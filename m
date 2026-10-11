Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CB745D1A5;
	Sun, 11 Oct 2026 19:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791748287; cv=none; b=QYeRSAqVDVyOaJMfECe0lnR2dL5oMLupfsAs2sMaHElMTfYow4a11vH74Ps2ZRBPXgZQ43NWUsMk/u249w0XopO8wNCxRc46bpe/QSwLQaIhme1YkgtsMR4WFDSblvhzaCqag4SNe7zv7IbiNFF9jIU+0jmIaAJyQR9THnyNxHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791748287; c=relaxed/simple;
	bh=GIJ9F2Np/KnoELKdLubUt0TAqiAWj1v87UsVkZJoiIU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OBILEQ3WLTUHnfjkcxfYVa0jyna0pDiMk8xllZud7N2vM62ZGtPLrcjarDEnFjA9EcImunCCr6vMt7/ihLaXvCJ25iPAKu8MYlkjq0vZwttHvuD10yefjAcCA3km7n/vlNascXzbAYXmcQYH5i6lfnzEKBEwdtsDm9GCagdvSXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wct6DCv8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wct6DCv8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B54D21F0089B;
	Sun, 11 Oct 2026 19:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791748286;
	bh=ixEiEmdMDrjOCwJWxWu04K8rpLNN5UqmwsEo5HnbdWw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Wct6DCv8TFbXCrI81pl41bPBrFrIr/UEZOCXKM4hAejb+kixuIM/OvwMdoGNUBuwN
	 4cPCiucDo2o7Dw1XERIbXu/rgJ1/BdoudUP/GcmTgT/FvIJrOSkHRO/iBDP+IvOh15
	 KwXrOnB4LGtDq24yglF2enRV0TQ2mQIJSZvoTrz31Tp9Kughj/HDKqKwlZaS2GnfKn
	 PGRb6utA3ov0tuyHB4/TRAgCguFYyq5/0Ouz2V3RlG0RQ7Vxi1Ybr1PqnuP7lDldQk
	 U9E6BFsBsWDdG4oNaQ6ijhBXU7grRe45B/wWSp7u+fogTHI3hyRfRtW3NWfAH36B95
	 gCasHT27cykJA==
Subject: Re: [PATCH net-next v3 5/9] net: dsa: realtek: rtl8365mb: set and get
 vlan 4k for family D
From: netdev-bot+sashiko@kernel.org
To: namiltd@yahoo.com
Cc: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, luizluca@gmail.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 11 Oct 2026 19:51:25 +0000
Message-ID: <179174828532.434549.7339327413845979862@kernel.org>
In-Reply-To: <22c20407-e6bc-4171-92b5-33650de94a49@yahoo.com>
References: <22c20407-e6bc-4171-92b5-33650de94a49@yahoo.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] In rtl8365mb_vlan_4k_write()
  (drivers/net/dsa/realtek/rtl8365mb_vlan.c), the family-D branch sets…

--

net: dsa: realtek: rtl8365mb: set and get vlan 4k for family D

This commit gives family D its own two-word pack/unpack for the CVLAN
(VLAN4k) table entry in rtl8365mb_vlan_4k_read() and
rtl8365mb_vlan_4k_write(). Family C keeps its three-word layout. On
family D the FID is narrowed to 2 bits and the write path forces the
IVL selection bits.

> diff --git a/drivers/net/dsa/realtek/rtl8365mb_vlan.c b/drivers/net/dsa/realtek/rtl8365mb_vlan.c
> index 8d49ffadce926..2c4c5baf93f10 100644
> --- a/drivers/net/dsa/realtek/rtl8365mb_vlan.c
> +++ b/drivers/net/dsa/realtek/rtl8365mb_vlan.c

[ ... ]

> @@ -244,36 +284,59 @@ static int rtl8365mb_vlan_4k_write(struct realtek_priv *priv,
>  	val = FIELD_GET(RTL8365MB_CVLAN_UNTAG_LO_MASK, vlan4k->untag);
>  	data[0] |= FIELD_PREP(RTL8365MB_CVLAN_ENTRY_D0_UNTAG_MASK, val);
>  

[ ... ]

> +	if (is_d) {
> +		/* The chip supports both IVL and SVL, but the caller (see
> +		 * rtl8365mb_vlan_4k_port_set()) never requests SVL, so both
> +		 * IVL/SVL selector bits are forced here rather than threaded
> +		 * through from vlan4k->ivl_en, which family C does honor.
> +		 */
> +		data[1] |= FIELD_PREP(RTL8365MB_D_CVLAN_ENTRY_D1_IVL_EN_MASK,
> +				      1) |
> +			   FIELD_PREP(RTL8365MB_D_CVLAN_ENTRY_D1_SVLAN_CHK_IVL_SVL_MASK,
> +				      1);

[Severity: Low]

This doesn't change runtime behavior today, because
rtl8365mb_vlan_4k_port_set() always sets vlan4k.ivl_en = true. However,
the commit message and comments no longer match the code.

The commit message says:

    so that control bit is forced here to match existing driver behavior,
    not a hardware limitation.

Two bits are forced here, though: IVL_EN (bit 3) and SVLAN_CHK_IVL_SVL
(bit 2). Could the commit message mention the second bit and say why 1
is the right value for it?

Family D writes ignore vlan4k->ivl_en, but rtl8365mb_vlan_4k_read()
still reports the field from hardware:

	vlan4k->ivl_en =
		FIELD_GET(RTL8365MB_D_CVLAN_ENTRY_D1_IVL_EN_MASK,
			  data[1]);

So the read path and the write path handle the field differently.

Some comments in the file are also out of date for family D. The
kernel-doc for struct rtl8365mb_vlan4k still says:

 * @ivl_en: enable IVL instead of default SVL

The file header still says VLAN4k entries can choose between IVL and
SVL.

The layout comment above the new size define still says u16[3]:

/* CVLAN (i.e. VLAN4k) table entry layout, u16[3] */
#define RTL8365MB_CVLAN_ENTRY_SIZE			3 /* 48-bits */
#define RTL8365MB_D_CVLAN_ENTRY_SIZE			2 /* 32-bits */

The family D D1 masks are also mixed in with the family C masks under
that comment. Later patches in the series don't update any of these
comments either.

Should these comments be updated to describe the family D layout and
the forced IVL bits?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/e84d76ee-03df-49b0-8c9a-b289dfae8728%40yahoo.com
