Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E3344AB9B;
	Tue, 15 Sep 2026 07:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789455815; cv=none; b=QmYhsfp/yrO0behgsQ2x/MJns8UCY8Ih39R3UyAONoqJvRCXjVYF3aG4iUwjskuGaWH5GssUvYeNaFEAS+AIMR0PuFEUG8O/gRqOnXnCz9J5ci8e5vZDcmsjIPNGj/oLSDAaTP403xJ8DCq6xJq4JJHRHSm8uEX6x8K3OwMfwmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789455815; c=relaxed/simple;
	bh=PASnGHuTNr9ooO+/UyWkBH7ChjK/TTZc6mbxL06hQlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HBk1rRheAoCBFFnGzkqEZx1T4hYWQ2/dEi4qYnA2ayJbk6y9K2JyzvG4BMIv+OlC1cdUxLF3QhzrUYLVdYqD1HLAcGazENkgP9a4a9WFN8yH/qtVE8j3IguGjeReEaxtTthOOPdse9jLiG/m7aQ6yxsJIvo9Tbe9VAV9EgMsvOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DY8pZtu4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DY8pZtu4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 229E91F000FF;
	Tue, 15 Sep 2026 07:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789455808;
	bh=0jqazLvI6PHhKlLUw5ES9AlYBTQV/CW02EbTg8KOkAc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DY8pZtu4LuzXGihC1YElZInpGFpLzAlctTZ5qIJHgqTbGCYvRb74jSsImxBX/Of7e
	 P0rUoS8jmWyqFsv1InIewtvA0IXOHOyhuf4iViVzEhejf/jXhPrH3TqtIs2s1DhQTi
	 KY1Qq3wU1lwpqPuYbRLl+n9f7qvELuG4c6/zO3fGPtgIBMA1li/lP8ueuCBu2P8uzP
	 vpR9ZNieeTiSO2dYr7NtjIQeGAK2C6hkvIg/+exeXoSw5ilvOgXNejrys3ydrq+lte
	 X32vaAM+P4DQW2VRBFoiGaerQ2zbPPtO8yQdygT6+VaK2aUU+SUz8YOkEIO9WZySWq
	 ih0c7yOtrqI6w==
Date: Tue, 15 Sep 2026 00:03:26 -0700
From: Peter Chen <peter.chen@kernel.org>
To: Subasri S <subasris1210@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Duncan Sands <duncan.sands@free.fr>,
	Chas Williams <3chas3@gmail.com>,
	Minas Harutyunyan <hminas@synopsys.com>,
	Hans de Goede <hansg@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Badhri Jagan Sridharan <badhri@google.com>,
	linux-usb@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org
Subject: Re: [PATCH v2 1/3] usb: chipidea: Use %pe to print error pointers
Message-ID: <aqjtvglG5NhsDLZe@hu-petche-lv.qualcomm.com>
References: <20260801-usb-ptr_err_patchset-v2-0-1698e298c1e3@gmail.com>
 <20260801-usb-ptr_err_patchset-v2-1-1698e298c1e3@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260801-usb-ptr_err_patchset-v2-1-1698e298c1e3@gmail.com>

On 26-08-01 17:59:50, Subasri S wrote:
> Use the %pe format specifier instead of %ld with PTR_ERR() for printing
> error pointers in imx_get_clks(), ci_hdrc_imx_probe(), and
> ci_get_platdata(). This prints symbolic error names (e.g. -ENOMEM)
> instead of errno numbers (e.g. -12), making error logs more readable.
> 
> Fix coccinelle reported warning:
> WARNING: Consider using %pe to print PTR_ERR()
> 
> Compile-tested only.
> 
> Signed-off-by: Subasri S <subasris1210@gmail.com>

Acked-by: Peter Chen <peter.chen@kernel.org>

Peter
> ---
>  drivers/usb/chipidea/ci_hdrc_imx.c | 12 ++++++------
>  drivers/usb/chipidea/core.c        |  4 ++--
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
> index 56d2ba824a0b..7bfe37ed68ae 100644
> --- a/drivers/usb/chipidea/ci_hdrc_imx.c
> +++ b/drivers/usb/chipidea/ci_hdrc_imx.c
> @@ -218,8 +218,8 @@ static int imx_get_clks(struct device *dev)
>  		if (IS_ERR(data->clk)) {
>  			ret = PTR_ERR(data->clk);
>  			dev_err(dev,
> -				"Failed to get clks, err=%ld,%ld\n",
> -				PTR_ERR(data->clk), PTR_ERR(data->clk_ipg));
> +				"Failed to get clks, err=%pe,%pe\n",
> +				data->clk, data->clk_ipg);
>  			return ret;
>  		}
>  		/* Get wakeup clock. Not all of the platforms need to
> @@ -448,8 +448,8 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
>  		pinctrl_hsic_idle = pinctrl_lookup_state(data->pinctrl, "idle");
>  		if (IS_ERR(pinctrl_hsic_idle)) {
>  			dev_err(dev,
> -				"pinctrl_hsic_idle lookup failed, err=%ld\n",
> -					PTR_ERR(pinctrl_hsic_idle));
> +				"pinctrl_hsic_idle lookup failed, err=%pe\n",
> +					pinctrl_hsic_idle);
>  			ret = PTR_ERR(pinctrl_hsic_idle);
>  			goto err_put;
>  		}
> @@ -464,8 +464,8 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
>  								"active");
>  		if (IS_ERR(data->pinctrl_hsic_active)) {
>  			dev_err(dev,
> -				"pinctrl_hsic_active lookup failed, err=%ld\n",
> -					PTR_ERR(data->pinctrl_hsic_active));
> +				"pinctrl_hsic_active lookup failed, err=%pe\n",
> +					data->pinctrl_hsic_active);
>  			ret = PTR_ERR(data->pinctrl_hsic_active);
>  			goto err_put;
>  		}
> diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
> index 07563be0013f..09db8a4eace2 100644
> --- a/drivers/usb/chipidea/core.c
> +++ b/drivers/usb/chipidea/core.c
> @@ -680,8 +680,8 @@ static int ci_get_platdata(struct device *dev,
>  			/* no vbus regulator is needed */
>  			platdata->reg_vbus = NULL;
>  		} else if (IS_ERR(platdata->reg_vbus)) {
> -			dev_err(dev, "Getting regulator error: %ld\n",
> -				PTR_ERR(platdata->reg_vbus));
> +			dev_err(dev, "Getting regulator error: %pe\n",
> +				platdata->reg_vbus);
>  			return PTR_ERR(platdata->reg_vbus);
>  		}
>  		/* Get TPL support */
> 
> -- 
> 2.43.0
> 

-- 

Thanks,
Peter Chen
