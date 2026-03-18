Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C622F354AC0
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 11:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773833175; cv=none; b=rJcjidCvFwKiLfArYCoDF0xlhoPY3bGBAsPXGNmatoTWA5FhPVyqB393875vQD1MhOpcDA2sT2BQ+gvYkBBesfy0hkfWV4+b5SuKNcdxf/h9DkJz3Am0t5BCId0TsjslxrnbfC4KHWOQjlRfOHk7m+iUGhhHQv3h94ga2qxapW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773833175; c=relaxed/simple;
	bh=H1GaUTZ7PoAPJxbjHZ3pQ3WngVkqVjTyPMUKNKCKUqY=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Gqs4/fPcSkvTQ5DygWycFC1XMRP4j6y7T/0/3wJs8u5XNDa0gHdVZGWH7BJkLar8LGiIoOSd3GiJNJpI9O+xU0DTTczcI5AeMl+kvI8GPzM3UPVa5AslIzMA5nDYmTg6zxZCLK9Nl+/kgyZU1YgZuraY9SirtuXjlL6ICCM+KYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=K9kxYkS1; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="K9kxYkS1"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AA04DA47AF;
	Wed, 18 Mar 2026 12:25:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1773833163; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=uiXZLI/r51Z0R/qzZ22LeeOwsCar/krz4M7OipyTRIQ=;
	b=K9kxYkS1HmdnADGjlL29XB1iBlb3RsTD9KMdEymVvtNgScptONJ4eHPGvtV6VwXdddUa4H
	L7ex4mmyZD3RB7FHKhQCh3hoFs8AJRyF5/UG2R6qT/O7jO0/azKX9yAzgkXUWgvnHJUnKq
	2RsNkzOTwVK1LUAsObXngdb85qZR/5hXG7Q8o0m6JEtmwVgXd3rAdagmvDe4FkXruW7/VD
	Oh0dqIwSnerq6TeRDpV1Qn98fSZCH7ntgcXokaXsU2HFD6MkeVw5wr1uH3vqovimN3Owz4
	0AZXIWHT4XURjX+h1NSkSkJE0ezL4ysjTHKCvlFcK5UotQdqcCLj8sUnHnS2Hw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 18 Mar 2026 12:25:58 +0100
From: Nicolai Buchwitz <nb@tipi-net.de>
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Cc: Jakub Kicinski <kuba@kernel.org>, nicolas.ferre@microchip.com,
 claudiu.beznea@tuxon.dev, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: macb: allow MTU changes while the interface
 is running
In-Reply-To: <DH5TETVK34CG.V7P9P9Z1AAKL@bootlin.com>
References: <20260316092720.39198-1-nb@tipi-net.de>
 <DH57URLYG3TU.B4HGNJATLFMU@bootlin.com> <20260317152330.32998fdd@kernel.org>
 <1aae7cf5906c753c0ff5356b8e1f53e2@tipi-net.de>
 <20260317162303.4065e307@kernel.org> <DH5TETVK34CG.V7P9P9Z1AAKL@bootlin.com>
Message-ID: <46380e79a62bfca31a551cfd872e34ab@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

On 18.3.2026 10:53, Théo Lebrun wrote:
> [...]

>> 
>> Hm, not really. Take a look at fbnic_set_ringparam()
>> You need some struct that's config + pointers to all the resources.
>> And make all allocation helpers operate on that without touching the 
>> HW.
>> Then you can just allocate a new struct, give it whatever config you
>> need, call all the alloc helpers with it. Now you have a fully
>> populated struct and haven't touched the HW yet at all. Stop HW,
>> swap the resources, start HW.
>> 
>> I did something similar for the nfp driver but that code has been
>> slightly adulterated since I left Netronome so fbnic is clearer :)
> 
> Do you feel we should (1) clone the full `struct macb` as done by fbnic
> or, (2) just partially, with the few interesting fields. Something like
> `struct stmmac_dma_conf`.
> 
> stmmac is not the greatest example. They have this struct that carries
> their buffers but they still "close -> update -> open" on operations
> versus the optimal "alloc -> reconfigure_hw -> free".
> 
> With #2 we could use an unnamed structure field.
> https://gcc.gnu.org/onlinedocs/gcc/Unnamed-Fields.html
> See commit c4781dc3d1cf ("Kbuild: enable -fms-extensions").
> 
> struct macb_buffers {
> 	struct macb_queue queues[N];
> 	...
> };
> 
> struct macb {
> 	struct macb_buffers;
> 	...
> };
> 
> Goal is to keep `bp->queues` & co as before, to minimise the diff.

The unnamed struct idea is nice for keeping the diff small, but I'm not
sure it works cleanly for the per-queue case. The macb_queue_ring fields
would be embedded anonymously in macb_queue, but the alloc helpers need
to write into a separate clone. The swap then becomes memcpy/cast tricks
between the anonymous portion of each queue and the clone's qring[q].

Embedding the full queues[] array in the swappable struct would be
simpler for the swap, but then NAPI, IRQs, spinlocks etc. travel
along, which we don't want.

For struct macb itself (rx_buffer_size, ring sizes, tieoff) the unnamed
struct works fine and saves a lot of churn. It's really the per-queue
ring fields where it gets awkward.

> 
> Thanks,
> 
> --
> Théo Lebrun, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

Cheers
Nicolai
