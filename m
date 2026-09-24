Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492F522A80D
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 00:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790209661; cv=none; b=gSG3bPh9sk6jGyZ3VoHY6lJpGhMTTeL2LdKEiz1H47LFd0O9LOSTlfyASPz1IiCk9NZrcYG9gdHN7suOJ+huRuoMEXDrPVfXDT3evSttDYc/ac+/3d74NyvVh+k3QRN9qBTBjk/GtCy0XfF7/kns/Y4O6wsFPIqn+nDieY+hQy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790209661; c=relaxed/simple;
	bh=7pupVE6FUU2YtAtM15MnAR3OHdI99nGsHiaLGwN01aU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uWCReTg8SVi8a/WFxCDjaLB/ZvsWN+Mhis59vxjnJVN4A0pOx7fdap3050R8xs+qJE8LJQsrJq2jCsOOtg4N8MXmbSEEWOyxt6o9OLoU4kftFifgnlCnD5/WLVYiSjOdCxz/iYNLd8QJel/Wp1NlNKf5NMZX9Ie9QqYGfWHNArM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l5nwMRvt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l5nwMRvt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ED9A1F000FF;
	Thu, 24 Sep 2026 00:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790209659;
	bh=TKWJx95XpYyCX011ri2ZAUwoGkkwUhwnKkG32XTsvVY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=l5nwMRvteU4DDHkN6tZ29nrMQxN5Y2pSBnpro3BNN+6pdDznnFIWe/9WGGAUV2/nY
	 fGPbiF8kdDZ3RNabl+OCF2TVe+yMvziTGXzvCk2/3NgNMXp1x4WMaz4nCB3aHIOS1/
	 ModUz4/5/AW34Ss8x4xkbDNUSpHdJS13GdRAyVPoN7RCFs8Saw8UtqC6vuaODWtI/M
	 fEJLVV0KZCrm/QzPpGx8nu3777elFabQz9YVFnqWcgL0VxlI3VMvBSbXLPjJLrb79Z
	 TAmlcxKnqwZjwlnSOCGpuu/Cnrk1syM64tOFhXtIvhi1vxVggC0g4pcO9EjuAG4p2G
	 +kPuxcltQc57A==
Subject: Re: [PATCH net-next 1/9] dlm: fix send buffer backpressure handling
From: netdev-bot+sashiko@kernel.org
To: edumazet@google.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ncardwell@google.com, kuniyu@google.com, willemb@google.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
Date: Thu, 24 Sep 2026 00:27:38 +0000
Message-ID: <179020965880.2160803.15947896824748271639@kernel.org>
In-Reply-To: <20260922122721.3568295-2-edumazet@google.com>
References: <20260922122721.3568295-2-edumazet@google.com>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] fs/dlm/lowcomms.c:send_to_sock() — making the CF_APP_LIMITED
  branch live for the first time in ten years introduces a permanent…
- [Low] fs/dlm/lowcomms.c:send_to_sock(): after switching the guard to
  SOCK_NOSPACE, the guard and the "Notify TCP" action now operate on the…

--

dlm: fix send buffer backpressure handling

The send path in fs/dlm/lowcomms.c tested SOCKWQ_ASYNC_NOSPACE in
con->sock->flags, a bit that has not lived there since commit ceb5d58b2170,
so the test was always false and send_to_sock() always returned
DLM_IO_RESCHED on -EAGAIN. The patch switches the test to SOCK_NOSPACE and
drops the matching clear_bit() in lowcomms_write_space().

> diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
> index 2aff1c7c17de4..abe9ae4c643fa 100644
> --- a/fs/dlm/lowcomms.c
> +++ b/fs/dlm/lowcomms.c
> @@ -522,10 +522,8 @@ static void lowcomms_write_space(struct sock *sk)
>  	clear_bit(SOCK_NOSPACE, &con->sock->flags);
>  
>  	spin_lock_bh(&con->writequeue_lock);
> -	if (test_and_clear_bit(CF_APP_LIMITED, &con->flags)) {
> +	if (test_and_clear_bit(CF_APP_LIMITED, &con->flags))
>  		con->sock->sk->sk_write_pending--;
> -		clear_bit(SOCKWQ_ASYNC_NOSPACE, &con->sock->flags);
> -	}
>  
>  	lowcomms_queue_swork(con);
>  	spin_unlock_bh(&con->writequeue_lock);
> @@ -1391,7 +1389,7 @@ static int send_to_sock(struct connection *con)
>  	if (ret == -EAGAIN || ret == 0) {
>  		lock_sock(con->sock->sk);
>  		spin_lock_bh(&con->writequeue_lock);
> -		if (test_bit(SOCKWQ_ASYNC_NOSPACE, &con->sock->flags) &&
> +		if (test_bit(SOCK_NOSPACE, &con->sock->flags) &&
>  		    !test_and_set_bit(CF_APP_LIMITED, &con->flags)) {

[Severity: High]
This makes the CF_APP_LIMITED branch reachable for the first time in ten
years.  Once it is taken, is there anything left that can restart this
connection if the TCP connection then dies?

send_to_sock() parks the send worker:

	if (test_bit(SOCK_NOSPACE, &con->sock->flags) &&
	    !test_and_set_bit(CF_APP_LIMITED, &con->flags)) {
		...
		con->sock->sk->sk_write_pending++;
		clear_bit(CF_SEND_PENDING, &con->flags);
		...
		/* wait for write_space() event */
		return DLM_IO_END;
	}

process_send_sockets() just breaks on DLM_IO_END, so nothing is queued on
io_workqueue for this connection any more.

The only place that clears CF_APP_LIMITED on a live socket is
lowcomms_write_space(), and that is only reached from TCP ACK processing
(tcp_check_space() -> tcp_new_space() -> sk->sk_write_space()).

If the peer stops acking, tcp_reset() or tcp_write_err() end up in
tcp_done_with_error(), which purges the write queue, calls tcp_done() and
sk_error_report().  None of those call sk->sk_write_space(), and an RST
does not produce an sk_data_ready() either, so neither worker is woken.

Every remaining restart point goes through lowcomms_queue_swork(), which
refuses to queue while CF_APP_LIMITED is set:

	if (!test_bit(CF_IO_STOP, &con->flags) &&
	    !test_bit(CF_APP_LIMITED, &con->flags) &&
	    !test_and_set_bit(CF_SEND_PENDING, &con->flags))
		queue_work(io_workqueue, &con->swork);

That gate covers _dlm_lowcomms_commit_msg() for new messages, the
retransmit path lowcomms_error_report() -> dlm_midcomms_unack_msg_resend()
-> dlm_lowcomms_resend_msg() -> _dlm_lowcomms_commit_msg(), and the
receive-side error recovery in process_recv_sockets():

		if (ret < 0) {
			if (test_bit(CF_IS_OTHERCON, &con->flags)) {
				close_connection(con, false);
			} else {
				spin_lock_bh(&con->writequeue_lock);
				lowcomms_queue_swork(con);
				spin_unlock_bh(&con->writequeue_lock);
			}

lowcomms_error_report() only logs, asks for a retransmit and forwards to
the default error report; it neither clears CF_APP_LIMITED nor closes the
connection.  dlm_lowcomms_connect_node() only queues swork when
con->sock == NULL, and the dead socket is never closed, so con->sock stays
non-NULL.

Before this change the (dead) test meant send_to_sock() returned
DLM_IO_RESCHED, swork was requeued, the next sock_sendmsg() picked up the
socket error and the ret < 0 path did close_connection() plus
lowcomms_queue_swork().  So the CPU-burning loop the patch removes was
also the error detection and reconnect mechanism.

Would it make sense to add a fallback that clears CF_APP_LIMITED or closes
the connection when sk_err is set, so a peer RST or retransmission timeout
during the app-limited state does not leave the connection permanently
silent?

>  			/* Notify TCP that we're limited by the
>  			 * application window size.

[Severity: Low]
With the test switched to SOCK_NOSPACE, does the body of this branch still
do anything?  The guard and the notification now touch the same bit in the
same word:

	if (test_bit(SOCK_NOSPACE, &con->sock->flags) &&
	    !test_and_set_bit(CF_APP_LIMITED, &con->flags)) {
		/* Notify TCP that we're limited by the
		 * application window size.
		 */
		set_bit(SOCK_NOSPACE, &con->sock->sk->sk_socket->flags);

For the kernel sockets dlm creates, sk->sk_socket == con->sock, which is
also how lowcomms_write_space() spells it:

	clear_bit(SOCK_NOSPACE, &con->sock->flags);

lock_sock(con->sock->sk) is held across the test and the set, so the bit
cannot be cleared in between, and the set_bit() can never change state.
The comment about notifying TCP then describes something the code no
longer does.

The two different spellings of one flags word inside a single if statement
are the same kind of trap that produced the dead test this patch fixes, so
perhaps the set_bit() and its comment could be dropped, or at least
spelled consistently as con->sock->flags.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922122721.3568295-1-edumazet%40google.com
