Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7F636896F
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 15:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779809756; cv=none; b=AhNJfKbYjmsAZDICqR3Y/ComYCrHlvq/NGovU7Ib8fWQ36Ov0McOeGOcbmwmB3vWSfPyYmx2uaFafuMoLnT92nvZPQINGB9P85Oqc/6SiecH8NBnSw+C0N7qqEMct/+lcZcfFS+o/7ZbtJSxOMsjDAmp4UkPO2iHgAtU5ahMKoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779809756; c=relaxed/simple;
	bh=Li2ucb20mKjlh+iJAcNYn+SzafHJSJKo9g/ddo8PS0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SjEPoVaGwjvFO65k2FowSWHNVM99vB/TaM3k9JFwsf4KMDaxcpoWfMyJ0ydQf+ku7kWhUeEMfd/VRQLowDZcq3eTqtbm20/65eXvA8WKDefsVwoIEg9ULU5JTVfhEIfxvzZsw+f488QII4cwjUGKRyFGnwbyYo1LILQ1MgVO/GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=golv54UP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="golv54UP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B0FB1F00A3D;
	Tue, 26 May 2026 15:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779809751;
	bh=7FrEx+vAYEIpeQKhLdHTCiup43jXebzWWN2wOMbDBfE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=golv54UPZgbcgV15lGWLE+CfzkUD4H2fDfae9Rv82eSJVHmrMpQ/Berztberq6Che
	 ganvUQbksOzx/B6x8PlDCQp8ZltAC45AlIQusd68cdt6PJnEXD41PE4zXXZ9WOcaKZ
	 XJPEMu1ra0DAlN5s8gkqFS/Vf7PtuIvJi7Sy1Z1bX1X8q2ItcDewm0P+8AZMWah+6N
	 zm6NKfQebhcHkGLnb5oN7ezpti7fftw9/iQETpdWjYR0FZy2o2fnBukCN0rmNyvXI7
	 Q/PavX6/a48R7QiYtECx4pOOOMfrJYEDMR7LvOXWAw8vNP6jnTeHXrcwULMXBgPKyO
	 x9M2rvTkW66Kw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	o.rempel@pengutronix.de,
	kory.maincent@bootlin.com,
	maxime.chevallier@bootlin.com,
	haiyangz@microsoft.com,
	Jakub Kicinski <kuba@kernel.org>,
	andrew@lunn.ch,
	chleroy@kernel.org
Subject: [PATCH net 04/10] ethtool: pse-pd: fix missing ethnl_ops_complete()
Date: Tue, 26 May 2026 08:35:27 -0700
Message-ID: <20260526153533.2779187-5-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526153533.2779187-1-kuba@kernel.org>
References: <20260526153533.2779187-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pse_prepare_data() is missing ethnl_ops_complete() if
ethnl_req_get_phydev() returned an error. Move getting
phydev up so that we don't have to worry about this
(similar order to linkstate_prepare_data()).

Note that phydev may still be NULL (this is checked in
pse_get_pse_attributes()), the goal isn't really to avoid
the _begin() / _complete() calls, only to simplify the error
handling.

While at it propagate the original error. Why this code
overrides the error with -ENODEV but !phydev generates
-EOPNOTSUPP is unclear to me...

Fixes: 31748765bed3 ("net: ethtool: pse-pd: Target the command to the requested PHY")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: o.rempel@pengutronix.de
CC: kory.maincent@bootlin.com
CC: andrew@lunn.ch
CC: maxime.chevallier@bootlin.com
CC: chleroy@kernel.org
---
 net/ethtool/pse-pd.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/ethtool/pse-pd.c b/net/ethtool/pse-pd.c
index 2eb9bdc2dcb9..757c9e0cc856 100644
--- a/net/ethtool/pse-pd.c
+++ b/net/ethtool/pse-pd.c
@@ -62,14 +62,14 @@ static int pse_prepare_data(const struct ethnl_req_info *req_base,
 	struct phy_device *phydev;
 	int ret;
 
-	ret = ethnl_ops_begin(dev);
-	if (ret < 0)
-		return ret;
-
 	phydev = ethnl_req_get_phydev(req_base, tb, ETHTOOL_A_PSE_HEADER,
 				      info->extack);
 	if (IS_ERR(phydev))
-		return -ENODEV;
+		return PTR_ERR(phydev);
+
+	ret = ethnl_ops_begin(dev);
+	if (ret < 0)
+		return ret;
 
 	ret = pse_get_pse_attributes(phydev, info->extack, data);
 
-- 
2.54.0

