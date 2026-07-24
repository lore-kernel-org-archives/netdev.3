Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9BB768EA;
	Fri, 24 Jul 2026 05:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784869949; cv=none; b=Vs/Z5dDJ+ticHm3TgIzcPuusjUaG0x5kCTkcLg8DKuxhPKnln/O6jQKp+9mWKxqnIa04S8Hrvux0earby9K1syj+LGm2CfVXkc1vPXlNAU+7oACIPKKyLbqYeW87wUkh78luoVCkjvW4pfygeMkO9bWNYyWeGiFfdAU1BA/cOlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784869949; c=relaxed/simple;
	bh=kqefiRgOHf+bivPpWJsfhgNyCjePoUo5GGe5qsg2F00=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uhFdHLs1HhNVAuSD9I6sHUD6r/jga1BoUfBRb8EcJz5fDcmy6wm9cfSN7QVomPv6oGxMhQ+cu+LXYKbUAhQRM4Z58R77cbVU+lN2POzPLEpIO1UVGrSOPy5N2zShUMsvqDm36iZ1na06eNIckKd2dyywQEiB15bprrE+VI+FeKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=bGtdifE7; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="bGtdifE7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1784869937;
	bh=kqefiRgOHf+bivPpWJsfhgNyCjePoUo5GGe5qsg2F00=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bGtdifE7uB1pElNvM4neN15GlFbwCJSOEuhTxOPnxW04ODLafChmtBzGiOGdSD2MM
	 ulW9W28PogNifdzv8qkQlOGB4L1T0DBGtYDid8c+1JT01m7JSvnKlonYhQ8P4d7TSZ
	 F6KCKGE+RHYect0/tstyt45Tcg34gfFT9Hkdto9OGAs+Ul+6DsaNrfB0oWykYnvxiO
	 Bl7617OqbvwKz2dkg5X/jFQXjA8Xg4DGfzTZZCTlGY+qMcPIShB/YGQ749ApW6QXKZ
	 KI44L3E1FvcQJWyhBUWGTY+nW1F5HtlX0//ph5NGLjEEZVnsQhlfTB1R+3CBg859V8
	 t/p8Xd+TBIx3g==
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id B164166354;
	Fri, 24 Jul 2026 13:12:16 +0800 (AWST)
Message-ID: <0eeb9e53e5fdf2a505a371e413b825e6ceb7ef52.camel@codeconstruct.com.au>
Subject: Re: [PATCH net-next v4 11/12] net: mctp: usb: enable v1.1 packet
 spanning
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Paolo Abeni <pabeni@redhat.com>, Matt Johnston
 <matt@codeconstruct.com.au>,  Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet	 <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Greg Kroah-Hartman	
 <gregkh@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org
Date: Fri, 24 Jul 2026 13:12:16 +0800
In-Reply-To: <14455fa9-15b8-424d-aac0-b74d7da35f04@redhat.com>
References: 
	<20260713-dev-mctp-usb-1-1-v4-0-4ae8de764a01@codeconstruct.com.au>
	 <20260713-dev-mctp-usb-1-1-v4-11-4ae8de764a01@codeconstruct.com.au>
	 <14455fa9-15b8-424d-aac0-b74d7da35f04@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Paolo,

> Sashiko has still something to say:
>=20
> https://sashiko.dev/#/patchset/20260713-dev-mctp-usb-1-1-v4-0-4ae8de764a0=
1%40codeconstruct.com.au
>=20
> and the race in look real to me.

Not so much a race, but more an inconsistency in how we're dealing with
ndo_stop between a deferred requeue vs urb kill. Fix coming in v5.

... and I may as well deal with non-power-of-two xfer sizes there too.

> Note that you are expected to act on AI review feedback autonomously,
> either debating it or addressing. A reply on the ML is expected in
> either cases.

Sure thing.

Cheers,


Jeremy
