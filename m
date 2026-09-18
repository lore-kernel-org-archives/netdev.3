Received: from mail-wr2-f27.google.com (mail-wr2-f27.google.com [74.125.225.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07005013D1
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 15:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789745399; cv=none; b=OhyT2Q94mq9abgoot/n6D1blsdRQKvGWOwWV2KTyxYsOrELx89NQrT19aQEnzYldS80mj24MXwCfiPuIUXfrau5D0P6n5cb4L7trz/8R5LllnvGc1ZESGLMfiEkHx0eF/whVSq1zUcmp9D5B1CDTFQgMuL2hRT52F4mAXKut49c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789745399; c=relaxed/simple;
	bh=2EVShEmI/0rJNMpwjpQOmFmP5a9kka8l4gxp8+ZaUpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KgIIyS8vFfkFx6ynt+m55ot8NuyCO/7lKgidCqQWXDmLpHktXkmPz0EZSPw8P5P4aYPeaBRr8zSSAwMl6QYIh+RCmbgiIDxy0xrDVykQzz/xM2pubmBkRu0yvVnOGno30LC6454ltui7kcgdETQcTNDS1l2FKe+H5M+OzXE8QWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=TWaTLgeC; arc=none smtp.client-ip=74.125.225.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="TWaTLgeC"
Received: by mail-wr2-f27.google.com with SMTP id ffacd0b85a97d-4843796e373so507217f8f.1
        for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 08:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1789745396; x=1790350196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=96oAyfpjzN0+/Y81mIOKiKNvJ2eV4pXY44RiiIB6xww=;
        b=TWaTLgeCVAEGRDu/eU7k+djecp98OJT0wfxTXZgvzhH22CSvCDasOd+lseXY7ReLCJ
         6efwDoS28W4OgebNBU9ozy/UwNHSIOrM3v5zkzIe0aFEv6sf4yN6/HxHSWPrWGClwve6
         rLYioBtlfO5N9Xs/5PaAeV2CMATBX0DobK3tCUwBtblhX/jdomYoDePAxm6UK/8rO0eS
         2XQnPIa64c1aZa23Tq6lFZLghxtpwltIr2XDd8tIGxzY+aT0AM95WQ8H7febKNpRY7RB
         Kua9tdHmnPh7CE2+tN8cQRlLZ5PbWDq6Xcxy/KVAsJSToO7xlttfooJOgmDLncoA5qn8
         aD+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789745396; x=1790350196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=96oAyfpjzN0+/Y81mIOKiKNvJ2eV4pXY44RiiIB6xww=;
        b=dFkFjpKIswTvdIgBdH99ELx54pfHGjwFTwY2SAcfWJrShw1exmM1agtkMyj6c5UZmM
         fEV96w4rcpsYlv/THatExp7iICzzbpbp5RVYU9rrb96DFjpZTYbM28l/PXfoxMxnoMoG
         Lf14i36HVOsVeIKi3doNYzhXDzWujKQ4Qt+hdzt443ed7ekUDAeXBjXqEHm542W4ViDd
         H0dn6bZqNy2KNnFppxxrEZ90D2UWYQAYo6KosOnEVpk8Bjw26WGx8F2X/ZOwSYkBivzY
         M/5Os/p7UlvZiI2rinXlyl6LmEz0rl3uPsTRDpxGxTX52kwizFhzWZxpFCiAHQLzoJne
         MVtQ==
X-Gm-Message-State: AFuF++mEfsO9dvdGMoVhj1V29xuHbjufo93QlRQPC/rJhDADKed3SjKu
	/VxcHhADil6YUIqw7xNSi6J+5onLA6PymkFGRgRD3UKnKeJUHfjVEklOC8BeL8IG6sNQT4sv7cH
	JY1Hc
X-Gm-Gg: AYBFou0jhFu2IFg9jCWNF5O6LtB/fMvX4u88KNqRgH/q1sfcFsWyidNbJJtI7wtKu4M
	nKeCPAW6MGG2Zaul7dd1XV4j78RR/eVs0oY4gN+/ALXHNM+BOYb2MFiLGvCKhuWpDr863mAU7H7
	HwbYNKhwBKAtbpHWdfl1/aiEl7hD+3/SS5vOksD/7hex5wdkE2CLa2sGqJ8bo1ycyZStODjqfoo
	2jv+Ep43MO5SLyVCs8Yoie0yGFGRq4n9lVci+0cHtMaxn27dMeXAU3tpD69ecQ3kZZV9pK9Jvnz
	McRnCvwm5PslvkkLeXv3hRcEw7hnuiHQ07xU5gxk5X+Th8YZxBQ94HEFh3r9F8Q2uHY9+ouinjG
	mipxJdZ7L6/WRU6nv4NlsPQMN4mPPmmAlcXqwYPZz1/MnepkKl+LQugb8q4K2Y1w1QKzDVfUW3F
	cwWz91C2cXzqewEksyLy/cNp74Lm+KGl0wPJn9Dr258qdSIoFqyNij4DMDf2umaXpyfIs9JSCrI
	WPxycD2RutFQqqaDjaP2g==
X-Received: by 2002:a05:6000:1acb:b0:487:767:b301 with SMTP id ffacd0b85a97d-4871e387052mr4220968f8f.57.1789745395848;
        Fri, 18 Sep 2026 08:29:55 -0700 (PDT)
Received: from localhost (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4871ff5551fsm4656235f8f.15.2026.09.18.08.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 08:29:55 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	bridge@lists.linux.dev,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net-next 2/9] net: bridge: factor out port flooding
Date: Fri, 18 Sep 2026 18:29:43 +0300
Message-ID: <20260918152950.1938259-3-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260918152950.1938259-1-razor@blackwall.org>
References: <20260918152950.1938259-1-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Factor out port flooding code into its own helper, it will be used by later
changes to flood to specific port VLANs. No functional changes intended.

Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_forward.c | 77 +++++++++++++++++++++++------------------
 1 file changed, 43 insertions(+), 34 deletions(-)

diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
index 31d54125b441..a696c6c128e3 100644
--- a/net/bridge/br_forward.c
+++ b/net/bridge/br_forward.c
@@ -219,6 +219,48 @@ static void br_flood_finish(struct net_bridge_port *prev, struct sk_buff *skb,
 		__br_forward(prev, skb, local_orig);
 }
 
+static void br_flood_port(struct net_bridge_port **prev,
+			  struct net_bridge_port *p, struct sk_buff *skb,
+			  enum br_pkt_type pkt_type, bool local_orig, u16 vid)
+{
+	/* Do not flood unicast traffic to ports that turn it off, nor
+	 * other traffic if flood off, except for traffic we originate
+	 */
+	switch (pkt_type) {
+	case BR_PKT_UNICAST:
+		if (!test_bit(BR_FLOOD_BIT, &p->flags))
+			return;
+		break;
+	case BR_PKT_MULTICAST:
+		if (!test_bit(BR_MCAST_FLOOD_BIT, &p->flags) &&
+		    skb->dev != p->br->dev)
+			return;
+		break;
+	case BR_PKT_BROADCAST:
+		if (!test_bit(BR_BCAST_FLOOD_BIT, &p->flags) &&
+		    skb->dev != p->br->dev)
+			return;
+		break;
+	}
+
+	/* Do not flood to ports that enable proxy ARP */
+	if (test_bit(BR_PROXYARP_BIT, &p->flags))
+		return;
+	if (BR_INPUT_SKB_CB(skb)->proxyarp_replied) {
+		if (test_bit(BR_PROXYARP_WIFI_BIT, &p->flags))
+			return;
+		/* For gratuitous ARPs/NAs, check neigh_forward_grat.
+		 * For regular ARPs/NDs, check only neigh_suppress.
+		 */
+		if (br_is_neigh_suppress_enabled(p, vid) &&
+		    (!BR_INPUT_SKB_CB(skb)->grat_arp ||
+		     !br_is_neigh_forward_grat_enabled(p, vid)))
+			return;
+	}
+
+	*prev = maybe_deliver(*prev, p, skb, local_orig);
+}
+
 /* called under rcu_read_lock */
 void br_flood(struct net_bridge *br, struct sk_buff *skb,
 	      enum br_pkt_type pkt_type, bool local_rcv, bool local_orig,
@@ -230,40 +272,7 @@ void br_flood(struct net_bridge *br, struct sk_buff *skb,
 	br_tc_skb_miss_set(skb, pkt_type != BR_PKT_BROADCAST);
 
 	list_for_each_entry_rcu(p, &br->port_list, list) {
-		/* Do not flood unicast traffic to ports that turn it off, nor
-		 * other traffic if flood off, except for traffic we originate
-		 */
-		switch (pkt_type) {
-		case BR_PKT_UNICAST:
-			if (!test_bit(BR_FLOOD_BIT, &p->flags))
-				continue;
-			break;
-		case BR_PKT_MULTICAST:
-			if (!test_bit(BR_MCAST_FLOOD_BIT, &p->flags) && skb->dev != br->dev)
-				continue;
-			break;
-		case BR_PKT_BROADCAST:
-			if (!test_bit(BR_BCAST_FLOOD_BIT, &p->flags) && skb->dev != br->dev)
-				continue;
-			break;
-		}
-
-		/* Do not flood to ports that enable proxy ARP */
-		if (test_bit(BR_PROXYARP_BIT, &p->flags))
-			continue;
-		if (BR_INPUT_SKB_CB(skb)->proxyarp_replied) {
-			if (test_bit(BR_PROXYARP_WIFI_BIT, &p->flags))
-				continue;
-			/* For gratuitous ARPs/NAs, check neigh_forward_grat.
-			 * For regular ARPs/NDs, check only neigh_suppress.
-			 */
-			if (br_is_neigh_suppress_enabled(p, vid) &&
-			    (!BR_INPUT_SKB_CB(skb)->grat_arp ||
-			     !br_is_neigh_forward_grat_enabled(p, vid)))
-				continue;
-		}
-
-		prev = maybe_deliver(prev, p, skb, local_orig);
+		br_flood_port(&prev, p, skb, pkt_type, local_orig, vid);
 		if (IS_ERR(prev))
 			break;
 	}
-- 
2.47.3

