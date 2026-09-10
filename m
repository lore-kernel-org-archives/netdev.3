Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813A7486B8F;
	Thu, 10 Sep 2026 15:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789052673; cv=none; b=sGKjHeu9DEp8Uqs6VcNEK/hyJjSrrBvbWPxJgnpCl8+wFawE+gw21MFQ8g+QPtFcVg8CETgOQsF4I0J9+tYof5klV5j7huI89mpFNVknfZPLOCmz/iMsssgHEi39fzW33MlEcQGNDf0lleJJhLSKAXgkv5WJ3ewcw9Gx3mB9DCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789052673; c=relaxed/simple;
	bh=47BZ8IVkJhzIuCQmjPgWg6l7pwEQ6070pwcJB2CPlYU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i77qrCNZ6oF7nU6YKrv6WXtag/FOTgDZdQOt1TLlh4F9I80/fyVyym+9msa8tyl4A2+HceRhNUYhSw433jDYDXhrjVfuNm1S/DUQ6YUw2L1GGt8sWjipXL9CVKrSr93xjVyOPO5yZ0KCFCP6gB7PCWm3bLBBwnro6991/kl4pl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fo9jA6Jo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fo9jA6Jo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9606B1F000FF;
	Thu, 10 Sep 2026 15:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789052670;
	bh=1hDS7Ux89QAOdyzyNUYM7H70Xe8CR/zN6jWfreP8qyY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fo9jA6JoTunKNHq14P3jR0EQqmMBh0mbO8Bl1KYMiCJYaNhPGOtiPLuAf/ND6hpfB
	 Qy65W23iBfaDXKUfq76d+LyZ7cllRvH91UgLBZh3RLXGyKOuy1bmefIGaltdfqVPjg
	 5WNEZZcKs0p3wYPmYHZm/2S/MXlC/kESxqhIxPLHgMa3zVpJf7lYt3bOQXVw8nWyMq
	 2CgJXKzEIrc9G/ItEOJ5rVmRYpZJCAOMhfeOMiRd4pGLXQx7h6hO+zUYF3XEpuPmDu
	 UZWK2i5jUKI5XMk8kQeoKn/EdKWfEYV4BswKEO5mkaeIKhbRL+GHcTsKZnlnwsDaNp
	 3aX4VROu4Btaw==
Subject: Re: [PATCH net-next v3 1/4] dt-bindings: net: realtek,rtl9301-mdio:
 Add clock-frequency
From: netdev-bot+sashiko@kernel.org
To: markus.stockhausen@gmx.de
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
Date: Thu, 10 Sep 2026 15:04:29 +0000
Message-ID: <178905266913.219967.14055923312447045014@kernel.org>
In-Reply-To: <20260909150107.3602067-2-markus.stockhausen@gmx.de>
References: <20260909150107.3602067-2-markus.stockhausen@gmx.de>
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

- [Low] The binding documents `clock-frequency` (with `default: 2500000`
  and per-family enums) for the `mdio-bus@N` children of the Realtek…

--

dt-bindings: net: realtek,rtl9301-mdio: Add clock-frequency

This documents a clock-frequency property on the mdio-bus@N child nodes of
the Realtek Otto switch MDIO controller, with a default of 2500000 and
per-family allowed value sets expressed through new allOf if-then blocks.
No clock reference is added, since the setup bits are not documented as
dividers.

No Link: tags are present in the commit header.

> diff --git a/Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.yaml b/Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.yaml
> index 67e0b23a8470..88502d017eed 100644
> --- a/Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.yaml
> +++ b/Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.yaml
> @@ -56,6 +56,9 @@ patternProperties:
>        reg:
>          maxItems: 1
>  
> +      clock-frequency:
> +        default: 2500000
> +
>      required:
>        - reg
>  

[ ... ]

No regressions found in this patch.

One item was checked and dismissed: at this commit there is no consumer of
clock-frequency, since otto_emdio_probe_one() in
drivers/net/mdio/mdio-realtek-rtl9300.c reads only reg. The driver side
arrives later in the same series with "net: mdio: realtek-rtl9300: Support
non-default clock frequency", which does:

	if (of_property_read_u32(node, "clock-frequency", &freq))
		freq = 2500000;
	err = priv->info->set_bus_frequency(bus, freq);

so the default of 2500000 and the per-family value sets documented here are
honoured by the end of the series.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260909150107.3602067-1-markus.stockhausen%40gmx.de
