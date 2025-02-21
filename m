Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BFE3FD1;
	Fri, 21 Feb 2025 22:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740176197; cv=none; b=PgUNGWg0zRt21PdCGBV5j6FPGCBlgWtbhQimX5LnC+0VSdgD4gDMXc388a+YmAOoZhiZbQdQyktWsYo/a7lTjvLUA4/b8QUDgMuaB+BIyolVEzXQO+44GCwd5/gUs51iXn/FjXG34bylgklpuZJNmP8fcNaVC/SFM57wxRy7JbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740176197; c=relaxed/simple;
	bh=23PN250gtc7EcFv1DIBV80PwXFQEG45j2Rg1PLeXuq0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c7aTR+Ux2FPqcmJ+de19VNUciSMa0+5lB/HfecfxhzFLbMCmncU4fWq4sMp4HKmo6jOxWyFJrGMtK7FCtQZxVnxaNMZUYKG4RMHWO70E+SYl0PBmYdfTPJ+Mir7n0P+9SwctHZf3dCQP2S4Nhg8hXU86ov5NqDyGfudw/oUa9s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GzwEr5aM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GzwEr5aM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58419C4CED6;
	Fri, 21 Feb 2025 22:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740176197;
	bh=23PN250gtc7EcFv1DIBV80PwXFQEG45j2Rg1PLeXuq0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GzwEr5aMCzrciGtwb1ZhEyOJW8Db+TpHE036ckNqvDi9H1lVL6vDRf6pqa9UEE37m
	 OPzt5/umJO+ot5TlXX1nDWFf43eeeB/G02zxCgq4vMyq1WKEqpr+7Jhqq7V46NkVEY
	 KySEk8nBdoW6NIG9nBocwv2pQ9wWrrZga5U1N1KwPJ4GZOi31suM0a72d/Z04FUkbV
	 3l1TqotCQZBOiQ7YaUfzBVdFsZ0tLCUnV/CinbmCJpaBEcSLpbK0nO0rQCLz4qwg9X
	 3oKLMiYLkx5r9arVd2Pr5yECHzifgptkL1y2yAl6N5JMxeBbpvluCtcQl5evzlc0ie
	 5kTpQB8b1Sc0g==
Date: Fri, 21 Feb 2025 14:16:35 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Felix Fietkau <nbd@nbd.name>, Sean Wang
 <sean.wang@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "Chester A. Unal" <chester.a.unal@arinc9.com>,
 Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
 upstream@airoha.com
Subject: Re: [PATCH net-next v6 12/15] net: airoha: Introduce Airoha NPU
 support
Message-ID: <20250221141635.4d01e792@kernel.org>
In-Reply-To: <20250221-airoha-en7581-flowtable-offload-v6-12-d593af0e9487@kernel.org>
References: <20250221-airoha-en7581-flowtable-offload-v6-0-d593af0e9487@kernel.org>
	<20250221-airoha-en7581-flowtable-offload-v6-12-d593af0e9487@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Feb 2025 11:28:13 +0100 Lorenzo Bianconi wrote:
> +	addr = kzalloc(size, GFP_ATOMIC);
> +	if (!addr)
> +		return -ENOMEM;
> +
> +	memcpy(addr, p, size);

coccicheck says:

drivers/net/ethernet/airoha/airoha_npu.c:128:8-15: WARNING opportunity for kmemdup
-- 
pw-bot: cr
