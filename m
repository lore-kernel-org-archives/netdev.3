Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6266447277C;
	Fri, 18 Sep 2026 11:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789731961; cv=none; b=eqNmuKQGXME2ZNM8sdzqH9jvPCi1+UwL0KGoUsDasfReQyhfei1bvA8gK8R3kA9J3D4tbfji6+vmpiWqXEPg7USxt+TShIBqx83S0EuXr7c+v3OzC1/hK4O3bVTUgs9x2ZMXSA+NAj9KAbvHc9CBIyWVgsaEQrK8vj+YKx0V048=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789731961; c=relaxed/simple;
	bh=A65aEjSXoqIagP509Nv7sm6Ny7VZMTNOTNDwmmrG9w4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uKCN3MYpSRA4z0OIRCoGwfEBIIHVy9iy8fGAjshbaS9smUfo4kySoET9jVp5+2eH+l1l+X0jy6SIDlWQcY5gEpXETPXYJwMA83t9FIp+cCFWE4A/jb3fCU7BphOdt3hurDBFHtC4t1VWNgY+sPcO/AnCNuIXGl2HUbtkeFvWleU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HnaV3bgz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HnaV3bgz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B4271F000FF;
	Fri, 18 Sep 2026 11:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789731960;
	bh=dA3Kqwy5aEWCE7vJqjnIhtFJ+rmNOsi9GPhX9P+fZUI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=HnaV3bgz/j08Vay4QLU6tJ8Wy/3gD61oBfOkycfO+8B3417lc72k53uFIe6qArF3/
	 9SyV1v8mCKZThUIK35BD+gA1sjRtESBgJoNp0yuACjACwn/+Y8w8SPhySXN8q8iH0+
	 emu6fFq4Gv7ZWG5GRMNL3YTWs/FqzL5cBd+LnFkZs5JgfQtThx7MOufPdtyhRyhOVT
	 J3ZXq4vLGcxXRV91kbieU0WvWwFc+urxaYp4kGAkpdehGIrBdoOLZNDndJxC5nSFqR
	 QnhKtgGmi0VMIjAZj7IuPeiWMukxuwUkbqRR2bPpWNjpvYeLiWfGK+gS8M1LiX2wb0
	 Ik/0/ob7yvnDg==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: alexanderduyck@fb.com, kuba@kernel.org, kernel-team@meta.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 mohsin.bashr@gmail.com, mike.marciniszyn@gmail.com, joe@dama.to
Subject: Re: [PATCH net] eth: fbnic: Avoid rounding zero ring sizes
In-Reply-To: <178971206933.22033.236948278674126701@kernel.org>
References: <20260915181229.4159158-1-bjorn@kernel.org>
 <178971206933.22033.236948278674126701@kernel.org>
Date: Fri, 18 Sep 2026 13:45:56 +0200
Message-ID: <87qziqrde3.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

netdev-bot+sashiko@kernel.org writes:

>> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/n=
et/ethernet/meta/fbnic/fbnic_ethtool.c
>> index 0e47088ec44ba..8954fcd08cb31 100644
>> --- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
>> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
>> @@ -334,11 +334,6 @@ fbnic_set_ringparam(struct net_device *netdev, stru=
ct ethtool_ringparam *ring,
>>  	struct fbnic_net *clone;
>>  	int err;
>>=20=20
>> -	ring->rx_pending	=3D roundup_pow_of_two(ring->rx_pending);
>> -	ring->rx_mini_pending	=3D roundup_pow_of_two(ring->rx_mini_pending);
>> -	ring->rx_jumbo_pending	=3D roundup_pow_of_two(ring->rx_jumbo_pending);
>> -	ring->tx_pending	=3D roundup_pow_of_two(ring->tx_pending);
>> -
>>  	/* These are absolute minimums allowing the device and driver to opera=
te
>>  	 * but not necessarily guarantee reasonable performance. Settings below
>>  	 * Rx queue size of 128 and BDQs smaller than 64 are likely suboptimal
>
> [Severity: Medium]
> With the roundup moved below the checks, the minimum-size test in
> fbnic_set_ringparam() now compares the raw userspace request rather than
> the rounded value.  Does this reject nonzero sizes that used to be
> accepted?
>
> The effective minimums all evaluate to 64:
>
> drivers/net/ethernet/meta/fbnic/fbnic_txrx.h:
>     #define FBNIC_TX_DESC_MIN	roundup_pow_of_two(FBNIC_TX_DESC_WAKEUP)
>     #define FBNIC_RX_DESC_MIN	roundup_pow_of_two(FBNIC_MAX_RX_PKT_DESC * =
2)
>     #define FBNIC_QUEUE_SIZE_MIN		64u
>
> FBNIC_RX_DESC_MIN is 16 and FBNIC_TX_DESC_MIN is 64 for the common
> MAX_SKB_FRAGS =3D=3D 17, so max(FBNIC_QUEUE_SIZE_MIN, ...) is 64 in every
> case.
>
> Previously a request like "ethtool -G ethX tx 40" was rounded to 64 first
> and then passed the check, ending up with a 64-entry ring.  Now the check
> sees 40 and returns -EINVAL with "requested ring size too small".  The
> same applies to any rx, rx-mini or rx-jumbo value in 33..63.
>
> The ethtool core does not enforce a minimum, it only validates the maxima:
>
> net/ethtool/rings.c:ethnl_set_rings() {
> 	...
> 	/* ensure new ring parameters are within limits */
> 	if (ringparam.rx_pending > ringparam.rx_max_pending)
> 	...
> }
>
> and ethtool_set_ringparam() in net/ethtool/ioctl.c does the same, so those
> values do reach the driver unchanged.

Indeed. V2!

Bj=C3=B6rn
