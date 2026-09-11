Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9963F438466;
	Fri, 11 Sep 2026 11:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789125920; cv=none; b=tSJmjPfIaNExQjg5aMoAHuj6Z+OQlwon9Vkkm42YIu7TbtjSnW+IIRgJlh5NdYQZ2qgApljvkj5Vq/YOCXc6tTe7TdyozouXTwb2LBNDrvGDaCS4qHvROb73x3VhWyDXPIQRcXYXwXYxMeQQYJkUgrQoP0zbCX9buobaZTHyBOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789125920; c=relaxed/simple;
	bh=YDO07ty55SZ/h7MjtNA43/8iHCK9KahWWNct3aH0gzk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kKzb2XBfjoHRGCCct61aKoD8WFTCZG1By7/QQohUdTnm24J+qJoKdzs+eD5xUIrfKw4nPEcFxB3T2PXQ6aW4BTAli6p+nb1N+y/XO6uhfHbzIVVhW9H6lJZ5045jp4dh7fCoJNT/dajVWsFLY93NCAHersju1LWMNqHZi6b9moo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XczocO6d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XczocO6d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75D4F1F00893;
	Fri, 11 Sep 2026 11:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789125908;
	bh=UTTG8yan6yVoKZGPEDLowwJNC987s9yGpXDxZ0pvHPw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XczocO6d55CVKrVVPATsFg2zy9sPS0Jxt22hCBVDF65gfZ3jm+YUfeomUJzOzLD3B
	 ntD0sMYNbEZML9W0CoFx1p7KeP5KBaNFZMAAKVS/r6cNo3EMEEQPtTNg17I/t3pFl0
	 yI0TiH3T5LZHy5pkGtpARjkzt7WIuOaS7rwAX9VeQSqaQEFRJJO/81gKVYj2zdZkGB
	 OHqSUoGDPsn+1fJgxNlmvjs3WcnjRZIC5Yw9oJGqec1HtJL6sWJs4Ldd1s409E5xsF
	 +cB3TdRh8iFYJER57+PZA4jVz3IFW9pg8usW7WPNeinfvYgirww97B88N5c+fFNssD
	 HR29fmBvobvSg==
Subject: Re: [PATCH net-next v2 1/9] dt-bindings: net: ti,dp83867: add supply
 properties
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
Date: Fri, 11 Sep 2026 11:25:07 +0000
Message-ID: <178912590701.219967.15448701667812128746@kernel.org>
In-Reply-To: <20260908-shikra_ethernet-v2-1-bbe3389d0652@oss.qualcomm.com>
References: <20260908-shikra_ethernet-v2-1-bbe3389d0652@oss.qualcomm.com>
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

- [Low] Reported concern (assessed INVALID): the binding patch adds four
  regulator-consumer properties (vdda-2p5-supply, vdd-1p0-supply,…

--

dt-bindings: net: ti,dp83867: add supply properties

This documents four regulator consumer properties for the DP83867 PHY
(vdda-2p5-supply, vdd-1p0-supply, vdda-1p8-supply and vddio-supply),
matching the two-supply and three-supply configurations described in the
datasheet plus the separate VDDIO rail.  Documentation-only change, no
code is touched.

No Link: tags present in the commit header.

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
One thing that came up while reading this in isolation: at this commit
drivers/net/phy/dp83867.c has no regulator API usage, so the four new
properties describe DT ABI with no in-tree consumer yet.  Is that
intentional for this patch of the series?

Checking the rest of the series answers it, so this looks fine as posted.
The following patch, "net: phy: dp83867: add regulator supply management",
adds dp83867_power_on() with:

  static const char * const supply_names[] = {
          "vdda-2p5", "vdd-1p0", "vdda-1p8", "vddio",
  };
  ...
          ret = devm_regulator_get_enable_optional(dev, supply_names[i]);

and dp83867_probe() calls dp83867_power_on() before dp83867_of_init() and
before any register programming in dp83867_config_init(), with the
datasheet stabilization delay applied there.  The supply IDs match the
property names documented here exactly, and the enable reference taken by
devm_regulator_get_enable_optional() keeps the regulator core's late
cleanup from turning the rails back off.

So no change is being requested here; noting it only in case the
documentation is meant to land ahead of the driver change.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260908-shikra_ethernet-v2-0-bbe3389d0652%40oss.qualcomm.com
