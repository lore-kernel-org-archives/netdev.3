Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AC2266EE9;
	Sun, 21 Jun 2026 22:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782079214; cv=none; b=tavq7t80jO4Km75lAchH/vZfD/ZY1gjbwTo1UbwWRnu5RzCopo18B/k2GwJHS2iiek9yWN8YKi5eBEk7CuJlehQUg8Z2SXUqsF680grmcFQunVMg+qdrWdSb9KRT6JWZVEYo8MwBXFU8iZxLp1UO8L1WNvlVB6NomMbXWXRE2kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782079214; c=relaxed/simple;
	bh=j+eacf5l31dQ7E+Yr8tezfcUSuwXqZkTxQhwnnMfrqc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BgqZ9VH32GycDxsGQ4JsClv+wrdq9XcOwhgLy7cOhKdvkE/NcjPPIMv0kl25PQoryFxLD9rXNanXhVOXUmHnCj1bUAOSH5tW3u/597XaH8UG3fonCzgKJ8WwnsNDZ+6jv4AXInOM8uS4C74/39t1MsgQgl/b8DqpTvspWJ7HKw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZE1LukA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZE1LukA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66F361F000E9;
	Sun, 21 Jun 2026 22:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782079212;
	bh=OUDUBgcr0qOs5Ykzn549bWzd1i/vK7iiNOi1XwlptEc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FZE1LukAd/ddX8H1jtTeAPuGE5faq6uMtRLYx7ZIGS2WqAK9aAObzzuhjDNslinQl
	 YFpZVxsWS0fr8GrZYKiVAKbssPbv22mjUhv878BX7KrZ30aYxNZhclDBgV2R5vAho6
	 aKALpc5umc1BuzgqOMKYVqQQTa9w/EHkwzakWHIAR/7dnspuZEZgDGur/NKwLFQS0k
	 elYF9TWxSFY4jIniyaaHSoQ///vtOkAzSBzOSknsg3c/PaZ9gHffTlajfXHQcKCngA
	 P7zllHZZbRHor8wjtBLEjxArzZWkmacU4a7/a/A6nc0y3j5L+CFqe/6bgmziEAryXs
	 04IDot9LL3lxA==
Date: Sun, 21 Jun 2026 15:00:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Taehee Yoo <ap420073@gmail.com>, "David S . Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] amt: don't read the IP source address from a
 reallocated skb header
Message-ID: <20260621150011.33c2fe80@kernel.org>
In-Reply-To: <20260617123443.3586930-1-michael.bommarito@gmail.com>
References: <20260617123443.3586930-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Jun 2026 08:34:43 -0400 Michael Bommarito wrote:
> amt_update_handler() caches iph = ip_hdr(skb) and then calls
> pskb_may_pull(). pskb_may_pull() can reallocate the skb head: the new
> head is allocated and the old one is freed. The cached iph is not
> refreshed, so the following tunnel lookup reads iph->saddr from the
> freed head. On an AMT relay this lookup runs for every incoming
> membership update, before the update's nonce and response MAC are
> validated.
> 
> The sibling handlers amt_multicast_data_handler() and
> amt_membership_query_handler() re-read ip_hdr() after the pull and are
> not affected; only amt_update_handler() keeps the pre-pull pointer.

Sashikos point out a bunch more of these in AMT:
https://sashiko.dev/#/patchset/20260617123443.3586930-1-michael.bommarito@gmail.com
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260617123443.3586930-1-michael.bommarito@gmail.com

Let's fix them all with one patch?
-- 
pw-bot: cr
