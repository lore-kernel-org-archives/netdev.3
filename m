Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAD22DECBF
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 13:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784898281; cv=none; b=Q4cYhNL75mll0tUE/JAJ/KoyiTVQUalZZRnDqZDocUSM28zSjc6AF2HXAaDGya0uCEJzQwsn7XeK92fbt0N5q0IGhVOY23GgJGkzypcPrbCPKQRrqmmMIlA0gba2Fh2BgIN6KWxSAPOulvN6q3/AJPjr3w+bor1Snr8hLvuo900=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784898281; c=relaxed/simple;
	bh=2umajvbhajfJHtqP50OvfkaVtnrWvS/GJS1JNgL/gy0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MRUQZ+tPXNkLzQZm0gvf36Ywg5xMSuUUI6dYSaeVpjW4E3zKgCW/GBzsveZ7VnnRz6J2LSqCBouFPPVWjacRUulHUTaV70Tbpju9Wrsc+onJEBHc6qtye+XSblZMfBMU8mXw/t0kLE2w2CSRSrIYaLO6HvHPLaJ4q8SGn8OWv7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HJo4JH4n; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HJo4JH4n"
Message-ID: <c597273c-4fc7-4d3c-8886-6f8be5dc72f9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784898276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a6jTiAk5PpfG/pfDy1T0fjrEXPY3y58y008DCXKo98k=;
	b=HJo4JH4nYCH2K7sh747jWEs9uO/1aU/anywdoTmmoOBKGj0v0BvHJcCqv24iXCrT4AEgoF
	dN+yR3rYxax4inCd0lYlanr0CowWZxPsDCygTAz7b+/taUa49+/X/LvIN3R1vhNzdINtrA
	Q8Wwd1ggZ2sm2wuOu+OqKsVGzMmT1m0=
Date: Fri, 24 Jul 2026 14:04:34 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] net: ethernet: ax88796: initialize all fields of
 eeprom_93cx6 struct
To: stf_xl@wp.pl, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
References: <20260724083411.8562-1-stf_xl@wp.pl>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260724083411.8562-1-stf_xl@wp.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 24/07/2026 09:34, stf_xl@wp.pl wrote:
> From: Stanislaw Gruszka <stf_xl@wp.pl>
> 
> Commit 7738a7ab9d12 ("misc: eeprom: eeprom_93cx6: Add quirk for extra
> read clock cycle") added extra 'quirk' field to struct eeprom_93cx6,
> which change how the data is read.
> 
> Some existing users of eeprom_93cx6, including ax88796 driver, allocate
> the structure on the stack without initialization of all the fields.
> As a result, the added quirk field has undefined value, what can
> randomly cause reading wrong data from the EEPROM.
> 
> Fix by using designated initialization.
> 
> Fixes: 7738a7ab9d12 ("misc: eeprom: eeprom_93cx6: Add quirk for extra read clock cycle")
> Cc: stable@kernel.org # v6.13+
> Signed-off-by: Stanislaw Gruszka <stf_xl@wp.pl>
> ---
>   drivers/net/ethernet/8390/ax88796.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/8390/ax88796.c b/drivers/net/ethernet/8390/ax88796.c
> index e1695d0fbd8b..5ee1fbafdcfc 100644
> --- a/drivers/net/ethernet/8390/ax88796.c
> +++ b/drivers/net/ethernet/8390/ax88796.c
> @@ -722,12 +722,12 @@ static int ax_init_dev(struct net_device *dev)
>   #ifdef CONFIG_AX88796_93CX6
>   	if (ax->plat->flags & AXFLG_HAS_93CX6) {
>   		unsigned char mac_addr[ETH_ALEN];
> -		struct eeprom_93cx6 eeprom;
> -
> -		eeprom.data = ei_local;
> -		eeprom.register_read = ax_eeprom_register_read;
> -		eeprom.register_write = ax_eeprom_register_write;
> -		eeprom.width = PCI_EEPROM_WIDTH_93C56;
> +		struct eeprom_93cx6 eeprom = {
> +			.data = ei_local,
> +			.register_read = ax_eeprom_register_read,
> +			.register_write = ax_eeprom_register_write,
> +			.width = PCI_EEPROM_WIDTH_93C56,
> +		};
>   
>   		eeprom_93cx6_multiread(&eeprom, 0,
>   				       (__le16 __force *)mac_addr,

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
