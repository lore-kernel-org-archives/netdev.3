Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9A739E190
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 23:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786576241; cv=none; b=SrTZ2UvcuI8AYxOVs/018D0+dt3/oQxct4KKDtk93vK1R2FTbaoYro7xFtvocffQZL8M6F5S2KkogWqQIR+zF25pHyzRnKqTDscuONMHl1JMcP4p+YmoMCdmMJXOtUfsitg7mXyq1UG7ZnvGh8cEZNIk/WI/UDydztJPX/t7ylM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786576241; c=relaxed/simple;
	bh=CseEYY66hcx4HtaX2fRwP8AulArfXVD4D/X35NDdTgY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rSy028EPS7pcTZSU38dk9kXYVKuXkUhZXjkBdusroSqPgt6GTGZZBLMrTRcZOLgoQiZSctthZmLXeG17fCj6g7EtgMzI1ODM0zwvDxV7eZ9pwt1q/E95cL45I2hlgZyh06cDQkXuKKYKHpwfk8RpTntU2EeGozk6r7vuovg/8Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IoAYHNY+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IoAYHNY+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C32A1F000E9;
	Wed, 12 Aug 2026 23:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786576239;
	bh=CUY/Ds/MUvmVmH7d6jg454DnOepLNosOzWfrRQBaR+4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=IoAYHNY+QUKKh+ZdT2yVJSbBiZ7Y9lXnHdVaeKw4QClxpQggA5wKRNyLeGwkRqPy8
	 81OlXlKGYXsA3vUMKukuCjPOJ8PCfYISeko2z24lO1bZ7Ws+HDlA/BG5iWM0G8AURs
	 UJSAxOLtghAd4xRU+TjAM62b0oPOaWyrNSHGSTkIIkgjC7GKE9qN16b6zelQ53xZTW
	 26qy16fv1uaDFGFIeIwfH3w8O+84tgzBTLBVx29p8M9YhWUk4G/UVRPStzTCueO6Nd
	 iJCLkS21FNZ6jGM3ucuU+b2lVtLvj0WQDFhPVpS3wUHVOVJQyTQiCaOzbqH1j+Bdmn
	 8afo83nwAchnw==
Date: Wed, 12 Aug 2026 16:10:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v2] net: stmmac: improve TSO/GSO queue
 selection
Message-ID: <20260812161038.5602eac9@kernel.org>
In-Reply-To: <anybM_3Rdg8X8CMs@lore-qca>
References: <20260808-stmmac_select_queue-tso-fix-v2-1-67175b29772e@oss.qualcomm.com>
	<anybM_3Rdg8X8CMs@lore-qca>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Aug 2026 18:11:31 +0200 Lorenzo Bianconi wrote:
> please drop this version, I will post v3 to fix some pending issues.

FTR Russell was trying to fix TSO in this driver too, before giving up
(on us?). The direction he was following of clearing the TSO caps in
ndo_features_check and letting the stack GSO instead of all the weird
hacks this driver has seemed much more sane. But maybe I'm missing
something TBS specific here 
