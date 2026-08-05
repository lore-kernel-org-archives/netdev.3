Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5774A229B38;
	Wed,  5 Aug 2026 14:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785939460; cv=none; b=mIhlNUst7/IU3gcfGSlGYj06X2pynyCYYJfonMQoHelzS2pkR3y1K16uqyD62O6D6cIbi5EhoXhnfD8CNpQCOjpZ16Sn8T3VtQBMPyfk2Uy28nIYKmMAXfW4g89hsK6jigxvWd32rPuOORJwzXpFR2L0oM5yvTCvbh9WaCf7lCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785939460; c=relaxed/simple;
	bh=GPGze19TDCPXf4nZX+4fdoAJtcow1ucuywe97ygxELc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A7Eq6F+VcsEb4LF2KjB5EMPllcnEAhLpeoFbs0PfrnlQbMOmyR18CVKJB9xnhH8bi3LlJbQJQQBDHyUEqMsPdZ4vT0GUOKpsRhzCW7dGafdTFrlkhz/nwFH0DRZkPnoIY0YfuSJ6z9AvDfTMmxc5Gkvrtj/Q/1PLFhwFgsqDKjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BTmyM5ty; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BTmyM5ty"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76BAC1F000E9;
	Wed,  5 Aug 2026 14:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785939458;
	bh=JDuXv4mytSaw3QUpQ4W/0Z9j0VJSFj4YqRtc976l3kw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BTmyM5ty0rO4V6Jhc9sL9DMndsBFHlqLTQgLY9LUoxFgvGpr2SC9LBcvTIdE5qgy3
	 VoIHsoyYSOoIgFoTdEkA4oZ1ZzvIZhgXymlnc4Tvu4YApXBwTAVrT269JzTQTSd3/C
	 UGjrmH+36Tw4L6TO5bnWMId9rWjTzIymEET1CU3TIRHlD6aHAwsmMkW9HYVohBAnSS
	 2aK+1y89RZsYhJt7Tz1WVkT46VJDLEh6j7+v8e0IlptUfgHy1Bwxlzer0IxHfj9Jou
	 8KjMuZdHwKtymSyblYhLz3+XH1lZ2maTo2wUJYwrF0VWpU6bxJgBavxS03UhcbWGhS
	 377MhFlw9Hc3w==
Date: Wed, 5 Aug 2026 09:17:37 -0500
From: Rob Herring <robh@kernel.org>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiko Stuebner <heiko@sntech.de>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	mfd@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH net-next v2 5/8] dt-bindings: net: x-powers: add AC300
 EPHY control
Message-ID: <20260805141737.GA715959-robh@kernel.org>
References: <20260804-submit-acx00-of-dynamic-v1-v2-0-3eef49ff1d8c@gmail.com>
 <20260804-submit-acx00-of-dynamic-v1-v2-5-3eef49ff1d8c@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804-submit-acx00-of-dynamic-v1-v2-5-3eef49ff1d8c@gmail.com>

On Tue, Aug 04, 2026 at 08:27:03PM -0600, James Hilliard wrote:
> The AC300 exposes its Fast Ethernet PHY control registers through a
> separate non-PHY Clause 22 address. The manual defines that address as
> the link PHY address plus 16, giving control addresses 16 through 23 and
> link addresses 0 through 7.

That's not a separate device, but just a second address range. You 
should make 'reg' have 2 entries.

> 
> Describe the control endpoint, its required VCC1 supply, its 24, 25 or
> 27 MHz input clock and its SoC SID calibration cell. The actual PHY
> remains a separate ethernet-phy node and supplies the MAC-selected
> interface mode at runtime.
> 
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
>  .../bindings/net/x-powers,ac300-ephy-ctl.yaml      | 70 ++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/x-powers,ac300-ephy-ctl.yaml b/Documentation/devicetree/bindings/net/x-powers,ac300-ephy-ctl.yaml
> new file mode 100644
> index 000000000000..8a616ff3e89f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/x-powers,ac300-ephy-ctl.yaml
> @@ -0,0 +1,70 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/x-powers,ac300-ephy-ctl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: X-Powers AC300 Ethernet PHY control interface
> +
> +maintainers:
> +  - James Hilliard <james.hilliard1@gmail.com>
> +
> +description:
> +  The AC300 Fast Ethernet PHY has a separate control interface accessed as a
> +  non-PHY Clause 22 device. Its address is 16 plus the address of the link PHY.
> +
> +properties:
> +  compatible:
> +    const: x-powers,ac300-ephy-ctl
> +
> +  reg:
> +    minimum: 16
> +    maximum: 23
> +
> +  clocks:
> +    maxItems: 1
> +    description:
> +      AC300 input clock. Its configured rate must be 24, 25, or 27 MHz and
> +      determines the corresponding EPHY_CLK_SEL value.
> +
> +  vcc1-supply:
> +    description:
> +      3.3 V supply for the AC300 I/O, bandgap, Ethernet PHY analog front end,
> +      and internal digital LDO

Sounds like this supply and clock would need to be enabled before 
accessing the "link PHY address"? If so, then 2 nodes is really a 
problem.

Rob
