Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7EE4C957E;
	Thu,  6 Aug 2026 19:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786043696; cv=none; b=ZGQTGEIBGiiidkEJsF/aBXcl+fkpksqVSgzTuUOEtC/iK1Xgjl4OSMC/P4PfoN24q8/GcsuN/HKpTca5L0Dkcswl7AAx3k7o2It+MfFGMzjclhEIcHVW0vcGXefoob96QFska5DIy65z0HVl87cJdaJms6dEaIvBKeMjIDy6LS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786043696; c=relaxed/simple;
	bh=grd/qvmp6W68jyQtfcEHWGI5kiG+ITk9iL9hYvTtf2c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TbFBxp4o7YTMFRGsEUfIAvZwzTS48L5socyvr3xbrwte2vHdM4xq2aTF2+o0KcMXn6STsvU3RCAj1j7MLAtE5VGNTfRsvkwTT8vFOYP6HzQdwE+8r1uUJMF122u3t5iOt+8vp+aFM7v5qtmWgvY94J4Mea6qS8OWtgkB8soFvE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OkYAoNXJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OkYAoNXJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE7C41F00A3A;
	Thu,  6 Aug 2026 19:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786043688;
	bh=XcMcYhakAnhAd3+Le2EHhwC9TyJ3yi81NJlnQb/TS+c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=OkYAoNXJUp/ywx1Bg+Z0VDYg7TFcFHMTztRsVe4MFBCTv7Xhd8A5m7ZLjdlKI6YhM
	 4NJu00GXFiT+5PraNdK7WSgNDRmsjzf7xAsc/F37Z9/SQDrc+xyIEV+ifoJMgC74+a
	 IHcK+fLfeZdUgcRUelj7uHJQcyJn7yAjr/SXb3ynKBbc6SNyRx8u1DAEpMmt/Vf08s
	 uEqK6AgwVnxowmApuns92l/3PxMVXfOWIPWQvf8C7CDsGr4mF71+UmIOanJvXApq53
	 0TFueV8bFyM4mPCdcV9hI9u+5Qhw2pgHKpcPyC6HUMGWM4CwfwMLLMGQ2seRYLmX7i
	 O1ST+wPkVRKgw==
Date: Thu, 6 Aug 2026 12:14:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dhanushkalyan G <Dhanushkalyan.G@microchip.com>
Cc: <netdev@vger.kernel.org>, Bryan Whitehead
 <bryan.whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 "Thangaraj Samynathan" <Thangaraj.S@microchip.com>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 1/2] net: lan743x: set interrupt moderation
 timer based on link speed
Message-ID: <20260806121447.3031bcb9@kernel.org>
In-Reply-To: <20260803124847.17315-2-Dhanushkalyan.G@microchip.com>
References: <20260803124847.17315-1-Dhanushkalyan.G@microchip.com>
	<20260803124847.17315-2-Dhanushkalyan.G@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 3 Aug 2026 18:18:46 +0530 Dhanushkalyan G wrote:
> Set the moderation timer as a function of the negotiated link speed in
> the MAC link-up path: 64 us at 2.5G, 150 us at 1G, and 330 us at
> 100M/10M. The interrupt-vector-to-timer mapping (INT_MOD_MAP) is static,
> so it stays programmed once at interrupt open; only the timer value
> (INT_MOD_CFG) is updated, from the new lan743x_config_int_mod() helper,
> when the link comes up.

This patch should go away. With patch 2 user can chose the right
coalescing settings for themselves. adaptive coalescing means that 
the driver adjusts the coalescing settings based on _traffic_ not
link speed. Please don't (ab)use that for the trivial link speed based
heuristic. There's a library called DIM which implements the dynamic
algo which you can plug into your driver if you want (it even has docs)
