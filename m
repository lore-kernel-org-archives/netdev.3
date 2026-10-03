Received: from mail-106102.protonmail.ch (mail-106102.protonmail.ch [79.135.106.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F237E39182A
	for <netdev@vger.kernel.org>; Sat,  3 Oct 2026 08:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791015512; cv=none; b=Cv4VODm043f8rryFgwjBH99fFAORXETLen7PCBTf3w1X0IPT6ukW6h5T/hLLR5+9ebJCAtS2SeD7uIUArRCmZXFwUS0g97yavU10nThYHW7URo1IFmNYZ0qDG+0mIe5h+dCmFdy4qIbJN9oJ2Dry7NOQCkLLKw13KguQZo3v2zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791015512; c=relaxed/simple;
	bh=fIQYchEyl9V/S9Mi9fJ+YKUhkFzbMNbC/Q9u5MLuAxA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nB+sm0EBleriDsGHFhwwDE3UuzFpPSBcW+1VsZ5cLaqbHFuVfrl2rCH1CjYpmg3L6ZRN1bAmvDmdGS59Lb9e6/Tk+Cq3+pcJn7azmOFmCHXChTttHVBLLo06ZuVL31Jzu40A2QltRKC8x45OAdZiubEwexOQR3ZHNH3x4dvLAT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=g6If6B17; arc=none smtp.client-ip=79.135.106.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="g6If6B17"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=cstzjhqkrzeg5beecotbbtswl4.protonmail2; t=1791015496;
	x=1791274696; bh=fIQYchEyl9V/S9Mi9fJ+YKUhkFzbMNbC/Q9u5MLuAxA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=g6If6B17F3B2QHb7J/bUB60XzMlE2zKTv64yNRlQdeIm7A+3RpL0YxqKQNtSqm1ri
	 A39FCu7ilDA3ESWpJngn2Ro2UwA9MyTQWzj1f9saybomhbi3TM3yG/HFXuE8mEvrJe
	 rRn2YqarNlv2ayZ1ZEzIQWW8dlJks1XkjY8EsTgKb5Lxet2uWalF1lXdXJolLzAJdC
	 O7d1CBuvKG+TY8hdC6ppceT3wM9rcnA4wHsELKKER65i9UM/zJDdLr6PBfqGEaekAt
	 Pweyvkrx2XHVy2fJcuD+DIndV+KJiQus5B/evviHUdmc77tdRbMTXD9fQerdyx+3BO
	 5GdBJdkMHIByA==
Date: Sat, 03 Oct 2026 00:07:54 +0000
To: netdev@vger.kernel.org
From: iugfdin <iugfdin@proton.me>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net 1/2] r8169: preserve checksum offload when packet padding is unnecessary
Message-ID: <179098478410.1174319.5605355405318252998.r8169-1@proton.me>
In-Reply-To: <179098478409.1174319.4377246796187959500.r8169-cover@proton.me>
References: <179098478409.1174319.4377246796187959500.r8169-cover@proton.me>
Feedback-ID: 225708956:user:proton
X-Pm-Message-ID: a3461f477443c527c93a7cde279d2212acdac29d
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

rtl_quirk_packet_padto() returns the minimum packet length required by
the padding quirks. For RTL8168evl and RTL8125-family chips this is at
least ETH_ZLEN, even when the skb is already longer.

rtl8169_features_check() treats that nonzero target as a boolean and
therefore disables checksum offload for ordinary non-GSO
CHECKSUM_PARTIAL packets on these chips. Packets that need no padding
are unnecessarily checksummed in software.

Compare the skb length with the padding target instead. Packets that
actually need padding continue to use software checksumming; the
existing short-frame and transport-offset checks are unchanged.

Fixes: 8d520b4de3ed ("r8169: work around RTL8125 UDP hw bug")
Assisted-by: LLM
Signed-off-by: iugfdin <iugfdin@proton.me>
---
Tested with W=3D1 driver-target builds on net under x86-64
allmodconfig and allyesconfig, and source-executing ASan/UBSan
checks with modeled kernel/DMA/MMIO boundaries. No physical
Realtek NIC was available; this is not an on-device test claim.

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethern=
et/realtek/r8169_main.c
index ee1bc9bd..045fcd4d 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -4677,7 +4677,7 @@ static netdev_features_t rtl8169_features_check(struc=
t sk_buff *skb,
 =09=09if (skb->len < ETH_ZLEN)
 =09=09=09features &=3D ~NETIF_F_CSUM_MASK;
=20
-=09=09if (rtl_quirk_packet_padto(tp, skb))
+=09=09if (skb->len < rtl_quirk_packet_padto(tp, skb))
 =09=09=09features &=3D ~NETIF_F_CSUM_MASK;
=20
 =09=09if (skb_transport_offset(skb) > TCPHO_MAX &&

