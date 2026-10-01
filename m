Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D951A52FE4C
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 20:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790887772; cv=none; b=eDQl8Qzv90RE2A/rpjHOybD5ZQbY4Pv6Ssh5gjLTwReVsaHdcHgjJX3dZu/SZetjUn0FiVXI6RKiFHYUO104O+NvQurOUzTpYpbIlmuGZNkLYsyTtDqSYMTntBNxGw8GVstIjuI0A5y/QL5kf6hu9q80/JXpU2lhvth2yI7QAYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790887772; c=relaxed/simple;
	bh=I6/o9KvZg6aat6YOGe4DnDre2ezdsh2qzKZe1N9kGWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ik9vFDB8GBNiIFKB4YNbFeMit5wWvBQ5LdBnLnCN0uTv9JH6ulEFjGm10OCNSB51PYWSesIitMzUi8pAadHpwCXOsqwBKXorrufC6HGrtFXSwEyVdZ7mAnF+KkRQQfeRAfC73XDWr8/tZQZld3OCr5FdKhj5o05gz76wznuPSCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xd2TDf8b; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xd2TDf8b"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccd4f99dso4470607a91.2
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 13:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790887761; x=1791492561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hYT65medAWN0BTZv+iirNsDXipqGQN4Oa20zSL9XADg=;
        b=Xd2TDf8bZXYLpvnP8vwruHly+HUR49cPjJEljcg9VOc/k622HTJ57RGN+zPfabiJeB
         t6Q43hy4zyIxU0JCe0q6WZGxHhbHtArNQh6Ck8eZ+v8PTU1HuQnCIInSH6pNcZ9xeezO
         709tTjkN28J2LAu9lCD8q+ageb9cCGG/VRxaLJ4IQiUlYo9gvvsjiQeUpvESH4Xas+hU
         Vf0927sozPk9c2+TXztjuupEnqvKIWPqQy2hmf6ivCFnYqbfSys4O4yCk/Tj7e7tzJZf
         CHiJK4s/wYkb6gWeA68gzaFqGz0c9Rgd9QFXGTIDvjug7zHVKK1HzM23iUK03vNOJc1x
         Uzww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790887761; x=1791492561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hYT65medAWN0BTZv+iirNsDXipqGQN4Oa20zSL9XADg=;
        b=fNLw4Zrh9EFqbLgqsyBCM+blUQYDkKzaoqtvHHo+kIWB1duFhIUQQRFawC1ZJUR8Mm
         6wYD+WlrdxGkJOmBI7wu5YMgbupt+wT6+gdibTGac1XTtjB9JrvISqKdkdK2e1/6p3Gh
         wSDHJDE7an7e0I7l5Twb519xybmZc9agTkNHhZ2h1oMhJurNvmBz4P58V2kL8mwtlf/T
         S1QZAjPdybTeA9toy365i5Bk+nNl9R50wjh6oZnZ7L4S2CkdwSN6isx5cfr3pOr4wZBi
         RLbHVRS8FRbSAOx9gW1Ts7OzZ1mXjTJSoatE3kgTc7dM51gJNwrr80+FsOIvdpR/LfIc
         HF0Q==
X-Gm-Message-State: AFq9FYJlJel9RjM2oErB1ZFDJ0x3LpWtituLGotxMYk70SLYyeO5nvXc
	Ih4o+mWVYvpsi57TwM2DuhMoWk1vvpLzpHH9eJL4mfOUbikFJ7ALPG0gdZRx0gq/
X-Gm-Gg: AYBFou2oFwrD9CPCoXcfrQ2sidFlnPnIKqI/jkn8ne0srPSeKo+yS3qt30QziEqae+c
	h8zf+uruasP6qUDPLzvXqxI2RwXh1ugjd4+WoUhmzCpmiIVj98SgJqt3C6bdj8DTwVZgw5eGBKF
	c2OsCyj0JyO+NyE4Q3cSFRlWnUFprSGmAn8G8PkKqjHJpDJ1MLC9XjxBjswISLx5gN3vGCPQzwX
	2JKgNrRlecAhj0SmJmGceYwIom3M9COEl0me2Xch/Jg2Xdq8xpv0e/XYy3bchPRZAnxBRexUeGU
	MMr9dD1RSw7EpKEXBkZu4eMY5sEOtOS+sfZnXeo559OoPM/0+vkZFYcvlvCd9nCgPs9amPmJmmL
	O3wnq4bKz7gAMSkXqHHXPsDxQy8CczNr8z17b/B4x4OsIE+EpAMMdFaKXdT6eQ3FkSSZN39yipL
	9XaDjvLPK3ELGXhPp9MlTW5jlR89dcBkeqCe548gWrIKvxJwiqg+o/NNQKl/M5CQkvpDVTAqQQe
	jgF/vYSs2BlbLnoVxvgJO+qrSPsoFl4GMnj
X-Received: by 2002:a17:90b:2687:b0:3a6:c8f0:c3ca with SMTP id 98e67ed59e1d1-3a6cec5e97fmr586435a91.47.1790887761126;
        Thu, 01 Oct 2026 13:49:21 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:661e:3050::4d0:26])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4f478e9c6sm5658797a91.14.2026.10.01.13.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 13:49:19 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 5/5] net: dsa: motorcomm: Add TC prio support
Date: Fri,  2 Oct 2026 04:48:48 +0800
Message-ID: <20261001204851.2576101-6-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261001204851.2576101-1-mmyangfl@gmail.com>
References: <20261001204851.2576101-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The HW supports fewer ACL priorities than TC does. Notice the default
priority for flower is 49152 and catchall filter has priority 65535, so
scale the priority accordingly and reject the ones that do not map onto
a hardware priority.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/motorcomm/tc.c | 19 ++++++++++++++++++-
 drivers/net/dsa/motorcomm/tc.h |  1 +
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/motorcomm/tc.c b/drivers/net/dsa/motorcomm/tc.c
index 95ed0f245b1f..c5581e85208f 100644
--- a/drivers/net/dsa/motorcomm/tc.c
+++ b/drivers/net/dsa/motorcomm/tc.c
@@ -1029,7 +1029,10 @@ yt921x_acl_rule_ext_parse_flow(struct yt921x_acl_rule_ext *ruleext, int port,
 			       const struct flow_cls_offload *cls, bool ingress,
 			       struct yt921x_priv *priv)
 {
+	const unsigned int scale = (U16_MAX + 1) / YT921X_ACL_ORD_NUM;
 	struct netlink_ext_ack *extack = cls->common.extack;
+	u32 prio = cls->common.prio;
+	u32 ord;
 	int res;
 
 	if (!ingress) {
@@ -1042,6 +1045,20 @@ yt921x_acl_rule_ext_parse_flow(struct yt921x_acl_rule_ext *ruleext, int port,
 		return -EOPNOTSUPP;
 	}
 
+	/* TC prio can't be 0 & TC lowest first -> HW highest first
+	 * map 1...U16_MAX to (ACL_ORD_NUM - 1)...0
+	 */
+	if (prio == U16_MAX) {
+		ord = 0;
+	} else if (!(prio % scale)) {
+		ord = YT921X_ACL_ORD_NUM - prio / scale;
+	} else {
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "Invalid priority %u, must be a multiple of %u or 65535",
+				       prio, scale);
+		return -EOPNOTSUPP;
+	}
+
 	res = yt921x_acl_rule_ext_parse_flow_action(ruleext, cls, priv, port);
 	if (res)
 		return res;
@@ -1049,7 +1066,7 @@ yt921x_acl_rule_ext_parse_flow(struct yt921x_acl_rule_ext *ruleext, int port,
 	if (res)
 		return res;
 
-	yt921x_acl_rule_set_ports(&ruleext->r, 0, BIT(port));
+	yt921x_acl_rule_set_ports(&ruleext->r, ord, BIT(port));
 	ruleext->r.tag = cls->cookie;
 	ruleext->r.type = TC_SETUP_CLSFLOWER;
 	return 0;
diff --git a/drivers/net/dsa/motorcomm/tc.h b/drivers/net/dsa/motorcomm/tc.h
index 2a811127ec8c..99d4abf5dacd 100644
--- a/drivers/net/dsa/motorcomm/tc.h
+++ b/drivers/net/dsa/motorcomm/tc.h
@@ -331,6 +331,7 @@ enum yt921x_l4_type {
 
 #define YT921X_ACL_ENT_PER_BLK	8
 #define YT921X_ACL_NUM		384
+#define YT921X_ACL_ORD_NUM	512
 #define YT921X_UDF_NUM		8
 
 struct yt921x_acl_entry {
-- 
2.53.0

