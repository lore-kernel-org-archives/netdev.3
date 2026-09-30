Received: from mail-pj2-f38.google.com (mail-pj2-f38.google.com [74.125.227.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB39466B03
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 19:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790798301; cv=none; b=PNZJwV2MMR7EGYxE8O3318Uqa6/Z/8lkQs4SG2a4sx9zA5+urgZVSRoMjQ9FyuXRhik7GZFTRyNRNV4aA1Cj8NXnQsTLJ908Nc1X2bpkcL9PPC9B/71RN8nkATdJjiwB7BZWdJtwNsufmdcuiuypqgJdFcI6btH0McaKmpsAMfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790798301; c=relaxed/simple;
	bh=TY9HTzhIi2O6++k11RsmYUXoF9kBqGtjhJf6CkG3wOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bm0IxesGdhXbpMODbqliLQdMFF4Qxs+Ea1qNSYnfy5GKFU++he8QKyBzQC82v0NQl7yRXZ57qfDbe0RJIuU2bWdg8qv8S8Wi1fVgfrYgBG1QibGx0fWj0AwB+wZZU/JuL1H9j9k/AZP5OPFXcsf/I3IN84uZfigpFv8Sg+wn/5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=kQ+Vazu3; arc=none smtp.client-ip=74.125.227.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="kQ+Vazu3"
Received: by mail-pj2-f38.google.com with SMTP id d9443c01a7336-2e2dd05994cso5700855ad.2
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 12:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1790798299; x=1791403099; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wwT5G3hOZ+437mDeNovsYJIgF/coP9gi596iqTX5ReA=;
        b=kQ+Vazu3P7ZEgQtiDY3Odvn0EqUCNM4Buzby4H9j1KC8OuqVoKin7+Xih0qPyNZ7HP
         A60KZcNeDBJRlDVlZNfVkJoB/C1F8aCCT+7p1WRvlNS70VOo8ama8IHdN9OoSEuZnVCK
         loSex8RqwAUFHYPjalmqoaTj5ypHT8ca+RXdoeZjLj7TXADOaDgSPbzaaayM+1FZ7IDE
         MTRxANXH4YcPfMjwMzixcotf2kFmhVk4wdlN7Jix5ojnOTzPMjqMDrHoaD06F/5wNHwN
         hVtsat8Ss3ktPXjiaafaGxLwrVLv6CrcYuMUYQezPTpznROatfE76WTR/z/O2LWe6aXh
         vlLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790798299; x=1791403099;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wwT5G3hOZ+437mDeNovsYJIgF/coP9gi596iqTX5ReA=;
        b=N2SdbigU4kBk83ZHWIkjs2qlNVKThM5lbHdH7COrAbaPESnBsl8aIb1mqj4ymEKGB1
         VdlDdU1x3z0HNe2C+LBlYWCKSGOvQYgCIUEzz0jXL4kAV+U9sAQ5anJjnKF6bHgDNnnr
         3km8WW7mMX1K9uMKcMjHZoKjyFiB/UqRfYVHUC2FSadFMhLt8KA4vKyNspA4l8S32ND3
         Kjqk1NiKXYRt5mkT/ZqF4jXSH+RgAFJff6V534LYRvHeeemXhwO4/Tx9OnoN7Zfb2mXP
         qwthdSnvAp1VYS9vQj1//wvYiuSLWmgPW75ZsRbUdzCum1qBKKft2qJEVKfRoTXlc4zN
         M10g==
X-Gm-Message-State: AFq9FYKV/NO/34zGk0WpXfWKILv5IBJaAnRtXEt+DUNHop/0Veylvr8W
	mQmHsy6EA6m8CaAcmss7d3dhJKTyjqFBzmxFJjuZsEkzS7VtFPXKeTRl/4pyMjj1ovM=
X-Gm-Gg: AYBFou2OFZIPMF4YFplKcuc85ZY8GikDttv5trDa6qZNzN4+Ta+2ESAckbJpopxTdIj
	1b/MkMffZ9DM20k+NCclqyawuqFlgvM4hLO7TMNHE7ZcAM6PkDxV6gHfRugP5ph+wyoS/DjY2lj
	gjfNzOpevUteNSZ2V0qM+p6NyniHB56KPfpdpvHAkrKVLORBqHJGZJOi4PhWQeTcjyfcFn+ruK4
	iNrq1X6QETgTa7zOqfBIN6NVSkq4jMt/vzJZ9d3wb9vXgSXSCTjJ3iM0bHP98uo37RjmENVyFoH
	F/PZy9EZ5cV7AzeQ9nx4yAZbtbLjzp4owhapoTm13Uow8cgvnnzo30fVhiTFK/Dp4NGpTylYEh6
	l3/mihP01mukbcETmb18xNgoP9AavjYifKltqhskNJkHRAY/HirRPUMQu4hm/BkeS0kFZZCKsWf
	pQTK1BxFAEhho+aBd9I35PtBD9AXodLWqpBDX1gQTBZ2SNXimUECv4azTnx/45mNC/kXjDE7nxn
	gatCKc2Rcl21RkSKKxTbAA=
X-Received: by 2002:a17:903:2308:b0:2df:a023:6883 with SMTP id d9443c01a7336-2e2e4a1e373mr18255265ad.17.1790798298669;
        Wed, 30 Sep 2026 12:58:18 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:70::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e30099a3f0sm1868405ad.23.2026.09.30.12.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 12:58:18 -0700 (PDT)
Date: Wed, 30 Sep 2026 12:58:17 -0700
From: Joe Damato <joe@dama.to>
To: Zhang Yunfei <zhangyunfei1@kylinos.cn>
Cc: netdev@vger.kernel.org, jiawenwu@trustnetic.com,
	mengyuanlou@net-swift.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, aleksandr.loktionov@intel.com,
	u.kleine-koenig@baylibre.com, weirongguang@kylinos.cn,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	leitao@debian.org
Subject: Re: [PATCH net v3 2/2] net: ngbe: clear DRV_LOAD bit when
 ngbe_open() fails
Message-ID: <ar1p2bK3Aab1RT5U@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Zhang Yunfei <zhangyunfei1@kylinos.cn>, netdev@vger.kernel.org,
	jiawenwu@trustnetic.com, mengyuanlou@net-swift.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, aleksandr.loktionov@intel.com,
	u.kleine-koenig@baylibre.com, weirongguang@kylinos.cn,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	leitao@debian.org
References: <20260930094748.1198085-1-zhangyunfei1@kylinos.cn>
 <20260930094748.1198085-3-zhangyunfei1@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930094748.1198085-3-zhangyunfei1@kylinos.cn>

On Wed, Sep 30, 2026 at 05:47:48PM +0800, Zhang Yunfei wrote:
> On NCSI-managed systems, a failed ifup - for example when IRQ or
> ring allocation fails under memory pressure - leaves the port
> without either host or firmware driving it: the firmware already
> handed the port over on open, so out-of-band management of the NIC
> through that port stops until the next successful ifup.
> 
> ngbe_open() sets the WX_CFG_PORT_CTL_DRV_LOAD bit to tell the
> management firmware the host has taken over the port, but every
> error path returns without clearing it, leaving rings, IRQs and the
> PHY torn down while the firmware still believes the host owns the
> port.
> 
> Roll the bit back on all open error paths, matching ngbe_close()
> and ngbe_dev_shutdown(), so a failed ifup leaves the same
> firmware-visible state as if the interface had never been opened.
> 
> Found by manual code inspection of the open error paths. The
> deterministic reproduction uses a loadable test module injecting a
> wx_setup_resources() failure: in a QEMU VM the unfixed driver
> leaves DRV_LOAD set after a failed open, and with the fix the bit
> is cleared. No physical ngbe device is involved.
> 
> Fixes: a1cf597b99a7 ("net: ngbe: Add ngbe mdio bus driver.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhang Yunfei <zhangyunfei1@kylinos.cn>
> ---
> Changes in v3:
> - correct the Fixes tag to a1cf597b99a7, the commit that introduced
>   the bug (the first ngbe_open() failure path after the DRV_LOAD bit
>   is set; v2 pointed at e7956139a6cf, which added more failing returns
>   but not the first one); no code change.
> 
>  drivers/net/ethernet/wangxun/ngbe/ngbe_main.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

idk much about these devices but the reasoning and code looks right to me
after reading it so:

Reviewed-by: Joe Damato <joe@dama.to>
