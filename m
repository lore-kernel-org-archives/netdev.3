Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95978388890;
	Tue, 21 Jul 2026 19:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784662394; cv=none; b=OR5j+dOS7bfr/ghuhHke/BVe9eGoMm+GMdufUs3S3YiJvMexy0td3kIY6+K+WCULoxM3kXlnNZOaCsoBr3aZLrN7pAdC/zA6pBjkA1YNLse/r2bIp1F+5wnlyK3PYZQPyL57CAHAOx5UZvoQQXO4jXMq8npZZoKUskImgXQTO/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784662394; c=relaxed/simple;
	bh=jdpMPEWJ0ewNhqI5WRa23p4FJZ08qG/AswIPidEhqeY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uLpQgnYds0m4yJFHiegU+1/CTkMAPKJT0ydXKAgFS5H+KDJEfcT1J6L3lzYfWmGSNNeZ/XmXY0B/YwRIFngSYw6gX85SjcZl0c6z1rwooTfrasthYZzANufLb0E6Q/vF92RdpzWPCRKjHtYOM8FHS9sfBmLW3NNRjtp2P1SUUj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=njwLVRoE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="njwLVRoE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AD231F000E9;
	Tue, 21 Jul 2026 19:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784662393;
	bh=jdpMPEWJ0ewNhqI5WRa23p4FJZ08qG/AswIPidEhqeY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=njwLVRoEmfF/sBVQr9EgYkV7oPh3a03RQ9zYjL6cZeYFEK0G1Wb2tn5fMHByelcP8
	 LXZCdIDVHs/hVM3+7nKzwq8MgO0AW8mazu6tVJZiTlvGYl56mKZELDMTGhDUZgB2ea
	 3iFgABSA8+XAIltg/1NpcbFG61IgpSF+OAfWL2pKllxVbZ/Ah8omlt63YkX2g5fdKA
	 aoqYah0qYFSl7kPkQ18nIQ38wmYhb3r2m6+Wo0/grHqhApD531JjWbJr/d47i+64q3
	 IYpJDXHIrB3PCq27v+wwfrW/czeR/HGiHmXa5lLbwRxzp18CJhmsrocF55Ek+zG6Jr
	 lKSnAity8hwmQ==
Date: Tue, 21 Jul 2026 12:33:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Xiang Mei <xmei5@asu.edu>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, David Ahern <dsahern@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bestswngs@gmail.com
Subject: Re: [PATCH net] mpls: fix NULL deref in mpls_valid_fib_dump_req()
 on CONFIG_INET=n
Message-ID: <20260721123312.66ff6a57@kernel.org>
In-Reply-To: <20260712220903.3131568-1-xmei5@asu.edu>
References: <20260712220903.3131568-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 12 Jul 2026 15:09:03 -0700 Xiang Mei wrote:
> On CONFIG_INET=n, mpls_valid_fib_dump_req()'s local strict-check loop
> enters the RTA_OIF arm on the index alone and calls nla_get_u32(tb[i]).
> Since nlmsg_parse_deprecated_strict() leaves tb[i] NULL for any omitted
> attribute, a dump without RTA_OIF dereferences NULL and oopses.

Someone else already fixed this
