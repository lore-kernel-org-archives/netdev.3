Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518F247987B
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 23:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790034243; cv=none; b=AVpRKfdi3jH5c0KrcNETZyD1wJt7bF+FiLGCDNtmUtIts6gsOe75j2i5PRfab8XTnu8hpk/h02QKAgSdW034QozdqFiU6+mqhoe8Kea8r07oMpXVWnDuitwgxEZkESOQeNj81SNuNMNAc/MsH7N1i4yheUmVr2z+22QvZFbGD+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790034243; c=relaxed/simple;
	bh=VGdBfqJ6kRfHyO2cf83Y1MyEPKRWXHjuwviLQvOE9uY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UizD+0VVFjqv9wDLUusvzyshurKe2VsbwK5Fygfpefuqf/ui9A8wTp/L28XBsH6LoUsz8RB7QUlzOCQe8UE3hDfMHc4dlg690XBDqBDIwUEGDEZGriXVvKB8BP2C1n/NjZ1f7pplqYWbvd4/Vei4oYp9Fq2rPp/hV9vns4hGp7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JZ9Ckuxm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JZ9Ckuxm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7907D1F00898;
	Mon, 21 Sep 2026 23:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790034237;
	bh=5auJ6Ge+mSJ4TXxp3iLHdiVCBAzVEDyaSUBFIplEEMI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=JZ9CkuxmLnswxR0euVG0E5n7pmFWrQglRXaziSrXhts5DDexdh0T7TMF4GNKmoFJR
	 1L9su5Pny5heRi+aINdoNcZ3cPuJ+uJDHJ8LXw+Oq/yUafoP404ac6QyYbIeVwOQOk
	 b/jqW7iYpfn25JQ1MNx4gXPudFu3a5bWw+Lw2m9Ptxh6qyK3vJcUpRy1DVtglZhSzd
	 JWq9qoFMQZXakG2sIEVF4El5UjSPRNKvt2dEsBTtfTjh+1s0PnSpYLYUYfu4ICUbqN
	 R3lPg89qYkzXVU2JTAcjd99cuejRT13FHqJC8uXCZ70SgrnSN6za87eQcSDL6XrIvZ
	 Ub5twYqSGvNMA==
Subject: Re: [PATCH net v3] tg3: use random MAC address when
 tg3_get_device_address fails
From: netdev-bot+sashiko@kernel.org
To: colona@arista.com
Cc: kuba@kernel.org, michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 netdev@vger.kernel.org, vinc@42.fr, atharvatiwarilinuxdev@gmail.com
Date: Mon, 21 Sep 2026 23:43:57 +0000
Message-ID: <179003423707.2160803.15146112639455736653@kernel.org>
In-Reply-To: <20260917223416.GA245819@visor>
References: <20260917223416.GA245819@visor>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new random-MAC fallback is taken on
  tg3_get_device_address()'s -EINVAL path, which returns *before* the…

--

tg3: use random MAC address when tg3_get_device_address fails

When tg3_get_device_address() cannot find a valid MAC address, the driver
now assigns a random address and continues probing instead of failing.
-EPROBE_DEFER from the address provider is still propagated as a probe
deferral.

Link: https://lore.kernel.org/netdev/20260909191751.651aa5c4@kernel.org/

> diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
> index 73a4b569b03e3..813181590bce9 100644
> --- a/drivers/net/ethernet/broadcom/tg3.c
> +++ b/drivers/net/ethernet/broadcom/tg3.c
> @@ -17914,12 +17914,17 @@ static int tg3_init_one(struct pci_dev *pdev,
>  	}
>  
>  	err = tg3_get_device_address(tp, addr);
> -	if (err) {
> -		dev_err(&pdev->dev,
> -			"Could not obtain valid ethernet address, aborting\n");
> +	if (err == -EPROBE_DEFER) {
> +		dev_err_probe(&pdev->dev, err, "ethernet address provider not ready\n");
>  		goto err_out_apeunmap;
>  	}
> -	eth_hw_addr_set(dev, addr);
> +	if (err) {
> +		dev_warn(&pdev->dev,
> +			 "Could not obtain valid ethernet address, using a random address\n");
> +		eth_hw_addr_random(dev);
> +	} else {
> +		eth_hw_addr_set(dev, addr);
> +	}

[Severity: Medium]
Can this randomize the address on a system that does have a MAC available
through the generic provider infrastructure?

The tail of tg3_get_device_address() looks like this:

	if (!is_valid_ether_addr(addr))
		return -EINVAL;

	if (tg3_is_default_mac_address(addr))
		return device_get_mac_address(&tp->pdev->dev, addr);

	return 0;

So the -EINVAL return happens before the only device_get_mac_address()
call in the driver. If the SRAM mailbox has no 0x484b signature (or
reports the zero address the comment in that function mentions as "Some
old bootcode may report a 0 MAC address in SRAM"), and NVRAM plus
MAC_ADDR_0_HIGH/MAC_ADDR_0_LOW also yield an invalid address, the
function returns -EINVAL and the fwnode "mac-address"/"local-mac-address"/
"address" properties and the nvmem "mac-address" cell are never consulted.

tg3_init_one() then skips the new err == -EPROBE_DEFER test and calls
eth_hw_addr_random(), so the device binds with NET_ADDR_RANDOM and only a
dev_warn, even when device_get_mac_address() would have supplied the real
address - or would have returned -EPROBE_DEFER because the nvmem provider
is not registered yet.

Does the earlier call in tg3_get_device_address() cover that case?

	if (!eth_platform_get_mac_address(&tp->pdev->dev, addr))
		return 0;

eth_platform_get_mac_address() in net/ethernet/eth.c only looks at
dev->of_node and arch_get_platform_mac_address(), and folds every failure
into -ENODEV:

	ret = of_get_mac_address(dev->of_node, mac_addr);
	if (!ret)
		return 0;

	addr = arch_get_platform_mac_address();
	if (!addr)
		return -ENODEV;

while device_get_mac_address() is the one that reaches the non-OF fwnode
properties and the device level nvmem cell:

	if (!fwnode_get_mac_address(dev_fwnode(dev), addr))
		return 0;

	return nvmem_get_mac_address(dev, addr);

Would it make sense to query device_get_mac_address() on the invalid
address path too, before falling back to eth_hw_addr_random(), so that a
firmware supplied MAC and a genuine -EPROBE_DEFER are not lost?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917223416.GA245819%40visor
