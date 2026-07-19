Received: from mail-200166.simplelogin.co (mail-200166.simplelogin.co [176.119.200.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF61D1A9F97
	for <netdev@vger.kernel.org>; Sun, 19 Jul 2026 02:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=176.119.200.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784427142; cv=pass; b=LdW3ZdrmviUZCjdqtNVYcfKLl5x6sV1X81JHelsLmW77anyliviVuQAQUB2VnkRWP86ke0ZH8m7X5VEQm+5Qtizxa1cTvsR2KTuCClyA7/VM2rCzz29H33v9m3PvWJ47KGZA8LouWBkWDEhqIfIuRI4bPmRajZGhy8yjEdvnVQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784427142; c=relaxed/simple;
	bh=VlZG6rG4j03zYsUgtt6Nvr+4RrV8YUV0ZekM4ksBDbM=;
	h=Date:Subject:MIME-Version:Content-Type:From:To:Cc:Message-ID; b=TkMxSSS92ccpmYuHct98GdqJWncrLJgfJ0L3PL+rqWOmpiq4dKGApraWzx1fRFQ4crAUbldkcHm0m72jAfeSihtSIE5NZCweMPKUOFBTMhPI66niRVF/D91vk0I/+Kj0AYYJ684DlseB34tnwjJU0MJlZG3Yr/72vRt5boJ/hw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=elinell1337.me; spf=pass smtp.mailfrom=elinell1337.me; dkim=pass (1024-bit key) header.d=elinell1337.me header.i=@elinell1337.me header.b=wTm5q386; arc=pass smtp.client-ip=176.119.200.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=elinell1337.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=elinell1337.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=elinell1337.me header.i=@elinell1337.me header.b="wTm5q386"
ARC-Seal: i=1; a=rsa-sha256; d=simplelogin.co; s=arc-20230626; t=1784427138;
	cv=none; b=2AOEJ7IgVw6izz7kGLkomXKj3QUa/onRi+7iNKGu0mgMDbLs1p1NQD9E6guCpWfBzDpxb9XAMnUMztecom2FQ5WdcVnFVd5D+VrFY2vcYM2GuX/6x/eTZ1ougD8YuRYxm6HEAR1UgIrYNJu9chynVHzxARrGXzNi196mG1meZdRDAuE5x2bRkRDHtxcrGqw+UmNGg7pY993dCx7JmmqOl+IIPWkoPztXi+WfW1TaAMBNZPpPfPjzUcXdDatSdElmtkeFr9UN/KwWLLNTUV0sjw3FtSDZJ6869nj6ns/Yy4eqtlbnwAyuAzN5GalWCpWIRrOQAbFAWD8tzIj0GmBcDw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=simplelogin.co; s=arc-20230626;
	t=1784427138; c=relaxed/simple;
	bh=VlZG6rG4j03zYsUgtt6Nvr+4RrV8YUV0ZekM4ksBDbM=;
	h=Date:Subject:From:To:Cc; b=aczz5bYeEVvhF+KJMGbU1kyFdygk6p5cbu0onSDnToc8bTqOuwTzRAKd0xQyLskeNGWC/VmsT4OOmanNVLqYTK1z0TDPrmBiLEbsagOcUzb0S0EFT0k6cVya9gaEVrvZY7UNW2cjUupl9KQD7V0ZANgZy9xdajy8h/L8U3hjoIWv5RqJjHqBzJDpnjOVzu0Cm+k4qGRNUSL6W6v2aXKqHbYzVWmb5DVzy5Tj7KU3a7b/sfbicpJCdToRJ100RxBhRl/f8DYjpEanL46SvrT0MsOW4tPlIuXh/MFsLdwEXToV06DcxV22KOIn1wm6teAJjNDjqKb2qkvHlgNYvGhMAQ==
ARC-Authentication-Results: i=1; mail.protonmail.ch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=elinell1337.me;
	s=dkim; t=1784427138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VlZG6rG4j03zYsUgtt6Nvr+4RrV8YUV0ZekM4ksBDbM=;
	b=wTm5q386xxQ4/VMRG1sQygbq+V4vG5wTc4TvJXAK544ubbjCpkgGMEXEaRnktro9ZJRcFz
	mhV3rG3t9GydGLbmsPHb8VGqOgOAIRbrQYPtLmSATh/gMZ4wJIEQoq40YuZqT6nRCwviGZ
	NO5uPv99pbxUqITP/nzfGjLEH3hB5Go=
Date: Sun, 19 Jul 2026 02:12:10 +0000
Subject: Question: MII media mux for external PHY/SFP combo ports
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: git@elinell1337.me
To: maxime.chevallier@bootlin.com
Cc: andrew@lunn.ch,netdev@vger.kernel.org,olteanv@gmail.com
Message-ID: <178442713834.7.10284519099797443296.1492041940@elinell1337.me>
X-SimpleLogin-Type: Reply
X-SimpleLogin-EmailLog-ID: 1492041959
X-SimpleLogin-Want-Signing: yes

Hi Maxime,

Sorry for the duplicate email. The previous copy was rejected by the list b=
ecause it contained HTML (default mode in Proton Mail).
This is a plain-text resend.

I am working on upstream support for the Banana Pi BPI-R4 Pro 8X and
would like guidance before writing any board-specific mux code.

The board [1] has two independent RJ45/SFP combo connectors. Each has
one SerDes lane, a GPIO-controlled passive external mux, one AS21010P
copper PHY endpoint, and one SFP cage endpoint. One mux is connected
to an MT7988 MAC. The other is connected to an MxL86252 DSA user port.

The downstream policy selects SFP when a module is present and copper
when the cage is empty. Each combo must keep one logical network port,
its MAC address, and its bridge/VLAN configuration across a media
transition. Switching either combo must not affect the other combo or
the remaining switch ports.

I have downstream reference code [3,4], but it polls MOD_DEF0 and
replaces driver-private MediaTek or DSA phylink state. I am treating it
only as bring-up evidence.

The phy_port documentation [2] added by commit 62518b5b3d8e describes
external MII mux topologies and identifies an MII mux framework as
future work.

Does runtime MII/media mux follow-up work already exist or is it
planned? If not, is phy_port the right starting point for a generic
design that covers both MAC and DSA consumers?

I can provide the exact DTS topology, downstream references, and a board
for copper/SFP hot-plug, traffic, and concurrent-combo testing.

[1] https://docs.banana-pi.org/en/BPI-R4_Pro/BananaPi_BPI-R4_Pro
[2] https://patch.msgid.link/20260108080041.553250-15-maxime.chevallier@boo=
tlin.com
[3] https://github.com/BPI-SINOVOIP/BPI-R4PRO-8X-OPENWRT-V24.10.0-Master-De=
vel/blob/56e0e77adad258ba05782fee8f94f00d17b0b991/target/linux/mediatek/fil=
es-6.6/drivers/net/dsa/mxl862xx/mxl862xx.c#L3696-L3738
[4] https://github.com/frank-w/BPI-Router-Linux/blob/6aa3b285d8f88267e5f3f4=
03000c88a08b61f851/drivers/net/ethernet/mediatek/mtk_eth_soc.c#L5430-L5508

Thanks,
Pavel Kirbai

