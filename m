Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EFA2E06EF
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 02:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788921207; cv=none; b=LDU0fc0heTXQtOR2d1QC2S6sI7f5HwZDxB5BLrY9wOQ80Qsb/uwZJ+vxAz0ZpTXl/GdPJBr3BOrEwEU5JgOfovMYdcrvabS4XV7dVAELrr7QMNCm5j8x9qLTTt9peSrky65W5b3Ck5BUGvXZS6rnZtr/7AqQye53PeGChCwq5L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788921207; c=relaxed/simple;
	bh=lhrXvMxCSGq/rE5uNEHfufDBqXhd63SUjB8zYdFHIVU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FAVPPWd+NGF5Scrr96212ewEzKhy/vEvrLahK9oekbWGVFSlGXobg01BG7C6OKRtGpGjx52TJJHcTsdP4jFAQtYMYRKpZSav7LLK3/PP6pDOPxlCihqJHWLeROuz7m5D5p0gkkIMXNR3OD+KmMdekvyNXB6tE1cZadd5b2ZGR4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AciyzCpG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AciyzCpG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88E241F00A3A;
	Wed,  9 Sep 2026 02:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788921205;
	bh=gSQ9qbzpAMWUPIlAftKLpCMjz2pDPFD9VyMQu3iSrAA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=AciyzCpGofgyz803QdkrnVM322ZLhvD8/FM6mF626c+T+MZAhwfV8RGjmU6GzhukK
	 jZl5sxYFjkpwl+xRjcayny9tnH4znMBAihjy2jWPhFc98T8lLan01rOXSRLFmTjb5x
	 Ano+Kp1JorXu2CaZ1wnIPgQ7ddp1qYAq1WYGhmkyiPdigZPjVY6/DjehZwSYiHozXJ
	 1dKHgV3mcIWvLVkO1YrgqxnW3Hs63+RjnNplvqSfbmdlOKW+7TmM5i7wf5KCr5Uwtp
	 f5KT8DtuvKGVkDJ+4ktp5G4Y3OeuPk6BvwzHNCW7lhdHMx9bDdUUnFDxCjaQKWH3Tl
	 nDNUibhysr0pg==
Subject: Re: [PATCH net] tg3: check NVRAM and control register if SRAM has the
 placeholder MAC address
From: netdev-bot+sashiko@kernel.org
To: colona@arista.com
Cc: kuba@kernel.org, michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 netdev@vger.kernel.org, paul.sage@42.fr, vinc@42.fr,
 atharvatiwarilinuxdev@gmail.com
Date: Wed, 09 Sep 2026 02:33:25 +0000
Message-ID: <178892120510.219967.1246975569411905126@kernel.org>
In-Reply-To: <20260903233255.GA4109366@visor>
References: <20260903233255.GA4109366@visor>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 0 · Low: 0

- [High] In tg3_get_device_address()
  (drivers/net/ethernet/broadcom/tg3.c), clearing addr_ok when the SRAM…

--

tg3: check NVRAM and control register if SRAM has the placeholder MAC address

This adds the placeholder address check to the addr_ok expression in
tg3_get_device_address(), so a BCM57762 reporting 00:10:18:00:00:00 in the
SRAM mailbox falls through to the NVRAM and MAC control register sources
instead of failing probe.

> diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
> index 73a4b569b03e3..0b47908f09355 100644
> --- a/drivers/net/ethernet/broadcom/tg3.c
> +++ b/drivers/net/ethernet/broadcom/tg3.c
> @@ -17081,7 +17081,8 @@ static int tg3_get_device_address(struct tg3 *tp, u8 *addr)
>  		addr[5] = (lo >>  0) & 0xff;
>  
>  		/* Some old bootcode may report a 0 MAC address in SRAM */
> -		addr_ok = is_valid_ether_addr(addr);
> +		addr_ok = is_valid_ether_addr(addr) &&
> +			  !tg3_is_default_mac_address(addr);
>  	}
>  	if (!addr_ok) {
>  		__be32 be_hi, be_lo;

[Severity: High]
Does clearing addr_ok for the placeholder address remove the only way to
reach the device_get_mac_address() fallback added by e4c00ba7274b?

Once addr_ok is 0, the block that follows rewrites all six bytes of addr
from NVRAM or from MAC_ADDR_0_{HIGH,LOW}, so the placeholder value no
longer survives to the tail of tg3_get_device_address():

drivers/net/ethernet/broadcom/tg3.c:tg3_get_device_address() {
	...
	if (!is_valid_ether_addr(addr))
		return -EINVAL;

	if (tg3_is_default_mac_address(addr))
		return device_get_mac_address(&tp->pdev->dev, addr);
	...
}

If the NVRAM words at mac_offset or the MAC control registers read as
0xffffffff (erased flash, ff:ff:ff:ff:ff:ff is multicast) or as zeros, the
is_valid_ether_addr() test returns -EINVAL before the
device_get_mac_address() call is reached.  Would that not move the probe
failure from the placeholder path to the NVRAM/register path, on the same
systems (iMac 20,1 / BCM57766) where the fwnode property is currently the
working source?

And when the NVRAM or register value is valid but stale, is the firmware
property still consulted at all?  It looks like the hardware source now
wins over the property, which inverts the priority e4c00ba7274b set up for
the placeholder-in-SRAM case.

Note eth_platform_get_mac_address() earlier in the same function does not
cover that platform class either, since net/ethernet/eth.c only consults
dev->of_node via of_get_mac_address() and arch_get_platform_mac_address(),
not dev_fwnode()/ACPI.

Would it work to read each fallback source into a scratch buffer, reject
content that is invalid or equal to the placeholder, and keep
device_get_mac_address() as the last resort, for example by testing

	if (!is_valid_ether_addr(addr) || tg3_is_default_mac_address(addr))
		return device_get_mac_address(&tp->pdev->dev, addr);

instead of returning -EINVAL first?

A related question about the fallback block itself: tg3_nvram_read_be32()
returns 0 for any successfully executed read command regardless of the
content read, so unprogrammed NVRAM (0x00.. or 0xff..) is copied into addr
and also suppresses the MAC_ADDR_0_{HIGH,LOW} branch that may still hold
the bootcode-programmed address.  Should the NVRAM content be validated
before that branch is skipped?

Lastly, could the commit message mention that the device property fallback
is being narrowed by this change?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260903233255.GA4109366%40visor
