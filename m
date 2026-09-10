Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B3238DC71
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 09:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789031223; cv=none; b=T9N8F57ohEfCEnQxfLYtlOZOF9jnrdstqOspGSgyHH7UqGnRrnCLVvsWq+sA+h1Zmwbhu04RUtwyN18DhxBxAySjEI8PtVpE3vlILvEhX4o87LzMp0KnkJvnjpYj8LunFWaGZpMHtBwPOODJrVNb1PVXTGNMHo5XGN7ckX/tKtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789031223; c=relaxed/simple;
	bh=98ptv6rfuwvhydBME95fdFOyv6p1Cs4i6w7lfirkLa0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tgRrGVfz+MTS/Rrc9OEyWvodqFVV/C/VeK9XDMQ1IjTsZF5HKQugOwo3otca4Aukx53BSO5D9QF/2hejP4NbOZf2BHP4jjRUZuwc5ve4oM+6Hq537xN5JkJAK4zINZvuabzf2WKzG/XYk3XSm5OsxFoPR+sYly+DgnUSQB1H7Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NA0aWsjd; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=l95Q5+Qx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NA0aWsjd";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="l95Q5+Qx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789031220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mtDa2p+R7+DpjSivG9cDQd2WySu2bvarovpKx6zwgkM=;
	b=NA0aWsjdP6j9qxtcq101tWxzcKUEtNgqGxhOsAfnXdlccTZigh+/3PACpQFF0I2afAdwqS
	mROV3b6otB8d4smLkxPB1+7lIHmI3J2K6zH9kfJjK0lR6nVuin636oTcdGOY5389VytCfk
	WDENmCU3V7xjHer4BJ3dK83Fljlr9lY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-yYhLiBpkMteRdZFIzsHzSA-1; Thu, 10 Sep 2026 05:06:59 -0400
X-MC-Unique: yYhLiBpkMteRdZFIzsHzSA-1
X-Mimecast-MFC-AGG-ID: yYhLiBpkMteRdZFIzsHzSA_1789031218
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49cced8309bso65337585e9.3
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 02:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789031218; x=1789636018; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mtDa2p+R7+DpjSivG9cDQd2WySu2bvarovpKx6zwgkM=;
        b=l95Q5+QxVO4YVlbKSo7HqBdyEHCz4lO1JEqDSHA/uS87UsN4mnJxSAGlubgobHAQ09
         c93tyN0Hj/jFpYOOvYNDowpVHJc2ep4R3Bs4BzelnITYdSMAEd8BQFvouzzVb3+YimH0
         g5YUifdNYzx3M7G/H2otQAbBE0wBdEz7R82wQ6g5H6d70/cyMJKqg5m+LxYneiVUCYgF
         wBXdoQUlZQomRXeQFchCILWr91I1I0igzwnDzALPAGCA7JFVSgGd2A7Z+b95nbeW5vOP
         KFU15VKQTGhrQQuYkCbjcrsFMxNPt56VBnfiKpesZhoztBEA6g7oF6VHTBDZTJsvfN5K
         u8lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789031218; x=1789636018;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mtDa2p+R7+DpjSivG9cDQd2WySu2bvarovpKx6zwgkM=;
        b=bfQegHIjzMiLxfGET0WeUOEQSF+Yn23tmVW1pyz2yoTcX8gOq4jwQ+7DqLnsZq6u1c
         m+oyzycG807Go/GSD1gtuqJQZ0wePV1T8kBgz/GsAsMnsBwAizi/1qlF7Tre42Nt0ZE6
         tPd/fNMj5Tl4RhKjfJyr893X8F/v67K7tqa/OJajfK9u8zsHS5QW2JYLqnqnRR1hCAu5
         LJT5o7M/oUjWLvjX7cnnpQO4sOg8TCqOsy5qQCsGHUA+LHCIXT9I2lKVTWFe56LmjWZr
         cVakOsuxzJvXiokO+oEtfFiTG3xx6GmGv4zFFcH2vTwSLep5grS1gKolTT4IHdLZLtPl
         beFA==
X-Forwarded-Encrypted: i=1; AKwUvBxr4jwCoxiZDLAUfwd4o3Z2YMLYSuPIUtxd2H1YTObh89hidoqF8EU2U3c/T5AIozq1sAJfTpk=@vger.kernel.org
X-Gm-Message-State: AFuF++kQ1Pcjsd0ifM2n44suQqPt51Oo+VqT3phNBJ3UFUHnT2G/6sAO
	zC6KlJ6n/i3sWEPUVmFFTJmBO3g3JvG8tbmGGUoM3dE4XhKRhmNvMlxOGMfShO5IEP6MiIi3bxV
	E0izwTORfwTyICbTtrAABDCCELYGfb9/xwc5lh1+vbAl8oqVY3GFR1u0CjQ==
X-Gm-Gg: AYBFou2GzE8J0yKIr0EN+w82Ad7AfB3baYVPmE1B3HzZzLtVQP4FAhEQ0alSIQf4VbE
	6MfYFOLC0vW2HW1uyCLoRDiQLO6hR1OmIMwzDIfgck8seLMet204gAS3fU3LD843FZrdmyk7xxK
	j4jYYKj2UwtMiXLRKaR2zT1BhsyOTGJrkXI5RaODZSdODQY4l8N3Uzd+OickK0xlr+VEw8+qBqk
	alheX8EeL4y+pYd/aAAYMFPftHBEiN7wSuoVr8vxvEaJkivydLZ7jYtfOk1vKtTsWYN2DuxXQK6
	RNHjY+xKFIj6vJzg121d+Szna8Rarp1rGN+OBptQ3kmMDeOKbXFt8jpPX2Yv+Ov+8CZr3iLyLAj
	qhYMp81Ohn5SAztR4T6aK4YSx+2WLmTleIw0xxC2yuF4lGSRepYKrNgJo30jMBZunjkvFuYoSZQ
	==
X-Received: by 2002:a05:6000:430b:b0:485:adb5:2075 with SMTP id ffacd0b85a97d-485adb52e38mr7977144f8f.51.1789031217906;
        Thu, 10 Sep 2026 02:06:57 -0700 (PDT)
X-Received: by 2002:a05:6000:430b:b0:485:adb5:2075 with SMTP id ffacd0b85a97d-485adb52e38mr7977080f8f.51.1789031217419;
        Thu, 10 Sep 2026 02:06:57 -0700 (PDT)
Received: from [192.168.188.218] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885bfdf6sm49916954f8f.34.2026.09.10.02.06.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2026 02:06:54 -0700 (PDT)
Message-ID: <2e89ce5a-3d7c-42fd-af82-899f6bc8a64a@redhat.com>
Date: Thu, 10 Sep 2026 11:06:51 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 0/5] net: pse-pd: decouple controller lookup
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
References: <20260906153102.959217-1-github@szelinsky.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260906153102.959217-1-github@szelinsky.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/6/26 5:30 PM, Carlo Szelinsky wrote:
> This is v6 of Corey's series [1]. It takes the PSE controller lookup out
> of the MDIO probe path, so a modular PSE driver no longer makes the
> PHY/DSA probe spin on -EPROBE_DEFER until the PSE module loads.
> 
> Patches 1-3 are the same three notifier patches as v4 [4], unchanged,
> with Jonas's Tested-by. Patches 4 and 5 fix two problems the v4 review
> surfaced; v6 additionally fixes a build regression in v5 [7]'s patch 4.
> 
> Patch 4: Aleksander reported [5] that v4 deadlocks on probe for an MDIO
> bus registered from ndo_init (lantiq_etop, sni_ave, netsec): those
> already hold rtnl via register_netdevice(), and v4's phy attach took rtnl
> again underneath. Patch 4 swaps that rtnl for a dedicated mutex, so the
> register path no longer recurses. The ethtool PSE paths take the same
> mutex, so the use-after-free that rtnl used to close stays closed. The
> mutex lives in pse_core rather than phylib: net/ethtool is always built
> into vmlinux but PHYLIB is tristate, so with CONFIG_PHYLIB=m or =n a
> phylib export is unresolved (v5 failed to link there [8]); PSE_CONTROLLER
> is bool, so pse_core is always reachable.
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
> confirmed the lantiq_etop probe deadlock is gone at boot.
> 
> Tested-by: Carlo Szelinsky <github@szelinsky.de>
A bunch of 'high prio' sashiko reported issues are actually fixed by
patch 5/5, so IMHO not very relevant. Still I think there are a few
points to act upon.

@Carlo: please have a look at commit
c82ff94592fb68f529afe63ca7f5ddb7dae4ba83: you are supposed to reply to
LLM's comments.

/P

