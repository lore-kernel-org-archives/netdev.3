Received: from mta1.migadu.com (out-249.mta1.migadu.com [95.215.58.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEA73FCC
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 07:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787123570; cv=none; b=FzaQpDfMcEAlmf3PtAEBzUIoRO/UKBo8w6hl0CU707qlTRhas/Apb1mfEWHN6KgjJiOLT+JgvRuifx9z6XD+f1EtOltg4yHrtVP3lmQPtKBb8aOHsAhJCl7Cc2pF6iE7gwHPjgX8ksa4YhRc4kSz/ZXoDi/VfeMW4kBnxknd024=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787123570; c=relaxed/simple;
	bh=DMzbNbV8t3RU0pu2wPPItVvGom+rBFQGByx/Om+m5Gs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C8vtFWQyD8YPFBalF/Y6HlClqYpJHIlk3v9GVv27m0osUZ2h3fnVUgDwe4gef6tz+SmJBl6W22r+2i8wJ4kbdTl+XuiamScGXRh9ErSxAvKzqvec18XM9adR399/PQrYEqJ+/k6O62fneGlsWH3UNxF4V/9TQoY2dgE6AHWPcyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gJYWOu/j; arc=none smtp.client-ip=95.215.58.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gJYWOu/j"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=DMzbNbV8t3RU0pu2wPPItVvGom+rBFQGByx/Om+m5Gs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787123565; v=1; x=1787728365;
 b=gJYWOu/jryoj0hE7BUHIC+0qsEdao+7pOMmaR7wWoo7NDLdbz9Qiu9X6MqhrOr8rrgyQknpW
 kDsEzv3ZZQOBJ4Td9CEOeIkTNCFA/FMiH9lMX5QLSBiDEINkz3D4kvuh9UOXFzxN9m+9mS1ZayF
 m8YnMtsABDMv0/29+clHq5gA=
X-Envelope-To: netdev@vger.kernel.org
Received: from fedora (203.175.12.241)
	by smtp.migadu.com with ESMTPS id 867fa8b296f11ad7;
	Wed, 19 Aug 2026 07:12:45 +0000
X-Migadu-Flow: FLOW_OUT
Date: Wed, 19 Aug 2026 15:12:32 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Jiacheng Xu <stitch@zju.edu.cn>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH] netdevsim: avoid NULL dereference after failed probe
Message-ID: <aoVXYEDchDlsFG3i@fedora>
References: <42315c2c.15f85.1a01853d723.Coremail.stitch@zju.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42315c2c.15f85.1a01853d723.Coremail.stitch@zju.edu.cn>

Hi Jiacheng,

On Wed, Aug 19, 2026 at 12:42:22PM +0800, Jiacheng Xu wrote:
> device_register() reports whether device registration succeeded, not
> whether the matching driver's probe succeeded. If nsim_drv_probe()
> fails, the driver core leaves the nsim_bus_dev registered while the probe
> error path clears its driver data.
> 
> new_device_store() subsequently marks the nsim_bus_dev initialized. A
> write to its new_port or del_port attribute therefore passes the init
> check and calls nsim_drv_port_add() or nsim_drv_port_del() with no valid
> nsim_dev. Both helpers pass the NULL driver data to priv_to_devlink(),
> leading to a NULL pointer dereference. The triggering PoC is attached.
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

Thanks for your fixes.

Please do not attache the reproducer as an attachment in patch file. You can
describe it in commit description, cover letter, Or, add it as a selftest in
tools/testing/selftests/drivers/net/netdevsim/.

BTW, please designate your patch to a tree, i.e. [PATCH net].

Thanks
Hangbin

> #include <fcntl.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <unistd.h>
> 
> static void write_attr(const char *path, const char *buf)
> {
>         int fd = open(path, O_WRONLY | O_CLOEXEC);
>         ssize_t len;
> 
>         if (fd < 0) {
>                 perror(path);
>                 exit(EXIT_FAILURE);
>         }
>         len = write(fd, buf, strlen(buf));
>         if (len < 0)
>                 perror(path);
>         close(fd);
> }
> 
> int main(void)
> {
>         /* One port is enough; the excessive queue count makes probe fail. */
>         write_attr("/sys/bus/netdevsim/new_device",
>                    "1 1 2147483648");
>         write_attr("/sys/bus/netdevsim/devices/netdevsim1/new_port",
>                    "2");
>         return 0;
> }

