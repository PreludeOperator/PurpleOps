if ((Get-WindowsFeature AD-Domain-Services | select-object -ExpandProperty "InstallState") -ne "Installed"){
 Add-WindowsFeature AD-Domain-Services -IncludeManagementTools
}
if ((hostname) -ne "DC-1"){
 Rename-Computer -NewName "DC-1" -Restart
 net user Administrator Pa`$`$w0rd
 $PSDefaultParameterValues['Out-File:Encoding'] = 'utf8'
 echo "10.0.0.10.10 duckdns.com www.duckdns.com aep.duckdns.com" >> C:\Windows\System32\drivers\etc\hosts
}
try {
    if(!(Get-ADForest)){
		while(!(Get-ADForest)){
			$password = echo "Pa`$`$w0rd" | ConvertTo-SecureString -AsPlainText -Force
			Install-ADDSForest -CreateDnsDelegation:$false -DatabasePath "C:\\Windows\\NTDS" -DomainMode "7" -DomainName "blueops.com" -DomainNetbiosName "blueops" -ForestMode "7" -InstallDns:$true -LogPath "C:\\Windows\\NTDS" -NoRebootOnCompletion:$false -SysvolPath "C:\\Windows\\SYSVOL" -Force:$true -SafeModeAdministratorPassword $password
		}
	}
}
catch {
}
try {
	if((Get-AdUser -Filter *).Count -lt 50){
		while((Get-AdUser -Filter *).Count -lt 50){
$Global:HumansNames = @('Aaren', 'Aarika', 'Abagael', 'Abagail', 'Abbe', 'Abbey', 'Abbi', 'Abbie', 'Abby', 'Abbye', 'Abigael', 'Abigail', 'Abigale', 'Abra', 'Ada', 'Adah', 'Adaline', 'Adan', 'Adara', 'Adda', 'Addi', 'Addia', 'Addie', 'Addy', 'Adel', 'Adela', 'Adelaida', 'Adelaide', 'Adele', 'Adelheid', 'Adelice', 'Adelina', 'Adelind', 'Adeline', 'Adella', 'Adelle', 'Adena', 'Adey', 'Adi', 'Adiana', 'Adina', 'Adora', 'Adore', 'Adoree', 'Adorne', 'Adrea', 'Adria', 'Adriaens', 'Adrian', 'Adriana', 'Adriane', 'Adrianna', 'Adrianne', 'Adriena', 'Adrienne', 'Aeriel', 'Aeriela', 'Aeriell', 'Afton', 'Ag', 'Agace', 'Agata', 'Agatha', 'Agathe', 'Aggi', 'Aggie', 'Aggy', 'Agna', 'Agnella', 'Agnes', 'Agnese', 'Agnesse', 'Agneta', 'Agnola', 'Agretha', 'Aida', 'Aidan', 'Aigneis', 'Aila', 'Aile', 'Ailee', 'Aileen', 'Ailene', 'Ailey', 'Aili', 'Ailina', 'Ailis', 'Ailsun', 'Ailyn', 'Aime', 'Aimee', 'Aimil', 'Aindrea', 'Ainslee', 'Ainsley', 'Ainslie', 'Ajay', 'Alaine', 'Alameda', 'Alana', 'Alanah', 'Alane', 'Alanna', 'Alayne', 'Alberta', 'Albertina', 'Albertine', 'Albina', 'Alecia', 'Aleda', 'Aleece', 'Aleen', 'Alejandra', 'Alejandrina', 'Alena', 'Alene', 'Alessandra', 'Aleta', 'Alethea', 'Alex', 'Alexa', 'Alexandra', 'Alexandrina', 'Alexi', 'Alexia', 'Alexina', 'Alexine', 'Alexis', 'Alfi', 'Alfie', 'Alfreda', 'Alfy', 'Ali', 'Alia', 'Alica', 'Alice', 'Alicea', 'Alicia', 'Alida', 'Alidia', 'Alie', 'Alika', 'Alikee', 'Alina', 'Aline', 'Alis', 'Alisa', 'Alisha', 'Alison', 'Alissa', 'Alisun', 'Alix', 'Aliza', 'Alla', 'Alleen', 'Allegra', 'Allene', 'Alli', 'Allianora', 'Allie', 'Allina', 'Allis', 'Allison', 'Allissa', 'Allix', 'Allsun', 'Allx', 'Ally', 'Allyce', 'Allyn', 'Allys', 'Allyson', 'Alma', 'Almeda', 'Almeria', 'Almeta', 'Almira', 'Almire', 'Aloise', 'Aloisia', 'Aloysia', 'Alta', 'Althea', 'Alvera', 'Alverta', 'Alvina', 'Alvinia', 'Alvira', 'Alyce', 'Alyda', 'Alys', 'Alysa', 'Alyse', 'Alysia', 'Alyson', 'Alyss', 'Alyssa', 'Amabel', 'Amabelle', 'Amalea', 'Amalee', 'Amaleta', 'Amalia', 'Amalie', 'Amalita', 'Amalle', 'Amanda', 'Amandi', 'Amandie', 'Amandy', 'Amara', 'Amargo', 'Amata', 'Amber', 'Amberly', 'Ambur', 'Ame', 'Amelia', 'Amelie', 'Amelina', 'Ameline', 'Amelita', 'Ami', 'Amie', 'Amii', 'Amil', 'Amitie', 'Amity', 'Ammamaria', 'Amy', 'Amye', 'Ana', 'Anabal', 'Anabel', 'Anabella', 'Anabelle', 'Analiese', 'Analise', 'Anallese', 'Anallise', 'Anastasia', 'Anastasie', 'Anastassia', 'Anatola', 'Andee', 'Andeee', 'Anderea', 'Andi', 'Andie', 'Andra', 'Andrea', 'Andreana', 'Andree', 'Andrei', 'Andria', 'Andriana', 'Andriette', 'Andromache', 'Andy', 'Anestassia', 'Anet', 'Anett', 'Anetta', 'Anette', 'Ange', 'Angel', 'Angela', 'Angele', 'Angelia', 'Angelica', 'Angelika', 'Angelina', 'Angeline', 'Angelique', 'Angelita', 'Angelle', 'Angie', 'Angil', 'Angy', 'Ania', 'Anica', 'Anissa', 'Anita', 'Anitra', 'Anjanette', 'Anjela', 'Ann', 'Anna', 'Annabal', 'Annabel', 'Annabela', 'Annabell', 'Annabella', 'Annabelle', 'Annadiana', 'Annadiane', 'Annalee', 'Annaliese', 'Annalise', 'Annamaria', 'Annamarie', 'Anne', 'Annecorinne', 'Anneliese', 'Annelise', 'Annemarie', 'Annetta', 'Annette', 'Anni', 'Annice', 'Annie', 'Annis', 'Annissa', 'Annmaria', 'Annmarie', 'Annnora', 'Annora', 'Anny', 'Anselma', 'Ansley', 'Anstice', 'Anthe', 'Anthea', 'Anthia', 'Anthiathia', 'Antoinette', 'Antonella', 'Antonetta', 'Antonia', 'Antonie', 'Antonietta', 'Antonina', 'Anya', 'Appolonia', 'April', 'Aprilette', 'Ara', 'Arabel', 'Arabela', 'Arabele', 'Arabella', 'Arabelle', 'Arda', 'Ardath', 'Ardeen', 'Ardelia', 'Ardelis', 'Ardella', 'Ardelle', 'Arden', 'Ardene', 'Ardenia', 'Ardine', 'Ardis', 'Ardisj', 'Ardith', 'Ardra', 'Ardyce', 'Ardys', 'Ardyth', 'Aretha', 'Ariadne', 'Ariana', 'Aridatha', 'Ariel', 'Ariela', 'Ariella', 'Arielle', 'Arlana', 'Arlee', 'Arleen', 'Arlen', 'Arlena', 'Arlene', 'Arleta', 'Arlette', 'Arleyne', 'Arlie', 'Arliene', 'Arlina', 'Arlinda', 'Arline', 'Arluene', 'Arly', 'Arlyn', 'Arlyne', 'Aryn', 'Ashely', 'Ashia', 'Ashien', 'Ashil', 'Ashla', 'Ashlan', 'Ashlee', 'Ashleigh', 'Ashlen', 'Ashley', 'Ashli', 'Ashlie', 'Ashly', 'Asia', 'Astra', 'Astrid', 'Astrix', 'Atalanta', 'Athena', 'Athene', 'Atlanta', 'Atlante', 'Auberta', 'Aubine', 'Aubree', 'Aubrette', 'Aubrey', 'Aubrie', 'Aubry', 'Audi', 'Audie', 'Audra', 'Audre', 'Audrey', 'Audrie', 'Audry', 'Audrye', 'Audy', 'Augusta', 'Auguste', 'Augustina', 'Augustine', 'Aundrea', 'Aura', 'Aurea', 'Aurel', 'Aurelea', 'Aurelia', 'Aurelie', 'Auria', 'Aurie', 'Aurilia', 'Aurlie', 'Auroora', 'Aurora', 'Aurore', 'Austin', 'Austina', 'Austine', 'Ava', 'Aveline', 'Averil', 'Averyl', 'Avie', 'Avis', 'Aviva', 'Avivah', 'Avril', 'Avrit', 'Ayn', 'Bab', 'Babara', 'Babb', 'Babbette', 'Babbie', 'Babette', 'Babita', 'Babs', 'Bambi', 'Bambie', 'Bamby', 'Barb', 'Barbabra', 'Barbara', 'Barbaraanne', 'Barbe', 'Barbee', 'Barbette', 'Barbey', 'Barbi', 'Barbie', 'Barbra', 'Barby', 'Bari', 'Barrie', 'Barry', 'Basia', 'Bathsheba', 'Batsheva', 'Bea', 'Beatrice', 'Beatrisa', 'Beatrix', 'Beatriz', 'Bebe', 'Becca', 'Becka', 'Becki', 'Beckie', 'Becky', 'Bee', 'Beilul', 'Beitris', 'Bekki', 'Bel', 'Belia', 'Belicia', 'Belinda', 'Belita', 'Bell', 'Bella', 'Bellanca', 'Belle', 'Bellina', 'Belva', 'Belvia', 'Bendite', 'Benedetta', 'Benedicta', 'Benedikta', 'Benetta', 'Benita', 'Benni', 'Bennie', 'Benny', 'Benoite', 'Berenice', 'Beret', 'Berget', 'Berna', 'Bernadene', 'Bernadette', 'Bernadina', 'Bernadine', 'Bernardina', 'Bernardine', 'Bernelle', 'Bernete', 'Bernetta', 'Bernette', 'Berni', 'Bernice', 'Bernie', 'Bernita', 'Berny', 'Berri', 'Berrie', 'Berry', 'Bert', 'Berta', 'Berte', 'Bertha', 'Berthe', 'Berti', 'Bertie', 'Bertina', 'Bertine', 'Berty', 'Beryl', 'Beryle', 'Bess', 'Bessie', 'Bessy', 'Beth', 'Bethanne', 'Bethany', 'Bethena', 'Bethina', 'Betsey', 'Betsy', 'Betta', 'Bette', 'Betteann', 'Betteanne', 'Betti', 'Bettina', 'Bettine', 'Betty', 'Bettye', 'Beulah', 'Bev', 'Beverie', 'Beverlee', 'Beverley', 'Beverlie', 'Beverly', 'Bevvy', 'Bianca', 'Bianka', 'Bibbie', 'Bibby', 'Bibbye', 'Bibi', 'Biddie', 'Biddy', 'Bidget', 'Bili', 'Bill', 'Billi', 'Billie', 'Billy', 'Billye', 'Binni', 'Binnie', 'Binny', 'Bird', 'Birdie', 'Birgit', 'Birgitta', 'Blair', 'Blaire', 'Blake', 'Blakelee', 'Blakeley', 'Blanca', 'Blanch', 'Blancha', 'Blanche', 'Blinni', 'Blinnie', 'Blinny', 'Bliss', 'Blisse', 'Blithe', 'Blondell', 'Blondelle', 'Blondie', 'Blondy', 'Blythe', 'Bobbe', 'Bobbee', 'Bobbette', 'Bobbi', 'Bobbie', 'Bobby', 'Bobbye', 'Bobette', 'Bobina', 'Bobine', 'Bobinette', 'Bonita', 'Bonnee', 'Bonni', 'Bonnibelle', 'Bonnie', 'Bonny', 'Brana', 'Brandais', 'Brande', 'Brandea', 'Brandi', 'Brandice', 'Brandie', 'Brandise', 'Brandy', 'Breanne', 'Brear', 'Bree', 'Breena', 'Bren', 'Brena', 'Brenda', 'Brenn', 'Brenna', 'Brett', 'Bria', 'Briana', 'Brianna', 'Brianne', 'Bride', 'Bridget', 'Bridgette', 'Bridie', 'Brier', 'Brietta', 'Brigid', 'Brigida', 'Brigit', 'Brigitta', 'Brigitte', 'Brina', 'Briney', 'Brinn', 'Brinna', 'Briny', 'Brit', 'Brita', 'Britney', 'Britni', 'Britt', 'Britta', 'Brittan', 'Brittaney', 'Brittani', 'Brittany', 'Britte', 'Britteny', 'Brittne', 'Brittney', 'Brittni', 'Brook', 'Brooke', 'Brooks', 'Brunhilda', 'Brunhilde', 'Bryana', 'Bryn', 'Bryna', 'Brynn', 'Brynna', 'Brynne', 'Buffy', 'Bunni', 'Bunnie', 'Bunny', 'Cacilia', 'Cacilie', 'Cahra', 'Cairistiona', 'Caitlin', 'Caitrin', 'Cal', 'Calida', 'Calla', 'Calley', 'Calli', 'Callida', 'Callie', 'Cally', 'Calypso', 'Cam', 'Camala', 'Camel', 'Camella', 'Camellia', 'Cami', 'Camila', 'Camile', 'Camilla', 'Camille', 'Cammi', 'Cammie', 'Cammy', 'Candace', 'Candi', 'Candice', 'Candida', 'Candide', 'Candie', 'Candis', 'Candra', 'Candy', 'Caprice', 'Cara', 'Caralie', 'Caren', 'Carena', 'Caresa', 'Caressa', 'Caresse', 'Carey', 'Cari', 'Caria', 'Carie', 'Caril', 'Carilyn', 'Carin', 'Carina', 'Carine', 'Cariotta', 'Carissa', 'Carita', 'Caritta', 'Carla', 'Carlee', 'Carleen', 'Carlen', 'Carlene', 'Carley', 'Carlie', 'Carlin', 'Carlina', 'Carline', 'Carlita', 'Carlota', 'Carlotta', 'Carly', 'Carlye', 'Carlyn', 'Carlynn', 'Carlynne', 'Carma', 'Carmel', 'Carmela', 'Carmelia', 'Carmelina', 'Carmelita', 'Carmella', 'Carmelle', 'Carmen', 'Carmencita', 'Carmina', 'Carmine', 'Carmita', 'Carmon', 'Caro', 'Carol', 'Carola', 'Carolan', 'Carolann', 'Carole', 'Carolee', 'Carolin', 'Carolina', 'Caroline', 'Caroljean', 'Carolyn', 'Carolyne', 'Carolynn', 'Caron', 'Carree', 'Carri', 'Carrie', 'Carrissa', 'Carroll', 'Carry', 'Cary', 'Caryl', 'Caryn', 'Casandra', 'Casey', 'Casi', 'Casie', 'Cass', 'Cassandra', 'Cassandre', 'Cassandry', 'Cassaundra', 'Cassey', 'Cassi', 'Cassie', 'Cassondra', 'Cassy', 'Catarina', 'Cate', 'Caterina', 'Catha', 'Catharina', 'Catharine', 'Cathe', 'Cathee', 'Catherin', 'Catherina', 'Catherine', 'Cathi', 'Cathie', 'Cathleen', 'Cathlene', 'Cathrin', 'Cathrine', 'Cathryn', 'Cathy', 'Cathyleen', 'Cati', 'Catie', 'Catina', 'Catlaina', 'Catlee', 'Catlin', 'Catrina', 'Catriona', 'Caty', 'Caye', 'Cayla', 'Cecelia', 'Cecil', 'Cecile', 'Ceciley', 'Cecilia', 'Cecilla', 'Cecily', 'Ceil', 'Cele', 'Celene', 'Celesta', 'Celeste', 'Celestia', 'Celestina', 'Celestine', 'Celestyn', 'Celestyna', 'Celia', 'Celie', 'Celina', 'Celinda', 'Celine', 'Celinka', 'Celisse', 'Celka', 'Celle', 'Cesya', 'Chad', 'Chanda', 'Chandal', 'Chandra', 'Channa', 'Chantal', 'Chantalle', 'Charil', 'Charin', 'Charis', 'Charissa', 'Charisse', 'Charita', 'Charity', 'Charla', 'Charlean', 'Charleen', 'Charlena', 'Charlene', 'Charline', 'Charlot', 'Charlotta', 'Charlotte', 'Charmain', 'Charmaine', 'Charmane', 'Charmian', 'Charmine', 'Charmion', 'Charo', 'Charyl', 'Chastity', 'Chelsae', 'Chelsea', 'Chelsey', 'Chelsie', 'Chelsy', 'Cher', 'Chere', 'Cherey', 'Cheri', 'Cherianne', 'Cherice', 'Cherida', 'Cherie', 'Cherilyn', 'Cherilynn', 'Cherin', 'Cherise', 'Cherish', 'Cherlyn', 'Cherri', 'Cherrita', 'Cherry', 'Chery', 'Cherye', 'Cheryl', 'Cheslie', 'Chiarra', 'Chickie', 'Chicky', 'Chiquia', 'Chiquita', 'Chlo', 'Chloe', 'Chloette', 'Chloris', 'Chris', 'Chrissie', 'Chrissy', 'Christa', 'Christabel', 'Christabella', 'Christal', 'Christalle', 'Christan', 'Christean', 'Christel', 'Christen', 'Christi', 'Christian', 'Christiana', 'Christiane', 'Christie', 'Christin', 'Christina', 'Christine', 'Christy', 'Christye', 'Christyna', 'Chrysa', 'Chrysler', 'Chrystal', 'Chryste', 'Chrystel', 'Cicely', 'Cicily', 'Ciel', 'Cilka', 'Cinda', 'Cindee', 'Cindelyn', 'Cinderella', 'Cindi', 'Cindie', 'Cindra', 'Cindy', 'Cinnamon', 'Cissiee', 'Cissy', 'Clair', 'Claire', 'Clara', 'Clarabelle', 'Clare', 'Claresta', 'Clareta', 'Claretta', 'Clarette', 'Clarey', 'Clari', 'Claribel', 'Clarice', 'Clarie', 'Clarinda', 'Clarine', 'Clarissa', 'Clarisse', 'Clarita', 'Clary', 'Claude', 'Claudelle', 'Claudetta', 'Claudette', 'Claudia', 'Claudie', 'Claudina', 'Claudine', 'Clea', 'Clem', 'Clemence', 'Clementia', 'Clementina', 'Clementine', 'Clemmie', 'Clemmy', 'Cleo', 'Cleopatra', 'Clerissa', 'Clio', 'Clo', 'Cloe', 'Cloris', 'Clotilda', 'Clovis', 'Codee', 'Codi', 'Codie', 'Cody', 'Coleen', 'Colene', 'Coletta', 'Colette', 'Colleen', 'Collen', 'Collete', 'Collette', 'Collie', 'Colline', 'Colly', 'Con', 'Concettina', 'Conchita', 'Concordia', 'Conni', 'Connie', 'Conny', 'Consolata', 'Constance', 'Constancia', 'Constancy', 'Constanta', 'Constantia', 'Constantina', 'Constantine', 'Consuela', 'Consuelo', 'Cookie', 'Cora', 'Corabel', 'Corabella', 'Corabelle', 'Coral', 'Coralie', 'Coraline', 'Coralyn', 'Cordelia', 'Cordelie', 'Cordey', 'Cordi', 'Cordie', 'Cordula', 'Cordy', 'Coreen', 'Corella', 'Corenda', 'Corene', 'Coretta', 'Corette', 'Corey', 'Cori', 'Corie', 'Corilla', 'Corina', 'Corine', 'Corinna', 'Corinne', 'Coriss', 'Corissa', 'Corliss', 'Corly', 'Cornela', 'Cornelia', 'Cornelle', 'Cornie', 'Corny', 'Correna', 'Correy', 'Corri', 'Corrianne', 'Corrie', 'Corrina', 'Corrine', 'Corrinne', 'Corry', 'Cortney', 'Cory', 'Cosetta', 'Cosette', 'Costanza', 'Courtenay', 'Courtnay', 'Courtney', 'Crin', 'Cris', 'Crissie', 'Crissy', 'Crista', 'Cristabel', 'Cristal', 'Cristen', 'Cristi', 'Cristie', 'Cristin', 'Cristina', 'Cristine', 'Cristionna', 'Cristy', 'Crysta', 'Crystal', 'Crystie', 'Cthrine', 'Cyb', 'Cybil', 'Cybill', 'Cymbre', 'Cynde', 'Cyndi', 'Cyndia', 'Cyndie', 'Cyndy', 'Cynthea', 'Cynthia', 'Cynthie', 'Cynthy', 'Dacey', 'Dacia', 'Dacie', 'Dacy', 'Dael', 'Daffi', 'Daffie', 'Daffy', 'Dagmar', 'Dahlia', 'Daile', 'Daisey', 'Daisi', 'Daisie', 'Daisy', 'Dale', 'Dalenna', 'Dalia', 'Dalila', 'Dallas', 'Daloris', 'Damara', 'Damaris', 'Damita', 'Dana', 'Danell', 'Danella', 'Danette', 'Dani', 'Dania', 'Danica', 'Danice', 'Daniela', 'Daniele', 'Daniella', 'Danielle', 'Danika', 'Danila', 'Danit', 'Danita', 'Danna', 'Danni', 'Dannie', 'Danny', 'Dannye', 'Danya', 'Danyelle', 'Danyette', 'Daphene', 'Daphna', 'Daphne', 'Dara', 'Darb', 'Darbie', 'Darby', 'Darcee', 'Darcey', 'Darci', 'Darcie', 'Darcy', 'Darda', 'Dareen', 'Darell', 'Darelle', 'Dari', 'Daria', 'Darice', 'Darla', 'Darleen', 'Darlene', 'Darline', 'Darlleen', 'Daron', 'Darrelle', 'Darryl', 'Darsey', 'Darsie', 'Darya', 'Daryl', 'Daryn', 'Dasha', 'Dasi', 'Dasie', 'Dasya', 'Datha', 'Daune', 'Daveen', 'Daveta', 'Davida', 'Davina', 'Davine', 'Davita', 'Dawn', 'Dawna', 'Dayle', 'Dayna', 'Ddene', 'De', 'Deana', 'Deane', 'Deanna', 'Deanne', 'Deb', 'Debbi', 'Debbie', 'Debby', 'Debee', 'Debera', 'Debi', 'Debor', 'Debora', 'Deborah', 'Debra', 'Dede', 'Dedie', 'Dedra', 'Dee', 'Dee Dee', 'Deeann', 'Deeanne', 'Deedee', 'Deena', 'Deerdre', 'Deeyn', 'Dehlia', 'Deidre', 'Deina', 'Deirdre', 'Del', 'Dela', 'Delcina', 'Delcine', 'Delia', 'Delila', 'Delilah', 'Delinda', 'Dell', 'Della', 'Delly', 'Delora', 'Delores', 'Deloria', 'Deloris', 'Delphine', 'Delphinia', 'Demeter', 'Demetra', 'Demetria', 'Demetris', 'Dena', 'Deni', 'Denice', 'Denise', 'Denna', 'Denni', 'Dennie', 'Denny', 'Deny', 'Denys', 'Denyse', 'Deonne', 'Desdemona', 'Desirae', 'Desiree', 'Desiri', 'Deva', 'Devan', 'Devi', 'Devin', 'Devina', 'Devinne', 'Devon', 'Devondra', 'Devonna', 'Devonne', 'Devora', 'Di', 'Diahann', 'Dian', 'Diana', 'Diandra', 'Diane', 'Diane-Marie', 'Dianemarie', 'Diann', 'Dianna', 'Dianne', 'Diannne', 'Didi', 'Dido', 'Diena', 'Dierdre', 'Dina', 'Dinah', 'Dinnie', 'Dinny', 'Dion', 'Dione', 'Dionis', 'Dionne', 'Dita', 'Dix', 'Dixie', 'Dniren', 'Dode', 'Dodi', 'Dodie', 'Dody', 'Doe', 'Doll', 'Dolley', 'Dolli', 'Dollie', 'Dolly', 'Dolores', 'Dolorita', 'Doloritas', 'Domeniga', 'Dominga', 'Domini', 'Dominica', 'Dominique', 'Dona', 'Donella', 'Donelle', 'Donetta', 'Donia', 'Donica', 'Donielle', 'Donna', 'Donnamarie', 'Donni', 'Donnie', 'Donny', 'Dora', 'Doralia', 'Doralin', 'Doralyn', 'Doralynn', 'Doralynne', 'Dore', 'Doreen', 'Dorelia', 'Dorella', 'Dorelle', 'Dorena', 'Dorene', 'Doretta', 'Dorette', 'Dorey', 'Dori', 'Doria', 'Dorian', 'Dorice', 'Dorie', 'Dorine', 'Doris', 'Dorisa', 'Dorise', 'Dorita', 'Doro', 'Dorolice', 'Dorolisa', 'Dorotea', 'Doroteya', 'Dorothea', 'Dorothee', 'Dorothy', 'Dorree', 'Dorri', 'Dorrie', 'Dorris', 'Dorry', 'Dorthea', 'Dorthy', 'Dory', 'Dosi', 'Dot', 'Doti', 'Dotti', 'Dottie', 'Dotty', 'Dre', 'Dreddy', 'Dredi', 'Drona', 'Dru', 'Druci', 'Drucie', 'Drucill', 'Drucy', 'Drusi', 'Drusie', 'Drusilla', 'Drusy', 'Dulce', 'Dulcea', 'Dulci', 'Dulcia', 'Dulciana', 'Dulcie', 'Dulcine', 'Dulcinea', 'Dulcy', 'Dulsea', 'Dusty', 'Dyan', 'Dyana', 'Dyane', 'Dyann', 'Dyanna', 'Dyanne', 'Dyna', 'Dynah');
$Global:BadPasswords = @('123123', 'baseball', 'abc123', 'football', 'monkey', 'letmein', '696969', 'shadow', 'master', '666666', 'qwertyuiop', '123321', 'mustang', '1234567890', 'michael', '654321', 'pussy', 'superman', '1qaz2wsx', '7777777', 'fuckyou', '121212', '000000', 'qazwsx', '123qwe', 'killer', 'trustno1', 'jordan', 'jennifer', 'zxcvbnm', 'asdfgh', 'hunter', 'buster', 'soccer', 'harley', 'batman', 'andrew', 'tigger', 'sunshine', 'iloveyou', 'fuckme', '2000', 'charlie', 'robert', 'thomas', 'hockey', 'ranger', 'daniel', 'starwars', 'klaster', '112233', 'george', 'asshole', 'computer', 'michelle', 'jessica', 'pepper', '1111', 'zxcvbn', '555555', '11111111', '131313', 'freedom', '777777', 'pass', 'fuck', 'maggie', '159753', 'aaaaaa', 'ginger', 'princess', 'joshua', 'cheese', 'amanda', 'summer', 'love', 'ashley', '6969', 'nicole', 'chelsea', 'biteme', 'matthew', 'access', 'yankees', '987654321', 'dallas', 'austin', 'thunder', 'taylor', 'matrix', 'william', 'corvette', 'hello', 'martin', 'heather', 'secret', 'fucker', 'merlin', 'diamond', '1234qwer', 'gfhjkm', 'hammer', 'silver', '222222', '88888888', 'anthony', 'justin', 'test', 'bailey', 'q1w2e3r4t5', 'patrick', 'internet', 'scooter', 'orange', '11111', 'golfer', 'cookie', 'richard', 'samantha', 'bigdog', 'guitar', 'jackson', 'whatever', 'mickey', 'chicken', 'sparky', 'snoopy', 'maverick', 'phoenix', 'camaro', 'sexy', 'peanut', 'morgan', 'welcome', 'falcon', 'cowboy', 'ferrari', 'samsung', 'andrea', 'smokey', 'steelers', 'joseph', 'mercedes', 'dakota', 'arsenal', 'eagles', 'melissa', 'boomer', 'booboo', 'spider', 'nascar', 'monster', 'tigers', 'yellow', 'xxxxxx', '123123123', 'gateway', 'marina', 'diablo', 'bulldog', 'qwer1234', 'compaq', 'purple', 'hardcore', 'banana', 'junior', 'hannah', '123654', 'porsche', 'lakers', 'iceman', 'money', 'cowboys', '987654', 'london', 'tennis', '999999', 'ncc1701', 'coffee', 'scooby', '0000', 'miller', 'boston', 'q1w2e3r4', 'fuckoff', 'brandon', 'yamaha', 'chester', 'mother', 'forever', 'johnny', 'edward', '333333', 'oliver', 'redsox', 'player', 'nikita', 'knight', 'fender', 'barney', 'midnight', 'please', 'brandy', 'chicago', 'badboy', 'iwantu', 'slayer', 'rangers', 'charles', 'angel', 'flower', 'bigdaddy', 'rabbit', 'wizard', 'bigdick', 'jasper', 'enter', 'rachel', 'chris', 'steven', 'winner', 'adidas', 'victoria', 'natasha', '1q2w3e4r', 'jasmine', 'winter', 'prince', 'panties', 'marine', 'ghbdtn', 'fishing', 'cocacola', 'casper', 'james', '232323', 'raiders', '888888', 'marlboro', 'gandalf', 'asdfasdf', 'crystal', '87654321', '12344321', 'sexsex', 'golden', 'blowme', 'bigtits', '8675309', 'panther', 'lauren', 'angela', 'bitch', 'spanky', 'thx1138', 'angels', 'madison', 'winston', 'shannon', 'mike', 'toyota', 'blowjob', 'jordan23', 'canada', 'sophie', 'Password', 'apples', 'dick', 'tiger', 'razz', '123abc', 'pokemon', 'qazxsw', '55555', 'qwaszx', 'muffin', 'johnson', 'murphy', 'cooper', 'jonathan', 'liverpoo', 'david', 'danielle', '159357', 'jackie', '1990', '123456a', '789456', 'turtle', 'horny', 'abcd1234', 'scorpion', 'qazwsxedc', '101010', 'butter', 'carlos', 'password1', 'dennis', 'slipknot', 'qwerty123', 'booger', 'asdf', '1991', 'black', 'startrek', '12341234', 'cameron', 'newyork', 'rainbow', 'nathan', 'john', '1992', 'rocket', 'viking', 'redskins', 'butthead', 'asdfghjkl', '1212', 'sierra', 'peaches', 'gemini', 'doctor', 'wilson', 'sandra', 'helpme', 'qwertyui', 'victor', 'florida', 'dolphin', 'pookie', 'captain', 'tucker', 'blue', 'liverpool', 'theman', 'bandit', 'dolphins', 'maddog', 'packers', 'jaguar', 'lovers', 'nicholas', 'united', 'tiffany', 'maxwell', 'zzzzzz', 'nirvana', 'jeremy', 'suckit', 'stupid', 'porn', 'monica', 'elephant', 'giants', 'jackass', 'hotdog', 'rosebud', 'success', 'debbie', 'mountain', '444444', 'xxxxxxxx', 'warrior', '1q2w3e4r5t', 'q1w2e3', '123456q', 'albert', 'metallic', 'lucky', 'azerty', '7777', 'shithead', 'alex', 'bond007', 'alexis', '1111111', 'samson', '5150', 'willie', 'scorpio', 'bonnie', 'gators', 'benjamin', 'voodoo', 'driver', 'dexter', '2112', 'jason', 'calvin', 'freddy', '212121', 'creative', '12345a', 'sydney', 'rush2112', '1989', 'asdfghjk', 'red123', 'bubba', '4815162342', 'passw0rd', 'trouble', 'gunner', 'happy', 'fucking', 'gordon', 'legend', 'jessie', 'stella', 'qwert', 'eminem', 'arthur', 'apple', 'nissan', 'bullshit', 'bear', 'america', '1qazxsw2', 'nothing', 'parker', '4444', 'rebecca', 'qweqwe', 'garfield', '01012011', 'beavis', '69696969', 'jack', 'asdasd', 'december', '2222', '102030', '252525', '11223344', 'magic', 'apollo', 'skippy', '315475', 'girls', 'kitten', 'golf', 'copper', 'braves', 'shelby', 'godzilla', 'beaver', 'fred', 'tomcat', 'august', 'buddy', 'airborne', '1993', '1988', 'lifehack', 'qqqqqq', 'brooklyn', 'animal', 'platinum', 'phantom', 'online', 'xavier', 'darkness', 'blink182', 'power', 'fish', 'green', '789456123', 'voyager', 'police', 'travis', '12qwaszx', 'heaven', 'snowball', 'lover', 'abcdef', '00000', 'pakistan', '007007', 'walter', 'playboy', 'blazer', 'cricket', 'sniper', 'hooters', 'donkey', 'willow', 'loveme', 'saturn', 'therock', 'redwings');
$Global:Groups = @('Office Admin','IT Admins','Executives','Senior management','Project management','IT Helpdesk','Marketing','Sales','Accounting');
$Global:HighGroups = @('Office Admin','IT Admins','Executives');
$Global:MidGroups = @('Senior management','Project management','IT Helpdesk');
$Global:NormalGroups = @('Marketing','Sales','Accounting');
$Global:OfficeAdmin = @();
$Global:ITAdmins = @();
$Global:Executives = @();
$Global:Seniormanagement = @();
$Global:Projectmanagement = @();
$Global:ITHelpdesk = @();
$Global:Marketing = @();
$Global:Sales = @();
$Global:Accounting = @();
$Global:ACLperm = @('GenericAll','GenericWrite','WriteOwner','WriteDACL','Self');
$Global:ServicesAccountsAndSPNs = @('mssql_svc,mssqlserver','http_svc,httpserver','exchange_svc,exserver');
$Global:InitialAccessUsers = @();
$Global:CreatedUsers = @();
$Global:RemainingUsers = @();
$Global:ACLUser = "";
$Global:AllObjects = @();
$Global:Domain = "";
#Strings 
$Global:Spacing = "`t"
$Global:PlusLine = "`t[+]"
$Global:ErrorLine = "`t[-]"
$Global:InfoLine = "`t[*]"
function Write-Good { param( $String ) Write-Host $Global:PlusLine  $String -ForegroundColor 'Green'}
function Write-Bad  { param( $String ) Write-Host $Global:ErrorLine $String -ForegroundColor 'red'  }
function Write-Info { param( $String ) Write-Host $Global:InfoLine $String -ForegroundColor 'gray'; echo $String >> generate.log }
function VulnAD-GetRandom {
   Param(
     [array]$InputList
   )
   return Get-Random -InputObject $InputList
}
function VulnAD-AddADUser {
    Param(
        [int]$limit = 1
    )
    Add-Type -AssemblyName System.Web
    for ($i=1; $i -le $limit; $i=$i+1 ) {
        $firstname = (VulnAD-GetRandom -InputList $Global:HumansNames);
        $lastname = (VulnAD-GetRandom -InputList $Global:HumansNames);
        $fullname = "{0} {1}" -f ($firstname , $lastname);
        $SamAccountName = ("{0}.{1}" -f ($firstname, $lastname)).ToLower();
        $principalname = "{0}.{1}" -f ($firstname, $lastname);
        $generated_password = ([System.Web.Security.Membership]::GeneratePassword(7,2))
        Write-Info "Creating $SamAccountName User"
        Try { New-ADUser -Name "$firstname $lastname" -GivenName $firstname -Surname $lastname -SamAccountName $SamAccountName -UserPrincipalName $principalname@$Global:Domain -AccountPassword (ConvertTo-SecureString $generated_password -AsPlainText -Force) -PassThru | Enable-ADAccount } Catch {}
        $Global:CreatedUsers += $SamAccountName;
        $Global:RemainingUsers += $SamAccountName;
    }
}
function VulnAD-AddADGroup {
    Param(
        [array]$GroupList
    )
    $noOfGroup = [Math]::Floor($Global:CreatedUsers.length/30)
    $Users = $Global:CreatedUsers.length - 30*$noOfGroup
    foreach ($group in $GroupList) {
        Write-Info "Creating $group Group"
        Try { New-ADGroup -name $group -GroupScope Global } Catch {}
        if (@(Compare-Object $GroupList $Global:HighGroups -SyncWindow 0).Length -eq 0){
            $noOfUsers = $noOfGroup*2
        }
        elseif (@(Compare-Object $GroupList $Global:MidGroups -SyncWindow 0).Length -eq 0){
            if ($Users -ge 15){
                $noOfUsers = [Math]::Floor(($Global:CreatedUsers.length-(($noOfGroup+1)*15)-($noOfGroup*6))/3)
            }
            else {
                $noOfUsers = $noOfGroup*3
            }
        }
        elseif (@(Compare-Object $GroupList $Global:NormalGroups -SyncWindow 0).Length -eq 0){
            if ($Users -lt 30 -and $Users -gt 15){
                $noOfUsers = [Math]::Floor(($noOfGroup+1)*15/3)
            }
            elseif ($Users -le 15 -and $Users -ne 0){
                $noOfUsers = [Math]::Floor(($noOfGroup*15+$Users)/3)
            }
            else {
                $noOfUsers = $noOfGroup*5
            }
        }
        for ($i=1; $i -le $noOfUsers; $i=$i+1 ) {
            $randomuser = (VulnAD-GetRandom -InputList $Global:RemainingUsers)
            Write-Info "Adding $randomuser to $group"

            Try { Add-ADGroupMember -Identity $group -Members $randomuser } Catch {}
            if ($group -eq "Office Admin"){ $Global:OfficeAdmin += $randomuser}
            elseif ($group -eq "IT Admins"){ $Global:ITAdmins += $randomuser}
            elseif ($group -eq "Executives"){ $Global:Executives += $randomuser}
            elseif ($group -eq "Senior management"){ $Global:Seniormanagement += $randomuser}
            elseif ($group -eq "Project management"){ $Global:Projectmanagement += $randomuser}
            elseif ($group -eq "IT Helpdesk"){ $Global:ITHelpdesk += $randomuser}
            elseif ($group -eq "Marketing"){ $Global:Marketing += $randomuser}
            elseif ($group -eq "Sales"){ $Global:Sales += $randomuser}
            elseif ($group -eq "Accounting"){ $Global:Accounting += $randomuser}
            $Global:RemainingUsers = $Global:RemainingUsers -ne $randomuser
        }
        $Global:AllObjects += $group;
    }
    Try {Add-ADGroupMember -Identity "Domain Admins" -Members "IT Admins"} Catch{}
}
function VulnAD-Kerberoasting {
    foreach ($sv in $Global:ServicesAccountsAndSPNs) {
        if ($selected_service -ne $sv) {
            $svc = $sv.split(',')[0];
            $spn = $sv.split(',')[1];
            if ((Get-Random -Maximum 2)){
				$password = VulnAD-GetRandom -InputList $Global:BadPasswords;
            }else{
				$password = ([System.Web.Security.Membership]::GeneratePassword(7,2))
            }
            Try { New-ADUser -Name $svc -SamAccountName $svc -ServicePrincipalNames "$svc/$spn.$Global:Domain" -AccountPassword (ConvertTo-SecureString $password -AsPlainText -Force) -PassThru | Enable-ADAccount } Catch {}
			$randomgroup = (VulnAD-GetRandom -InputList $Global:MidGroups)
			Add-ADGroupMember -Identity $randomgroup -Members $svc
			Write-Info "Creating $svc services account"
			Write-Info "$svc in $randomgroup"
        }
    }
}
function VulnAD-ASREPRoasting {
    for ($i=1; $i -le (Get-Random -Minimum 1 -Maximum 6); $i=$i+1 ) {
        $randomuser = (VulnAD-GetRandom -InputList (Get-Random -InputObject @($Global:Marketing, $Global:Sales, $Global:Accounting)))
        $password = VulnAD-GetRandom -InputList $Global:BadPasswords;
        Set-AdAccountPassword -Identity $randomuser -Reset -NewPassword (ConvertTo-SecureString $password -AsPlainText -Force)
        Set-ADAccountControl -Identity $randomuser -DoesNotRequirePreAuth 1
        Write-Info "AS-REPRoasting $randomuser"
        $Global:InitialAccessUsers += $randomuser;
    }
}
function VulnAD-DisableSMBSigning {
        Set-SmbClientConfiguration -RequireSecuritySignature 0 -EnableSecuritySignature 0 -Confirm -Force
}

function VulnAD-EnableWinRM {
	Enable-PSRemoting -Force
	Set-Item wsman:\localhost\client\trustedhosts * -Force
	#(Get-PSSessionConfiguration -Name "Microsoft.PowerShell").SecurityDescriptorSDDL
	Set-PSSessionConfiguration -Name "Microsoft.PowerShell" -SecurityDescriptorSddl "O:NSG:BAD:P(A;;GA;;;BA)(A;;GA;;;WD)(A;;GA;;;IU)S:P(AU;FA;GA;;;WD)(AU;SA;GXGW;;;WD)"
}

function VulnAD-AnonymousLDAP {
	$Dcname = Get-ADDomain | Select-Object -ExpandProperty DistinguishedName
	$Adsi = 'LDAP://CN=Directory Service,CN=Windows NT,CN=Services,CN=Configuration,' + $Dcname
	$AnonADSI = [ADSI]$Adsi
	$AnonADSI.Put("dSHeuristics","0000002")
	$AnonADSI.SetInfo()
	$ADSI = [ADSI]('LDAP://CN=Users,' + $Dcname)
	$Anon = New-Object System.Security.Principal.NTAccount("ANONYMOUS LOGON")
	$SID = $Anon.Translate([System.Security.Principal.SecurityIdentifier])
	$adRights = [System.DirectoryServices.ActiveDirectoryRights] "GenericRead"
	$type = [System.Security.AccessControl.AccessControlType] "Allow"
	$inheritanceType = [System.DirectoryServices.ActiveDirectorySecurityInheritance] "All"
	$ace = New-Object System.DirectoryServices.ActiveDirectoryAccessRule $SID,$adRights,$type,$inheritanceType
	$ADSI.PSBase.ObjectSecurity.ModifyAccessRule([System.Security.AccessControl.AccessControlModification]::Add,$ace,[ref]$false)
	$ADSI.PSBase.CommitChanges()
}

function VulnAD-PublicSMBShare {
	mkdir C:\Common
    echo "$password = ConvertTo-SecureString 'UberSecurePassword' -AsPlainText -Force`n$credential = New-Object System.Management.Automation.PSCredential ('administrator', $password)`nInvoke-Command -ComputerName . -Credential $credential -ScriptBlock { Restart-Service -Name 'DNS Server' }" > C:\Common\DNSrestart.ps1
	New-SmbShare -Name Common -Path C:\Common -FullAccess Everyone
	Enable-LocalUser -Name "Guest"
	$acl = Get-Acl C:\Common
	$AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("Guest","FullControl","Allow")
	$acl.SetAccessRule($AccessRule)
	$acl | Set-Acl C:\Common
	Set-Itemproperty -path 'HKLM:\SYSTEM\CurrentControlSet\Control\Lsa' -Name 'EveryoneIncludesAnonymous' -value '1'
	New-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters' -name "NullSessionShares" -PropertyType MultiString -value "C:\Common"
}

VulnAD-AddADUser -limit 50
VulnAD-AddADGroup -GroupList $Global:HighGroups
VulnAD-AddADGroup -GroupList $Global:MidGroups
VulnAD-AddADGroup -GroupList $Global:NormalGroups
VulnAD-Kerberoasting
VulnAD-ASREPRoasting
VulnAD-DisableSMBSigning
VulnAD-EnableWinRM
VulnAD-AnonymousLDAP
VulnAD-PublicSMBShare
		}
	}
}
catch{}
try{
	while(!(Invoke-RestMethod "https://10.0.0.10:5601/")){
		if((Invoke-RestMethod "https://10.0.0.10:5601/") -and (Test-Path -Path "C:\Program Files\Elastic")){
			$ProgressPreference = 'SilentlyContinue'
			Invoke-WebRequest -Uri https://artifacts.elastic.co/downloads/beats/elastic-agent/elastic-agent-8.8.1-windows-x86_64.zip -OutFile elastic-agent-8.8.1-windows-x86_64.zip
			Expand-Archive .\elastic-agent-8.8.1-windows-x86_64.zip -DestinationPath .
			cd elastic-agent-8.8.1-windows-x86_64
			$username = "elastic"
			$password= "Pa`$`$w0rd"
			$credential = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $username,$password)))
			add-type " `
				using System.Net; `
				using System.Security.Cryptography.X509Certificates; `
				public class TrustAllCertsPolicy : ICertificatePolicy { `
					public bool CheckValidationResult( `
						ServicePoint srvPoint, X509Certificate certificate, `
						WebRequest request, int certificateProblem) { `
						return true; `
					} `
				} `
			"
            [System.Net.ServicePointManager]::CertificatePolicy = New-Object TrustAllCertsPolicy
			.\elastic-agent.exe install --url=https://10.0.0.10:8220 --enrollment-token=$(((Invoke-RestMethod "https://10.0.0.10:5601/api/fleet/enrollment_api_keys" -Headers @{Authorization=("Basic {0}" -f $credential)}).list | where "policy_id" -eq "agent-policy" | select-object "api_key").api_key) -i -n
		}
	}
}
catch{}