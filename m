Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04DE37CD37;
	Wed,  9 Sep 2026 06:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788933796; cv=none; b=MRHsPAGJ+OjkG3FIjkWvsQ2VMaF2QlyrxMAvypEqrXQQb12mjzh0YNhsOahM1to6Jgrcktw01hEsDVj8FEW6wXlWO5S/lMZhyR/pnxUS529jjAVv/qzCyO70lnBu73ZWcXEd8nh4Htx2vinYE0k6Sm+nK8l+gPnMGfGA6jCAl+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788933796; c=relaxed/simple;
	bh=j+6JOQ9ayV+ksPXicfcDXkHTUp2zulV1q0BOuNHWZrc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XuiNc0lZbBAFCw9ZhrYsvCecqg+ckMcquZdYY2DBDVx6jSFC4Fmf1mX6/5+glejmj9bIQ0V3iE2SBrd3GdLooJu2NvR4ZK3cNLRuwVCr6pjTVQ9dnzA8rxB+2YAQboo7DYm3rXPhsyK9xD2cBmefLRxlpqPQzICTnQUHbhdeOdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KzIVASu5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KzIVASu5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E85B31F00A3D;
	Wed,  9 Sep 2026 06:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788933795;
	bh=KqdLnz2otcs/Y+5ddF0p4ES+NmmuXrcQpn82rCBZyf0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KzIVASu5AV75/YC5HuyrDpz5AIWES+zqEVQbWzpy1Q4KeavKCup37uRR+frQr07Z9
	 ZIQtIz4ttytsLtZXo+KXe3xWOX1sPT3cbUvGVUCa24D2FIDWbbJ5ON1JfQwa+QwmrB
	 BOp1Kn/lYihnt3OkyNMxvbDn3h6W7RrODDTyJbgB5U+uPaobAF9N2FjHtwv3ZgCkTc
	 3h4AcGMVNxMPQkQI9maEzqZpqgzjwuSDLsDYHfeHOtqcGJDG9zVNp1jc6UBc+GvP9Q
	 F4+3AyDAv2Bs8TgNzZlRCD5pCK7eMqpXq6evE28DsrcTto0nzkHNciiqP625nQnYj+
	 jo3L7xJ8oXYjQ==
Subject: Re: [PATCH net] net: usb: qmi_wwan: add Quectel RG660QB
From: netdev-bot+sashiko@kernel.org
To: sebastian.sjoholm@gmail.com
Cc: bjorn@mork.no, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 09 Sep 2026 06:03:14 +0000
Message-ID: <178893379449.219967.12448568252331713076@kernel.org>
In-Reply-To: <20260903180044.6179-1-sebastian.sjoholm@gmail.com>
References: <20260903180044.6179-1-sebastian.sjoholm@gmail.com>
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
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 0

- [Medium] Inaccurate commit message / incomplete composite-device
  support: the patch adds only the qmi_wwan match for Quectel RG660QB…

--

net: usb: qmi_wwan: add Quectel RG660QB

This adds a single qmi_wwan match for the Quectel RG660QB 5G module
(2c7c:013d) using QMI_MATCH_FF_FF_FF, i.e. the vendor-specific ff/ff/ff
QMI function only.  The commit message states that the remaining
interfaces of the device are handled by the option driver.

> diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
> index fdfdcf24ddcf8..f51cf9cb9421c 100644
> --- a/drivers/net/usb/qmi_wwan.c
> +++ b/drivers/net/usb/qmi_wwan.c
> @@ -1084,6 +1084,7 @@ static const struct usb_device_id products[] = {
>  	},
>  	{QMI_MATCH_FF_FF_FF(0x2c7c, 0x0122)},	/* Quectel RG650V */
>  	{QMI_MATCH_FF_FF_FF(0x2c7c, 0x0125)},	/* Quectel EC25, EC20 R2.0  Mini PCIe */
> +	{QMI_MATCH_FF_FF_FF(0x2c7c, 0x013d)},	/* Quectel RG660QB */

[Severity: Medium]
The commit message says:

    The remaining interfaces are handled by the option driver.

Is that true for this tree?  Grepping drivers/usb/serial/option.c at this
commit returns no entry for product id 0x013d, and every match in
option_ids[] in the Quectel block is per-product-id, so there is no
vendor-wide wildcard that could pick 2c7c:013d up:

drivers/usb/serial/option.c:option_ids[] {
	...
	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_RG650V, 0xff, 0xff, 0x30) },
	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_RG650V, 0xff, 0, 0) },
	...
}

The sibling modules referenced in the neighbouring qmi_wwan lines carry
that extra pair of option.c rows (RG650V for 0x0122, and 0x0620 for
EM160R-GL), but nothing equivalent is added here for 0x013d.

Since the other functions of the module also use vendor-specific class
0xff, cdc_acm will not claim them either, and qcserial only matches
0x05c6/0x1199.  Does that leave the AT/DM/NMEA/PPP interfaces of the
RG660QB unbound, with no /dev/ttyUSB* nodes appearing?

Should this either come with a companion option.c patch adding the
0x013d entries, or have the sentence about the option driver dropped or
reworded so the commit message matches what the tree actually contains?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260903180044.6179-1-sebastian.sjoholm%40gmail.com
