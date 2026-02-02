Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A70C36C0BC
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 14:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770042034; cv=none; b=qH4Uce/wfo5dr4bpcKXAmlZROQmHn8vP/D0DR5D+2ILC97Jy5kV5Jwf+rw1GGCYswg//wqDAoIaDu+nptYwCVM5R5oy54MiWPFCM8N7ftvLM+UogQh+h1OzIwLHQI0KGhFF60G/YlVbw8VUNVXOlnBdNrHSzVts4Id3rUAJgi7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770042034; c=relaxed/simple;
	bh=EbWL9adU5Z+0qz4YL/BEp5QwXcwGF4GvCrQO4lI28eA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jFJ15tkDQ8W89ZMBjgqsqiWQ+f/nlHoFS8kXxM71UJrT5FB18ios515AkHq+q8dVHFfSQv7XOO3HHONKM+zI1U41vB2rqFm9WawKXDru++cUxZHrCo159SiNU43IbNPKiENkCNzFXmVbc1H9GmoNDY7GjK9F4eJ8VjAo4QLqNZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FKVyznrb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FKVyznrb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770042032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iOkWbZzgEgXYjm6R2vky7/7JbTxXAzfAhQhbwNBkA3w=;
	b=FKVyznrbG4ioqylhufz5VYXKi7+X3SxAIy5Bn1AtEnkcpsxqginpNhwOOJznnjgTxTOhFl
	CSqBibU63debLZCttNgTbZNBWLfoB4mCxF1rGnenvHbxKjW3XrYuXzUmjEbEB9HYUXQofm
	GCusoUEETBPG/W2wRhiSm12LH4DJsts=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-615-_B39V-moPJybM7Ogivxv1A-1; Mon,
 02 Feb 2026 09:20:29 -0500
X-MC-Unique: _B39V-moPJybM7Ogivxv1A-1
X-Mimecast-MFC-AGG-ID: _B39V-moPJybM7Ogivxv1A_1770042027
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D16DF1800447;
	Mon,  2 Feb 2026 14:20:26 +0000 (UTC)
Received: from thinkpad.redhat.com (unknown [10.44.34.1])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 16F34180094B;
	Mon,  2 Feb 2026 14:20:22 +0000 (UTC)
From: Felix Maurer <fmaurer@redhat.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jkarrenpalo@gmail.com,
	tglx@kernel.org,
	mingo@kernel.org,
	bigeasy@linutronix.de,
	matttbe@kernel.org,
	allison.henderson@oracle.com,
	petrm@nvidia.com,
	antonio@openvpn.net
Subject: [PATCH net-next v3 1/8] selftests: hsr: Add ping test for PRP
Date: Mon,  2 Feb 2026 15:19:17 +0100
Message-ID: <146a8368c2126acf48b90d6eba1ceeb280707179.1770041682.git.fmaurer@redhat.com>
In-Reply-To: <cover.1770041682.git.fmaurer@redhat.com>
References: <cover.1770041682.git.fmaurer@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Add a selftest for PRP that performs a basic ping test on IPv4 and IPv6,
over the plain PRP interface and a VLAN interface, similar to the existing
ping test for HSR. The test first checks reachability of the other node,
then checks for no loss and no duplicates.

Signed-off-by: Felix Maurer <fmaurer@redhat.com>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 tools/testing/selftests/net/hsr/Makefile    |   1 +
 tools/testing/selftests/net/hsr/prp_ping.sh | 147 ++++++++++++++++++++
 2 files changed, 148 insertions(+)
 create mode 100755 tools/testing/selftests/net/hsr/prp_ping.sh

diff --git a/tools/testing/selftests/net/hsr/Makefile b/tools/testing/selftests/net/hsr/Makefile
index 4b6afc0fe9f8..1886f345897a 100644
--- a/tools/testing/selftests/net/hsr/Makefile
+++ b/tools/testing/selftests/net/hsr/Makefile
@@ -5,6 +5,7 @@ top_srcdir = ../../../../..
 TEST_PROGS := \
 	hsr_ping.sh \
 	hsr_redbox.sh \
+	prp_ping.sh \
 # end of TEST_PROGS
 
 TEST_FILES += hsr_common.sh
diff --git a/tools/testing/selftests/net/hsr/prp_ping.sh b/tools/testing/selftests/net/hsr/prp_ping.sh
new file mode 100755
index 000000000000..fd2ba9f05d4c
--- /dev/null
+++ b/tools/testing/selftests/net/hsr/prp_ping.sh
@@ -0,0 +1,147 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+ipv6=true
+
+source ./hsr_common.sh
+
+optstring="h4"
+usage() {
+	echo "Usage: $0 [OPTION]"
+	echo -e "\t-4: IPv4 only: disable IPv6 tests (default: test both IPv4 and IPv6)"
+}
+
+while getopts "$optstring" option;do
+	case "$option" in
+	"h")
+		usage "$0"
+		exit 0
+		;;
+	"4")
+		ipv6=false
+		;;
+	"?")
+		usage "$0"
+		exit 1
+		;;
+esac
+done
+
+setup_prp_interfaces()
+{
+	echo "INFO: Preparing interfaces for PRP"
+# Two PRP nodes, connected by two links (treated as LAN A and LAN B).
+#
+#       vethA ----- vethA
+#     prp1             prp2
+#       vethB ----- vethB
+#
+#     node1           node2
+
+	# Interfaces
+	# shellcheck disable=SC2154 # variables assigned by setup_ns
+	ip link add vethA netns "$node1" type veth peer name vethA netns "$node2"
+	ip link add vethB netns "$node1" type veth peer name vethB netns "$node2"
+
+	# MAC addresses will be copied from LAN A interface
+	ip -net "$node1" link set address 00:11:22:00:00:01 dev vethA
+	ip -net "$node2" link set address 00:11:22:00:00:02 dev vethA
+
+	# PRP
+	ip -net "$node1" link add name prp1 type hsr \
+		slave1 vethA slave2 vethB supervision 45 proto 1
+	ip -net "$node2" link add name prp2 type hsr \
+		slave1 vethA slave2 vethB supervision 45 proto 1
+
+	# IP addresses
+	ip -net "$node1" addr add 100.64.0.1/24 dev prp1
+	ip -net "$node1" addr add dead:beef:0::1/64 dev prp1 nodad
+	ip -net "$node2" addr add 100.64.0.2/24 dev prp2
+	ip -net "$node2" addr add dead:beef:0::2/64 dev prp2 nodad
+
+	# All links up
+	ip -net "$node1" link set vethA up
+	ip -net "$node1" link set vethB up
+	ip -net "$node1" link set prp1 up
+
+	ip -net "$node2" link set vethA up
+	ip -net "$node2" link set vethB up
+	ip -net "$node2" link set prp2 up
+}
+
+setup_vlan_interfaces()
+{
+	# Interfaces
+	ip -net "$node1" link add link prp1 name prp1.2 type vlan id 2
+	ip -net "$node2" link add link prp2 name prp2.2 type vlan id 2
+
+	# IP addresses
+	ip -net "$node1" addr add 100.64.2.1/24 dev prp1.2
+	ip -net "$node1" addr add dead:beef:2::1/64 dev prp1.2 nodad
+
+	ip -net "$node2" addr add 100.64.2.2/24 dev prp2.2
+	ip -net "$node2" addr add dead:beef:2::2/64 dev prp2.2 nodad
+
+	# All links up
+	ip -net "$node1" link set prp1.2 up
+	ip -net "$node2" link set prp2.2 up
+}
+
+do_ping_tests()
+{
+	local netid="$1"
+
+	echo "INFO: Initial validation ping"
+
+	do_ping "$node1" "100.64.$netid.2"
+	do_ping "$node2" "100.64.$netid.1"
+	stop_if_error "Initial validation failed on IPv4"
+
+	do_ping "$node1" "dead:beef:$netid::2"
+	do_ping "$node2" "dead:beef:$netid::1"
+	stop_if_error "Initial validation failed on IPv6"
+
+	echo "INFO: Longer ping test."
+
+	do_ping_long "$node1" "100.64.$netid.2"
+	do_ping_long "$node2" "100.64.$netid.1"
+	stop_if_error "Longer ping test failed on IPv4."
+
+	do_ping_long "$node1" "dead:beef:$netid::2"
+	do_ping_long "$node2" "dead:beef:$netid::1"
+	stop_if_error "Longer ping test failed on IPv6."
+}
+
+run_ping_tests()
+{
+	echo "INFO: Running ping tests"
+	do_ping_tests 0
+}
+
+run_vlan_ping_tests()
+{
+	vlan_challenged_prp1=$(ip net exec "$node1" ethtool -k prp1 | \
+		grep "vlan-challenged" | awk '{print $2}')
+	vlan_challenged_prp2=$(ip net exec "$node2" ethtool -k prp2 | \
+		grep "vlan-challenged" | awk '{print $2}')
+
+	if [[ "$vlan_challenged_prp1" = "off" || \
+	      "$vlan_challenged_prp2" = "off" ]]; then
+		echo "INFO: Running VLAN ping tests"
+		setup_vlan_interfaces
+		do_ping_tests 2
+	else
+		echo "INFO: Not Running VLAN tests as the device does not support VLAN"
+	fi
+}
+
+check_prerequisites
+trap cleanup_all_ns EXIT
+
+setup_ns node1 node2
+setup_prp_interfaces
+
+run_ping_tests
+run_vlan_ping_tests
+
+exit $ret
-- 
2.52.0

