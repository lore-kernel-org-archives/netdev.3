Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B23353A6E
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 20:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786740993; cv=none; b=tKcLmd1yU/BDBOlrsZ/RPQcuFo9/fNBa1az6o8YPCyoXRFaJuiqyIi/yF709FZjjrRorShXJ7BOPy4R7iu7HKLIHefpBwZ8VY5F4PQw8BaYUrWDgzASeL8wZX0CZeP0VtGXL6owKXCitlUrAONNr1P4UIEwG1JgaLOADvLAMIKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786740993; c=relaxed/simple;
	bh=6I8Hv8Ppt3iaFvJJ7lIkyZFrTpKZar5tIz02P9QeyrE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ewoPsrFxD/+4BZhAW6jBLRCBENloL7wDJTL4k99bKvEhDUKWNiHg2vHRV/aCmoaq3mk6MwRvT8pJ+j5atazX2MsDasIgD1fhSVaxRiqn6Pr3VtLWOArVgYSc2fxaKGUZxThjMttF7mDdsnwtT12kclgcN98vcrnK0SzPVXbHnh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FUWUtxyY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FUWUtxyY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA7B81F000E9;
	Fri, 14 Aug 2026 20:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786740992;
	bh=txwIcghIDFQCole2IsQwq4GyoOsv4SwBZ6WsmT3EGbI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FUWUtxyY657nby0HMqTftl3yTxOs+pbLkKWwCXElBHayuIGmDamX6czcgqqQy5aNi
	 qtMNU+N++LxoDxCvKKnIIT5vl9nsTXnmR7UqtrrAhKGgo+iHXfw7xK0SyayGiH8ZeK
	 S29KvMpUX4MeFyEZIHqMfoZFYHa4Tac0FV3xVBvooq375wj8e6CNGhN5KfTdPUMbSj
	 c+IYnyC09YbKJtp4GGbFS7RVetJZjyKLRQ6EqCKxW2rdPkkpR4B+jqgJJ3FiltsnKK
	 1d93DxnpcxlGy6P4xpdi/U+kBglFsxs452seqVxh3Crtypl5+DOP3d48qWSfRsrIb2
	 ds4R5FquXjpcQ==
Date: Fri, 14 Aug 2026 13:56:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Daniel Thompson <daniel@riscstar.com>, Alex
 Elder <elder@riscstar.com>, Davide Caratti <dcaratti@redhat.com>,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v3 2/3] net: stmmac: add tc-mqprio qdisc
 offload
Message-ID: <20260814135631.766ceb41@kernel.org>
In-Reply-To: <20260808-stmmac-ets-offload-v3-2-b714466142b9@oss.qualcomm.com>
References: <20260808-stmmac-ets-offload-v3-0-b714466142b9@oss.qualcomm.com>
	<20260808-stmmac-ets-offload-v3-2-b714466142b9@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 08 Aug 2026 16:49:58 +0200 Lorenzo Bianconi wrote:
> Subject: [PATCH net-next v3 2/3] net: stmmac: add tc-mqprio qdisc offload
> 
> Implement offload of the tc-mqprio qdisc in the stmmac driver. The MTL TX
> scheduler is switched to strict priority, and the PSTQX/PSTC priority
> bitmask of each TX queue is programmed from the set of frame priorities
> mapped to the owning traffic class (qopt->prio_tc_map).
> 
> The offload requires the DCB feature and a 1:1 TC to TX queue mapping,
> with the queue ranges bounded by the number of queues the MAC implements.
> Configurations with AVB queues are rejected, since forcing strict
> priority conflicts with the CBS algorithm.

Clashiko has a bunch of comments, I assume at least one of them is
actionable. High level - you say "add tc-mqprio qdisc offload"
but the driver already has a bunch of mqprio code. Background
would be useful. You also say "1:1 TC to TX queue mapping", if there's
only one queue per priority why offload mqprio and not prio?
At least a note in the commit message would be useful.
