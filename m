Received: from mta1.migadu.com (out-164.mta1.migadu.com [95.215.58.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25451FF5E3
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 06:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787207233; cv=none; b=V8D4JCnZPHg7QBGrK1clidebJphchbldaAu40VJ89GkA6EvRQ+Aa4eDm+IA4ZHkG1Uejw6X42hVFJP35H6kQbGlc28Q/zCkivI0jK9HBa5UEqrgXQkkkegWA9rmJfQPlxvwIcGLWrGZqinv+DpblNbTLY4pzcfjeVsKd8wmjef4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787207233; c=relaxed/simple;
	bh=fqELq6m1L/AIwXnUHQsyI2ZsPK5ZxGEKIhsXFLC5Wrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gOqBlVZuFkZFvseOxMQwGepCzssHMQj5dqU7yTHivjm/TpdF33pKko7ZM/e8sze/d4w4IR5QyKdB6A26LSbm9vZ/VMM/DGDf2CVbRyV1qTVe6jFJgn2ANxClPSkr/QOygWGRGlh4esdwCePe2DPnybW4Y4MROepDRS5h4VVQ7n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cDAeb2rb; arc=none smtp.client-ip=95.215.58.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cDAeb2rb"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=fqELq6m1L/AIwXnUHQsyI2ZsPK5ZxGEKIhsXFLC5Wrk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787207226; v=1; x=1787812026;
 b=cDAeb2rbhsfIfZYLOVmowBVmLghe8OGpELj3o2iPBcB1L5BteOgHoNSPc8bHvSC8AxRxiueG
 +etgSh+O4h15FI5gHJmOFroRDbLjkum+sI0sc48/XmRTzxe5/xVkyuz8S6dHEspFQnlF6QkNDv/
 1cw2KPmwJzePieTS3CL+YfAA=
X-Envelope-To: netdev@vger.kernel.org
Received: from fedora (216.236.36.152)
	by smtp.migadu.com with ESMTPS id 18534bc25965cc1e;
	Thu, 20 Aug 2026 06:26:56 +0000
X-Mizu-Trace-ID: 18534bc25965cc1e
X-Migadu-Flow: FLOW_OUT
Date: Thu, 20 Aug 2026 14:26:48 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Jiacheng Xu <stitch@zju.edu.cn>
Cc: kuba@kernel.org, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com
Subject: Re: [PATCH net v2] netdevsim: avoid NULL dereference after failed
 probe
Message-ID: <aoaeKBZV5hAqRuRn@fedora>
References: <4fe1dcd1.16124.1a01a660a42.Coremail.stitch@zju.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fe1dcd1.16124.1a01a660a42.Coremail.stitch@zju.edu.cn>

Hi Jiacheng,
On Wed, Aug 19, 2026 at 10:21:30PM +0800, Jiacheng Xu wrote:
> device_register() reports whether device registration succeeded, not
> whether the matching driver's probe succeeded. If nsim_drv_probe()
> fails, the driver core leaves the nsim_bus_dev registered while the probe
> error path clears its driver data.

I'm not very familiar with this part. Can't we just unregister the
device if probe failed?

BTW, your code is not rebased on latest net. Please do rebase if you
need to post a new version.

Thanks
Hangbin
> 
> new_device_store() subsequently marks the nsim_bus_dev initialized. A
> write to its new_port or del_port attribute therefore passes the init
> check and calls nsim_drv_port_add() or nsim_drv_port_del() with no valid
> nsim_dev. Both helpers pass the NULL driver data to priv_to_devlink(),
> leading to a NULL pointer dereference.
> 
> This can be reproduced by creating a netdevsim device for which
> nsim_drv_probe() fails and then writing to the new_port or del_port
> attribute of the registered device.
> 
> Serialize the driver data check and the port operation with the device
> lock, and reject the operation with -ENODEV when no driver data is
> present. This also prevents driver unbind from freeing nsim_dev between
> the check and its use, and follows the locking used by sriov_numvfs.
> 
> Fixes: 794b2c05ca1c ("netdevsim: extend device attrs to support port addition and deletion")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiacheng Xu <stitch@zju.edu.cn>
> ---
> Changes in v2:
> - Target the patch to the net tree.
> - Remove the reproducer attachment and describe the trigger in the
>   commit message.
> 
> drivers/net/netdevsim/bus.c | 17 ++++++++++++++---
> 1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/netdevsim/bus.c b/drivers/net/netdevsim/bus.c
> index 41483e371f05..0ab51306ad0a 100644
> --- a/drivers/net/netdevsim/bus.c
> +++ b/drivers/net/netdevsim/bus.c
> @@ -93,8 +93,13 @@ new_port_store(struct device *dev, struct device_attribute *attr,
>                 return -EINVAL;
>         }
> 
> -       ret = nsim_drv_port_add(nsim_bus_dev, NSIM_DEV_PORT_TYPE_PF, port_index,
> -                               addr_set ? eth_addr : NULL);
> +       device_lock(dev);
> +       if (!dev_get_drvdata(dev))
> +               ret = -ENODEV;
> +       else
> +               ret = nsim_drv_port_add(nsim_bus_dev, NSIM_DEV_PORT_TYPE_PF,
> +                                       port_index, addr_set ? eth_addr : NULL);
> +       device_unlock(dev);
>         return ret ? ret : count;
>  }
> 
> @@ -115,7 +120,13 @@ del_port_store(struct device *dev, struct device_attribute *attr,
>         if (ret)
>                 return ret;
> 
> -       ret = nsim_drv_port_del(nsim_bus_dev, NSIM_DEV_PORT_TYPE_PF, port_index);
> +       device_lock(dev);
> +       if (!dev_get_drvdata(dev))
> +               ret = -ENODEV;
> +       else
> +               ret = nsim_drv_port_del(nsim_bus_dev, NSIM_DEV_PORT_TYPE_PF,
> +                                       port_index);
> +       device_unlock(dev);
>         return ret ? ret : count;
>  }
> 
> --
> 2.25.1
