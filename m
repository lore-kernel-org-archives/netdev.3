Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CA438DC49
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 14:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792161066; cv=none; b=J3LDqpXijFoADQ71NYyWKORYahwBX+Su7L9KIliZkRkBf0V5hupkVtlWUgWEUHSM7qziJqhwLFddAroS63Bzu0n1rL6ZV4P3rsgSbKPuIaVM7OHVcupY2cg4Nw4nc0OTPjhH/qnYxNOIsDsZPcBYZH29mGcOcjftbiWn/PvljVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792161066; c=relaxed/simple;
	bh=VCOWo4u0sejFL5QXif8txOYk+8sJtM+dqK3lTGbBqGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QkrcjEf0LvHH3zoinS1HE3Mzqx2e0FUkPl7/E/Tfh5t2hAeR7/dn8poxkaTRbT8D9HeCMwOEK9J8zyocQCud1/DZTCUhPN1C98iWkoxmqDtdUmBX/HpR429thKs7atRrUX7n6+QBkeAWs1l/kkrwtZVvqeI49DfuyKSp5ZJWJa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=iQIQ6sSl; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="iQIQ6sSl"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a16c1608faso640325e9.0
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 07:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1792161063; x=1792765863; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9QGOZ83IKQe9etq3jkQaz9KzpqO4YHXXJ/jdZCauo8M=;
        b=iQIQ6sSlNOK88b+Wb90c4tfgvO1Ba+hDIk3j3tzgclATV6ljnRHCDvhxB+evfu0JBV
         A8fdIWpI+JypExmZOZmbYyjYOE41Bu0zq1jyQKM+5pIdv96gxYk5196ghmoCd9lNTB7v
         Oe9l0wq3ywOQ5cdJKPotj+ruj60Tf/SlhgUZwoLKyaLbW60hqZQmqW99CcYOBBJ+OgTl
         6rG44smrJmQp8HhkQ9xk01iMx2tgYXir8xRGIMoCfMVc8pZgWLDSJrG/kBJpPUd73/A2
         VXu3CWMc/qSYfub72WZVAz1VR7umsOJg+vlGJgYxx+SXgbwhbO8WLiCBQRIk20vxqs8x
         Y+kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792161063; x=1792765863;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9QGOZ83IKQe9etq3jkQaz9KzpqO4YHXXJ/jdZCauo8M=;
        b=jeha3o1+jmWZw1UxEgpZsjqKVL9kbhLKi2S7JaSyi2yALu/l6Azs9hnxFqqwCspO6/
         0QST0aO5/SHUnjMBdtGxvy1goZ2ENVfSTZkKK3brDannT8pti2frzGbvvgkUcxqeoTOv
         VyvIa8sRg0ARY/yGZ7dc8X2SpmXIIsE4DSJlNBqXgm7R4Fvh4iSWFULsNn1aau2+7zlM
         F/2nH5mKMqiW8fw+t9f7pTf8yTt3qR1OK3M0oZJNnPjzpG+HlA8TP7e98Pl19iXdUs02
         tu1qVV3B93W5ss+jDxs9tCHkt2R9Z8X/kK456ljDYEppMI7N4QdxNGJPxEaWsPF+kyBo
         sSbA==
X-Forwarded-Encrypted: i=1; AKwUvBxwLo2w1/pAiPIgt9iqHUfu9szX69JH8sIFROfK0shWaDbkQxJ+/QLjVnKoKNhfYxZcEFyU9nI=@vger.kernel.org
X-Gm-Message-State: AFq9FYIOxmLakkk2GvpGjzDvloOi5srzbwdYgBSJgMBXiQ5Sjz9Zj/yI
	f7tl4GHnoAh9UtmMncAp/FGvPA31p31T7TnuyWQZo+OOs2pi0XTaYAwjGN7naZLDJgA=
X-Gm-Gg: AYBFou2NtKiuNak1dioejxJMwz3rfvA5wHJCNBH6dD0nD0kzV4SX5UIB+TFI691sCeM
	R+JKY9EDmyhgfs4cfJvTIAvyHB5TDQT7maGSYce5shi1u+x+mSI4dWfa6NxF+5FGZuywJBnm6Nr
	oLuzBciCvNDJJBqesl6Bo596rhrgZjc+o7Vcr31y8TtI2ZF+nWC36N0C1U0WvsNb39bkMmFQzGT
	t8SH6GnY+wMs7QgLWDJ1w/jk/FQ+Tqfift7FGQDv661U8jotDLHrTMxjuBRwfBZwfww62VrkIzK
	nKrjMZQVzM3x+4/lQF6mIQkdjdIKF/9j7w3yX5x8992mVQ7lHXOBBmENx8i63M1Mo5dVq6VFypF
	6vvYjFZJbQBxobWuWsva/tzlROAvvPbukFAod4rFKEHHicFnuhZAsjHovYrdu65W+0ME6S3aM0h
	QAdYD4+okcvJzDaxRVtT9sPENDwUJ7ewveVf9Gkv6oDfhFnEuhjfhz4V3QTANa+YWlcSPF3emDO
	KZ631HLZE3DGXxZaNC9kEbAillIASqa7QiDXQ+LdWA5tadWcrh7fgtpYN61RIeZ932Nz8aaYfkx
	XU6l8eX4eBFBbCYWxn/7gYimi1cdD8UB+WPfRsuunE9612OxwJQQIS8Ru4Y=
X-Received: by 2002:a05:600c:4f91:b0:49e:65f2:db64 with SMTP id 5b1f17b1804b1-4a1c664b3a4mr77865325e9.5.1792161062087;
        Fri, 16 Oct 2026 07:31:02 -0700 (PDT)
Received: from aspen.lan (aztw-33-b2-v4wan-169864-cust3247.vm26.cable.virginm.net. [92.239.204.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1c8ddde4esm79138725e9.12.2026.10.16.07.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 07:31:00 -0700 (PDT)
Date: Fri, 16 Oct 2026 15:30:56 +0100
From: Daniel Thompson <daniel@riscstar.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alex Elder <elder@riscstar.com>, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: pcs: xpcs: select operating mode for
 10G-baseR capable PCS
Message-ID: <atI1IK6blP-vumLQ@aspen.lan>
References: <20261014223100.304486-1-elder@riscstar.com>
 <20261014223100.304486-3-elder@riscstar.com>
 <f8c01002-da88-4f0f-a02a-7480591f4296@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8c01002-da88-4f0f-a02a-7480591f4296@lunn.ch>

On Thu, Oct 15, 2026 at 11:09:14PM +0200, Andrew Lunn wrote:
> I don't know this PCS driver, so maybe dumb questions....
>
> > Currently the XPCS found on Toshiba TC9564 is unable to operate at
> > 2500base-X and slower with a PHY connected using SGMII/2500base-X
> > (in our case a Qualcomm QCA8081).
>
> Is the PHY actually relevant here? What about SGMII/2500base-X for an
> SFP?

No, I don't think the phy is relevant here (the bit in brackets just
records the specific hardware combination that we observed the problem
on).


> Is this purely a PCS problem, or does what the PCS connect to make a
> difference?

AFAIK it is purely a PCS problem (but it's all soldered down so I have
no chance to prove I am right by testing it).


> > The problem arises because this XPCS supports 10Gbase-R. That means
> > that the reset value of SR_XS_PCS_CTRL2:PCS_TYPE_SEL (0) is valid and
> > this suppresses the modal switching based on bit 13 of SR_PMA_CTRL1
> > or SR_XS_PCS_CTRL1.
>
> ~/linux/drivers/net/pcs$ grep SR_XS_PCS_CTRL1 *
> ~/linux/drivers/net/pcs$ grep SR_PMA_CTRL1 *
> ~/linux/drivers/net/pcs$
>
> This is not helping me understand what is going on here.

These names are exactly as they appear in the technical documentation
for the TC9564. I assumed these to be inherited from the Synopsis XPCS
docs and would make sense in the context of the XPCS driver.

However, now you mention it I can see that "Speed selection bit (13) of
PCS control 1" would be considerably clearer for reviewers who take a
wider view! Will fix this and will also be a bit clearer about how XPCS
treats PCS_TYPE_SEL.


> > +	if (mdio_stat2 & MDIO_PCS_STAT2_10GBR) {
> > +		switch (interface) {
> > +		case PHY_INTERFACE_MODE_SGMII:
> > +		case PHY_INTERFACE_MODE_1000BASEX:
> > +		case PHY_INTERFACE_MODE_2500BASEX:
> > +			/*
> > +			 * Why are we writing MDIO_PCS_CTRL2_TYPE + 1? We want
> > +			 * the modal behaviour that comes when we pick a
> > +			 * reserved value. XPCS allocates extra bits to this
> > +			 * field and allocates values from 15 down so
> > +			 * MDIO_PCS_CTRL2_TYPE + 1 is the value likely to be
> > +			 * allocated last (and hopefully never).
>
> MDIO_PCS_CTRL2_TYPE is 3. Looking at 802.3, the value 4 is
> 40GBASE-R. The 2022 version of the standard has values defined up to
> 10011b, for speeds up to 400G,
>
> Alex added support for 25G, 50G, 100G.
>
> Is this an issue?

It will probably be an issue when the kernel is first called up on to
support an XPCS that supports 40GBASE-R.

The XPCS (at least in TC956x) handles MDIO_PCS_CTRL2 in a slightly odd way.
It 4 bits wide and accepts 10GBASE-R, 10GBASE-X, 5GBASE-R and 2.5GBASE-X
is defined in the standards up to 2018. All other bit patterns are
reserved and instruct the XPCS to use Speed selection bit (13) of PCS
control 1 to choose between 10GBASE-X or 1000BASE-X.

That means we *must* write a reserved value to this register because the
default value after a reset prevents <=1G modes from working (I think
automatic switch over between 1G and 2.5G also liked this to a reserved
value but I don't fully recall right now).

On that basis the best bit pattern to use one that isn't implemented by
whatever XPCS we happen to be running on. One simple approach might be
keep using 40GBASE-R but to check PCS Status 2 to ensure we fail in a
non-silent manner on hypothesized future XPCS hardware:

	if (mdio_stat2 & MDIO_PCS_STAT2_10GBR) {
		if (mdio_stat2 & MDIO_PCS_STAT2_40GBR) {
			dev_err(dev, "40GBASE-R is *not* a reserved "
			              value on this XPCS");
			return -ENOTSUP;
		}


		switch (interface) {
		case PHY_INTERFACE_MODE_SGMII:
		case PHY_INTERFACE_MODE_1000BASEX:
		case PHY_INTERFACE_MODE_2500BASEX:
			/* better comment goes here */
			ret = xpcs_write(xpcs, MDIO_MMD_PCS, MDIO_CTRL2,
					 MDIO_PCS_CTRL2_40GBR);
			...
		}
		...
	}

Given this function would almost certainly need other changes to
support different speeds this shoudn't be too much of a hardship
for whoever ends up working on a 40GBASE-R-capable XPCS.

I assume it would be OK to define the two new values
(MDIO_PCS_STAT2_40GBR and MDIO_PCS_CTRL2_40GBR) in the uapi?


Daniel.
