Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793325942;
	b=PpnBXP5q8NyHYwn++Ck/yHA+TDcV9iOA4oxPRgGYqYRqiwiLze2ynUVU5BURsUM/J/cW
	 9Tdx/00tydzCpSPnnbrLlWsecV+J3utkyf8irNB/IYMMoe3a/ADUalovO5S4NxosSuoBJ
	 4VyL/qtVsbLMEBc7AMwCXvOGFGJV6sJqCaRKLrgrTrMR7BmuNyH9HK7d0SM7oclvDRtZz
	 B1IIwG8umWYtZo+/82BHLxHWnsqAzeVy9RCdWjdvNvcO4TohtyVJRQ7w8nhq3eZ8qKzRv
	 h+1igkOwjOo5pkSyDwPInKk9OfpM2Pp96t0QJzcIrwWPjVXVP96+8jBsKstkWxFo7IQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793325942;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=5q6VLlVtRVGzt5myNjmdcIJTUsnVE4fKK2cK3gpYnOc=;
	b=e6eV+IFjuId+FsvKXutU0P84+PCZjtyTy7uynF+4ziREYml70ZEhucRrmjorLNSTq7Av
	 WfRcpxiqTFKzOZ3vfY0dNm6U2YeSMDHftFv3MrFf7pDyQdumkvVPkfWOi1kBR1kPdKHIL
	 qat2E81WL5s9uvvre9JDPFZ+HmRy4/gFMGFrX7EVsJBB3CqAopKzHzcGIRfFOV7hlXQfA
	 2CzvJOlprg3Vi9Gyb8zPPWbKQP9M03Y+7NY0buEicl2crtj3IwG0jhWO/NWXUYoIQ0nRR
	 MfG1gjlvxmxjapkF1GKM0H+NzGgs1fnCbqxODZ/93Nhu/YPC62eyfqUGtOfJTIEsl1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=PfR+rHNA;
	arc=none smtp.remote-ip=91.218.175.148
Received: from mta0.migadu.com (out-148.mta0.migadu.com [91.218.175.148])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2E3606A31A
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 02:05:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E2E3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=PfR+rHNA
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=9cmqbsbAYRunmp/btWpjdtkpFl2yYOXgBmGWd0cWFJQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793325939; v=1; x=1793930739;
 b=PfR+rHNAuyMeSUsq8dt1qw+B7dfBtmt1xW7FyBiIgPtM9FobTgY+6F4rSz2u82NdCzpSDYN0
 tXdxT/MUDaEizK+nZ/90aQqcFP2uIW5D1NVcveUqsmmgMsJcX9eFstVx28Pjzx41kAZXKxL0nKR
 8V7INOUFfUFudUcYKCXTUT9I=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 62c2abc1fac3e23c;
	Fri, 30 Oct 2026 02:05:22 +0000
X-Mizu-Trace-ID: 62c2abc1fac3e23c
X-Migadu-Flow: FLOW_OUT
Date: Fri, 30 Oct 2026 10:05:11 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: =?iso-8859-1?Q?=D6mer?= Mete Kaya <omermetekaya0@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Joas Antonio dos Santos <joasantonio108@gmail.com>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	syzbot+88435e204734072bf39a@syzkaller.appspotmail.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] netdevsim: reject port addition and clean up
 ports after a failed reload
Message-ID: <auP7VyY3MGqOphL-@bogon>
References: <20261030001444.289973-1-omermetekaya0@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261030001444.289973-1-omermetekaya0@gmail.com>

Hi, 
On Fri, Oct 30, 2026 at 03:13:20AM +0300, Ömer Mete Kaya wrote:
> nsim_drv_port_add() does not check devlink_is_reload_failed(), so ports
> can be added via new_port after a failed reload.  nsim_dev_reload_destroy()
> returns early in that state, leaving them behind.  nsim_drv_remove() then
> hits WARN_ON in bpf_offload_dev_destroy() and a subsequent use-after-free.
> 
> Block port creation with -EIO when reload has failed, and delete any
> leftover ports on the early-return path as a safety net.
> 
> Fixes: 75ba029f3c07 ("netdevsim: implement proper devlink reload")
> Reported-by: syzbot+88435e204734072bf39a@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=88435e204734072bf39a
> Signed-off-by: Ömer Mete Kaya <omermetekaya0@gmail.com>

Looks Joas has a same issue fix with yours a few hour earlier.

https://lore.kernel.org/netdev/179324296598.34505.11070163314749859668@gmail.com/

> ---
> Tested with syzbot C reproducer.
> v2: drop Cc:stable and target net-next.
> 
>  drivers/net/netdevsim/dev.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/netdevsim/dev.c b/drivers/net/netdevsim/dev.c
> index feb88ccbbced..61f0824ce4d3 100644
> --- a/drivers/net/netdevsim/dev.c
> +++ b/drivers/net/netdevsim/dev.c
> @@ -1697,8 +1697,10 @@ static void nsim_dev_reload_destroy(struct nsim_dev *nsim_dev)
>  {
>  	struct devlink *devlink = priv_to_devlink(nsim_dev);
> 
> -	if (devlink_is_reload_failed(devlink))
> +	if (devlink_is_reload_failed(devlink)) {
> +		nsim_dev_port_del_all(nsim_dev);
>  		return;
> +	}
>  	debugfs_remove(nsim_dev->take_snapshot);
> 
>  	if (nsim_dev_get_vfs(nsim_dev)) {
> @@ -1758,7 +1760,9 @@ int nsim_drv_port_add(struct nsim_bus_dev *nsim_bus_dev, enum nsim_dev_port_type
>  	int err;
> 
>  	devl_lock(priv_to_devlink(nsim_dev));
> -	if (__nsim_dev_port_lookup(nsim_dev, type, port_index))
> +	if (devlink_is_reload_failed(priv_to_devlink(nsim_dev)))
> +		err = -EIO;
> +	else if (__nsim_dev_port_lookup(nsim_dev, type, port_index))
>  		err = -EEXIST;
>  	else
>  		err = __nsim_dev_port_add(nsim_dev, type, port_index, perm_addr);


But yours have an extra guard in nsim_drv_port_add...

Leave this to Jakub decide...

Thanks
Hangbin
