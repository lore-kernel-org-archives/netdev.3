Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.32
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793585970;
	b=KiKr0p8epsqTJ45IXYBcs7wDkrsfDpav25jFsYpcMUlrOuMe6hLkuLE4K3pET2r/6JwC
	 yW7CKYo9RsYE2WkINffKg6prVbVKAcfJD0hPqno/OS6ka89pWN5rucYEfTTIy54NrYSlH
	 WGZm/2Lc7cFcblCZTB/heWywSXrjWgkNfknWNuVQcDAVlLhj9fHKtwihT6kmx3fODSAfd
	 Y2LE4u7P6MJ8FKwqa+uRZfWO2EdW6xhoHORULsqi/WWcNnmMl7UokgATnWzfeP/ljRp4H
	 CxWzevgxtHGO21OxvfVBGM+qbpvoB5uXQN5orWga4jO56LNMbSvw6LSc8r1+qyiiZNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793585970;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=oWiK3tLwJTeoCwTM/EhaJi6Xwbpz4rsT5Fj18q9ROlE=;
	b=raLVKR7R55ITLhqkQ49pPrw2via/5WZmqM/CjJZLLZj89GkFk+g+xuVf25EV7ocFDfdd
	 u/+Ef2DwnM7mwIs/6z4XBB3OJ74HLz+fYsVP66PKFfj7L192xkbV8j806d6/g5mtFsNVZ
	 Qj+9tyacxFeWAaB87ob//8qtqVbX2MMyUErU8CzZZfXSXa8OcYxi6QrYhS8WFw/g9vgO/
	 snXQtU+KBTpVV0QsuvovpzrvCb7bbjNtGaj+KFm2SAl8X/AD2DDfO7RU5XKf0+aWYYccV
	 SVQhO9GrCDzlONCXTUvqBltqrV0xmeEYfUER6S1BG4gzvddc+XtrS9+hB1amaZ47Hyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="FSquQ9/f";
	arc=none smtp.remote-ip=91.218.175.32
Received: from mta0.migadu.com (out-32.mta0.migadu.com [91.218.175.32])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AFE606A327
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 02:19:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2AFE606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=FSquQ9/f
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Nr34wUCDOVsABZdnNKfDCH6g7tuffGciV7ziRLOLpgQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793585967; v=1; x=1794190767;
 b=FSquQ9/fJeXA3NtxEtP/zeIl/jyojlmD7MTXI2uQTWcuLp+zNMJzTEGiXP+ThnKcL7bvxmol
 Wp67/5vaXaodDuC3J9g787OH9k3egEhriYFfLIsUHZoU1lZ9B2nAYMYdj9gLCiM91tjNkUFJQlO
 y7g0CjBpjq0sM1O66nzVk5Ps=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 7eb5af2a8e588f47;
	Mon, 02 Nov 2026 02:19:27 +0000
X-Mizu-Trace-ID: 7eb5af2a8e588f47
X-Migadu-Flow: FLOW_OUT
Date: Mon, 2 Nov 2026 10:19:17 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>,
	Jiacheng Xu <stitch@zju.edu.cn>
Cc: kuba@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+b3fca27eb4005f0111f4@syzkaller.appspotmail.com
Subject: Re: [PATCH net] netdevsim: check the driver is bound in
 new_port/del_port
Message-ID: <aufzJYquZBEcCKqP@fedora>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261101135824.24484-1-ngocthang2710.1999@gmail.com>

Hi Nguyen,
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

FYI, Jiacheng already posted a same fix for this issue.

https://lore.kernel.org/netdev/4fe1dcd1.16124.1a01a660a42.Coremail.stitch@zju.edu.cn/

Thanks
Hangbin

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
