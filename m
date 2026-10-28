Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793153093;
	b=114KwsedMP3vhWZaCQH7szn6JWVYEiJHQ1rQkGjBrzn7+9belYtg7PGNf4tuNOqJlJdm
	 lGvdrF2q9dNduwgHF8VXOIWWnLZ0EibXPmbfO4H5UKMRSBC9avhPqbAYC+oevIY4xvdm9
	 tswyImjvzdtfyg2IOTDcX6GRH5irC9xN39EUvAktmsV2lnQgBuBYxzDe3Ry/mN7pS9R6T
	 CrA7rjKHXYcUepAE2QjQ1zsvqAN3/02A7iEBcRJaFlKYdsKYUuQ+BoLRMaE+gxmzQtfy1
	 J2fzhPgj9KOqR90B3RoQHta3kK6gYE0gdzTuSZKNMD2TzEZ6UvJ6y3wD0yU+WsSBZhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793153093;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=B2dbDPohrwxKAwssPy3BtXvVXxGswtl67OL+peXJlOw=;
	b=NcGQWp5jYj5Ruh+JN5cDXeJKavyAgoqSZ73Aw8gh0fQTd9kAJ+b1RJjRrANGN2M33eha
	 kCmiPhPfQodvH73VUXunLPQ6bAGywa3Orvg6x2p9gFVgTgL4Ma2yriItga+9jb/V+remf
	 sTc8/atlwsmUJCNLLZzVGkRNWCETOfftjVbPHT48BsvgPv5uQ0FKNa1lYQOKdzBvLZDGy
	 LASDMEpuwb1dllxSaTt+voHyUZmi/FAUMIROEh4VO0QR93wfZwppSW7L+Fc5T/zpH611U
	 qT7k//b0iT+GP0iFQSV5aBYddM2vH19sYHADov02qsLWHHh+HyRtRXwZiS0ePKCM4Hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=5x8cAJ7L;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD8B606A31A;
	Wed, 28 Oct 2026 02:04:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FD8B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=5x8cAJ7L
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=B2dbDPohrwxKAwssPy3BtXvVXxGswtl67OL+peXJlOw=; b=5x8cAJ7LZHUnDKePmgwZ20M/j7
	hn+Nb0k8uUqZHRbyWaRzScZ3ohhWxC40WHQ+04V/gsEzMtmnWa2VZeNku0lHlB0L/rppedXTKNBHe
	gxR1um6VYW1zj/Ok1qxCZnxpDkzJRSb7sbdHcqPKrvjfM/P/cXQIxpWSjzlSvujBo6DQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xLt1b-00D2jJ-0N; Wed, 28 Oct 2026 03:04:23 +0100
Date: Wed, 28 Oct 2026 03:04:22 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Caleb James DeLisle <cjd@cjdns.fr>
Cc: netdev@vger.kernel.org, olteanv@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
	chester.a.unal@arinc9.com, daniel@makrotopia.org,
	linux@armlinux.org.uk, arinc.unal@arinc9.com,
	Landen.Chao@mediatek.com, dqfext@gmail.com, sean.wang@mediatek.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, naseefkm@gmail.com,
	b.larsson@gmx.com
Subject: Re: [PATCH v3 2/7] dt-bindings: net: dsa: mediatek,mt7530: add
 passthrough mode
Message-ID: <a031f089-0b96-4fc0-b878-6af13414524f@lunn.ch>
References: <20261028011317.1557238-1-cjd@cjdns.fr>
 <20261028011317.1557238-3-cjd@cjdns.fr>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261028011317.1557238-3-cjd@cjdns.fr>

On Wed, Oct 28, 2026 at 01:13:12AM +0000, Caleb James DeLisle wrote:
> MT7530 switches can be configured to blindly pass packets between their
> CPU/upstream port and a downstream DSA port, in particular, without
> altering the MediaTek DSA Tag on the packets. This mode is used in some
> integrations where an SoC integrated switch exists, but a more capable
> MCM switch is added to effectively replace it.
> 
> Signed-off-by: Caleb James DeLisle <cjd@cjdns.fr>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../devicetree/bindings/net/dsa/mediatek,mt7530.yaml       | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
> index 90b3582b7619..e29fb8693498 100644
> --- a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
> @@ -73,6 +73,13 @@ description: |
>  
>        Check out example 7.
>  
> +  The MT7530 and MT7531 switches are capable of being operated in "passthrough"
> +  mode. In this mode, traffic is unconditionally passed between the CPU port
> +  and the DSA port which links to a second switch. To use passthrough mode, the
> +  upstream switch is configured with a DSA link to the downstream switch. In
> +  passthrough mode the upstream switch is restricted, with no other ports or
> +  switch configuration allowed.
> +
>  properties:
>    compatible:
>      oneOf:

Looking at just what is here, all i see is a comment. There is no new
property? Yet the subject is "add passthrough mode"?

	Andrew
