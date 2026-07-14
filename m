Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64DC35BDDB
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 11:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784029021; cv=none; b=Pb4Um9vJcedQON9XKEhVTEHI77o4rTjgHKpfBPpWRYQ+0pYebodzELQXDl69VPyPkOXHN302KzHMbRayg4SlAboaCiI8XeVvUCT/ExxRK/KKKYoH5a61d3r31CMKWl7x42PwXXMSr0kd99Rp0wcGefRx5qJiU1j/l7SR2/nVhlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784029021; c=relaxed/simple;
	bh=aKi6l+eRVD1oKycjxSDZEpRPD6tuXU/IZOT+QPWatw0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oIg6WUAS1O4ST06klto1kUQTqoWpS424XQrnIZ4KxQzhd6VXPo2sTa6YFoY4cMovI+Hapz3n32iRbCydm4TyDpDUipwtCCRsBykmsQM03tMkY/x9P8zloCv9PuS5EspyMR97nh517SwuhTZyXygxTgkZ5CYnSsAjEp6RMXIfQNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GjO1+GoF; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GjO1+GoF"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2cc77a6943eso20303415ad.0
        for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 04:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784029019; x=1784633819; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QfszI3/9x9yG0BiAtw9Ae070rJI+dJEzJ6JtNwTW3h0=;
        b=GjO1+GoFqmrXxq77dQ7r48edPsIxxKmk0ATBawShlEy5ia/gK0C3YPIbFQOaYIfLhE
         iEGs5l8kXgh/5DKdtKXxdA+HMwwnE1SHm+/4VGfA9LcjjBP9eZpw/6chNE7MjltrKQuR
         dnoMsc22o+h0sqlm0Ili2qyMSAxNfQ4sz1AOXrHz7oekzX6cTq2lvrfgcZT1qC4WWexo
         BMdo9xFDUxHldObVoHA/y64ijtIS8NFZ4LGPinl3ZLNeS/weUhu1d76JTBNuf/IGMmS7
         5aSdIkjCMFJ7NlLuEJsSvR7V/LOnFd4+jfXw+d+jg2El8EKWMml2/sonyQlq4Lw6VZqQ
         Akhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784029019; x=1784633819;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QfszI3/9x9yG0BiAtw9Ae070rJI+dJEzJ6JtNwTW3h0=;
        b=rAWDzX4Ml/+J7CPHo52TjjySOs7lgYy7hurCnAA3/VutW36mflHG2X0NT39Spg6YdS
         Hx2tUM+JQcYRo5od+Rs4hBAd01LDIX2pQtmMOmdFwtSmOvPtJ4EQ5T9dq/harCeRK3aw
         9So1nHq/MtNBSd1uC+Qz1SwbxbH+d1qYMPu/qoI9VL38JTKIS0EmuV00PxVPCyCQ89Jj
         yeQvh3zgmzelJVPvWvoajPjfQ0A4fjXtX+POxXwz7nSC4xQkZfU6gR2pztD2cEyp5hQW
         jgbtkyyf3WwtWEStJdxxhTJldtDCa8xTDd8Quwi2PcUaWbpcii2syXDcuIs5d5lH5J92
         8doQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro9Eg9IRNJg+3ET4IlA3Vg5B0Llrg/7b2vcfL8FFZ0e0mkcp7tEPwpXn5dVP2Btqnk5N72CZ+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIcjiJZjOESEXoSSSRUpfhexqT603adVOCcWw4hNpFKxXpP/rM
	orak6ZRlVcXWzeV7p9zSPn+bpi4H4yYHXUjIdIQ/PlB/fnkf1wEyKcf6QL5Hp7pDO7iG3mZr7bl
	3JAbWmA==
X-Received: from pgia18.prod.google.com ([2002:a63:e412:0:b0:c9a:baba:c20])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:b7a7:b0:3c0:9c1b:d0b2
 with SMTP id adf61e73a8af0-3c1108c2c0amr13885393637.61.1784029019043; Tue, 14
 Jul 2026 04:36:59 -0700 (PDT)
Date: Tue, 14 Jul 2026 11:36:53 +0000
In-Reply-To: <20260702224150.3730033-2-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260702224150.3730033-2-sdf@fomichev.me>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260714113658.2023117-1-kuniyu@google.com>
Subject: Re: [PATCH net-next v2 1/6] net: hold instance lock around NETDEV_DOWN/GOING_DOWN
From: Kuniyuki Iwashima <kuniyu@google.com>
To: sdf.kernel@gmail.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"

From: Stanislav Fomichev <sdf.kernel@gmail.com>
Date: Thu,  2 Jul 2026 15:41:45 -0700
> Mirror what call_netdevice_register_net_notifiers does but for the
> teardown. Cover only DOWN and GOING_DOWN. UNREGISTER is still unlocked
> because of the SW devices using dev_xxx methods.
> 
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
>  net/core/dev.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 4b3d5cfdf6e0..9d49493f4fb5 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -1912,9 +1912,11 @@ static void call_netdevice_unregister_notifiers(struct notifier_block *nb,
>  						struct net_device *dev)
>  {
>  	if (dev->flags & IFF_UP) {
> +		netdev_lock_ops(dev);
>  		call_netdevice_notifier(nb, NETDEV_GOING_DOWN,
>  					dev);
>  		call_netdevice_notifier(nb, NETDEV_DOWN, dev);

FYI, this is the report I mentioned yesterday.

Most likely false-positive because open/close, which takes RTNL,
are never called under epoll lock.

https://lore.kernel.org/netdev/6a55fc56.c90005c7.37d349.001c.GAE@google.com/
