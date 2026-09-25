Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6184BC007;
	Fri, 25 Sep 2026 15:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790349151; cv=none; b=qJ9p9iEaB1KXMnhNB4XDk2f6PFmVkX5jfjKkY2EUnJWY74Vl/kO2l5b17BNTQEe8I83fRRdfEY8QHMlVxzmx5lDNQ1lSvSaOr3wcFrGPrWiJIcxKq732Jqg21ZYnGDZVsWG6xNM/Xe5LMr9NVd8SLLhvEqtX12uYILbsHFI5KDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790349151; c=relaxed/simple;
	bh=TJ2/gTRiRoF8Qx7Q+GjxSPVmL5qqx28RUz8ON4l6uvw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eNi28O3lOqpgCZhWJjVenYg8ouItH3zkQVhG9xwuKnbCN9p0AxzdtuMyBidJH8gYeMbkR+PnMorvnSxfV78pWVZqReTUTnFQ5SPTReamiheS6OIcX7t7Lx0npT9WRka2LbGpq+GJvAcoN48c4tkJhMO3/1OFqacQbb3EXXM94Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pe0CtPYA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pe0CtPYA"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BBCB4C2BCF6;
	Fri, 25 Sep 2026 15:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790349149;
	bh=TJ2/gTRiRoF8Qx7Q+GjxSPVmL5qqx28RUz8ON4l6uvw=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=pe0CtPYANUIefLNaEAW2gSQAaNXuaXEQ1xNv22jmWyyXh0WYaVa7k1358xjTSNqQS
	 by6ViMN1NKztTyQWQOreeMQfZrYm18+nVxpmqj/MSALrHKC/xAXiPwE1tRtFmIEJh+
	 brtmBbfgP8620IBtBhPv2QFEP2qukmu4rMOV59usMwAttje2pEQTckJLvTxbpdmxub
	 lZao6JydDsuwVHiL4IzQyDSGkWtXRMJJ2GuTWanEs7IJMKV9yYQpSiwqMV0LPl17b4
	 R/sIA7u9pQXQ6z28FBZ+mVjJfpd0O+M3Cma0cncY9OcuSk6CR6XqQJnrzPeSHfh9Sb
	 SKwYPxqUKlPOw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9663BC9830E;
	Fri, 25 Sep 2026 15:12:29 +0000 (UTC)
From: Kyle Hendry via B4 Relay <devnull+khendry.reliablecontrols.com@kernel.org>
Subject: [PATCH net-next 0/2] net: pcs: rzn1-miic: Validate dtb
 configuration values
Date: Fri, 25 Sep 2026 08:12:05 -0700
Message-Id: <20260925-miic-validate-dtb-v1-0-3a6db9bb75ec@reliablecontrols.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEWPtmoC/x3MSQqAMAxA0atI1gZqFaeriIsOUQNapS1FEO9uc
 fkW/z8QyDMFGIsHPCUOfLqMqizAbMqthGyzQQrZikE2eDAbTGpnqyKhjRr1Yhpd90J3vYTcXZ4
 Wvv/nBI4iOrojzO/7AZC82ZJtAAAA
To: =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <clement.leger@bootlin.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kyle Hendry <khendry@reliablecontrols.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790349149; l=806;
 i=khendry@reliablecontrols.com; s=20260813; h=from:subject:message-id;
 bh=TJ2/gTRiRoF8Qx7Q+GjxSPVmL5qqx28RUz8ON4l6uvw=;
 b=5ywa4mW0gAbU8H+APXL2Ev1Jiq69YYjIbJ8ck0lqbdajhzLPUSlerUEjiR0pU/YhaKU547TxK
 ArfQ2m71h1lBrSykqxWqM9lxVwriiSQ8pOYyB/H5UIcWV1dTJP9DgyK
X-Developer-Key: i=khendry@reliablecontrols.com; a=ed25519;
 pk=gbK6oghz3qBlBiaGCsEzALLOtj5VklmsuolHQNhDV5M=
X-Endpoint-Received: by B4 Relay for khendry@reliablecontrols.com/20260813
 with auth_id=946
X-Original-From: Kyle Hendry <khendry@reliablecontrols.com>
Reply-To: khendry@reliablecontrols.com

This series addresses issues found when reviewing another fix:
https://lore.kernel.org/netdev/20260915-rzn1-miic-fix-array-v5-1-b7173fd5b97d@reliablecontrols.com/

Invalid values from the dtb could cause out of bounds array access. Checking
the values as they're parsed should prevent this.

Signed-off-by: Kyle Hendry <khendry@reliablecontrols.com>
---
Kyle Hendry (2):
      net: pcs: rzn1-miic: Make usage of miic_port_max consistent
      net: pcs: rzn1-miic: Validate dtb configuration values

 drivers/net/pcs/pcs-rzn1-miic.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)
---
base-commit: 42a9fb3382fc2573e92f41d203b095d9a372cfc9
change-id: 20260924-miic-validate-dtb-bfc4b380b782

Best regards,
-- 
Kyle Hendry <khendry@reliablecontrols.com>


