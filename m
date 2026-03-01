Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BF2175A89;
	Sun,  1 Mar 2026 18:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772388761; cv=none; b=oV9F8vSEsc5qP0Wf3eThxJQsCuKOzq6V4OIpwt5jhCh02C20FZNQRjZR85nmqhx7+fPmkH/Q8HEikQMhlrgkIINYYkssWlHvugIx37Zz6HVEX3q3WKNbapiwvdhavAnGw7C5j/zPAmcJzO/hwRhnKrdTGIhUGcWkk6x2Izyr0mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772388761; c=relaxed/simple;
	bh=2tBYxDnTTDmwYplUfxuZm8q55vkRHX1ktadnQoNR0rQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CF8x1k5lZiW/Fzgwndjar2D/JJyNDtYYOhSJaUh9AeobreOY1zQ9TlKVdLFrBt00vyP3lKDB1+hLG/PY3xmZQOpLLT2ZqyU9NTTV8VkUtrCo7TDEBVybJyobzsmAXpCEL2rtHmlkbFvjvVmVVhUUGmdEd8HPaVWp+WahM7SojGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bEMndagJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bEMndagJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D20A8C116C6;
	Sun,  1 Mar 2026 18:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772388761;
	bh=2tBYxDnTTDmwYplUfxuZm8q55vkRHX1ktadnQoNR0rQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bEMndagJnw30yQE+6GEDfRZo6V64zCPvYR6jfCNLWmxRqLfBWlrQhzu1QVZVoOPb/
	 Ddvcdhs9LVG1JSilSt0TYdu6UVJj7lX+nm65zYRwKnNdKL0A1AMIyQiLa0dgLXU4VE
	 XhsDLjsDlQYrkYKVw0fOW+ojc+aE5tNbS93bZXDvIxYgOmSNClDOrSoJyk11oSsFgR
	 zD87GosuvuycJ6n4lUYNeoXgnxVBkMd4YnXJ1TSOfQpytje26ch8QmxzHdhAto+Dnj
	 fJ3emgzcGlTLPn3SjTH9ai16xRuLTbSmBtfRsiwg+ekJiFajw5MieEGQSeFVrx01/h
	 KHr32JdamrivA==
Date: Sun, 1 Mar 2026 18:12:33 +0000
From: Simon Horman <horms@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: netdev@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>,
	Valentina.FernandezAlanis@microchip.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Richard Cochran <richardcochran@gmail.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Neil Armstrong <narmstrong@baylibre.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	Vineeth Karumanchi <vineeth.karumanchi@amd.com>,
	Abin Joseph <abin.joseph@amd.com>,
	=?utf-8?B?VGjDqW8=?= Lebrun <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net-next v2 5/8] net: macb: timer adjust mode is not
 supported
Message-ID: <aaSBkVkhNTbQHkmI@horms.kernel.org>
References: <20260226-snowshoe-amusable-6716d4ddea11@spud>
 <20260226-dollop-maturing-9e3c83192ee5@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226-dollop-maturing-9e3c83192ee5@spud>

On Thu, Feb 26, 2026 at 11:03:20AM +0000, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> The ptp portion of this driver controls the tsu's timer using the
> controls for "increment mode", which is not compatible with the hardware
> trying to control it via the gem_tsu_inc_ctrl and gem_tsu_ms inputs in
> "timer adjust mode". Abort probe if the property signalling that the
> relevant signals have been wired up is present.
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  drivers/net/ethernet/cadence/macb_main.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index ddbb0c327b303..fa55e6e7036f2 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -5535,6 +5535,12 @@ static int macb_probe(struct platform_device *pdev)
>  
>  	bp->usrio = macb_config->usrio;
>  
> +	if (of_property_read_bool(bp->pdev->dev.of_node, "cdns,timer-adjust") &&
> +			IS_ENABLED(CONFIG_MACB_USE_HWSTAMP)) {
> +		dev_err(&pdev->dev, "Timer adjust mode is not supported\n");

Hi Conor,

Assuming this is an error condition I think that err should
be set to an negative error value here. Else the function will return 0.

Flagged by Smatch.

> +		goto err_out_free_netdev;
> +	}
> +
>  	/* By default we set to partial store and forward mode for zynqmp.
>  	 * Disable if not set in devicetree.
>  	 */
> -- 
> 2.51.0
> 
> 
