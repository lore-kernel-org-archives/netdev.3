Received: from mail-oa1-f67.google.com (mail-oa1-f67.google.com [209.85.160.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF63175A9D
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 22:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775514563; cv=none; b=sNe329SiQS2UBT1N1VjTEAwPiQaysR/GOYfPc6MyWzDMi26L6CO3MBw4Zur9bZO9yziJ8u+y2VfnaM5NOJPxZNSEt979b8bXsJdcrP/yOMrObASzGxHg8fAQZpqSTI5eWL4uTcfjfojRNm6EaLH4r9cOiRqg319r5ETH7YOEgXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775514563; c=relaxed/simple;
	bh=LUzJA1J+Gw5NjbM6Dld0HvR14OMyArHq5FKNu3pkyzg=;
	h=From:Date:Message-ID:To:Cc:In-Reply-To:Subject:Content-Type; b=NI7gUpsAukNE6tCP+uj5jMYuZsKaQlEkyl1e6fZVc+aGDJm49AOMZsqOQ6086bYYQ/UP23DmKxc0iMq8mIwMMZkvHROJA0yx3d8EXfv1YDdiMA55w6g6CZ2bMYozNVCn4N0s52LyTD3o3ix9Z6mX1pjMJ2Xqq/MHIfJAHLY9htg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G9mRNFdx; arc=none smtp.client-ip=209.85.160.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G9mRNFdx"
Received: by mail-oa1-f67.google.com with SMTP id 586e51a60fabf-41c420d1460so1328393fac.3
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 15:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775514561; x=1776119361; darn=vger.kernel.org;
        h=subject:in-reply-to:cc:to:message-id:date:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+0bGVpl6x2zDew34A40t3ZPrtvEBJJVdySuHtbTCdjs=;
        b=G9mRNFdxbeuSjXFRyiO2QUPf3nFxpFSJW7ZElClm8y2x8Wv4HP4kcRgPKkhvHGF65O
         YmGb0GnSok1mmyB8kptDcv7lBZe9kHlG2SSqfVY2Hvd3cPBq7ZiMJLGynhDuInatOZUJ
         YJ/Q8bdHolzLvUQSTbl8F4CD/YIpmZqi7KlkeXsDhila5RXBQ38hYKpWc2feO0lUTqbi
         avj4Lk0WbM4jwtJGbvix5ZAL2btEe0EWHx1gV3AVo+3LxTIQqnFmfARFY59TSYwsKJcX
         p8qYnHi3Rf29O3KBgLKjRSrVPBx0bH5Mz/RM2cO7VQ+aZ+UK43W6f84hE3Z28IBjU31A
         ca+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775514561; x=1776119361;
        h=subject:in-reply-to:cc:to:message-id:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+0bGVpl6x2zDew34A40t3ZPrtvEBJJVdySuHtbTCdjs=;
        b=dADIHONHrncXr+PobXBoZrP19xJiHnrs/+ClSsm5Jnjjcx/lrfn0QgINdAC+FZuBxE
         J59HnGjblJneODSZCMJujdiMLcdnJSqcnFBWq3MNrJ528py/PVaU27o81be/pAXoNsZY
         cpJuxQWLd8F9XAuxtX4t/qrxctnc9j6dQjskQmRH+AeEBZURt9UBNszwmk6XESh+oNEe
         tK1aI4n/DL1YUmcuSA+KAKYIudmtkujD/WCNenZLV/Na/zMe3jIKeEbuzZauZqM97832
         MjZvG2G7kg0h/zJUAcmDLX6PvSa1/xcIKZIugfImnWsAbbwCJadL9fPnqQQAtyKrRwwu
         i0Hw==
X-Forwarded-Encrypted: i=1; AJvYcCXZ+q5R6DFFIS//KAND9Vv8rwWLoMeyt/HMhEKnhKmKysrwN41vtMMpX8zAUpJQWTe4jbbPV10=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAXocUuPR1ZV8e5+TyOGY4fFhI0r2XtL3q9kcJyuse5o9IPy+8
	NwE9PeSwVPDYpU7kgtxtPRnivtp36ZbLLb1mhVnqoStmIGv7VMPP+lh1bkR+VwBKhommFg==
X-Gm-Gg: AeBDiesezLfhSKfp83LGYICMjJHSBN/Yq3k9br9Td4n6V82i7QaJyTAlA9hygX4mhLh
	kH2sf3CB6wVeQfwad1H7QowYP5ZvzCuR72bZcGjRXkuwXdaxfcc2F5yoQx7iy66d2EgxM+XO4jy
	CU1meEmnxlZirEfh8q9bHhBofTHMGaOuh+vldiuHbojfCLKuf4u+9d03UqzCFZ727psg+59n/LQ
	s/xfJOlW8LJ3YMTciMMfeMx2R3ykqe4dnyHhO5GlKO+COsRrI2E7Q1Cu8GecrP182kcWobgGMXR
	z/KMYdj/KWVo392Abk/ifMtlwqM66jQllBIu1ekbDzjH+hdQXy4XyoDsW88WWzeuR0178gVbhBj
	Awc5oOMot46RkFKQS2I+qRbeOH4mxVMCNWbRCnOA6lf2hI6EuPxcBQF3zN29hbbXLir7JlP+2+f
	BxGza1YoUH28R0fJ/gazreXKrH26c=
X-Received: by 2002:a05:6870:d313:b0:417:837:6360 with SMTP id 586e51a60fabf-4230ffda562mr8041857fac.29.1775514560696;
        Mon, 06 Apr 2026 15:29:20 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:9::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-42330d4a3c1sm7165426fac.1.2026.04.06.15.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 15:29:20 -0700 (PDT)
From: sdf.kernel@gmail.com
Date: Mon, 06 Apr 2026 15:29:19 -0700
Message-ID: <f453b9f890d225d6d63bd3364b69cd5b.sdf.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, jiri@resnulli.us,
 jv@jvosburgh.net
In-Reply-To: <20260404000614.2414164-1-kuba@kernel.org>
Subject: Re: [PATCH net-next v5 09/14] iavf: convert to ndo_set_rx_mode_async
 (b1dc10d5dff2)
Content-Type: text/plain
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> iavf: convert to ndo_set_rx_mode_async
> 
> This commit converts the iavf driver from using ndo_set_rx_mode to
> ndo_set_rx_mode_async. It updates iavf_set_rx_mode to take explicit
> unicast and multicast list parameters and uses __hw_addr_sync_dev on
> the snapshots instead of __dev_uc_sync and __dev_mc_sync.
> 
> > diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
> > --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
> > +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
> > @@ -1150,14 +1150,18 @@ bool iavf_promiscuous_mode_changed(struct iavf_adapter *adapter)
> > -static void iavf_set_rx_mode(struct net_device *netdev)
> > +static void iavf_set_rx_mode(struct net_device *netdev,
> > +			     struct netdev_hw_addr_list *uc,
> > +			     struct netdev_hw_addr_list *mc)
> >  {
> >  	struct iavf_adapter *adapter = netdev_priv(netdev);
> >  
> >  	spin_lock_bh(&adapter->mac_vlan_list_lock);
> > -	__dev_uc_sync(netdev, iavf_addr_sync, iavf_addr_unsync);
> > -	__dev_mc_sync(netdev, iavf_addr_sync, iavf_addr_unsync);
> > +	__hw_addr_sync_dev(uc, netdev, iavf_addr_sync, iavf_addr_unsync);
> > +	__hw_addr_sync_dev(mc, netdev, iavf_addr_sync, iavf_addr_unsync);
> >  	spin_unlock_bh(&adapter->mac_vlan_list_lock);
> 
> [ ... ]
> 
> > @@ -1210,7 +1214,7 @@ static void iavf_configure(struct iavf_adapter *adapter)
> >  	struct net_device *netdev = adapter->netdev;
> >  	int i;
> >  
> > -	iavf_set_rx_mode(netdev);
> > +	iavf_set_rx_mode(netdev, &netdev->uc, &netdev->mc);
> 
> Does this code iterate and mutate the live netdev address lists without
> holding the required locks?
>
> Previously, iavf_set_rx_mode() called __dev_uc_sync() and __dev_mc_sync(),
> which internally acquire netif_addr_lock_bh() to protect the live netdev
> address lists.
> 
> Now, iavf_configure() passes the live lists (&netdev->uc and &netdev->mc)
> directly to iavf_set_rx_mode(), which calls __hw_addr_sync_dev() on them.
> __hw_addr_sync_dev() iterates and modifies the lists by updating sync_cnt,
> refcount, and removing stale entries.
> 
> Since iavf_configure() is called from contexts like iavf_open() and the
> driver's watchdog task, it appears netif_addr_lock_bh() is not held here.
> 
> Could this cause list or RB-tree corruption if there are concurrent
> modifications, such as IGMP/MLD timers adding multicast addresses in softirq
> while holding netif_addr_lock_bh()?

Most of this is seems bogus:
- ndo_set_rx_mode_async path is fine because of the snapshot
- iavf_configure is fine because of the ops lock

What I can do is to wrap iavf_set_rx_mode in iavf_configure into
netif_addr_lock_bh to satisfy the bots?
