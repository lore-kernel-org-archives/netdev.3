Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DAA36C581;
	Mon, 10 Aug 2026 07:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786345388; cv=none; b=rzx4SX8KxyUH/hXAqDWp1CVYbvAtLFzczoouYo0TshaCEaWBSXrtnXhlwwtGf2thx9WsPLj6jet93EO7hqK6qY9G+j1apE6ySKiBTFLItscawShZfYTwXSaeKYhVHIF1akn4G761VFKd5eMbWHh2MwQeUv9lB6P82GWjKZ6aVYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786345388; c=relaxed/simple;
	bh=KBTz6r+JeBs9O1VpvPejsZmn2FVLnyeLkBnM0bvWAJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jm+hYjBBpoxjNaCqoZK//Dau1qKZOBaH4ELQ9r4WHCqNMQ4WA9tXx7sLhcNq85OQLymPvRWbOkS+zQJuv91XOTqSegYYUTKxRJ/5d0fcKVykbirCTZkhztmNmgQ6H0gcG+bGPNi4TaJE6ww04L9K/ae8wTGKCKMu9aqxeZpvU4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IX+mcSDH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IX+mcSDH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83A531F000E9;
	Mon, 10 Aug 2026 07:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786345386;
	bh=9lGpz6Zt2dO5Xy8l3cKhsN+96f+fJRqLVb2vOIjzLQ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IX+mcSDH6NRxncfESgodMHXM1/bLTX1vVLDP2o6sEa3+8zxF0v433gq0+Ndb/1p3r
	 rUJmF+Wd9QuTWzlhYXMIFlq83E452UMUrut7W2WAiFrG6jFBIWrPjQRPANdJE6p8Z9
	 WwV0GGbHKRAUe/zm/t1LpKRFtv+WiAKYXZqMR1Uog+Lp/xEFMJFwJQwMU/Kk1y4sCi
	 DaEj+KBych3hUSauSCHL2gZ4xEag/UcLFAMoU0hT7kJyPLQEEvuLwTlfPtd/uMII8n
	 HzebmHojVwRnwt1zStTxTdlUR4qyDeZxi1vySy8tD1PrX+Rjldkixumka2oh7UQicS
	 cnL2n60xlWFwg==
Date: Mon, 10 Aug 2026 09:03:02 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Luke Howard <lukeh@padl.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Vivien Didelot <vivien.didelot@gmail.com>, Gregory CLEMENT <gregory.clement@bootlin.com>, 
	Andrew Lunn <andrew@lunn.ch>, Richard Cochran <richardcochran@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, 
	Simon Horman <horms@kernel.org>, Cedric Jehasse <cedric.jehasse@gmail.com>, 
	Kieran Tyrrell <kieran@sienda.com>, Max Holtmann <mh@rme-audio.de>, Max Hunter <max@huntershome.org>, 
	Christoph Mellauner <christoph.mellauner@joyned.at>, Simon Gapp <simon.gapp@gapp-audio.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v4 4/5] dt-bindings: net: dsa: add EDSA
 arrival-timestamp tag protocol
Message-ID: <20260810-adorable-nimble-newt-8eb03c@quoll>
References: <20260727-mv88e6xxx-ptp-fixes-v4-0-10b4020155fc@padl.com>
 <20260727-mv88e6xxx-ptp-fixes-v4-4-10b4020155fc@padl.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260727-mv88e6xxx-ptp-fixes-v4-4-10b4020155fc@padl.com>

On Mon, Jul 27, 2026 at 01:59:15PM +1000, Luke Howard wrote:
> Add edsa-ptp-reserved2-ts to the dsa-tag-protocol enum. This
> EDSA-derived protocol lets a board select in-frame embedding of the PTP
> arrival timestamp, which the switch writes over the reserved2 field of
> the PTP common header, on switches that support it. Giving it its own
> identifier keeps the wire format discoverable via dsa/tagging.
> 
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Luke Howard <lukeh@padl.com>
> ---
>  Documentation/devicetree/bindings/net/dsa/dsa-port.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

