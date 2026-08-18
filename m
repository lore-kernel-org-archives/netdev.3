Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6F6360ED0
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 15:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787065695; cv=none; b=LlH4GJFgrMm6Gu4mBOZOSbOnzhZ6P+iKFVLV0bTZNKU6mBOHoDylZ4b/SM5DtIzjYQJuvJk7KQnP8vLhsYTeCTdwANjHVv/FgJohzCU58vwvt8JzslbG10GwsDlXm/5u4cON5VrxvVsAvDKDnT8kkZZ8T+XPq4r1FxSoL2AUWzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787065695; c=relaxed/simple;
	bh=t+JIdzgNDB+wXkLvzEVmEGCGBEGugUb504qbpH6q2Sk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gpcKVkXHCBuGweK1nuyN0VdbOSfL6DiG8AgYIEL15wg3SSnV2cBsuGiPmuKYTyTZVRrXmfSYmTGEPO124jYwlMT/3IhGWxoq0SP41yZWbSYF2xOm+01AQkbsZoUEPZ5ZejciHGrUmpys8N68PdoimleeoU+/GMvI0ptQThC+8xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=MEk+k+/h; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="MEk+k+/h"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-47fd4531020so2873057f8f.3
        for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 08:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1787065691; x=1787670491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fsJTTJLMftxjOk/8vHlxHx3gsMZIHruqB4aZN98cgQg=;
        b=MEk+k+/hK8l+x1/JPcxqBAqRmetqLvfaFga9BQY8j2m8ZOrQBsRJq71T/uQtesUoC9
         C6gQMjtDusYm2lTdNfKlNQ7FYau0ejf0QdhxT167B2Re5VfWDEiSk09pWamJnDFCsCjC
         +7eZEuVFA5bKV6FrCQitfziWupbr3PA2pFIpTKw851FIdCiFOJ7PTeGccIEtgMRNKh15
         3XrSAdSllnlhnWwB6E0QCwKldzEGP4FdgZsgowbPjkMO/QhjsdNCdCiCgZPHs0PEmN9Q
         dK2ndPkotQkGggAgoz8W4Byfvo53b10ikEdaMSyAHNAU0cKlQUxTHuRZYJAXYkW8ooXl
         SiUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787065691; x=1787670491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fsJTTJLMftxjOk/8vHlxHx3gsMZIHruqB4aZN98cgQg=;
        b=lu00jzGGKQjcNiLVK/2dbNWCFY/kLJs3RVq/579jdB4EpYolac4DkRcO0vvLI6jY/r
         oAS66aNTCHk18aKM7ci0oNXmhmT0bsCz/sL/TlD9up+lordU+gVEygUNVldavarKif3Y
         3rtdRi/AoitaH7VqsSStmI/YJyJQ8hnzPZsxjAyJl0+cSm/lqp80xQK4B2vz95nYR37P
         0GIC9j84KHWAxffkivbtNw/YQF07u3vkRRbGntxdgTmHEISBB60dvX+RAIvLZo50Fpzg
         8ujH2wbPEGFbNLA5/M3+VTlNQkc4iOaNpkpBrnQrvREe0Tmysbev/360c4fFvmH40J7T
         +fwA==
X-Gm-Message-State: AOJu0Yxg+vNjybP/E0HCTNCl5bHmCBsvR5Ud7MX9vXlwiCso/LtNAl7D
	z1QZyBaowmfzE+11/FiZ1zpAvSPhr0gQ8XUMNiBqapI//p+SE5UQkQognzM0N4BlkxFBSeeGE9o
	/hyYc
X-Gm-Gg: AR+sD10d6On+vv381+2j8EAhDtRnJRsNynZakAQtD8cu2gwP+fTDFq8d5hDVhhKcphw
	YIxK7gGg9Mjx2+dSeax0vhM08PD6mUvpuw76oMbaMfgcv1vTUQIizC3aQmu62Zm1yd0juoLRw8G
	EeeGztrexaluFYQ51XuJmOpMB+AjOvPoxk0aYdHrCfO1VwbY9VAmeC0DnjeH022S12lzvlCkYRr
	e+RiI4W+cvtTlhI/M/Ehy3WIcBb1F3rVdJp2XCQJVoMqw7RqTgxbo3FxfBTi1xMZaIV6IVOSEhM
	bQ2/jYZtAhLOQrdyis2+rQRDyN8WembhUbMSyGXqSTrdpv1DKVDVtsl8FhZq0kHBodi+h/HETgR
	yQrS8iaJgL/8F3yiA4r3jyf71SrSuMOtZcchuGmURkMRjesOygd5T5++2FRE7BR8WzKtmA6ShEh
	N+0guWOwsN8ZX5s/OjbIXeao9EQ4G6sCWpCGwE81s/7eyZV+fXIxiITzomDKQoigDcpyeQD10cD
	kr5j1zfeG0=
X-Received: by 2002:adf:fd0a:0:b0:481:51b7:290b with SMTP id ffacd0b85a97d-481607630fdmr42455679f8f.14.1787065691040;
        Tue, 18 Aug 2026 08:08:11 -0700 (PDT)
Received: from localhost (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-482a5a3157fsm12203428f8f.3.2026.08.18.08.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 08:08:10 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	roopa@nvidia.com,
	bridge@lists.linux.dev,
	andrew+netdev@lunn.ch,
	dlstevens@us.ibm.com,
	amwang@redhat.com,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net v2 2/2] vxlan: fix reading neigh ha
Date: Tue, 18 Aug 2026 18:07:56 +0300
Message-ID: <20260818150756.890025-3-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260818150756.890025-1-razor@blackwall.org>
References: <20260818150756.890025-1-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently arp/neigh_reduce read neigh ha directly which can lead to
partial reads while the neigh is being updated. Use neigh_ha_snapshot to
take a stable snapshot of the address similar to route_shortcircuit which
already does the right thing.

Fixes: e4f67addf158 ("add DOVE extensions for VXLAN")
Fixes: f564f45c4518 ("vxlan: add ipv6 proxy support")
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
v2: - use ETH_ALEN instead of MAX_ADDR_LEN, the bridge devices all use
      ETH_ALEN and vxlan allows arp/nd reduce only when not in raw/gpe
      so it also always uses ETH_ALEN
    - align ha to 2 bytes because ether_addr_copy() expects it (Sashiko)

 drivers/net/vxlan/vxlan_core.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 824144bb7774..a94168f7a18e 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1881,6 +1881,7 @@ static int arp_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni)
 
 	if (n) {
 		struct vxlan_rdst *rdst = NULL;
+		u8 ha[ETH_ALEN] __aligned(2);
 		struct vxlan_fdb *f;
 		struct sk_buff	*reply;
 
@@ -1889,8 +1890,10 @@ static int arp_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni)
 			goto out;
 		}
 
+		neigh_ha_snapshot(ha, n, n->dev);
+
 		rcu_read_lock();
-		f = vxlan_find_mac_tx(vxlan, n->ha, vni);
+		f = vxlan_find_mac_tx(vxlan, ha, vni);
 		if (f)
 			rdst = first_remote_rcu(f);
 		if (rdst && vxlan_addr_any(&rdst->remote_ip)) {
@@ -1902,7 +1905,7 @@ static int arp_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni)
 		rcu_read_unlock();
 
 		reply = arp_create(ARPOP_REPLY, ETH_P_ARP, sip, dev, tip, sha,
-				n->ha, sha);
+				   ha, sha);
 
 		neigh_release(n);
 
@@ -1935,7 +1938,8 @@ static int arp_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni)
 
 #if IS_ENABLED(CONFIG_IPV6)
 static struct sk_buff *vxlan_na_create(struct sk_buff *request,
-	struct neighbour *n, bool isrouter)
+				       struct neighbour *n, u8 *ha,
+				       bool isrouter)
 {
 	struct net_device *dev = request->dev;
 	struct sk_buff *reply;
@@ -1981,7 +1985,7 @@ static struct sk_buff *vxlan_na_create(struct sk_buff *request,
 
 	/* Ethernet header */
 	ether_addr_copy(eth_hdr(reply)->h_dest, daddr);
-	ether_addr_copy(eth_hdr(reply)->h_source, n->ha);
+	ether_addr_copy(eth_hdr(reply)->h_source, ha);
 	eth_hdr(reply)->h_proto = htons(ETH_P_IPV6);
 	reply->protocol = htons(ETH_P_IPV6);
 
@@ -2010,7 +2014,7 @@ static struct sk_buff *vxlan_na_create(struct sk_buff *request,
 	na->icmph.icmp6_override = 1;
 	na->icmph.icmp6_solicited = 1;
 	na->target = ns->target;
-	ether_addr_copy(&na->opt[2], n->ha);
+	ether_addr_copy(&na->opt[2], ha);
 	na->opt[0] = ND_OPT_TARGET_LL_ADDR;
 	na->opt[1] = na_olen >> 3;
 
@@ -2051,6 +2055,7 @@ static int neigh_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni)
 
 	if (n) {
 		struct vxlan_rdst *rdst = NULL;
+		u8 ha[ETH_ALEN] __aligned(2);
 		struct vxlan_fdb *f;
 		struct sk_buff *reply;
 
@@ -2059,7 +2064,8 @@ static int neigh_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni)
 			goto out;
 		}
 
-		f = vxlan_find_mac_tx(vxlan, n->ha, vni);
+		neigh_ha_snapshot(ha, n, n->dev);
+		f = vxlan_find_mac_tx(vxlan, ha, vni);
 		if (f)
 			rdst = first_remote_rcu(f);
 		if (rdst && vxlan_addr_any(&rdst->remote_ip)) {
@@ -2068,7 +2074,7 @@ static int neigh_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni)
 			goto out;
 		}
 
-		reply = vxlan_na_create(skb, n,
+		reply = vxlan_na_create(skb, n, ha,
 					!!(f ? f->flags & NTF_ROUTER : 0));
 
 		neigh_release(n);
-- 
2.47.3

