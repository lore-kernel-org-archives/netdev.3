Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC722EEE9D
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 22:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784585064; cv=none; b=nFU5LZliy6z1FV2lMMiLJ+eWO8tLDXEeve8CXK5Uqg54wiOC56hIPV1AYFJZaecCiEyS+7fYegVaVGQa1DQce3vCoxMeaffzo42SzGnaiLtqRFqaLOTzG9+QJgXnE/QwetETLYFVvwbQERT3M8KesNNt735KvkD8cLb06XsiTW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784585064; c=relaxed/simple;
	bh=e5ZcprGmTKouJsqT1P+dINR12VwrsyrBuWfz3/ybNdY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OxbijfTDxsz1YiMs464SGdX6lBLUvEWvrprs+NhF90Od6NDg4TG83tS/PtyzxxUjFf01agFWt4G5UcNu/QbNBj279S1vPfrWiNz/fKs2pmzNQiG9ORHipiENoGoIsffOFPxuYXdJomOag7WQI67p4w2kk5DFwhsDQMUYfrZ9drE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MkGhsYiW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MkGhsYiW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 976521F000E9;
	Mon, 20 Jul 2026 22:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784585063;
	bh=uu5RM4d1V94/PPWT88IgE52BpBBsPP0bpENjQZ3Pp98=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=MkGhsYiW1s12sYffPhLg+73t0v5d6FlfY6mmzcv9yjV14R5veT6tB8UD0w5OCBIoD
	 2vWQLQM5dJo8S1PK/btXlle2o1rWtcbj4Sxg/VCnlrHjYx0nim+cG0LQCWH1SRDWn4
	 b7DKqNRkOQeu1TXYrWkAUc4wZHZb9KLhAK02ra7kT28Jb78ywZDBBUpMQidwnmmQdI
	 uL3MvKDUD8j1v6cw1EcROh+yhQCVjKFTtqsyqVtHNBuoQ+eXR97wQ1y4f01yaHDsqi
	 mqw1cdrisfPJptG5UyleJHOu9UXD85B3+Dj1iEdV8NjFF7w7XHGHotuMrykaWK7NPK
	 FYI/gbwxLtuKA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 21 Jul 2026 00:03:35 +0200
Subject: [PATCH net-next v9 1/3] net: airoha: rename airoha_priv_flags to
 airoha_dev_flags
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-airoha-ethtool-priv_flags-v9-1-9c15d8b71a56@kernel.org>
References: <20260721-airoha-ethtool-priv_flags-v9-0-9c15d8b71a56@kernel.org>
In-Reply-To: <20260721-airoha-ethtool-priv_flags-v9-0-9c15d8b71a56@kernel.org>
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

Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
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

