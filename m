Received: from mail-ej2-f10.google.com (mail-ej2-f10.google.com [74.125.228.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7EF442FAD
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 09:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788513900; cv=none; b=jSHL2Fddf58BaU3q2bkuBnv8oLwRs7vhnoux1pM8QGJBljVBOdIm4d1FpUWaebI3YcALkTcPeunJZoPQOl5PFRfWc1rsCV83mcu8CzI0CVUrjH3gd6SW6U4l++nnmBixaTQRoOvTIVKK899cdHs0PdOjtIlHWlalbGpyYj0Tadg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788513900; c=relaxed/simple;
	bh=fm9T6gXzMUmaBydrBUMtFIpUa6OxX8zUeLR/eA86Rq4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qeu4HcgBLtd5Y/ZTU1tkYlXTwiaR//Qyl2qtm+/kHW9D5OGoPW2UAZ/MAREHrEftScYBsFlbzo9ULe4GFvJqbyTXrTt6OkjgF/3L+Dhq6BSxkk6xMT3QIJxTgSS0QQGsIx9Nly00j1i/fhbJ7mXVFBMsoHBeAPNb8ljkukKdKVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de; spf=pass smtp.mailfrom=bairaktaris.de; dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b=YLlAJJJt; arc=none smtp.client-ip=74.125.228.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b="YLlAJJJt"
Received: by mail-ej2-f10.google.com with SMTP id a640c23a62f3a-c25b4493edfso31903666b.0
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 02:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1788513896; x=1789118696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WstpREewxAVHgQRNTBHOeu2o6yyD2SP9BVlTbZRUMhw=;
        b=YLlAJJJtBaFPyPYssJccRipixGPA3rHUBdg+h+IUsWIZqytXie56Gq94kxhOMuaU/N
         mMJh9MCFLtoN6OQ3o/dktmp88K9NtqnVCdvNi7reJBBc4szmIIvjNT1veoP38Yc2YTQI
         lyktMeWMTw8Lqj4C7XGIVxhgEpO8Ezcvs6NK9EKsS+WNKHLZFrUDgHYZ+U91KlUqIjF+
         v0xWR2ZLXeqI+fks0crB2+uqXk7Y7pXdVn6y7nFzbihjJE6UqPZ39zmMF2rJiixrT2dC
         EEpT4Ep7LZ5Dhwom8uhmtlNOXKc+Q62vEvRABEyCSh146KbalKePRihq1OK1q81D3DiT
         7ycQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788513896; x=1789118696;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WstpREewxAVHgQRNTBHOeu2o6yyD2SP9BVlTbZRUMhw=;
        b=P4HCJo5pTPxgWjr5txWVjM0OatKv38WMUOuwAjr5BcYBBZ+B3UKPaWke++BRDKhnhK
         CfqbKYvE0wVinPLOmi6QfGoKYAvipOp697ON4CwA8zdOMh52jd/P478hYH5rJyWbiYhQ
         vELpAyxRS3LLztZKaQbK4BTwAZuvy0BrRauUa+2weatVgvExI1LaMtG8T575Dl5ku9KJ
         IFIqmJQR94gpbpoaESSII+Uo18YYssNQieh1GG7YNtHNv+cVMQOBWAh8DK/vInDNVYEs
         52vYIfl+f7ZJ6VpaRxt+Nx6nixu2LiNu5pAR7BUOKAG6kQdTDb2bPePerjGKwssNyu/o
         pzzQ==
X-Forwarded-Encrypted: i=1; AKwUvBzGD+5rd/56RSHPpDD3wGa+cm4RVwtZPN/gyLjGyNCFdAtzEaBViV/+huevsB6gc4o3sJ2TR6o=@vger.kernel.org
X-Gm-Message-State: AFuF++mI+o0+0kficmUEGpswBm9pe8S2eSFMgiwRtb+G2e+Wp0fwiX9o
	qpZ6ZihUHxAXUeIx1uG0X9KiretI1xQUo7mpxqZ0izGbqpGSx5YgB2zQ8vcL/JN/aA==
X-Gm-Gg: AYBFou165tZCZgi5C5YoOZO7xnLaW9j7qnrbXxdUun3rKYhaiRazDV/ZaP7wcv6+uir
	ZvmHFzCJB65d89lvq9XA6OejKXVbD3e0kx7OJkjwJu3d1xZvTw4LfPYsZIYJev0qPSlUPcY0btP
	CVZx0/FPvY7mCqa9WxzpguiqNkGoyxEOjmlegYyiz6d2r8FPXPdZviXNbS+uiwzLY39S4ktrjne
	HN/iZuQYFxsjQuHUa9ibgmkKHlw0xwv4hCp9nf5PBI0xTIVyM1sC2VMM66eU5flyhQBLEoMhpgc
	m+gfjLg1jtPOeS2+Vw64wJLYr+OwnbERfjKazoKOKRCt+EIf3Hrw8ang5m1FxFpKPbGEP7yoyNy
	fWYAFwjYJWs51cXVpr/NSDJPKqxuNH38wwwfSjiMn5YWoZXiXqdTCaCA61RO8I/cGjE8nuxzcHI
	9WoRczV7NMi/M5RR8tXWN+qTpAi3uhKIVYhPr/QDc18HEiqCSZlP0v4NjA4e26vb0trZw5zgxoB
	lBjaIflpgRO4FBjGSA8N0aQti1Jt+grUsdgI/4SbIIxRUcVl0vkfqazHL+fdinmTm7pLAPCMY/B
	qmjmK4sab4bVUOxMrMDTqacrSTuKUp7VRz7AzkqXyC37emUNrt5Uv2WerIVHmPfljfP9+G5fw2I
	0sXqegS/3s9egx1ViellSA6AXdI/zqFj6B+AiFwSJRNcU4pIAzrVtsoZriEcSzG9CXzGxpeOFmk
	O5swiF4fvwr1WN6yruQfrjxOkNAA==
X-Received: by 2002:a05:6402:46c3:b0:6a7:ee54:f89e with SMTP id 4fb4d7f45d1cf-6a7ee550089mr595421a12.34.1788513895892;
        Fri, 04 Sep 2026 02:24:55 -0700 (PDT)
Received: from Desktop.fritz.box (pd9513ef7.dip0.t-ipconnect.de. [217.81.62.247])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a7e6bf337bsm864418a12.26.2026.09.04.02.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 02:24:55 -0700 (PDT)
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
Date: Fri,  4 Sep 2026 11:24:50 +0200
Message-ID: <20260904092451.531652-1-julius@bairaktaris.de>
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

