Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4844343711C
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 17:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786988019; cv=none; b=cU0DsrnFNNsSqbDdQP+Hqz9VM9SUhNuzRW20KHH92ABVctEjv8O91RvhN9pI4xbQmBWx4gMN+9Q2VMSDqUoB+NtGHLSoodbvJVpY04qqExmkh1Rk+QjkjxzsKT6aolRvG7F6Ib1FZkP2LcEPzVPPmjrnRYAxeY+kroH0EQ0/190=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786988019; c=relaxed/simple;
	bh=pMiwIJJM6ofZE6w7K/RbwzXIJKKVQXafj8nQOVcTdQc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mWGShd/q4ncm884p35EICSZTE+5TSdCzv/janLQRFW/0g06C1WZZHe4glFl+VIjX/6OMIffaV0zkFrNj3Fwca2TKsg1nYTz18EagruntHSejdzDufOQX0Xj6OE7IFSyY1OBKBY5YXZFsbE0DakoeLMqwAhIJ2HQFQ/kJyCDyD5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PerXsyF5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PerXsyF5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2AB41F000E9;
	Mon, 17 Aug 2026 17:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786988018;
	bh=EbO79SBt1fqQKSNB4+jp3tSRgB259JknfPmG5q55o1U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PerXsyF5f8Z99E1O/MH92EBezeiHuo2++IAFgfYNvD7F3OEzpcIrAlpU86edyelU0
	 Ny9fqUX/GijwKkNUR4Xnb8JwqupgeSdTWB/hUnaA7CJ31qRqFaczjMF7XZLaV+jsuU
	 n5c2BxF71FeWhQiUN9shtog4IQ4r64tJ5kqWg2oB4soBEDTNNqM3QDZKylL7bde5Z4
	 H06KoCiTY4nvN1a7pyNJkFf8H0JkNpBIe89QOUv7RhtgkYMPgoDlGnkt3apxA65rib
	 Sp2Qs4COOr08cu2rYW5AkxULK9FfSzNMjGskmSR0h9BxKh/tBEZHHAwjoqJgW+CIJa
	 akKCkCxlCWexA==
Date: Mon, 17 Aug 2026 10:33:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kurt Kanzenbach <kurt@linutronix.de>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: [PATCH net-next] net: stmmac: stm32: Set TSO/TBS Tx queues
 default settings
Message-ID: <20260817103337.74c30adc@kernel.org>
In-Reply-To: <20260812-stm32mp2_txtime-v1-1-f9e2462cc85d@linutronix.de>
References: <20260812-stm32mp2_txtime-v1-1-f9e2462cc85d@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Aug 2026 08:28:57 +0200 Kurt Kanzenbach wrote:
> TSO and TBS cannot coexist. Use the first queue with TSO and the rest for
> TBS. Tx queues with TBS can support etf qdisc hw offload. This is done
> similar to dwmac-imx and dwmac-intel.

Can you explain your use case? And how many queues the device has 
in total?

You say "TSO and TBS cannot coexist" but can any queue on your
platform be configured to support either feature? If yes why are
we configuring this statically instead of making appropriate
configuration based on qdisc or some other uAPI knob?
