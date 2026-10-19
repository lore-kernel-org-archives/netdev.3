Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792428298;
	b=xKptkSHOCHBP5iHGRZ/zr2AcsA84UxwyHM9c9CvfU160VsOP5xYrcorBY9xX6TL9IVdl
	 Vs+w+hn/l+ERY7EFlhmOgdQs2gsHrKKFQ2ByNArYgTRd6q1otXsNK6vek8qm4q+U2/3Tm
	 yknvNCw8MhWjJdZyvhxo5yKzkI0iutxhc3MIfiAry6V1RvNHyRjtzJcRPeHRvHEKnoEKp
	 8ZzaNt6dGxODhs0dZxZO7zz09ZwF8zlC8juQOyKSTkOavVyceOZ60iRMIbHkA0NcORUsX
	 Pjv6nPq+PXUnBsWut+jOJmPSFldroyWbIf6CMvXkSHxrQh2vXp4oFAmmPs0n8m3Pipw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792428298;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=YBxE2RHs/xtw2k6w0uwqJcfXRjL9fFfsXhtkaG1a0dA=;
	b=M8c3JhcO7HpMoaRec0iD8ismuNiK/W3wqHxtgk2j+p38iRlg0EwM2cin3aZFV1hZ8i5+
	 b2XS3ArEJR0BzGfc0A/M5AUTcFgAT1nAfZLmzi3mJiFD2vXwjIyHY6q0lNkjd60Wjoi11
	 xWX6DWHpqkbmLZxAxtif5fb2gTCn0ZAVgosN2o5IBPPybdmLO2MJ+Fd2dFdZCwGjIOrco
	 tF+BQaTXJddpusTvaCO6rj0OUMB5bb/DwHtonBNYfRbUT626sTWbEegTH2DFZrtNHbujy
	 pbZewoWA7I8d2CSv5WGgrFr0SEzrbwTBsXHaY6x0c9iLsnoPxY6VOQYap0VHmDU6GyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=riscstar.com;
	spf=pass smtp.mailfrom=riscstar.com;
	dkim=pass header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=sWUP6p6d;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52802606A336
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 16:44:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52802606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=sWUP6p6d
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4980fe6b3beso21429455e9.0
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 09:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1792428297; x=1793033097; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YBxE2RHs/xtw2k6w0uwqJcfXRjL9fFfsXhtkaG1a0dA=;
        b=sWUP6p6dS77gDd9crmmTzReRjbttlB+oGdebU8insTZ0eh8VuwE85bYmR7cVuMfITN
         04ViV/M5Cli7xTKW1+fo4opBWS1lhlnfqVoEyTDIHAffyAjIGxPmIzYALh+/M2+i5hhm
         dIou0xRjPwAY22CinG4x17pvDzKX4avuJU251GO8e4LulYdFpt4p+fzVlvyU9jj9CFUQ
         rE0MiumtTqofDWMfk/iSipZfzKD7t+QsbDwy9bEKQZiGTiDe85n+QhXb02GSLwnZEvRt
         l0W+tZzsycG6O3Rcc/9ZktykZeaw1RAAobhTLe/k8KMsoLXZvGEh5kbD5nWv4ECn/q4O
         sEeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792428297; x=1793033097;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YBxE2RHs/xtw2k6w0uwqJcfXRjL9fFfsXhtkaG1a0dA=;
        b=uLGfFQAmEptPnpfj8K4lqKj/5VaDefQFYtk+SCU83xEZAuMQGOyHEtbOwWhkPV7j29
         vWYCvZmrApiqAJazUJSr7X/2PGBLtQhBVbu0UwrhGixEdEVJFbpBcTXuoIT1i7cUYFZ8
         fUvvONLB4xZgz9rZ1gjYEW09893ze+5D/JQoSONlpsVof7zAWd5gd/qw6RH8xW2Mx4y4
         ZHyTpKfp28kNntzZOIrahwrA5KFZGpyVXMbEVhakk1SOe3XGRiguC4kRaeh/IRP9TTb5
         ifOValy97heGoVJZCoEstx/1cNHJ9wXq/quIvlgGV5f7VEhK2A5jYfaOxijL1lrvgqDY
         ekAw==
X-Forwarded-Encrypted: i=1; AKwUvBynzeymPJUrsNPxu+aQ2a0DArNO0PDAWUTBouJK5D2IDSV0l9tW9Ffns18PWuqxaYucnOV+/iU=@vger.kernel.org
X-Gm-Message-State: AFq9FYL45im3vWtz0y5oPHlYUaTm1XCtrIBxiMpCUnWadmO3gpbDmzi+
	nDPvbsEJW65/sNqQAh875hplZrDHytoO/7Vwm/Rlnmkt2xk8ajYLrTU6G8OkOGhtzjU=
X-Gm-Gg: AYBFou1Wd5/Pvoh8DVzPyI5g7Bmu3APhmU347n9x98OkDN9TmqQLTKvtxm1vaFYmkSk
	a7E8i3BEw0h5jWQ15opmBcgVNYNEZ+aIfZfztIV4lQ3kP/jXsQf1tJaJbbrLaBxUHsaSisiGH87
	LzyMfo4AaGbwimj1CamS/KxYPQx6yFm/6xsnCaF3BJTQ9zUMZXEtuk7n9LO67naaMkN8CqpKNVK
	UM2fv16IdvwX7ZZiya8HYGjE6DePGm5A8Bv7PnHI5E3y6rdSCWLpHHmdETgDSK0M61cMs75Iehz
	lzKWknUjQgs20JQLEfY8PI+EnC4l90+hj4zM6Xsz5QoO8D7zF1ah3Aoun2LlJevphGfEoFCzLVU
	eWzi2dpTEcRU/2KoQPtUuTaMW/b17TZdHhVOXP53w7wg9GtnMdzqkuzUq2mEypcmXnAEJPChLm2
	p3t6gRhqWBJwdiVN6/2IPJRw8elbLmTQpYEPD0zoedm2K14t35z4CCTrs7pMii8G3VRMFLt2QrG
	UhOfc/NErzkzbOkI7NnEhNJ+x01C6qB2BgQKbvh5HMXvjFNFXCUo66LLJE2sJNlXqDkLTO+MmKo
	uIZAMor1qfVzsOBsY9lamHppwwinFnXWOSv2+2MeSl/7ootNMgzAkqpaC00=
X-Received: by 2002:a05:600c:5254:b0:4a1:e57b:667e with SMTP id 5b1f17b1804b1-4a1e57b68c7mr97174505e9.4.1792428296450;
        Mon, 19 Oct 2026 09:44:56 -0700 (PDT)
Received: from aspen.lan (aztw-33-b2-v4wan-169864-cust3247.vm26.cable.virginm.net. [92.239.204.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2d324f8sm3668735e9.6.2026.10.19.09.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 09:44:55 -0700 (PDT)
Date: Mon, 19 Oct 2026 17:44:53 +0100
From: Daniel Thompson <daniel@riscstar.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexander Duyck <alexanderduyck@fb.com>,
	Alex Elder <elder@riscstar.com>, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: pcs: xpcs: select operating mode for
 10G-baseR capable PCS
Message-ID: <atZJBaHU2QQGwcnG@aspen.lan>
References: <20261014223100.304486-1-elder@riscstar.com>
 <20261014223100.304486-3-elder@riscstar.com>
 <f8c01002-da88-4f0f-a02a-7480591f4296@lunn.ch>
 <atI1IK6blP-vumLQ@aspen.lan>
 <fe13016b-ebd6-4a2f-a07b-324f46b456d3@lunn.ch>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe13016b-ebd6-4a2f-a07b-324f46b456d3@lunn.ch>

On Sun, Oct 18, 2026 at 05:48:39PM +0200, Andrew Lunn wrote:
> > > > +	if (mdio_stat2 & MDIO_PCS_STAT2_10GBR) {
> > > > +		switch (interface) {
> > > > +		case PHY_INTERFACE_MODE_SGMII:
> > > > +		case PHY_INTERFACE_MODE_1000BASEX:
> > > > +		case PHY_INTERFACE_MODE_2500BASEX:
> > > > +			/*
> > > > +			 * Why are we writing MDIO_PCS_CTRL2_TYPE + 1? We want
> > > > +			 * the modal behaviour that comes when we pick a
> > > > +			 * reserved value. XPCS allocates extra bits to this
> > > > +			 * field and allocates values from 15 down so
> > > > +			 * MDIO_PCS_CTRL2_TYPE + 1 is the value likely to be
> > > > +			 * allocated last (and hopefully never).
> > > > +			 */
> > > > +			ret = xpcs_write(xpcs, MDIO_MMD_PCS, MDIO_CTRL2,
> > > > +					 MDIO_PCS_CTRL2_TYPE + 1);
> > > > +			break;
> > > > +		default:
> > > > +			ret = xpcs_write(xpcs, MDIO_MMD_PCS, MDIO_CTRL2,
> > > > +					 MDIO_PCS_CTRL2_10GBR);
> > > > +			break;
> > > > +		}
> > >
> > > MDIO_PCS_CTRL2_TYPE is 3. Looking at 802.3, the value 4 is
> > > 40GBASE-R. The 2022 version of the standard has values defined up to
> > > 10011b, for speeds up to 400G,
> > >
> > > Alex added support for 25G, 50G, 100G.
> > >
> > > Is this an issue?
> >
> > It will probably be an issue when the kernel is first called up on to
> > support an XPCS that supports 40GBASE-R.
>
> Which is likely to happen sometime in the future. Maybe Alex's
> hardware even supports it, but if you can do 50G, why bother with 40G?
>
>
> > The XPCS (at least in TC956x) handles MDIO_PCS_CTRL2 in a slightly odd way.
> > It 4 bits wide and accepts 10GBASE-R, 10GBASE-X, 5GBASE-R and 2.5GBASE-X
> > is defined in the standards up to 2018. All other bit patterns are
> > reserved and instruct the XPCS to use Speed selection bit (13) of PCS
> > control 1 to choose between 10GBASE-X or 1000BASE-X.
>
> We probably need Alex in this thread, what happens for 25G, 50G, 100G?

That would be very much appreciated (hi Alex)!

I have spent a fairly big chunk of today trying to "get back inside my
own head" since it's been quite a while since I last looked at this
code; Alex (Elder) and I were focusing on other bits.

I made two assumptions when I was reasoning about regressions:

1. No existing code ever wrote to PCS Control 2 and therefore the value
   after reset must be correct for existing working cases.

2. The reset value is bit pattern 0 (10GBASE-R).

The idea of the code above is designed to match only those cases where
we *know* that the reset bit pattern (0) will cause trouble and change
things. It's currently a very narrow match although I might expect
additional cases to be added as other phy interface modes are tested.

I have spotted a very obvious flaw in my reasoning above: the special
case logic for FBNIC that suppresses the initial XPCS reset.
Unfortunately the version history doesn't mention what bad thing we
can avoid by suppressing the reset (perhaps a reset can clobber values
such as PCS_TYPE_SEL that are injected by the firmware).


> Maybe there are different revisions of the IP, and later revisions
> make this register follow the standard?

I'm not able to answer that. All I can say is most XPCS seem to have the
same ID. Finger crossed that, if they change the behaviour they also
change the ID!


> > That means we *must* write a reserved value to this register because the
> > default value after a reset prevents <=1G modes from working (I think
> > automatic switch over between 1G and 2.5G also liked this to a reserved
> > value but I don't fully recall right now).
> >
> > On that basis the best bit pattern to use one that isn't implemented by
> > whatever XPCS we happen to be running on. One simple approach might be
> > keep using 40GBASE-R but to check PCS Status 2 to ensure we fail in a
> > non-silent manner on hypothesized future XPCS hardware:
> >
> > 	if (mdio_stat2 & MDIO_PCS_STAT2_10GBR) {
> > 		if (mdio_stat2 & MDIO_PCS_STAT2_40GBR) {
> > 			dev_err(dev, "40GBASE-R is *not* a reserved "
> > 			              value on this XPCS");
> > 			return -ENOTSUP;
> > 		}
>
> Maybe. But we need to ensure it does not cause regressions for fbnic,
> which might actually support this speed.

I will sketch out an idea based on explicitly checking both my
assumptions hold by checking PCS Status 2 and PCS Control 2 after
a soft reset. Thus if you never reset then the code will never
deploy. Likewise we don't need to rely on my guess that all XPCS
implementations will reset PCS_TYPE_SEL to 0.

I will also, given everything I've had to share by e-mail,
improve the commenting a lot!


Daniel.
