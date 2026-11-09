Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794187116;
	b=Wr/DeEi1RCI5Iy6pnNBgJofrydqv1yOuxABikkahnFq53exb0Z3FW/V7SwsJGT/xbVyl
	 GsHR48usGamV3YVFUjd2RxuuCNkQcsJgZWspnqUtSdrDZr8YM9SeTcpprwMTKJmcqyl3p
	 0nZKaZnLZX57qlzvmH51DLU8z2iAEwQGfW+6CGRiKl4+IEDmjVc63LOCQ7mTS2Rb1/IDb
	 WQFHkb1L1R+w5wzR6fgPCdE4fcNgzGoYL8g9/PRZOt2eR6oksfL/bChd3IWPtdGgML5C9
	 0qIwK6OOVq+KT/01UWGGUkOb0hxFLOch7TFiOTt4jQQ1KdGeggNuHcw0vuOPAp4nOrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794187116;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=xPeztD9jupX4eVwTVUeTKAoTPh5ugz27mamWsCNiAPk=;
	b=pLqZF4Y+Orrw+R2GabyaPYcn6ZXKhV/zaqfN9mdmUd5Q5pYeQxDheLYoaq1mTyHI+mGf
	 uPcBhqnSZoKbQ5BKhCIfbYSn19iqa/EiGfiLK2Y9jE8ap2jhuHohRnT/x+kqDIdrZ0cRL
	 obfGMKYqpx4BkGXunJHR9TRQvWPtOtZnCkk2fDRuHrVw61R/WfyrGwO0/dxhvaRswj9hE
	 8eyAL3BsuC8PIA93vrA1ZKhvK3RbzZ9JBw+Sl1vfspj/fcQDQLKkNaj6qj4/2iVMfASll
	 P6v+Hd5uWKZHHEj7TFGDg4i3ysGb7PVStybmsWkwlZJIm6t+wDQalUqbWpOXjyv1xAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=iAWQjwsz;
	arc=none smtp.remote-ip=91.218.175.11
Received: from mta0.migadu.com (out-11.mta0.migadu.com [91.218.175.11])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F0C606A323
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 01:18:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36F0C606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=iAWQjwsz
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=clTj9343lRLL07YsOYeNovaP17CXMps+FdlXaphuSNA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794187101; v=1; x=1794791901;
 b=iAWQjwszyGQARCy6cQPq1IU+KVGUWAM8zhlEowA5+N9o7GfY41XiWB6GQ6JTbc3wXCcoheR2
 ZTOs1D9GyMnoLa92K8CDlA5zp3rG4rolGLYFviBcS0t5rD75FjxmDQiJhsdGCoDBIT7NvopdfMg
 IEsO35ekf7Cd+VT7aeEb8zUI=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 7e66af7b63cab7ae;
	Mon, 09 Nov 2026 01:18:20 +0000
X-Mizu-Trace-ID: 7e66af7b63cab7ae
X-Migadu-Flow: FLOW_OUT
Date: Mon, 9 Nov 2026 09:18:05 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>,
	Jiacheng Xu <stitch@zju.edu.cn>, Shuai Liu <847807867@qq.com>,
	=?iso-8859-1?Q?=D6mer?= Mete Kaya <omermetekaya0@gmail.com>
Cc: kuba@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+b3fca27eb4005f0111f4@syzkaller.appspotmail.com
Subject: Re: [PATCH net] netdevsim: check the driver is bound in
 new_port/del_port
Message-ID: <avEfTZl6gC20PRPc@fedora>
References: <20261101135824.24484-1-ngocthang2710.1999@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261101135824.24484-1-ngocthang2710.1999@gmail.com>

On Sun, Nov 01, 2026 at 08:58:24PM +0700, Nguyen Ngoc Thang wrote:
> new_port and del_port are attributes of the bus device, so they stay
> reachable after the driver is unbound. nsim_drv_remove() clears
> drvdata, yet both handlers pass it straight to priv_to_devlink() and
> devl_lock(), which faults on a small negative pointer:
> 
>   BUG: unable to handle page fault for address: fffffffffffffeb0
>   RIP: 0010:__lock_acquire+0x41/0x2de0 kernel/locking/lockdep.c:5140
>   Call Trace:
>    lock_acquire+0x115/0x350
>    mutex_lock_nested+0x55/0x1d0
>    nsim_drv_port_add+0x5a/0x140 drivers/net/netdevsim/dev.c:1760
>    new_port_store+0x1a5/0x280 drivers/net/netdevsim/bus.c:96
>    kernfs_fop_write_iter+0x3a5/0x540
> 
> The nsim_bus_dev->init check does not help: it is only cleared when
> the whole device is deleted, not on unbind.
> 
> Do what sriov_numvfs already does: take device_lock() so the driver
> cannot be unbound underneath us, and return -ENOENT if drvdata is
> NULL.
> 
> Fixes: 794b2c05ca1c ("netdevsim: extend device attrs to support port addition and deletion")
> Reported-by: syzbot+b3fca27eb4005f0111f4@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=b3fca27eb4005f0111f4
> Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
> ---
> Reproduced in QEMU (x86_64, KASAN + lockdep) with the syzbot C repro:
> the unpatched kernel oopses in nsim_drv_port_add() right after unbind.
> With the patch, the write to new_port returns -ENOENT, a 40s stress of
> bind/unbind + new_device/del_device racing with new_port/del_port/
> sriov_numvfs runs clean (no splat, no lockdep report, no hung task),
> and new_port/del_port still work as before on a bound device.
>  drivers/net/netdevsim/bus.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/netdevsim/bus.c b/drivers/net/netdevsim/bus.c
> index 5c55c308487b..d843b3c985cf 100644
> --- a/drivers/net/netdevsim/bus.c
> +++ b/drivers/net/netdevsim/bus.c
> @@ -93,8 +93,13 @@ new_port_store(struct device *dev, struct device_attribute *attr,
>  		return -EINVAL;
>  	}
>  
> -	ret = nsim_drv_port_add(nsim_bus_dev, NSIM_DEV_PORT_TYPE_PF, port_index,
> -				addr_set ? eth_addr : NULL);
> +	device_lock(dev);
> +	ret = -ENOENT;
> +	if (dev_get_drvdata(dev))
> +		ret = nsim_drv_port_add(nsim_bus_dev, NSIM_DEV_PORT_TYPE_PF,
> +					port_index, addr_set ? eth_addr : NULL);
> +	device_unlock(dev);
> +
>  	return ret ? ret : count;
>  }
>  
> @@ -115,7 +120,13 @@ del_port_store(struct device *dev, struct device_attribute *attr,
>  	if (ret)
>  		return ret;
>  
> -	ret = nsim_drv_port_del(nsim_bus_dev, NSIM_DEV_PORT_TYPE_PF, port_index);
> +	device_lock(dev);
> +	ret = -ENOENT;
> +	if (dev_get_drvdata(dev))
> +		ret = nsim_drv_port_del(nsim_bus_dev, NSIM_DEV_PORT_TYPE_PF,
> +					port_index);
> +	device_unlock(dev);
> +
>  	return ret ? ret : count;
>  }
>  
> -- 
> 2.43.0
> 

There are three identical fixes (author cc'ed) following Jiacheng’s patch [1].
I’m not sure whether there were others before that. I notified Jiacheng and
Nguyen on Nov 2, but Jiacheng hasn’t reposted his patch. To prevent further
duplicate fixes from landing on netdev, I’d prefer to ack Nguyen’s patch,
since it is the earliest one that includes test information.

[1] https://lore.kernel.org/netdev/4fe1dcd1.16124.1a01a660a42.Coremail.stitch@zju.edu.cn/

Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
