Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D78242589C;
	Thu, 24 Sep 2026 07:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790234066; cv=none; b=gg0rvLaUtNNNsV36024ll5RudwO0oXv01b4dpsJ5SUlzUlwxcG5S6VgZJafkwm2/5qiWljtvnsdTpyGgswMNIZxksTCbZCOnsxckR4DdOM+fdcf18TR+ofJ1sbpFGMvpkFL5/o7thFb6hEDwIA66Z2eh+T/25OcREhwBGFfe/Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790234066; c=relaxed/simple;
	bh=f8sCwf+Is/R9HbBxAaH8/zW1TrvDfyMSRoaBAAoaBhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fnNKrQEX8J4nJHvy5eeU3PMfzcdrS/EKnJp5Tr/1V2QAPJGEPI6Zgk6VwbSrHpnGcuCeQUP8odvNOE19ri8xc81Z8Q/bykLIZIj0QcDTY1LQ0MqXso6X98RC6dceq1P1MeB8adNbgBj90TZgWBicUTFta2YnWME5VlgPXHZSBno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net; spf=pass smtp.mailfrom=marmottus.net; dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b=Sfs3zKSa; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marmottus.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b="Sfs3zKSa"
Received: by mail.gandi.net (Postfix) with ESMTPSA id B63103F0AB;
	Thu, 24 Sep 2026 07:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marmottus.net;
	s=gm1; t=1790234056; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9fJ3LmMTgl5ooa3A8qiDWthkRa7eakjePx2Q6mdnXeY=;
	b=Sfs3zKSaZZj0K0kTpYrRVDmeeW0W9WEZw87qKKuK4PdadQ7xoiwQ0Jsc5EtjeeaRGMSFj0
	I+K6ymCA1dJy4q58ybHPzg+WmMPzvXUL8GD3CP1vYlil5/S6QG5Yir+Nd6c15WzsG8AX3K
	4FYwWEVan+cn7ensc/c3h0ktXyHAhixleBTNJpeKmueBt/MrguJm93+dC9Ue4BDk+tRh0V
	xq++KWwE8yOaSgMplXF7MvoWboAacrQdxxWaIHhTFB8Nt0oERl3BkqrBRNeySEnqshF39D
	b3jh8HkXzpxrTGxi8quaMqCR6/iWRYlEd5oWhFl9zs/jZc3OpDaJ2sRqCawkNA==
Date: Thu, 24 Sep 2026 09:14:11 +0200
From: Arthur Crepin Leblond <arthur@marmottus.net>
To: netdev-bot+sashiko@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, arnd@arndb.de,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v10 2/3] dt-bindings: net: wiznet,w5100: add
 link status interrupt
Message-ID: <20260924071411.GA21468@marmottus.net>
Reply-To: arthur@marmottus.net
References: <20260921-wiznet-link-gpio-v10-2-5874a7a147a2@marmottus.net>
 <179021495463.2160803.46310334870833128@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179021495463.2160803.46310334870833128@kernel.org>
X-GND-Sasl: arthur@marmottus.net
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: dmFkZTEb2Erd0INHoVhtF+GeJfrW4H/dz0p2A5Z0hMw06lXj2jf+KUqKvxDdzCx24kigi802336LLAtDXTskONTmzc4eX+qeDTwobmEPlEiAd7MRU82fbfz+aN0UQY2c8cc1hh4Y9Bq+eqEQcsPdP0Jd2ZmxkZke7+D//KNpCR1JZg0hULhJaC8DUD25ty6Wz9Hn+awmyYb+Yvb3MQ6kffChwGHX3dxmb5yibLBrukK5kwDpj0XdCad13BQA3Gd5lQNNQPm3CfmRUr+6ZLdm3nIkiQqeLW5xKYoFoPA0kcIY/sg51/GV1Knm+PJ2EwPsMcCTDHpMmK+l/n7+X6CrBpEfjE37Jdx+JZq4zXb5577PjulqzwGEXGlYX3qscrN6bBuLbgfDtpOoduDhNba3ZwKaPibra2euuh3Gu4iBfvZ/7rG1B44jik1/PrrxvqIFpaz1fcySHykr0T1AW+6s6cx5ij8VnhGyHrbndpAntSVvbr93cYQ/m4ZEFXS8jmkiYBM/lB5TM7MLPTdH4Dj1wd2KKdxH9RvXIaksjcCcx6t2XjqErfqgK6S4tdOs1CeMA7SmEm5uyybH9KEiwtr1E8iEuYCetMvynwyt1LPysNTCmtOnt+yIAw346yGUYT4OB3Ht6UFMPnlwmBnDsYGls6RQ2C+KY96c5ZdIjL4FGCxgki5iXg

On Thu, Sep 24, 2026 at 01:55:54AM +0000, netdev-bot+sashiko@kernel.org wrote:
>Thank you for your contribution! Sashiko AI review found more severe
>issue(s) in other patches of this series. This mail is only an FYI, in case
>you want to address the nit picks below when you respin.
>
>Low priority / nit picks for your consideration:
>
>- [Low] Concern (INVALIDATED by later patch in this series): the binding
>  documents an optional second, LINKLED interrupt for wiznet,w5500 and…
>
>--
>
>dt-bindings: net: wiznet,w5100: add link status interrupt
>
>This adds an optional second interrupt to the wiznet,w5100 binding for the
>LINKLED pin, described as being supported only on wiznet,w5500.  The
>interrupts property is moved to a two-item list with an allOf conditional
>restricting non-w5500 compatibles to a single interrupt, and the example is
>updated to list both interrupts.
>
>> diff --git a/Documentation/devicetree/bindings/net/wiznet,w5100.yaml b/Documentation/devicetree/bindings/net/wiznet,w5100.yaml
>> index 25098308eb6e5..ac2ee725af5d5 100644
>> --- a/Documentation/devicetree/bindings/net/wiznet,w5100.yaml
>> +++ b/Documentation/devicetree/bindings/net/wiznet,w5100.yaml
>
>[ ... ]
>
>> @@ -24,8 +20,16 @@ properties:
>>        - wiznet,w5500
>>
>>    interrupts:
>> -    maxItems: 1
>> -    description: Main interrupt (INT pin on the device).
>> +    minItems: 1
>> +    description:
>> +      The main interrupt (INT pin) is mandatory on all devices. The w5500
>> +      additionally supports an optional second interrupt for link status changes
>> +      (LINKLED pin). If it is not specified, link state changes will not be
>> +      reported.
>> +    items:
>> +      - description: Main interrupt (INT pin on the device).
>> +      - description:
>> +          Optional interrupt for link status changes (LINKLED pin on w5500).
>
>[Severity: Low]
>At this point in the series, is there anything that consumes the second
>interrupt?  The description promises that link state changes are reported
>when the LINKLED interrupt is present, but w5100_probe() in
>drivers/net/ethernet/wiznet/w5100.c only uses spi->irq (interrupt index 0)
>and there is no netif_carrier_on() call in the driver yet.
>
>For the record, this resolves later in the same series: the final patch
>("w5100: detect carrier state using link status bit and optional
>interrupt") adds
>
>	priv->link_irq = -EINVAL;
>	if (ops->chip_id == W5500) {
>		priv->link_irq = fwnode_irq_get(dev_fwnode(dev), 1);
>
>and w5500_report_carrier_state() which calls
>netif_carrier_on()/netif_carrier_off().  So the documentation and the
>implementation only disagree between this patch and that one, which is
>nothing more than a transient bisect-window mismatch.
>
>[ ... ]
>

https://elixir.bootlin.com/linux/v7.2/source/Documentation/devicetree/bindings/submitting-patches.rst#L54

   The Documentation/ portion of the patch should come in the series before
   the code implementing the binding.

Arthur
