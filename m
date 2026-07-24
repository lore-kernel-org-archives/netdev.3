Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE37E411F86
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 14:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784902752; cv=none; b=d60j5+fiChbqz4DD/6gK2bJIfEZ4256vx9Ry0lxDjIQHz++UXOU0BwNGDa8LZNZhjBYrgY9zn/bf07978UbdVOKwm8qD+WwPwyoIloEkLuqsiR92EQDZWv0xqdE7AGYnliOfjNw81uX8IdM4G7cwR2ddzuv7/6BauHmZi2mnMwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784902752; c=relaxed/simple;
	bh=qZw9KoI/6S+/P0QeeER4mnpq5Kp0LMp8/kiWK81nCPc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W4rhJR1hiPBN0V7dcJYveOwE8zl58iPBkenq17p7eQ0aVmNSLVuKjxs4dkScvSZ5FD0VvcLJ2+PbCBKZ56s0neaC4LydlEPV1OM9p87GNO8JMixbDjpE1tgdKqQbhwb8/7P3UeYxX8Kvnc8DZUU/Arm1KF6aCfGwyD4Ivnq4ElE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=evAnYCzP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="evAnYCzP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02A731F000E9;
	Fri, 24 Jul 2026 14:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784902750;
	bh=qEwXosTLOaG24TJ4Dcs3EuCGM4emZSACTBVJ5HxidrE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=evAnYCzPHtJcd6LD59TB/ElmLQSdZMO4EIZX69jYVLUrHafscgJPIDKLCbzhJ4sPn
	 acrU7foKIrsr2LcDXwyWmH7zq6U+khqHOmrFl/zybOFe1xY/vg4hennAgQuL2HTEow
	 dNZOysEcsr6SMFCBY2kx9Pop80stUib4uy0cop9C/wLUfFGmH8XVExL3VV83kgbWAQ
	 BJKnSc84BB7PBcTOuPOoakJXlTcIYJRvgwAM/gS4CdITlZC1yX0JPcqps0Ls86SGJy
	 6BL5oQmbX9bazRpG0sm9UccEX2YY1B+rl9310H11KTKf4ysjjIMLaN0fIYU92PmVCn
	 VdNlST8UO27Gg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 24 Jul 2026 16:18:56 +0200
Subject: [PATCH net-next v11 1/3] net: airoha: rename airoha_priv_flags to
 airoha_dev_flags
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-airoha-ethtool-priv_flags-v11-1-686dea300a40@kernel.org>
References: <20260724-airoha-ethtool-priv_flags-v11-0-686dea300a40@kernel.org>
In-Reply-To: <20260724-airoha-ethtool-priv_flags-v11-0-686dea300a40@kernel.org>
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
ethtool private flags.

While at it, switch to test_bit()/set_bit()/clear_bit() APIs and
convert the flags field from u32 to unsigned long to make flags
manipulation atomic.

Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 2 +-
 drivers/net/ethernet/airoha/airoha_eth.h | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 79418e682f71..d9a44a11d8db 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -2078,7 +2078,7 @@ static int airoha_dev_init(struct net_device *netdev)
 		fallthrough;
 	case AIROHA_GDM2_IDX:
 		/* GDM2 is always used as wan */
-		dev->flags |= AIROHA_PRIV_F_WAN;
+		set_bit(AIROHA_DEV_F_WAN, &dev->flags);
 		break;
 	default:
 		break;
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index fe934f9ffe8a..24dd16fc509a 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -570,8 +570,8 @@ struct airoha_qdma {
 	DECLARE_BITMAP(qos_channel_map, AIROHA_NUM_QOS_CHANNELS);
 };
 
-enum airoha_priv_flags {
-	AIROHA_PRIV_F_WAN = BIT(0),
+enum airoha_dev_flags {
+	AIROHA_DEV_F_WAN,
 };
 
 struct airoha_gdm_dev {
@@ -584,7 +584,7 @@ struct airoha_gdm_dev {
 	u64 cpu_tx_packets;
 	u64 fwd_tx_packets;
 
-	u32 flags;
+	unsigned long flags;
 	int nbq;
 
 	struct airoha_hw_stats stats;
@@ -694,7 +694,7 @@ static inline u16 airoha_qdma_get_txq(struct airoha_qdma *qdma, u16 qid)
 
 static inline bool airoha_is_lan_gdm_dev(struct airoha_gdm_dev *dev)
 {
-	return !(dev->flags & AIROHA_PRIV_F_WAN);
+	return !test_bit(AIROHA_DEV_F_WAN, &dev->flags);
 }
 
 static inline bool airoha_is_7581(struct airoha_eth *eth)

-- 
2.55.0

