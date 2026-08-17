Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD62543B4B5
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 14:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786977399; cv=none; b=kon2BlhzVut1aqyt5Up2GyBc0yEJeZGkXh1vTznWYd9JH48UlvIBr/4xZZR+c0pnm6tBYf16JWeXdsyujPVo5mpkBFog1hCAj5/iojE323EByoM7JZXzx1fauxEHybKE5CE2fZaEBphSaioHRmZnQiyxjzhLsYWmnfo184Rp8tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786977399; c=relaxed/simple;
	bh=sPFAD+uo8IMND4QzghXVp2u1uXHoKLiKjili6fsUfSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M4BeZlZI9Hb6DaxPb4wMaCiuNZoQP5QN8EqGomsdrEoqIE3QaF/M+SJRgOZFjMyGymdyM63DhsWaXy52ySwbf3BY8SbU/l9WZ4CyWlwqGYTDAtgI+6M9Q8iJs/VC5A+ubWB4uRzL4oHUPvofgvQa/gGayUBwoMeLp27fHPmZUvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=g+qcwOWg; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="g+qcwOWg"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47fd66a094eso1323944f8f.3
        for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 07:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1786977396; x=1787582196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g9EuLf3DhLkqiTmLxGnPjFranl+WvLWJf72aAVoAZP0=;
        b=g+qcwOWgOWHHpczW8n7s8R7HPDpOZYcblVfaqsEZVKYkfdR/js4In9Bis5fjXVPeQl
         OnrvPd4E6vxNP0pAlK8zEFhYBsj/PEoG/3z9eRFIiTAr+tifOq0NLIS9ahPbCT4OqZ08
         Yg8zmsXFk6jomiz7K2TI+TvcgdDWZGhzUB9RScfTxLbR5Vv363W1N3ltVT9Ujd2Aarg7
         uK4hUWTCWM6jfST0J4Gdic4NP0Drta9CTQL597x747v//vlfL6hGYs6nx1abGp3KAYrJ
         TTXVuVb/Dr9E7xYZgmwUEFPTYW5YzRnWM5G3tzmwSo6yP2BKynI0NyPAfUOphajH61CW
         jijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786977396; x=1787582196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=g9EuLf3DhLkqiTmLxGnPjFranl+WvLWJf72aAVoAZP0=;
        b=nnDLuUdepf2i8Vv9uII20yB0I/lt7l+hD2fcMVav9DotD/HkRvnh9awfeuFlO48aTs
         5fRCje+5UQBaD5W/gG4cPtEuV1jiaqtjQR5YU58YR8cE0ABoTHWtK7sCvUcTdzXUJTRI
         ENVmxUaEIgdLCY0e2wTvGUIaMFXWLDkwe5SBQeDeiGvoUNz+Fh6YDML9IUOoCa8OAe6/
         Y7GQ0KlI5jBdZBijwwHk8BuxXg0APOCqvImBGgl/Hp3W8eYDB2w0BcD/68kULk4Hsyyg
         vhZQJ2l1pLTcDHvfry5S5QZr768Hp2H8VBCig5w5VXlKlELdhuL57M9wSr/B6D3x2yDZ
         U4YQ==
X-Gm-Message-State: AOJu0YxpBipvjr7nsB7fqoLa9pqrRxJ3UCwlJWB/q435CleR33vnIVoG
	yOfI4YWZOX0tkso6WC9wHDDxqFobUS0jKXImCKk1fu35qi/cMinjqB0fJ9jjOAqrY7r4Tv/s+zr
	J3crZ
X-Gm-Gg: AR+sD13xUQRQojgE2OqzIBgTIDaCagB07nUBrqNLFy6HVYILzHdV/5TfT8OzCHaJTdQ
	aiNwZSZeKwWCnEuZcEzMYU8p/jBB66yGov20z17yfZx67s2vpief7URv8QF08tsAJiNdlPRdJIr
	6P+OuUut7Eg/LcLZjCxreMnDj8YsR61Q+V5hIiYff7CIXAK60p6AYqleRWl5rDLb2oIqn0pIUJa
	lNNJdM9nrTgDEFpTChxWurkKk2RJHnU2EUm8euAGfH48vYNWTneRp2kR+Jqxlq2ZAbK6Uuczr5A
	cg5qNldCiudOHYzfDFO7VvUyaV3gsAJNzxhGRhEphu1TOU6U629rsrgI8t9fbVj9Ssdd1K705Jf
	ShAFtEv6w44UirSkybAxOZbZmGzoLxf2M67pZGOnWRuVxOF3Lq0lvIjXH4cB5NbknRKvo3PgP8C
	cD+oGqTqE2JhO7RgeZ8m+PZhTW10l79OOYsyL+wqyE6I7P5XMRDKDEWmcwxCLfl8G9Nt/n8HLgK
	1khxSevUos=
X-Received: by 2002:a05:6000:288d:b0:47f:9de0:c27f with SMTP id ffacd0b85a97d-482a8fe9b80mr1239936f8f.1.1786977396119;
        Mon, 17 Aug 2026 07:36:36 -0700 (PDT)
Received: from localhost (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-482a5b783c6sm4599175f8f.31.2026.08.17.07.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 07:36:35 -0700 (PDT)
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
Subject: [PATCH net 2/2] vxlan: fix reading neigh ha
Date: Mon, 17 Aug 2026 17:36:13 +0300
Message-ID: <20260817143613.685769-3-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260817143613.685769-1-razor@blackwall.org>
References: <20260817143613.685769-1-razor@blackwall.org>
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
 drivers/net/vxlan/vxlan_core.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 824144bb7774..2e0d25fe607d 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1883,14 +1883,17 @@ static int arp_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni)
 		struct vxlan_rdst *rdst = NULL;
 		struct vxlan_fdb *f;
 		struct sk_buff	*reply;
+		u8 ha[MAX_ADDR_LEN];
 
 		if (!(READ_ONCE(n->nud_state) & NUD_CONNECTED)) {
 			neigh_release(n);
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
 
@@ -2053,13 +2057,15 @@ static int neigh_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni)
 		struct vxlan_rdst *rdst = NULL;
 		struct vxlan_fdb *f;
 		struct sk_buff *reply;
+		u8 ha[MAX_ADDR_LEN];
 
 		if (!(READ_ONCE(n->nud_state) & NUD_CONNECTED)) {
 			neigh_release(n);
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

