Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6AC318BB8
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 13:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786369359; cv=none; b=cU0T4FNEIPWQi7dhHBXchdNxH16tAyOD8m28C2ic8RkZGU2szuVqG8cEBjm31KbTmivS3P+AejL6fMD0AyCV61CWTlQ17wgdYsu2GlhJLGpJw6DV9zA8GCbwr5/PTtWpnZxAKDOx/SihV7bgTft4x/2TyDXYb13e7sLcPHQo3E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786369359; c=relaxed/simple;
	bh=w4RTm1SdmnPbUq7p6a2Lo87lUDniWqHAOY5MD7rV81E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QiIuj68/H/S4+wiFWcrKG02QByw7dp4rrkfP88M7OUV29LlBbnUFdV2ty5p3yYhNKo+HwLm2D+/ARHC5Al74TUWrgG0SewaV5OokXHAZij6MxBuAvIMw5K4Qkckjjb45CSY18jayGvB0RDg/ssl09X4PDbYnLCjMCsBBPivTcJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=cn2kZ6bE; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="cn2kZ6bE"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-529a1ee0e62so12808711cf.2
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 06:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1786369357; x=1786974157; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BCZXwY4oNGw2YYfFqKfcu4fpZvmors3q1AOve/GpS3E=;
        b=cn2kZ6bE/fnC6Tb10sEle1ggcS1nGM8G/wtZSWHg14KuZzJzo2hZttI6FxpGehCzrO
         1ZRrXur/s2Dm6auTot7E+3ZfSb07C1ku592gpr0PpsHtz0FNxa2Cv44uTELPTl5EbuGt
         kFjxHffECFJw9QJnGIXkw5TMT7FpX25z5fe0aMzigx0+uqKFWwYXZPDWpVQeDoVuGUQB
         CTxZzmmrf+beLqfEHXI7lwcqR+wjqcupaGyh87saDognX6+MQYvOMixRjD4vet1SkHdL
         QkOjfEtXF2ZvEQUD5HqoCPRkVqbIMsiySjse/QJCHEAZSAhrtjvsUdJOSL/a9OsCsgOT
         PFEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786369357; x=1786974157;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BCZXwY4oNGw2YYfFqKfcu4fpZvmors3q1AOve/GpS3E=;
        b=dzjT1yVCgNspCu6GKTGL1kRstXr7tJFtmg3wn5VCppmM70BNmX76mYVfSUqRfgXXdt
         w2fFYX5BxBJrKu4hef7Q+jincHeWbnKieXuuPLg24zXJ/6U0YMeOcXTGThUpjgBQxozx
         I3Ggs7YXdE2+W33tcwep3vCHo+c00Fzft9t3N+d51grxbUawcmPJtdKhdWMuN8cCLPRJ
         O/LPaJYIttHXE8m06ljS3jLD1b4ooaGqMq26Aa2yxz2HOT2T7gqVGYwfEyy9Ow2Vx+Xq
         W/r8oz10kdco7YkB5xtVNuZP209xvXeKraENv6tvtTFdU3FFH41JEZkYhcS456Y0XcvG
         6eLA==
X-Forwarded-Encrypted: i=1; AHgh+RpeAgQYZympfDQmFA7h/TpuEoJvEvMghYkEK0J/osCH3x/3NBZFRkH6pEjTtYxx+w7PLi09yTg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxcig6aN+pq6x2beWBT8G0h10AyyDgE2ANfljDRHGrtg2kxw2Wv
	jX3UqcJgpflaVHFZWIIXu3WKM8w24i1x7hLdF59uCjsFpatBineA5bfzX5+63hzBENs=
X-Gm-Gg: AR+sD1204blvp762n/PO1GflZY5+emIt140P1LRfd04mBoHWtAciRt9e6DTuYmN/B96
	awMhGElgMUEGOkTGRgYZDhLq1pfU6tO3kfYQjOy191iDQCW6akTMOlEI7hZ/nbqZAsUbl3H7QQf
	FWFSWAcmWsX7BKO0HS0ntTDItRrYcsul6IWF/NnNp11+6ElifUSQLYutMCJ72V1nKsRdt58TAaI
	GfiKUj7BRpY7IcpH6cVa9Hf6ZVLwCZ72jruXht5qHdTlhU9f+CE/tTNQOtvktfid0CMbQUhv1hc
	P8lhAkl9E0FEcY7p16FBT/HK5C+kC1e+5ZTT2vJ5+mXdEvNNMaMpWZ4OnMa3DTJe4513FN/b063
	G/umEriwnXzdXnnq22tko/wLoWy6Rj/BFx2MPGboDmYwsjAPS08/qQYBrfDunlEYzNrvriEWCwT
	cxMyjkp9ozEQMD0LgXRzCemCaw/Tk9JdQFutHcBA==
X-Received: by 2002:ac8:7f4d:0:b0:51c:1c2c:a8bc with SMTP id d75a77b69052e-52d4bca21d5mr17658741cf.37.1786369356751;
        Mon, 10 Aug 2026 06:42:36 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-908a9301d83sm72812166d6.26.2026.08.10.06.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 06:42:36 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wtQGx-000000022xs-25Hm;
	Mon, 10 Aug 2026 10:42:35 -0300
Date: Mon, 10 Aug 2026 10:42:35 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Krystian Kaniewski <krystianmkaniewski@gmail.com>
Cc: Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com
Subject: Re: [PATCH net v3] RDMA/core: Reject unregistering netdevs in
 ib_get_eth_speed
Message-ID: <20260810134235.GO200537@ziepe.ca>
References: <20260810133124.44513-1-krystianmkaniewski@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810133124.44513-1-krystianmkaniewski@gmail.com>

On Mon, Aug 10, 2026 at 03:31:20PM +0200, Krystian Kaniewski wrote:

> @@ -2049,7 +2050,15 @@ int ib_get_eth_speed(struct ib_device *dev, u32 port_num, u16 *speed, u8 *width)
>  		return -ENODEV;
>  
>  	rtnl_lock();
> +	if (READ_ONCE(netdev->reg_state) != NETREG_REGISTERED) {
> +		dev_put(netdev);
> +		rtnl_unlock();
> +		return -ENODEV;
> +	}
> +
>  	rc = __ethtool_get_link_ksettings(netdev, &lksettings);
> +	if (rc)
> +		strscpy(name, netdev->name, sizeof(name));
>  	rtnl_unlock();
>  
>  	dev_put(netdev);
> @@ -2060,7 +2069,7 @@ int ib_get_eth_speed(struct ib_device *dev, u32 port_num, u16 *speed, u8 *width)
>  		netdev_speed = SPEED_1000;
>  		if (rc)
>  			pr_warn("%s speed is unknown, defaulting to %u\n",
> -				netdev->name, netdev_speed);
> +				name, netdev_speed);
>  	}

I would probably just put this block inside the rtnl lock and not copy
the netdev->name

Jason
