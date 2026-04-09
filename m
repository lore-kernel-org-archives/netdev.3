Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1F1192590
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 23:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775775818; cv=none; b=eP9VaGRi+Q1nI8VYEe/SHmf4TZCCMSZ8AwA5VLjyq6DCZIZa2OIqJwSZuGNbfgivG5jet78zhD2aLQLLMgcd7cp3c2I2UTHmJ0ogjmK0AePGKT2Iv/ENbhyhC0jujEMa1ib0cvhHrHsnrnI+zmwkDFhYu5GDozRk6iLQk78dveI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775775818; c=relaxed/simple;
	bh=wsdm8ej4MLXGYH0H5ah1PJJbWDQoWXbgPxWp07LxbdM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L9x+T2gQ6YfLcw12BgKaDWtbuHYvkzytk7abGTRcllnzDCXOz76SXynmNuAz7qxZHYlg9v27L2efGwWklGEkNNT0MkPfkJ1wIYkgA+mb0bKqGtrHOK6ugPzSNZllWWNPZIQ5hIqRXvohEmOwqA+72Yy2Lyg7zhFcDUobD6Qtul0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id A885C60636; Fri, 10 Apr 2026 01:03:34 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net] selftests: netfilter: nft_tproxy.sh: adjust to socat changes
Date: Fri, 10 Apr 2026 00:45:02 +0200
Message-ID: <20260409224506.27072-1-fw@strlen.de>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Like e65d8b6f3092 ("selftests: drv-net: adjust to socat changes") we
need to add shut-none for this test too.

The extra 0-packet can trigger a second (unexpected) reply from the server.

Fixes: 7e37e0eacd22 ("selftests: netfilter: nft_tproxy.sh: add tcp tests")
Reported-by: Jakub Kicinski <kuba@kernel.org>
Closes: https://lore.kernel.org/netdev/20260408152432.24b8ad0d@kernel.org/
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 I'll leave it up to netdev maintainers to apply this to net-next
 instead.

 .../selftests/net/netfilter/nft_tproxy_udp.sh      | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/netfilter/nft_tproxy_udp.sh b/tools/testing/selftests/net/netfilter/nft_tproxy_udp.sh
index d16de13fe5a7..1dc7b0450145 100755
--- a/tools/testing/selftests/net/netfilter/nft_tproxy_udp.sh
+++ b/tools/testing/selftests/net/netfilter/nft_tproxy_udp.sh
@@ -190,13 +190,13 @@ table inet filter {
 }
 EOF
 
-	timeout "$timeout" ip netns exec "$nsrouter" socat -u "$socat_ipproto" udp-listen:12345,fork,ip-transparent,reuseport udp:"$ns1_ip_port",ip-transparent,reuseport,bind="$ns2_ip_port" 2>/dev/null &
+	timeout "$timeout" ip netns exec "$nsrouter" socat -u "$socat_ipproto" udp-listen:12345,fork,ip-transparent,reuseport,shut-none udp:"$ns1_ip_port",ip-transparent,reuseport,bind="$ns2_ip_port",shut-none 2>/dev/null &
 	local tproxy_pid=$!
 
-	timeout "$timeout" ip netns exec "$ns2" socat "$socat_ipproto" udp-listen:8080,fork SYSTEM:"echo PONG_NS2" 2>/dev/null &
+	timeout "$timeout" ip netns exec "$ns2" socat "$socat_ipproto" udp-listen:8080,fork,shut-none SYSTEM:"echo PONG_NS2" 2>/dev/null &
 	local server2_pid=$!
 
-	timeout "$timeout" ip netns exec "$ns3" socat "$socat_ipproto" udp-listen:8080,fork SYSTEM:"echo PONG_NS3" 2>/dev/null &
+	timeout "$timeout" ip netns exec "$ns3" socat "$socat_ipproto" udp-listen:8080,fork,shut-none SYSTEM:"echo PONG_NS3" 2>/dev/null &
 	local server3_pid=$!
 
 	busywait "$BUSYWAIT_TIMEOUT" listener_ready "$nsrouter" 12345 "-u"
@@ -205,7 +205,7 @@ EOF
 
 	local result
 	# request from ns1 to ns2 (forwarded traffic)
-	result=$(echo I_M_PROXIED | ip netns exec "$ns1" socat -t 2 -T 2 STDIO udp:"$ns2_ip_port",sourceport=18888)
+	result=$(echo I_M_PROXIED | ip netns exec "$ns1" socat -t 2 -T 2 STDIO udp:"$ns2_ip_port",sourceport=18888,shut-none)
 	if [ "$result" == "$expect_ns1_ns2" ] ;then
 		echo "PASS: tproxy test $testname: ns1 got reply \"$result\" connecting to ns2"
 	else
@@ -214,7 +214,7 @@ EOF
 	fi
 
 	# request from ns1 to ns3 (forwarded traffic)
-	result=$(echo I_M_PROXIED | ip netns exec "$ns1" socat -t 2 -T 2 STDIO udp:"$ns3_ip_port")
+	result=$(echo I_M_PROXIED | ip netns exec "$ns1" socat -t 2 -T 2 STDIO udp:"$ns3_ip_port",shut-none)
 	if [ "$result" = "$expect_ns1_ns3" ] ;then
 		echo "PASS: tproxy test $testname: ns1 got reply \"$result\" connecting to ns3"
 	else
@@ -223,7 +223,7 @@ EOF
 	fi
 
 	# request from nsrouter to ns2 (localy originated traffic)
-	result=$(echo I_M_PROXIED | ip netns exec "$nsrouter" socat -t 2 -T 2 STDIO udp:"$ns2_ip_port")
+	result=$(echo I_M_PROXIED | ip netns exec "$nsrouter" socat -t 2 -T 2 STDIO udp:"$ns2_ip_port",shut-none)
 	if [ "$result" == "$expect_nsrouter_ns2" ] ;then
 		echo "PASS: tproxy test $testname: nsrouter got reply \"$result\" connecting to ns2"
 	else
@@ -232,7 +232,7 @@ EOF
 	fi
 
 	# request from nsrouter to ns3 (localy originated traffic)
-	result=$(echo I_M_PROXIED | ip netns exec "$nsrouter" socat -t 2 -T 2 STDIO udp:"$ns3_ip_port")
+	result=$(echo I_M_PROXIED | ip netns exec "$nsrouter" socat -t 2 -T 2 STDIO udp:"$ns3_ip_port",shut-none)
 	if [ "$result" = "$expect_nsrouter_ns3" ] ;then
 		echo "PASS: tproxy test $testname: nsrouter got reply \"$result\" connecting to ns3"
 	else
-- 
2.52.0

