Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F221377A80
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 20:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788466827; cv=none; b=MirO52r+bNI6WTlbWqqUZalQtAQXgkdr2waQu78IoJViEU6WZlNw2SDIZd72GIZC8kTP+qYneNTmNQFnGOdfzYpeUU0VsyWnHczdv8RL6syFruAgG/8qy9kpikE9uV3dUIfCaex35rro/kf58tooGB6aEp9O+HTSLn6aRb+4p9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788466827; c=relaxed/simple;
	bh=Q4RT8whgllLufR8p3mhaAWLxqsfOaXYbBQxY7uxcnZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QHlzFee1Sr1qn6YLdvsyg+Pyr5jwnOvReugISjyLHyKFNFb5spaI4+zDTTFifJjFXCfFYYPxJ3xrWSwnV0L6rz0pgbBkbnbYSluaEP30Ea+e3ze5m3kylY5baxq7hnCngHKXDL9mCaHxHKnyx6kD7BsbggZigrBZIwGvYaoUl4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=LtZIW2yr; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="LtZIW2yr"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cc439bfb2d8so294509a12.2
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 13:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1788466812; x=1789071612; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Go8IdAYfdfi+4NcD+57NpaUXzelmMF8zr7mgBK3iMro=;
        b=LtZIW2yrqamwbbaY/Cl3XkxqfwiEGl+A07x0TXaaRyVF3USAAIhGnvALntvYvLdim5
         vD8YX/a1uzUKaQKBY6n+6Y9AMa5bGSjCl9/aN1bgtMwVoQlN5DUkDVHyXGrylcBdZOjd
         LwYefrGi0QmwNCisA0JpSnNRIMJUOgSvOitQ9nrWoLMqsjfOxva1EWw5hSvkoIJvVR8X
         IEebfStZl29NFm8NqZwdJbuO6xSsr6QKdZH+Crf3JV7loNxvahhgL4gBlqLoktGorwPb
         DoPVRbttW0RntpKGgDerE+wMx9BtVTuaWYIJWRzC6iV7Rktvk5+pQPK4zV3x6y7in1FV
         MGaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788466812; x=1789071612;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Go8IdAYfdfi+4NcD+57NpaUXzelmMF8zr7mgBK3iMro=;
        b=hB3P97vrpEaduMmxnmGRqHA1qUaIQpw+JYxRE7A2Q2dNjOf0oaf9oPFs7n0utJoUS1
         Lvvqr/bx4lDRbWfZMsHv+TmxIVIZRl/zzpf+Juc55O3nMeCNqLUbI+9Idd6rbUlPRgaa
         L4iMmifJL/Z9pDBG8phYjfr7ZFEjEcKzeGNjn7sz9WKHk2H1mm507DUwxa6KAAPRxCXG
         1KyjgT/1LONPfHDkT3fChctCattyN372l5RSjRipcjABDGR0LVnzfzDVTQ+6mEvs4zMg
         AhPDsZzhlLuvrsSF/Bl22AImI+6JItkRUYv8uK0yqO3CAMlRWIaXuoYcCau4zAX5D4yu
         60tw==
X-Forwarded-Encrypted: i=1; AKwUvByH1sV2X4G0Gd9PRWuF+wXVFFohBTvr+qFvuQ/+BLH/QrywYYe1u+QwWrN0A5TespuO5ISoGJ0=@vger.kernel.org
X-Gm-Message-State: AFuF++nASrHJN9TOywKUfvPG1kZUCHCQzc+6BBLxWw/kO6P3N61ITOi9
	AnLb4mF0VyfpkzHGoUdA1suL2o8KbGDriw3KE7q1MUU9RfSahG+zxKM2LFSJFFexMgI=
X-Gm-Gg: AYBFou2Cfjw5oNj/F/fK1LDo5I5dzuv0rQ9WdbouGmN//TbIC7H0WINTw1snJh6UcSO
	kHZFkHESmCflEJqwBQvVMs6XHwvzRRwtAgPmUQao3nVPkD1EGvd6D38plzUn9tgD3DbCsHGz3kN
	ssDNu4fo11xrHu8GY9/WCqRQbzEyH6KyyEIDczAv/pHB3HDnYjHtsoojE7ylw8aot0mYEQDjMZS
	Q58w54zecvFH7c3ES9Tuoc6peP7HADRXyWzDGJnkfaKV7a0gY0qaFkCo5ZFReGz2vMHvwofwhWY
	z5MN/T8CeoV/q1oz+FzvjZwID1Rv+8v7gNx3QkpGiTWdytK3ZDXRm+9GuYZ/1enVlciuJpkbTbs
	+cU3FlQ1L3XDHGxD4w6xgzH7g7sSRKVXYfM5uGLLShgwq1M/lkw08eRAZM3s7C5GcbVgSBh3Kfd
	HRVbUKiW+1NBlkpluphTdBQltmG6nq+MuE8FrNxm+VcQ==
X-Received: by 2002:a17:90b:3852:b0:38e:9ef9:eb97 with SMTP id 98e67ed59e1d1-39b26272d69mr1524591a91.16.1788466811646;
        Thu, 03 Sep 2026 13:20:11 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:44::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08cacba5sm7297568a91.12.2026.09.03.13.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 13:20:11 -0700 (PDT)
Date: Thu, 3 Sep 2026 13:20:10 -0700
From: Joe Damato <joe@dama.to>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	florian.fainelli@broadcom.com, jonas.gorski@gmail.com,
	andrew@lunn.ch, olteanv@gmail.com, vivien.didelot@gmail.com,
	f.fainelli@gmail.com
Subject: Re: [PATCH net 4/5] net: dsa: mv88e6xxx: bound the policy rule dump
 by the caller's buffer size
Message-ID: <apnWeu4h4j3Z/l+H@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org,
	florian.fainelli@broadcom.com, jonas.gorski@gmail.com,
	andrew@lunn.ch, olteanv@gmail.com, vivien.didelot@gmail.com,
	f.fainelli@gmail.com
References: <20260903032611.3000029-1-kuba@kernel.org>
 <20260903032611.3000029-5-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903032611.3000029-5-kuba@kernel.org>

On Wed, Sep 02, 2026 at 08:26:10PM -0700, Jakub Kicinski wrote:
> mv88e6xxx_get_rxnfc() uses rxnfc->rule_cnt as the write index while
> dumping the policy IDR, clobbering the input value before it has been
> looked at.  That input is the number of entries the caller had room for.
> ETHTOOL_GRXCLSRLALL requires no CAP_NET_ADMIN and the ioctl sizes the
> buffer from the rule_cnt userspace passes in, so once an admin has
> installed policy rules any user can ask for fewer slots than there are
> rules and run off the end of the allocation.  A rule_cnt of 0 leaves the
> buffer pointer NULL and the walk dereferences it.
> 
> Count into a local so the caller's limit survives the walk, and stop with
> -EMSGSIZE once it is reached.
> 
> Fixes: da7dc8755304 ("net: dsa: mv88e6xxx: add RXNFC support")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: andrew@lunn.ch
> CC: olteanv@gmail.com
> CC: vivien.didelot@gmail.com
> CC: f.fainelli@gmail.com
> ---
>  drivers/net/dsa/mv88e6xxx/chip.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)

Reviewed-by: Joe Damato <joe@dama.to>
