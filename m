Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B5A3D5668;
	Thu, 10 Sep 2026 06:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789022113; cv=none; b=ofpGMZVO5V9FuUPk6bgHMTFYqe3OiJdnsLiRBFFRbTEipPbeRabLWuDZxEGKF53s1wh6UHXGXABUkCGF+SckOIRSAi1CvWsqvDQQHRD/2YPwLDX/RPrAQg/5mDPUXIKlkK0DGCy9hbZ2Ru4aILuCZhaLQLwSlOW3I+tVbdnf1b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789022113; c=relaxed/simple;
	bh=6dO5xsTdCHe+Rlre4CNhPM4AceKxp6LoUHgY4xoauWg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e5UjK6HaGtQUagH7pxcUQmKBY7mup+yiV82lID+y/Udpof0NAvYxexDGYZl3MHxijDx5framiqOUcLKD07Ug1BxITb4+uLgcmFHz3oCqiHQGqaSkyB7f/uQxx+zwKD7lZWJhjpLsAdCRzYbuIEYU4+l41dD/Khb19Dl++Siy4I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TwsrRT5c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TwsrRT5c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25BA31F000FF;
	Thu, 10 Sep 2026 06:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789022111;
	bh=GUjaWT/4AjkCL1zxMcOsSiItM4siXuY2MNJ3WGRtXCc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=TwsrRT5clN7yiQvGw0VX9PoKOJCnnYqn+SxBoPk2Zn3ftcXTOYUPC3j5h3RhldvnK
	 G7qoWR5k8IoEaBd5zvRfq26vNWeG6X27Zx55QaR4XQ2iJI9BiXdbwxmVovImXsVLOP
	 QMG2hF2trXWmQApWxGw1Mh+60agA3jwVmUG+r9MxDtCUfYG3ShsXpZA5Qg2FMBb7aM
	 M3b1QeereacBZZpDibA9CmwyQSa2CskskEMzBC7AEg8Ztdui6/gds/0TZwTn3v877W
	 0TJUXTV7PD6hcu0UaXCTGjdVoPAJVV2zvYAL3xVtMlTi23YNLHl36nP9L6fveO5qv+
	 szdq043E1CcnA==
Subject: Re: [PATCH] tcp: validate old ACKs before fast path data processing
From: netdev-bot+sashiko@kernel.org
To: inbal.lipshtat@mail.huji.ac.il
Cc: edumazet@google.com, ncardwell@google.com, kuniyu@google.com,
 netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, linux-kernel@vger.kernel.org,
 amit.klein@mail.huji.ac.il, tamir.shahar1@mail.huji.ac.il
Date: Thu, 10 Sep 2026 06:35:10 +0000
Message-ID: <178902211070.219967.15947434635255374738@kernel.org>
In-Reply-To: <20260906123151.1391349-1-inbal.lipshtat@mail.huji.ac.il>
References: <20260906123151.1391349-1-inbal.lipshtat@mail.huji.ac.il>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 3

- [Medium] Incomplete RFC5961 enforcement: the new ACK-acceptability
  check is only added to the data-carrying fast-path branch of…
- [Low] The patch fixes a remotely triggerable, security-relevant defect
  (the ESTABLISHED fast path accepting payload from a segment whose…
- [Low] No in-tree test covers the newly added enforcement.
- [Low] The rationale comment for the tp->bytes_acked term is lost.

--

tcp: validate old ACKs before fast path data processing

This adds an RFC5961 5.2 SEG.ACK acceptability test to the ESTABLISHED
fast path in tcp_rcv_established(), before the segment payload is queued,
sending a challenge ACK and dropping the segment when the ACK is too old.
The existing test in tcp_ack() is factored into a new tcp_ack_too_old()
helper shared by both call sites.

Link: https://www.cve.org/CVERecord?id=CVE-2023-52881

A few questions below.

[Severity: Low]
The changelog names both CVE-2023-52881 and commit 3d501dd326fb1c7 ("tcp:
do not accept ACK of bytes we never sent"), but the tag block has no
Fixes: line and no stable routing indication.

Should this carry a Fixes: tag so stable selection and CVE correlation
have something to key on?  The candidates implied by the changelog are the
original RFC5961 5.2 mitigation (which only touched tcp_ack()) and/or
3d501dd326fb1c7.

[Severity: Low]
The changelog carries a working reproducer, but nothing in-tree exercises
the new hunk.  The existing script
tools/testing/selftests/net/packetdrill/tcp_rfc5961_ack-out-of-window.pkt
injects only zero-length probes for both edges:

  +0 < . 1:1(0) ack 2 win 1000
  ...
  +0 < . 1:1(0) ack 1000 win 1000

Those take the len == tcp_header_len pure-ACK branch (or the slow path),
so that test passes identically with and without this patch.

Could the packetdrill script from the changelog (500-byte priming segment
followed by the 1000-byte segment with ack 2794967397) be added next to
the existing rfc5961 case, so a later refactor of the fast path cannot
silently drop the check?

> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 0f60a1dbf9274..6ebf72cd9a755 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -4272,6 +4272,17 @@ static void tcp_rack_update_reo_wnd(struct sock *sk, struct rate_sample *rs)
>  	}
>  }
>  
> +/* Validates that the ACK is older than the acceptable historical ACK window*/
> +static inline bool tcp_ack_too_old(const struct tcp_sock *tp, u32 ack,
> +				   u32 snd_una)
> +{
> +	u32 max_window;
> +
> +	max_window = min_t(u64, tp->max_window, tp->bytes_acked);
> +
> +	return before(ack, snd_una - max_window);
> +}
> +

[Severity: Low]
The helper comment describes a plain MAX.SND.WND window, but the code also
bounds by tp->bytes_acked, which is strictly tighter than RFC5961.  The
comment explaining that term is deleted in the hunk below and not
reproduced here:

-		/* do not accept ACK for bytes we never sent. */
-		max_window = min_t(u64, tp->max_window, tp->bytes_acked);

Since the helper now has two call sites, could the "do not accept ACK for
bytes we never sent" rationale be moved into tcp_ack_too_old() alongside
the RFC5961 note?

>  /* This routine deals with incoming acks, but not outgoing ones. */
>  static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
>  {
> @@ -4303,12 +4314,8 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
>  	 * then we can probably ignore it.
>  	 */
>  	if (before(ack, prior_snd_una)) {
> -		u32 max_window;
> -
> -		/* do not accept ACK for bytes we never sent. */
> -		max_window = min_t(u64, tp->max_window, tp->bytes_acked);
>  		/* RFC 5961 5.2 [Blind Data Injection Attack].[Mitigation] */
> -		if (before(ack, prior_snd_una - max_window)) {
> +		if (tcp_ack_too_old(tp, ack, prior_snd_una)) {
>  			if (!(flag & FLAG_NO_CHALLENGE_ACK))
>  				tcp_send_challenge_ack(sk, false);
>  			return -SKB_DROP_REASON_TCP_TOO_OLD_ACK;

[ ... ]

> @@ -6614,6 +6621,15 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
>  			if ((int)skb->truesize > sk->sk_forward_alloc)
>  				goto step5;
>  
> +			if (unlikely(before(TCP_SKB_CB(skb)->ack_seq, tp->snd_una))) {
> +				if (tcp_ack_too_old(tp, TCP_SKB_CB(skb)->ack_seq,
> +						    tp->snd_una)) {
> +					tcp_send_challenge_ack(sk, false);
> +					reason = SKB_DROP_REASON_TCP_TOO_OLD_ACK;
> +					goto discard;
> +				}
> +			}
> +

[Severity: Medium]
The new check sits inside the else branch of if (len <= tcp_header_len),
so it only covers data-bearing segments.  Was the sibling pure-ACK branch
intentionally left out?

That branch still does this, in this order, in tcp_rcv_established():

	if (len <= tcp_header_len) {
		if (len == tcp_header_len) {
			if (tcp_header_len ==
			    (sizeof(struct tcphdr) + TCPOLEN_TSTAMP_ALIGNED) &&
			    tp->rcv_nxt == tp->rcv_wup)
				flag |= __tcp_replace_ts_recent(tp, delta);

			tcp_ecn_received_counters(sk, skb, 0);
			...
			tcp_ack(sk, skb, flag);
			__kfree_skb(skb);
			tcp_data_snd_check(sk);
			tp->rcv_rtt_last_tsecr = tp->rx_opt.rcv_tsecr;
			return;

__tcp_replace_ts_recent() stores unconditionally:

net/ipv4/tcp_input.c:__tcp_replace_ts_recent() {
	tcp_store_ts_recent(tp);
	return tstamp_delta > 0 ? FLAG_TS_PROGRESS : 0;
}

So for a bare ACK matching tp->pred_flags with seq == tp->rcv_nxt,
!after(ack_seq, tp->snd_nxt), and before(ack_seq, tp->snd_una -
min(max_window, bytes_acked)), tp->rx_opt.ts_recent is advanced to the
segment's TSval, the ECN receive counters are bumped, and
tp->rcv_rtt_last_tsecr is taken from that segment.

tcp_ack() then reaches the same tcp_ack_too_old() test, sends the
challenge ACK and returns -SKB_DROP_REASON_TCP_TOO_OLD_ACK, but the
return value is still discarded here and nothing is rolled back or
accounted as a drop.

This is the same condition the changelog describes:

    "In the fast path, tcp_ack() is also called,
    but only after the data from the segment is processed.
    Furthermore, the return value from tcp_ack() is not checked."

The slow path does not have this ordering problem, since tcp_ack() runs
the too-old test before the FLAG_UPDATE_TS_RECENT handling, and step5
checks (int)reason < 0.

Would hoisting the new check up to just after the header prediction test,
before if (len <= tcp_header_len), cover both branches with a single call
site instead of leaving the pure-ACK branch as is?

>  			/* Predicted packet is in window by definition.
>  			 * seq == rcv_nxt and rcv_wup <= rcv_nxt.
>  			 * Hence, check seq<=rcv_wup reduces to:

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260906123151.1391349-1-inbal.lipshtat%40mail.huji.ac.il
