Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A85439182C
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 15:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786462046; cv=none; b=KD4uGq1RA8GjqCtd5oMCywC3ij5xd3nzeFhwigYVMYUkNA+3FOichoCFQ3RQrPZY7rhtBs83O9EbYbGl5Za0pQoj/Hkt5umEcvZ/Q/ZxMscjuj4KJmumaXF773d5GUHe6akYUrFe9re2TvfcTqMHAkz3LVkjtW60VminLCIMTQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786462046; c=relaxed/simple;
	bh=JCD44ZcOuYHC1HTHLWF7Wqcw4KD0p8/yOyBeSDoDs7g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k5N+L9CJ+NkZnNQhNnhDQ3kZDRf7N+SBvPvYGZbXfJGn8FgXC8YfWh5harZeB48NtMjzpgiGhJ0ARhOxAlfLD+UNLQ1fyekMMp1EXJY/94x5ctKtV5Btgsv7WVlqQ/Sl3SmsiadcK3e3MVy9fqFQtsIUyj/oMaXR8CMoW0Qdjoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dyw0icwI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dyw0icwI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C42B1F000E9;
	Tue, 11 Aug 2026 15:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786462044;
	bh=eKmqPf9yrLQijSrQuJmiBdhoHJvOibhs/te98X6heYA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Dyw0icwI3q8kjthKNmZzjwVXpNIPgbx7ETwrioJaYgl5g5pU+8TkgkhcPfIbW/W6N
	 8MTFpb4zxGHwh62m2vaWhh07gLgxeP5AcYDzfoVT9PUAHOkiIFFbf4O7uTv6GVTOH7
	 KMYtWnie9v/S8+K6M2q5BngFLqLmcQZHuGGav7a79VDk9WLPS6MVbcHTg/r57Y1q/i
	 COudYXfD9Zb8PIzcWDuNP2HhlI0eC8FwKFKzbqv3BWZOf1e+kacP699iToLuRtliuB
	 hWHrFXfqhxg5OxbkMPPanqpJ9TsBkYw4JXnPakfNtOHQcoqhQrFrZAOF7b4N+CGCsX
	 l0sBTsUxKKR3A==
Date: Tue, 11 Aug 2026 08:27:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, andrew@lunn.ch, Willem de Bruijn
 <willemb@google.com>
Subject: Re: [PATCH net-next v2] selftests: drv-net: so_txtime: only send
 test traffic to sch_etf
Message-ID: <20260811082723.43a9af08@kernel.org>
In-Reply-To: <CAF=yD-JsW3moq_xw+ZM5c8hxg77btODoBujMpNut3Nr04PYt4A@mail.gmail.com>
References: <20260808160129.890119-1-willemdebruijn.kernel@gmail.com>
	<20260810183118.32d5c06a@kernel.org>
	<CAF=yD-JsW3moq_xw+ZM5c8hxg77btODoBujMpNut3Nr04PYt4A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Aug 2026 10:29:12 -0400 Willem de Bruijn wrote:
> I can reproduce after
> 
> tc qdisc replace dev eth0 root handle pfifo_fast
> tc qdisc replace dev eth0 root handle 1: pfifo_fast
> 
> It is not possible to replace tc qdisc replace with a del + add pair,
> due to "Error: Cannot delete qdisc with handle of zero." on systems
> with the default 0: qdisc, like my debian trixie.
> 
> The simplest change, then, is to replace the qdisc twice, first for
> the kind, then for the handle.
> 
> @@ -45,17 +45,18 @@ def _qdisc_setup(ifname, qdisc, optargs=""):
>      """
>      orig = tc(f"qdisc show dev {ifname} root", json=True)[0].get("kind", None)
>      defer(tc, f"qdisc replace dev {ifname} root {orig}")
> +    tc(f"qdisc replace dev {ifname} root {qdisc} {optargs}")
>      tc(f"qdisc replace dev {ifname} root handle 1: {qdisc} {optargs}")
> 
> It's an extra replace, so a bit ugly. But avoiding that requires
> parsing the json for existing handle, branching on that.
> 
> I'm testing the above some more, will send that if no concerns.

If we are adding an extra command adding del would seem more intuitive?
But no preference.

The issue may be because the ring reconfig test now also sets up qdiscs.
And we don't have a proper way to restore previous qdisc config in the
tests. If another test needs to change qdiscs we should probably add
better infra, but for now I think the simple workaround you suggest is
best.
