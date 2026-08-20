Received: from mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2987317A2F6
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 10:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787220412; cv=none; b=nDOc4L4lP4DKjja8AqxmTh04UccxqNN2YM773l0tf229Sf0kHneoOVPFGlBjAPpTC9QBBkv6ictzd0ZKIUJg0lVR07ufs0kMfT48QP/lrc7bpixeVGnw2jADYdX3yQO3U/FJsD8b/SVBMNDM4O6X6a2lrNNtyZkvC3louJRgck4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787220412; c=relaxed/simple;
	bh=9LJdOzgjMAGRiq2JFYxRxT/wHGq3LUAU3JRtfYZW0OE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nYS94Y69cmuMqWOblIF2LENp14pspjIIUY3DD5XYzhzv66qeN3t3zT7Fjp0bRT4UuaQp+BKO0Z72FqFkcjoyRMKzz2KBdEOXpwUDy+Pi3kfROKYhEHS5sRv2gROKw50gbDeLBH1vNJynt6YoysAeFMP/JdXfjcI3FVwP+wjlrIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wY9bmt7f; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wY9bmt7f"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=9LJdOzgjMAGRiq2JFYxRxT/wHGq3LUAU3JRtfYZW0OE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787220406; v=1; x=1787825206;
 b=wY9bmt7f2kNBF5DhQXommjYL3gyY2INHcCAX76X4r2V66vUArftx3hbBVp4AfadOlE7fsacw
 39C9PlzQW9DpwjCDbB4/BIjEp3ADVVsp4ZnC15YanakUYRtMhezbtfx5yCJYypTaFE6lHSAvbyM
 vz2SrQncMhjfsJuTJOcjndes=
X-Envelope-To: netdev@vger.kernel.org
Received: from [198.18.0.1] (116.128.244.171)
	by smtp.migadu.com with ESMTPS id 0264d887be765534;
	Thu, 20 Aug 2026 10:06:46 +0000
X-Mizu-Trace-ID: 0264d887be765534
X-Migadu-Flow: FLOW_OUT
Message-ID: <6753cab4-d5ee-4760-813d-4427d880a669@linux.dev>
Date: Thu, 20 Aug 2026 18:06:41 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 3/5] net: phy: set PHY_READY after LED setup
To: netdev@vger.kernel.org, kuba@kernel.org, andrew@lunn.ch,
 maxime.chevallier@bootlin.com
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, chleroy@kernel.org,
 linux-kernel@vger.kernel.org, Xuanqiang Luo <luoxuanqiang@kylinos.cn>
References: <20260819060236.24665-1-xuanqiang.luo@linux.dev>
 <20260819060236.24665-4-xuanqiang.luo@linux.dev>
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
In-Reply-To: <20260819060236.24665-4-xuanqiang.luo@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2026/8/19 14:02, Xuanqiang Luo 写道:
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>
> phy_probe() sets PHY_READY before calling of_phy_leds(). If LED setup
> fails, the error path releases the initialized resources while the PHY
> state remains READY even though probing failed.
>
> Set PHY_READY only after LED setup succeeds.
>
> Fixes: 01e5b728e9e4 ("net: phy: Add a binding for PHY LEDs")
> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>
I noticed that Sashiko found two new issues:

> > diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> > index 538e9ca44d093..8fd6fbf378f0a 100644
> > --- a/drivers/net/phy/phy_device.c
> > +++ b/drivers/net/phy/phy_device.c
> > @@ -3799,9 +3799,6 @@ static int phy_probe(struct device *dev)
> >                   phydev->supported);
> >      }
> >  
> > -    /* Set the state to READY by default */
> > -    phydev->state = PHY_READY;
> > -
> >      /* Register the PHY LED triggers */
> >      if (!phydev->is_on_sfp_module)
> >          phy_led_triggers_register(phydev);
>    
> [Severity: Critical]
> This is a pre-existing issue, but by ignoring the return value of
> phy_led_triggers_register() here, could we trigger a double-free later?
>
> In drivers/net/phy/phy_led_triggers.c, if phy_led_triggers_register() fails,
> it frees phy->phy_led_triggers but leaves it as a dangling pointer and sets
> phy_num_led_triggers = 0. Since the return value is ignored here, phy_probe()
> continues execution.
> 	
> If of_phy_leds() then fails, the code jumps to out_unreg_led_triggers and
> calls phy_led_triggers_unregister(). Inside that function, the loop is
> skipped because phy_num_led_triggers is 0, but it unconditionally calls
> kfree(phy->phy_led_triggers). This results in a double-free of the dangling
> pointer.	

Although this part was not introduced by the current patch, I think it
still falls within the scope of probe failure handling, so I plan to add
a separate patch in the next revision to fix it.

> > @@ -3815,6 +3812,9 @@ static int phy_probe(struct device *dev)
> >  			goto out_unreg_led_triggers;
> >  	}
> >  
> > +	/* Set the state to READY by default */
> > +	phydev->state = PHY_READY;
> > +
>
> [Severity: High]
> Does moving this lockless state assignment to the end of phy_probe() create
> a race condition with concurrent MAC driver attachments?
>
> The driver core sets dev->driver before invoking phy_probe(). While
> phy_probe() is still running and potentially blocked in of_phy_leds(), a
> concurrent network driver probe could find this PHY and call
> phy_attach_direct().
>
> Because dev->driver is already set, phy_attach_direct() proceeds without
> acquiring the PHY's device lock and sets the state to PHY_READY. The MAC
> driver then immediately calls phy_start(), which acquires phydev->lock and
> transitions the state from PHY_READY to PHY_UP.
>
> If this lockless assignment completes after the MAC driver has already called
> phy_start(), won't it silently clobber the PHY_UP state back to PHY_READY and
> stall the PHY state machine?
>
This appears to be a pre-existing issue, since phy_attach_direct() and
phy_probe() are not serialized.

This patch does widen the race window, but phydev->state should still
be set to PHY_READY before phy_probe() returns.

Thanks,
Xuanqiang

