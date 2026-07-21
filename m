Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11364A33E1;
	Tue, 21 Jul 2026 10:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784630027; cv=none; b=V+mI8Xv3G2S4xATugAl3zfsbUJUvnqGJwZfYXLPVIR41QmKwi0ss7XuJzxERk+AqeOZwA57/advNVc7BSJb4cz5Ed8iEcz7qHMLxjwn1+qYduppt6/Xinkcz5Y+Vr9xUpHAaCH9cSyXwqmr314GJ0tbKUoa4sy74S67q75bhTqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784630027; c=relaxed/simple;
	bh=WJGTqjCh1G3VEZn3GJLICNgLE0eVx5PejOB2rEtQ0YU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t4cAwDMoakTvtCVydCnCwZYu5sD1x1ql+G+Ty10LKfFt74PV3H+Wr+wLn8ro+t/9abNBe/bJQEABWFhnwKJRki64xBucvcvTBPhVDaQHg3mHNLze0Z/DmgmZmTFR7w9gJRWwZgdnDmWNg85TN6ogsE/2VoRAupC3vrxlFSh1Bjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L+q3LaSK; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L+q3LaSK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784630021; x=1816166021;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WJGTqjCh1G3VEZn3GJLICNgLE0eVx5PejOB2rEtQ0YU=;
  b=L+q3LaSKHJNBh3h6PGNYGP2wHbtlXudRpaWZHKrEAxcSLLWsORgfgCRo
   t4iuMsd/4cKSq20DEZ7iT/5PEEgnpbHEQ8000Db/LREpElfvJsTJQWZen
   sOy5ojSLyXWpQaZQjPK4XFDeY/oAxl2xYERQ4Lx2mSslS8qZW5ZcxmeK4
   FsOQGszFs1PnDukH0/HZ6/5Q2X4oyjih2n4+Bp/BMIdBd11ZCoZWHI7cq
   VF1CQncz3zFZpubEwzVDTBHCxo1C1iaZnSHJ3x8LPyk1PLVRv9fMrj58z
   Lt54lH7LMbsTSGtX++F0C6ewdqURXFyCsuegnMlTszI4Q339nORqe2cNj
   Q==;
X-CSE-ConnectionGUID: vzYFBY1cRYCfPI4NylcSiw==
X-CSE-MsgGUID: 9dtSZo+0RHW51BahhMEXhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="89117451"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="89117451"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 03:33:38 -0700
X-CSE-ConnectionGUID: LOm+XhIsSSC11g9b3Ixtdg==
X-CSE-MsgGUID: Jf4YByYiTEC9GfPIHvQ8WA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="253369954"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa006.fm.intel.com with ESMTP; 21 Jul 2026 03:33:34 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id EB03695; Tue, 21 Jul 2026 12:33:32 +0200 (CEST)
Date: Tue, 21 Jul 2026 13:33:31 +0300
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
Subject: Re: [PATCH 3/3] usb: typec: Use %pe to print error pointers
Message-ID: <al9K-4w4FykFIgpi@kuha>
References: <20260719-usb-ptr_err_patchset-v1-0-85f7f2e4fefb@gmail.com>
 <20260719-usb-ptr_err_patchset-v1-3-85f7f2e4fefb@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260719-usb-ptr_err_patchset-v1-3-85f7f2e4fefb@gmail.com>

Hi Subasri,

Thanks for the patch.

On Sun, Jul 19, 2026 at 06:25:48PM +0530, Subasri S wrote:
> Use the %pe format specifier instead of %ld with PTR_ERR() for printing
> error pointers in various typec drivers. This prints symbolic
> error names (e.g.-ENOMEM) instead of errno numbers (e.g. -12),
> making error logs more readable.
> 
> This patch fixes coccinelle reported warnings:
> ./typec/tcpm/tcpm.c:4799:60-67: WARNING: Consider using %pe to print PTR_ERR()
> ./typec/mux/pi3usb30532.c:143:3-10: WARNING: Consider using %pe to print PTR_ERR()
> ./typec/mux/pi3usb30532.c:155:3-10: WARNING: Consider using %pe to print PTR_ERR()
> ./typec/wusb3801.c:281:5-12: WARNING: Consider using %pe to print PTR_ERR()
> 
> Compile tested only.
> 
> Signed-off-by: Subasri S <subasris1210@gmail.com>
> ---
>  drivers/usb/typec/mux/pi3usb30532.c | 8 ++++----
>  drivers/usb/typec/tcpm/tcpm.c       | 2 +-
>  drivers/usb/typec/wusb3801.c        | 4 ++--
>  3 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/usb/typec/mux/pi3usb30532.c b/drivers/usb/typec/mux/pi3usb30532.c
> index 985683fe49e9..a2357a28ecf4 100644
> --- a/drivers/usb/typec/mux/pi3usb30532.c
> +++ b/drivers/usb/typec/mux/pi3usb30532.c
> @@ -139,8 +139,8 @@ static int pi3usb30532_probe(struct i2c_client *client)
>  
>  	pi->sw = typec_switch_register(dev, &sw_desc);
>  	if (IS_ERR(pi->sw)) {
> -		dev_err(dev, "Error registering typec switch: %ld\n",
> -			PTR_ERR(pi->sw));
> +		dev_err(dev, "Error registering typec switch: %pe\n",
> +			pi->sw);

One line is enough.

>  		return PTR_ERR(pi->sw);
>  	}
>  
> @@ -151,8 +151,8 @@ static int pi3usb30532_probe(struct i2c_client *client)
>  	pi->mux = typec_mux_register(dev, &mux_desc);
>  	if (IS_ERR(pi->mux)) {
>  		typec_switch_unregister(pi->sw);
> -		dev_err(dev, "Error registering typec mux: %ld\n",
> -			PTR_ERR(pi->mux));
> +		dev_err(dev, "Error registering typec mux: %pe\n",
> +			pi->mux);

Ditto.

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

Thanks,

-- 
heikki
