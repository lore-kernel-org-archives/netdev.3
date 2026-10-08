Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6DA37207D;
	Thu,  8 Oct 2026 18:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791482593; cv=none; b=Sk7ZJ43EOj//Ru9oaBhwUjWAj+OwwmjB7NiXnT/hEoTGZMNk+aZeHwoD2hU8z0hSrviP6GY0pWYKszPyT96ie1Yj05PGXUUarLFjttr4pUtUeP8HHRxG7gyEUkIET1ABpf6/kpH9zNxk/YSns78zW/HLso2m2rwBwXC3a4Vyce8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791482593; c=relaxed/simple;
	bh=Zzl70P+RGux/UwfMrnelaaTuxjCeRO/kek2Z5ohISAc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TiXrIs998b+/nKn/XWBW8yMEUmn4igCI76Pfvk6O65ifbhrHSsxc6Tpab+4r7r6WhfUnPQE+5Px6CZGQsHC1Zw4WVvK4Y+foEJInnD0TCrVzOtlTcMjc5a0VNroLKjbHcOsdBp5p1i9PsRquGal+aQOexwo5vzCfdQM9xVYOfSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XKdoaXPr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XKdoaXPr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17C091F000FF;
	Thu,  8 Oct 2026 18:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791482592;
	bh=Zzl70P+RGux/UwfMrnelaaTuxjCeRO/kek2Z5ohISAc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=XKdoaXPrfG2co/uUU69wo21lDZVEJhQZCAoKg53vKPqSyV6sWhKCJQi4iAdvcKcLQ
	 7wSg2g7ZbWoa2ZQk/NH7P2P7dwt0SYKTHVWzUmnaI3Pp9bDb4bvTwmeg7r0azaPn7I
	 KVVT1hZwZC7HTC0E32JkH4uFXE8Q2F7P3cw8v1A88zuTyGjo1zTDEw7YYMMECmSUSd
	 LNvpo/TEmBCyXitmF7e53lVJUp+LMeXQ5Bs2ra0uv7ShBSvl04wT1dDNvGJdwqvgso
	 0hrAj96s10Quq62osYXJIuBE6Ceac2gPU+bhCGNEfMz+O6z8//0UtNPCLSFPBfV1mo
	 mKWkPj5CH7XSw==
Date: Thu, 8 Oct 2026 11:03:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?w5ZtZXI=?= Mete Kaya <omermetekaya0@gmail.com>
Cc: netdev-bot+sinfo@kernel.org, netdev@vger.kernel.org, oneukum@suse.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] usbnet: fix EVENT_RX_PAUSED race in
 usbnet_skb_return()
Message-ID: <20261008110311.6c93f25d@kernel.org>
In-Reply-To: <6cf2ac60-a9e6-4a2d-a7a5-7535441485a3@gmail.com>
References: <20261007220311.113827-1-omermetekaya0@gmail.com>
	<179141094859.2527009.4935200551311639225@kernel.org>
	<20261008084012.53e34d5f@kernel.org>
	<6cf2ac60-a9e6-4a2d-a7a5-7535441485a3@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 8 Oct 2026 18:47:07 +0300 =C3=96mer Mete Kaya wrote:
> On 10/8/26 18:40, Jakub Kicinski wrote:
> > Hi, please answer these questions, and try to include the answers in
> > the commit msg of future submissions. =20
>=20
> Hi, I couldnt add reported-by tag when it comes from sashiko,
> should I include the answers under the "---" for future submissions?

In the main body is better, this is very useful info for risk / benefit
analysis for backporters.

Single sentence like this seems suitable here:

Discovered by Sashiko, not triggered, not tested on real HW.
