Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BF03D1CAE;
	Thu,  8 Oct 2026 09:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791452412; cv=none; b=QSysqkSFsBUJUoKap/BZftX4bP6EjVxjFxC/ec7EASLleW3FGyvCySUtPEHvWljOZFVmc/OKQVRZnFKsWY+4GJBIWfjQXFvxjTeYg+1k0Mvqc5oDaf9t52TdNKoj0zR3N8c2/y5UyjWwO2Z9qOZQcjVhL0b7qeP++zKzsmGizjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791452412; c=relaxed/simple;
	bh=+IMv3sXzs8BTK1qu+9caQ7PaJuthejvXrTDxnpWlI0Y=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=evoFAedwdK5dagoRZ8dYS/l/aXjD5VveY4G586zMyHKE9CUtGRUNzeDMBFLziTNmOePhm0o07d0uTkmJ7IDhXq+cvujIcwUWFBk7Uh2zVxdUrUz+4//pcWuP3J+SUYTukqa2Ajr1LbHot/nLd9OHlC6UceBch4UMitAk9ciMOcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EU9TGESN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EU9TGESN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFA541F000FF;
	Thu,  8 Oct 2026 09:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791452410;
	bh=C0yE/7lUsAyL+nx261PJuPICQ8yvH4+l+7EV2CV84VY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=EU9TGESNjXpogbfu1Xw7rXI7P2Cg7tiiB8RJzxyHjl1J4HYlt0wi8LK1bFMEQ38O1
	 TVL5XGDzKP6jPuidY2mb2xZla0WzO49dUWPUOH0umXkJiTSSN6aavyMW/LexvQmGCq
	 fdEx78ywrFfS73V+PID60LEeUubRssNWpJMQkZXICy9Wc9vpzZBVdBh4wsDzcafEB/
	 A1ByoDaKVqhJp9AGOvtYgXe6fZTM2Go/nxZbuhhtSD3g3aVeARtmzUHHf79SCjq4Z9
	 pkXgXPYXi8OZEHL6oIa27HV82narPUHgMR2NRo1IMCWYJsER65H7YABP5VBa8SS9Lj
	 GWbfF4NarwpZQ==
Subject: Re: [PATCH net] tcp: reject devmem tx with fastopen and repair
From: netdev-bot+sashiko@kernel.org
To: kaifengw@google.com
Cc: netdev@vger.kernel.org, edumazet@google.com, ncardwell@google.com,
 kuniyu@google.com, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, asml.silence@gmail.com, almasrymina@google.com,
 willemb@google.com, kaiyuanz@google.com, sdf@fomichev.me,
 linux-kernel@vger.kernel.org
Date: Thu, 08 Oct 2026 09:40:09 +0000
Message-ID: <179145240932.434549.7611587204685903726@kernel.org>
In-Reply-To: <20261005214002.3226574-1-kaifengw@google.com>
References: <20261005214002.3226574-1-kaifengw@google.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new devmem rejection in tcp_sendmsg_locked()
  (net/ipv4/tcp.c:1172-1177) is wrapped in `!sockc_err`, so it does…
- [Medium] In tcp_sendmsg_locked(), the new `tp->repair` rejection
  (net/ipv4/tcp.c:1172-1177) runs once at the top, while the socket lock…

--

tcp: reject devmem tx with fastopen and repair

This commit extends the devmem TX check in tcp_sendmsg_locked() so that it
also rejects sends when TCP Fast Open (MSG_FASTOPEN or DEFER_CONNECT) or TCP
repair mode is active. Both paths byte-copy from the iterator and would treat
dma-buf offsets as user pointers.

> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 87ef6d5cbfeba..225e758c194aa 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -1169,7 +1169,9 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
>  			zc = MSG_SPLICE_PAGES;
>  	}
>  
> -	if (!sockc_err && sockc.dmabuf_id && (zc != MSG_ZEROCOPY || !binding)) {
> +	if (!sockc_err && sockc.dmabuf_id &&
> +	    (zc != MSG_ZEROCOPY || !binding || tp->repair ||
> +	     (flags & MSG_FASTOPEN) || inet_test_bit(DEFER_CONNECT, sk))) {

[Severity: Medium]
Can the !sockc_err gate let the Fast Open and repair cases through?

sock_cmsg_send() processes cmsgs in order. It returns at the first error and
does not undo fields that earlier cmsgs already set. __sock_cmsg_send() stores
dmabuf_id as soon as it sees SCM_DEVMEM_DMABUF:

net/core/sock.c:__sock_cmsg_send() {
    ...
	case SCM_DEVMEM_DMABUF:
		if (cmsg->cmsg_len != CMSG_LEN(sizeof(u32)))
			return -EINVAL;
		sockc->dmabuf_id = *(u32 *)CMSG_DATA(cmsg);
		break;
    ...
}

Suppose a valid SCM_DEVMEM_DMABUF is followed by a cmsg that fails. Two
examples:

  SCM_TS_OPT_ID, which always returns -EINVAL on TCP
  SO_PRIORITY with a value the caller may not set, which returns -EPERM

In that case sockc.dmabuf_id stays set and sockc_err is non-zero, so the new
check is skipped entirely.

The Fast Open branch runs whether or not sockc_err is set:

	if (unlikely(flags & MSG_FASTOPEN ||
		     inet_test_bit(DEFER_CONNECT, sk)) &&
	    !tp->repair) {
		err = tcp_sendmsg_fastopen(sk, msg, &copied_syn, size, uarg);
		if (err == -EINPROGRESS && copied_syn > 0)
			goto out;

tcp_sendmsg_fastopen()->tcp_send_syn_data() then calls copy_page_from_iter()
and treats the iov_base values as user addresses. When copied_syn > 0 the code
jumps to out, so sockc_err is never returned and the send looks successful.

The repair TCP_RECV_QUEUE path works the same way. tcp_send_rcvq() runs and
jumps to out_nopush before the later "if (sockc_err)" check.

Could the Fast Open and repair conditions be tested against sockc.dmabuf_id
without the !sockc_err gate? Another option would be to return sockc_err
before these early copy paths when dmabuf_id is set.

>  		err = -EINVAL;
>  		goto out_err;
>  	}

[Severity: Medium]
Is it enough to check tp->repair only once, at the top of the function?

If the socket is still in SYN_SENT or SYN_RECV, tcp_sendmsg_locked() later
calls sk_stream_wait_connect(). While it sleeps, sk_wait_event() drops the
socket lock via release_sock().

During that window, another thread with CAP_NET_ADMIN in the netns user
namespace can run:

  setsockopt(TCP_REPAIR, TCP_REPAIR_ON)
    tcp_can_repair_sock() only requires sk_state != TCP_LISTEN
  setsockopt(TCP_REPAIR_QUEUE, TCP_RECV_QUEUE)
    do_tcp_setsockopt() only requires tp->repair

Once the connection is established, the sender wakes up and reads tp->repair
again:

	if (unlikely(tp->repair)) {
		if (tp->repair_queue == TCP_RECV_QUEUE) {
			copied = tcp_send_rcvq(sk, msg, size);
			goto out_nopush;
		}

tcp_send_rcvq() then calls skb_copy_datagram_from_iter() on the devmem
iterator even though binding is held. This is the repair case the commit
message describes.

The devmem setup can pass the entry check in SYN_SENT. Connect has already
set sk_route_caps and the dst, so zc == MSG_ZEROCOPY and
net_devmem_get_binding() succeeds.

Would rejecting a non-NULL binding inside the tp->repair branch cover this?
Repeating the check after the wait would also work.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261005214002.3226574-1-kaifengw%40google.com
