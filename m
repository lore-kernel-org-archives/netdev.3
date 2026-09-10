Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50347475335;
	Thu, 10 Sep 2026 12:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789044178; cv=none; b=CzVu1tVVKlXYTn1eORY5fDWqdNcOXkbuC9sHV/9r77LHN6TOEhdmrKA98GvU/H9hQzlBmWsnMFErEh/XklM0kuWENJB5qQqY+PoOdS/6tkRnXdNoi+vSw4dtW5rgx97cQrKQJsFElNby1JFRjmUmfaX7ZAURYrpJvgakTuku+Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789044178; c=relaxed/simple;
	bh=rD2r0ZJHQ4pnPyzvZzv6ITnpgWvWEqQMsaZpzTxq+eE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qVpZoMPSgn1uGJwFMzLx3ZU2sr3UengcQFhIEFvYC0/mgpNk0cLkdlXs0WLUprz20q2rcdRpv3MyebM0EvxZI17BiLqsPzDsgo6PwKB8b78gxx1Hm+3/orPzHtHacDy3+mUL3DX8Z4g6N3mx/GJgIvDFvavhPmFLyjnb7sCkCb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yK+RulPa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yK+RulPa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5D951F000FF;
	Thu, 10 Sep 2026 12:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789044172;
	bh=O1TCJNckcR1ZCasoAjnNvFB4xDvkSyyaa1YH7Joef6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=yK+RulPacUHhpAYnJuoHh8GDv71b4aSmFvhUE6Y2XCOVOlh6lvucgxqC+aDsczaHa
	 2kODvhRmbmlXG9KMIldiXzavjoo0BEyVI6isRfuHAlqsio/aYRU3RfAN+yRsY/2pn9
	 hVyocgAVna/IJwYzvgPjMDrrO4vpteCO+E+4tuEo=
Date: Thu, 10 Sep 2026 14:42:44 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Shashank Balaji <shashank.mahadasyam@sony.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Bastien Nocera <hadess@hadess.net>,
	Matthias Kaehlcke <mka@chromium.org>,
	Valentina Manea <valentina.manea.m@gmail.com>,
	Shuah Khan <shuah@kernel.org>, Hongren Zheng <i@zenithal.me>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daniel Palmer <daniel.palmer@sony.com>,
	Rahul Bukte <rahul.bukte@sony.com>, Tim Bird <tim.bird@sony.com>,
	linux-embedded@vger.kernel.org
Subject: Re: [PATCH 2/4] usb: core: set mod_name in driver registration
Message-ID: <2026091010-awkward-crouton-31e0@gregkh>
References: <20260722-mod_name_usb-v1-0-96d781530f3f@sony.com>
 <20260722-mod_name_usb-v1-2-96d781530f3f@sony.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722-mod_name_usb-v1-2-96d781530f3f@sony.com>

On Wed, Jul 22, 2026 at 12:31:22PM +0900, Shashank Balaji wrote:
> The driver core only creates the sysfs "module" symlink for a built-in
> driver when its struct device_driver has mod_name set (see
> module_add_driver()). This registration path left mod_name unset, so built-in
> drivers using it had no such symlink.
> 
> Set mod_name to KBUILD_MODNAME during driver registration. Built-in
> drivers now gain the symlink, while loadable modules are unaffected.
> 
> Co-developed-by: Rahul Bukte <rahul.bukte@sony.com>
> Signed-off-by: Rahul Bukte <rahul.bukte@sony.com>
> Signed-off-by: Shashank Balaji <shashank.mahadasyam@sony.com>
> ---
>  include/linux/usb.h       | 4 ++--
>  drivers/usb/core/driver.c | 4 +++-
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/usb.h b/include/linux/usb.h
> index 2466183a45f0..6507c217bca7 100644
> --- a/include/linux/usb.h
> +++ b/include/linux/usb.h
> @@ -1369,9 +1369,9 @@ extern void usb_deregister(struct usb_driver *);
>  		       usb_deregister)
>  
>  #define usb_register_device_driver(new_udriver) \
> -	__usb_register_device_driver(new_udriver, THIS_MODULE)
> +	__usb_register_device_driver(new_udriver, THIS_MODULE, KBUILD_MODNAME)

It seems odd to me that struct module doesn't contain the name of the
module, and you have to pass this around all the time...

Anyway, all now queued up, thanks!

greg k-h
