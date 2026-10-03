Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065EB42669C;
	Sat,  3 Oct 2026 14:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791039451; cv=none; b=cOm4/9kMcgdd8z5zJhhOnJH/Jj58k6OWlaBJQ8HE3PTWKutnEIZH0S0ShqkNHUihYLmoY5rrCg28pbcPEwGFwEX3gYrJ/AM5djI26mC2rczZlYWsuQL+Hmod0FAKWKvV2XiuirlRfVeBXkIjWayApdBu3v7CRSA3DsNF9NlIVSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791039451; c=relaxed/simple;
	bh=uXJZsVteBsFqjHbXMx/x9zuPLikQCN04yzIKRIVguww=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G+AVygObPkp3N2Zb5xKYUwt7U9sLStUlMXtbZJbLtJ4EinmYmWTMp21AwJSNRnGFCHUfju1YQ1dscDtYHNiXEyrCm2M+G6hu7ZaUysb43RskvXY6Bwcnt49iyqLUeTbGSqlETFvwa629QZmdEJW5pEsEoGeCun3+u1Zoj3kLsDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=krETLDSJ; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="krETLDSJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1791039437; x=1791298637;
	bh=uXJZsVteBsFqjHbXMx/x9zuPLikQCN04yzIKRIVguww=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=krETLDSJFteY5BJdc1leBNvIaU/JT5EvBg0qmMKmXAMGCIixEkKBV1/RvNOYdQNw4
	 ZsMOUI8PVJcNmD4cwCsqYEwSO1hPSPcxcghYh0Y+2aJWcf1SfpWdekhQ7DuhwqBykO
	 VUXFMH0QoyueBEwkYDaSW5eMsWpZ3fEFxIQDnQOk+IZ3JV/xbTQWlVPnCa1ElVBqgg
	 YKWVur9NcKXLKhovIH7SaxfSVYNlUVkXUxk0Dw2Pjp40jnM5TAuc74RmvmTek+xenm
	 ANkIPCqfLyq9n/Z/WaUiiHW4GS1/o4g8n/OdqjVoRtyEpC0OMBhPTiMFBBWjDUGyK6
	 NyyvFIp5tt/Lg==
Date: Sat, 03 Oct 2026 14:57:11 +0000
To: wens@kernel.org
From: Norman Herms <dockseed@proton.me>
Cc: Junhui Liu <junhui.liu@pigmoral.tech>, Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, Philipp Zabel <p.zabel@pengutronix.de>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Richard Cochran <richardcochran@gmail.com>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, netdev@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>, Enzo Adriano <enzo.adriano.code@gmail.com>, Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH v5 3/8] clk: sunxi-ng: a733: Add PRCM CCU
Message-ID: <Xss-x8UR9RSDehrUzeE27kgFWXhob67jMdSrxfgSV5FIhrtDiD5VRcpJYP2-j7itF4eArxOmzsGWXqQucflO9EJqt7LK70OVjFmCjsaqHc0=@proton.me>
In-Reply-To: <CAGb2v65q8w6NLzTtuMX3HZR98nAvR=Z4ODUCFZb5j3TgkDu_3Q@mail.gmail.com>
References: <20260930-a733-clk-v5-0-11175b41cd2d@pigmoral.tech> <20260930-a733-clk-v5-3-11175b41cd2d@pigmoral.tech> <CAGb2v65q8w6NLzTtuMX3HZR98nAvR=Z4ODUCFZb5j3TgkDu_3Q@mail.gmail.com>
Feedback-ID: 144388465:user:proton
X-Pm-Message-ID: 1db97b86471db45a5d153e83a4f06e314e249029
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi ChenYu,

Measurements for your comments on this patch. Same two Radxa Cubie A7S
boards and boot chain as in my reply to the cover letter (SID + 0xA0 =3D
0, no secure boot). Cold boot, register reads from U-Boot at
non-secure EL2 on both boards (same values). On one board also a
non-secure write test, and reads from EL3 with a test BL31 that only
reads, before and after sunxi_security_setup(). Again done by AI agents
(Claude) on my boards, so a report, not a Tested-by.

> The three bus dividers are secure by default, and either need to be toggl=
ed
> to non-secure by the bootloader, or (I'm guessing) the system is running
> without secure boot and the secure access bit isn't in effect.

On our boards the bootloader toggles them. Bit 0 of PRCM_SEC_SWITCH_REG
(UM 4.2.5.26) covers exactly AHBS/APBS0/APBS1, and TF-A's common
sunxi_security_setup() writes 0x1 to that register (our BL31 and the
vendor BL31 set 0x7). From EL3 it reads 0 before and 0x7 after that
write. From non-secure: 0x07010290 =3D 0x7, r-ahb =3D 0x03000000, r-apb1 =
=3D
0x04000000. Both differ from the reset value 0, so these registers are
readable. We have not checked non-secure access to them before BL31
sets the switch. Note that secure filtering is active on these parts
even without the fuse, see the TWD gate below.

> > +static SUNXI_CCU_GATE_HW(bus_r_twd_clk, "bus-r-twd", &r_apb0_clk.commo=
n.hw, 0x12c, BIT(0), 0);
>
> User manual says this is secure only.

On our boards it behaves like that even without secure boot. From EL3,
S_TWD_BGR_REG (0x0701012C) reads its UM default 0x1, before and after
the BL31 security setup, so the gate is open after reset. From
non-secure it reads 0 on both boards, and a non-secure write of 0x1
does not stick.

> BSP sources say there is a "dma-clken-sw" gate at 0x1dc bit 0. Same on th=
e
> A523, though it's unclear what it does or controls.

The A733 UM lists no register at 0x1DC (the S_PRCM list goes from
0x01CC to 0x020C). In the Radxa BSP (radxa/allwinner-bsp, branch
cubie-aiot-v1.5.0) "dma-clken-sw" exists in ccu-sun55iw3-r.c and
ccu-sun60iw1-r.c, but not in ccu-sun60iw2-r.c, the A733 one. On our
boards 0x070101DC reads 0 from non-secure.

Thanks,
Norman
