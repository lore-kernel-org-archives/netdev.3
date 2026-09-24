Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB00A37B002
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 09:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790242238; cv=none; b=nPYARAKPaJG9Na9oh6RQSOMooM8Y9XTv+HfAjudXuLym2689+X0jCFogbS7vASxJoyyVBera4jejiHwCWSmLgMYTihrWs9bbou41JTzQKABYlTWUENkx592SJPv3qzv98VUepCHri47xeieenNfDMRuNOLLATMFcCjdqYPxMN2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790242238; c=relaxed/simple;
	bh=OGeIwVwDe8oME1g5NKc/KR/rvF0BXlH+bMB1IT3yRkg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JxB+3+1i8NIh4uKoQeeGDRA32SW1Vog1BdcHH0EE7VwAu54mxsR9HIWtPjwXuw0HQjbnVCyBSlwzMPm4EDN8eLFASES3wJZtFuMRNQaCnNLSo7bVK14X9cTtXTcvwCHR5xv5vp3bVDWpbw4oRah4uZCpCVCPVsyhoQAU7pvOQaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F6FjQAd5; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=eWJJ5226; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F6FjQAd5";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="eWJJ5226"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790242235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mTrjsIWcICpVWaDL+QIPC/Do7s36dFqemExsR7yHAPE=;
	b=F6FjQAd5QyNw5jnu/fE+3Yvo97mfMc076r+4dd7jeIz2ypIPuLyhLb0Gvj7Q+xrbYcXgWS
	RmybaSAju2HZvJDCzj+Ls4LT50aAy3b8wRl4t2CH1kC88G61Bd41tGwqXMBC9iHqDuChen
	PkcX8Trpwz2s4eHphfioTxDM2UmDc5o=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-J4-76t1-MbqbSyYzd6AlOQ-1; Thu, 24 Sep 2026 05:30:33 -0400
X-MC-Unique: J4-76t1-MbqbSyYzd6AlOQ-1
X-Mimecast-MFC-AGG-ID: J4-76t1-MbqbSyYzd6AlOQ_1790242232
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c2939e341f7so206940866b.2
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 02:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790242232; x=1790847032; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mTrjsIWcICpVWaDL+QIPC/Do7s36dFqemExsR7yHAPE=;
        b=eWJJ522627IaLcthjkZHs7nISpUNmQ2UKNlOytSMp9olzcw9hWWnC7toUmuWSpXRGr
         8DkQnM99Nuin45EED7TEG7Rs2QjO7u876dQq8Nsh39+TlQM2UOLj81CpI0htaNIU57eS
         loSyWILpkjYE9eXyyJP+0f2ZJYfEJcTPi6MqPho+WWM7DaFhbkpomLz8opldi6vgHi1n
         WNO+ovbjpZwak04gRdzl1WfZPG2nfcDu/XDqibXf5Ya/VlsqT6rVRb3fsPGhsW5c4+PX
         U9ypNNTtREMoJ9LDuxSowj+eWQ+r0DGlhZWSeidnotVDjZCHGyv922k6+UZ9cXrsODim
         7ZpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790242232; x=1790847032;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mTrjsIWcICpVWaDL+QIPC/Do7s36dFqemExsR7yHAPE=;
        b=N1IRS+3t/E5ekIdfd03ZJsO/I7sVSnqcIbJ7GXpQN8ZuMHyH7bukzShI7odK4FixoG
         7tAeF88wn3OYFCD3M68PzwQu75UI/dko2shh9L2LJue3oWc1hFf9H9IGiMEVaDR8uve9
         8PCNl3sLUOCP+963bbzIq/5rt7SAVmtqYeitpCgXKlIPdwvYW3edCpfncVU9yV4fOi+y
         6Ynz7RHN/NyzHSuWAKDDQE7Agj3M8D3/SizOpSp8nOSA6f+24SkWkw1SkDamJUzRk4M9
         oMFyUXqavaIVEo1FW1id2xIQhBuIVjsHlRO783xhbadp11rafFj4W02s3T8SE0GVxAU4
         UIJw==
X-Forwarded-Encrypted: i=1; AKwUvBzybYU9d6Htg+gpP61Wec/Lxbp0L6oHmgz3NPN7CyKnv5fv+Z9LKXSh99ToB3NIUFdg7rvcDcc=@vger.kernel.org
X-Gm-Message-State: AFuF++nnkC7Zj7EyWlCpS/ue5yF8jKFok6PuV3aVU2qTnl4NIvZrTtM5
	2Dk4ybukSAlff2+CvdXSBRi/YQrc6LtD+uoq8iG2D5hUz6Dlu5E4caoaHVErWmnbW5k6Oc9X/5l
	zQ7XsO+RdPhaQxTpNb3jV69yYllkZcXKORPXmEKjL9jp6nDWg2FGnz8F/8Q==
X-Gm-Gg: AYBFou2VKOoKDp6uT8VCrLZvTaA2I7nBT/oOiqYYe8mgpTq/QxJpqDY25eG0ZM3To1H
	WA0+AI6V2LKQCuOHojLk86YnCxAo3XtwV3zyUJiZmUC8X67UDqekZXxzk2rTffLZ/7S78dWW5pT
	/iwMigq1s/+gfcCXqjaCj3q+Lj9xnjy80xHALIfcSnSgzzla+Op+idC5i1YZbLM6NWhVoIcmwc5
	YJhMx32NLR/O6mm7zsgpDdis80IgkRSX4K0nlAOSu6kQlWNVniMZRuFsFgjCUQRboeYvM1xUmlf
	UzdEbg+it2y0S1Ak/IC9vXhxVMhWyOJSkUtBVh/5UhQFEhsUx/+13ItUoiCKRBG3SQNRlDiXsPz
	7krlEztOQiCa7kjbZRZ/kvRGRBsC9CFEA4WjXmwx+kmCg31lOpL+U47FSnv8UpSjZjqDzUkewzQ
	==
X-Received: by 2002:a17:907:1999:b0:c29:45ad:7af7 with SMTP id a640c23a62f3a-c2ac256d4damr160715466b.30.1790242232105;
        Thu, 24 Sep 2026 02:30:32 -0700 (PDT)
X-Received: by 2002:a17:907:1999:b0:c29:45ad:7af7 with SMTP id a640c23a62f3a-c2ac256d4damr160713466b.30.1790242231685;
        Thu, 24 Sep 2026 02:30:31 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2aae6ecd17sm269433866b.63.2026.09.24.02.30.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 02:30:31 -0700 (PDT)
Message-ID: <a7148410-7e21-42cf-939c-e24537fdf031@redhat.com>
Date: Thu, 24 Sep 2026 11:30:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: phy: refuse to attach a PHY whose driver
 is being unbound
To: Aleksei Sviridkin <f@lex.la>, netdev@vger.kernel.org
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 linux-kernel@vger.kernel.org, maxime.chevallier@bootlin.com
References: <20260919015340.499675-1-f@lex.la>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260919015340.499675-1-f@lex.la>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/19/26 03:53, Aleksei Sviridkin wrote:
> phy_remove() clears phydev->drv as its last act; the driver core clears
> d->driver only afterwards, in device_unbind_cleanup(). An attach entering
> that window still sees d->driver, so it skips the genphy substitution and
> then dereferences the NULL phydev->drv.
> 
> Unbinding a PHY driver under an attached consumer crashes in real life.
> The board that showed it is an MT7981 whose copper PHY driver needs
> firmware from the rootfs, so the driver arrives after DSA has attached
> the PHY. I was testing how a port copes with that driver coming and
> going, on an OpenWrt 6.18 kernel with the distro's backports, local
> patches and the series under test. Racing a sysfs unbind against port
> teardown and bring-up oopsed twice: once in the state machine, and once
> inside a live phy_attach_direct() where phy_init_hw() had already
> entered the driver's config_init(). The second came after a
> one-line NULL check at the state-machine site let the run continue, with
> nothing added to widen the window. Both have this root. Neither is this
> dereference: in one the driver went away under a port close, in the other
> mid-attach, and in neither was phydev->drv already NULL when an attach
> started. That window is the narrow member of the family, and reaching it on
> demand needed a 200 ms msleep() at the end of phy_remove().
> 
> Refuse the attach rather than let it complete on a driverless PHY, with
> -EBUSY, which this function already returns when the PHY is attached
> elsewhere. Without phylink the netdev would come up on a PHY that never ran
> config_init. Under phylink it does not get that far: phylink_bringup_phy()
> dereferences phy->drv->name as soon as the attach returns.
> 
> The mid-attach case needs serialisation rather than a NULL test.
> phy_init_hw() tests phydev->drv once on entry and then dereferences it
> several more times, and it calls the driver's own config_init(), which is
> where one of those oopses landed, on a dereference made by driver code that
> no test in phylib can reach. The device lock is not available either:
> phy_attach_direct() runs under rtnl from ndo_open, while phy_remove() runs
> under the device lock and calls sfp_bus_del_upstream(), which takes rtnl
> for a PHY with an SFP bus.
> 
> Assisted-by: LLM
> Signed-off-by: Aleksei Sviridkin <f@lex.la>
> ---
> 
> Notes:
>      v1: https://lore.kernel.org/netdev/20260914204200.2743251-1-f@lex.la/
>      
>      v2:
>      - Said in the commit message where this was seen. The site in
>        phy_attach_direct() was found by reading the unbind path, but the race it
>        belongs to was not theoretical: it took the same board down twice with no
>        instrumentation in the kernel, while a sysfs unbind of the PHY driver was
>        raced against port teardown and bring-up. v1 opened with "found by
>        reading, not from a crash report", which was true of the site and
>        misleading about the race; that line is gone. The second of those two
>        came after the state-machine site had been given a local NULL test so the
>        run could continue, so the kernel that produced it carried that one extra
>        check; nothing was added to widen the window in either. The traces were
>        read at the time and the dumps were not preserved.

I read the above as you observed the addressed race without additional delays
in a real-life usage. That means target should be net.

More importantly if you observe and address a crash you should include the
relevant stack trace in the commit message.

Also I think that the sashiko feedback is relevant: you should attempt to close
the wider race, with proper locking. I read last part of the commit message as
a pre-existing lock inversion (RTNL should not be acquired under the device lock,
only vice-versa) prevents the more straight-forward fix. You should
provably investigate solving such lock inversion.

/P

