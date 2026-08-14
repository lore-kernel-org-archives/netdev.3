Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED8918FDDE
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 01:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786670626; cv=none; b=d+vBcu80MwaY2cvzdpDbN43o16D508EhiZAoTVnBo/ADDBUaINyNZ1Z3rXVv8ng1Lk6N4FqnrY/YTU1wxkaWub4PbSyJMkhXmy56ts4csMWKrW9Hrwm3CNvB/awpOgcntgDP8T0zIhgGuoOU5fGPO+UA7N0Om6XMF0YK75btcFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786670626; c=relaxed/simple;
	bh=k1PdrtA/9PqMB4Q/KFzTfjWb3Z2R+facX6ikbQwV5ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eA2hnbeHM8JZsuf6z1ZtE2Azs5cIZaCxv3Il1347ePAEGoFoJyfLcliL3P0DuehgGnZBjYR8PGVlocYdqzP89BZb9E104Oaw9VX99YKFoK/aa03yxgC5QE+zDqGSeN7EYbo9eE1B2WR7ygKb3RyMj74QyVlYZHbtDGNo9z6b4i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M8aam0fa; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M8aam0fa"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-84faf87d19dso397441b3a.3
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 18:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786670624; x=1787275424; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ec9denQCMG1siPi/j1GAugEq6qMWjv0MMecbi60zlMI=;
        b=M8aam0faoKFfAN3E2M0QjZaPvQhMkWoqM1z9QvW+oWj8Rfl1lVxlzWcb3Wd7FHIewb
         0RqlBQFdPTbyz9+wCOm2BJZLzAwsMaan8ajP/tH/Pwyz7oTYtsIUwIcSfY0m5ZXTUcaq
         lZfCwgQkpY7vUS+xlte/q9nfrnobu2Vgd1zhzgCQyhq8UwK4gD778IaVV/T40MBDabzD
         9dy6H/PvsA+YPkDdrkBuAoQSE+NDNDFIjkAbuU4kVY97+Kj35Y05dJUsAnih1cYDwhWY
         3qjbyDk92C21qcwyq6q/VEHurj5cI6xEcIntdqhxv5/S30+jbHSFu8HjfUP0UEvf+uTH
         X8NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786670624; x=1787275424;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ec9denQCMG1siPi/j1GAugEq6qMWjv0MMecbi60zlMI=;
        b=e4YzoevEM6qY+IrOOJWbMGfpCm0I2vz/NaQVwI8J33cJqHuHz2PstbweeSKFsynBlU
         OLxsEg6/N9Tvd81+gv21U8dsSPiY/gPL7sR7z5CAxwGOHQNiyOWCnjthUCWzqOoRrNFW
         GyeEGh6u1Rk1Vw3COJ8IYYdBs+F2c2GP2fCvfxvLlPGycBRMaaagqIg/SSX/MCfHzCOL
         77sO/Z+0OGq2YCtL4+JVQxD1AwELg61RwNs/4JIWI7s2fvebzgK7yXDZg4VJJ64SFLnn
         i8nJcy+UnOcivXdy+//NOJnUzkU/K6npPmctyqBS4Wuqg+1nFdDfbpnlvxgrWajJqwPq
         KMtw==
X-Gm-Message-State: AOJu0YzQut3KPkOIGAtke+Daxtbgl61TKC832KbhcVhN4IV1A7ARqq1T
	sxd4c5tL0HPKpJOiEUOik39sdVM8Z+31TawsadwWDDPnLXBr3oz2DlS2
X-Gm-Gg: AR+sD13cU3T6MC6+++iWTOs0wtm+IlaTYMEEXm8DnBvWzpOnwwr8vU4w7pEgjK+HqkY
	YuI8MPiv53bWn6pwcSuiffR1uSi3rSI9EvFiOQ6W3KXzkHiKtgZlT2a2Ex8QpAnzZov5l72XbTb
	fVTfTLowOAFsYXP/TV+6466IXaYpieV+ChXn0qYdhp6wE4bnglCj8ZM919CEVi9IvscauTBsxzE
	oWgjJGPu4q14w3FZ24vQivar2NEW3JMk7qpYXNvtc1pYcVksxbM7Bz9BRK3i/F+jXlxqmXAEwQH
	Pfe63L2DXixHCZC/mzBS1tzkce2LaPSSv18TjU5dQyDxxyvphUZzvQv2qsKDcWSpGgW+scdNnk0
	ExVeS3grySLtZaKAL4G4jRsKOAIgA6wYlYZR/jJf+OmbDUzcoeq6KF0KI5n5LaV53MMHEzfqXL7
	naCncJYqvQ/Pecxaa5ajfVnyPHANYcAP+r1GLuKuun4Mmj7bRLdzsNzbA=
X-Received: by 2002:a05:6a21:688:b0:3c3:92ba:c61f with SMTP id adf61e73a8af0-3cc71c1b043mr2280234637.8.1786670623990;
        Thu, 13 Aug 2026 18:23:43 -0700 (PDT)
Received: from fedora ([203.175.12.240])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbef710a897sm1667083a12.18.2026.08.13.18.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 18:23:42 -0700 (PDT)
Date: Fri, 14 Aug 2026 09:23:36 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Ruoyu Wang <ruoyuw560@gmail.com>
Cc: netdev@vger.kernel.org, jv@jvosburgh.net, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] bonding: initialize err for empty target lists
Message-ID: <an5uGF7AR2H-NJgf@fedora>
References: <20260813153126.3952893-1-ruoyuw560@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813153126.3952893-1-ruoyuw560@gmail.com>

On Thu, Aug 13, 2026 at 11:31:26PM +0800, Ruoyu Wang wrote:
> Empty NLA_NESTED attributes are valid, and bonding uses them to clear
> the ARP and NS target lists. When either target attribute is empty,
> nla_for_each_nested() does not execute, so err retains an uninitialized
> value before it is tested. The request can consequently return an
> unpredictable error after clearing the targets.
> 
> Initialize err to zero so an empty target list completes successfully.
> Non-empty lists still propagate errors from __bond_opt_set() unchanged.
> 
> This issue was found by a static analysis checker and confirmed by manual
> source review.
> 
> Fixes: 4fb0ef585eb2 ("bonding: convert arp_ip_target to use the new option API")
> Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
> ---
>  drivers/net/bonding/bond_netlink.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bond_netlink.c
> index 4a11572f663d31..87d92d3cce4a88 100644
> --- a/drivers/net/bonding/bond_netlink.c
> +++ b/drivers/net/bonding/bond_netlink.c
> @@ -220,7 +220,7 @@ static int bond_changelink(struct net_device *bond_dev, struct nlattr *tb[],
>  	struct bonding *bond = netdev_priv(bond_dev);
>  	struct bond_opt_value newval;
>  	int miimon = 0;
> -	int err;
> +	int err = 0;
>  
>  	if (!data)
>  		return 0;
> -- 
> 2.51.0
> 

Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
