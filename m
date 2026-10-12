Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CA1489FA5
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 12:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791809656; cv=none; b=nw5T0mNyv/dq6WZ7eyJg1KIQ73g8PMcFnyOcBeaasKxFK+9ooFZUD/wUm0embG9f76LeP4QDQXVuwl2tS1zxguUUFOPbWQWnREZRrSV4vO2ywQuPYrY5Fm09i9DVhkv+WK3YvDPxWK/s+4cNHyJH79veU3tK//v/DM/8k+toa38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791809656; c=relaxed/simple;
	bh=eg/RKWlP1ruNV7TVBfwmysnrbDuw4Rl1G1Thj0rJ/1o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=unD18/+jgUd+CknkYOTOdsPc3xJoivQpInEoqtbLHI8mSe6oNUKclgBWQ8QYQRZgJcLGgrmthuWpkoL/GcQRfhP0A5tNLK4pemMc/VYcmBzlC+EmvV0el37+6G+W6FuB8FL6GNmhnEx1r/UPyXSbPiDJkoKxyOpXB31LQIC0eZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iLWizlzo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iLWizlzo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791809653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IDA+Qa/xd/+ERE4Ri6kv1sTLCcaJQKE0vjjRHXpBfJU=;
	b=iLWizlzoN65PQ/AulMJ4lSR+kvLM45U+LzOfbu8VDgdnOLpNw3CdSYGykOKFkV8KiE/fez
	tIGrL2uJ5S+GE2Xj0Bmo+6Emw/HH2yLPaNERc1pZPYeusGBte6bXBgeVoicxuRT6hwFicT
	KUzas/KzI3doXYfxCy9KFL2aretmrdo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-694-dHEzW9_-NEuXaFbAC9xXBw-1; Mon,
 12 Oct 2026 12:54:10 +0000
X-MC-Unique: dHEzW9_-NEuXaFbAC9xXBw-1
X-Mimecast-MFC-AGG-ID: dHEzW9_-NEuXaFbAC9xXBw_1791809649
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EA8751802572;
	Mon, 12 Oct 2026 12:54:08 +0000 (UTC)
Received: from pmukherj-thinkpadt14gen5.punetw6.csb (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0390330000E7;
	Mon, 12 Oct 2026 12:54:02 +0000 (UTC)
From: Prasenjit Mukherjee <pmukherj@redhat.com>
To: "David S. Miller" <davem@davemloft.net>,
	"Eric Dumazet" <edumazet@kernel.org>,
	"Jakub Kicinski" <kuba@kernel.org>,
	"Paolo Abeni" <pabeni@redhat.com>,
	"Simon Horman" <horms@kernel.org>,
	"Shuah Khan" <shuah@kernel.org>,
	"David Ahern" <dsahern@kernel.org>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	netdev@vger.kernel.org
Cc: "Davide Caratti" <dcaratti@redhat.com>
Subject: [PATCH net] selftests: net: fix race condition in icmp.sh causing CKI sporadic failures
Date: Mon, 12 Oct 2026 18:23:32 +0530
Message-ID: <b15ee681a330f9b05a9076a3852c186017f59d83.1791804421.git.pmukherj@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

CKI reports sporadic failures in icmp.sh, Davide suggests this might be
caused by a race condition where tcpdump starts capturing after the last of
expected ICMP unreachable packets have been sent.
Fix this replacing tcpdump with a tc flower filter that
matches ICMP Destination Unreachable (type 3, code 0),
and match on act_gact counters instead.
This will remove any race condition to appear.

Fixes: 7e9838b7915e2 ("selftests/net: Add icmp.sh for testing ICMP dummy address responses")
CC: Toke Høiland-Jørgensen <toke@redhat.com>
Suggested-by: Davide Caratti <dcaratti@redhat.com>
Reviewed-by: Davide Caratti <dcaratti@redhat.com>
Reported-by: CKI Project <cki-project@redhat.com>
Closes: https://datawarehouse.cki-project.org/issue/3658
Signed-off-by: Prasenjit Mukherjee <pmukherj@redhat.com>
---
 tools/testing/selftests/net/icmp.sh | 32 ++++++++++++++---------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/net/icmp.sh b/tools/testing/selftests/net/icmp.sh
index 824cb0e35eff..0714e8b34d12 100755
--- a/tools/testing/selftests/net/icmp.sh
+++ b/tools/testing/selftests/net/icmp.sh
@@ -27,11 +27,8 @@ PINGADDR=172.16.1.1
 RT2=172.16.0.0/24
 H2_IP6=2001:db8:1::2
 
-TMPFILE=$(mktemp)
-
 cleanup()
 {
-    rm -f "$TMPFILE"
     cleanup_ns $NS1 $NS2
 }
 
@@ -52,21 +49,24 @@ ip -netns $NS2 route add $RT2 via inet6 $H1_IP6
 
 # Make sure ns2 will respond with ICMP unreachable
 ip netns exec $NS2 sysctl -qw net.ipv4.icmp_ratelimit=0 net.ipv4.ip_forward=1
+# Install tc flower filter to count ICMP unreachable from 192.0.0.8
+ip netns exec $NS1 tc qdisc add dev veth0 clsact
+ip netns exec $NS1 tc filter add dev veth0 ingress \
+	protocol ip pref 1 handle 1 flower \
+	src_ip 192.0.0.8 ip_proto icmp type 3 code 0 \
+	action pass
 
-# Run the test - a ping runs in the background, and we capture ICMP responses
-# with tcpdump; -c 1 means it should exit on the first ping, but add a timeout
-# in case something goes wrong
-ip netns exec $NS1 ping -w 3 -i 0.5 $PINGADDR >/dev/null &
-ip netns exec $NS1 timeout 10 tcpdump -tpni veth0 -c 1 'icmp and icmp[icmptype] != icmp-echo' > $TMPFILE 2>/dev/null
+# Send ping to trigger ICMP unreachable from ns2
+ip netns exec $NS1 ping -c 1 $PINGADDR >/dev/null 2>&1
 
-# Parse response and check for dummy address
-# tcpdump output looks like:
-# IP 192.0.0.8 > 172.16.0.1: ICMP net 172.16.1.1 unreachable, length 92
-RESP_IP=$(awk '{print $2}' < $TMPFILE)
-if [[ "$RESP_IP" != "192.0.0.8" ]]; then
-    echo "FAIL - got ICMP response from $RESP_IP, should be 192.0.0.8"
-    exit 1
-else
+# Verify ICMP unreachable was received from dummy address 192.0.0.8 per RFC7600
+COUNT=$(ip netns exec $NS1 tc -j -s filter show dev veth0 ingress \
+	| jq '.[1].options.actions[].stats.packets')
+
+if [[ "$COUNT" -eq 1 ]]; then
     echo "OK"
     exit 0
+else
+    echo "FAIL - expected 1 ICMP unreachable from 192.0.0.8, got $COUNT"
+    exit 1
 fi
-- 
2.55.0

