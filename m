Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33822AE78;
	Mon, 27 Jul 2026 11:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785152356; cv=none; b=CTQ0Denx4WJpWzTT8ngmopdLEjxypfg2UL116Y88gG0U+GjUVwxzmx+Tvr89U4Kihn/zB4uK6Vfsh5KzN1sE/jcToxptocUYme04pwkZ3hbhPIeoExz72Vqy/Cu2dzX6K3/19+y5KKkfc0no1JCQlLoZspFKk2KKzrWbGLwPghc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785152356; c=relaxed/simple;
	bh=n7j1ohc/cieq1FqmOuXuNCbLEMVtWTGjYjUFB2+2XPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EPBdv2N9UHLtLUGExQaaG+3BUz90ekjBoOb+xTRCUrz2bS8Xc7VczrCR5Um87l/297IonjqBVjDPvHRmhOGZ1ufUh3Rz0EjdMvx5NkXW0eRXsdADZp7TuBzQy1B/PjxHZMDZ90VFkQEuhEI5KJNmQb2FLjLrsuUmC/IsF8N2PE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mbnkULCi; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mbnkULCi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785152355; x=1816688355;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=n7j1ohc/cieq1FqmOuXuNCbLEMVtWTGjYjUFB2+2XPk=;
  b=mbnkULCieUIkvA17bAKkK6z2aNp+zx6FycuWP0OTB8T8Bu5gqvusyLRN
   zBW7qj/EAHMXN3UBpepymJZ2UBlWE7k9Me4rfmT9f46sYIPydhczV+KLS
   w0s/4l21tJFZ32O5KIg7CArf1LpJfmME/+0zRCRJHvIwWguNwX7GZpWIR
   7We1jOl+HD3ieUeloIm7daxmtbanEBoHh45wvvysJ7hGOKWX47rC/S3xk
   ICRmG2g2RjWCCPN4qdRDOi64keLGbpTxXHP/agwam6Zh5g21TxYrrzA3c
   w6MSzUZ9BArLTDKXIKlHF77NJaoI7f4+X9fppGbCjvt34Ljqtq6caQcNo
   Q==;
X-CSE-ConnectionGUID: wh9ZZkiDS0CBo8Y3IqR3Lw==
X-CSE-MsgGUID: 5cQVWxV/SWelGdcH7Y2Dnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11857"; a="97091915"
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="97091915"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 04:39:14 -0700
X-CSE-ConnectionGUID: kH6nFSc9Q0G0sTUCW+YyVQ==
X-CSE-MsgGUID: VhzHa07fQ0aDZlMHHy47cQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="283909273"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa001.fm.intel.com with ESMTP; 27 Jul 2026 04:39:10 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id 50D8C99; Mon, 27 Jul 2026 13:39:09 +0200 (CEST)
Date: Mon, 27 Jul 2026 13:39:09 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Shashank Balaji <shashank.mahadasyam@sony.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bastien Nocera <hadess@hadess.net>,
	Matthias Kaehlcke <mka@chromium.org>,
	Valentina Manea <valentina.manea.m@gmail.com>,
	Shuah Khan <shuah@kernel.org>, Hongren Zheng <i@zenithal.me>,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daniel Palmer <daniel.palmer@sony.com>,
	Rahul Bukte <rahul.bukte@sony.com>, Tim Bird <tim.bird@sony.com>,
	linux-embedded@vger.kernel.org
Subject: Re: [PATCH 3/4] usb: typec: set mod_name in driver registration
Message-ID: <amdDXSFZHeAroQL0@black.igk.intel.com>
References: <20260722-mod_name_usb-v1-0-96d781530f3f@sony.com>
 <20260722-mod_name_usb-v1-3-96d781530f3f@sony.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722-mod_name_usb-v1-3-96d781530f3f@sony.com>

On Wed, Jul 22, 2026 at 12:31:23PM +0900, Shashank Balaji wrote:
> The driver core only creates the sysfs "module" symlink for a built-in
> driver when its struct device_driver has mod_name set (see
> module_add_driver()). This driver left mod_name unset, so its built-in
> form had no such symlink.
> 
> Set mod_name to KBUILD_MODNAME during driver registration. Built-in
> drivers now gain the symlink, while loadable modules are unaffected.
> 
> Co-developed-by: Rahul Bukte <rahul.bukte@sony.com>
> Signed-off-by: Rahul Bukte <rahul.bukte@sony.com>
> Signed-off-by: Shashank Balaji <shashank.mahadasyam@sony.com>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  include/linux/usb/typec_altmode.h | 4 ++--
>  drivers/usb/typec/bus.c           | 4 +++-
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/usb/typec_altmode.h b/include/linux/usb/typec_altmode.h
> index ef21ead551be..92309b569c3a 100644
> --- a/include/linux/usb/typec_altmode.h
> +++ b/include/linux/usb/typec_altmode.h
> @@ -227,9 +227,9 @@ struct typec_altmode_driver {
>   * handle all SVID specific communication.
>   */
>  #define typec_altmode_register_driver(drv) \
> -		__typec_altmode_register_driver(drv, THIS_MODULE)
> +		__typec_altmode_register_driver(drv, THIS_MODULE, KBUILD_MODNAME)
>  int __typec_altmode_register_driver(struct typec_altmode_driver *drv,
> -				    struct module *module);
> +				    struct module *module, const char *mod_name);
>  /**
>   * typec_altmode_unregister_driver - unregisters a USB Type-C alternate mode
>   * 				     device driver
> diff --git a/drivers/usb/typec/bus.c b/drivers/usb/typec/bus.c
> index e84b134a3381..587d3b06ee8d 100644
> --- a/drivers/usb/typec/bus.c
> +++ b/drivers/usb/typec/bus.c
> @@ -383,12 +383,14 @@ void typec_altmode_put_plug(struct typec_altmode *plug)
>  EXPORT_SYMBOL_GPL(typec_altmode_put_plug);
>  
>  int __typec_altmode_register_driver(struct typec_altmode_driver *drv,
> -				    struct module *module)
> +				    struct module *module,
> +				    const char *mod_name)
>  {
>  	if (!drv->probe)
>  		return -EINVAL;
>  
>  	drv->driver.owner = module;
> +	drv->driver.mod_name = mod_name;
>  	drv->driver.bus = &typec_bus;
>  
>  	return driver_register(&drv->driver);
> 
> -- 
> 2.43.0

-- 
heikki
