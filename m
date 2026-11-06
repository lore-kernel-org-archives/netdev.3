Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794007140;
	b=yjr06bqlVJB/g9pUDFfHRfWKYzKk+M7QYUGv7diSDQQGwNp1lfpHLiex9mEd1vuFcaER
	 Ylh0cNlEFDEiPO1NIyU1+if5b8Aim1mix4/ij+Bgyfb6EY9n9BSGDsbMDSeRKCEYjImKa
	 rhb+q78ZdtoEcBCh4YghkeDy4pMFBXr1q+wVlbG8DFUbfEJU/fCfjGvrl/dQcTkIiQvFm
	 kzYJncCVHusMVwbqO+IrhvrZ+C8emMsVh05bH5cSmtCxDvS7/BNFlzGCG49dVjjEd3quy
	 Y9k7XYdPQ+zb7bVr1Mx6p0rTBQkSmm6mvUwzoX8n1lE3h0VRpuAwgn4UV/oGCt06Nww==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794007140;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=LeCeJW0Pqi3vrB4ccYEz7Em8dMhAh3G+2wJJVohz8bg=;
	b=eVporATqi8GrH2ycvaFvgqRVRZVck9Cw5KslJxTU78Qc+F3soPqjLTJ7c0ZIXROLkTFV
	 WF9O37+BHqvUyqznJiVTK8v1MnZQ5Rrt5nkXg96W2ubqMJ/6+piUoMzUHX9avfCgPDu4k
	 QcYa8YbvTi0fxAOdPrAvD8fF6G7PF9Y6t7sEe1pkBOAWiqy7AE221TJ4G7aPpZVSKBW7g
	 afK7UuoxFesqFfZ1Z6i5Vz6+Um2Xa8payXIy/2gj77WbAl3N7/ClZY2hK/sIO3d3edWHX
	 eazwUn/0DSs+MUW/NYk2Coqi/DE5Yi0Y7v62z3VYPAKHy6M78jZE76cSPRzNGPwBv4Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W4nhdfP8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DC5606D81C;
	Fri,  6 Nov 2026 23:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W4nhdfP8
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794007139;
	b=KHNUN9kJIAcR5tIpcO9ArDpldTtRFVCPu9kK3w8MnaoFuCKDGU1x63+wztKKFCaoEQEJ
	 zkDCtttSiTvW8MMy8r6DyjOAbm6XcBayoLuFH58TEv2CrCGk/V6TjMPkvBVHbsUoj4zfi
	 GxLNj4SSy+9QpCUAwf1AWeL4pcFU0OKp7ahKyfq0H48or9rOT3EJqjfdfAwfxeDP3nAFH
	 GHT2QgCoF8UpFoBBH5QFEFwuRXbz051PWc3vbDTaITngVcRTuqfkr25vA1qPuqT/R12FU
	 eOcv1N83+ECfa7LehCGTx99QOvFKDyeK/98He7pmx2mgf4C4TWDocRfNWmfBnM5WTzw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794007139;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=LeCeJW0Pqi3vrB4ccYEz7Em8dMhAh3G+2wJJVohz8bg=;
	b=V7DbyG/vqondsVSyo963pGmk3tmKCtwr1Ofj5tGlsDy6Xp5+yfZqUFHNyXSxog6OJdUF
	 oFDy39RmKSJ3z79piTBM/EYZPdb7zVqjtwZHCDN85laUCSoh0autwwCUSKW9whogQfsi3
	 qgI8ouCVXygwRpDmaGGWNbywEhIVmgspNpfECCPUMpcqIDHnBdlxfUyadypi08RLanN9a
	 eXBFd9ytnMjiylpBmGi/wOzmUR2LHOzY3//F1LRqHfGEvSDQiyHt5Y5FYAZNprcpr215G
	 A5+TXOQEHYjz9dXt9gmGMtXLur4CvZf1Q8F3cvK+K3Om0EkkPw13t6qVh3YjSr4yQcQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 7BC6B1F00921;
	Fri,  6 Nov 2026 23:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794007139;
	bh=LeCeJW0Pqi3vrB4ccYEz7Em8dMhAh3G+2wJJVohz8bg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=W4nhdfP8WBDe6aL+C6cUY9Gou5PWGaB3JsAoF5hK5RRKC1uhWlfH41DPv4K0Aex5x
	 oQtmZxDOoOHoTVLJuW45+taiDDPudB/lhzbPl0zOt3iEwnOCSOBl9mVXCXr6xrAA73
	 MDL+8WdzWlhZnMzhDyPqwG13wPK43THt+IpZ4ZnKj98ZsyutCkQPOuiymq8RzB/0wS
	 PI+FxyEM4O06GWyNIyDqgokXb4nfqUEYiYz8f1uAQuQ8ix30aM4tMBlMZGpkDeUnsN
	 uFhlpP81m44YSgGc1CNoO5HLmHXjdik8b1WLaBV6xD2QDgxQI/9YSsdcUGuC6FkNCN
	 wqPbj0t/aAlYA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 668A6478FC;
	Fri,  6 Nov 2026 23:18:55 +0000 (UTC)
From: Selvamani Rajagopal via B4 Relay <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Date: Fri, 06 Nov 2026 15:18:55 -0800
Subject: [PATCH net-next v10 09/11] onsemi: s2500: Added selftest support
 to onsemi's S2500 driver
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261106-s2500-mac-phy-support-v10-9-31b5a69b85b7@onsemi.com>
References: <20261106-s2500-mac-phy-support-v10-0-31b5a69b85b7@onsemi.com>
In-Reply-To: <20261106-s2500-mac-phy-support-v10-0-31b5a69b85b7@onsemi.com>
To: Selva Rajagopal <selvamani.rajagopal@onsemi.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Richard Cochran <richardcochran@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Eric Dumazet <edumazet@kernel.org>, 
 Piergiorgio Beruto <piergiorgio.beruto@gmail.com>, 
 Eric Dumazet <edumazet@kernel.org>
Cc: Selva Rajagopal <Selvamani.Rajagopal@onsemi.com>, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Jerry Ray <jerry.ray@microchip.com>, 
 Ciprian Regus <ciprian.regus@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794007133; l=1948;
 i=Selvamani.Rajagopal@onsemi.com; s=20260531; h=from:subject:message-id;
 bh=Q0wyqn5Hg54FegeMMR6fxbllhqIRTXa29mMs6gTL5tE=;
 b=EoU4iR7hd2YKxNcgTxt+cl04PuP80YCZ5hOPgAJjmZk5piiKLH7a9/CEz9gN+IfMc+a8mK/Co
 3RPA+ojQZW1B6lBU+3duklsHBrQIh9HmxnV174KwzmHyKPvS7oenZT9
X-Developer-Key: i=Selvamani.Rajagopal@onsemi.com; a=ed25519;
 pk=5QRdM0HS/LGWWcUZZ9hVfZ+qbPQGZCumcTXOiN7Fyug=
X-Endpoint-Received: by B4 Relay for
 Selvamani.Rajagopal@onsemi.com/20260531 with auth_id=803
X-Original-From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Reply-To: Selvamani.Rajagopal@onsemi.com
Content-Transfer-Encoding: 7bit

From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

Adds selftest support for onsemi S2500 MAC-PHY. Added as a separate
patch for the ease of review.

Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

---
changes in v10
  - Added a check for CONFIG_NET_SELFTESTS before returning the
    count value
changes in v9
  - Added net_selftest entry to the ethtool_ops in the correct patch
changes in v8
  - No change
changes in v7
  - No change
changes in v6
  - Moved the signed off information to the correct place.
changes in v5
  - No change
changes in v4:
  - Added a selftest as a separate patch
  - First patch
---
 drivers/net/ethernet/onsemi/s2500/s2500_ethtool.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/onsemi/s2500/s2500_ethtool.c b/drivers/net/ethernet/onsemi/s2500/s2500_ethtool.c
index 062cab9460dc..4e42b4748c46 100644
--- a/drivers/net/ethernet/onsemi/s2500/s2500_ethtool.c
+++ b/drivers/net/ethernet/onsemi/s2500/s2500_ethtool.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/ethtool.h>
+#include <net/selftests.h>
 #include <linux/phy.h>
 
 #include "s2500_hw_def.h"
@@ -201,6 +202,10 @@ static int s2500_get_sset_count(struct net_device *ndev, int sset)
 	switch (sset) {
 	case ETH_SS_STATS:
 		return S2500_MAC_STATS_LEN;
+	case ETH_SS_TEST:
+		if (!IS_ENABLED(CONFIG_NET_SELFTESTS))
+			return -EOPNOTSUPP;
+		return net_selftest_get_count();
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -214,6 +219,9 @@ static void s2500_get_strings(struct net_device *ndev, u32 stringset,
 		memcpy(buf, s2500_mac_stat_strings,
 		       S2500_MAC_STATS_LEN * ETH_GSTRING_LEN);
 		break;
+	case ETH_SS_TEST:
+		net_selftest_get_strings(buf);
+		break;
 	}
 }
 
@@ -372,5 +380,6 @@ const struct ethtool_ops s2500_ethtool_ops = {
 	.get_ts_info = s2500_get_ts_info,
 	.get_regs_len = s2500_get_regs_len,
 	.get_regs = s2500_get_regs,
+	.self_test = net_selftest,
 };
 

-- 
2.43.0


