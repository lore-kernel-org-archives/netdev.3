Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483E674BE1;
	Tue, 24 Feb 2026 01:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771896801; cv=none; b=VPAkfBAWCRcFQRBpsyJI86cpCjPGFrgtWlOnoTH0J+mnUvVMSedm1tjAP/9w5HvVohgZM14DTV5yhTBTbBehtZRtNsy3uQ6RgFBg5tmzfCI4sWsS25IC8rNTAvXfCSdycD8nAqcSwXXuu7DNFABDf1pdxkvp3ZXzlNdf8j4F+Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771896801; c=relaxed/simple;
	bh=rNtfZ7XhiZrK32oDIZNocH6ITBMCgKtTpjd+d8nLzL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WB/BjaQyHu+qshpvEyeoL40RMJRyUH7Kn3yErPLpjJVttEaNMX8JgNRT1NqwcS8RLAv3ZRJeEcAUvWGXknSvZ2dYlAXH2XOADWqfnhAWHsNJFLQd8TfJKYE0d/I1CjQ8S+6L8KxVr54cEPZSpAApcEILeXEkzGdRLBV37Lm2KH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vuhIV-000000001oV-0fcf;
	Tue, 24 Feb 2026 01:33:11 +0000
Date: Tue, 24 Feb 2026 01:33:07 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?Ren=E9?= van Dorst <opensource@vdorst.com>
Subject: Re: [PATCH net-next] r8152: Add 2500baseT EEE status/configuration
 support
Message-ID: <aZz_0_Zt67XsOyTM@makrotopia.org>
References: <20260223-b4-eee2g5-v1-1-7006b537b144@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223-b4-eee2g5-v1-1-7006b537b144@birger-koblitz.de>

On Mon, Feb 23, 2026 at 08:20:35PM +0100, Birger Koblitz wrote:
> The r8152 driver supports the RTL8156, which is a 2.5Gbit Ethernet controller for
> USB 3.0, for which support is added for configuring and displaying the EEE
> advertisement status for 2.5GBit connections.
> 
> The patch also corrects the determination of whether EEE is active to include
> the 2.5GBit connection status and make the determination dependent not on the
> desired speed configuration (tp->speed), but on the actual speed used by
> the controller. For consistency, this is corrected also for the RTL8152/3.
> 
> This was tested on an Edimax EU-4307 V1.0 USB-Ethernet adapter with RTL8156,
> and a SECOMP Value 12.99.1115 USB-C 3.1 Ethernet converter with RTL8153.
> 
> Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
> ---
>  drivers/net/usb/r8152.c | 42 +++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 37 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index 49433301e7b1d5c98fc32c72f821e31335bc3527..0bc3b1b93017c80e1761b00767904ff1c2e6ac87 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c
> @@ -213,6 +213,7 @@
>  #define OCP_EEE_LPABLE		0xa5d2
>  #define OCP_10GBT_CTRL		0xa5d4
>  #define OCP_10GBT_STAT		0xa5d6
> +#define OCP_EEE_LPABLE2		0xa6d0
>  #define OCP_EEE_ADV2		0xa6d4
>  #define OCP_PHY_STATE		0xa708		/* nway state for 8153 */
>  #define OCP_PHY_PATCH_STAT	0xb800
> @@ -954,6 +955,7 @@ struct r8152 {
>  	u16 ocp_base;
>  	u16 speed;
>  	u16 eee_adv;
> +	u16 eee_adv2;
>  	u8 *intr_buff;
>  	u8 version;
>  	u8 duplex;
> ...
> @@ -8953,7 +8962,10 @@ static int r8152_set_eee(struct r8152 *tp, struct ethtool_keee *eee)
>  
>  	tp->eee_en = eee->eee_enabled;
>  	tp->eee_adv = val;
> -
> +	if (tp->support_2500full) {
> +		val = linkmode_to_mii_eee_cap2_t(eee->advertised);
> +		tp->eee_adv2 = val;

eee_adv2 set here is never actually written to the hardware.
ie. you are never doing
ocp_reg_write(tp, OCP_EEE_ADV2, tp->eee_adv2);
for capable NICs.
