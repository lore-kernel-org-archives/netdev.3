Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25DC3DAADB
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 08:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787818937; cv=none; b=hfGLEe/BjUlFH2KWdu/nlJ/6OX4DNvSGmtTnegB1QY75OhJaRHljihVkO09PJTWdoLLC/gcbnsFvSUWLDrMRqJGawWM1e6lWbjVFlTt2lGcGO2pj370i0c5xeO0cSWMUL9vP4Lvzu9xMLVG2xWZdv7qNux7Xvg0U6tWKMjMCWNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787818937; c=relaxed/simple;
	bh=/gv3ufdfwILdTEX7Eod5gwGywiG4fL8+snjE/boMplY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HX0J+6bFidJb5ihwQH/FUswslAc3dO4HLq0iWRpY2oL6HggFNt8BNyWdnVl0+XJXZGm6X2NqlHI913wlBLAK3y9bp7NleSnkHECsE/pkh9fmjX0molpKv8Pr7kfxmSrLHFuTD7RVb28WSpxI1ZQXMq24iCGdYt+Bmdg9y5wY1wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KytYM/cg; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HFUhyI6j; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KytYM/cg";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HFUhyI6j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787818934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gKHp3gLrKf8rOuYKQ/7dH0d3WeV+yyWGmO/XcuuHT1c=;
	b=KytYM/cgKtyIilG5qLurTQRPySMVjOM5QcrBcjsmgBWWSCePIJKCzesT0W0E03/HCtJdK7
	FncHAXGX82P4X6LS+xgZDFFiZgg4MEKk5EhJW0cmLLBzWqhBliNTGZ+yux4gxzZ8E8rCRn
	MroEXskIxaSDNELsPfd1yJN29kEqxxU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-lDO5yZk1NnyX2tDWkxXWdw-1; Thu, 27 Aug 2026 04:22:13 -0400
X-MC-Unique: lDO5yZk1NnyX2tDWkxXWdw-1
X-Mimecast-MFC-AGG-ID: lDO5yZk1NnyX2tDWkxXWdw_1787818932
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-482e8e1ac69so328977f8f.0
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 01:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787818932; x=1788423732; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gKHp3gLrKf8rOuYKQ/7dH0d3WeV+yyWGmO/XcuuHT1c=;
        b=HFUhyI6juYhYOqlNprfjyRDyn+CxzK9Dg5kf1bHkwPrbPoxL4hzJr5GiugM4kZO/8g
         c5WQoGk3fToTfR2kvstGoBJHJol9I/8F5iN6nYdMs9aauczcBIMP5Sic+JpnfGHHuqHA
         lA0gW4rBqec7xiUM3MghW9MR176x7zCiDIs8Vq8ycaDWORW9MN1SKcVKM555PVD+gHqz
         IuJ3fhQtQgLlDu7xzm7tqX4LLZBsJLNyFGQzhjyTN3ejjGA3dfqSqhzZiHi436jcV48e
         AeRL9UYfqiibEWK1Wb5Rkp8ByA0tMeoEuH15MvdX8h/5VOe5B++o53lfkGDzG/DxMmtf
         0IKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787818932; x=1788423732;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gKHp3gLrKf8rOuYKQ/7dH0d3WeV+yyWGmO/XcuuHT1c=;
        b=ns7Nsi2COf81ZFr4avK4zUcoFQENNn5CaRxuphlNUACcIX2h8EiY548mrYBHCgFPtS
         XPADn8rj60Y4BV8g17z2jveF33KAQc1GJTeFChsUlfuBvlNganlY3YaO503HjX3D6Abx
         156tyxOdaglpVncDpHdN/4mv7j/0y37BgUGXh0H20pzsBYJR1SBotwHPU/ECJSy8jyQ8
         h8im7jUOrvmOTju2l81HJwE7rpr3/5YTwCSrhj697z3O22PKUhvnU9ycuo+NNLShkA+V
         mMC1AbRKv0rWTTH5uBeGj8/oWkiVsIQC/xKWP1GXKnH9f3j4gPUx91BQiG6xZYKuC6TD
         hQhQ==
X-Forwarded-Encrypted: i=1; AHgh+RpW5QUIituvwoq/vAZSkYA183GkdT/wRZZiEE3ucTBdiADpjGEiO9pXDGIGgRS/E31495fyMMw=@vger.kernel.org
X-Gm-Message-State: AFuF++njp4+moiNMAlQ33rYDXevq2aTs+7RIvpZvR+jCQbjEOtPog0ix
	hiptJqjR0A326tUD4LjYVIynDfGaGC8pzWKQ2AW7MPjD33FnPL/u5AjM9vmCHmpJp3M/4EamdhS
	pQaPR22WSBuZZqoj1AWsvDDK/pkjnpZjwzyfilPgXh0ARcxCrgApTvhz3TQ==
X-Gm-Gg: AR+sD115zZPB3rpTS9+J3l1o4/qHkTlwJt4l8h0jle15R0OeKnazmWIFxdvMlFSExVa
	Y/0X88PGxX1jBfDN8uoFwh293uoNQUZxkjVmz99dcclQjfGnyEFya5DDSBUUeAT1o/gxVjXApag
	Ihj8CP1UERnx5fer0iXEOeo9VXzqftmjgzDa8vi1LI57BFC5SgTqTyG3AeN+isLKMfESkkH3lJd
	FXcGuS6tYX+lXf6gUdAsl/Ns7nibl5bUKLqaOjlAClxDSyOglBo7nMI+XjaOLYTi/X6V9HPtW0y
	USoThLm7nW3Iv6HSUUTyssv6M/u9hlYdGNDq5PH6vnRTjhPc+hNjaGx5ljv8hnBgJgmVeKwUrsx
	BZ7LmcbIGSr+XC55vIQJHiWA64f2gChssz18pHzvURq6bwFfIgQc7CY77U+Uu30C1YNwnU70=
X-Received: by 2002:a05:600c:1c06:b0:49b:8f5e:51fb with SMTP id 5b1f17b1804b1-49b8f5e52b1mr7615685e9.3.1787818931747;
        Thu, 27 Aug 2026 01:22:11 -0700 (PDT)
X-Received: by 2002:a05:600c:1c06:b0:49b:8f5e:51fb with SMTP id 5b1f17b1804b1-49b8f5e52b1mr7614535e9.3.1787818931303;
        Thu, 27 Aug 2026 01:22:11 -0700 (PDT)
Received: from [192.168.188.103] (ip46-47-231-195.pool-bba.aruba.it. [195.231.47.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b4aff5ffbsm28366465e9.13.2026.08.27.01.22.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2026 01:22:10 -0700 (PDT)
Message-ID: <20d7a730-8ed2-4fb8-bdca-974065d9d70b@redhat.com>
Date: Thu, 27 Aug 2026 10:22:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 0/5] net: pse-pd: decouple controller lookup
 from MDIO probe
To: Carlo Szelinsky <github@szelinsky.de>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: Corey Leavitt <corey@leavitt.info>,
 Jonas Jelonek <jelonek.jonas@gmail.com>, Simon Horman <horms@kernel.org>,
 Aleksander Jan Bajkowski <olek2@wp.pl>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260826220344.121865-1-github@szelinsky.de>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260826220344.121865-1-github@szelinsky.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/27/26 12:03 AM, Carlo Szelinsky wrote:
> This is v5 of Corey's series [1]. It takes the PSE controller lookup out
> of the MDIO probe path, so a modular PSE driver no longer makes the
> PHY/DSA probe spin on -EPROBE_DEFER until the PSE module loads.
> 
> Patches 1-3 are the same three notifier patches as v4 [4], unchanged,
> with Jonas's Tested-by. Patches 4 and 5 are new and fix two problems the
> v4 review surfaced.
> 
> Patch 4: Aleksander reported [5] that v4 deadlocks on probe for an MDIO
> bus registered from ndo_init (lantiq_etop, sni_ave, netsec): those
> already hold rtnl via register_netdevice(), and v4's phy attach took
> rtnl again underneath. Patch 4 swaps that rtnl for a dedicated mutex, so
> the register path no longer recurses. The ethtool PSE paths take the
> same mutex, so the use-after-free that rtnl used to close stays closed.
> Aleksander confirmed it fixes his deadlock.
> 
> Patch 5: Paolo's review [6] pointed out that patch 3 defers the
> pse_control_put() to phy_device_release(). A phy that is device_del()'d
> but still pinned (an attached netdev) is off the mdio_bus_type klist, so
> the PSE_UNREGISTERED notifier walk never clears its phydev->psec, and the
> deferred put later touches a pcdev->pi[] the controller has already
> freed. Patch 5 puts phydev->psec back in phy_device_remove(), which the
> mutex from patch 4 now makes safe (the rtnl recursion that motivated the
> deferral is gone), so the detach is synchronous and cannot outlive the
> controller.
> 
> How it works: pse_core gets a notifier chain (REGISTERED / UNREGISTERED).
> The phy layer subscribes, owns phydev->psec, and attaches the PSE handle
> when the controller shows up instead of during probe. fwnode_mdio loses
> its PSE awareness, so no -EPROBE_DEFER leaves it and the probe-retry loop
> is gone.
> 
> Tested on a Realtek rtl93xx PoE switch with two HS104 PSE controllers on
> i2c:
> 
>  - clean boot, no probe-retry loop, no watchdog reset
>  - 10G SFP+ port: module hotplug works, no deadlock
>  - ethtool --set-pse enable/disable cuts and restores power to a PD
>  - i2c unbind -> rmmod -> modprobe: PSE detaches on unbind and re-attaches
>    on reload with power restored, no reboot. No lockdep splats.
> 
> Jonas confirmed the RTL8214FC deadlock he reported is gone. Aleksander
> confirmed the lantiq_etop probe deadlock is gone.
> 
> Tested-by: Carlo Szelinsky <github@szelinsky.de>
## Form letter - net-next-closed

net-next pull request for v7.3 has already been merged, and therefore
the net-next tree is closed for new drivers, features, code refactoring
and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens after Aug 31st.

RFC patches sent for review only are obviously welcome at any time.

See:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer
pv-bot: closed

