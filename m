Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC9234DCD2;
	Mon, 28 Sep 2026 09:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790586139; cv=none; b=A42sSvLVlJTZs5+IeY9deOn7b5cDkQDvM4SUj5OvcJ2M/MzWQJoTpnC88SnAFe1F04tqfGJOmjE3yeuz0GIXVOjyyQCK+VfnRUHiWo2Lp9guIQ41DacjRRDoSNLFmgNbLp0VGP7WfutbipPrJAEV64tHa9sHdKawyszC5sz2pwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790586139; c=relaxed/simple;
	bh=7G51KArnG29LcWRmh3uK0kqHfYkcwE64yvpraIoZu3U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NUFTliv/sLXGnIr/PpeFwyKupZVjZCCOXgPZv/nlmaCEmQNWwJ+DR5XptlLnC3/F6SMuSWq7ooBYKTTKcC41grJ17knbOB0H1ZvucfzNLXGsV69W5aUbTTEb6ae7/TNYIpgYgaykT6Y+Mdmf5I9nv0/E+dbWBgzbswfKMF8DN5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oq6lfoet; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oq6lfoet"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51DEE1F000FF;
	Mon, 28 Sep 2026 09:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790586138;
	bh=vdonEvpZnOZU1yvJsjopOR6WU7Aqm7c/dPvUMJ/KK+0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=Oq6lfoetLHxi8gmasTJE50aWrmt3DKsVicLkSYaEP6ZDv8vPePLaTiYYvrIKUGPGf
	 nRao1PAQFarKjz5goR+tu9iGZ/Ro5egv0KG1mfl2pcsHxMjssPVRk8I4mcQ5mutX1M
	 c/5viBL9mSGPN67iR8Cyx2tsECjb+1fPo2N7eV6GIXYpee4vE0kEJ9Rwfsve1kOfmG
	 QLHBPgI8ZBzUj0z3iQ0QYNQ9soN+agkP3PPR+bn3Aeh1GrPlKUgZYJ3CdPg33MFhFr
	 3FNaaW1CP2C+vterJAts+DH2dK9JxqiMnyfku17gNImol1t6siHxTJ2rAHugki8fIx
	 mZOtSzyonBsLg==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: alexanderduyck@fb.com, kuba@kernel.org, kernel-team@meta.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, linux@armlinux.org.uk, netdev@vger.kernel.org,
 mohsin.bashr@gmail.com, mike.marciniszyn@gmail.com, leitao@debian.org,
 horms@kernel.org, almasrymina@google.com, linux-kernel@vger.kernel.org,
 netdev-bot+sashiko@kernel.org
Subject: Re: [PATCH net v2] eth: fbnic: Keep real queue counts synchronized
In-Reply-To: <179036391870.2160803.457228716006507823@kernel.org>
References: <20260924191817.1843726-1-bjorn@kernel.org>
 <179036391870.2160803.457228716006507823@kernel.org>
Date: Mon, 28 Sep 2026 11:02:14 +0200
Message-ID: <87h5j94ull.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

netdev-bot+sashiko@kernel.org writes:

> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 0 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
>
> - [High] The patch adds a hard `-ENOSPC` exit to `__fbnic_pm_resume()`
>   (drivers/net/ethernet/meta/fbnic/fbnic_pci.c:523-529).
>
> --
>
> eth: fbnic: Keep real queue counts synchronized
>
> The patch publishes the default channel counts, and the counts set while
> the device is down, to the core with netif_set_real_num_queues() right
> away. It adds num_napi_cfg so the configured NAPI count survives suspend.
> Resume now fails with -ENOSPC if fewer vectors come back than that layout
> needs.
>
> Link: https://lore.kernel.org/netdev/178915061000.219967.7726187707862333=
281@kernel.org/
>
>> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c b/drivers/net/e=
thernet/meta/fbnic/fbnic_pci.c
>> index c6698e3002a13..48279a5214c8a 100644
>> --- a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
>> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
>
> [ ... ]
>
>> @@ -519,8 +520,16 @@ static int __fbnic_pm_resume(struct device *dev)
>>=20=20
>>  	fbn =3D netdev_priv(netdev);
>>=20=20
>> -	/* Reset the queues if needed */
>> -	fbnic_reset_queues(fbn, fbn->num_tx_queues, fbn->num_rx_queues);
>> +	max_napis =3D fbd->num_irqs - FBNIC_NON_NAPI_VECTORS;
>> +	if (fbn->num_napi_cfg > max_napis) {
>> +		netdev_err(netdev,
>> +			   "Unable to restore channel configuration: %u NAPI vectors require=
d, only %u available\n",
>> +			   fbn->num_napi_cfg, max_napis);
>> +		err =3D -ENOSPC;
>> +		goto unlock;
>> +	}
>
> [Severity: High]
> Can this leave the NIC unusable after a resume or an AER slot reset that
> used to recover?

Thanks, this is valid. The resume path limits the IRQ request using the
online CPU count, then rejects the resulting allocation against the
saved configuration. It can therefore fail without ever asking PCI for
the required number of vectors. The administratively-down and AER cases
are valid as well.

I'll rework the IRQ allocation and resume handling.

pw-bot: cr
