Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD8A36AB77;
	Tue, 15 Sep 2026 23:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789515409; cv=none; b=QRfJG2uXklYBvNUI9aAKhWZzEmngjMn1pSDwCIPiSJGGyTkaJ9J/8oqnOe6V+wzJZllFSMwyQ6z7XqqG9sFvhSM/n+WxZN2kEyrWH1nEUEqXhUDZhNEK6KrVryx0tkZuXzeHmQsVwHMZL6tuzhmlddFtm0b6rHu32SUFvVrPqMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789515409; c=relaxed/simple;
	bh=RtyTdpKvqSxnyYQ5VRFitwCi3WRQTWVKpP6/vdtdbwE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=orVmaHooxUGz3WBYQcUXY6lmhajiIO9FcHn87fw4u078t7nyTSnZzwwCUs8EWsEpRhcI3iOuHDzE+fVvFM1u0wztwg/kzLi9gDrsmuBCWhTL3JrBGOKww2rJfy1nMKhbkaGDAB7syQnfG0WqlgP3zQvtRvw+ElJqlVOVt0xYesw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WRhuGBTw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WRhuGBTw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 389061F000FF;
	Tue, 15 Sep 2026 23:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789515408;
	bh=INkcnMUGl36Q6k3gE/mUr015tmdSW5mC7l/9957Q9aY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WRhuGBTwWvvw5B9032Z+n6q8K4TJHy9wwaxCQURm9xojrQEiHgZhAlHf3aW+xosR6
	 WGa+im1lQNX5nqW61e+copgxzOcJmbZrxQJbfUbNyRX38ZrDD+NoQxbC/5b9c9838h
	 QOA65BtMrFZ+fwrhG4PXjD9neastRrWBjH9NUYrWdMC0VMgYjMnypOGYBj1QXMeuZc
	 ln1DDb9aWr0lUo3EIwGYpdBct1MAAqeWyqOE76ht0uGIQK54Bn7bblAIOSlwEBV0vn
	 JIuNDf4BVieZJQOy3VBwV7vaERRBulcdW86b7IxiOXqHnMUqlcNy12+Vuhz8xPD1e1
	 OP+Lg6Rar2HGg==
Subject:
 Re: [PATCH net-next v14 1/4] dt-bindings: net: dsa: microchip: Add KSZ8995XA
From: netdev-bot+sashiko@kernel.org
To: linusw@kernel.org
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 marex@denx.de, horms@kernel.org, linux@armlinux.org.uk, nb@tipi-net.de,
 netdev@vger.kernel.org, devicetree@vger.kernel.org
Date: Tue, 15 Sep 2026 23:36:46 +0000
Message-ID: <178951540672.22033.5965330247410897822@kernel.org>
In-Reply-To: <20260914-ks8995-to-ksz8-v14-1-3d72692b3c97@kernel.org>
References: <20260914-ks8995-to-ksz8-v14-1-3d72692b3c97@kernel.org>
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

- [Low] Concern (validated as resolved within the series): the new
  compatible `microchip,ksz8995xa` added to…

--

dt-bindings: net: dsa: microchip: Add KSZ8995XA

Adds the compatible string microchip,ksz8995xa to the Microchip KSZ
series DSA switch binding, described as having the same properties as
the KS8995XA. No Link: tags were present in the commit header.

> diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> index 8d4a3a9a33fcc..4ed13870ed3ac 100644
> --- a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> @@ -23,6 +23,7 @@ properties:
>        - microchip,ksz8864  # 4-port version of KSZ8895 family switch
>        - microchip,ksz8873
>        - microchip,ksz8895  # 5-port version of KSZ8895 family switch
> +      - microchip,ksz8995xa

[Severity: Low]
One thing that came up while reviewing this in isolation: at this commit
there is no consumer for microchip,ksz8995xa, so a device tree using it
would not match anything in ksz_dt_ids[] in
drivers/net/dsa/microchip/ksz_spi.c and ksz_spi_probe() would bail out.

Checking the rest of the series resolves this, so this looks fine as is:

  drivers/net/dsa/microchip/ksz_spi.c:ksz_dt_ids[]
	{
		.compatible = "microchip,ksz8995xa",
		.data = &ksz_switch_chips[KSZ8995XA]
	},

  drivers/net/dsa/microchip/ksz_spi.c:ksz_spi_ids[]
	{ "ksz8995xa" },

along with the ksz8995xa_regs[] register map and the KSZ8995XA entry in
ksz_switch_chips[] in drivers/net/dsa/microchip/ksz_common.c, all added by
"net: dsa: microchip: Support Microchip KSZ8995XA / KS8995XA".  The
alternative placement in micrel,ks8995.yaml also does not apply since
drivers/net/dsa/ks8995.c is removed by "net: dsa: ks8995: Delete surplus
driver" in the same series.

Should the placement of the compatible with respect to the existing
allOf/if blocks be double checked too?  The microchip,ksz8863/ksz8873
3-port block and the microchip,ksz8463 straps block both look inapplicable
to a 5-port KSZ8995XA, so as far as I can tell no existing conditional
needed the new string added, but confirmation would be useful.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260914-ks8995-to-ksz8-v14-0-3d72692b3c97%40kernel.org
