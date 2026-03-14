Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8134B1FC0EA;
	Sat, 14 Mar 2026 02:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773453670; cv=none; b=n6tnGjCfsayggndOxqpFXxhupfp0XiyfVwWYCl4sWoYRFmbkog46CUPWNi14mN8XKipRGA+pqO8F31PxtIKVMrm3LhRJM3S37T7rrvnptdI/mG2xIb0USt48hArMoxZNFm5oSY/cfwnYxToNdGorSi3vTU9TUvJ5Fn4dCi4B52A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773453670; c=relaxed/simple;
	bh=7+CVxXjAZY7yb95XrrtXjiVcjM6EVPFwnpwYSFSNvVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y2/BIRJ9w4stVKtwwEEA7emjjY4OXWRXr3zkNHPW7jTh4a51LxwsMplQimuhh6i7sur0ooQBNkRVWcJGKJUm6QN6I2lyIMiVIcwfsXO+KXF7xOX2x+lf1+x+zvLg3As1iTRH0AS5ax+IL9HJjvuuP8iXabWnnEWqvZq9HyaQFxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WqMgoKAb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WqMgoKAb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85293C19421;
	Sat, 14 Mar 2026 02:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773453670;
	bh=7+CVxXjAZY7yb95XrrtXjiVcjM6EVPFwnpwYSFSNvVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WqMgoKAbIkkWTPeQpVGuHUCiaQh2D+XQx2VsbBHjyTxoSv/CwJ8NUq+Yafer/TMqD
	 /lWXgGbLF7isF1rbfJx2GEZz6bYnM667hU6gkrvn7/ouoWzGBOOZIUk/zf9U92ZqHT
	 HDArK1PcSYrtWkN45sUBuVto/Qrt3jXF7AtovpvLRcEJAx14dgbyDXBxMBy8FIrlUo
	 VpjY1ZMI8Gos86GtHt90PdUuhb1bbrqn2unlmrETCxNNYtf2lFpbU0Zjl+RkWSWRyZ
	 bfUrFX/FJlmpGxDAnnBVxAdNUDv9B/GrD0dDxCRonXllFc1AzdEZjshKYtJuwVEALJ
	 dylihlQqgXucw==
From: Jakub Kicinski <kuba@kernel.org>
To: geert+renesas@glider.be
Cc: Jakub Kicinski <kuba@kernel.org>,
	linux-renesas-soc@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	eichest@gmail.com,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	devicetree@vger.kernel.org,
	andrew+netdev@lunn.ch,
	robh@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org
Subject: Re: [2/2] dt-bindings: net: micrel: KSZ8041RNLI supports LED mode
Date: Fri, 13 Mar 2026 19:01:07 -0700
Message-ID: <20260314020107.2241383-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <6ccda7a00f250e87b0457e276ac1070cb0708d71.1773321267.git.geert+renesas@glider.be>
References: <6ccda7a00f250e87b0457e276ac1070cb0708d71.1773321267.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
dt-bindings: net: micrel: KSZ8041RNLI supports LED mode

Micrel KSZ8041RNLI supports LED mode, just like KSZ8041. This fixes (a.o.)
the following "make dtbs_check" warning for the r8a7791-koelsch device tree.

> diff --git a/Documentation/devicetree/bindings/net/micrel.yaml b/Documentation/devicetree/bindings/net/micrel.yaml
> --- a/Documentation/devicetree/bindings/net/micrel.yaml
> +++ b/Documentation/devicetree/bindings/net/micrel.yaml
> @@ -54,6 +54,7 @@
>        KSZ8021: register 0x1f, bits 5..4
>        KSZ8031: register 0x1f, bits 5..4
>        KSZ8041: register 0x1e, bits 15..14
> +      KSZ8041RLNI: register 0x1e, bits 15..14
                  ^^^^
This isn't a bug, but there's a typo here. Should this be KSZ8041RNLI
instead of KSZ8041RLNI?

The chip is called KSZ8041RNLI in the commit subject and in the compatible
string definition:

>        KSZ8051: register 0x1f, bits 5..4
>        KSZ8081: register 0x1f, bits 5..4
>        KSZ8091: register 0x1f, bits 5..4

[ ... ]

> @@ -80,6 +81,7 @@
>              contains:
>                enum:
>                  - ethernet-phy-id0022.1510
> +                - ethernet-phy-id0022.1537
>                  - ethernet-phy-id0022.1555
>                  - ethernet-phy-id0022.1556
>                  - ethernet-phy-id0022.1560
-- 
pw-bot: cr
