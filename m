Received: from mail-ej2-f8.google.com (mail-ej2-f8.google.com [74.125.228.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21D343CE59
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 09:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514045; cv=none; b=FZmGzpDfmqrpFtNVkSWT/zJDaAN9ImhyxY07areaDhQqaa/Qntso5erVs6Hwqu73n8etbSJNzLWhSRdQx6/fBFYI1RAlZFBB1ChBh1cxKk4l5tKoS6JOkkJ+HlstAYgmpftlHdkeQNxe47Pq5N2/krXpasFpj2+ocvSbmmm1tA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514045; c=relaxed/simple;
	bh=fm9T6gXzMUmaBydrBUMtFIpUa6OxX8zUeLR/eA86Rq4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o4Ueb3zr9euJIrHaKPXbzKd1H9B5h7djJSOonIxnMEZNJWjCrzkih3I/2sLX+PBDdvFABxjcaOWtX9TXWj/uxtfuwEfkoiCHWGdySJJDuWUGSTz0fLyzxbK04cj+8+xtbPzyf6zjR39koxibXYaZ8sQbjFtYiGgq3hviQJp7OC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de; spf=pass smtp.mailfrom=bairaktaris.de; dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b=UdaafsHC; arc=none smtp.client-ip=74.125.228.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b="UdaafsHC"
Received: by mail-ej2-f8.google.com with SMTP id a640c23a62f3a-c254113e9beso27134866b.1
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 02:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1788514042; x=1789118842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WstpREewxAVHgQRNTBHOeu2o6yyD2SP9BVlTbZRUMhw=;
        b=UdaafsHC6De5jMcdRIjAEcr+YzzAJoC9AAVtB/fL2uWY4b+ktiqOVDntC7ry1VayXq
         C03V+YGBd45TMqHCKJ31HUmfxk26W17s8CWZPnFW/nuLcnV3uIreWYvfcSNy9cPkI0z/
         0T+JNOhJBArHow6Nrot124LiKshHnx3p9mRuI02zFMtU+TlbAEHUCsEI6Z9qaUH7WA87
         gWlY43IUBtqDYXuBSToj/4ubqoZfgelVCcxa9tMlRS2cuqzS5y+fOyk7b2RoB+lCdv9K
         4yr2+4PWQzlmsuaighepB0ARN5NSs+ZCiU3wgF8b/GCPurdEIku0AvT4Y6KU0hKLtZL4
         2pOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788514042; x=1789118842;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WstpREewxAVHgQRNTBHOeu2o6yyD2SP9BVlTbZRUMhw=;
        b=DCOTRReNwdp14EZ3bxZAKERt2/3TSc3MHWylL/Q7YTG1Op16zngQvS2UuUMxp0bYjY
         V7YrC0pwQRtGy2aGSOSv2/568qSiP+p42yPXWtpbrdFZ/CiMPLxAqMsehV1m2lIgknBm
         OlziJxAtlNJlJc13p/aFUFgX8a+VRz/WKPD09TSCHHMHt4oB/5Yan++ImOq3UOrRDvWU
         Bxn6fLIWSvQz5GxWYes1FboDdAwYYxJVvQ3jJaO/pcJFwyblwBGhk1R4B4qWLDFBrZl8
         7V9xFZJMopo5NvxrjUNIP4IKJPgx7b3wW4Cb16k/v2ZO7/WhC3xoj5beZXPeTkDxXWNn
         wFNA==
X-Forwarded-Encrypted: i=1; AKwUvBwIzhL23+tCIsejQdVqfDlZMwsah6jKcp0YUqL3eYHpOaTOAJY/8+2orau3w6e8NooTj4aYZxU=@vger.kernel.org
X-Gm-Message-State: AFuF++k4dDznQVOXMqXSxiixZIzYTrT2Q8zoSIlZucKUPPLiyOF512PF
	ciirphhxRpEV4JCAUEkBPuq5IluK+Cl3idqk6VfjBwKSTQPvBUnGJw5Bqfh53Kdr78yOILrXviS
	AyKo3Qmk6rF90wQ==
X-Gm-Gg: AYBFou2g7rkurjCVtR6aOBHBddxGwE7p/LSSeFx+3B85xWJDN8OpxM7Fy44HYxqBn+k
	+sLihr0izTvejmBbBI+Z7HwRdfwE06kklr9Q8YZkUuhZQQgUfcMjkO5ZNTvJ0ruxGZ4DedPN9ZD
	4455w30ih5mGUKZPbsQvJNE811rNJ8PpZO9TzDKvYHQ7IYQeisg/2xOfYl+oIRYXkYZeuGknsMk
	BSgNeskrFisSk6KMbJmTagJ+TmaFZ3zevQDEM7RmDNv2i4M4bnAsjHEIgnl/i3aeNeiWf98SGaG
	zcratmtmtLycTZ8hCgLvlbHuqQTEdVC5IKzHSG94Lgaz8aY4bdQfFXQSI5aLF9DMUA+IsCKpf8P
	qSkYQw1Z1JXJWgtgjpqtLfBXchI9rM0edIM0fTtRDOJiHrKeJZlXk7l0yhWb02MrhMuFwpXqDhs
	37BADsNfSLR87r7uRND5Q7mcFuAIQj6hxoO8CVEaDbwp/WiSNfbTTbh+Jk+osdIgcgWvdob+hV8
	hHTn3DMVsTJX3hgLNb3BZgLT3S+V9DzEnJJPfM9bkq555KSiQG+SRAQjcHvJRMvkvr9Ou5+t8PA
	YASMxSbmjZ0X5Ll0XNOzGKhMBjt8HRNV3csU0q24QHwfoDwBEm95vGKq04XcOqrUnay4tYbiP2C
	j8M2LC+szw+zyExOVPT3qq/620VfpF/JOOC0P79T0liYoZWKMaSkmuPhL1zvSOywWMqyzTufzdG
	BaBdDjC8/A5IqR4fJMxhPMAOFcpg==
X-Received: by 2002:a17:907:7a89:b0:c24:6445:d19 with SMTP id a640c23a62f3a-c260c9f314emr207802766b.17.1788514041386;
        Fri, 04 Sep 2026 02:27:21 -0700 (PDT)
Received: from Desktop.fritz.box (pd9513ef7.dip0.t-ipconnect.de. [217.81.62.247])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d5773c5sm80462966b.40.2026.09.04.02.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 02:27:20 -0700 (PDT)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH net-next v2] net: dsa: offer a flowtable to the switch before the conduit
Date: Fri,  4 Sep 2026 11:27:18 +0200
Message-ID: <20260904092719.534318-1-julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A flowtable bound to a DSA user port is forwarded to the conduit netdev
by dsa_user_setup_ft_block(), for a flow engine that sits on the
conduit as mtk_eth's does. It does not go through
ds->ops->port_setup_tc, so a switch that owns its flow engine is never
offered the flowtable.

Offer TC_SETUP_FT to the switch first and forward it to the conduit
only when the switch answers -EOPNOTSUPP. The side that takes the bind
is recorded on the port so that the unbind goes to the same side. Every
in-tree .port_setup_tc returns -EOPNOTSUPP for TC_SETUP_FT, so a
conduit-side flow engine is reached as before.

Assisted-by: Claude:claude-fable-5-1
Signed-off-by: Julius Bairaktaris <julius@bairaktaris.de>
---
v2:
- decide the target on FLOW_BLOCK_BIND and record it on the port, so
  the unbind goes to the side that holds the block callback
- reword the comment
v1: https://lore.kernel.org/netdev/20260901092546.369232-1-julius@bairaktaris.de/

Tested on IPQ8074 with an out-of-tree DSA switch driver that handles
TC_SETUP_FT (openwrt/openwrt#24806): three flowtable unbind/bind cycles,
hardware offload of routed flows after each.

 include/net/dsa.h |  6 ++++++
 net/dsa/user.c    | 25 ++++++++++++++++++++-----
 2 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index 7507d632e7c6..dbcb02de06fc 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -297,6 +297,12 @@ struct dsa_port {
 
 	u8			setup:1;
 
+	/* Flowtable blocks on this user port go to the switch, not the
+	 * conduit; decided at bind time. Written without rtnl, so not one of
+	 * the bit fields above.
+	 */
+	bool			ft_on_switch;
+
 	struct device_node	*dn;
 	unsigned int		ageing_time;
 
diff --git a/net/dsa/user.c b/net/dsa/user.c
index 041f9060c8ef..f4cd48df2519 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -1718,15 +1718,30 @@ static int dsa_user_setup_tc_block(struct net_device *dev,
 	}
 }
 
-static int dsa_user_setup_ft_block(struct dsa_switch *ds, int port,
-				   void *type_data)
+static int dsa_user_setup_ft_block(struct dsa_port *dp,
+				   struct flow_block_offload *bo)
 {
-	struct net_device *conduit = dsa_port_to_conduit(dsa_to_port(ds, port));
+	struct net_device *conduit = dsa_port_to_conduit(dp);
+	struct dsa_switch *ds = dp->ds;
+	int err;
+
+	/* The unbind goes to the side that took the bind. */
+	if (bo->command == FLOW_BLOCK_BIND) {
+		err = -EOPNOTSUPP;
+		if (ds->ops->port_setup_tc)
+			err = ds->ops->port_setup_tc(ds, dp->index, TC_SETUP_FT,
+						     bo);
+		dp->ft_on_switch = err != -EOPNOTSUPP;
+		if (dp->ft_on_switch)
+			return err;
+	} else if (dp->ft_on_switch) {
+		return ds->ops->port_setup_tc(ds, dp->index, TC_SETUP_FT, bo);
+	}
 
 	if (!conduit->netdev_ops->ndo_setup_tc)
 		return -EOPNOTSUPP;
 
-	return conduit->netdev_ops->ndo_setup_tc(conduit, TC_SETUP_FT, type_data);
+	return conduit->netdev_ops->ndo_setup_tc(conduit, TC_SETUP_FT, bo);
 }
 
 static int dsa_user_setup_tc(struct net_device *dev, enum tc_setup_type type,
@@ -1739,7 +1754,7 @@ static int dsa_user_setup_tc(struct net_device *dev, enum tc_setup_type type,
 	case TC_SETUP_BLOCK:
 		return dsa_user_setup_tc_block(dev, type_data);
 	case TC_SETUP_FT:
-		return dsa_user_setup_ft_block(ds, dp->index, type_data);
+		return dsa_user_setup_ft_block(dp, type_data);
 	default:
 		break;
 	}
-- 
2.53.0

