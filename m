Received: from mail-24427.protonmail.ch (mail-24427.protonmail.ch [109.224.244.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E3D37FF48
	for <netdev@vger.kernel.org>; Sat,  3 Oct 2026 08:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791015511; cv=none; b=T+F1PPyv+PKgpPcWWEX95YVNUI+haUn1kASSbu9vHB/U3hR9rqhqxgnEPBm8ascQRGhC8t4ERrdrB2t4+WaQarTJXvn5Ck5Rlmoh0SaFwMqalTkEYwZI4YpWD81vxw2cYmniolT7LQwAeW7dkUzrmyiK2zT+hxKyjGW5XnZ6Ak4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791015511; c=relaxed/simple;
	bh=xBzJEkqpbm553jn0OaGDHQjKkx4MFvLAXpkGc+8QPWU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JovhQuWS4awh2JkvD7gJYPSRlXYIypLOiZ7OtGCNHG9Q1DPwGuRUO0A3vtb+RKV8s2lsv6yZaVPPrVP9hVJFCRJqxJM7ykh5r7923hKjwdOEYY7KNWz9aQ8piStl5QYeFAF71fP8+yPMyktTG/sWrWx8VB/T4+Q6SO09zVNmdZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=nHTEVBrN; arc=none smtp.client-ip=109.224.244.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="nHTEVBrN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1791015503; x=1791274703;
	bh=xBzJEkqpbm553jn0OaGDHQjKkx4MFvLAXpkGc+8QPWU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=nHTEVBrN5Z/h4WSgOqPWZIxQyi6apyoaeTsv2M4O71ZTNf8kDsQ4Cn3vXzdIWOhBd
	 RxTDgxKQOvoeTGtEKE1qAhGeEa7p/VsN0WF5c4wd4TbB0wsjlWYKt0sBtE70984z5u
	 DUIDFAixGVLvXlXhKaDPyxkCPdGtJHaPcO8S44TUVdBgT1REnx+A2L9p8lcc7n0W/s
	 V7WM4Rvjth/oUexZR+7HXjTokgukQ57hHAqOQ5HwAbUs07+lglLU0MILXbZi6WcWK1
	 wKJ07KoS4IzFe/YMFOMWdFZ51KbgYU5wXCTOrTgaoHYV+pPZu5t8FL5uv/K3oT9HnB
	 JK2ZZLZyJmA8Q==
Date: Sat, 03 Oct 2026 00:08:01 +0000
To: netdev@vger.kernel.org
From: iugfdin <iugfdin@proton.me>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net 2/2] r8169: flush pending transmit packets when an skb is dropped
Message-ID: <179098478410.1174319.17923728268629391314.r8169-2@proton.me>
In-Reply-To: <179098478409.1174319.4377246796187959500.r8169-cover@proton.me>
References: <179098478409.1174319.4377246796187959500.r8169-cover@proton.me>
Feedback-ID: 225708956:user:proton
X-Pm-Message-ID: c71b5c56695a88b852d35f3e9d360f30a1967e09
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

rtl8169_start_xmit() can defer a transmit poll when xmit_more is set.
If a later skb fails preparation or DMA mapping, the shared error
path drops it without issuing that deferred poll. If the failed skb
ends the batch, previously committed packets can remain pending
until another packet or recovery path kicks the device.

Issue a transmit poll after cleaning up the failed skb so earlier
packets can make progress. The failed skb still does not advance
the producer index or contribute to BQL accounting.

Fixes: ef14358546b1 ("r8169: make use of xmit_more")
Assisted-by: LLM
Signed-off-by: iugfdin <iugfdin@proton.me>
---
Tested with W=3D1 driver-target builds on net under x86-64
allmodconfig and allyesconfig, and source-executing ASan/UBSan
checks with modeled kernel/DMA/MMIO boundaries. No physical
Realtek NIC was available; this is not an on-device test claim.

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethern=
et/realtek/r8169_main.c
index 045fcd4d..ae8ea0d8 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -4625,6 +4625,8 @@ static netdev_tx_t rtl8169_start_xmit(struct sk_buff =
*skb,
 err_dma_0:
 =09dev_kfree_skb_any(skb);
 =09dev->stats.tx_dropped++;
+=09/* Flush packets queued with xmit_more before this failure. */
+=09rtl8169_doorbell(tp);
 =09return NETDEV_TX_OK;
 }
=20

