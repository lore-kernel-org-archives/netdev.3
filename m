Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE4252FE4D
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 21:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788903916; cv=none; b=MG/ImxDRmvF/wMppGHWszBSSgoZ/diBFaZ9fUApaH0kXw8o8FBXCfpX8PsPCypZdf06Vlc0cVB5ag6ViJt/yttbSakdCjLWHUNYCYeY42qbft60Q3sbc7Yhg4PSVn9GHJE7L1ofNNzUM5B57ec2cCO3qowZg7ChVf4f9DpxPwgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788903916; c=relaxed/simple;
	bh=IJKoGRmI/1PJ2oPeAQuFfw/3bUr0QU85KU5pe48U6BA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oq1eD0osqUNXjUhbm6L2mt9ibTeDV2dTjl2SkFdlOD9Gpw9RYXkrFcqHxAMaKUyuFJVbawOPEUwY4mQl83AaI+2/x5GK97Qc6pBgqPLuW8LN5lStml9d1jy7oLaRFgQZV17id7kfnglLlrIgGG6EjWMF0O1zg0LQKpHItI6KydI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FEFa2uWz; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FEFa2uWz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788903914; x=1820439914;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IJKoGRmI/1PJ2oPeAQuFfw/3bUr0QU85KU5pe48U6BA=;
  b=FEFa2uWzbLxOSf6jEplLxLq9Pb5qqUNvZ3fKKIacMHCr54fi3h/yc6vD
   5PR8EYiv2q4OIvwFcFoKpS8Kx1bj7S1nndSwerJnpXU9xlgmJhGBMfs4E
   5MnqRaCkHZr8o2OUsQTh5FTVvV4AlM1UtF+h1s/xQnqiyriOc0XJKc3Kt
   0WtvK4cLVcH6BFeL1waEVmrOw/i90akewar5VSj0LI3MYSkbsKTsW2GPc
   l6WwuhhjvRXbDtPb6ZmqP6wh2LzLQcvPnGt+XJNE5m96OBsa5sapnMOLL
   kiigLGtnQC7moKv4ZaeB5ErlXU7zOuewKTH7MnHuS0sfnafUuJa4rI3gM
   Q==;
X-CSE-ConnectionGUID: gqXCGJjpRJ6r3TW3lRRD+Q==
X-CSE-MsgGUID: +mz92zVQQJiOBQP+U/pPAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="106836235"
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; 
   d="scan'208";a="106836235"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 14:45:09 -0700
X-CSE-ConnectionGUID: 2YAMqKuKRqC4hWLOwZedXg==
X-CSE-MsgGUID: +qcK5cOARiiDrO2I/UJ6gQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; 
   d="scan'208";a="269782515"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa010.jf.intel.com with ESMTP; 08 Sep 2026 14:45:08 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Joshua Hay <joshua.a.hay@intel.com>,
	anthony.l.nguyen@intel.com,
	ae878000@gmail.com,
	mhun512@gmail.com,
	sridhar.samudrala@intel.com,
	milena.olech@intel.com,
	vadim.fedorenko@linux.dev,
	willemb@google.com,
	jacob.e.keller@intel.com,
	przemyslaw.kitszel@intel.com,
	jbrandeb@kernel.org,
	Emil Tantilov <emil.s.tantilov@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Samuel Salin <Samuel.salin@intel.com>
Subject: [PATCH net 3/5] idpf: account for VLAN header when parsing RSC packet header
Date: Tue,  8 Sep 2026 14:44:58 -0700
Message-ID: <20260908214502.528440-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260908214502.528440-1-anthony.l.nguyen@intel.com>
References: <20260908214502.528440-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joshua Hay <joshua.a.hay@intel.com>

While parsing the header of a Receive Side Coalesced (RSC) packet, check
if a VLAN tag is present and adjust the header parsing accordingly.
Otherwise, Rx TCP traffic is completely broken for any VLAN interface
whose underlying interface has RSC (rx-gro-hw) enabled.

We only need to worry about one VLAN header since Rx packets with
multiple VLAN headers are not candidates for RSC.

Fixes: 3a8845af66edb ("idpf: add RX splitq napi poll support")
Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
Reviewed-by: Emil Tantilov <emil.s.tantilov@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 9ba9c2952d78..4311ffa30bb1 100644
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
2.47.1

