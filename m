Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62843BADAA
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 21:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784584100; cv=none; b=Y9YVOSgmhyh2IqgD5ZeYnklzywAGqDz6NYQ8inm4i/jZp+dyTdl2wUao5/pPUMOQe0OUZHtneLjvB5uxfT7VAFFs2GW0oYNnE/xAVX2hNXITY7ns50HLupBScey4cTsAIqvvGFoc9oBWZn3oDbBJWHlWpOJsKqM+x+AD7LwWwVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784584100; c=relaxed/simple;
	bh=vsqCLPan+/wNGpTkf7z9LhaHDgvbDsbIV+JINchj7hQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V7Dg/DwMRDqkL7YLQIQgo3hJ2OguGTYtAakMgxlyzPdB0bTm6VIfRyF7+3ZpqY74J2JKAyDYPjaop10tU3n78qqQVbOKSm8EtmmxnMs6NXwlUlW1YXA6N4xPFu4YsFF24NSQRAll9yH5WSVUWnZambJ8eCyx8RvoZcWQqfLpHbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fEwtl3ik; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fEwtl3ik"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 361AF1F000E9;
	Mon, 20 Jul 2026 21:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784584097;
	bh=vsqCLPan+/wNGpTkf7z9LhaHDgvbDsbIV+JINchj7hQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fEwtl3ikdnwq7ANP9ITcthGzt7EaCg7gjT+NTRtJpe0A+BMU55d9tEfJeh2jLjyVB
	 mg8e5cxFlRRyWx7S4T7dE+33+qs6H3iPeHxUNeEKafLTSwhDSt7dqtlvuq3jYLAXK/
	 mbM5RXuIhPCMWu79pMX6d2aQvvW59RqECqPHDgexpOjXx7B73FEJkppTeQm46SmMh/
	 osVkwjyydU9mAl3hBB4q+quKyCG5zB9cp9tz9zbvpz2Saakt88ieKKy/ZdW1Lw8nwE
	 5ocNGkgBrp0r5KHMR5tkAE9igmUxYiHzFgb67zKztUKFNPRupwA9gZYJcMy+tDLYJW
	 hvTNF7o3dxzKA==
Date: Mon, 20 Jul 2026 14:48:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, Madhur Agrawal
 <madhur.agrawal@airoha.com>
Subject: Re: [PATCH net-next v8 0/3] airoha: add the capability to configure
 GDM3/GDM4 as WAN/LAN on demand
Message-ID: <20260720144816.4d32909b@kernel.org>
In-Reply-To: <aloP8n-EVtAHnl-l@lore-desk>
References: <20260703-airoha-ethtool-priv_flags-v8-0-015ba5ac89ee@kernel.org>
	<aloP8n-EVtAHnl-l@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Jul 2026 13:20:18 +0200 Lorenzo Bianconi wrote:
> I'm not entirely sure what the next steps should be for this series.
> Thanks in advance.

You have to repost, once a patch is 2 weeks old korg patchwork bots
insist on marking it as archived.
