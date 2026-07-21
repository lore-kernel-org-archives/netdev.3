Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8301B415F0E;
	Tue, 21 Jul 2026 19:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784662115; cv=none; b=pLdgJq+cctYNHyn9q6IokiMMKT16tDPLjTwT8cIa3v6WfEaDeABOCSJYFZ+pK1m5zYEobUFSVp/edYZ/EHB3yYVpdIkaITBuLY7AtuGxS0txyI0tT3Kw7T8ZpL50Ez2xp+h3V2hX6chGMg1ey2mp/DXuFH0QYhc0JCQ0JqZRDvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784662115; c=relaxed/simple;
	bh=lgclJuk0CqxNxS/2ZM00UldPOzsTBKWl/vFU3Zpif3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pSrr12IPj4lD9eFA2ujWrOfPNXpjKxxLsgmX2yK/EO96F6yc+uOjAgJLnMW2SNzPJ62t6gVKyaPMYmmvOOSdz3ewrAvl9hlLaAimNzzFxzWtZObOMk4D4eNhA67J9l7VOhW3U3dhYzRAf1LG/suP2fB3aFi/s/7gR+Bj4tTjmHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ch/kxbBu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ch/kxbBu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04BCA1F00A3E;
	Tue, 21 Jul 2026 19:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784662114;
	bh=xC8lvJvDUQ9mMy/yHy4cng0x19uXIMryBnv+mV/BtRo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ch/kxbBuOr35ZOfuV6AS8t6/kRvi5NNuti6hN3q0Jhgjudk5cB+LsvTJ9mEVCQ2/Z
	 bCu99xy614UcbIIZCvnOhByuXJVEPQeeXNESxJhJuBV7o/7QrDAWwaqIl63EBblCKQ
	 7Ku5XZRfU968q9H8p77wuV42kGH3TS4uET3CW+GxmGxUUiOnXTKc1oIweDhjL6hI87
	 vEH8zQxWtKoZltfAyHwJTU+BwkrOQe7hIgqzr+k0xpmLF91sN88jf7r7VLEKRUscVg
	 9W99CV7/nCkzXvMenWsG/gIx1mwKCQsyRv+h/Nb/3LDD9hi12Mw56keiu7rP5wW5N8
	 hH+SCyEXFYgow==
From: Jakub Kicinski <kuba@kernel.org>
To: xmei5@asu.edu
Cc: Jakub Kicinski <kuba@kernel.org>,
	edumazet@google.com,
	kuniyu@google.com,
	pabeni@redhat.com,
	willemb@google.com,
	davem@davemloft.net,
	horms@kernel.org,
	weiwan@google.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com
Subject: Re: [PATCH net] net: sock: prevent integer overflow in sock_reserve_memory()
Date: Tue, 21 Jul 2026 12:28:32 -0700
Message-ID: <20260721192832.931173-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260711005955.1467140-1-xmei5@asu.edu>
References: <20260711005955.1467140-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
--- Patch [1]: [PATCH net] net: sock: prevent integer overflow in sock_reserve_memory() ---
commit 16cb32b81c740c27028a52ef3c27a62623c808ad
Author: Xiang Mei (Microsoft) <xmei5@asu.edu>

net: sock: prevent integer overflow in sock_reserve_memory()

This commit attempts to prevent an integer overflow in sk_forward_alloc by
computing the new value in u64 and rejecting allocations that exceed
INT_MAX.

> diff --git a/net/core/sock.c b/net/core/sock.c
> index 8a59bfaa8096e..2ba95bead1aed 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -1042,6 +1042,9 @@ static int sock_reserve_memory(struct sock *sk, int bytes)
>  
>  	pages = sk_mem_pages(bytes);
>  
> +	if ((u64)sk->sk_forward_alloc + ((u64)pages << PAGE_SHIFT) > INT_MAX)
> +		return -EINVAL;
> +

[Severity: Medium]
Does casting sk_forward_alloc to u64 sign-extend negative values?

Since sk_forward_alloc is a signed int and can legitimately be negative
(e.g., due to over-reclaim), casting it to u64 when negative produces a
massive value (e.g., -4096 becomes 0xfffffffffffff000).

If a user requests a small reservation such that sk_forward_alloc +
(pages << PAGE_SHIFT) remains negative, the 64-bit sum remains a large
unsigned value greater than INT_MAX.

Does this falsely trigger the > INT_MAX check, rejecting valid reservations
with -EINVAL and causing a functional denial of service for the socket?


[Severity: High]
This is a pre-existing issue, but does checking sk_forward_alloc allow
a state-change (TOCTOU) bypass?

sk_forward_alloc dynamically decreases when packets are queued on the
socket, as memory is temporarily moved to sk_rmem_alloc or
sk_wmem_queued.

Could an attacker reserve memory near INT_MAX, queue packets to reduce
sk_forward_alloc, and then call SO_RESERVE_MEM again? The temporarily
reduced sk_forward_alloc allows the check to pass.

When the attacker reads or drops the packets, sk_mem_uncharge()
unconditionally adds the memory back, overflowing sk_forward_alloc past
INT_MAX into a negative value.

On socket destruction, this negative value bypasses sk_mem_reclaim(),
leaving a non-zero balance that triggers a WARN_ON_ONCE kernel panic in
inet_sock_destruct().

Should this check use the total tracked sk->sk_reserved_mem instead of
the fluctuating sk_forward_alloc?


[Severity: High]
This is a pre-existing issue, but does sk_forward_alloc modification in
this function race with UDP receive paths?

sock_reserve_memory() modifies sk_forward_alloc using the non-atomic
WRITE_ONCE() helper via sk_forward_alloc_add() under lock_sock().

For UDP sockets, receive-side modifications (like udp_rmem_release())
occur in softirq without holding lock_sock() (using
sk_receive_queue.lock).

Can an unprivileged user repeatedly call setsockopt(SO_RESERVE_MEM) while
receiving UDP packets, causing a read-modify-write data race?

Could these lost updates corrupt socket memory accounting, leading to memory
limit bypasses or triggering panics during socket destruction?

>  	/* pre-charge to memcg */
>  	charged = mem_cgroup_sk_charge(sk, pages,
>  				       GFP_KERNEL | __GFP_RETRY_MAYFAIL);
-- 
pw-bot: cr
