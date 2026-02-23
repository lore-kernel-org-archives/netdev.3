Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A600330D38
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 19:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771873286; cv=none; b=Eeo1v473IAEBD4AI4XZtaQCYQT2HXTF+nH+239vlMgTDEA1gcqXzydkq+N5A8vdzFDrHYkvbxcg1B5eq4R1iC7fVO5H9t6qAAc/mezIaEV8posXcvMUfvdmWOUailVxQnlfAi8XC0pzz+iM2Ojnui9YsrzArsQZpEqLsiZrYz4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771873286; c=relaxed/simple;
	bh=RBuoWMub8e6Cm2xNdhxAWcDE3UG9Qb2tacaLSL2ZTpA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rYR+URdq9cNpTTn83+nVpaT9AZesIIPOmAiwM25/aBJ3GWqbNcS11ktzJ5s2OZbrsigz5/AieNGLlzESxebQKxukWpX4p41cZdatNEl1knswuhVfSXvhjx90iz/QM+YZMlpxlJNNXcfjLSbdn+Jbh041R0bRbVuGFGWP8v/SRPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 6C2946033B; Mon, 23 Feb 2026 20:01:16 +0100 (CET)
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net] selftests: netfilter: nft_queue.sh: increase udp_gro_ct subtest timeout
Date: Mon, 23 Feb 2026 20:00:58 +0100
Message-ID: <20260223190108.28139-1-fw@strlen.de>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jakub reports test flakes on debug kernels:
 FAIL: test_udp_gro_ct: Expected software segmentation to occur, had 23 and 17

The nf_queue listener exits when it doesn't receive a new packet after
2s, seems this is too low. Use a 5 second timeout instead, same as the
duration of the packet generation side.

Fixes: 59ecffa3995e ("selftests: netfilter: nft_queue.sh: add udp fraglist gro test case")
Reported-by: Jakub Kicinski <kuba@kernel.org>
Closes: https://lore.kernel.org/netdev/20260218184114.0b405b72@kernel.org/
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 Hello, unfortunately I can't repro the flakes here, but 2s is rather
 short and a nf_queue listener that exits while packets are still queued
 does explain the error message (more packets counted as incoming than
 outgoing).

 tools/testing/selftests/net/netfilter/nft_queue.sh | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/netfilter/nft_queue.sh b/tools/testing/selftests/net/netfilter/nft_queue.sh
index 139bc1211878..5d22a4dc8721 100755
--- a/tools/testing/selftests/net/netfilter/nft_queue.sh
+++ b/tools/testing/selftests/net/netfilter/nft_queue.sh
@@ -591,6 +591,7 @@ EOF
 test_udp_gro_ct()
 {
 	local errprefix="FAIL: test_udp_gro_ct:"
+	local timeout=5
 
 	ip netns exec "$nsrouter" conntrack -F 2>/dev/null
 
@@ -630,10 +631,10 @@ table inet udpq {
 	}
 }
 EOF
-	timeout 10 ip netns exec "$ns2" socat UDP-LISTEN:12346,fork,pf=ipv4 OPEN:"$TMPFILE1",trunc &
+	timeout "$timeout" ip netns exec "$ns2" socat UDP-LISTEN:12346,fork,pf=ipv4 OPEN:"$TMPFILE1",trunc &
 	local rpid=$!
 
-	ip netns exec "$nsrouter" ./nf_queue -G -c -q 1 -t 2 > "$TMPFILE2" &
+	ip netns exec "$nsrouter" ./nf_queue -G -c -q 1 -t "$timeout" > "$TMPFILE2" &
 	local nfqpid=$!
 
 	ip netns exec "$nsrouter" ethtool -K "veth0" rx-udp-gro-forwarding on rx-gro-list on generic-receive-offload on
@@ -644,11 +645,11 @@ EOF
 	local bs=512
 	local count=$(((32 * 1024 * 1024) / bs))
 	dd if=/dev/zero bs="$bs" count="$count" 2>/dev/null | for i in $(seq 1 16); do
-		timeout 5 ip netns exec "$ns1" \
+		timeout "$timeout" ip netns exec "$ns1" \
 			socat -u -b 512 STDIN UDP-DATAGRAM:10.0.2.99:12346,reuseport,bind=0.0.0.0:55221 &
 	done
 
-	busywait 10000 test -s "$TMPFILE1"
+	busywait $((timeout * 1000)) test -s "$TMPFILE1"
 
 	kill "$rpid"
 
-- 
2.52.0

