Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.88.38.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794392860;
	b=xdSi5e6rq+hvRo2F2I7+qCLo1El8nhv5JGbviVa7OYKzhdnMKCEAgyq6zG9Z6EkjSiCD
	 ghnhtP2m5vr276/O724olBvei2rBGtuVal5i45/v+06/dIMsm+Iz4YLaek90dWzRgKZRa
	 ZM4PZCU51iUVlOiwlYsWOHUXDu8vBl0KgVXtyhpEyDNWfVUDPLT6KyzmIiGJDFtRqip2Q
	 boqoQRNlGdVkQC4xnOYPOcLVK6eBGt35CUdHu6dCON4VZzOAvbTYPIHA1KPC+oNc4yDa9
	 b2+9NQ7ONOpUa/xnxh1QXRz6MM4LzUTSHs93ICts/vkT2PufwSHOadYhdZ+jAg3Fwlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794392860;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=HljEgh7Ck6LSl06ejQODxRbfgqi7X5YtOB5itCLKdOU=;
	b=adALq5ukJgbaHeSyTybG2mHxMfMAO+dphHFYU+BuY9fNCLlU5wCJ5Mrf56q8bwPbZto9
	 f7JEbsVMn5Xh/OsQ02ASvC/6wAIEroN2rmBGnMv9E3w+0S5cSi3WSS3g5zIg3WZCA5ocX
	 Oof4DZ7mrRlg0F1unEnfvhTzpYgi9KnUs2QjvNSO/x3zFLvUnPRng1g8CoqPlWh+nrByj
	 EGRhHG1i1ESIMr8eOEc55okXU9+9vPV/Ul0//tSfgCxyModaVjzPiMmzSJD+QF3cMAJOU
	 ql+OEFD3BDBvWuehEI80WdLhewVdvvPGsEQdNH/pBiNqtScbNI4NYgB38GVUhIfBy3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simonwunderlich.de;
	spf=pass smtp.mailfrom=simonwunderlich.de;
	dkim=pass header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=jl3spfgs;
	arc=none smtp.remote-ip=23.88.38.48
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 1561F606A326
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 10:27:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1561F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=jl3spfgs
Received: from kero.packetmixer.de (p200300c59740deD843BE7e4a980E9c65.dip0.t-ipconnect.de [IPv6:2003:c5:9740:ded8:43be:7e4a:980e:9c65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id B6600FA112;
	Wed, 11 Nov 2026 11:27:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1794392852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HljEgh7Ck6LSl06ejQODxRbfgqi7X5YtOB5itCLKdOU=;
	b=jl3spfgsr0g3OoqjUiEqZON+IaYXqi/1A5JlwfKjvZDPXI+BNEeJG82Sx4F+WtnIQXcuU7
	ppsNSfR/JGcfjBOw6gZ17wkKsdZwpHyqkWSkbrZGKls2VxySIrgdlzaqK5I7Pckbg63eNj
	7P/K6+AVFNaanfRCNjnq7lvIP44nGsvOdXjYgcDs+Uyu3+HXkxKbkBr4qYtme4WqD5Y4FJ
	xA6menFhbMdYppWR660rLak13EX8MuG6Agu6PLBPC1vDwMatBahDgTY4CxBp0FFx7I03rB
	qMJqv9MB3PE7R500R20932WvFE+fSC5o2ALGn6p4eVXlYDxYK8AJtrciy+vQpg==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	=?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 02/15] batman-adv: mcast: explicitly initialize mcast.want_all_rtr{4,6}_list
Date: Wed, 11 Nov 2026 11:27:16 +0100
Message-ID: <20261111102729.2096241-3-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261111102729.2096241-1-sw@simonwunderlich.de>
References: <20261111102729.2096241-1-sw@simonwunderlich.de>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Sven Eckelmann <sven@narfation.org>

All mcast.want_*_list are initialized in batadv_mesh_init() - with the
exception of mcast.want_all_rtr4_list + mcast.want_all_rtr6_list. At the
moment, it works because INIT_HLIST_HEAD just initializes it to NULL and
the netdev private data is already set to 0 before being passed to
.ndo_init.

For consistency purposes, also initialize mcast.want_all_rtr4_list +
mcast.want_all_rtr6_list explicitly.

Acked-by: Linus Lüssing <linus.luessing@c0d3.blue>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 3b9fa861be7be..cae2a48fa0ad9 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -216,6 +216,8 @@ int batadv_mesh_init(struct net_device *mesh_iface)
 	INIT_HLIST_HEAD(&bat_priv->mcast.want_all_unsnoopables_list);
 	INIT_HLIST_HEAD(&bat_priv->mcast.want_all_ipv4_list);
 	INIT_HLIST_HEAD(&bat_priv->mcast.want_all_ipv6_list);
+	INIT_HLIST_HEAD(&bat_priv->mcast.want_all_rtr4_list);
+	INIT_HLIST_HEAD(&bat_priv->mcast.want_all_rtr6_list);
 #endif
 	INIT_LIST_HEAD(&bat_priv->tt.changes_list);
 	INIT_HLIST_HEAD(&bat_priv->tt.req_list);
-- 
2.47.3

