Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1D64AA1EB;
	Mon, 21 Sep 2026 14:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789999738; cv=none; b=dQZdVHpdikSrhPHjIEd1uyZJB17d0zM2wBBczrVYwyJEqSoX1jvTGtxYklZs/B75nYc7VUfsT2NxwPJAourfH/4JbAuYMJkwJIwRYEShNiL0q0VJ/MaWYHLW1RkvUIYNkbEuN2WAN7ZJ4J6try5LVSA4S6KzCvNo2iSKoe1xjdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789999738; c=relaxed/simple;
	bh=G9q3i7tqWsB3HK9OoAQ8A3g/zpnIoUQKiZ8DEPL3MOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bWyRE37529uo0XBD2NomQJOJvpeNFQt2gSCDA5fOvEDRbPxEt4YQgCi+oDyMd710wKeGAEZ21b7lieWyK9Es8mfOtb0b1OynkJYOt6Z69oiO5nn389BNaJu87YTMCYk+jC+KOlZBt/WVlxfFGjUEKnc5gzChC5khpIJrb/bz+nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YlA5biMh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YlA5biMh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1FD11F000FF;
	Mon, 21 Sep 2026 14:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789999736;
	bh=cbB+ulRwWthQ5iQQXII3rLWdyEpsPLITlFYeU+SNDgA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YlA5biMhBOfZeFi5Yj/ukPxV5f84tQ+VnDekgm20U+L7ge7eMkjVc+fU7seNWV7Cd
	 pI53zMhWIs8MBkR7ULxtuVIOC5S8e7KPAq3R+dsstPRvkTisu8yiZJt28/tuDu5aBj
	 24CL5HIbJ/8dyG/8D08PPj7AlLr6UUhjtmSFttP2Ypv4KzpFG9wSxzQhhl0gjht2ls
	 OtcFj6efkmspj5CPE18/13H38Pnvu2Ihn085V66iYH/3zy5BUKpFcgPNVQzmYEB5It
	 AFZ9tucnpEXyIHWppyIOLjoFwCqDKJ5ScWUxzlfmDCcy0kWNU2b0vX4VbAppIWg2dn
	 FHbgWsvNZj2xA==
Date: Mon, 21 Sep 2026 15:08:52 +0100
From: Simon Horman <horms@kernel.org>
To: Yuchao Zhang <ndaugoing@gmail.com>
Cc: David Heidelberg <david@ixit.cz>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] nfc: llcp: reject connect() on sockets not in
 LLCP_CLOSED state
Message-ID: <20260921140852.GR13925@horms.kernel.org>
References: <20260918033920.85025-1-ndaugoing@gmail.com>
 <20260918033920.85025-2-ndaugoing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918033920.85025-2-ndaugoing@gmail.com>

On Fri, Sep 18, 2026 at 11:39:20AM +0800, Yuchao Zhang wrote:
> When a socket is bound via llcp_sock_bind(), its state transitions to
> LLCP_BOUND and it is linked into the local->sockets hlist via
> nfc_llcp_sock_link().
> 
> Currently, llcp_sock_connect() only checks if the socket is already
> connected (LLCP_CONNECTED) or in progress (LLCP_CONNECTING):
> 
> 	if (sk->sk_state == LLCP_CONNECTED) {
> 		ret = -EISCONN;
> 		goto error;
> 	}
> 	if (sk->sk_state == LLCP_CONNECTING) {
> 		ret = -EINPROGRESS;
> 		goto error;
> 	}
> 
> Crucially, it does not check for the LLCP_BOUND (or LLCP_LISTEN) state.
> Previous fixes addressing CVE-2020-25670 / CVE-2020-25673 added the check
> for LLCP_CONNECTING to prevent duplicate in-flight connection attempts
> from corrupting the connecting_sockets list. However, they assumed any
> other non-connected socket was in LLCP_CLOSED, leaving the LLCP_BOUND
> state window unhandled.
> 
> If connect() is invoked on a socket that has already been bound:
> 1. llcp_sock_connect() silently overwrites llcp_sock->dev and
>    llcp_sock->local without releasing previous references or freeing the
>    bound service_name, leading to refcount and memory leaks.
> 2. The socket remains linked in local->sockets, while llcp_sock_connect()
>    links it again into local->connecting_sockets via nfc_llcp_sock_link().
> 3. When connection confirmation (CC) arrives, nfc_llcp_recv_cc() executes:
> 
> 	nfc_llcp_sock_unlink(&local->connecting_sockets, sk);
> 	nfc_llcp_sock_link(&local->sockets, sk);
> 
>    Because sk was never unlinked from local->sockets, the head.first of
>    local->sockets still points to &sk->sk_node. The second
>    hlist_add_head() sets sk->sk_node.next = sk->sk_node, producing a
>    self-referential loop. Subsequent traversals of local->sockets
>    (e.g. nfc_llcp_sock_get(), nfc_llcp_socket_release()) enter an
>    infinite loop with spinlocks held, resulting in kernel soft-lockups.
> 4. Furthermore, if connect() specifies a different NFC device index than
>    bind(), the socket remains linked on device A's socket list while
>    being assigned to device B, causing cross-device socket confusion.
> 
> Fix this by ensuring that llcp_sock_connect() only accepts sockets in the
> LLCP_CLOSED state, returning -EBADFD otherwise, matching the state check
> behavior in llcp_sock_bind().
> 
> Fixes: d646960f7986 ("NFC: Initial LLCP support")
> Signed-off-by: Yuchao Zhang <ndaugoing@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>

