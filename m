Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AE443D4E9
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 20:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784753063; cv=none; b=lyQz6C94x2QWWnoG5T3WcZwjeb07lmjJSUWY1P96cmlOAZT13LJ8CTwYS7oCcC3X7B+Hq9OzHHVgT1E53Y4Betm5Hv0+WN4cDKadvuQ02I0gmYGUNZPtm8ldaFdAfjUkbZoMEWjSepSimS1v9YObeDYApnEDJhg92f8fgnFaKow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784753063; c=relaxed/simple;
	bh=0Zlmhninie/D9TRflmLm+EsRF+kAisYvD/lFxeS76Qs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H/uFkW3FHEOus7XlK4pRJvcQYmgu87eoDX9SR39ro51sGNMoaHMa9Lvb1ZnNuWBnapNQr9CXdT+0Ed6ZlRDGM0CfQcFak/X05ZhVrb731d9AbiIJUxb/iPL2FRKWk13coHVee/lSY7mC12Fe/zLvv5Fii6aEFYIXZnhlEQBD1Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TClIpQjP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TClIpQjP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 242031F000E9;
	Wed, 22 Jul 2026 20:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784753061;
	bh=B3rErr10p9wOACNt+wLol9UrYf5v0rNYumxMy4SRbfs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=TClIpQjPHfNb2UC+86DccO1ZrMk2+zy5rLUTHbdUN31XdnfQmEyzF0g00UYVJvCt4
	 FXhV4YAcs5lWiKtyTP2/gpdsVZW7ab/ZGgLSaH0Q2SUFy141vcrOpLy6haasxqnace
	 6hhwS6L9eGbDYygci9yZTfTRBGHXkgZpaJcVmMhumYjv07vi2jDBbTYnEGPhr/JYiA
	 AiFqAUMG4h1dchH/GhbOXm4fscuN2vH0YcCHEUJpkTTtubdQ3HFcREsOzPasDqLqG0
	 MaMTXTfHgA9P07wMsqz+1DaUoobIBHqX3iXyFQ8EbvjqU0/peqdI1ZCDe5rMPbRuP7
	 ez0lmxyiPoqZQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 22 Jul 2026 22:44:00 +0200
Subject: [PATCH net-next v10 1/3] net: airoha: rename airoha_priv_flags to
 airoha_dev_flags
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-airoha-ethtool-priv_flags-v10-1-d2562c5dd942@kernel.org>
References: <20260722-airoha-ethtool-priv_flags-v10-0-d2562c5dd942@kernel.org>
In-Reply-To: <20260722-airoha-ethtool-priv_flags-v10-0-d2562c5dd942@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Simon Horman <horms@kernel.org>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 netdev@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.14.3

Rename the airoha_priv_flags enum to airoha_dev_flags and the
AIROHA_PRIV_F_WAN flag to AIROHA_DEV_F_WAN. The "priv_flags" naming
dates back to an earlier design that used ethtool private flags; since
this series switched to tc qdisc offload for LAN/WAN configuration,
align the naming to reflect that these are per-device flags rather than
ethtool private flags. No functional change.

Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 2 +-
 drivers/net/ethernet/airoha/airoha_eth.h | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 59001fd4b6f7..41c1a0ffbdd8 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -2039,7 +2039,7 @@ static int airoha_dev_init(struct net_device *netdev)
 		fallthrough;
 	case AIROHA_GDM2_IDX:
 		/* GDM2 is always used as wan */
-		dev->flags |= AIROHA_PRIV_F_WAN;
+		dev->flags |= AIROHA_DEV_F_WAN;
 		break;
 	default:
 		break;
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index f6d01a8e8da1..bf1c249255bd 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -543,8 +543,8 @@ struct airoha_qdma {
 	DECLARE_BITMAP(qos_channel_map, AIROHA_NUM_QOS_CHANNELS);
 };
 
-enum airoha_priv_flags {
-	AIROHA_PRIV_F_WAN = BIT(0),
+enum airoha_dev_flags {
+	AIROHA_DEV_F_WAN = BIT(0),
 };
 
 struct airoha_gdm_dev {
@@ -667,7 +667,7 @@ static inline u16 airoha_qdma_get_txq(struct airoha_qdma *qdma, u16 qid)
 
 static inline bool airoha_is_lan_gdm_dev(struct airoha_gdm_dev *dev)
 {
-	return !(dev->flags & AIROHA_PRIV_F_WAN);
+	return !(dev->flags & AIROHA_DEV_F_WAN);
 }
 
 static inline bool airoha_is_7581(struct airoha_eth *eth)

-- 
2.55.0

