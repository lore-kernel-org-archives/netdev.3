Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBD329C328;
	Tue, 28 Jul 2026 01:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785201889; cv=none; b=rTpQ4Oe23ID2qqHcYV/EHi5XMDScuB3hmZ+HntvuycgwK46kbEvV06at2Lx4uSOVuvMmOVaFg1ZnjAfwKkkloRLqHfZumauorQIzd2+6whrW3n8Q4MSTOcJjxPo1kHha+h19FBBYlobL8OTqo+y2/1ptSdwW0oL88e2arWwKGz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785201889; c=relaxed/simple;
	bh=ZGUdo3j5fPY6ZH5wuURASnMClyvLgYXyligQoOBwmHE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kZCqOdZnkUr33F+vanCLCJxYzdwSxyB3nSstLmqpi9B3bjPouTC7mf1hxLOBN2/QEhI99SqM5NPqWG7SmNxr2Gw+4HNK9i0hP+3TrDVDXt46LfNAmAt+2wBbxZQsJOwKxwiQJE9coqF3NnLEE6i//+ZZmnqeKGusFIOxXZhI8fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fUrvQF5/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fUrvQF5/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B809E1F000E9;
	Tue, 28 Jul 2026 01:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785201888;
	bh=YcvaTqvZZ754VGOAK4U5a8C2y6dVVa6zfinprjkO90U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fUrvQF5/xQWpixUVht4+GeBrEyFM41NoaPiGb9NU4rvCDPO7XeikSk8y0fvuOOrtt
	 BeyYLCuZNIb/w1lMThUmm3hE3nFGd84KmImLWmM6xMsKOkhaN9Bd+AhyVhSVTM3Mup
	 zl+XpcE2XVC1ilRQeAKt4Fo70PHnZ1WmMEadCVEDcyKRjoLNylFgfMH0v7pLG46/rw
	 QfyodNreB+PClkIevYbthBI0Xy7SFyZn7/0ht9uHmtBMtIKwYVHtM4PhJHznAKKs/M
	 Q/2bjE1z8l7A56nbOw2L40EL3m7SoLN/oHsaxJNvcYd/TGP1NL8veKkCOKx+2KeQBL
	 mQVy69L38CVIg==
Date: Mon, 27 Jul 2026 18:24:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiale Yao <yaojiale02@163.com>
Cc: Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] team: reject ARPHRD_CAN devices in team_port_add
Message-ID: <20260727182447.114f9fc5@kernel.org>
In-Reply-To: <20260723040032.2094322-1-yaojiale02@163.com>
References: <20260723040032.2094322-1-yaojiale02@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Jul 2026 12:00:32 +0800 Jiale Yao wrote:
> Enslaving a CAN device (e.g. vxcan) to a team master triggers a
> NULL pointer dereference in can_rx_unregister() inside
> net/can/af_can.c.

Gemini review says that similar issue is possible with
ARPHRD_IEEE802154 devices, could you double check that,
see if there are any others, and all these in a single
patch?
-- 
pw-bot: cr
