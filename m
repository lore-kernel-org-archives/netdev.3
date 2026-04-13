Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75E739B97A
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 22:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776120955; cv=none; b=WOwh3tM9BWoCIMFAY4Gd96uLDE/mbMvykVT0gaYfYMBqex364kiRGL6eRk2yqSuzwDxYTMPHy4kyVOlyh/6GQ9MQipnwYE2Yw2D+95Gaw1z8SzrctjAgc2c8fBu7e8YoOcPOUtfg82dPqADjjR1SvwwGFWl/fn78LwxNlahFk0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776120955; c=relaxed/simple;
	bh=MXyKZMh+MNa+HEo88G4wjyPYSzisITUP97BQUgAstCo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hhGLob0zE4yQv11pBQprHk1x6qQeK5IEHF82nL7w2/6b0ljwQd81tkELhKfUJv8ogQEr1WH6ze+4vgANFVAvDf+MV4KYX+0cH2n2wR8atETt6QEJsPKYSfaLOIkLjUwE9W3IcbAiNk3Tb+QoPDK7dGj7y7L2gUjR8DuoPw8mDoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e08tusbV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e08tusbV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7FE1C2BCAF;
	Mon, 13 Apr 2026 22:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776120955;
	bh=MXyKZMh+MNa+HEo88G4wjyPYSzisITUP97BQUgAstCo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=e08tusbV1Y4JUr57h3YAVMfLBdDXQf/r7pxJI4r97/yBxDiToqgTbkGhWnhSc3nrp
	 TC5RuZvZv1dzlwcbvyZ8iVXULQzo3OKHp3w/8dwX3/0CU7T1sB7kb31qyMkQLRNz4K
	 ff6lyjVhD6rKsXzkucgdTHvwja+QKU8HCTwNoV5Fe6IOrgX9jvWAmmpibSrcTIzFos
	 a/worhjEwGkQoKAJ02of54tXsFot4mpFMBA+AzJZHinLLfcW2b57F48cZzN5yAD0ZA
	 ZYvJSQ1QopwMUj9Zj//F5tPEZmB4ZBcIw2mjFIIfEoP9oCMzEK4g1SLXHtwi7oMhW9
	 OsYWXmEgYczjQ==
Date: Mon, 13 Apr 2026 15:55:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alice Mikityanska <alice.kernel@fastmail.im>
Cc: Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Xin Long <lucien.xin@gmail.com>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, David Ahern <dsahern@kernel.org>,
 Nikolay Aleksandrov <razor@blackwall.org>, Shuah Khan <shuah@kernel.org>,
 Stanislav Fomichev <stfomichev@gmail.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>, Florian Westphal
 <fw@strlen.de>, netdev@vger.kernel.org, Alice Mikityanska
 <alice@isovalent.com>
Subject: Re: [PATCH net-next v3 00/12] BIG TCP for UDP tunnels
Message-ID: <20260413155552.5cd00bc0@kernel.org>
In-Reply-To: <20260410150943.993350-1-alice.kernel@fastmail.im>
References: <20260410150943.993350-1-alice.kernel@fastmail.im>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 Apr 2026 18:09:31 +0300 Alice Mikityanska wrote:
> This series is a follow-up to "BIG TCP without HBH in IPv6", and it adds
> support for BIG TCP IPv4/IPv6 workloads in vxlan and geneve. Now that
> IPv6 BIG TCP doesn't require stripping the HBH in all various
> combinations in tunneled traffic, adding BIG TCP becomes feasible.

No longer applies, sorry :( 
We'll have to revisit after the merge window.
-- 
pw-bot: cr
