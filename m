Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794503103;
	b=aOA0cLzM0DsVoth8zCBPU7YheYm8kAludlz4Sk3tXCkmmqYYHAddRjdE+9hwNeZRJjbo
	 mtB0by+hO6NPpMzoz4r3Rw0vDoajIQfGSdc8A2a/wxOaES+87kVpLfF6Ng9WCPgZPUlMw
	 viB6LzpSNyvQ+xMFkQmeleJViQalch9Sy22rJENtzAntYYBWoyb95ehmYf42TOENrOojW
	 USgjkrJm1oPQQYbq8ZSHm5lBpIss9pfvfXDetrTKCfQtk97YnLN+AZRCPWdPZrezarL6Q
	 q/rZoS17vtxRT0TQ7ZPlB68qKLt6eu/nG8EkioP3xeI7XrjkgVb4F1xUCN354oJoq+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794503103;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=wbD8bqsyj1FI3svUFeCRQnTnpsoTV5729OFTLNVeQsY=;
	b=VzXRGqr9dWGizGhKri0FpKkwLBQhUVy0Yb7I1TIEZ0qlzowO8/FfL/FySUmmmMrAi0su
	 KinuY2pQK9T+k2g/pqZiTJ33LY3GVhgPkQqWtxgN/vjylldGHz2XCevXCE7zqurVd6GLn
	 2ck3Gjof/mYv+A+RruwS8gocOJ1bZETtc+dNn7eW45cRr5RhUP7iAy08nMlaENXgyjrMb
	 7a0NeiWOeaf0GhaYRAs/0LajliPsOJZbeJ7tIS1bftw82fOxpc41mP+Sh27XLhM37mZgW
	 eL7rMqRr8m+225tIUCnmyqO1TxpSDzAwvhRrnjlET9Ic5LRkRyuuM5ycHCL1WkOvKWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Eo0mCFUq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE27606A323
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 17:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Eo0mCFUq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B5861F000C4;
	Thu, 12 Nov 2026 17:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794503102;
	bh=wbD8bqsyj1FI3svUFeCRQnTnpsoTV5729OFTLNVeQsY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Eo0mCFUqVCu8SqQKARkPAwg+JYn+9QI1QclpjdFj3lLoo7qTygDTkm4gdFXvkG6dN
	 bcdpYfJRs5psWen+iJII0FxlvH0Dmv1KenwfJtmNb4glp5KpSEXJGcPmbV4Kh+xeY7
	 aP5r9dA9uAnLG5rNc55Wv8U8m//G9dltyIHJo8PU/ZRiYHOtpI5SkIQmOsFUry6F72
	 7fG9hNE8EZNHlo2kCMMoWOEsb6tk299gy6NSaQMYsdMKLAqPC3Tm/8kYlTLEsOAHJl
	 8dm6J3G6hXDK+pp+3NE1D6BmTm5AWymiGrq8kmLZ0GTnVIIEX4pi6tqFFzTAlAkF/b
	 /VTczqs9SvTWw==
Subject: Re: [PATCH net v2] tcp: fix NULL pointer dereference when restarting
 a Fast Open listener
From: netdev-bot+sashiko@kernel.org
To: imv4bel@gmail.com
Cc: edumazet@kernel.org, ncardwell@google.com, kuniyu@google.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org
Date: Thu, 12 Nov 2026 17:05:01 +0000
Message-ID: <179450310167.2199510.18107423940014989443@kernel.org>
In-Reply-To: <avMkfJrXhCFXn8M_@v4bel>
References: <avMkfJrXhCFXn8M_@v4bel>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch is meant to stop request_socks from being stranded in
  rskq_rst_head while they hold a listener reference, but another path…

--

tcp: fix NULL pointer dereference when restarting a Fast Open listener

This patch makes inet_csk_listen_stop() always take fastopenq.lock and
detach rskq_rst_head while holding it. That serializes the drain against
reqsk_fastopen_remove() adding entries to the RST list. The goal is to
stop request_socks from being stranded on rskq_rst_head while holding a
listener reference, and to avoid the NULL rskq_rst_tail dereference seen
when listen() is called again.

> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
> index 37cc8606d6835..9ca59dca5d184 100644
> --- a/net/ipv4/inet_connection_sock.c
> +++ b/net/ipv4/inet_connection_sock.c
> @@ -1533,17 +1533,15 @@ void inet_csk_listen_stop(struct sock *sk)

[ ... ]

> +	/* Free all the reqs queued in rskq_rst_head. */
> +	spin_lock_bh(&queue->fastopenq.lock);
> +	req = queue->fastopenq.rskq_rst_head;
> +	queue->fastopenq.rskq_rst_head = NULL;
> +	spin_unlock_bh(&queue->fastopenq.lock);
> +	while (req != NULL) {
> +		next = req->dl_next;
> +		reqsk_put(req);
> +		req = next;
>  	}
>  	WARN_ON_ONCE(sk->sk_ack_backlog);
>  }

[Severity: High]
Is this fix complete? The commit message says:

    With this synchronization, reqsk_fastopen_remove() either inserts the
    request_sock before inet_csk_listen_stop() acquires the lock, in which
    case inet_csk_listen_stop() reclaims it, or sees that the listener is
    not in TCP_LISTEN and does not insert anything.

That argument only holds if every exit from TCP_LISTEN goes through
inet_csk_listen_stop(). The failure path in inet_csk_listen_start()
does not:

net/ipv4/inet_connection_sock.c:inet_csk_listen_start() {
    ...
	reqsk_queue_alloc(&icsk->icsk_accept_queue);
    ...
	inet_sk_state_store(sk, TCP_LISTEN);
	err = sk->sk_prot->get_port(sk, inet->inet_num);
	if (!err) {
		...
		err = sk->sk_prot->hash(sk);

		if (likely(!err))
			return 0;
	}

	inet_sk_set_state(sk, TCP_CLOSE);
	return err;
}

Take a listener that went through shutdown(SHUT_RD) or connect(AF_UNSPEC)
while an accepted Fast Open child was still in SYN_RECV. Then listen() is
called on it again. If an RST for that child arrives after TCP_LISTEN is
stored, reqsk_fastopen_remove() passes this check under fastopenq->lock:

	if (!reset || lsk->sk_state != TCP_LISTEN) {

It then links req onto rskq_rst_head/rskq_rst_tail without calling
reqsk_put().

Now suppose get_port() fails afterwards, for example with EADDRINUSE
because another SO_REUSEADDR socket started listening on the port, or
hash() fails. The socket goes back to TCP_CLOSE and rskq_rst_head is never
drained.

A later close() will not reclaim the list, because __tcp_close() only
calls inet_csk_listen_stop() when sk_state == TCP_LISTEN. A later
successful listen() just overwrites the list in reqsk_queue_alloc():

	queue->fastopenq.rskq_rst_head = NULL;
	queue->fastopenq.rskq_rst_tail = NULL;

Does this leak the request_sock? If so, it also leaks the listener
reference taken in reqsk_alloc_noprof(), which only
sock_put(req->rsk_listener) in __reqsk_free() drops. That would pin the
listener sock and its netns reference too.

This looks like the same leak the commit message describes, reached
through a different TCP_LISTEN -> TCP_CLOSE transition.

Should the inet_csk_listen_start() error path also drain fastopenq under
fastopenq.lock? Alternatively, could the drain move to a place that covers
both paths?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/avMkfJrXhCFXn8M_%40v4bel
