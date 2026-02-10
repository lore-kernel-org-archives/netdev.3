Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CED329E58;
	Tue, 10 Feb 2026 14:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770734930; cv=none; b=GKfpxl+IoY/gsA5Tln24918gQFaVCOeBSsUc3DMCebG3KYRqLJrqQTQqbAGn6+0FyCoRLopb8qo7iiMO0OkAW60vmkFDBf8aenxBfoqeGkulNmTtxvkxBLRvqNBM1SklLFQNp64ZSELfPPO7jSdOKIFsMYNTkGu8GOCEcE+kbKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770734930; c=relaxed/simple;
	bh=0BPOdjZ9FZZhVNS70ugUYJcdyNmnzzQQblYQQVtkCAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u/OfCs0uRWIMSIJ3JZ1SmfPMRim1/2Y1+AkZXfNfFk38dJeqbPDOi9HHov9vyTcSgo4zkWDoUNt3pb/QETxFpLXvOP1VWg0nu+vU9eifdef1FHDl5BMkrKTReMNb7RQPTvJZPj6NTGCUUtSn/6YbBX4cAs+y5X6kAcx8VhAJoXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EEL355M7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EEL355M7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A603C116C6;
	Tue, 10 Feb 2026 14:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770734930;
	bh=0BPOdjZ9FZZhVNS70ugUYJcdyNmnzzQQblYQQVtkCAI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EEL355M7aYUwWTSyH8KocQFtO+QK8eM+yylOh+jKs/gUQG/tfGx/n2a+5I4BKhBTu
	 hltnl+VVUrmIh9G0TY2Eqv3S5COB7SnYGSa1MLRQZZk5FS6d9wTXJPCaf8NAdpNwzq
	 d5Hek3aBv0L+pIEzaFxoCMiZh6YQYOGPviLtNiWALzem0j5ddEJEgOfMg5OINkuGIA
	 cPm/8Y6sc1cWZN785j5Ci5avKtcT9y5qKMGgWkDyYhmkQDt/PvPSqFLXu9VRB33Lvw
	 4UGis9ilIAgM0eKnieYUHCg9m/MeLW72wNMkFJZvRywabIvJ7pSPQaAo1inHWJUsOt
	 uDGj0U5SS1Aow==
Date: Tue, 10 Feb 2026 08:48:49 -0600
From: Rob Herring <robh@kernel.org>
To: Teresa Remmet <t.remmet@phytec.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, upstream@lists.phytec.de,
	Yannic Moog <y.moog@phytec.de>, Benjamin Hahn <b.hahn@phytec.de>,
	Yashwanth Varakala <y.varakala@phytec.de>,
	Jan Remmet <j.remmet@phytec.de>
Subject: Re: [PATCH 1/2] dt-bindings: dp83867: add binding for
 ti,output-impedance property
Message-ID: <20260210144849.GB2675838-robh@kernel.org>
References: <20260129-wip-t-remmet-phytec-de-bspimx95-132_upstream-v1-0-8deccd658d16@phytec.de>
 <20260129-wip-t-remmet-phytec-de-bspimx95-132_upstream-v1-1-8deccd658d16@phytec.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129-wip-t-remmet-phytec-de-bspimx95-132_upstream-v1-1-8deccd658d16@phytec.de>

On Thu, Jan 29, 2026 at 03:13:33PM +0100, Teresa Remmet wrote:
> Add an optional device tree property, "ti,output-impedance", which
> specifies the output impedance using a raw register field value from
> 0x0 to 0x1f.
> 
> 0x0 corresponds to the highest impedance (approximately 70 ohms),
> while 0x1f represents the lowest (approximately 35 ohms).
> 
> This property allows the impedance to be configured through the
> device-tree to any required value rather than being limited to fixed
> minimum or maximum settings.
> 
> Signed-off-by: Teresa Remmet <t.remmet@phytec.de>
> ---
>  Documentation/devicetree/bindings/net/ti,dp83867.yaml | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/ti,dp83867.yaml b/Documentation/devicetree/bindings/net/ti,dp83867.yaml
> index 4bc1f98fd9fe..a8d8bfb68bee 100644
> --- a/Documentation/devicetree/bindings/net/ti,dp83867.yaml
> +++ b/Documentation/devicetree/bindings/net/ti,dp83867.yaml
> @@ -52,11 +52,20 @@ properties:
>      description: |
>        MAC Interface Impedance control to set the programmable output impedance
>        to a maximum value (70 ohms).
> -      Note: Specifying an io_impedance_ctrl nvmem cell or one of the
> -        ti,min-output-impedance, ti,max-output-impedance properties
> -        are mutually exclusive. If more than one is present, an nvmem
> -        cell takes precedence over ti,max-output-impedance, which in
> -        turn takes precedence over ti,min-output-impedance.
> +      Note: Specifying an io_impedance_ctrl nvmem cell, ti,output-impedance
> +        or one of the boolean ti,min-output-impedance and ti,max-output-impedance
> +        properties is mutually exclusive.
> +        If more than one is present the priority order is nvmem cell,
> +        ti,output-impedance, ti,max-output-impedance and last
> +        ti,min-output-impedance.
> +
> +  ti,output-impedance:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      MAC Interface Impedance control to set the raw register value from 0x0
> +      (approx. 70 ohms) to 0x1f (approx. 35 ohms).
> +    minimum: 0
> +    maximum: 31

How does this compare to 'mac-termination-ohms'? Seems like this should 
be a common property whether it's the same or for a different location.

Rob
