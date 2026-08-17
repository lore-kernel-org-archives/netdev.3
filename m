Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDED419303
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 16:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786985418; cv=none; b=JKaARD687MgJWP6Mo02twPjFhmfWRcrRLZ14tBV/0Zl88h5SmCzIMaQvlEldGNe4Q9pdaVGE4oVjOOd1DruEMK/Tqbr8kFf7nZknjGiNsWDkdZrCPEd5F/bPIJxRQsvYMMzrEeoFMujpoFfXhOyZRk6Db4UpcfwwcLOVsqWppbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786985418; c=relaxed/simple;
	bh=+j/aFlAFXdV7WxQ9V4ISLrqc8PFJR3V/mGdIkWMKOzk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ik6YmAGH2yA+LDSm3qrCEutM1W3wbGheRYk66VMwBpJuFiBYs3sywCRU1mgmrmJmmJF6rEZXP6H0+NxESytzVZnUeIuXDHrqXXInrpeX5lwm2eUMpZGeq8YSnq6lTAeJbyWVgklNcixKIbCXM4Twgqy67vsASgaIzyiHUdRkhB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OtMbjS9l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OtMbjS9l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74EC91F000E9;
	Mon, 17 Aug 2026 16:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786985416;
	bh=+j/aFlAFXdV7WxQ9V4ISLrqc8PFJR3V/mGdIkWMKOzk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=OtMbjS9lnL8K7aCwS5jBh496Cll3bDxaiR57hXHaqNPCGnWOUqIf6qrUMXMzxptVm
	 Es3a6y1mtr81o+kG/pO0Fy+wlGfvxCOuqSSA2x4Mwkifm4wEI2PL/+6qLZW+KT0jIa
	 +t87YXJDwntGMaZdaxQ1h/YMaK84H2KDy4QBSVF9WhKVbN+6TzhrcE6xmjMgS4DSa3
	 cGiHrUoK5J0cactZ6c+QO0WCXFxB0b1tpM7F68cXjTL9Sfuguzl68dl7PGDnE4jHMC
	 ChX6lb+XLNhH8B5Kgicf8A+bTO+xk9dfZyOGaQszhdGSk0pCR8WfX6ux9TYcRV71BS
	 vsqqB0bTB64nQ==
Date: Mon, 17 Aug 2026 09:50:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ido Schimmel <idosch@nvidia.com>
Cc: Ren Wei <weir@nebusec.ai>, edumazet@google.com, ncardwell@google.com,
 netdev@vger.kernel.org, dsahern@kernel.org, davem@davemloft.net,
 pabeni@redhat.com, horms@kernel.org, vega@nebusec.ai, edragain@163.com
Subject: Re: [PATCH net RESEND 1/1] ipv4: reject RTAX_ADVMSS values below
 TCP_MIN_MSS
Message-ID: <20260817095015.75fc2f44@kernel.org>
In-Reply-To: <20260817082803.GA242453@shredder>
References: <cover.1786610865.git.edragain@163.com>
	<2c3901162c65a1d85cc1756a83a458db834d70c1.1786610865.git.edragain@163.com>
	<20260817082803.GA242453@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Aug 2026 11:28:03 +0300 Ido Schimmel wrote:
> Given the above and the "We assume here that mss >= 1. This MUST be
> enforced by all callers" comment above tcp_select_initial_window(), do
> you prefer to fix this in TCP by enforcing a minimum MSS value?
> Something like [3].

Should we still take the patch as posted?
Maybe not as a fix but to let the user know the value is out of bounds?
