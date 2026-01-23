Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170DB332EAD;
	Fri, 23 Jan 2026 11:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769166554; cv=none; b=FOnY0GEBt0U/fBrKhA1HX5sf2FaW7cyCGuIkyxDmWB5x8Omy8A9Vm4U3mL+OGwPhAhxFrMiLtTByztOy3rG0qmH8v0s34z7wfoUX4kIZ4RopoSEwr0lguRlMX5nL4pQIQEnFLkA+pAo65SApFbJMaQ1s5WvfdSobTjtEgg6O9lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769166554; c=relaxed/simple;
	bh=DU4R/vh6HtH41Phs1tX6pkE7/HJlTdL2Clho8TNvyR0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WYDq0tF5zSURy1DZukUSZzLQV18YadQHbmSf9Qv/cYWmfxEejhSMu+zmJfWAUq/sxjGhsRmmCCzl5FZzj4/QCUp/ogIKDJEg0qhzHZYNXzHSngtl53QCGOG01kxU93jEb9Lp98S3CYfD9oYYBI7BJJj1QPrNnUAMb4p0Wy+G2BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YPiiP8wa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YPiiP8wa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B57A8C4CEF1;
	Fri, 23 Jan 2026 11:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769166552;
	bh=DU4R/vh6HtH41Phs1tX6pkE7/HJlTdL2Clho8TNvyR0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YPiiP8wal8toWFTCjQ1NRIGngEzybNfyLzM2Pyzfggp0b43TzPT2KLr0hCVNUIVaa
	 Cl9CB4AvVPelSZBsh08uLettW1pf6iZlDAvS0sRrmkRtFZqyHToaFF2kjJ/Pqo8Gyu
	 vjBCBR8OA1zxqKCNTz3fRqE0dpM8EjwiB7vyFEbatMgyYXVnRylybMX4OD5tw7RRtg
	 fz8Vd6/nyx1La5ZMBvs9soQqZFNejYv0CHaCtawjiApUNZBcuccQusDHV6o9T+voz/
	 OMgm+j9uMTH0zKIfz7En2mWSmmfeu/Yhaw03S9DHMaXTuG62mMFAnIkTbsTsR2uy6P
	 24GoH6Ey2CdSw==
Message-ID: <06da8493-b8a5-4497-8cf6-54aaf44b70b1@kernel.org>
Date: Fri, 23 Jan 2026 12:09:08 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH phy] phy: enter drivers/phy/Makefile even without
 CONFIG_GENERIC_PHY
To: Vladimir Oltean <vladimir.oltean@nxp.com>, linux-phy@lists.infradead.org,
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>, linux-kernel@vger.kernel.org,
 Venkat Rao Bagalkote <venkat88@linux.ibm.com>
References: <20260123110600.3118561-1-vladimir.oltean@nxp.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260123110600.3118561-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 23/01/2026 à 12:06, Vladimir Oltean a écrit :
> Kconfig option CONFIG_PHY_COMMON_PROPS, which builds
> drivers/phy/phy-common-props.c, was intended to be selectable
> independently of CONFIG_GENERIC_PHY. Yet it lives in drivers/phy/, which
> is entered by the Makefile only if CONFIG_GENERIC_PHY is set.
> 
> Allow the Makefile to enter one level deeper, but stop at drivers/phy/
> if CONFIG_GENERIC_PHY is unselected (i.e. do not enter vendor folders).
> The other stuff from drivers/phy/Makefile except for CONFIG_PHY_COMMON_PROPS,
> like CONFIG_PHY_NXP_PTN3222, all depends on CONFIG_GENERIC_PHY.
> 
> Fixes: e7556b59ba65 ("phy: add phy_get_rx_polarity() and phy_get_tx_polarity()")
> Closes: https://lore.kernel.org/lkml/43ea0202-891d-4582-980b-5cb557b41114@linux.ibm.com/
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Debugged-by: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

> ---
>   drivers/Makefile     | 2 +-
>   drivers/phy/Makefile | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/Makefile b/drivers/Makefile
> index ccc05f1eae3e..53fbd2e0acdd 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -10,7 +10,7 @@ obj-y				+= cache/
>   obj-y				+= irqchip/
>   obj-y				+= bus/
>   
> -obj-$(CONFIG_GENERIC_PHY)	+= phy/
> +obj-y				+= phy/
>   
>   # GPIO must come after pinctrl as gpios may need to mux pins etc
>   obj-$(CONFIG_PINCTRL)		+= pinctrl/
> diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
> index 30b150d68de7..93715ea0d010 100644
> --- a/drivers/phy/Makefile
> +++ b/drivers/phy/Makefile
> @@ -15,7 +15,7 @@ obj-$(CONFIG_PHY_SNPS_EUSB2)		+= phy-snps-eusb2.o
>   obj-$(CONFIG_USB_LGM_PHY)		+= phy-lgm-usb.o
>   obj-$(CONFIG_PHY_AIROHA_PCIE)		+= phy-airoha-pcie.o
>   obj-$(CONFIG_PHY_NXP_PTN3222)		+= phy-nxp-ptn3222.o
> -obj-y					+= allwinner/	\
> +obj-$(CONFIG_GENERIC_PHY)		+= allwinner/	\
>   					   amlogic/	\
>   					   broadcom/	\
>   					   cadence/	\

