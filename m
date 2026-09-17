Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7DD1448E0
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 02:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789610877; cv=none; b=tYPoQwbjlO7ZDYOtKFhE8yj9tmr4+O/uiHhzf8Q48SsicnvAeQ7C91L4klZ+ZeHS5AurqFz3MUd2kjvlM+imR+MphN3q8FHmGlW1CAvfFrl6JiinrOF35iWO0JtvxnFyTp9f89h15EWM0Mjn758vkD8vDktGP9fGSK8QGpO0Pn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789610877; c=relaxed/simple;
	bh=9jLP+tcFz5LgxWIeFGTGMYwnlOBskDvLiLHr1CSFlI8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n4TMVkzdkwAyUXpcoT9ImxiOuosLlIvuHuj3XWOxPAGQevGTA3jxcaYd0fy7AGKMnXkxizyjk7dfvy7mKURx1+n9+WUS3f5u+A5qVhUK/HACVk5Qt0mI61QzudcMVnODFcKxLf5yxEHh4HU+4w//5nDbYowwMxzmsIYDej3jg9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iMx6adQj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iMx6adQj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 967441F000FF;
	Thu, 17 Sep 2026 02:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789610876;
	bh=tcFVg6U7Elocxdk6cJFxSjF/qOLMGtsQs0wFgszuGas=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=iMx6adQjxBmbB2hosa9JGqfhJ03ZlV1FOoSpPuFTaY8IzxRoJxRvZ8IRpsGMj8IFG
	 7JuOKnYDxVCdigwE2ABYmjTRYpIpvvKYAw4PoxKSRUfb7MU0gg4H4en75rGlna3quY
	 f3pgPjJ44LMiP7Nu0HtwBkfE+I/9KjdINhD1IV4WIDbl+LR11335+aXexBNP4TNTr/
	 0BHnkHG+5X/gFAsJSJPhrS2eBAxKlx/B5WBhRbAroZR8fTo79I7C6QCv2DdMGIRowQ
	 xMQbRxQG8l0E2MSHyXJezW5pvAEg/pxDl3bGC66HGZtUn7yoC5JhlyOSa53ysTuA3E
	 LKBkW/uQHyFNg==
Subject: Re: [PATCH net v2] tg3: use random MAC address when
 tg3_get_device_address fails
From: netdev-bot+sashiko@kernel.org
To: colona@arista.com
Cc: kuba@kernel.org, michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 netdev@vger.kernel.org, paul.sage@42.fr, vinc@42.fr,
 atharvatiwarilinuxdev@gmail.com
Date: Thu, 17 Sep 2026 02:07:55 +0000
Message-ID: <178961087513.22033.11361973190889045659@kernel.org>
In-Reply-To: <20260914230521.GA1400582@visor>
References: <20260914230521.GA1400582@visor>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 1

- [Medium] tg3_init_one()
  (drivers/net/ethernet/broadcom/tg3.c:17916-17923) now converts *every*…
- [Low] The recorded commit message of eb360ca620ab contains the inter-
  revision changelog line "v2: assign random address when…

--

tg3: use random MAC address when tg3_get_device_address fails

Instead of failing probe when no valid ethernet address can be obtained,
tg3_init_one() now warns and assigns a random MAC address so the device
still probes on systems where the SRAM placeholder address cannot be
replaced through device_get_mac_address().

Link: https://lore.kernel.org/netdev/20260903233255.GA4109366@visor/t/#u

>     v2: assign random address when tg3_get_device_address fails instead of
>         changing its logic.

[Severity: Low]
This isn't a bug, but should the "v2:" changelog line live below the ---
separator instead of in the commit body?  The worked example in
Documentation/process/maintainer-netdev.rst places the per-version
changelog after the --- marker that follows the Signed-off-by tags, so it
does not end up in git history.

> diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
> index 73a4b569b03e3..75cb0b0fab2fa 100644
> --- a/drivers/net/ethernet/broadcom/tg3.c
> +++ b/drivers/net/ethernet/broadcom/tg3.c
> @@ -17914,12 +17914,13 @@ static int tg3_init_one(struct pci_dev *pdev,
>  	}
>  
>  	err = tg3_get_device_address(tp, addr);
> -	if (err) {
> -		dev_err(&pdev->dev,
> -			"Could not obtain valid ethernet address, aborting\n");
> -		goto err_out_apeunmap;
> +	if (!err) {
> +		eth_hw_addr_set(dev, addr);
> +	} else {
> +		dev_warn(&pdev->dev,
> +			 "Could not obtain valid ethernet address, using a random address\n");
> +		eth_hw_addr_random(dev);
>  	}
> -	eth_hw_addr_set(dev, addr);

[Severity: Medium]
Should -EPROBE_DEFER be handled separately here rather than being turned
into a random address?

In the exact case this patch targets, the SRAM holds the placeholder
address, so tg3_get_device_address() returns whatever
device_get_mac_address() gives back:

drivers/net/ethernet/broadcom/tg3.c:tg3_get_device_address() {
	...
	if (tg3_is_default_mac_address(addr))
		return device_get_mac_address(&tp->pdev->dev, addr);

	return 0;
}

That value can be -EPROBE_DEFER:

net/ethernet/eth.c:device_get_mac_address() {
	if (!fwnode_get_mac_address(dev_fwnode(dev), addr))
		return 0;

	return nvmem_get_mac_address(dev, addr);
}

net/ethernet/eth.c:nvmem_get_mac_address() {
	...
	cell = nvmem_cell_get(dev, "mac-address");
	if (IS_ERR(cell))
		return PTR_ERR(cell);
	...
}

drivers/nvmem/core.c:nvmem_cell_get() {
	...
	if (dev->of_node) { /* try dt first */
		cell = of_nvmem_cell_get(dev->of_node, id);
		if (!IS_ERR(cell) || PTR_ERR(cell) == -EPROBE_DEFER)
			return cell;
	}
	...
}

Before this change the error was propagated out of the PCI probe via
'goto err_out_apeunmap', so the driver core retried once the NVMEM
provider registered and the firmware MAC was picked up.  With the new
else branch, does the deferral get swallowed, leaving the interface
registered with a locally-administered random address that changes on
every boot or module reload, with no later retry?

Would the usual idiom help here, i.e. returning early on -EPROBE_DEFER
before falling back to eth_hw_addr_random()?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260914230521.GA1400582%40visor
