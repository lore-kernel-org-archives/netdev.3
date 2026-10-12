Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFB73AEF5F;
	Mon, 12 Oct 2026 05:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791781584; cv=none; b=OZsLejeRswNU5aEcg7ZC6sj1B7Au0J8FPLZvRn0aAJs4uFtStqB/xUX4Qma9da8V/tiQvneqOoQBwbdnt5CO21QzLffmNlnUeXCZh3GLQ5KYgFts5fJMWNMFx6ynsIL/j2Su3ewUd01M3xVl1jaS4JH4i4pcMQ/gGj2sIxwVKzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791781584; c=relaxed/simple;
	bh=Ohy3FXyPI/1AldXDkoxIE8x2jL1MPH/wXKjx+1HUTJ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cCTJtvtTX5bIBnHaoGjautALwxsLNmuAKMhY438Ccpl9xCE9ccIV6vKd//HEuFYC8JwlBM4RBjHgGBcYgE3pDZWZZvSOR1k1uQYHgm87+l9gvjIUzmsMSrRq0NDjLjaAsmSO1u/E3ZCLE9tt4VHd9ieR+SDUMRkUgMQMOXLYMEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XNCaX8wZ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XNCaX8wZ"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69C2Ekk32913040;
	Mon, 12 Oct 2026 05:06:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ewhnlzpDySiqjc13Y
	UoEfB7m/jaXKOqIGvovrJzGkAw=; b=XNCaX8wZ5+GdabFq185I8ul0aAwzb5K58
	x3CuTOHtv+bp797ZpA4bpQw8MGXwtoS6x7T3O6sD1Vlqa9ESSg8JS1kjyDSQdC2t
	8vkZiG8s1P2Ozs7BX+jw/H6xkGCoO90V0QbOaGMe7qLcXRhuBU2msqGb9MBD74zN
	aO25zt/jJfDY3QklGwXzG6PAwk1xO9AlJTqYyPqQiebbI6NpAaU+1Mrc3Gwo6dTW
	qF5nRRwmcAkcGu8GqywdSJPdomwEcODKVCawUSHa31+wjMkddXfuhQ15OnbSqDNx
	NbSgmEIppdW6RcIrtxrPJ0WkWsu3Pw27J0160fDh0P3aTlksxK7Yg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwhpyrv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 05:06:06 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69C5544T3726536;
	Mon, 12 Oct 2026 05:06:05 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h81wfukqh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 05:06:05 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69C563JE31064584
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 05:06:04 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D45CE58121;
	Mon, 12 Oct 2026 05:06:03 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 18A055811C;
	Mon, 12 Oct 2026 05:06:00 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.163.79])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 05:05:59 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: Mingming Cao <mmc@linux.ibm.com>, nnac123@linux.ibm.com,
        maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
        kuba@kernel.org, pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, horms@kernel.org, davemarq@linux.ibm.com,
        bjking1@linux.ibm.com, brking@linux.vnet.ibm.com,
        tlfalcon@linux.vnet.ibm.com, jmaxwell37@gmail.com, zdai@us.ibm.com,
        marcelo.leitner@gmail.com, ksiva@linux.vnet.ibm.com
Subject: [PATCH net-next v4 9/9] ibmveth: check headers in the RX large send and checksum helpers
Date: Sun, 11 Oct 2026 22:05:18 -0700
Message-Id: <20261012050518.88858-10-mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20261012050518.88858-1-mmc@linux.ibm.com>
References: <20261012050518.88858-1-mmc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAxOCBTYWx0ZWRfX3XxgTVTEAZyd
 J70ae+T/qo6CDKE8MWXse6WEPyn2inRiNDW89ze3crN4ct2BTHjMUmekqgeHkVvcg+H4b32RWTa
 c4UKyG2caavkahGusvoDAL2q+HPMuNcZDqxsnNSHvcA77iNAoKWZH2GbBC+A4A7yrPGpxWT31Vu
 SaMG4WuWaYCLKtzbAGkiTDWwaebUV3FzbxuKVwFGo5CgTSBtohFED4zmCRfosxVKiWQcZ+GBsLK
 FJ38/McBEil+4qku4khidDX5WJ5fUva+YRZ6eFzmfC6FCZecr+QKCT/8jaMhcT1ibP5pLSK2MF6
 /FKVz9HfHFl32CWWJ3UveOskfg0JRNtWgajWU3luXcp9xcuM/n1G5LHSQTT3T1HazVbeSqFEAyh
 C3v4Bu4At121WVn7N4Jrj5gyOeRrCi06O13qpnb6CJzu7Q9krKdN2AdgFV00rAbYCH6ZLG0BQmV
 ogsQMlNrM9Pst5iLayA==
X-Proofpoint-GUID: pZWxsCto6rlx3JEWlsTkoGkQDn_2BTL3
X-Proofpoint-ORIG-GUID: l833tFZ7HRfhuz26We7igs6LbrkUzip7
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAxOCBTYWx0ZWRfX4sz+1/sPKHfy
 EfJbcbvcTL32DiKNR7Kb11pdharTe1lCB/CDxDtH6nnuMBD1sc2XH/ZXY8Hn6kzqJIka1he//Kn
 DmSJZ7rOPPtVDSxdYfSEacpqVHAeL5s=
X-Authority-Analysis: v=2.4 cv=btHZl0ai c=1 sm=1 tr=0 ts=6acc6abe cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=Dgfd_u8aUg-a4jxWMB0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 phishscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120018

ibmveth_rx_mss_helper() and ibmveth_rx_csum_helper() trust the IP and
TCP headers of received frames, which come from another partition on
the virtual LAN.

The worst case is an IPv4 frame with ihl 0 and iph->check 0xffff: the
checksum helper calls ip_fast_csum(iph, 0), and the ppc64 version
loops ihl - 1 times on an unsigned count, reading up to 16 GiB in
softirq: a long stall, or an oops once the read leaves mapped memory.
Both helpers also read and write header fields past the end of a short
frame. The large send helper takes the segment size from the TCP
checksum field and gso_segs from a TCP header length it never checks,
and treats an IPv4 TCP fragment as a large send, which can zero two of
its bytes; the checksum helper can write a checksum into a later
fragment's payload.

The ihl problem dates from the first commit in Fixes:, the large send
helper from the second, and the checksum helper from the third.

Before using a header, check that it fits the frame, that the IPv4 ihl
is at least 5, and that an IPv4 TCP frame is not a fragment. In the
large send helper, also require a TCP doff of at least 5 and TCP
payload within the IP length, the length the stack trims the frame to,
so Ethernet padding does not count; compute gso_segs from the IP
length; and keep the segment size at or above TCP_MIN_GSO_SIZE, as
virtio_net_hdr_to_skb() does since
commit c27c449d455a ("virtio-net: Ensure that TCP packets don't
overflow gso_segs"),
and below GSO_BY_FRAGS, which virtio rejects. With the headers checked
and gso_segs computed, the skb is not marked SKB_GSO_DODGY, which
would also keep it from hardware TSO on the egress device.

A frame that fails a check is passed up without the GSO fields or
CHECKSUM_UNNECESSARY, so the stack checks it. The skb is linear, so
the checks use skb_headlen(); pskb_may_pull() could reallocate the
head under the helpers' header pointers.

Add KUnit cases for both helpers: valid IPv4 and IPv6 large sends, the
segment size clamp, and refused frames. With any one of the ihl, doff,
IP length, fragment or clamp checks, or the checksum helper's IPv4
options, IPv6 header or TCP header length checks, removed, a case
fails; without the checksum helper's ihl check, ip_fast_csum() oopses
on qemu.

Found by the Sashiko AI review of the previous version of this series
and by AI-assisted review, and confirmed by code inspection and the
KUnit cases above. Tested with KUnit on qemu pseries (ppc64le) and on
a POWER10 LPAR with iperf3 large sends over IPv4 and IPv6 at MTU 1500
and 9000, threaded NAPI and busy polling, with no new drops or
InCsumErrors. No kernel selftests cover ibmveth.

Fixes: 9c7e8bc584f5 ("ibmveth: Add support for Large Receive Offload")
Fixes: 7b5967389f5a ("ibmveth: set correct gso_size and gso_type")
Fixes: 66aa0678efc2 ("ibmveth: Support to enable LSO/CSO for Trunk VEA.")
Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmveth.c | 263 ++++++++++++++++++++++++++++-
 1 file changed, 254 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 85e176d0ed32..1c2ac88c28ca 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -1396,8 +1396,12 @@ static netdev_tx_t ibmveth_start_xmit(struct sk_buff *skb,
 
 }
 
-static void ibmveth_rx_mss_helper(struct sk_buff *skb, u16 mss, int lrg_pkt)
+/* Returns false when the IP or TCP headers fail the checks; the frame is
+ * then left unchanged for the stack to check.
+ */
+static bool ibmveth_rx_mss_helper(struct sk_buff *skb, u16 mss, int lrg_pkt)
 {
+	unsigned int gso_type, ip_len;
 	struct tcphdr *tcph;
 	int offset = 0;
 	int hdr_len;
@@ -1406,28 +1410,41 @@ static void ibmveth_rx_mss_helper(struct sk_buff *skb, u16 mss, int lrg_pkt)
 	if (skb->protocol == htons(ETH_P_IP)) {
 		struct iphdr *iph = (struct iphdr *)skb->data;
 
+		if (skb_headlen(skb) < sizeof(*iph) || iph->ihl < 5)
+			return false;
 		if (iph->protocol == IPPROTO_TCP) {
+			/* only a whole datagram has a TCP header to segment */
+			if (ip_is_fragment(iph))
+				return false;
 			offset = iph->ihl * 4;
-			skb_shinfo(skb)->gso_type = SKB_GSO_TCPV4;
+			ip_len = ntohs(iph->tot_len);
+			gso_type = SKB_GSO_TCPV4;
 		} else {
-			return;
+			return true;
 		}
 	} else if (skb->protocol == htons(ETH_P_IPV6)) {
 		struct ipv6hdr *iph6 = (struct ipv6hdr *)skb->data;
 
+		if (skb_headlen(skb) < sizeof(*iph6))
+			return false;
 		if (iph6->nexthdr == IPPROTO_TCP) {
 			offset = sizeof(struct ipv6hdr);
-			skb_shinfo(skb)->gso_type = SKB_GSO_TCPV6;
+			ip_len = offset + ntohs(iph6->payload_len);
+			gso_type = SKB_GSO_TCPV6;
 		} else {
-			return;
+			return true;
 		}
 	} else {
-		return;
+		return true;
 	}
 	/* if mss is not set through Large Packet bit/mss in rx buffer,
 	 * expect that the mss will be written to the tcp header checksum.
 	 */
 	tcph = (struct tcphdr *)(skb->data + offset);
+	if (skb_headlen(skb) < offset + sizeof(*tcph) || tcph->doff < 5 ||
+	    ip_len > skb_headlen(skb) || ip_len <= offset + tcph->doff * 4)
+		return false;
+	skb_shinfo(skb)->gso_type = gso_type;
 	if (lrg_pkt) {
 		skb_shinfo(skb)->gso_size = mss;
 	} else if (offset) {
@@ -1436,11 +1453,18 @@ static void ibmveth_rx_mss_helper(struct sk_buff *skb, u16 mss, int lrg_pkt)
 	}
 
 	if (skb_shinfo(skb)->gso_size) {
+		/* chosen by the sending partition: at least the floor
+		 * virtio_net_hdr_to_skb() uses, and never GSO_BY_FRAGS
+		 */
+		skb_shinfo(skb)->gso_size =
+			clamp_t(u16, skb_shinfo(skb)->gso_size,
+				TCP_MIN_GSO_SIZE, GSO_BY_FRAGS - 1);
 		hdr_len = offset + tcph->doff * 4;
 		skb_shinfo(skb)->gso_segs =
-				DIV_ROUND_UP(skb->len - hdr_len,
+				DIV_ROUND_UP(ip_len - hdr_len,
 					     skb_shinfo(skb)->gso_size);
 	}
+	return true;
 }
 
 static void ibmveth_rx_csum_helper(struct sk_buff *skb,
@@ -1457,6 +1481,10 @@ static void ibmveth_rx_csum_helper(struct sk_buff *skb,
 
 	if (skb_proto == ETH_P_IP) {
 		iph = (struct iphdr *)skb->data;
+		if (skb_headlen(skb) < sizeof(*iph) || iph->ihl < 5 ||
+		    skb_headlen(skb) < iph->ihl * 4 ||
+		    (iph->protocol == IPPROTO_TCP && ip_is_fragment(iph)))
+			goto bad_hdr;
 
 		/* If the IP checksum is not offloaded and if the packet
 		 *  is large send, the checksum must be rebuilt.
@@ -1471,6 +1499,8 @@ static void ibmveth_rx_csum_helper(struct sk_buff *skb,
 		iph_proto = iph->protocol;
 	} else if (skb_proto == ETH_P_IPV6) {
 		iph6 = (struct ipv6hdr *)skb->data;
+		if (skb_headlen(skb) < sizeof(*iph6))
+			goto bad_hdr;
 		iphlen = sizeof(struct ipv6hdr);
 		iph_proto = iph6->nexthdr;
 	}
@@ -1493,6 +1523,8 @@ static void ibmveth_rx_csum_helper(struct sk_buff *skb,
 	if (iph_proto == IPPROTO_TCP) {
 		struct tcphdr *tcph = (struct tcphdr *)(skb->data + iphlen);
 
+		if (skb_headlen(skb) < iphlen + sizeof(*tcph))
+			goto bad_hdr;
 		if (tcph->check == 0x0000) {
 			/* Recompute TCP pseudo header checksum  */
 			tcphdrlen = skb->len - iphlen;
@@ -1510,6 +1542,13 @@ static void ibmveth_rx_csum_helper(struct sk_buff *skb,
 			skb_reset_network_header(skb);
 		}
 	}
+	return;
+
+bad_hdr:
+	/* headers do not fit the frame, or a fragment has no whole TCP
+	 * segment; let the stack check it
+	 */
+	skb->ip_summed = CHECKSUM_NONE;
 }
 
 static int ibmveth_poll(struct napi_struct *napi, int budget)
@@ -1624,7 +1663,8 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 			/* PHYP without PLSO support places a -1 in the ip
 			 * checksum for large send frames.
 			 */
-			if (skb->protocol == cpu_to_be16(ETH_P_IP)) {
+			if (skb->protocol == cpu_to_be16(ETH_P_IP) &&
+			    skb_headlen(skb) >= sizeof(struct iphdr)) {
 				struct iphdr *iph = (struct iphdr *)skb->data;
 
 				iph_check = iph->check;
@@ -1632,7 +1672,8 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 
 			if ((length > netdev->mtu + ETH_HLEN) ||
 			    lrg_pkt || iph_check == 0xffff) {
-				ibmveth_rx_mss_helper(skb, mss, lrg_pkt);
+				if (!ibmveth_rx_mss_helper(skb, mss, lrg_pkt))
+					csum_good = 0;
 				adapter->rx_large_packets++;
 			}
 
@@ -2508,10 +2549,214 @@ static void ibmveth_rxq_harvest_buffer_test(struct kunit *test)
 	flush_work(&adapter->work);
 }
 
+KUNIT_DEFINE_ACTION_WRAPPER(ibmveth_kfree_skb, kfree_skb, struct sk_buff *);
+
+/* A TCP frame after eth_type_trans(): IP header, 20 byte TCP header and
+ * payload bytes of data, with the IP length matching the frame.
+ */
+static struct sk_buff *ibmveth_test_tcp_skb(struct kunit *test, bool ipv6,
+					    unsigned int payload)
+{
+	unsigned int iplen = ipv6 ? sizeof(struct ipv6hdr) : sizeof(struct iphdr);
+	unsigned int len = iplen + sizeof(struct tcphdr) + payload;
+	struct sk_buff *skb = alloc_skb(len, GFP_KERNEL);
+	struct tcphdr *tcph;
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, skb);
+	KUNIT_ASSERT_EQ(test, 0, kunit_add_action_or_reset(test,
+							   ibmveth_kfree_skb,
+							   skb));
+	skb_put_zero(skb, len);
+	if (ipv6) {
+		struct ipv6hdr *iph6 = (struct ipv6hdr *)skb->data;
+
+		skb->protocol = htons(ETH_P_IPV6);
+		iph6->version = 6;
+		iph6->nexthdr = IPPROTO_TCP;
+		iph6->payload_len = htons(len - iplen);
+	} else {
+		struct iphdr *iph = (struct iphdr *)skb->data;
+
+		skb->protocol = htons(ETH_P_IP);
+		iph->version = 4;
+		iph->ihl = 5;
+		iph->protocol = IPPROTO_TCP;
+		iph->tot_len = htons(len);
+	}
+	tcph = (struct tcphdr *)(skb->data + iplen);
+	tcph->doff = 5;
+	return skb;
+}
+
+/**
+ * ibmveth_rx_mss_helper_test - unit test for ibmveth_rx_mss_helper
+ * @test: pointer to kunit structure
+ *
+ * Large send frames get gso_size from the descriptor or the TCP checksum
+ * field, clamped, and gso_segs from the IP length. Frames whose headers
+ * do not fit, with no TCP payload within the IP length, or that are
+ * IPv4 fragments, are refused and left without GSO.
+ *
+ * Return: void
+ */
+static void ibmveth_rx_mss_helper_test(struct kunit *test)
+{
+	struct sk_buff *skb;
+	struct tcphdr *tcph;
+	struct iphdr *iph;
+
+	skb = ibmveth_test_tcp_skb(test, false, 2896);
+	tcph = (struct tcphdr *)(skb->data + sizeof(*iph));
+	tcph->check = (__force __sum16)htons(1448);
+	KUNIT_EXPECT_TRUE(test, ibmveth_rx_mss_helper(skb, 0, 0));
+	KUNIT_EXPECT_EQ(test, SKB_GSO_TCPV4, skb_shinfo(skb)->gso_type);
+	KUNIT_EXPECT_EQ(test, 1448, skb_shinfo(skb)->gso_size);
+	KUNIT_EXPECT_EQ(test, 2, skb_shinfo(skb)->gso_segs);
+	KUNIT_EXPECT_EQ(test, 0, (__force u16)tcph->check);
+
+	skb = ibmveth_test_tcp_skb(test, false, 2896);
+	KUNIT_EXPECT_TRUE(test, ibmveth_rx_mss_helper(skb, 1000, 1));
+	KUNIT_EXPECT_EQ(test, 1000, skb_shinfo(skb)->gso_size);
+	KUNIT_EXPECT_EQ(test, 3, skb_shinfo(skb)->gso_segs);
+
+	skb = ibmveth_test_tcp_skb(test, true, 2896);
+	tcph = (struct tcphdr *)(skb->data + sizeof(struct ipv6hdr));
+	tcph->check = (__force __sum16)htons(1448);
+	KUNIT_EXPECT_TRUE(test, ibmveth_rx_mss_helper(skb, 0, 0));
+	KUNIT_EXPECT_EQ(test, SKB_GSO_TCPV6, skb_shinfo(skb)->gso_type);
+	KUNIT_EXPECT_EQ(test, 1448, skb_shinfo(skb)->gso_size);
+	KUNIT_EXPECT_EQ(test, 2, skb_shinfo(skb)->gso_segs);
+
+	skb = ibmveth_test_tcp_skb(test, false, 2896);
+	KUNIT_EXPECT_TRUE(test, ibmveth_rx_mss_helper(skb, 1, 1));
+	KUNIT_EXPECT_EQ(test, TCP_MIN_GSO_SIZE, skb_shinfo(skb)->gso_size);
+
+	skb = ibmveth_test_tcp_skb(test, false, 2896);
+	KUNIT_EXPECT_TRUE(test, ibmveth_rx_mss_helper(skb, GSO_BY_FRAGS, 1));
+	KUNIT_EXPECT_EQ(test, GSO_BY_FRAGS - 1, skb_shinfo(skb)->gso_size);
+
+	/* refused: ihl 0, doff 4, IP length past the frame. With ihl 0 the
+	 * TCP header would overlap the IP header; saddr makes its doff 5.
+	 */
+	skb = ibmveth_test_tcp_skb(test, false, 2896);
+	((struct iphdr *)skb->data)->ihl = 0;
+	((struct iphdr *)skb->data)->saddr = htonl(0x50000000);
+	KUNIT_EXPECT_FALSE(test, ibmveth_rx_mss_helper(skb, 1448, 1));
+	KUNIT_EXPECT_EQ(test, 0, skb_shinfo(skb)->gso_size);
+
+	skb = ibmveth_test_tcp_skb(test, false, 2896);
+	((struct tcphdr *)(skb->data + sizeof(*iph)))->doff = 4;
+	KUNIT_EXPECT_FALSE(test, ibmveth_rx_mss_helper(skb, 1448, 1));
+
+	skb = ibmveth_test_tcp_skb(test, false, 2896);
+	((struct iphdr *)skb->data)->tot_len = htons(skb->len + 1);
+	KUNIT_EXPECT_FALSE(test, ibmveth_rx_mss_helper(skb, 1448, 1));
+
+	/* refused: a fragment past the first, its payload left alone */
+	skb = ibmveth_test_tcp_skb(test, false, 2896);
+	((struct iphdr *)skb->data)->frag_off = htons(185);
+	tcph = (struct tcphdr *)(skb->data + sizeof(*iph));
+	tcph->check = (__force __sum16)htons(1448);
+	KUNIT_EXPECT_FALSE(test, ibmveth_rx_mss_helper(skb, 0, 0));
+	KUNIT_EXPECT_EQ(test, 0, skb_shinfo(skb)->gso_size);
+	KUNIT_EXPECT_EQ(test, 1448, ntohs((__force __be16)tcph->check));
+
+	/* refused: only Ethernet padding past the TCP header */
+	skb = ibmveth_test_tcp_skb(test, false, 6);
+	((struct iphdr *)skb->data)->tot_len = htons(40);
+	KUNIT_EXPECT_FALSE(test, ibmveth_rx_mss_helper(skb, 1448, 1));
+	KUNIT_EXPECT_EQ(test, 0, skb_shinfo(skb)->gso_size);
+
+	skb = ibmveth_test_tcp_skb(test, true, 2896);
+	((struct ipv6hdr *)skb->data)->payload_len = 0;
+	KUNIT_EXPECT_FALSE(test, ibmveth_rx_mss_helper(skb, 1448, 1));
+
+	/* not TCP: accepted and left alone */
+	skb = ibmveth_test_tcp_skb(test, false, 2896);
+	((struct iphdr *)skb->data)->protocol = IPPROTO_UDP;
+	KUNIT_EXPECT_TRUE(test, ibmveth_rx_mss_helper(skb, 1448, 1));
+	KUNIT_EXPECT_EQ(test, 0, skb_shinfo(skb)->gso_size);
+}
+
+/**
+ * ibmveth_rx_csum_helper_test - unit test for ibmveth_rx_csum_helper
+ * @test: pointer to kunit structure
+ *
+ * A large send IPv4 header checksum of 0xffff is rebuilt. Headers that
+ * do not fit the frame, an IPv4 ihl below 5, or a TCP fragment, clear
+ * CHECKSUM_UNNECESSARY instead of being read.
+ *
+ * Return: void
+ */
+static void ibmveth_rx_csum_helper_test(struct kunit *test)
+{
+	struct sk_buff *skb;
+	struct iphdr *iph;
+
+	skb = ibmveth_test_tcp_skb(test, false, 100);
+	iph = (struct iphdr *)skb->data;
+	iph->check = (__force __sum16)0xffff;
+	((struct tcphdr *)(skb->data + sizeof(*iph)))->check = (__force __sum16)htons(1);
+	skb->ip_summed = CHECKSUM_UNNECESSARY;
+	ibmveth_rx_csum_helper(skb, NULL);
+	KUNIT_EXPECT_EQ(test, 0,
+			(__force u16)ip_fast_csum((unsigned char *)iph, iph->ihl));
+	KUNIT_EXPECT_EQ(test, CHECKSUM_UNNECESSARY, (int)skb->ip_summed);
+
+	skb = ibmveth_test_tcp_skb(test, false, 100);
+	iph = (struct iphdr *)skb->data;
+	iph->ihl = 0;
+	iph->check = (__force __sum16)0xffff;
+	skb->ip_summed = CHECKSUM_UNNECESSARY;
+	ibmveth_rx_csum_helper(skb, NULL);
+	KUNIT_EXPECT_EQ(test, CHECKSUM_NONE, (int)skb->ip_summed);
+	KUNIT_EXPECT_EQ(test, 0xffff, (__force u16)iph->check);
+
+	/* IPv4 options past the frame; UDP, so no TCP check follows */
+	skb = ibmveth_test_tcp_skb(test, false, 0);
+	iph = (struct iphdr *)skb->data;
+	iph->protocol = IPPROTO_UDP;
+	iph->ihl = 15;
+	iph->check = (__force __sum16)0xffff;
+	skb->ip_summed = CHECKSUM_UNNECESSARY;
+	ibmveth_rx_csum_helper(skb, NULL);
+	KUNIT_EXPECT_EQ(test, CHECKSUM_NONE, (int)skb->ip_summed);
+
+	/* a TCP fragment past the first: header and payload left alone */
+	skb = ibmveth_test_tcp_skb(test, false, 100);
+	iph = (struct iphdr *)skb->data;
+	iph->frag_off = htons(185);
+	iph->check = (__force __sum16)0xffff;
+	skb->ip_summed = CHECKSUM_UNNECESSARY;
+	ibmveth_rx_csum_helper(skb, NULL);
+	KUNIT_EXPECT_EQ(test, CHECKSUM_NONE, (int)skb->ip_summed);
+	KUNIT_EXPECT_EQ(test, 0xffff, (__force u16)iph->check);
+	KUNIT_EXPECT_EQ(test, 0,
+			(__force u16)((struct tcphdr *)(skb->data +
+							sizeof(*iph)))->check);
+
+	/* TCP header past the frame */
+	skb = ibmveth_test_tcp_skb(test, false, 0);
+	skb_trim(skb, sizeof(struct iphdr));
+	skb->ip_summed = CHECKSUM_UNNECESSARY;
+	ibmveth_rx_csum_helper(skb, NULL);
+	KUNIT_EXPECT_EQ(test, CHECKSUM_NONE, (int)skb->ip_summed);
+
+	/* IPv6 header past the frame; UDP, so no TCP check follows */
+	skb = ibmveth_test_tcp_skb(test, true, 0);
+	((struct ipv6hdr *)skb->data)->nexthdr = IPPROTO_UDP;
+	skb_trim(skb, sizeof(struct ipv6hdr) - 1);
+	skb->ip_summed = CHECKSUM_UNNECESSARY;
+	ibmveth_rx_csum_helper(skb, NULL);
+	KUNIT_EXPECT_EQ(test, CHECKSUM_NONE, (int)skb->ip_summed);
+}
+
 static struct kunit_case ibmveth_test_cases[] = {
 	KUNIT_CASE(ibmveth_remove_buffer_from_pool_test),
 	KUNIT_CASE(ibmveth_rxq_get_buffer_test),
 	KUNIT_CASE(ibmveth_rxq_harvest_buffer_test),
+	KUNIT_CASE(ibmveth_rx_mss_helper_test),
+	KUNIT_CASE(ibmveth_rx_csum_helper_test),
 	{}
 };
 
-- 
2.50.1 (Apple Git-155)

