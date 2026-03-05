Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9941C8604;
	Thu,  5 Mar 2026 11:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772710816; cv=none; b=NLM6HpHPpid/JGezaPTI6jlidsoYswYiB8TWPCSS8r23aFdtIDSNe6GImtrd9rQW3W1fYwYR5Air5eOZwm5FnUCTw0gkrhg6Aj5hmkv0BTlStgGVi7JwESK1QX/WAwcNqfjFqzaVyHvb5ydnvxoH+TYU2iWCY9DGZqW2ikfSDEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772710816; c=relaxed/simple;
	bh=1p/Nk0MC98exNpyGON9gfNuYIE+M0R7ekjo6NyhRjsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iCYwX5ob5rFRNGiiNOOt1YqyIEiXjkHrm0FEVpdPdNqbcLsMwdj1FOQvh7xMw1CQtzh1yic7lrMerg1i3nkDcXuA2q+a5gDDf0oBUVr2m1X2wBVXSJsIIaHDtJfvMYjYBnydXInbkmAoAkQxJIzSlS1ien35GH63knMzFaEu8vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=poQQX8wH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="poQQX8wH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58EBFC19423;
	Thu,  5 Mar 2026 11:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772710816;
	bh=1p/Nk0MC98exNpyGON9gfNuYIE+M0R7ekjo6NyhRjsI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=poQQX8wHUes7U4A4/FdfuNLTv8TdhxS3QZC4eOqAQYZz0YHGITbbxknkt5B41ZN8p
	 p5U9r/0GWTatkTw1pJFVkuPmYmIg8IFjGL33O/BNrUDcgEKTjl6VD4aekjVf/4XIcc
	 W4ZPHExrCLlq3TWelO8dg1qMRaXli01C5GfiCX06Y/oS6uCJji6x7PtTVSuda1xWXs
	 AvoB5hWYJMzXZBiCdjeu6sw0RRqjnkaJtqBWdLHUKZTXjdIMSLRpjn0caaaXMItLOd
	 Sb/W0uk1qJ29AvpbzhjM/3PjrqBhikXss5PRi0mVRytHGJ9p5yV8YJxcVuCt6wIydC
	 iHuquGwPZi4bA==
Date: Thu, 5 Mar 2026 11:40:10 +0000
From: Simon Horman <horms@kernel.org>
To: Charles Perry <charles.perry@microchip.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/4] net: macb: add safeguards for jumbo frame
 larger than 10240
Message-ID: <20260305114010.GD90938@kernel.org>
References: <20260303180318.1814791-1-charles.perry@microchip.com>
 <20260303180318.1814791-4-charles.perry@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260303180318.1814791-4-charles.perry@microchip.com>

On Tue, Mar 03, 2026 at 10:03:17AM -0800, Charles Perry wrote:
> The RX buffers for GEM can have a maximum size of 16320 bytes
> (0xff in the RXBS field of the DMACFG register means 255*64 =
> 16320 bytes).
> 
> The "jumbo_max_length" field (bits 0..13) of the DCFG2 register
> can take a value of up to 16383 (0x3FFF). This field is not used
> when determining the max MTU, instead an hardcoded value
> (jumbo_max_len) is used for each platform. Right now the maximum
> value for jumbo_max_len is 10240 (0x2800).
> 
> GEM uses one buffer per packet which means that one buffer must
> allow room for the max MTU plus L2 encapsulation and alignment.
> 
> This commit adds a limit to max_mtu and rx_buffer_size so that
> the RXBS field can never overflow when a large MTU is used.
> 
> With this commit, it is now possible to add new platforms that
> have their gem_jumbo_max_length set to 16383.
> 
> Signed-off-by: Charles Perry <charles.perry@microchip.com>

Hi Charles,

I am sorry if this question is a bit naïve.

I understand the need to clamp the max_mtu to avoid overflowing RXBS.
And that this hasn't been an issue up until now due to the maximum
value of jumbo_max_len used in the driver.

But I'm unclear on the relationship between DCFG2 and the max_mtu.
Why does it need to be set to a value larger than that corresponding to
the maximum mtu and RX buf size?

...
