Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793959903;
	b=R/zMB9QmOsBHnjDischOuAKK4LulcO6ZNYqKJOhZ4QWPAEZpcL4F46OVDmWQIHV9S44z
	 7cjNYdLoDN0t4IFfO3pu2bWG7V2iz/2qIBWakLq0XN2KJGzwa6TVqOpM/F3xFi/2reH93
	 WhFI86DWam+N3KKAQ0gE7rqDE8DresoqkpjmkREwEtkvcPRXbp6p17/Dt5MOyoQf++ekO
	 xTngQyxCVjATACPEsPzJehWHgYuLZZAb6gI4PkpZ0I7Dr8XDiMijg1fzsUhpjxiC/mW+5
	 F9wpwEbHPLktJIZkniJ5H7UcFGwtbUHRVAj55MUMdF4kIpOqwrM25GSKAp91zNJ2Kig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793959903;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=NVbdOhY0Y8hSqBaccRJIemSs5pQgbapaJJc/jw4bTlA=;
	b=KQbaGjLRCPemmg0iaSLF+bqsQFeSKexZLjKhdBSeYO/IHiWucFinRHIFWHsb/2jhk0FX
	 3jlT5DUyQ1SdYcn1Xn88nZkgBd3QoEA0a4XP5iZClzKn7C9lz5pdXRumIOcidhVjeC/ej
	 mGUW3IGk2SgKNRPxa3NQhfvQJU0PEtZAxoYdYhVoKhpYippCH5CMc/cYR+xBnVyJ3VJZZ
	 HGK6U3VMmKrjPv+QsesrgmOEVNmwUF7P6RsF4hK/4iR7ag/qtAZ3sWB0mrjYHCcsS1ZoH
	 bk+Oop+KJZ7XsFenlgWQ1ilrjPXt1zQQTYJ+JezFh66yxR+F20wAy4JJxbUnHjIebzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="AF0/cyYI";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38C3606A32F;
	Fri,  6 Nov 2026 10:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AF0/cyYI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C83761F008A3;
	Fri,  6 Nov 2026 10:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793959902;
	bh=NVbdOhY0Y8hSqBaccRJIemSs5pQgbapaJJc/jw4bTlA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AF0/cyYIERpgU0HBQxi/PdKZp0ySQN/ch9rNzlnzK2Yx3SgOkGMggfUBGB4tnknIy
	 FYUwNMp6vwHdhojBUcl1OoypKlIZGO1vkNnRQN5CwTImzu4+nVCH2mhzqqm8Dm/Tjb
	 pbhPEFfx0rNwLFDiVkO+LgwPcDrRhC0EOqppkK7vev1kWZvd3BIni/u351TuiHHqxh
	 mTvXjX3o+m+iMn2AHLiuTbLfHcBf01Oj2Ez2KcoJR9tbhwQLXRxqH7+PzqQsXoe1eO
	 vPCx2JxRwUFq7pgnZfMnXzpkrGthYv6bdNMyn759+zoUy3qr/IuQUxultlWZYkxID2
	 F1nLp1YvZHjmw==
Date: Fri, 6 Nov 2026 10:11:37 +0000
From: Simon Horman <horms@kernel.org>
To: Linkui Xiao <xiaolinkui@126.com>
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
	pabeni@redhat.com, michael.bommarito@gmail.com, gnault@redhat.com,
	alice.kernel@fastmail.im, kuniyu@google.com, nicoyip.dev@gmail.com,
	mail@david-bauer.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Linkui Xiao <xiaolinkui@kylinos.cn>
Subject: Re: [PATCH net-next v2] l2tp: bump tunnel stats before dropping the
 session reference
Message-ID: <20261106101137.GF865646@horms.kernel.org>
References: <20261103084249.1337657-1-xiaolinkui@126.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103084249.1337657-1-xiaolinkui@126.com>

On Tue, Nov 03, 2026 at 04:42:49PM +0800, Linkui Xiao wrote:
> From: Linkui Xiao <xiaolinkui@kylinos.cn>
> 
> l2tp_udp_encap_recv() derives the tunnel pointer from the session it
> has just looked up, so the session reference is the only thing keeping
> the tunnel alive.  Both error paths of the function drop the reference
> before jumping to the invalid label, which still dereferences the
> tunnel:
> 
> 	tunnel = session->tunnel;
> 
> 	if (version != tunnel->version) {
> 		l2tp_session_put(session);
> 		goto invalid;
> 	}
> 	...
> invalid:
> 	atomic_long_inc(&tunnel->stats.rx_invalid);
> 
> Reorder the error paths so the statistics are updated before the
> reference is dropped, removing the dependency on the tunnel staying
> allocated after its last reference is gone.
> 
> Currently this is safe by accident: the only live entry point is the
> UDP encap_rcv hook, which is invoked under rcu_read_lock(), and the
> tunnel is freed by kfree_rcu(), so the tunnel memory outlives the
> dereference.  Making the order explicitly correct keeps the function
> safe regardless of the calling context, instead of relying on every
> future caller holding an RCU read-side reference.
> 
> The put on the version mismatch path came later, with commit
> 4d10edfd1475 ("l2tp: Fix memleak in l2tp_udp_encap_recv()."), which
> plugged a session leak.
> 
> Found by inspection.
> Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
> ---
> Changes in v2:
> - Describe the change as hardening instead of a reachable
>   use-after-free: the socket backlog path pointed at by the v1 commit
>   message cannot be reached, and the live receive path always holds an
>   RCU read-side reference, so the old ordering is currently safe
>   (Sashiko AI review).
> - Drop the backport tags (the Fixes tag and the Cc to stable)
>   accordingly and retitle the patch.
> - Correct the index line: the v1 patch carried the blob hashes of an
>   earlier draft of this change, so its new hash did not match the file
>   the diff actually produces.
> v1:
> - Link: https://lore.kernel.org/all/20261027063657.1359170-1-xiaolinkui@126.com/

Reviewed-by: Simon Horman <horms@kernel.org>

