
  var socket = io.connect('http://localhost:3000');
      jQuery(function($) {
                    //Internazionalization
                    $.i18n.load(i18n_dict);
                   
                 
                    var annotator = $('body').annotator().annotator().data('annotator');
                    annotator.addPlugin('Permissions', {
                        user: propietary,
                        permissions: {
                            'read': [propietary],
                            'update': [propietary],
                            'delete': [propietary],
                            'admin': [propietary]
                        },
                        showViewPermissionsCheckbox: true,
                        showEditPermissionsCheckbox: false
                    });
                    $('body').annotator().annotator('addPlugin', 'RichEditor');
                       $('body').annotator().annotator('addPlugin', 'Categories',{
                           errata:'annotator-hl-errata',
                           destacat:'annotator-hl-destacat',
                           subratllat:'annotator-hl-subratllat' }
                     );
                   $('body').annotator().annotator('addPlugin', 'Markdown');
                   $('body').annotator('addPlugin', 'Store', {
                        prefix: 'http://localhost:3000/annotation',
                        urls: {
                            // These are the default URLs.
                            create: '/new/'+propietary+'/'+code,
                            read: '/get/'+propietary+'/'+code,
                            update: '/update/'+propietary+'/'+code+'/:id',
                            destroy: '/destroy/'+propietary+'/'+code+'/:id'
                        }
                    });
                   $('body').annotator().annotator('addPlugin', 'visorAnotacions');

               jQuery("body").annotator().annotator('addPlugin', 'Touch', {
               force: location.search.indexOf('force') > -1,
               useHighlighter: location.search.indexOf('highlighter') > -1
               });
                   $('#anotacions-uoc-panel').slimscroll({height: '100%'});
                });

         socket.emit('login', { username: propietary });
         socket.emit('join',code);

         socket.on('notification', function (data) {
            var n = data.online;
             $('#count-anotations-alert').text(n);
           
      });