Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212233DBD47
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 11:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780400143; cv=none; b=lnGz2dsxrWSigvX3kXYfTRPlVnSAkEPfwJmPk5WDo1bTkR1CGGa2PTwmA9MEBTPllpLcCzRemTIhM50hBdkX8Y0t3e3RiTXnGQgQTLVsA0eQk/M5K9L37T1hsb+JEV1yboTmZZShjbZnf3HsxRdIsU97E51BxxU4A5FuH+B0vmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780400143; c=relaxed/simple;
	bh=DPNMVXJjVm54XbsOwGM+ZK0c2f+9poiZ1GDO5PtznIA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pQcIoGwe/qPj5WXiZtAjVzP+J0ezqCyKrpO4KayOfCnW8ICXufIfZJxI04cVfYsdNVEvONGM5sxREXNxLye8+O6JRgMZQVatdI5Cac9/c/F2sudc2EHcCmCY4DEgwUyLpdN4nB02Lyqh+SApVVZL78X0n7hoaHH8jIJ2KL+t1yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=IDupJJBL; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="IDupJJBL"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-bebb72b845aso425596166b.3
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 04:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1780400135; x=1781004935; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=oSOGmaHa4kMu8ptSsjX33V0sogN5c4l4AtB7SqHP2d4=;
        b=IDupJJBLjs6Z5jCreNYWkUcolFmpRkLyx8y4qko7l/gBZ0nrQJHvcbStoTruUqGZwY
         suntmneV7BHuwDtyLLB2zUyakaw97BXlFBO5l5nE1tOF46Qj5/WLKSMNgdQ/CFhRfsNY
         luJiy5MZYa/1sDyoMLefB6NDbnMtxuvePoYxQw7lDGVb5nGeZaBilubRiRaqEt3Qzv/j
         Xinpm1ARD5ulvxWoPUv/kS80U4Cg1kWAYG3dZl/h4JQQ1wFlSQJk9z35K7o3vjaTL960
         92IsKEt/WnE4jhoCXaudGfoMXPVMgJqxI0A/+MpDk/CuT8S62cD/yecGlB2LrjFoFOhI
         sdCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780400135; x=1781004935;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oSOGmaHa4kMu8ptSsjX33V0sogN5c4l4AtB7SqHP2d4=;
        b=hhl5ihUoKZ8OJL7NnqU/PihGlIPgYjqV1INJnspbsIeDd6yj0ioVQQgkRlSTbcAKLo
         uRKvRgFmi/7Iq4g0SGofxrLg6K5BphETlZG7TvuR6Rhc/i/dT1QiVbw0ZRIhEvj5ms/P
         mjSEJZqCW0Pbvo815G6ZrOUuSIZvaEhWoiNJeQwGgqkL9HNN/YI0044ajah9cekCMUza
         fKDb+8BU64vpdyVC91hOC5Q6HVaGVYTP0Y4X8HkYIr7LZSeoqasu7gXIcun4lCghYzbm
         Cfkvbd2KQ3JFj+KXvSL0XjOaBJtjY1h2wAtUFd5R8TxgAlw6gO6UtpQgMVD/WXPitgik
         nosw==
X-Forwarded-Encrypted: i=1; AFNElJ+nhWBYuIabixW/MVcDX+gjbOee9+4UQ5K3tf8AiUBldL38QPEpeUBZbdnCBfnlDaNFwK3W1bE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvIGvlb/Lu4kVZxX4WjfldFl2bBUIHJ6OQ72bOC9v1s6R6ll5V
	2iqyPONOeYel+RYfU850tC5RXjY9tj6LG3fqO3RLpv3119KSa7p0Nw/ztClwewxN87s=
X-Gm-Gg: Acq92OGG1q36nRAXlrdAwnlUzEKswFMOkWmDWRfEDuQGVdSOZlKh+jHDzvYKUmyEatS
	rvF2iRfkw5N40u1enZe5am9lawfwUN4RTyL0llHensAZeEIG4RLNVZLI/AhemwZB/Vq1EjuTOqK
	gM52lfd0s3SKBF8oAIgViSy9+iY+t7UGAGIrcfVOfFQwcb9NppSO1ISvYfHJFdu6nnGoxDMVk6S
	n3SR4VvToMOqLJIxNxmGWFm6Pw+x7qInoXIuFmYxKkUg4QDNNuMBCTN3vw7q5g1yFgc6DZoX9pA
	TqO/xDRDoRtRbWFMFFy0v4MjRDQPRB1cikH3h0vtovr12TOlls51kGM0lP6AffbDw3yA5psr6mY
	lOn2nX9w44kISXiprehkcxku3kqZcUklo6qV+4Tv1jpKMCF7WugYpB/LdEp32xZUiWBY9UgmhPA
	138eqnsj6YCeFFePRXbPvmfpHVD0XYN7ovcocB
X-Received: by 2002:a17:906:30d7:b0:bea:f4e0:c7b9 with SMTP id a640c23a62f3a-beaf4e0d3ebmr549558966b.19.1780400135283;
        Tue, 02 Jun 2026 04:35:35 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-be9d2de5c60sm481545266b.16.2026.06.02.04.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 04:35:34 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: Jakub Kicinski <kuba@kernel.org>,  davem@davemloft.net,
  netdev@vger.kernel.org,  edumazet@google.com,  pabeni@redhat.com,
  andrew+netdev@lunn.ch,  horms@kernel.org,  michael.chan@broadcom.com,
  joshwash@google.com,  tariqt@nvidia.com,  haiyangz@microsoft.com,
  linux@armlinux.org.uk,  maxime.chevallier@bootlin.com,
  willemb@google.com,  ernis@linux.microsoft.com,  sdf.kernel@gmail.com,
  kory.maincent@bootlin.com,  danieller@nvidia.com,  idosch@nvidia.com
Subject: Re: [PATCH net-next 02/14] net: ethtool: make sure
 __ethtool_get_link_ksettings() is ops-locked
In-Reply-To: <34fad14a092e28c3512f2405f0869133@tipi-net.de> (Nicolai
	Buchwitz's message of "Tue, 02 Jun 2026 13:20:30 +0200")
References: <20260528231637.251822-1-kuba@kernel.org>
	<20260528231637.251822-3-kuba@kernel.org>
	<878q8x5mip.fsf@cloudflare.com>
	<34fad14a092e28c3512f2405f0869133@tipi-net.de>
Date: Tue, 02 Jun 2026 13:35:33 +0200
Message-ID: <874ijl5g56.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jun 02, 2026 at 01:20 PM +02, Nicolai Buchwitz wrote:
> Hi Jakub ^ 2
>
> On 2.6.2026 11:17, Jakub Sitnicki wrote:
>> On Thu, May 28, 2026 at 04:16 PM -07, Jakub Kicinski wrote:
>>> __ethtool_get_link_ksettings() is exported and called from sysfs
>>> and many drivers. Looks like commit 2bcf4772e45a ("net: ethtool:
>>> try to protect all callback with netdev instance lock")
>>> missed adding the lock around it. Not treating this as a fix because
>>> I don't think any driver cares at this point, but if we want to
>>> remove the rtnl_lock protection this will become critical.
>>> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>
>> [...]
>
>>> diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
>
>> [...]
>
>>>  /* Internal kernel helper to query a device ethtool_link_settings. */
>>> -int __ethtool_get_link_ksettings(struct net_device *dev,
>>> -				 struct ethtool_link_ksettings *link_ksettings)
>>> +int ethtool_get_link_ksettings_locked(struct net_device *dev,
>>> +				      struct ethtool_link_ksettings *link_ksettings)
>>>  {
>>> -	ASSERT_RTNL();
>>> +	netdev_ops_assert_locked(dev);
>> Not sure why we're using the "compat" assertion here, which falls back
>> to check if RTNL is held, instead of the newly introduced
>> netdev_assert_locked_if_ops().
>> The contract here is that all callers are expected to hold the
>> netdev lock (if needed), IIUC.
>> [...]
>
> AFAIU that's on purpose: the original helper had ASSERT_RTNL(), and
> legacy callers still enter with rtnl_lock via the wrapper. _if_ops
> would silently pass for them if rtnl ever went missing.

But the legacy callers continue using __ethtool_get_link_ksettings(),
which has an explicit ASSERT_RTNL(), so I still don't get it:

| +/* Convenience helper for callers that hold only rtnl_lock(). */
| +int __ethtool_get_link_ksettings(struct net_device *dev,
| +				 struct ethtool_link_ksettings *link_ksettings)
| +{
| +	int ret;
| +
| +	ASSERT_RTNL();
| +
| +	netdev_lock_ops(dev);
| +	ret = ethtool_get_link_ksettings_locked(dev, link_ksettings);
| +	netdev_unlock_ops(dev);
| +	return ret;
| +}
|  EXPORT_SYMBOL(__ethtool_get_link_ksettings);

Anyway, no sense speculating. Let's wait for Jakub.
