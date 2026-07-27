Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194733F8EAB
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 22:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785193077; cv=none; b=szLg7rMNA8EHQAAeyCsxMrfjBvdyTbo4jy1BtlURfe0QYXfoYxbmhHqM73uRuWrxo6feXf46gEze+nY/Rno2AM70xHm/W4dtTNuY0VVvy76pggzvQLf5+T4pjXTFSf8AejzwoeLYnHe4XJCerQxSMAK4gEV37kgDpQO9U21YeDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785193077; c=relaxed/simple;
	bh=kzyWPv/hp3S8PU5Rn9lNwBnknhfersTVkI2IzpEKj1E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Yg6+NyGytTTrFpDZrR15UrNCsj7RZz5yVHoH1gaQ2tkdI6Q8X7kJsvbrdBCdZ/zt1j9nv2eDD+9bUXNBcmxfiRufJi1ynoLbNuWSH6QA4tWQobiQE5M0tYZLOWc93zLhYjJdAzTKUSnEz+fNhlb/2H/aqec/4fRns16NAYHpdng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X1jRVBnT; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X1jRVBnT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785193076; x=1816729076;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kzyWPv/hp3S8PU5Rn9lNwBnknhfersTVkI2IzpEKj1E=;
  b=X1jRVBnTIsNga22M37zbti161SS4eARslT6dUEYynzA/LR7WNhWdsdJl
   kpglsX6REp7ljYqaNkg/TgwDgfDazz1OfZ0ycM17vj35GKGW9PLuETN2W
   6cCCkoRDXiqatTiX92c/QgaTpejZf0a7uFgDetnozse7LhvlzNlgDe0Mh
   yozUU2yjE8+mjFZq1Xfr1wfPhO1ZDK6ZDPAg8GGUZ0gM6CgstDxjjKoRC
   1sfR3IqNQtDxkb7wnWrSodU0Fq7gRqOcgv/Zfnffr9zhMrxD+R2jc5RVv
   kIq8OVW1drdQ4ckITm6Z0fIjXauuMGEQb6ftfoih4aPgRBmbfUxunyR54
   A==;
X-CSE-ConnectionGUID: 5MfboR4bQHakBDeHiQJjuA==
X-CSE-MsgGUID: Cbl3Zn+1TsiQR7SD6vTU/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="84748870"
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; 
   d="scan'208";a="84748870"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 15:57:55 -0700
X-CSE-ConnectionGUID: uMBtnQtwTD+sp4H48NcDDg==
X-CSE-MsgGUID: pVfpCCTWQFCcUIhAVVwrJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; 
   d="scan'208";a="263027552"
Received: from dcskidmo-m40.jf.intel.com ([10.166.241.14])
  by orviesa003.jf.intel.com with ESMTP; 27 Jul 2026 15:57:55 -0700
From: Joshua Hay <joshua.a.hay@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [Intel-wired-lan][PATCH iwl-net] idpf: account for VLAN header when parsing RSC packet header
Date: Mon, 27 Jul 2026 16:08:48 -0700
Message-Id: <20260727230848.1557452-1-joshua.a.hay@intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While parsing the header of a Receive Side Coalesced (RSC) packet, check
if a VLAN tag is present and adjust the header parsing accordingly.
Otherwise, Rx TCP traffic is completely broken for any VLAN interface
whose underlying interface has RSC (rx-gro-hw) enabled.

We only need to worry about one VLAN header since Rx packets with
multiple VLAN headers are not candidates for RSC.

Fixes: 3a8845af66edb ("idpf: add RX splitq napi poll support")
Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
Reviewed-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index c724d429a7aa..70553f64f770 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -3299,6 +3299,7 @@ static int idpf_rx_rsc(struct idpf_rx_queue *rxq, struct sk_buff *skb,
 		       struct libeth_rx_pt decoded)
 {
 	u16 rsc_segments, rsc_seg_len;
+	u16 l3_start = 0;
 	bool ipv4, ipv6;
 	int len;
 
@@ -3321,7 +3322,10 @@ static int idpf_rx_rsc(struct idpf_rx_queue *rxq, struct sk_buff *skb,
 	NAPI_GRO_CB(skb)->count = rsc_segments;
 	skb_shinfo(skb)->gso_size = rsc_seg_len;
 
-	skb_reset_network_header(skb);
+	if (unlikely(eth_type_vlan(skb->protocol)))
+		l3_start = VLAN_HLEN;
+
+	skb_set_network_header(skb, l3_start);
 
 	if (ipv4) {
 		struct iphdr *ipv4h = ip_hdr(skb);
@@ -3329,7 +3333,7 @@ static int idpf_rx_rsc(struct idpf_rx_queue *rxq, struct sk_buff *skb,
 		skb_shinfo(skb)->gso_type = SKB_GSO_TCPV4;
 
 		/* Reset and set transport header offset in skb */
-		skb_set_transport_header(skb, sizeof(struct iphdr));
+		skb_set_transport_header(skb, l3_start + sizeof(struct iphdr));
 		len = skb->len - skb_transport_offset(skb);
 
 		/* Compute the TCP pseudo header checksum*/
@@ -3339,7 +3343,7 @@ static int idpf_rx_rsc(struct idpf_rx_queue *rxq, struct sk_buff *skb,
 		struct ipv6hdr *ipv6h = ipv6_hdr(skb);
 
 		skb_shinfo(skb)->gso_type = SKB_GSO_TCPV6;
-		skb_set_transport_header(skb, sizeof(struct ipv6hdr));
+		skb_set_transport_header(skb, l3_start + sizeof(struct ipv6hdr));
 		len = skb->len - skb_transport_offset(skb);
 		tcp_hdr(skb)->check =
 			~tcp_v6_check(len, &ipv6h->saddr, &ipv6h->daddr, 0);
-- 
2.39.2

