Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDC23BFACC;
	Wed,  9 Sep 2026 21:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788990434; cv=none; b=nkg7eJ6NsJymBdCl/FgQi2aYoxD7wTVb5khjLrnfKo108qS5lXiN9bsA/9bKnNAGmB+BmLIZWZcVnqCxXklyUGSvX7zKexsXpX5SLCMSuPUxYqPfJRtpZ4+cDajQKVjv8vLx4PmlxBRXRmU2xAgr2ex/aGJBFkbN2TFha+6OVDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788990434; c=relaxed/simple;
	bh=PttVx/ZUCS3iUKjrDv7JX04JrZYSS5c4PkRppv3kF7k=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ee7ySi+jR+Q7iwRDJLQYLDscrf+mwN82eoS2qIcGuD3wRof3+arusb13Avukt67XKWp/WM8mYBLLLHbfARTslDsv41b++nznxgAYsxUctBe4Le/fnVJdP5c0oZjR8dS073TyYPfioe32Rvv5f6Rz/OC2nzL1W77BXCpxPzag4FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CM1jE2ki; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CM1jE2ki"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 389131F00893;
	Wed,  9 Sep 2026 21:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788990423;
	bh=uuFvVYJoHxWOPg4L2VXKOq9qm6k3RQC4qvQt29QFY6E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=CM1jE2kirabr4C5dOeOZ2560aTwcLVhyPTUAHRsttFxvpRgkVWzRJ9Ekh/hNoxcvL
	 UxgjS6Co3KYEAQMzM2d29g7h2SWKs9UZc9/r9jnE5R6gPI14ZrBut/+j4UiOKVlhfT
	 2a37wMtyuEgP3ewBAOYQ3rNo6Jbz67ELGlwrBOIXTDilIInXMREvA/rv+8wLA0+tUV
	 RV13YFofjVRsKQ00NMBDSMnQiY8EcuLoyo1gcQfxzhixL2cU4RXUy9J2fftU440S34
	 ++fflDx0zFlF3qFA3DkY/R7voVNK9CG7XqyAUVpSEWS/uDUT6FSOmYWCFg023yUhZx
	 WGZek9RmvVrNA==
Subject:
 Re: [PATCH net-next 1/9] dt-bindings: net: ti,dp83867: add supply properties
From: netdev-bot+sashiko@kernel.org
To: mohd.anwar@oss.qualcomm.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, afd@ti.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, richardcochran@gmail.com, andersson@kernel.org,
 konradybcio@kernel.org, alexandre.torgue@foss.st.com, peppe.cavallaro@st.com,
 joabreu@synopsys.com, maxime.chevallier@bootlin.com,
 mcoquelin.stm32@gmail.com, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
Date: Wed, 09 Sep 2026 21:47:01 +0000
Message-ID: <178899042172.219967.3850665440981574441@kernel.org>
In-Reply-To: <20260904-shikra_ethernet-v1-1-a50765996035@oss.qualcomm.com>
References: <20260904-shikra_ethernet-v1-1-a50765996035@oss.qualcomm.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 0 · Low: 1

- [Low] Concern (invalidated): the four newly documented supply
  properties (vdda-2p5-supply, vdd-1p0-supply, vdda-1p8-supply, vddio-…

--

dt-bindings: net: ti,dp83867: add supply properties

This documents four power supply properties for the DP83867 PHY
(vdda-2p5-supply, vdd-1p0-supply, vdda-1p8-supply and vddio-supply),
matching the two-supply and three-supply configurations described in the
datasheet plus the separate VDDIO rail.

> diff --git a/Documentation/devicetree/bindings/net/ti,dp83867.yaml b/Documentation/devicetree/bindings/net/ti,dp83867.yaml
> index 4bc1f98fd9fe5..e78f08ded3d0d 100644
> --- a/Documentation/devicetree/bindings/net/ti,dp83867.yaml
> +++ b/Documentation/devicetree/bindings/net/ti,dp83867.yaml
> @@ -118,6 +118,20 @@ properties:
>        Transmitt FIFO depth- see dt-bindings/net/ti-dp83867.h for applicable
>        values.
>  
> +  vdda-2p5-supply:
> +    description: 2.5V analog supply (connected to the VDDA2P5 pins).
> +
> +  vdd-1p0-supply:
> +    description: 1.0V digital core supply (connected to the VDD1P0 pins).
> +
> +  vdda-1p8-supply:
> +    description: 1.8V analog supply (connected to the VDDA1P8 pins).
> +
> +  vddio-supply:
> +    description: |
> +      I/O supply (connected to the VDDIO pins). The supply can be 1.8V,
> +      2.5V or 3.3V.
> +

[Severity: Low]
One question came up while reviewing this in isolation: do these four
property names have a consumer anywhere?

Looking at the rest of the series, they do. The following patch,
"net: phy: dp83867: add regulator supply management", adds
dp83867_power_on() in drivers/net/phy/dp83867.c, which walks exactly
these names:

  static const char * const supply_names[] = {
          "vdda-2p5", "vdd-1p0", "vdda-1p8", "vddio",
  };
  ...
          ret = devm_regulator_get_enable_optional(dev, supply_names[i]);

and dp83867_probe() calls it:

          ret = dp83867_power_on(phydev);
          if (ret)
                  return ret;

So the names match and devm_regulator_get_enable_optional() handles the
disable/put on teardown. No change requested here; noting it only so the
binding-only patch is not read as documenting unused properties.

One remaining observation, and it belongs to the driver patch rather than
this one: a rail such as VDDIO that gates the MDIO interface itself cannot
be brought up from a PHY probe callback, since probe only runs after the
PHY ID has already been read over MDIO. Is that ordering expected to be
handled by the MDIO bus or board regulator-always-on instead?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260904-shikra_ethernet-v1-0-a50765996035%40oss.qualcomm.com
