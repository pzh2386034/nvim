require('orgmode').setup({
  org_agenda_files = {'~wks/agenda/*'}, -- 议程文件路径
  org_default_notes_file = '~/wks/orgnotes/notes.org', -- 默认笔记文件
  org_todo_keywords = {'TODO', 'WAITING', '|', 'DONE'}, -- 自定义任务状态
  org_capture_templates = {
    T = { description = 'Task', template = '* TODO %?\n  SCHEDULED: %t' },
    t = 'TODO',
    s = {
      description = 'Study Tasks',
      template = '* TODO %?\n  SCHEDULED: %t',
      target = '~/wks/agegnda/study.org',
    },
    i = {
      description = 'Idea',
      template = '* WHAT %?\n  DATE: %t\n  Note:',
      target = '~/wks/agegnda/idea.org',
    },
    j = {
      description = 'Journal',
      template = '* %?\n  DATE: %t\n  Abstract:',
      target = '~/wks/agegnda/journal.org',
    },
  }
})

