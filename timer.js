function CountUp(initDate, id){
    this.beginDate = new Date(initDate);
    this.countainer = document.getElementById(id);
    this.numOfDays = [ 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 ];
    this.borrowed = 0, this.years = 0, this.months = 0, this.days = 0;
    this.hours = 0, this.minutes = 0, this.seconds = 0;
    this.updateNumOfDays();
    this.updateCounter();
}

CountUp.prototype.updateNumOfDays=function(){
    var dateNow = new Date();
    var currYear = dateNow.getFullYear();
    if ( (currYear % 4 == 0 && currYear % 100 != 0 ) || currYear % 400 == 0 ) {
        this.numOfDays[1] = 29;
    }
    var self = this;
    setTimeout(function(){self.updateNumOfDays();}, (new Date((currYear+1), 1, 2) - dateNow));
};

CountUp.prototype.datePartDiff=function(then, now, MAX){
    var diff = now - then - this.borrowed;
    this.borrowed = 0;
    if ( diff > -1 ) return diff;
    this.borrowed = 1;
    return (MAX + diff);
};

CountUp.prototype.calculate=function(){
    var currDate = new Date();
    var prevDate = this.beginDate;
    this.seconds = this.datePartDiff(prevDate.getSeconds(), currDate.getSeconds(), 60);
    this.minutes = this.datePartDiff(prevDate.getMinutes(), currDate.getMinutes(), 60);
    this.hours = this.datePartDiff(prevDate.getHours(), currDate.getHours(), 24);
    this.days = this.datePartDiff(prevDate.getDate(), currDate.getDate(), this.numOfDays[currDate.getMonth()]);
    this.months = this.datePartDiff(prevDate.getMonth(), currDate.getMonth(), 12);
    this.years = this.datePartDiff(prevDate.getFullYear(), currDate.getFullYear(),0);
};

CountUp.prototype.addLeadingZero=function(value){
    return value < 10 ? ("0" + value) : value;
};

CountUp.prototype.formatTime=function(){
    this.seconds = this.addLeadingZero(this.seconds);
    this.minutes = this.addLeadingZero(this.minutes);
    this.hours = this.addLeadingZero(this.hours);
};

CountUp.prototype.updateCounter=function(){
    this.calculate();
    this.formatTime();
    this.countainer.innerHTML = " <strong>" + this.seconds + "</strong> <small>" + (this.seconds == 1? "second" : "seconds") + "</small>" +
        "<br /trong>" + this.minutes + "</strong> <small>" + (this.minutes == 1? "minute" : "minutes") + "</small>" +
        "<br /trong>" + this.hours + "</strong> <small>" + (this.hours == 1? "hour" : "hours") + "</small>" +
        "<br /trong>" + this.days + "</strong> <small>" + (this.days == 1? "day" : "days") + "</small>" +
        "<br /trong>" + this.months + "</strong> <small>" + (this.months == 1? "month" : "months") + "</small>" +
        "<br /trong>" + this.years + "</strong> <small>" + (this.years == 1? "year" : "years") + "</small>";
    var self = this;
    timerID= setTimeout(function(){self.updateCounter();}, 1000);
};

var currentTime = new Date();
window.onload=function(){ new CountUp(currentTime, 'counter'); };
$(function() {
    $('#headline').click(function() {
        var new_headline = prompt("New Headline: ");
        if (new_headline) {
            $(this).html("<h2>" + new_headline + "</h2>");
        }
    });

    $('#restart').click(function() {
        clearTimeout(timerID);
        var currentTime = new Date();
        timerID = new CountUp(currentTime, 'counter');
    });
});
