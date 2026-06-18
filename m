Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879772D73A0;
	Thu, 18 Jun 2026 09:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781773987; cv=none; b=s81l2kmyPAwUJeB1JA/AlEDNTemwuEYcTEDWhxaHQtNXPx7KNipYLaCl0HOWv7J82N05REQ3REUlqsyfpnIN65gdBt3ZXWNsJSEd72Hsfg4aCy5gCImmvmflMh4FsPkOH8GSw3sL8VhSLSl5WjLt3IzLf+o581rEpPvQtpmK7YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781773987; c=relaxed/simple;
	bh=aDAaixnaOkCp0FvlTHvbxtygQ39sFrxdpWNVbjJJnHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dLDTVw4txwoc/+GZb2teRxFOUd/OxOfoEXgp/9zlkGJXSotFQn558lndCuWM6NrjJXDF5LqOWVWOW4XZn3EqGupX3NNmsmMRmLNGewcT3K+NWvrV1wU7AY4sxhcroMjmECdQpgak2PriY6xigJdc4NcRj49eqlMJDIzEON205nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oHbX4KxF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oHbX4KxF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C5A41F000E9;
	Thu, 18 Jun 2026 09:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781773986;
	bh=AWCj/HVJb36OepoXtdk7Ch9Z0ybjjd4XF8zao04WgoU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oHbX4KxF+0QIg4xHyufx2IHH8OafCbIbmc5zHph+LWo/in3mFEOO1chIDtWtR4m9X
	 ex9BiJcimYFhM3o//odqcyHbMT/0gAY2c01V972zPE1a3Lj6gwJHq4CEqSRgL5JL5K
	 korznKLxhVP2BeQq9vRm3P5JMNwQsY/H1u3tdM3gHKN7ifIi1TUAa785iQZDViwdta
	 ZFEoXMXhAg+zxQDTFKQCe+aWM8z11cv3f7ldohcRD3loav1BA9baBR6lxh70YfazmX
	 RFGIIVxhj+0IFEGoBnE7QxTJ7iMhYJLqmjPb52GNDzer8cmUDnFdAeRURXTQso0kCK
	 T2XmfQ1MT8ndQ==
Date: Thu, 18 Jun 2026 10:13:01 +0100
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	asantostc@gmail.com, gustavold@gmail.com, kernel-team@meta.com
Subject: Re: [PATCH net] netconsole: don't drop the last byte of a full-sized
 message
Message-ID: <20260618091301.GH827683@horms.kernel.org>
References: <20260616-max_print_chunk-v1-1-8dc125d67083@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616-max_print_chunk-v1-1-8dc125d67083@debian.org>

On Tue, Jun 16, 2026 at 09:09:52AM -0700, Breno Leitao wrote:
> nt->buf is exactly MAX_PRINT_CHUNK bytes, but scnprintf() reserves one
> byte for its NUL terminator, so a non-fragmented payload of exactly
> MAX_PRINT_CHUNK loses its last byte (emitted as a stray NUL in the
> release path). Grow nt->buf to MAX_PRINT_CHUNK + 1 and bound the
> scnprintf() calls with sizeof(nt->buf); the transmitted length stays
> capped at MAX_PRINT_CHUNK.
> 
> Alternatively, nt->buf could be left at MAX_PRINT_CHUNK and the NUL byte
> reserved by routing exactly-MAX_PRINT_CHUNK payloads to fragmentation
> ('len < MAX_PRINT_CHUNK'), at the cost of fragmenting those messages.
> But it would look less sane, thus the current approach.
> 
> Fixes: c62c0a17f9b7 ("netconsole: Append kernel version to message")
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Simon Horman <horms@kernel.org>

