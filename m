Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118973A6B8A
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 23:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787009385; cv=none; b=Hr2YMaUZsmgkkDJThe5SxALescz90v79xX5uy0KlyvOefze8gvQ67EcexkLUMPnkBipLOznW6A2wHOmddh8gAs9VHR3VFZZJq5udpfQXSxrAa4CC9gQRnnax15LUh7aUUrHdNVHWrLOZcRRVXG3FxnV7zJR0pv9YUwcTDnQtJ+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787009385; c=relaxed/simple;
	bh=GWTIo9Avn+5Pi+6svs+/ekLOPV2RUTWVi+lvPzHXerg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YL4RzxJ9NBQH/0/7cDFwz1Z3IXJS9zkDTsEl5kJZhatfeUUrjJckSGdG9Wz0YiAu6U4u6Y9cgH0x6MI+OgH0zybc/FiC7fLWfYQYStRoCI9NWAJlmfV3Z3466xJ05DlRbD1bbP0jzPRK3HA8uvvj7+w1fUWl6nTWj28smatUJsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJamuGhj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJamuGhj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6307E1F000E9;
	Mon, 17 Aug 2026 23:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787009383;
	bh=oubCngcQy4g59IruCiIeITyEiuscAJmzXuNj9LCTxSo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=XJamuGhj5cXklcaYEhyg1jpjwDCh2iO73Db6A5MTn2/77IWV/tdfgg8Zwqpy0AnxV
	 Sl7DOVCoDi7QMJUc7ySoBCoua+KtBoEvQheckuKDGK5+uBb8JnuwoN5D6og5RM6kjy
	 bupBzS65sRGNz5oSHnyEz8v9UPejTjV48TMuo482877mHyZDD1Vlriq8Q3tSQog4RZ
	 4nA4Z/Pa9nKQGDWQMKgdzi7sq5ToKsmGatdFgSlHoabX8gECbdO6MSAQES1Kh06oik
	 tAbrpWHEf+pk5u92hx2MnVfFNtZioonMJ1sK3x9dX4K7lOguAcCcy5ajpUpkA8SFbP
	 A+50+eVr35tsA==
Date: Mon, 17 Aug 2026 16:29:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mariano Baragiola <mbaragiola@linux.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, willemb@google.com, kuniyu@google.com,
 littlesmilingcloud@gmail.com
Subject: Re: [PATCH] udp: resubmit encapsulation packets on all multicast
 listeners
Message-ID: <20260817162942.4d08f616@kernel.org>
In-Reply-To: <20260815141128.1564949-1-mbaragiola@linux.com>
References: <20260815141128.1564949-1-mbaragiola@linux.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 15 Aug 2026 11:11:28 -0300 Mariano Baragiola wrote:
> UDP encapsulation handlers (FOU/GUE and similar) return a positive
> protocol number from udp_queue_rcv_skb()/udpv6_queue_rcv_skb() when the
> UDP header has been consumed and the packet must be resubmitted to the
> IP protocol handler. Unicast paths already propagate that return value.
> 
> Multicast delivery called consume_skb() on every positive return, so the
> inner packet was dropped instead of being reinjected.
> 
> Commit 3cb8d4b9bfeb ("udp: fix encapsulation packet resubmit in multicast
> deliver") fixed only the primary ("first") socket path on net-next and is
> not yet in net. Secondary listeners still clone the skb and drop it on a
> positive return, and net itself still drops the primary socket path too.

Wait a week, rebase and repost against net.

> Resubmit secondary clones inline via ip_protocol_deliver_rcu() /
> ip6_protocol_deliver_rcu() (matching the GSO segment path in
> udp_queue_rcv_skb()/udpv6_queue_rcv_skb()), and propagate the primary
> socket return value with the same IPv4/IPv6 sign convention as the
> unicast helpers.

Please include in the commit description how the issue was found.
