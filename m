Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793776567;
	b=siKptpaNZ74/+a1LogHSyMjwphHnk90clNqAc9XSgXhoOhgsjF22nQJYfxD4d8eO+2e+
	 IAz9ImpAi+pQ3VqKHyQAcwgycuS6DVvveozNuT3xsUKSoDBmRpTgVNzOqJwHDd0OeAZhF
	 08NLuEF5UrWU0JasEvpJvNulPP1XJv5jrQolghyu6vGQxfwhIzKVXhWjFWKKXCvJIGw1a
	 Fd6KXp1Q/qdIpugrF2XXxESf/EgDj2Rl3gDNFZ93R5aR/olYLw9kp4Z5diKZrOjdnC1X0
	 I9HZBgsZbPEszz+r1JilYLs0AubZfE0eIPWoIi3N+Hy40MZecnqM1gslZsqxcVFw8sg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793776567;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=JzJ2sm0HA7zLXXojD+Y1kRVDhkZ262+huPCc7+3eLx0=;
	b=xUTsqguRlmWNUe92OGzRtv5wjaEmK0FCGUDPStCuWfGkQncw6wB8nlsnbrfzT/dh0GVa
	 6/pXOjB127KeGzgrjjiOkvved48yY88jxA4DeBCFbSl5yi3t3OWQ9mgnku2KemefneUgw
	 ie1tyCcPfYn3erfQJeyoBoO//SvHc0SFbbflw3mSufIlthENqbAMd8cMvhq8F9PY8ay+B
	 kduB6Md43LEBy/QXaNf/ytyrqMI2a3YtoqNbBZUtC/y1Sbp6XkrqFJFKXW4F9V9NuSJhP
	 ACEMVGU/LoCEBRJYF/ThhTxLLrM6EtDD8LylYe84xuellcNvEt1bu89RMDLH8XACvSg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MQGvag4+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5122606D802;
	Wed,  4 Nov 2026 07:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MQGvag4+
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793776566;
	b=pYzQf29xVYYd/D1tJtSEO56B0PxEZS1RdqeLYTV27FWq/eSSTJcdv4eImSmdjuYlI78I
	 8h2lvfaUSQjB2hyn949mUQIVSigWcgVOf1YuhwympQeYnXzQapIVyjUqir2cZvEbgm0ze
	 hp5v+78OgCPam7N9t1tjZhd88/FvjHSuOooaTP/ZHN2RGauBbozNtAvULpeFEfqDDg9DB
	 3JsDT4LuVUALc6kCdyWi4kBckky7GRFtY0mLhqN5S1NnS+KgrjwSqftJPHSVHwFPjVoMX
	 GrssQPCd7ihxchcCWSfugAl2j3HhGamG/YvllsrdhM7nE/W6/3wXUlWZ8JRpIO5GLHA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793776566;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=JzJ2sm0HA7zLXXojD+Y1kRVDhkZ262+huPCc7+3eLx0=;
	b=EP8YHS/gsejHYDMZBC1oov0OcLNVZsLOljwsIlylI2RWAilJ0jcGcr8ocx3FDYv8kidi
	 WfxP3cu7RTv8RTw/u3wDEW6Vh/+XIlglPM/DdswXau7s7nArK6l92e5X1bEd2KmBzXiRg
	 XTrRMVrjPO/UPmDvUfFKtYN1RMXgdvesyJdItoykg3rO5H0BG3gB2xQOEdWwwAILshWQs
	 D3C220ZPo4V6+vQyFM6APEbYLwHZqWim62yU6MiCGDO7Lm51DyIAQDta2Ln5odMR1JbwJ
	 0jLqgBxill4SsvSrQQEvWN2NqrrByLj6rAGC5JT59yRX2Wh1HsKaNP8n9GkbFWznZ9g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 6DA991F00A18;
	Wed,  4 Nov 2026 07:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793776566;
	bh=JzJ2sm0HA7zLXXojD+Y1kRVDhkZ262+huPCc7+3eLx0=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=MQGvag4+efWse/63asdymDzI/VQ/GnsoDSAqxmnmlxad/7BsoMk9a1JuntHzmNuWB
	 7JVRA1elo483WuzpLKtcjQVNDt45hYZ+va93renrUVZQp/Kb61/H7SRfdMZsTrPI5s
	 GQlqJ1ccI0Yq1AeN9vXD4qAO5SP/TAV9JoGxamnJZJExLROqnwPAuSI5aS8iulXddE
	 9tG5LlsgR0yvpyJL0fqa5Evxdp2lmBgaIUvbI6Kcz9VTftDtsVUrYWBMW+xWgFfku1
	 GrfCavJXJd0ot4f3P9bsAoEhujphxm95NTLrDTFleMWHjDLhSPOeMByUQQV+efjGs1
	 520EMwUbe5CXw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D824046CBB;
	Wed,  4 Nov 2026 07:16:04 +0000 (UTC)
From: Joseph Telaak via B4 Relay <devnull+joseph.telaak.dev@kernel.org>
Subject: [PATCH net-next 0/2] net: dsa: mxl-gsw1xx: reset the switch
 through reset-gpios
Date: Wed, 04 Nov 2026 02:15:46 -0500
Message-Id: <20261104-mxl-gsw1xx-reset-v1-0-53839bf5c88e@telaak.dev>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKLb6moC/yWM0QrCMBAEf6Xcswe9BKr4K+JDG7f1RKPkogZK/
 72pPg67MzMZksLo2MyU8FHTZ6wgu4bCtY8TWC+VybWuE2kdP8qdJ/tKKZxgyOz3fTj4bvAygqr
 2Shi1/JInivUQUTKd/4u9hxtC3oq0LCsNFKCWfgAAAA==
X-Change-ID: 20261102-mxl-gsw1xx-reset-37ac836b31fe
To: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joseph Telaak <joseph@telaak.dev>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793776564; l=1736;
 i=joseph@telaak.dev; s=20261104; h=from:subject:message-id;
 bh=igALwEyK9Wac7PwuwvoflBG0rSNJJThjoKwT2Oko4+Y=;
 b=wNMJC2Z2oeJ+jBMsYQPSXXLdKSUIRlF3rnM+ntL60bXTQ7yZk3yvsp996s1eeXdU7ZF/c19Pf
 +lPxoUdEpmjDZPLnTCTai8hnYFBtOcJ2ftgtGvU8cw5wX1q+fn5EmF0
X-Developer-Key: i=joseph@telaak.dev; a=ed25519;
 pk=oQI+UfddlZ0wK2ac4WKOGNjUl1ZEN8j9ZVFSqEDoNP0=
X-Endpoint-Received: by B4 Relay for joseph@telaak.dev/20261104 with
 auth_id=1404
X-Original-From: Joseph Telaak <joseph@telaak.dev>
Reply-To: joseph@telaak.dev

The GSW1xx driver never resets the switch, and the MDIO core does not
handle reset-gpios for non-PHY devices, so the driver works with whatever
the bootloader configured. On the GL.iNet GL-SFT1200 (SiFlower SF19A2890 +
GSW150) the bootloader leaves the internal PHYs one MDIO address too high,
and the WAN port has no PHY.

Patch 1 allows reset-gpios in the binding for the standalone switches.
Patch 2 pulses it at probe.

This is separate from commit 82e2c7db0830 ("net: dsa: mxl-gsw1xx: force
internal PHYs into a known reset state"), which only programs the PHY
bits of RST_REQ. On this board that commit is applied, and the PHYs still
sit at the shifted addresses; only a hardware reset of the switch moves
them back.

Tested on a GL.iNet GL-SFT1200 (Intel GSW150 / PEB7084 at SMI address
0x1f, reset on an active-low SoC GPIO), on the 6.18 backport that OpenWrt
carries: after a warm reboot and after a cold power-on, all three ports
find their PHYs at addresses 0 to 2 and link at 1 Gbit/s. Without the
patch, port 0 fails with -ENODEV after every boot.

The board's device tree goes to OpenWrt; there is no in-tree user yet.

---
Joseph Telaak (2):
      dt-bindings: net: dsa: lantiq,gswip: add reset-gpios
      net: dsa: mxl-gsw1xx: reset the switch through reset-gpios

 .../devicetree/bindings/net/dsa/lantiq,gswip.yaml        |  6 ++++++
 drivers/net/dsa/lantiq/mxl-gsw1xx.c                      | 16 ++++++++++++++++
 drivers/net/dsa/lantiq/mxl-gsw1xx.h                      |  4 ++++
 3 files changed, 26 insertions(+)
---
base-commit: 4dd16e31135ea8437a720222df34e8745f385d6d
change-id: 20261102-mxl-gsw1xx-reset-37ac836b31fe

Best regards,
--  
Joseph Telaak <joseph@telaak.dev>


