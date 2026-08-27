Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A0145D5D9
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 13:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787837310; cv=none; b=AP0wgNKZHTH2kFowlmuOUnPfyPDSoPbW1+1IYuoJTd6y6qJNpAHhndy40ThO8PifHYxa+sUwt5hzP07vXyueWKybmYt+LgNscO7xrmi7h8PVV2ALZiTeS2DtY9ydoXg8DAF30sTGCbcjgmUBb1LIgytkWIv+whohlvdZK1K5la4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787837310; c=relaxed/simple;
	bh=7iws63+16wpG8prIlgxf9CM1D0Nn+luPsBt8FZSBa74=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aNSeYRp36rVxo1SR/enJW5C//wrJpRcqd/m8DbUJs2+fG8hbfPqGCF5wTjFa+ozzUwZVv2NJ/3oaVSM2L2vaRRFM7Q41wfMli4lCmDfZKfg/a8ekw7QRczJw0F6VorsXRBTGnZDtsduJ+2c0+HLtdOlviDGp6bbNW0JaSY62GX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cVHeMPge; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IjTOiGF1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cVHeMPge";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="IjTOiGF1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787837292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dgsSqq61G4OIRRb8rEJF3DAo7sETU8xbSmJ6z7e8iaw=;
	b=cVHeMPgeCqQfoteMk9ecGkRIwVMGKv3QA9aqejP/2/qigvip5X4MHBZvEDu89gen/hqxg/
	jYrGgHwFRQFCYAEwkVPpg6ym30lSZCaog94/yIgf89CSdEKbgpE1ZbcyitCgJ/l4JFS8G/
	6oCZnE4zbQmyjENvP1C8aax7l1fbkgA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-sHRghxtyO86026c44CYZZw-1; Thu, 27 Aug 2026 09:28:11 -0400
X-MC-Unique: sHRghxtyO86026c44CYZZw-1
X-Mimecast-MFC-AGG-ID: sHRghxtyO86026c44CYZZw_1787837290
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4994d67d0e3so13831735e9.2
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 06:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787837290; x=1788442090; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dgsSqq61G4OIRRb8rEJF3DAo7sETU8xbSmJ6z7e8iaw=;
        b=IjTOiGF1QE6y4VjaWIvGAVKQ/tePWYWdCcN/KZEHa59woFV8fOiR7XhfvtWaNBjt4s
         ldLXTVDFtu/5Q8Cl2ZoCN70PMnDK+3p/L5z8FCFNoHLR9AWaIzmqlrVVL08UXbUr2WIG
         c+jsZtscXY9iT2vcANo86V0vDP+u4IBecEuaZqLvA/1da2WOvM6f2RwEWxqJPV6C+298
         55ZCPavAxn/zb0t3JDoyFAS6vpzCkzd0XMHA9+WXYAtdQMWEKNB0g4SEwyPiVD7X5V2f
         8F5Uo1aCOU9Gy2oJtGvCdkMV5bjOWevB5vKuXGQq62ASWheb3HZzSnJQdyVEdHG3nmSl
         lF3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787837290; x=1788442090;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dgsSqq61G4OIRRb8rEJF3DAo7sETU8xbSmJ6z7e8iaw=;
        b=VbODTzBTCbSuM/0Cv9oIaL4Lyf/6vg8xwVs4om8waRZwzrXvFK5lMWJJOopFn73gSR
         dUcULVDZs+PXKs2mnZk2Waau7LniQX1oW7PNW8ahgc2PKKJdzHFGxtsJzYG6CjXmi40v
         PMm0rBJOPBXUXrnY/tbgG2lHCpgIgBHEF1tYc8C/J3TkCtneg1dFL8cvb2J4mOv2N//N
         wjxA4MWTNV9H+Jkrq06vO5jolX3U4QQ3fsVLF0BFyrqWPw/zHRTvUvokL+H/V5xKGiFd
         WGJyDF7TimZy0YSUO+jHDZOt8tXWAHUYewQHNb07Fvtw7lOk5dYEYoEVK7X+vt4q75OT
         2mwQ==
X-Forwarded-Encrypted: i=1; AHgh+RpgGS+ebO3iojpK9bbM/OJyCavtEm7lb6rklB1FPgx1VmAnBq3CwuNuCT34yHNss0+ug7lkh7s=@vger.kernel.org
X-Gm-Message-State: AFuF++lPPGMFiJqRLc4RfbDvFcXZdqWhta4QJ5Qz6TnltjhDdvAU0k9R
	qi43IiR92ZjgPn8oWC7X5Deb9kpu0lSVUD9ekuUd4RkBLK16yYneneI8bvCKKxKP7Zozjypcpo/
	6gw/INsch0QUp+vldxNF3XqoQjcrIy2JkS7aobv3TbwBVXpgMAJ8/OtFKUw==
X-Gm-Gg: AR+sD13v1H+iJxqQs/tDewTfnFkxSvJdozxJEnO/7dYsPT43SuHPjl6zoqDc3ljRI5T
	yIiTPpnaG6sIHfiI8ev5t3gIoctJ/5/NpjOSL0gKOAFWnf2MgnPQuM4KM0oMrRr2fr5iGb7CozL
	SByF0io0X6TEiTXnq+svh0XTw4hxi1ExW9xkxrPxyE4V6QRRaTuDvREmvjWPx7YNtfWn+2N+C6V
	t7JVS4XMM3utSLR3TJbxES4f0RuTuVZ79n93rU2HEoOWXmi+/rJnD7W+qZXqoG5hKA5hjZUWNgM
	kMatssywhkxiB1dQtMjbsn6vsKfLbTb7YtyIwzje905Y616e5Os/sDzbfN97nrlKtNINGGATrMh
	cnd1D1al+9oQw0zf6E1RqoSgHZXj/i5w7AxEhioyQtwp5TgMCLcC+S4FvM+lBOC51ijEs6kI=
X-Received: by 2002:a05:600c:3f08:b0:499:51f0:a9b2 with SMTP id 5b1f17b1804b1-499dc6ec0e7mr200670355e9.1.1787837290305;
        Thu, 27 Aug 2026 06:28:10 -0700 (PDT)
X-Received: by 2002:a05:600c:3f08:b0:499:51f0:a9b2 with SMTP id 5b1f17b1804b1-499dc6ec0e7mr200669165e9.1.1787837289791;
        Thu, 27 Aug 2026 06:28:09 -0700 (PDT)
Received: from [192.168.188.103] (ip46-47-231-195.pool-bba.aruba.it. [195.231.47.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b4e2c1af7sm52968915e9.15.2026.08.27.06.28.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2026 06:28:08 -0700 (PDT)
Message-ID: <79005413-9560-4dba-945e-525a3badc059@redhat.com>
Date: Thu, 27 Aug 2026 15:28:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/2] net: phy: restore the interrupt after a
 generic-driver bind cycle
To: Aleksei Sviridkin <f@lex.la>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>
Cc: Vladimir Oltean <olteanv@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260824024029.41310-1-f@lex.la>
 <20260824024029.41310-3-f@lex.la>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260824024029.41310-3-f@lex.la>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/24/26 4:40 AM, Aleksei Sviridkin wrote:
> A PHY with no specific driver available at attach time gets the generic
> one, and phy_probe() parks it in polling mode because that driver has
> no interrupt callbacks. phy_detach() releases the generic driver so a
> real one can bind later, but the interrupt is not given back, and a
> generic probe that fails leaves the PHY the same way without reaching
> phy_detach() at all. The specific driver then attaches with
> irq == PHY_POLL and the PHY stays polled for the rest of the uptime,
> with no warning on that path.
> 
> Take it back from the MDIO bus interrupt table on both exits from the
> cycle: the cycle does not touch that table, so whatever the bus
> recorded there still stands. A bus that never filled it has nothing to
> give back and its PHY stays polled. Restore only where the cycle left
> PHY_POLL, so that an interrupt mode installed on the attached PHY
> afterwards is not reset.
> 
> Signed-off-by: Aleksei Sviridkin <f@lex.la>
> ---
> The cycle is easy to hit on a DSA switch that probes before the rootfs
> is mounted: the switch connects its user ports during setup, the PHY
> driver is still a module on that rootfs, so the generic driver binds
> and is released again when the connect fails. The real driver binds at
> ifup and gets irq == PHY_POLL.
> 
> Both exits from the cycle need the restore: phy_detach() for a generic
> driver that bound and is being released, and phy_attach_direct()'s
> error_module_put label for a generic probe that failed, which never
> calls phy_detach() at all.
> 
> What the table covers and what it does not. Nothing writes
> mii_bus->irq[] after the bus is registered except stmmac_mdio.c and
> mlxbf_gige_main.c, and both assign the same value to phydev->irq in the
> same breath, so a PHY whose interrupt came from firmware is fixed here.
> A PHY handed its interrupt by its MAC driver is not: lan78xx and
> smsc95xx write phydev->irq after registration and leave the table
> alone, so they keep polling after a generic cycle exactly as they do
> today, and the set of drivers that write only phydev->irq is larger
> than those two. Which raises a question I would rather ask than settle
> alone: if bus->irq[] is the per-address registry for a bus, should
> those drivers be mirroring into it the way mlxbf_gige and stmmac
> already do? If that is the intent I am happy to send it as a follow-up.
> 
> What the guard distinguishes and what it does not. It preserves an
> interrupt mode installed on the attached PHY after connect, so
> PHY_MAC_INTERRUPT from genet, tsnep or bcmasp survives the detach. It
> cannot tell phy_probe()'s parking from the other ways phydev->irq
> reaches PHY_POLL, so a PHY parked by PHY_F_NO_IRQ, by a failed
> phy_request_interrupt(), or by a MAC taking the phy.rst advice to set
> PHY_POLL, is restored here as well. That is harmless for the drivers
> that do so today: phy_attach_direct() applies PHY_F_NO_IRQ again on the
> next attach, a failed request is simply retried, and every MAC that
> forces PHY_POLL does so in the same function that connects the PHY, so
> a restored value is overwritten before anything can act on it.
> 
> The guard is not only tidiness. Without it a PHY that a MAC had put in
> PHY_MAC_INTERRUPT mode would get a real interrupt number back at
> detach, the next phy_connect_direct() would request it, and
> phy_disconnect() would then skip phy_free_interrupt(), because the MAC
> overwrites phydev->irq again right after connect and
> phy_interrupt_is_valid() is false by the time the interrupt would be
> freed. That asymmetry between phy_connect_direct() and
> phy_disconnect() is not new, and it bites any such MAC whose PHY has an
> interrupt to request; the guard keeps a generic-driver cycle from
> walking a PHY into it.
> 
> The same interrupt is also lost on a plain sysfs unbind and rebind of a
> PHY driver, and this patch does not cover that. A restore in
> phy_remove() would cover both paths, but is_genphy_driven is what keeps
> the intent narrow here, so I would rather not widen the fix on a guess.
> 
> No Fixes: tag on this one. The behaviour predates what I can bisect in
> this tree; if someone can name the commit I will add it.

If the root cause predates git history, the fixes tag should be:

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

Otherwise the oldest commit that still reproduces the issue would do.

It looks like out sashiko instance did not pick this series, and this is
net material. Please re-submit with the correct target tree and fixes tag.

Please also try to condense the above writing in a much shorter text, or
point to prior discussion.

/P

