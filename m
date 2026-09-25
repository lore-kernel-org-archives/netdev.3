Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231CE4A440F
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 13:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790344155; cv=none; b=rre6+AnmILdk80ohk+vvTgKjfR0UoSedQdDDAO7t+zpW/GmaJUff6iQeqlf4jzrI1jTA8WejcLYySKYETZ6Yc0X/HXwyAQOAnvB6Z1hhDEBDgb6cZaerXLl4BS+Oz7Trpx8AIJ8Ma6CKPqm18KptVgTSooDkZDrTvLMn/XTTZVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790344155; c=relaxed/simple;
	bh=jQljWpX2ZaLz44uWBfWHYe+GgOuAe3dD1ITZ7ziG1wQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jdW0HZaUjF0ohD5M7igPGneYmNG7jmlVxpVZUTwYktfWjCM2kXa3oV68MNSgkbUyIEHniQozxLkBFED01E6D933jD+Bh6iuzio1mvcwRItFQ+Dt3QU8tP78Q3o1XxCF3l9ya8Vf0UvIRzVKYj8XOBAdNIHMYVmbQJ3AmHXq76W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Re/tYJOO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Re/tYJOO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DDFB1F000FF;
	Fri, 25 Sep 2026 13:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790344153;
	bh=TGy28m5IfB1+BgKV18fzOYwK4Yk2MZZUpTwRtnLaVi0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Re/tYJOOv3admVdmO06yK0dtoC+XlUs37t293gHVkrH6uAlJA5RJKGajUcUj1gvXv
	 RybNeAI5QwdliXwKGIBjk+aWHG0YpPn3EZMsqEQCH3FA5NhHWM3dxN536n+ZSrTNkw
	 B4yqVEGCtQAJDudZqFSGWKDqdgSQylXO4F5YdKVCa47vj7NJO10Ru02Q2s8lbTZbO6
	 I9JH2zBisTvpThY0t62B8SqXJBuaOE/kMR8MSJPGCimg4xaEZqiVi2xQKJItCEgMIk
	 dtY7ZCwjbHVmBjXbjwlz1MHMZwcSFSsWHItvgT93CWRF3iU864chELPpACJJmAt7D+
	 D/IJ4JDnlL4Mg==
Subject:
 Re: [PATCH v2 net-next 1/9] dlm: fix send buffer backpressure handling
From: netdev-bot+sashiko@kernel.org
To: edumazet@google.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ncardwell@google.com, kuniyu@google.com, willemb@google.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
Date: Fri, 25 Sep 2026 13:49:12 +0000
Message-ID: <179034415277.2160803.7249465403484192965@kernel.org>
In-Reply-To: <20260924134729.2047213-2-edumazet@google.com>
References: <20260924134729.2047213-2-edumazet@google.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] This patch turns on the CF_APP_LIMITED / DLM_IO_END wait in
  send_to_sock() (fs/dlm/lowcomms.c).

--

dlm: fix send buffer backpressure handling

This patch changes send_to_sock() to test SOCK_NOSPACE instead of
SOCKWQ_ASYNC_NOSPACE. That bit has not lived in socket->flags since it
moved to socket_wq->flags.

With the patch, a TCP -EAGAIN sets CF_APP_LIMITED and returns
DLM_IO_END to wait for lowcomms_write_space(). Before, the send work was
requeued right away.

The patch also removes the stale clear_bit() of SOCKWQ_ASYNC_NOSPACE from
lowcomms_write_space().

> diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
> index 2aff1c7c17de4..abe9ae4c643fa 100644
> --- a/fs/dlm/lowcomms.c
> +++ b/fs/dlm/lowcomms.c

[ ... ]

> @@ -1391,7 +1389,7 @@ static int send_to_sock(struct connection *con)
>  	if (ret == -EAGAIN || ret == 0) {
>  		lock_sock(con->sock->sk);
>  		spin_lock_bh(&con->writequeue_lock);
> -		if (test_bit(SOCKWQ_ASYNC_NOSPACE, &con->sock->flags) &&
> +		if (test_bit(SOCK_NOSPACE, &con->sock->flags) &&
>  		    !test_and_set_bit(CF_APP_LIMITED, &con->flags)) {
>  			/* Notify TCP that we're limited by the
>  			 * application window size.

[Severity: High]
If the TCP connection is aborted while CF_APP_LIMITED is set, can the
send worker for that node stay stuck for good?

With this change the CF_APP_LIMITED / DLM_IO_END path is now live for
TCP. Once the flag is set, only lowcomms_write_space() or
close_connection() clear it.

A connection can be aborted by an RST from the peer (tcp_reset()), or by
tcp_write_err() after a retransmit, zero window probe or keepalive
timeout. All of these end up in tcp_done_with_error():

net/ipv4/tcp_input.c:tcp_done_with_error() {
    ...
	WRITE_ONCE(sk->sk_err, err);
	smp_wmb();
	tcp_write_queue_purge(sk);
	tcp_done(sk);
	if (!sock_flag(sk, SOCK_DEAD))
		sk_error_report(sk);
    ...
}

That path never calls sk->sk_write_space(), so lowcomms_write_space()
does not run.

lowcomms_error_report() does run, and it resends like this:

lowcomms_error_report()
  dlm_midcomms_unack_msg_resend()
    dlm_lowcomms_resend_msg()
      _dlm_lowcomms_commit_msg()
        lowcomms_queue_swork()

However, lowcomms_queue_swork() does nothing while the flag is set:

	if (!test_bit(CF_IO_STOP, &con->flags) &&
	    !test_bit(CF_APP_LIMITED, &con->flags) &&
	    !test_and_set_bit(CF_SEND_PENDING, &con->flags))
		queue_work(io_workqueue, &con->swork);

An RST does not call sk_data_ready, so process_recv_sockets() usually
does not run. When it does, its ret < 0 path for the main connection also
goes through lowcomms_queue_swork(), and is blocked in the same way.

So send_to_sock() never calls sock_sendmsg() again and never sees the
socket error. As a result, process_send_sockets() never reaches:

	default:
		if (ret < 0) {
			close_connection(con, false);

After that, every dlm_lowcomms_commit_msg() to that node is queued but
never sent.

If the peer reconnects, accept_from_sock() still finds con->sock set.
It attaches the new socket to othercon, which only receives. The send
side stays stuck until membership recovery calls dlm_lowcomms_close().

There is also a race here. Suppose the RST arrives after sock_sendmsg()
returns -EAGAIN but before lock_sock(). The error_report kick is lost,
because CF_SEND_PENDING is still set.

This code then sees SOCK_NOSPACE still set, and arms CF_APP_LIMITED on a
socket that is already dead. Neither sk->sk_err nor sk_state is checked
before it arms the flag.

Before this patch, send_to_sock() always returned DLM_IO_RESCHED. The
next sendmsg() on the dead socket failed with -ECONNRESET or -EPIPE, and
process_send_sockets() then closed the connection and reconnected.

The commit message says:

    This restores the semantics dlm had before the bit moved.

The CF_APP_LIMITED check in lowcomms_queue_swork() was added in 2022 by
commit dbb751ffab0b ("fs: dlm: parallelize lowcomms socket handling").
That was long after the bit stopped working.

Has that check ever been exercised with a working CF_APP_LIMITED path?

The later patches in this series do not seem to change this. They only
replace the bit operations with sk_set_nospace() / sk_clear_nospace().
lowcomms_error_report(), lowcomms_queue_swork() and this arming check
stay the same.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260924134729.2047213-1-edumazet%40google.com
