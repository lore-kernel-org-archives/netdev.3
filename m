Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D303334750F;
	Tue, 25 Aug 2026 10:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787653938; cv=none; b=La4Q7FtnggYAsB2CTf/lkIHGaGhsyilAFT8C0EpCcCVdF4kKpjlmOkFtvLrf2J/Dv8MpUreFgC/Qp1hdAGKKP0K5QNGYXsP66Ma+xnHI1JwkzJ0iKm58hw7qqCLmvF1Xz3rHYh/daTCemtghG7H97QmGOl1j7gt2Z06D3434i/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787653938; c=relaxed/simple;
	bh=Tsxi2Q13JLZntOlrs0aLxbld635jIPf+JkdjCgc9bSI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fFPWYxGF+RN+vGdbVR5i6G68awqxhUPDPvl5Pot1TkaTtGnmieCfS8cf3SJp1RncwYjOHQeJpwQ/uuW5jp/8dyIQ98czYQI2gYu6suflBDLRfDe4Xrd2/VTo8nzh1Mc5S70F41fbnSakiyH/8N1Q3NPhGVG1mTig14Hrb0GPRUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=QOv1dLDf; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="QOv1dLDf"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A3F71BF7;
	Tue, 25 Aug 2026 03:32:11 -0700 (PDT)
Received: from [10.1.31.148] (e142021.arm.com [10.1.31.148])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E6B313F7D8;
	Tue, 25 Aug 2026 03:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787653935; bh=Tsxi2Q13JLZntOlrs0aLxbld635jIPf+JkdjCgc9bSI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QOv1dLDfG0UNmyJ2VQE0AaDZv92EGE1qm9y4Pu6MsK7wVPVj1aCwzqS/FNSWwCgWW
	 WfzFzRkRshkDtapxyPO9JsOUefIZmjasDM3mxAeWKtnRaFM9wzM+mGWdRNPPi0BC4P
	 mSdooJGvXr2GnbdxqCZIpzQ8fHkAPqy+i8N6HvRk=
Message-ID: <95b5fee4-70e8-4b2d-96fa-bce267ff13f5@arm.com>
Date: Tue, 25 Aug 2026 11:32:11 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ethernet: sun4i-emac: Fix IRQ error handling
To: phucduc.bui@gmail.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Samuel Holland <samuel@sholland.org>, Linus Walleij <linusw@kernel.org>,
 Kees Cook <kees@kernel.org>,
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
 Arnd Bergmann <arnd@arndb.de>, Stefan Roese <sr@denx.de>,
 Maxime Ripard <mripard@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <20260824100901.31675-1-phucduc.bui@gmail.com>
Content-Language: en-GB
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <20260824100901.31675-1-phucduc.bui@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 8/24/26 12:09, phucduc.bui@gmail.com wrote:
> From: bui duc phuc <phucduc.bui@gmail.com>
> 
> irq_of_parse_and_map() returns 0 when parsing or mapping an IRQ fails.
> The current code checks for -ENXIO and therefore does not detect the
> failure.
> 
> Check for a zero return value and convert it to -ENXIO.

Yes, the return value is the IRQ number, or 0 in case of a missing IRQ.

> Fixes: 492205050d77 ("net: Add EMAC ethernet driver found on Allwinner A10 SoC's")
> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Thanks,
Andre

> ---
>   drivers/net/ethernet/allwinner/sun4i-emac.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/allwinner/sun4i-emac.c b/drivers/net/ethernet/allwinner/sun4i-emac.c
> index 42174249ef61..942454e29488 100644
> --- a/drivers/net/ethernet/allwinner/sun4i-emac.c
> +++ b/drivers/net/ethernet/allwinner/sun4i-emac.c
> @@ -996,9 +996,9 @@ static int emac_probe(struct platform_device *pdev)
>   	/* fill in parameters for net-dev structure */
>   	ndev->base_addr = (unsigned long)db->membase;
>   	ndev->irq = irq_of_parse_and_map(np, 0);
> -	if (ndev->irq == -ENXIO) {
> +	if (!ndev->irq) {
>   		netdev_err(ndev, "No irq resource\n");
> -		ret = ndev->irq;
> +		ret = -ENXIO;
>   		goto out_iounmap;
>   	}
>   

