Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE4047987A;
	Mon, 14 Sep 2026 13:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789391542; cv=none; b=Ui1N0YyNv4uF6WvjCEqpG6yt+u++AwpPYrCtWFglFjZLQ7a4ltC+fHBCG7I7cVDJu8O8xqD2fcPd9+kt5aGFjziNTnrt7RESp2fT9QWea3lNGgHg33/SSsbGUF4ni6FPibKSuRUgUZ/4hyAoaKlrdMPi6fxddvObZiqwDExPokk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789391542; c=relaxed/simple;
	bh=oxbFhAvr6JSfGzP5RlSIkIiQp3K9ZHr1MCwoENtbehI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KjUSpIa9tuRdTlomwu0+/ciIg7mEovaqliNBvl4xU8gfZLUTZa0UJ8wC/8V6PF4WBRPRn7PpelZiqjjAAuxphqmkZtyl8Ds5v5w6kj7+JSupXOgIl4PnwqddUWfMVDGIFuVp7SgKw5ws8qtG/eCsG9/cM4nU2nSM/91cbxdYILY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mPBSdDIB; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mPBSdDIB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789391540; x=1820927540;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oxbFhAvr6JSfGzP5RlSIkIiQp3K9ZHr1MCwoENtbehI=;
  b=mPBSdDIBFWF1SQT+VjfdPVHFSXjrs7TKpab9zSYV7DhyBmM5w2Wtw6dT
   2UdNib5PFjRQAqsRcOUDE6NqsX2fRRFY0MLLyxux6YJcK+unCC+TiRpRH
   KJJeP9f+9LUl5XOMJwM7jw+z3GjaqNOFj02qCz9k2s6OxBf4EvlTfxzVU
   xBV3vN9GM1pNC0ceeooFCvEi8XIEr+dMfxe0ZGDngzkq/3xvIKuAPZVs5
   SCnZLeB98dvGp4R4Tjw3aW7f4HuPmGltyqJ0jpnTWB/rwEHUpxgG9XqvL
   wG6fSP48xcL+vUtzzOTCc/jPZ30gOLRacuwX9Ck0ZkN3t56sL0k7Bb0wr
   A==;
X-CSE-ConnectionGUID: CpZ6BkesRhyQu0FT0WTvAg==
X-CSE-MsgGUID: znMlWhcfQgyVx4W/Jmnmqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11904"; a="112511240"
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; 
   d="scan'208";a="112511240"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 06:12:19 -0700
X-CSE-ConnectionGUID: K5cBbZILTeK5caqNakas1g==
X-CSE-MsgGUID: YqxQpIzbRh2TnzGxHNT0cQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; 
   d="scan'208";a="270832192"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa006.jf.intel.com with ESMTP; 14 Sep 2026 06:12:15 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id 5371A99; Mon, 14 Sep 2026 15:12:14 +0200 (CEST)
Date: Mon, 14 Sep 2026 15:12:14 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Subasri S <subasris1210@gmail.com>
Cc: Peter Chen <peter.chen@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Duncan Sands <duncan.sands@free.fr>,
	Chas Williams <3chas3@gmail.com>,
	Minas Harutyunyan <hminas@synopsys.com>,
	Hans de Goede <hansg@kernel.org>,
	Badhri Jagan Sridharan <badhri@google.com>,
	linux-usb@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org
Subject: Re: [PATCH v2 3/3] usb: typec: Use %pe to print error pointers
Message-ID: <aqfyrs6Hdjc_ywZG@black.igk.intel.com>
References: <20260801-usb-ptr_err_patchset-v2-0-1698e298c1e3@gmail.com>
 <20260801-usb-ptr_err_patchset-v2-3-1698e298c1e3@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260801-usb-ptr_err_patchset-v2-3-1698e298c1e3@gmail.com>

On Sat, Aug 01, 2026 at 05:59:52PM +0530, Subasri S wrote:
> Use the %pe format specifier instead of %ld with PTR_ERR() for printing
> error pointers in various typec drivers. This prints symbolic
> error names (e.g.-ENOMEM) instead of errno numbers (e.g. -12),
> making error logs more readable.
> 
> Fix coccinelle reported warning:
> WARNING: Consider using %pe to print PTR_ERR()
> 
> Compile tested only.
> 
> Reviewed-by: Badhri Jagan Sridharan <badhri@google.com>
> Signed-off-by: Subasri S <subasris1210@gmail.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/mux/pi3usb30532.c | 6 ++----
>  drivers/usb/typec/tcpm/tcpm.c       | 2 +-
>  drivers/usb/typec/wusb3801.c        | 4 ++--
>  3 files changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/usb/typec/mux/pi3usb30532.c b/drivers/usb/typec/mux/pi3usb30532.c
> index 985683fe49e9..b32f4c433de9 100644
> --- a/drivers/usb/typec/mux/pi3usb30532.c
> +++ b/drivers/usb/typec/mux/pi3usb30532.c
> @@ -139,8 +139,7 @@ static int pi3usb30532_probe(struct i2c_client *client)
>  
>  	pi->sw = typec_switch_register(dev, &sw_desc);
>  	if (IS_ERR(pi->sw)) {
> -		dev_err(dev, "Error registering typec switch: %ld\n",
> -			PTR_ERR(pi->sw));
> +		dev_err(dev, "Error registering typec switch: %pe\n", pi->sw);
>  		return PTR_ERR(pi->sw);
>  	}
>  
> @@ -151,8 +150,7 @@ static int pi3usb30532_probe(struct i2c_client *client)
>  	pi->mux = typec_mux_register(dev, &mux_desc);
>  	if (IS_ERR(pi->mux)) {
>  		typec_switch_unregister(pi->sw);
> -		dev_err(dev, "Error registering typec mux: %ld\n",
> -			PTR_ERR(pi->mux));
> +		dev_err(dev, "Error registering typec mux: %pe\n", pi->mux);
>  		return PTR_ERR(pi->mux);
>  	}
>  
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 89eec20a2064..ad10470ea73b 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -4796,7 +4796,7 @@ static void tcpm_typec_connect(struct tcpm_port *port)
>  			port->partner_desc.accessory = TYPEC_ACCESSORY_NONE;
>  		partner = typec_register_partner(port->typec_port, &port->partner_desc);
>  		if (IS_ERR(partner)) {
> -			dev_err(port->dev, "Failed to register partner (%ld)\n", PTR_ERR(partner));
> +			dev_err(port->dev, "Failed to register partner (%pe)\n", partner);
>  			return;
>  		}
>  
> diff --git a/drivers/usb/typec/wusb3801.c b/drivers/usb/typec/wusb3801.c
> index 6062875fb04a..86d13ab41670 100644
> --- a/drivers/usb/typec/wusb3801.c
> +++ b/drivers/usb/typec/wusb3801.c
> @@ -277,8 +277,8 @@ static void wusb3801_hw_update(struct wusb3801 *wusb3801)
>  		if (partner_type != WUSB3801_STAT_PARTNER_STANDBY) {
>  			wusb3801->partner = typec_register_partner(port, &desc);
>  			if (IS_ERR(wusb3801->partner))
> -				dev_err(dev, "Failed to register partner: %ld\n",
> -					PTR_ERR(wusb3801->partner));
> +				dev_err(dev, "Failed to register partner: %pe\n",
> +					wusb3801->partner);
>  		}
>  
>  		data_role = pwr_role == TYPEC_SOURCE ? TYPEC_HOST : TYPEC_DEVICE;
> 
> -- 
> 2.43.0

-- 
heikki
