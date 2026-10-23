Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792795015;
	b=dKJAVA5M+ykIEOoaMNOxbAtKfTrhDMgPJZpvzuykXi3zznVnLX97LfbROhwUq7VJNtCF
	 WvmXpiXfi4ltAR/Ux0q8Y0gjAHX5vlGJ04+PpHCiLrqhEUzE/UrZkZTDYeXc5zsGpLAO6
	 d9XtqNhtJtFUbj7NkTOxdUBPdDj4Hv59q2DCb+zGBRGdO0RdvlciHN//Mq5F+JyFMGqXv
	 JzOVpXlf92gX9wuxzg6VgYyaAyDbE9tjknsIhO7OeObRleUhVEbwrh/hD0g4/V5pwzV/A
	 5MlmCEe5Y+Yc0tZqLH8WH6V6B1qHpDamxqXtTh8LpsDgDQ20/gaiMKnn8SGSuj4aeVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792795015;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=0/rEZzYz4eWyMMI0tiEOBuOXvQdPHJRH2AxNxCrxtXw=;
	b=B/Nt+YRJcn9u4C0cf7SBtc0QBhbWhRx5msvCfPiaBIhMWD032UkZRObEt/7SJFmR13+1
	 1AQ50eJvJYb/eOy2pyAgZIDeceORq/USyQGOz2TAp4L+dplWew4HrQIxxWn7gz7VS08Io
	 l1mAOu8qLfNJOcLkPVngRJhYhFVLAHKYgGw0FuwLirAZILALmpC9NmroNYH5NYsYgfbR6
	 yMLUEL1uvIfvTGH9ZZWAruVTiPzKh2dV2bkOcVaPEZ2szHEZRGdlFO11BKbwYDYLoQGbs
	 /jcuHVLR8Pin0biS3JsN91ScsQg98wqxvlP1WQIkQKomdjlf7SQc3FnXDONfmHIdZ5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ot2Zd7PQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF67606A320;
	Fri, 23 Oct 2026 22:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ot2Zd7PQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FC221F031E2;
	Fri, 23 Oct 2026 22:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792795015;
	bh=0/rEZzYz4eWyMMI0tiEOBuOXvQdPHJRH2AxNxCrxtXw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Ot2Zd7PQIKUjMMTRzAehp/rauHpw78a1PE7deHqyXPB/O2LWtvAIr6+JsUPPi/SkX
	 7nWM8ShnBMSF6F1Yz4e5BJLY0o0ITNsf3bNT2qn4hFW6EmqNr/XJvA//72qmKBhp7W
	 ZnrlsoRRJWpAlNlZyInM8CSO4a3E7UjXurZr5fbhcuAZDnrSEPm/5ak+4AAa7bvDb1
	 VyMY0lDnYQaHJrcUCxtGjgwlVy/horV87gJAK4UMQT9LyMDk2P9j1fh5852N+aoqdW
	 WWavWtXPQmEZaOS99T1ZuN3SE78tiEOiR2JzAYNnI3zWHlqUOxNjKEo/7geLCOTB3/
	 e2mpkqhL8t5PQ==
Date: Fri, 23 Oct 2026 15:36:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lucas Tanure <tanure@linux.com>
Cc: xianwei.zhao@amlogic.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 davem@davemloft.net, Eric Dumazet <edumazet@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, Jerome
 Brunet <jbrunet@baylibre.com>, Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/7] Add ethernet support for the Amlogic T7
Message-ID: <20261023153653.4f01855d@kernel.org>
In-Reply-To: <20261022200640.3101932-1-tanure@linux.com>
References: <20261022200640.3101932-1-tanure@linux.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Oct 2026 21:06:33 +0100 Lucas Tanure wrote:
> The T7 has the same ethernet glue as the G12A. This adds the binding,
> the driver support and the device tree nodes, and enables the port on
> the Khadas VIM4.

## Form letter - net-next-closed

The merge window for Linux v7.4 has begun, and the net-next
tree is now closed for new drivers, features, code refactoring
and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens. There is some uncertainty
about how long this merge window will last, so please check
https://netdev.bots.linux.dev/net-next.html
before reposting. net-next _may_ reopen on Nov 2nd.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer
pv-bot: closed
