Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C16237268A
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 21:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774302157; cv=none; b=bHKVviER6n/ii9RNoZtd0nwxwbjqsCTmWU48S2yNehjcxO+YZZntCEgPQPZlWssxRqX59As0D4J+l8/9rsXHiJWHa1EwhfxO+boeu5kOm8rObDMv2yXxRtrWRC7QkEW5Z+Rib7inXcxsSekyTDU3C8+lccZCZcIJdQlB8+YHObA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774302157; c=relaxed/simple;
	bh=DSEbny84Yly4nLR2jlYZB3XOX3mwE7afr23M2dVlvic=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UiXe1o7/zkqsfuIwLQ0iZKNdNo+uKCXCwgAQf+0FYJWBoJYTGcs7VlmGbIqYcEd/hxe78LA/1uVbDciAJGgDq/ll0GSVoI69T8axxUXHJONLZiLnLot1UkBTVG2B8HX2QZ2AnKEwPh33PaXp0Fq/i2M7FtkWdQmvBWGGLRvw5gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ngRIvCvY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ngRIvCvY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84200C4CEF7;
	Mon, 23 Mar 2026 21:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774302156;
	bh=DSEbny84Yly4nLR2jlYZB3XOX3mwE7afr23M2dVlvic=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ngRIvCvYT7WxinR9td2K1amORjsD9EtWMrRhE8LTy5siBngX+ka9Vo6MoMBRC6JYW
	 c6NpbzNGVZ2l4LaQ0U3jT/iaNlymJGh+IxR+Ns5DNZbo6xr7uutHs2Cjgk9tg2LVYJ
	 70hHXaV5fLpPQpWhHH+4zUCVD3hd93WSEWZDY0NbeZ6wxVCNCfolUogoYGN5sO5Iqn
	 MpBY8F0yYDEJqHq+x+3PDwvTa6WGFt1pwGejrCkFTDhfN4jrvyPLwpLh8J3mv0xgy2
	 fgEbKpd7zITcz8SHHh48jCufAT0ZAo3GdZY8NhXMrDoxBJbJK26lf+XsOY+wZEYSnW
	 W0x4BaZaI+H5w==
Date: Mon, 23 Mar 2026 14:42:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: airoha: Reset PPE cpu port configuration
 in airoha_ppe_hw_init()
Message-ID: <20260323144235.6b843115@kernel.org>
In-Reply-To: <ab6R4krBRy5dycb-@lore-desk>
References: <20260317-airoha-fix-ppe-def-cpu-v1-1-338533d8e234@kernel.org>
	<20260320183127.22b360be@kernel.org>
	<ab6R4krBRy5dycb-@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 21 Mar 2026 13:41:06 +0100 Lorenzo Bianconi wrote:
> What do you think?
> I noticed commit f44218cd5e6a is already applied to net-next. I will post a
> follow-up patch, agree?

Sounds good, and yes please.
