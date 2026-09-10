Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFBC414412;
	Thu, 10 Sep 2026 20:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789070521; cv=none; b=sZq1wTi2gcomFqBBNM4CjzODAzkKZwqsolqtrbpFgzbOvl5DvJmOFNHKVkbk9uXeZNXb8iZcxIG/U9/sS8pqMLQ61ze1nMO4Wegnx3WYD/ry/t26HPOJCaWNbpockHB+UZauk/dRY0O+fwKCLXo0u6i6VQ2u2LgCapEgp4BP7l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789070521; c=relaxed/simple;
	bh=BsXqWD5IxXOC326mBgwhSwE9X0rFyG9iRier3U3acEY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Fgb+Hwyu14yjwEUj9dmKlUUJIpSoI+V0VErsTblH0HyFhlBGtBeg8TK1QCAIl4RmREL6OltsUUczixIAvGtlh1MBoHXF6+FBRs69oKH0rFg9XX1PSiY+Q30jSkYQh2aLDkZF2ghjGh7T8UR7aypm0ApntKxaqRWF4EXuaUBKvgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FvrF0IIC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FvrF0IIC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B07FF1F000FF;
	Thu, 10 Sep 2026 20:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789070519;
	bh=U7KuJTk7vnxnG/iu9ZQo46wJ57lDbx9Y3FbMn3PRZyU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FvrF0IICfdb9Yv2M6uss86cNSeDOqwGJf+fsbMNxBNF7P6dwyO+Y4J8xapPsTo1Da
	 h5yFhKvrzSH4jqTjEF9tb/0xyDIZVjkkrXHo6yxicNCbGZ+l2H6xi4QVI0/vq8zbPs
	 5k7sXpnx7S8bCIXqBkFMCyhfb+5ax+1S33cgx5CqWueunqc/a2obT+ATG3V+q9WlLR
	 T5nlBoGrFYlrD0a4BoA23sAjpC4tG50s/72PbDnrCh89UZuonXIxNR5ITKsT7qbcSM
	 MCkKUkfIYVlxIgokDocZs2u1+TMKj9eivR1X1YiaHKzlNIVbLP2Ye7fprze7ZMumLd
	 VuJ4kXtQc30Pg==
Subject:
 Re: [PATCH net-next v11 1/4] dt-bindings: net: dsa: microchip: Add KSZ8995XA
From: netdev-bot+sashiko@kernel.org
To: linusw@kernel.org
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 marex@denx.de, horms@kernel.org, linux@armlinux.org.uk, nb@tipi-net.de,
 netdev@vger.kernel.org, devicetree@vger.kernel.org
Date: Thu, 10 Sep 2026 20:01:58 +0000
Message-ID: <178907051821.219967.3256918514060835882@kernel.org>
In-Reply-To: <20260909-ks8995-to-ksz8-v11-1-0e04411a559d@kernel.org>
References: <20260909-ks8995-to-ksz8-v11-1-0e04411a559d@kernel.org>
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

- [Low] Claim: the newly documented `microchip,ksz8995xa` compatible has
  no in-tree consumer — no entry in ksz_dt_ids[]/ksz_spi_ids[], no chip…

--

dt-bindings: net: dsa: microchip: Add KSZ8995XA

This adds a new compatible string microchip,ksz8995xa to the Microchip
KSZ DSA switch binding. The commit message notes the chip was renamed
from KS8995XA and that KSZ8995MA and KSZ8995E are not compatible.

> diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> index 8d4a3a9a33fc..4ed13870ed3a 100644
> --- a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> @@ -23,6 +23,7 @@ properties:
>        - microchip,ksz8864  # 4-port version of KSZ8895 family switch
>        - microchip,ksz8873
>        - microchip,ksz8895  # 5-port version of KSZ8895 family switch
> +      - microchip,ksz8995xa

[Severity: Low]
This isn't a bug, just a note for the record: at this patch alone there is
no in-tree consumer for the new compatible, so a device tree using
microchip,ksz8995xa passes dt_binding_check but does not bind.

The driver side arrives in the later patch of the same series, "net: dsa:
microchip: Support Microchip KSZ8995XA / KS8995XA", which adds:

drivers/net/dsa/microchip/ksz_spi.c:ksz_dt_ids[] {
	...
	{
		.compatible = "microchip,ksz8995xa",
		.data = &ksz_switch_chips[KSZ8995XA]
	},
	...
}

and the SPI alias in ksz_spi_ids[]:

	{ "ksz8995xa" },

So the skew only exists between patch 1 and patch 3 of the series, which is
the expected ordering for bindings-first submissions. Is the intent that
both patches land together in the same merge window?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260909-ks8995-to-ksz8-v11-0-0e04411a559d%40kernel.org
