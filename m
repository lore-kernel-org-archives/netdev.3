Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352FE265620;
	Sat,  5 Sep 2026 01:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788571695; cv=none; b=AQ4U2lMrL2bTlzDGULo5bmxBFLkuFOxI8XD4qVlRTAhf5uaMhgSV1wWpaY387n/eeeQIdArEP9JFHVOQBD9HobeW3yIeoOC4U9KMb49AW1STlSSd3vET4IEfT5kX1ZPzbDVS6hAv5TLJecqz6wEtpA7kgEEYL/lVeSaSFhgwSRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788571695; c=relaxed/simple;
	bh=HMqTbzhWXi1aaYS/kfffuc65W/OnmgVDxpUWb8Dx4X0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Et0bfUUfYBIgJO72XSJZqIhSYtRlLJqmC3JqsLjuFkCjiL06qTGRX/W6dYS0XQwklYVoKzdPmMw8JwAkxh2nBN6ubUp6aeI4p2BZaa0T3QrWHwC/EBUykQRcBXpnAI+/CmyFTAude5OIoabzIoBSnUowNvQae1LhdSHTp0ZARCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mtIw9IpU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mtIw9IpU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E7F51F00A3D;
	Sat,  5 Sep 2026 01:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788571693;
	bh=emY1DrxijBXUwu7kJrge9yaXupXiqZ/OuYA+3UEF0mU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mtIw9IpUQNAKs7xjp9hyayRgnL05Gqwb9A0ppUn7YVlpaczsvclZXB5ln6dVsRGjF
	 XXKloAu3OayH3jJe0uoqUP+ETMSvPrRURWWOj7TMufJOamuE//7d0UMTISNVxusMhK
	 1KsB0VezNYkzXFv2tA7EYBeiwFJ/B23N5y3CBb4pIqs+wYWVcNmy7Gb1DMkSV3i3+O
	 YrXodCf2xH8eKg+D9hEgtnp3Z2sdJN/NAfAntGGSCqdb91BBfirGXYyN4rH7zWmp9N
	 31nWnmmRFGqh+uaNFxrPI/OGGT2HpSvKKVsWClkGinaGB6VcoOoVLLl6EzCvBDOR+x
	 bEv9TmZlS5c3g==
Date: Fri, 4 Sep 2026 18:28:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Marek Vasut <marex@nabladev.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, andrew+netdev@lunn.ch,
 edumazet@google.com, pabeni@redhat.com, bigeasy@linutronix.de,
 yiconghui@gmail.com, kernel@dh-electronics.com,
 linux-kernel@vger.kernel.org
Subject: Re: [net,PATCH v1] net: ks8851: Fix receiver error in 100BASE-TX
 mode following software power-down
Message-ID: <20260904182812.303b91c0@kernel.org>
In-Reply-To: <f7149e71-2c32-4f53-86c9-d1c586218fc2@nabladev.com>
References: <20260901173925.96183-1-marex@nabladev.com>
	<20260904003712.3484001-1-kuba@kernel.org>
	<f7149e71-2c32-4f53-86c9-d1c586218fc2@nabladev.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 5 Sep 2026 03:16:12 +0200 Marek Vasut wrote:
> On 9/4/26 2:37 AM, Jakub Kicinski wrote:
> > This is an AI-generated review of your patch.  
> 
> Sigh, a wall of generated text.

I'd feel bad if most of the patches I have to suffer thru
these days weren't entirely YOLO'ed slop where every lines comes 
with a 15 line comment :/ (not speaking about your patch, just
a general vent)

> >> @@ -506,8 +503,6 @@ static int ks8851_net_stop(struct net_device *dev)
> >>   	/* shutdown TX process */
> >>   	ks8851_wrreg16(ks, KS_TXCR, 0x0000);
> >>   
> >> -	/* set powermode to soft power down to save power */
> >> -	ks8851_set_powermode(ks, PMECR_PM_SOFTDOWN);
> >>   	ks8851_unlock(ks);  
> > 
> > [Severity: Low]
> > Related to the above: the kernel-doc for ks8851_net_stop() just above this
> > function still promises the low power transition that is being removed here:
> > 
> > 	/**
> > 	 * ks8851_net_stop - close network device
> > 	 * @dev: The device being closed.
> > 	 *
> > 	 * Called to close down a network device which has been active. Cancel any
                                                vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
> > 	 * work, shutdown the RX and TX process and then place the chip into a low
           vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvXXXX^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > 	 * power state whilst it is not being used.\
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > 	 */
> > 
> > The post-patch body only masks IER/ISR, zeroes RXCR1/TXCR, drains ks->txq
> > and calls free_irq(), with no PMECR access left. Should that last sentence
> > be dropped or reworded to mention the errata, so readers of
> > ks8851_suspend()->ks8851_net_stop() are not told a low power transition
> > happens?  
> 
> What exactly should I adjust in V2 ?

Drop the part of the sentence in the ks8851_net_stop() kdoc that says
we'll put the device in low power mode?
