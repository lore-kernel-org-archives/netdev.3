Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAEB3CB54D
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 07:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791875684; cv=none; b=T3PEDbpFEZSdlaDMu+BR7XwrQw0tLQhaILezxzQaFrC4fubAK5HQ8cwqojnMv9mF2VOHPe7Q8lKu0G9b6AoQ4Id5jKmEfhEuy3x6OVPKWGERCu5CWIHB5IK/mL3vN34WkrzBXxPN5q50Rst4CnGVNFU3KonAA+WVNgxclGyXsoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791875684; c=relaxed/simple;
	bh=cXTuVa3KGjH8lyOe0ao4EW5q0wlCixpiZlI7i4j48U4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LM/X+2pfciU4ZD++jGhdCPHJL9omD9gFCyi288Sf4e9IZrZmxU+k/Pv2/wo3JAWD2mwS9GeffbzZ0EACQZ/sxU0r9Qu9Bo3GS8r9LQ+AdCCAgNhBeWo7DZSY5KhlIir90AQG6GW3wUVhqMyM8t1RVNz4nmJQM2AYQgz0nIbSPg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Bk8fI6Nn; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="Bk8fI6Nn"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48b03f23305so2172475f8f.1
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 00:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1791875679; x=1792480479; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N/3uZKTyrNaRvsXwszDYWZ0D2uuc7O2dM/xJ/2Buikg=;
        b=Bk8fI6NncvVLBjXXXxFmxyBnmtq+i7ERE6tKWEMKRR0oGSc+H7TrU9BxN/qzyRrDm3
         hqTpFiqdTqnrzn+T/4L0zfkzFFOSgSltMbQkRk19KWrq78v/X6RqlUHYXIJia5BnpsP9
         njM9nEWdPQXoyymKcXuXeaALmaubAr9X79CofOrkrXOTEMIxWATxozSsa3hfQz82vFCD
         VRrI+Waayr7TAngKYOnORh2HQB4oqzbqGwlBugpkm4atJEZMsxm8iThfpbwXaC3YI5oW
         N9u8CFhOOTlwWLHz3XKUObSQN+mGM+yNRnaJihZWd5mApwcHwDOlgnJAENgdu0/lMT8p
         vt7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791875679; x=1792480479;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=N/3uZKTyrNaRvsXwszDYWZ0D2uuc7O2dM/xJ/2Buikg=;
        b=YO9MVma3IhbPtBKQ7MZ3e+ZX2qqFoxGJEf/BMnL/pMQSArQkeoxd5iqQoM9kuroNb0
         SZfBcAwFitMj3LmdBlhlC8Egq4ECEGjt8vLR17GDn+pEu36DbS0EOrgJCpaWmTV2anT0
         7mibKoXNXMWXSQMXeEaLXTWR0bo/tn3R8bdxCFZq0JtWXn6UNv0BTW36mTCITdCLPB4l
         e0xcxXqaR6pP0nRc/wT1DKAR3ZjYuaAvJf3NgAlr9qaXT/0/Yjf6t9kXeXexyzBVw0nq
         PTvOVfGNkVMoB23joVbBfJ0DPwXwcbr7Z5TwoVJcf8TXFd+msN+a60JA2l4vu1tG8wnk
         XT8g==
X-Gm-Message-State: AFq9FYKsyEbGwOQfFUHh2L/Ipl9z1yaehJHDlkmqHZbeLpwo2fdKu2Lg
	FM/MiOEZkKdY0xdISQRqZjNGjaB03LAG4YHUQUuCVYsABb/Olzz0RizikNO/aP23dN8=
X-Gm-Gg: AYBFou2BlyYjV3DYYVBXJg4skFEA+4fKgax0ZYsPwPpQO3J3xltHkP2mYRE0yRwXgBh
	7yD84NYjv9AlqBA7Jwk07foAeH7Gs0vQFWFOk9OFowBK3rKe63Ho/gkk9Z/lZ8rpF/5NN0XL1MH
	xgzKcl9yCu2lu1XQjCFOYS6uvZtTtPaYqnBQILmP4R3kiWmWIfzcctx47GHoaTXPlWrzU+65vy6
	3oHortEa0eb0wuNVMGCpQBNER+ua49/PdP07N4RthNW9ANnFewv6pBnfvBojuDCOOt6OEqMOcz6
	E5zUGHfH1idVFAkEWBFcr+GkInH4pkJETUE7xpNHqGSnw1q4NPy9PLWl7TmicFyRW2/3o4UY0Oz
	XsgIC3pprHIO4lRCa072qzn8WX5ICP32I3+VR5+SIXZfeixTGcphKxqBUOcaMrdRz7obPW/YTOj
	/eYTjkPU0YVf6XItRakWHDW7xsSIuxDL57NNzpL/cStDc9+CW4xvpESQ6/cqQXc/Y7Ps5KGha8B
	t+GVzLyeAg1/oss4g==
X-Received: by 2002:a5d:5846:0:b0:48b:180:b900 with SMTP id ffacd0b85a97d-48dbaadb302mr21043691f8f.16.1791875679329;
        Tue, 13 Oct 2026 00:14:39 -0700 (PDT)
Received: from localhost (82-67-6-57.subs.proxad.net. [82.67.6.57])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0ab5b03sm3925157f8f.30.2026.10.13.00.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 00:14:38 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Lucas Tanure <tanure@linux.com>, xianwei.zhao@amlogic.com, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Neil
 Armstrong <neil.armstrong@linaro.org>, Kevin Hilman
 <khilman@baylibre.com>, Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 8/8] dt-bindings: net: ethernet-controller: tabulate
 who adds the RGMII delays
In-Reply-To: <20261010105900.247342-9-tanure@linux.com>
References: <20261010105900.247342-1-tanure@linux.com>
 <20261010105900.247342-9-tanure@linux.com>
Date: Tue, 13 Oct 2026 09:14:38 +0200
Message-ID: <1jqzhu9in5.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On sam. 10 oct. 2026 at 11:59, Lucas Tanure <tanure@linux.com> wrote:

> The informative section explains in prose how phy-mode, the delay
> properties in the MAC node and the mode handed to the PHY fit together,
> and says itself that developers often get this wrong. A reader has to
> work through several paragraphs before answering the one question they
> usually have: for this phy-mode and these properties, which part adds
> which delay.
>
> Add a table that answers it at a glance, with one row for every
> combination the properties allow.
>
> Assisted-by: LLM
> Signed-off-by: Lucas Tanure <tanure@linux.com>
> ---
>  .../bindings/net/ethernet-controller.yaml      | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/net/ethernet-controller.yaml b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
> index 1bafd687dcb1..bba27a9feb61 100644
> --- a/Documentation/devicetree/bindings/net/ethernet-controller.yaml
> +++ b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
> @@ -339,6 +339,24 @@ additionalProperties: true
>  # has added. Failure to remove the delay will result in a
>  # non-functioning link.
>  #
> +# Put together, with the two properties in the MAC node, this is who
> +# adds each delay:
> +#
> +#   phy-mode    tx-internal-delay-ps  rx-internal-delay-ps  TX delay    RX delay
> +#   rgmii       -                     -                     PCB trace   PCB trace
> +#   rgmii-id    -                     -                     PHY         PHY
> +#   rgmii-id    present               -                     MAC         PHY
> +#   rgmii-id    -                     present               PHY         MAC
> +#   rgmii-id    present               present               MAC         MAC
> +#   rgmii-txid  -                     -                     PHY         PCB trace
> +#   rgmii-txid  present               -                     MAC         PCB trace
> +#   rgmii-rxid  -                     -                     PCB trace   PHY
> +#   rgmii-rxid  -                     present               PCB trace   MAC
> +#

That would match how the HW is working on the A733 Allwinner too but I'm
not entirely sure this is what Andrew had in mind from our previous
discussion [1]. Adding him to the thread

[1]: https://lore.kernel.org/linux-sunxi/491f043e-6dc6-4936-a490-31a3362c5b6e@lunn.ch/

> +# A property for a clock the PCB already delays is not in this table.
> +# It is either the fine tuning described next, or a mistake the MAC
> +# should report as a fatal error.
> +#
>  # Sometimes there is a need to fine tune the delays. Often the MAC or
>  # PHY can perform this fine tuning. In the MAC node, the Device Tree
>  # properties 'rx-internal-delay-ps' and 'tx-internal-delay-ps' should

Acked-by: Jerome Brunet <jbrunet@baylibre.com>

> -- 
> 2.56.0
>

-- 
Jerome
