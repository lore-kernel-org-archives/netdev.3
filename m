Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1B247CA79
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 09:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788254797; cv=none; b=XF8CK3fhn1AzcHM0a2cwZxnu6Lv06Ep7u9kHGM1QNhstEALe27IteBgnJXifGse9qRx2VxNzynBH92QKk+ofRiwKM2ZGD0UwB7TOW0Wi+8gCFcHrh8Apq39FBY9ht7IFXtoaSM9hDmscUtdXWAxWCwOj1gUOHElQVioCsV3S+VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788254797; c=relaxed/simple;
	bh=19eTCqrrjDDqZcwZomzp1yeRhX84hOOWpMarqsBgp58=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dGD+fwRAGt9mw27wIIUC5Fff9qq143NV7p+WYqpSxpQPuuT74M8DIoo6HTam0ea+wWqvw0eO1oxvv0gf3vZPBTv5ZuWhILza80uZVc4igHLgQD+pwH8lz5cVqm7MYe3178jr7CG3BA/IOS7M9jTjUdp1braTcarFbS9waUnfzq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de; spf=pass smtp.mailfrom=bairaktaris.de; dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b=yP5l1lLf; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b="yP5l1lLf"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c25b3c641fbso134160066b.1
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 02:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1788254793; x=1788859593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Klhk2PrFgiXUCk6rP4JbpGXhbQzfUnpa3kBBA5F/UDI=;
        b=yP5l1lLf646V4OmcS3y/kAr+oJfP57xBn+ax7xnQ3JoXdq6kOTmJxtjCIK0rOzrSwF
         TUD5SvDlrduQST3BL/Asf6vIF2NiDvYXIT0Zk3K9wBQNvsSRB7dc+4Hm4vZ0rkhvpKQF
         XDj5DVTEuNo4H+fKinSvIQTFesqaOiKtAjpH5ck/4pDL3na0HJnJk9oV5o+b6pMKNm8V
         2Q2bgb6ssm1G9JG1+n6sjBXYMeNPIpjamKKnxO7bGFa3uAuBJgDorLg08aYs83xzq0tI
         Z7quOLpUGF6Gj5lpJ4ByO9yYi4Cq0Y0nBNqfjAtzA9EPYV9XrMYW1p/HajnphQDWAeXH
         67sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788254793; x=1788859593;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Klhk2PrFgiXUCk6rP4JbpGXhbQzfUnpa3kBBA5F/UDI=;
        b=RMr5V4zJK8dy/um62X8bBOElhyxH2SwyUQydLcClDlJWqPyxYUiE4gZRxjUgZGKhAU
         QGq6Rwq3/FTTQBLOUD2tAzHREH7eX23EzoFafspJ+qMols7oUplBZGs2aApyVoJEI+Jg
         S1jGR/ZjQUOnTXfreJ3cA+GB/LUoX7T59wVH7lV6IrnLUFsbXJ1ckuxlyoWJNHL76Wbt
         41uveJWY5aX4C00FyO9Vo9Ou8lAjesTbGyw+QA8ofhWmPqYWvVdGYqW53VrobLC1XOUp
         H+HsVUB+OudJ1HFHNEAF3BeAscuRySmEAcZGevVfZdOyk3RdwDSmgxmz8WTBMoL7Jojb
         4nLw==
X-Forwarded-Encrypted: i=1; AHgh+Ro10ZAUxR81nii8Kmvw+kwA4YZFNqYsw80/M2o3OZ7hhn1Skg3DSdTQaJzk6JrJmTyW1UO9+BU=@vger.kernel.org
X-Gm-Message-State: AFuF++laRO66Y2iZtExMMI1Bni3wP2dervn72Zwypgoec1j7wXd30HNM
	kXFFTkp8AonllTxBztvvQX/K4S7rh260zM6WXywKDmzzfzpFJS5OMSKYJTQocwe4vLU/OWja7E7
	EqEJVidhr
X-Gm-Gg: AR+sD12reFMwjmvBE/qP3+mhNtXzRdELxsn0L+WPlmxWXBdi9gSQ5rIQscr3Yc6U6K7
	xTIO7HV+S5dUDn8PvTEl0MHZseFCbR23smWlUncAUbbUAckFka8Gd/5JtliuJfUno1+8cd+iHcI
	80+3jfKacCIskjePSgrc6sIJETyNIu+Pw6a94iqEx27xzLCwQA9E+n8CWsQxKl18VLejkqwAMGh
	BPtUqaIEAtrYmDIM6axSrKnal4uXuQrzW9S8NAZVyEXsgD+U/BzEXx9l0UBv71TVVE+NnA9ulWR
	ytUpceWeFNPpDjl+beN5PDTKaBr+zpVbmZstTESo9SCjue+V6zCqjZ07E5LEJVJJpar3HIM9Wo4
	CgxMQhi10UWBtTbPFgDS0uD/QF1JIPNJh/W6Coy020fLC7rJLZZrQAzAkeM40dtL0pdBxwfH+yV
	4YCjsysvWnyhWxKHcLuIs8HpwudEderYd5D9iWssuaVji2Yh3GBSFzdgfI4fSeLB8/yG/Pfi9oI
	X4GJEx76ulwBqDxv9SMiY9WwbR9UzuumrIe2tCfk69IT57OO58sr6iN75uQ9OMJEr4pk6lTQFsT
	IPtAcKPzXVshrBl+ICe67AGbZPy6rye8sA4rDkyffHlfM8LonoJbENlXsZOxiiyrnR+NGdo49x9
	AAHa8uRUNt60xgFj6T+FyYtD63W1CD01R1tSgb9YKlyBqm0Bo1C5ryhDp+XmzoX7M7T1yY9lWAj
	VkVmq/qwU=
X-Received: by 2002:a17:907:73cd:b0:c24:b11a:470f with SMTP id a640c23a62f3a-c25b39d698cmr465856366b.0.1788254792938;
        Tue, 01 Sep 2026 02:26:32 -0700 (PDT)
Received: from Desktop.fritz.box ([185.181.129.92])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c255f1b5a4esm549163566b.32.2026.09.01.02.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 02:26:32 -0700 (PDT)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: dsa: offer a flowtable to the switch before the conduit
Date: Tue,  1 Sep 2026 11:25:46 +0200
Message-ID: <20260901092546.369232-1-julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A netfilter flowtable bound to a DSA user port reaches hardware through
dsa_user_setup_ft_block(), which forwards the block to the conduit
netdev. That route serves a flow engine that sits on the conduit, as
mtk_eth's does. TC_SETUP_FT is the only tc setup type handled this way:
every other type falls through to ds->ops->port_setup_tc, so a switch
that owns its flow engine is never offered the flowtable at all.

Reaching back from the conduit's ndo_setup_tc through conduit->dsa_ptr
is not a substitute: dsa_tree_teardown() tears down the conduit before
the ports, so a block unbound while the tree goes down can no longer be
resolved to the port it was bound on.

Offer TC_SETUP_FT to the switch first and keep the conduit forward as
the fallback. Every driver implementing .port_setup_tc returns
-EOPNOTSUPP for a setup type it does not handle, so a conduit-side flow
engine is reached exactly as before.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Julius Bairaktaris <julius@bairaktaris.de>
---
The switch-side consumer is a DSA driver for the IPQ8074 PPE, maintained
in OpenWrt; a flowtable bound to its user ports is exercised there on
IPQ8074 hardware, against a live PPPoE uplink. The conduit path is
unchanged by inspection: every in-tree .port_setup_tc implementation
returns -EOPNOTSUPP for a setup type it does not handle, so mtk_eth
behind mt7530 keeps receiving the forward exactly as before.

 net/dsa/user.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/dsa/user.c b/net/dsa/user.c
index 041f9060c8ef..c5adb557056f 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -1734,11 +1734,22 @@ static int dsa_user_setup_tc(struct net_device *dev, enum tc_setup_type type,
 {
 	struct dsa_port *dp = dsa_user_to_port(dev);
 	struct dsa_switch *ds = dp->ds;
+	int err;
 
 	switch (type) {
 	case TC_SETUP_BLOCK:
 		return dsa_user_setup_tc_block(dev, type_data);
 	case TC_SETUP_FT:
+		/* A switch that owns the flow tables answers for itself; only
+		 * a conduit-side flow engine needs the block forwarded, and
+		 * that forward is gone by the time the port is torn down.
+		 */
+		if (ds->ops->port_setup_tc) {
+			err = ds->ops->port_setup_tc(ds, dp->index, type,
+						     type_data);
+			if (err != -EOPNOTSUPP)
+				return err;
+		}
 		return dsa_user_setup_ft_block(ds, dp->index, type_data);
 	default:
 		break;

base-commit: 25c1f6111034aef7fc06cfbdcf1e4f0d6e5ee74b
-- 
2.53.0

