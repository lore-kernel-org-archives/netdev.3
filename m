Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B992329D260;
	Mon, 14 Sep 2026 20:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789418819; cv=none; b=U1JHCCQxe2zHgMZht1LntpWQUlCCV9vay9HoKp2bibGGr8AJSBjFgwMPmZcw9ftNKkaqSCdxb9KozLIrGvtZ+rGb3LLRnHQJWdyvjCfW/f0aGhlyo03J9oY47GHsg0hNEiSjzMSmwUNTdmGWuazaJuI7HE2rKuGD9CTnQjLfENo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789418819; c=relaxed/simple;
	bh=UDzSfb4BwG6sGVb9E/qfHZLyZRA17sltkEQsWYJqHwE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a0Xoi/hdAR8Z7l0LxBBdWz19IscR7GEVby6t6MDB+UlpwcmaZDKICZGqHLDMtJYaRsj9ls5SIQv6WF6EUtYiNU0TS3dX8ZN1gg+nWq6MOeZqrJwl68L1HnO1D02NG98VGS14HoQ/+4ee3z2ISmLGHU6J1MNS3u61IXQnBpYmFzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kv5gQB1r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kv5gQB1r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5753F1F000FF;
	Mon, 14 Sep 2026 20:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789418818;
	bh=8o78y66u0vvIngvMECM8vbjVN71viUZnjA1J36HR0Ls=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Kv5gQB1rpViurVjFZd7MXsarJoFi6SsaLW9cj51xRoXOb+WMJl0pSNpvhHtbKRMDD
	 U5+4hFPIxziwIUMgJXL9vW9avT++o0GvE9rWmbPHMIwcyZQI0mJYQ68jxYGYgTflSY
	 zH6ptobiYa9yTpJ7nuidm19IRNGKjop6GsDOMWjuJX7OGeEai+PzGnqU4MPZ4W07LU
	 pGpZfE0IdJ7T2qP73zBgtb6Hfkr3wvOQb8zVG4QolXpn6co00hFl5UkmRdqlSsR1e8
	 hYYSHxOXFi8NunbqW8FlNiOl8qAmwrZeeYzcVEHK4ttSWbkDjWmIJ31Gpdc/mwC7LU
	 V5z0rQ2uQuJ3g==
Subject:
 Re: [PATCH net-next v13 1/4] dt-bindings: net: dsa: microchip: Add KSZ8995XA
From: netdev-bot+sashiko@kernel.org
To: linusw@kernel.org
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 marex@denx.de, horms@kernel.org, linux@armlinux.org.uk, nb@tipi-net.de,
 netdev@vger.kernel.org, devicetree@vger.kernel.org
Date: Mon, 14 Sep 2026 20:46:56 +0000
Message-ID: <178941881689.22033.5621078266167272370@kernel.org>
In-Reply-To: <20260913-ks8995-to-ksz8-v13-1-327b16d309eb@kernel.org>
References: <20260913-ks8995-to-ksz8-v13-1-327b16d309eb@kernel.org>
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

- [Low] Concern (validated as a FALSE POSITIVE, retained only because
  requires_validation=true): the concern claims that adding…

--

dt-bindings: net: dsa: microchip: Add KSZ8995XA

This adds a microchip,ksz8995xa compatible string to the Microchip KSZ
DSA switch binding. The commit notes the part was renamed from KS8995XA
and shares its properties, while KSZ8995MA and KSZ8995E are different
devices.

No Link: tags are present in the commit header.

> diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> index 8d4a3a9a33fcc..4ed13870ed3ac 100644
> --- a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> @@ -23,6 +23,7 @@ properties:
>        - microchip,ksz8864  # 4-port version of KSZ8895 family switch
>        - microchip,ksz8873
>        - microchip,ksz8895  # 5-port version of KSZ8895 family switch
> +      - microchip,ksz8995xa
>        - microchip,ksz9477
>        - microchip,ksz9897
>        - microchip,ksz9896

No regressions to report on this patch.

For the record, one point was checked and found not to be an issue: whether
the new compatible belongs in this file rather than in
Documentation/devicetree/bindings/net/dsa/micrel,ks8995.yaml, and whether any
driver matches it. Later patches in the same series add
{ .compatible = "microchip,ksz8995xa", .data = &ksz_switch_chips[KSZ8995XA] }
to ksz_dt_ids and { "ksz8995xa" } to ksz_spi_ids in
drivers/net/dsa/microchip/ksz_spi.c, along with the KSZ8995XA chip
description in ksz_common.c, so microchip,ksz.yaml is the matching binding
file. The only compatible-conditional blocks in this schema cover
ksz8863/ksz8873 and ksz8463, neither of which applies to this part, so no
if-then block needed updating.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260913-ks8995-to-ksz8-v13-0-327b16d309eb%40kernel.org
