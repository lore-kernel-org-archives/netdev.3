Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE495540A8
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 15:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788880772; cv=none; b=dl3vCWpOd3OGYT+C1jCWDcQgWZLCzeNxsXjPM4BjyyL47IvOgRnYbn4rT4KJqDOZMEe5uzKt/GSNd3N4NDOVBT1Ls9b1lY7W1bRSS7CL4Vp7HBTTknhbrIyxdXPEYSnLHJD/4g5tiBI01vlGAg3zWbNUBiiTBAeBbmJX9/+W1iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788880772; c=relaxed/simple;
	bh=2E2paIhVSecgEqjIXBb7PZzzAn2OOgH65j7qNTEeMiY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wm4LYRGxB6jryTumgCVPiqFuU7w/EcqiLOxVDmzp+CHhv4xG2fdPf5TKZaQJv34vA8PQH/G2/rC4iCJhE/1tmzkTM9Sc7sKyCszz2jqUaia3wnHo/Bnh8lfmE5Q9Ya94wo99Ls90TVMy8Cs+WGw31fz9C3wymU0upQVZc1eDcbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CFBxOYKB; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFBxOYKB"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-66c7e3a2332so3458840d50.2
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 08:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788880761; x=1789485561; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QhdCOmP4zDl1C4qG/vDZ2J5jFE+DMqbe+H/tbxij/K4=;
        b=CFBxOYKB3iRfvLbButzgKpzs1fOoQywfEeAYQVEyRRu0uRJHy9btNUKKy6vQ/FYDlf
         KY0X7JPm+TPmkMLm4oXmTnri693RhMPrR+MSsie4WAgAzLJFtcMZDR645ARELlf/eONu
         b1LQbzBGi6u7leRHYiZ0Mi03+3C7Hl66lYz9s785Dzu9oY1HWjaDlhkD72A6cZT7bs7o
         m7vF/XYi6N13hl8kkbL4m/R2/bKZ/szzUFGIFPXWDHA25l33JiiaDHCLkn2zT6oIYTBn
         DdepwaZ50w2KKo33Enz1rdxsF6J1VJULQol2YAhDOzoIQkjPKq8QfOr5xDCnET0ENzst
         MwWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788880761; x=1789485561;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QhdCOmP4zDl1C4qG/vDZ2J5jFE+DMqbe+H/tbxij/K4=;
        b=R/CQyw5hwE14p+ffm5ODesFkJf3XWsllaPpMyk60F3QiA8f8bfG1wJEY4pHr7pArMn
         P0jftaLmtZJiNh0mVqyPk1z1CNJvZbpFxGzmqSeZVKwKELv+iroK6QmwZkSry0sMfMIg
         F4evwlDOk6E0XJyKQmbxzFbhn8N9enyZoeiGyzvTGZ5XgyhG8zxCxiLZWf7Peslcn2qI
         /uFK2ONMe/e9XY254E3ZxIthrrgc5zyu5eqga1THAoYFpZMZK8i9tSoxRWDKbKlAIS3l
         BaCJDXy1zsE1z27zaS6/x4iOJqOSt/+/zgnkLO1DXOSXGJQQEPjewPltoueDwH+EDl3u
         XpFg==
X-Forwarded-Encrypted: i=1; AKwUvBw6/rygFWqYM2piCYwgtSVWbgcxCtzpMUnP00vZl1OuEB9d3CHFoW12BRhsn1wOQVW5EYnHDPY=@vger.kernel.org
X-Gm-Message-State: AFuF++kYpoavOzrORiWvMp94bUpu6ymYTUFwXTufAm1mu9PGoQpJS5HU
	i30X73G0yjgomDW33RVY5sBFIKuoj1ytCw1icyFPDJCSS1ZMa5mI4cg3
X-Gm-Gg: AYBFou1wcfWp2ErvmeCn9IxjV5EXxFuUUm1HLZptRU2/XF/4evO9v9nXVz78SE2iuXW
	kpA2V+VQBiMEKioOUP5zu6sswqcXAnf8On8EgPQj5d8MaSuycwHmqVVqoWSuFOo/JJh19c6Xdql
	weIZK5/7GKBr+vHTwc4w1QaeL9TRGAMIVXcGjIA5WJHWXiHj/5aogT4RvdO78GTyONgdvmHzane
	OW74yYRTJD/ADeyrbU5zsPASL1n4Y+GpNOWa0GSPNQwFi8EWpjAd5VY2aTmFWM7tdiGcKse82s9
	6E+WMv/Nc9C2y9etyff390HKn5HmKHl22bY5zzjYG4bMAyMO+1L2fU4/SKGY+wF7EKXiPzEv/l7
	nxbLVFiF7aa6xsTseHmt8tFOL+9JcFl/uOGoKCwDFUy7ZNjyQ6XxhBLiwJABksYs55eh/mpHKnT
	zQ/vBn8v+Ut8xuMysQtHruw6ZcUlaEPXRdDBrBfRuUoy/VVNofvwEF1UOolxOPU/jghPVQZ91TN
	yRr9ugZVYuj6AKsaw==
X-Received: by 2002:a05:690e:4893:10b0:66f:c6b0:e10b with SMTP id 956f58d0204a3-670f63fcd8fmr2064936d50.68.1788880760843;
        Tue, 08 Sep 2026 08:19:20 -0700 (PDT)
Received: from localhost (c-73-105-0-191.hsd1.fl.comcast.net. [73.105.0.191])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-670febedc44sm1035024d50.11.2026.09.08.08.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 08:19:19 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
X-Google-Original-From: Yury Norov <ynorov@nvidia.com>
Date: Tue, 8 Sep 2026 11:19:19 -0400
To: Andrew Lunn <andrew@lunn.ch>
Cc: Yury Norov <yury.norov@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Raju Rangoju <Raju.Rangoju@amd.com>,
	Prashanth Kumar K R <PrashanthKumar.K.R@amd.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jian Shen <shenjian15@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, linux-usb@vger.kernel.org,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 7/9] net: phy: use linkmode operation return values in
 phy_device.c
Message-ID: <aqAnd1gpXne2lqCT@yury>
References: <20260907215439.409858-1-ynorov@nvidia.com>
 <20260907215439.409858-8-ynorov@nvidia.com>
 <67ed1522-cec8-4137-85df-ffbae654e07c@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67ed1522-cec8-4137-85df-ffbae654e07c@lunn.ch>

On Tue, Sep 08, 2026 at 03:52:09PM +0200, Andrew Lunn wrote:
> > -	linkmode_and(sfp_support, port->supported, caps->link_modes);
> > -	if (linkmode_empty(sfp_support)) {
> > +	if (!linkmode_and(sfp_support, port->supported, caps->link_modes)) {
> >  		dev_err(&phydev->mdio.dev, "incompatible SFP module inserted, no common linkmode\n");
> 
> From a readability perspective, i like linkmode_empty(). It is more
> obvious than !linkmode_and().

OK, a function returning 2 values is not something obvious in C. What
about this?

        
	sfp_supported = linkmode_and(sfp_support, port->supported, caps->link_modes);
        if (!sfp_supported)
		dev_err(&phydev->mdio.dev, "incompatible SFP module inserted, no common linkmode\n");

> None of this code is in the hot path. So we should put readability
> above performance. 
> 
> >  	/* Some PHYs may advertise, by default, not support EEE modes. So,
> >  	 * we need to clean them. In addition remove all disabled EEE modes.
> >  	 */
> > -	linkmode_and(phydev->advertising_eee, phydev->supported_eee,
> > -		     phydev->advertising_eee);
> > -	linkmode_andnot(phydev->advertising_eee, phydev->advertising_eee,
> > -			phydev->eee_disabled_modes);
> > -
> >  	/* There is no "enabled" flag. If PHY is advertising, assume it is
> >  	 * kind of enabled.
> >  	 */
> > -	phydev->eee_cfg.eee_enabled = !linkmode_empty(phydev->advertising_eee);
> > +	phydev->eee_cfg.eee_enabled =
> > +		linkmode_and_andnot(phydev->advertising_eee,
> > +				    phydev->advertising_eee,
> > +				    phydev->supported_eee,
> > +				    phydev->eee_disabled_modes);
> 
> So, which is more readable, the original or this?

The new version is more readable to me. What about this:
        
        eee_advertised = linkmode_and_andnot(phydev->advertising_eee,
	                                     phydev->advertising_eee,
                                             phydev->supported_eee,
		                             phydev->eee_disabled_modes);

  	/* There is no "enabled" flag. If PHY is advertising, assume it is
  	 * kind of enabled.
  	 */
	phydev->eee_cfg.eee_enabled = eee_advertised;

Thanks,
Yury
