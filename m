Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C4786331;
	Mon,  1 Jun 2026 13:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780320403; cv=none; b=FI6ZpKapuLS2qXbQxiQYzx4NyC4RVOlJYSlk/0Z9fCGY5b+vT5ltheNAI6eqNlzqaqE2TrtojrM+KpMDh3z3v48IYMHxOek2UDAoC6drDSA18+jyTQdyOR+S8rQPY2rtZ7gVnrvWF6FFCK8/ButO56GeCPnSRtMBAOx+cTZWcKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780320403; c=relaxed/simple;
	bh=s7G3hvizn/N7ee9y/22RHBq1bi5D+34Fq/9rmvj3IvQ=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=L6Smez9QBBMxzxcl5BfftM40WbwQLraknp7JtDVjMPBqxm5SlRRex4Q74A21ndAbG2mP9lCKurwdeCOmApzi8sDwjEmz3lCpxTyLLLyMMjTLtomRFKgyIVS+B18sTZjYG3q58P/FgiHmNHxLRHRYP/o7xsiXXGaIukkbIK+lmu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=oHpYaYBN; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="oHpYaYBN"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 776B8A0960;
	Mon,  1 Jun 2026 15:26:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1780320400; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=8UNnRN175rIffqIktJv6rUvTH6Z1m+MsKORaXLUXrnc=;
	b=oHpYaYBNUj4s1tb3nNl3vHxTyAZITWqvgE7vMm52YFyEmjr5IwJdBF5DsdMKbssLIAQTOI
	CN1p6IpcueLi6kjg6MGFvgOMJiPSTr9dvY6JPzhJXnDjSr5UeD32UoHKl1TbF2pd/IoS1g
	A2GLNQWfOxhcH5AbkY3Ysh7Y8BHPes6pxO0c83oUbd9kPzR2FZs19etY4OU7689ZwYI1ZA
	LXpmCB7LURb1NdWOHtWxvdCNxtrAezuhtwzO5fgMpkuFPXLlhz++vftDTTgkrFMSVAb5rX
	0ya9DcnfBHwjMOnIaf+5vCelef3IXpMjKJ9AzqihjlUxw9WyiHj7GGUZ6RmL+A==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 01 Jun 2026 15:26:40 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Fidelio Lawson <lawson.fidelio@gmail.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Marek Vasut
 <marex@denx.de>, Maxime Chevallier <maxime.chevallier@bootlin.com>, Simon
 Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, Russell
 King <linux@armlinux.org.uk>, Tristram Ha <Tristram.Ha@microchip.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Fidelio Lawson
 <fidelio.lawson@exotec.com>, Marek Vasut <marex@nabladev.com>
Subject: Re: [PATCH net-next v8 2/3] net: ethtool: add KSZ87xx low-loss cable
 PHY tunables
In-Reply-To: <20260601-ksz87xx_errata_low_loss_connections-v8-2-cfa102cf62c0@exotec.com>
References: <20260601-ksz87xx_errata_low_loss_connections-v8-0-cfa102cf62c0@exotec.com>
 <20260601-ksz87xx_errata_low_loss_connections-v8-2-cfa102cf62c0@exotec.com>
Message-ID: <47ce6b5cb11318415b4e71a457c9e9d2@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 1.6.2026 13:54, Fidelio Lawson wrote:
> Introduce vendor-specific PHY tunable identifiers to control the
> KSZ87xx low-loss cable erratum handling through the ethtool PHY
> tunable interface.
> 
> The following tunables are added:
> 
> - a boolean "short-cable" tunable, applying a documented and
>   conservative preset intended for short or low-loss Ethernet cables;
> 
> - an integer LPF bandwidth tunable, allowing advanced adjustment of the
>   receiver low-pass filter bandwidth;
> 
> - an integer DSP EQ initial value tunable, allowing advanced tuning of
>   the PHY equalizer initialization.
> 
> The actual behavior is implemented by the corresponding PHY and switch
> drivers.
> 
> Reviewed-by: Marek Vasut <marex@nabladev.com>
> Signed-off-by: Fidelio Lawson <fidelio.lawson@exotec.com>
> ---

> [...]

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks
Nicolai
