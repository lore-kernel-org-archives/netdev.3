Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE1551AEC1;
	Fri, 18 Sep 2026 18:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789755795; cv=none; b=nuAN7hLKg1mIoeFTNlwx43eujMEfoYThA1dYBtW1jXhkr0XnRcvEX5wiWHJhpI8ZtY8DiHIJLBi4otNXZxi0S9q6STC9PoZbgKmGgohBY1qhtERNQKa2AXTjFcUdhLoGTT09tzAQG2ABGt8jTWEaOiEuP6ymFCcdMB4KPxdtqjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789755795; c=relaxed/simple;
	bh=R4EGLP0NgUZ5EIEjB1r1udzgmhqJirLrudGKIdHuU6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IXsr+/h4fqVvFsxMPzU1WnDYmg0Spl96YKvyfd3hhg4vwg/7VrQNfwjEarKojvXyYg+4tE4x6ikBiJyi4oQelijQyy7f4lEPqSiy8LdBImuyNuj6sDpAlC0IcWQ7L1VlN60aHUWbSMoQ/T49BQRWQ3D9wZ16dW1fCUkM+2oABDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=uBViZE7W; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="uBViZE7W"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 26133168F;
	Fri, 18 Sep 2026 11:23:09 -0700 (PDT)
Received: from [172.18.224.124] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE73A3F86C;
	Fri, 18 Sep 2026 11:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789755792; bh=R4EGLP0NgUZ5EIEjB1r1udzgmhqJirLrudGKIdHuU6A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uBViZE7WYA5IezA8HXvATa7vZqxde4vQR9FDelx+5xM6B1jzQNnpEagcPgtVcXg4o
	 QdPpJQBrzu93qd0jFcZXkH0sWXS7QIh0aXhmB/dNhF/hGUjElDA5Nl2Vq3pCEnZj7l
	 tZGiCBiF0PRTjP35B7KYEyyc3evTy82EGHYUzdmY=
Message-ID: <6b35feab-353c-4802-b47d-08ff6d226eca@arm.com>
Date: Fri, 18 Sep 2026 20:22:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 3/3] net: stmmac: sun8i: add support for
 Allwinner H616 EMAC1
To: James Hilliard <james.hilliard1@gmail.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>,
 Jose Abreu <joabreu@synopsys.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Maxime Ripard <mripard@kernel.org>,
 Alastair D'Silva <alastair@d-silva.org>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com
References: <20260917-submit-h616-emac1-v1-v3-0-62cb8316e19b@gmail.com>
 <20260917-submit-h616-emac1-v1-v3-3-62cb8316e19b@gmail.com>
Content-Language: en-GB
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <20260917-submit-h616-emac1-v1-v3-3-62cb8316e19b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 9/17/26 19:55, James Hilliard wrote:
> The H616 secondary EMAC uses a separate system-control clock register
> and supports only RMII at 10/100 Mbps. It connects internally to the
> co-packaged AC200 or AC300 EPHY and has no external PHY pins.
> 
> Add an EMAC1 variant using the dedicated register and enable only RMII.
> Leave PHY initialization to the PHY driver instead of using the H3
> internal-PHY controls. No RX or TX clock delays are configured for this
> RMII-only variant.
> 
> Co-developed-by: Richard Genoud <richard.genoud@bootlin.com>
> Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Looks good to me, nice and minimal:

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre


> ---
>   drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> index 4523a14f5e0c..1020168f1c3a 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> @@ -81,6 +81,13 @@ static const struct reg_field sun8i_syscon_reg_field = {
>   	.msb = 31,
>   };
>   
> +/* EMAC1 clock register @ 0x34 in the "system control" address range */
> +static const struct reg_field sun8i_syscon_reg_field_emac1 = {
> +	.reg = 0x34,
> +	.lsb = 0,
> +	.msb = 31,
> +};
> +
>   /* EMAC clock register @ 0x164 in the CCU address range */
>   static const struct reg_field sun8i_ccu_reg_field = {
>   	.reg = 0x164,
> @@ -143,6 +150,13 @@ static const struct emac_variant emac_variant_h6 = {
>   	.tx_delay_max = 7,
>   };
>   
> +static const struct emac_variant emac_variant_h616_emac1 = {
> +	.syscon_field = &sun8i_syscon_reg_field_emac1,
> +	/* The co-packaged AC200/AC300 PHY does not use the H3 PHY controls. */
> +	.soc_has_internal_phy = false,
> +	.support_rmii = true,
> +};
> +
>   #define EMAC_BASIC_CTL0 0x00
>   #define EMAC_BASIC_CTL1 0x04
>   #define EMAC_INT_STA    0x08
> @@ -1276,6 +1290,8 @@ static const struct of_device_id sun8i_dwmac_match[] = {
>   		.data = &emac_variant_a64 },
>   	{ .compatible = "allwinner,sun50i-h6-emac",
>   		.data = &emac_variant_h6 },
> +	{ .compatible = "allwinner,sun50i-h616-emac1",
> +		.data = &emac_variant_h616_emac1 },
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(of, sun8i_dwmac_match);
> 

