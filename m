Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA9C331A7B
	for <netdev@vger.kernel.org>; Sat, 25 Jul 2026 20:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785012129; cv=none; b=f90ZmpYl1kjdjYpvo5v0F1PcCNNrYregmjNkZ2U0YnueY2jJlleii6AF3WLYTHpceRMrJMS02J2xVcCYqUgH7Zi9OYNk3hpZ7ss4fq6Y3oWgy5pQRRZ9ZaaDR0GASTGPsKgK7rBQZRK1iu5lzxWeBKq8TBO/uanIeJ3XvmKuFVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785012129; c=relaxed/simple;
	bh=qZw9KoI/6S+/P0QeeER4mnpq5Kp0LMp8/kiWK81nCPc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XTIZb5KEK+TJLzhHWrU33VYcIARIixmyouRuLFJj+nCLzJt+toKP7Vg1yhXWtVt5bJdim14fz4nxkCfzSpNUfNiVuJz9JCSbb8DBvvgksCw+mK7mebvSBAfDxorsi15K9fvI6m8Mi9Yl00ejIdJlEsDJzoO6A9UyYMtgAPpIBL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AVPpQEmU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AVPpQEmU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE7A41F000E9;
	Sat, 25 Jul 2026 20:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785012128;
	bh=qEwXosTLOaG24TJ4Dcs3EuCGM4emZSACTBVJ5HxidrE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=AVPpQEmUlZu1TWIJidpY2bXpw3ZdEkPoznjwwtSDklIz15K+bYMzZdjkJYnDPY0Ki
	 oCn982BxIyx+pC6MLTQD+dQWzx47cQ7Rt1JIBPALUcRWVgtKa8LDusAoIWD4mR7s1i
	 ZQ1AFfS9I6ZVnD753tUu8cSBaFnOi9xKyLSDvgVtZ8vP1QajVVFyZzAuVO12t+S3lC
	 xmjMXBoQM7v8Z0AlyOiGl/cl6cI7sLLNRwwC1wjKBgD35bRHayUVU7VVtTUjjrpIOM
	 puuCEi0KW9LnqY7eoo4Kg4x7wl37J8kjxrR9drCkxg/hqHDMqPUjZNNdVMTsbYV935
	 p12HeikXBM8hA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sat, 25 Jul 2026 22:41:40 +0200
Subject: [PATCH net-next v12 1/3] net: airoha: rename airoha_priv_flags to
 airoha_dev_flags
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260725-airoha-ethtool-priv_flags-v12-1-5136a30b2157@kernel.org>
References: <20260725-airoha-ethtool-priv_flags-v12-0-5136a30b2157@kernel.org>
In-Reply-To: <20260725-airoha-ethtool-priv_flags-v12-0-5136a30b2157@kernel.org>
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

