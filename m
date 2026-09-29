Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44BA3D1A81
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 14:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790690988; cv=none; b=CTsU38QXdJ5a6K9RYsXI3Z47rY+hlLGRg0TQl3BmlWaOtp+v7Me5vatsQmO83KM4kugrT7uSN2QI/K/jlR9ImFUTmi6jrYFkFGYDliC3/W2gkLXLdW/50HLdxZjRGcnhnGUMjnXnbIvoy3IyLYCX45CDUj7AS5osfflp4/KdUJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790690988; c=relaxed/simple;
	bh=+jw2GgeLuUCWWr6zhg2xGsu1IGJC3eYeJOInKJc7E+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MEQFDkRiO0vvEM8dlZOjDZ4kbaedJywsKVxrjlAaws0mjBfuOams/7stNq/qamofWSPPabnY+3dfPqBf0w+W2zK6O8wCTcIy9trndi2RP70Kc+epiBVNWwADg8Wq1JqGQj/ErSaW0FZDuPA3MeTDL80Qgf2mtsJG/34st22H3+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ndqviar8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ndqviar8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F1021F000FF;
	Tue, 29 Sep 2026 14:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790690987;
	bh=Rh9LOw3XmQCm59WLRd/7vmwlrmdkOXMGXB9CgtarJ7I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Ndqviar81SP4sWqN/HKs3s0sxF1BQSbrx43WxBwjkWoDl5BMvCuUjqB5/dFEyS+sX
	 MbSfaFJSANDGczHW+0hJ+ZcCMqmvIGTo6DHImtnSMHCL4BAz02KNvmpkFy/1/VgV3N
	 scwZCV8OU08+RmvZ7fxPZRg0T35Totv3gnVDmY1M1vmatXDZYl+ZLuxys+dS65e9b9
	 hVAjyyVwhUJ8a0hpmPXm4nctxzoLF7b0MKcArRK7S9BSW0m3CpNWrgT3irctquMOP7
	 3SnetXqg5YkZp9sEl948dKJL0/tRAHREdQlcZckv2C0Ldhzemvi2VaQORPe5zJqwXj
	 HE1yDQcsvwr+A==
Message-ID: <0c6f073c-12c7-4843-846e-69c48c290107@kernel.org>
Date: Tue, 29 Sep 2026 08:09:46 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/1] ovpn: avoid caching stale IPv6 dst after FIB
 changes
Content-Language: en-US
To: Ralf Lici <ralf@mandelbit.com>
Cc: netdev@vger.kernel.org, Antonio Quartulli <antonio@openvpn.net>,
 Sabrina Dubroca <sd@queasysnail.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>
References: <20260918202718.36933-1-ralf@mandelbit.com>
 <20260928085639.151005-1-ralf@mandelbit.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260928085639.151005-1-ralf@mandelbit.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/28/26 3:56 AM, Ralf Lici wrote:
> Hi David,
> 
> Just following up on this. Does my previous example clarify why storing
> an old dst with a new cookie defeats reuse-time validation?
> 
> If so, would you prefer that I pursue the kernel-wide lookup-provenance
> approach described in the RFC, or keep the fix self-contained in ovpn?
> The same late-cookie-sampling pattern is used by several drivers and
> callers in the networking core, so I think fixing it generically is the
> better architectural choice.
> 
> If changing the generic interfaces is not acceptable, I can rework the
> patch as an ovpn-local fix, although that would duplicate IPv6 routing
> details in the driver and leave the equivalent pattern elsewhere
> unchanged.
> 

dst's are cached in lots of places. Why does ovpn need internal routing
details that the other places do not?

