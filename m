Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2208430F958
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 04:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791175121; cv=none; b=LnxCTb1fa84sgioEkUUrk8ePWsarC1J3FWxmhIZvo3pWccXqgwnKxT6jAII/0WxQGwwY/vR7GTS5lltKO55SNRavyRck30M+3lt5noshSrvhtrcrAl+Y6qlsngPAK7bwdlJyZkrrkWZuBF++fJ2LLI1YuPiS5eQu7ipptd8qoZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791175121; c=relaxed/simple;
	bh=nf2VEgIA5V8IZnfrS95/iUAfy7BDBD8Wra2bFqecV04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EnAc+S+Cw46R6o/7j8e5nbmxobcNyLgGdEfaawggvQxp1WN5iN7o2VD4KG/HlXnQVQq8qvAjQaT+EAdUuuI1bkSJx6XYlzfllhlXnDT8eW9QmE7Em3UVUOke6FpkMHwtx4l0QOnGl9CRNASVye/uLTLLGtnWIhjMEI8cdt+G+Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gaE8jOtu; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gaE8jOtu"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-34bffc8105eso1677459eec.0
        for <netdev@vger.kernel.org>; Sun, 04 Oct 2026 21:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791175117; x=1791779917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m3RnpCbUlx5vRacAcPCSy9Sv4WlyTpLU86dq8MXP9H0=;
        b=gaE8jOtuCGegXLBMhd1ZwBC3fROPD4NUTa//m1FawlArPwMSJoMmAxqNjYfkZLduyv
         A0I0UrrklyRVApEiMXJPhgUDFt1Df0beMkl9Dy5U9c6obI3LCJDVs1iBVrV/Gnr6OyLm
         TiWRtmkJ5J6B6uQXKiGnxNB3EAtvyrJqj0j3JKR1T4aNwBcpv2r0ZPfagMcD9SvFgpZ4
         JR8Jd7rMSj17sMv1Nsf2taWWHTa1SE7qgz8bHXwq3/ssDtAHX7trnbHUmn/IIPgWVpqs
         Q16NEdBR8KAyCExKI6960xzlObKZPUzwu2HZuXry5sewJ8BMCSYtgN6WOi+vOabQlBiP
         NQPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791175117; x=1791779917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=m3RnpCbUlx5vRacAcPCSy9Sv4WlyTpLU86dq8MXP9H0=;
        b=E3whQlikssm+WaVxes62/c9svCsKCGnCxsjvh19dO9+9X7UEYH/N5ENKXsofB4Bkt8
         pmEYwg2BRqPC5bm/ilru67o0t/kRxYZVYWVVVPkwdCO60/VIxbkcTMgi9cr4J17Tt/B0
         rMVEFDbAhfGx1XTZR7ShFEZKtNo1UN56LdLevHZYzGi/dERi/f56AKjk0h9KmtcWdkQ3
         3SKDsFgMWIiD/195UT9WS4DeG0y4qkv9qRFuT8cmpjKz0MAREif/k0KjuBsnPbvE/zVa
         iiqkX0VCfP9k77bI54qrziWTlz2b7Cawvn9G1IFTdbeU4VVcEr95lB5P4mD7U0qqdwmr
         aSNg==
X-Gm-Message-State: AFq9FYLeXw1wtnZdidQGwACsMVbM9uJPE2J1bjbK0cUqCiWv4hL5Zr+a
	KNcQxF0F4PH0bUkYCb2Eixd1vPtX4c1PE3GBK4ic1xuz4wS/JixJ37B3LNoX0XSj
X-Gm-Gg: AYBFou0VhdwOYBwzCwJ7958olR5si6y40F5eSkHeYG6EUY5M4DWSQREqvXxwtpE4nbJ
	2FGdEkO81K1FU2uld+7QpZZauODO75nZkGaplFTqUjne6EV/qv+QbqRUcEWQI/pAvyzPLZOlbqP
	7KidQdqErOFq8an62w4zKIjv8k6oKAGVuRhHpS4pBpWKrTLygGg5tQ6QwRagrinvj2U+1U7TwRq
	ZSK+p3x7CB0BWZM0l/rgxsSLDSU3EjBLJ6RBVrHGRUpgSKYq3eAVkmz6vhFj2B7Im8X2QpBozLE
	vJFD7KlBc9yzVwuzGCwUxh+ibfv+DkfC4OM8IYmNQIwwIWynm03TZ5UL5J6i8qcZvLSEMk4ndW/
	8rFap86tQmAXaRw6NSj9mxcWa+Bnx2Ja0eokGWo/DB+odLOC0KzoO14yCNCfX2ornpJmheEQxLb
	BSrmFMztyKei8213QOdYDNzOlboD52B86GDzKBLtC0ixyDPXeU/PQbovTDN5V0i+ZV497R9wr4O
	4VDzm8=
X-Received: by 2002:a05:693c:41c7:20b0:351:11aa:5d5b with SMTP id 5a478bee46e88-35111aa6037mr8207069eec.19.1791175117045;
        Sun, 04 Oct 2026 21:38:37 -0700 (PDT)
Received: from vscode-11-19.w453y.xyz ([59.164.88.43])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35127136b8esm9518581eec.6.2026.10.04.21.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 21:38:36 -0700 (PDT)
From: Abdul Wasey <w453y.me@gmail.com>
To: netdev@vger.kernel.org
Cc: razor@blackwall.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	horatiu.vultur@microchip.com,
	bridge@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 2/3] net: bridge: cfm: send an empty CFM nest when a bridge has no MEPs
Date: Mon,  5 Oct 2026 04:38:21 +0000
Message-ID: <20261005043822.3106580-3-w453y.me@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261005043822.3106580-1-w453y.me@gmail.com>
References: <20261005043822.3106580-1-w453y.me@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

br_fill_ifinfo() leaves IFLA_BRIDGE_CFM out when the bridge has no
MEPs. For a dump that is fine, but a notification sent after the last
MEP is deleted then looks like any other RTM_NEWLINK for the bridge,
and a listener can't tell that the CFM config is now empty.

Put an empty IFLA_BRIDGE_CFM nest in the message instead when CFM is
asked for and the bridge has no MEPs. Ports still get none, as before.

Signed-off-by: Abdul Wasey <w453y.me@gmail.com>
---
 net/bridge/br_netlink.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 5160e801d..68ec4529f 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -603,7 +603,10 @@ static int br_fill_ifinfo(struct sk_buff *skb,
 		struct nlattr *cfm_nest = NULL;
 		int err;
 
-		if (!br_cfm_created(br) || port)
+		/* A bridge with no MEPs gets an empty IFLA_BRIDGE_CFM, so a
+		 * listener can tell that the last MEP is gone.
+		 */
+		if (!IS_ENABLED(CONFIG_BRIDGE_CFM) || port)
 			goto done;
 
 		cfm_nest = nla_nest_start(skb, IFLA_BRIDGE_CFM);
-- 
2.53.0

