Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75611EE00A;
	Fri, 30 Jan 2026 02:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769741112; cv=none; b=tH0aPiLP1uIK0H4k467rpGiFc/pz1v93dEC5sgKUPyajdmyTe/v6ZQURQO3jThipsCEmik3TWIi7imDbbIn7qk0jDnL5yOuFvUPQQCUblfAdZFFkCBN6/xnHDLrqbXeWrrTEXomotwEiWA2ihyY4Q+OXe5Y7HF4b9tODClwxdQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769741112; c=relaxed/simple;
	bh=lvkR3AupMYkS1MRau1KxFU5qWBxB8Ry8+swDaQ63BOU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sEQIdSRYnRAP5or3dZdwum3zY2mEcn4dwU7QfuP6owDV4iyrxd5A/+gXKVCBC0CZvgFi/94yP3Ttr1iKjGU+sZr+blcbV2WxeCzEFCn8l1C4R2n27Jo0LJdLB4dXL0eEiu8TS7h4yJjtMfa8r8moIlB/+hKV5I7s45dbq8038eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q+6amwCG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q+6amwCG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97C8CC4CEF7;
	Fri, 30 Jan 2026 02:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769741112;
	bh=lvkR3AupMYkS1MRau1KxFU5qWBxB8Ry8+swDaQ63BOU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q+6amwCGq71Y1MzRhzQ5d3bFQrqqGYalYPxSLtPnmOvndLFEMKqsE/hs6zaM4WSq/
	 5K+/KwvNAqSI97ZMCuVUSBqoiDKKndUD+TweSo0lYlHW1MQ7tjhtIqhkdtIxfqgi3N
	 oeKb3P9JNeScW4X9+e42QLiwjABxH6VI0PBB+ZWAu9X/hCS+SFyXhRejTiD6Sc55YG
	 2E8LCZKn2SNRvLJTdxINYoZcYzUw0MwwqTMXyuMQ3dv6wl0akndPtynKClwy7EHGd+
	 06Rask6NRGEpLVLEosIrD4aFmWxyJ0GYrb7uR4N/AtRfHoXZe0Mn3WVJh3V6I9kC4P
	 As5rh7ZguGs/Q==
Date: Thu, 29 Jan 2026 18:45:10 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Antony Antony <antony.antony@secunet.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
 <netdev@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, David
 Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, Shuah Khan
 <shuah@kernel.org>, <devel@linux-ipsec.org>, Tobias Brunner
 <tobias@strongswan.org>, Simon Horman <horms@kernel.org>,
 <stable+noautosel@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v4 1/2] icmp: fix ICMP error source address
 when xfrm policy matches
Message-ID: <20260129184510.01319683@kernel.org>
In-Reply-To: <f820e0e9f80b1467f97d1408f00f61b1fdb1b986.1769595011.git.antony.antony@secunet.com>
References: <cover.1769595011.git.antony.antony@secunet.com>
	<f820e0e9f80b1467f97d1408f00f61b1fdb1b986.1769595011.git.antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Jan 2026 11:25:14 +0100 Antony Antony wrote:
> Subject: [PATCH net-next v4 1/2] icmp: fix ICMP error source address when xfrm policy matches

> Fixes: 415b3334a21a ("icmp: Fix regression in nexthop resolution during replies.")
> Cc: stable+noautosel@kernel.org # Avoid false positives in tests

I don't understand what you're trying to express with all these tags.
We are sending incorrect ICMP packets, seems like a normal net-worthy
fix to me?
