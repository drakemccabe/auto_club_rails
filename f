
[1mFrom:[0m /home/nitrous/code/auto_club_rails/app/views/events/index.html.erb @ line 25 ActionView::CompiledTemplates#_app_views_events_index_html_erb___746519895723433109_33241740:

    [1;34m20[0m:                   
    [1;34m21[0m:                
    [1;34m22[0m:                     
    [1;34m23[0m:                     <ul class="calendar">
    [1;34m24[0m:                       <li><div class="calbox"><div class="top">APR</div><div class="bottom">
 => [1;34m25[0m:                         <% binding.pry %>
    [1;34m26[0m:                         <% @calendar["#{Date.today.year}-12-01"].each do |item| %>
    [1;34m27[0m:                               <a href="/<%= item.id %>">SAT 9</a>
    [1;34m28[0m:                         <% end %>
    [1;34m29[0m:                         
    [1;34m30[0m:                         </div></div></li>

