Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18ED3CC300
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 08:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782893406; cv=none; b=GtuzqjT+4B3rHvO69ZkU5WHrv+qIlJN9yaEKFygwvDrglwHtkrT086qPMT4ptZpV1lkzue+z65OD9ep2u8+VScMIe86uvH4HlxeIAMldorvzvMLJ7mnLjB5/joDx4JC56vxcyQDwO0oYROY5a13rxE0bJgjjwP6MHXWojLHKChk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782893406; c=relaxed/simple;
	bh=63LWPd+FC+X6rTYjfIbYEdJS5O6PYuFKs+heGMVatFI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aVSa9TbRjYmcZpyAQF6T3dVqr1ifpLFJJlCvjYVp7lRVhJkrhU0c30X1Q9hKPsKpJ59at/hF+qq2fVjmZA4luHkmJa9AZG2A9nm88q4QLweb/2FkuYTa1pzicQL0V5ugsRgf105hfKZ+WDJEojsS7kKjsXioC9UdRVT0A17kitk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DkRC/j6P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DkRC/j6P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 170A91F000E9;
	Wed,  1 Jul 2026 08:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782893404;
	bh=lRmRx3E2TRD6nMHlslynO/JAwSkEz+lHHJvdgNM8QVs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=DkRC/j6P5kB3e9+MoIo7spZkiEMR4v/KTOdKZ8o6f6Yk+8zwinsjmbDAN0Qy8P8G1
	 LhCOqGdjd0iubyi5B+VcGiRlxc03k+GM9YZpccVQ+o9uEhV01698TlzqIfOgx8yslb
	 50VYq9nBmtP7NzRUuog9X4vygxDHtjlR9KjdIIDsiB6FZUB+NFrv6CTBTfCy+fkV8R
	 mR/Kopr9mUbxcVRtC19qyY2UG6OwfXo+31tU8hiqsQb+kokSHEWYy9G1ln8RNHVNaC
	 rJbYfAUGLrrYaknHIiO9EIzNJkXVcXpS0ZO/gfc2VStukvCc2Fp0IEz8vWKJSzg27c
	 qYqYUeQgSrFAQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 01 Jul 2026 10:09:25 +0200
Subject: [PATCH net-next v7 1/3] net: airoha: rename airoha_priv_flags to
 airoha_dev_flags
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-airoha-ethtool-priv_flags-v7-1-b4153bd44428@kernel.org>
References: <20260701-airoha-ethtool-priv_flags-v7-0-b4153bd44428@kernel.org>
In-Reply-To: <20260701-airoha-ethtool-priv_flags-v7-0-b4153bd44428@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Simon Horman <horms@kernel.org>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 netdev@vger.kernel.org
X-Mailer: b4 0.14.3

Rename the airoha_priv_flags enum to airoha_dev_flags and the
AIROHA_PRIV_F_WAN flag to AIROHA_DEV_F_WAN. The "priv_flags" naming
dates back to an earlier design that used ethtool private flags; since
this series switched to tc qdisc offload for LAN/WAN configuration,
align the naming to reflect that these are per-device flags rather than
ethtool private flags. No functional change.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 2 +-
 drivers/net/ethernet/airoha/airoha_eth.h | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 932b3a3df2e5..8bba54ebcf07 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -2048,7 +2048,7 @@ static int airoha_dev_init(struct net_device *netdev)
 		fallthrough;
 	case AIROHA_GDM2_IDX:
 		/* GDM2 is always used as wan */
-		dev->flags |= AIROHA_PRIV_F_WAN;
+		dev->flags |= AIROHA_DEV_F_WAN;
 		break;
 	default:
 		break;
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index d7ff8c5200e2..87ab3ea10664 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -535,8 +535,8 @@ struct airoha_qdma {
 	DECLARE_BITMAP(qos_channel_map, AIROHA_NUM_QOS_CHANNELS);
 };
 
-enum airoha_priv_flags {
-	AIROHA_PRIV_F_WAN = BIT(0),
+enum airoha_dev_flags {
+	AIROHA_DEV_F_WAN = BIT(0),
 };
 
 struct airoha_gdm_dev {
@@ -659,7 +659,7 @@ static inline u16 airoha_qdma_get_txq(struct airoha_qdma *qdma, u16 qid)
 
 static inline bool airoha_is_lan_gdm_dev(struct airoha_gdm_dev *dev)
 {
-	return !(dev->flags & AIROHA_PRIV_F_WAN);
+	return !(dev->flags & AIROHA_DEV_F_WAN);
 }
 
 static inline bool airoha_is_7581(struct airoha_eth *eth)

-- 
2.54.0

