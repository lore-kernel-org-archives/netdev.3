Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E186C52BE27
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 22:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788560719; cv=none; b=g5NgaJTGLEXVX0bQJzrt1tiQEFGaEgxmL0dlTtN2Gmc569S+pMIPHgE7+S0hR0Nm9VHpIRrhNKo5rctpUt/wo9n6CDe1Yh0TrrvH5J2azPZBH/8gfYJFC4/4c5u0GBcnVon+qYyAVxezMLb841csI37tMCrfkE1xAfKepZfPZVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788560719; c=relaxed/simple;
	bh=x6LW4cfDKhCpdnYTBTqj2RfNxq++JepFzcizrJmReE8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uDR9BwJ1Y/2QJSuIN1HEVt3LE4uzETvyfnhGbXJHao9JyVUaylNvWEIkcZKoNrNn4I2jvz3m5bXoAK+zNcHh+xa/CpnhB/+boZK0Nib6zaOtWLyHA1yr7Xq8wqBoMCPJjezJH0ZEk2mZRAHpMZlo/nTdJFmmRdEdYwN6I+Ujp6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PW3Au2Ti; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PW3Au2Ti"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00D551F00AC4;
	Fri,  4 Sep 2026 22:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788560713;
	bh=lg++jsLz4193tx4qFapAb9QSWQqe6czbLwvEpz+f+2c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PW3Au2TiM6xUpnvqcSKQBFEr5sro7bbfDZuEnMc9Jh1HeiSvVVBTlPIWf1KDus3sf
	 zpUNq+m0En/+m3qQDIJgI+B4qDo2KOHVhwFrfBMouwAgVy4InrsYatr2h3HwPe2ERH
	 t9FmyiHHXzkX8PffJmhJ9CM073b0nTNY88igNpRXYCdnKf3VMTJmx2yyXumvqGZBJh
	 Ftfjbz15bz6GUClOLjneANgXupDNGMvRZ0ob45Hekpwbfe3mry2q5enBqGobhWFKeW
	 ra5LHFyEceyav3gqqFmBpIAGH7HTxFVldg+JDIZNS5CUWfo+CL07HEg3bt/owRnKW8
	 A0D3ocXOJZjAw==
Subject: Re: [PATCH net v3] tcp: reject completely old segments during
 sequence validation
From: netdev-bot+sashiko@kernel.org
To: michael.cohen3@mail.huji.ac.il
Cc: netdev@vger.kernel.org, edumazet@google.com, ncardwell@google.com,
 kuniyu@google.com, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, tamir.shahar1@mail.huji.ac.il, amit.klein@mail.huji.ac.il
Date: Fri, 04 Sep 2026 22:25:12 +0000
Message-ID: <178856071254.219967.2120471585250029809@kernel.org>
In-Reply-To: <20260831205611.2439538-1-michael.cohen3@mail.huji.ac.il>
References: <20260831205611.2439538-1-michael.cohen3@mail.huji.ac.il>
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
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 0 · Low: 1

- [High] Incomplete fix: the new old-segment rejection in tcp_sequence()
  (net/ipv4/tcp_input.c:4847-4852) is bypassed by any segment that sets…
- [Low] The block comment documenting tcp_sequence()
  (net/ipv4/tcp_input.c:4827-4838) now contradicts the implementation in…

--

tcp: reject completely old segments during sequence validation

This tightens tcp_sequence() so that a segment consuming sequence space with
end_seq equal to tp->rcv_wup is rejected as completely old, instead of only
rejecting end_seq strictly before rcv_wup.  Segments with SYN or FIN set, and
segments that consume no sequence space, keep the previous behaviour.

> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 0f60a1dbf927..37316d07f996 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -4844,8 +4844,12 @@ static enum skb_drop_reason tcp_sequence(const struct sock *sk,
>  	const struct tcp_sock *tp = tcp_sk(sk);
>  	u32 seq_limit;
>  
> -	if (before(end_seq, tp->rcv_wup))
> -		return SKB_DROP_REASON_TCP_OLD_SEQUENCE;
> +	if (unlikely(!after(end_seq, tp->rcv_wup))) {
> +		if (before(end_seq, tp->rcv_wup) ||
> +		    (seq != end_seq &&
> +		     !(tcp_flag_byte(th) & (TCPHDR_SYN | TCPHDR_FIN))))

[Severity: High]
Can a data segment that also sets FIN still slip through this check?

For a segment with N bytes of payload and FIN set, tcp_v4_rcv() (and
tcp_v6_rcv()) compute:

	TCP_SKB_CB(skb)->end_seq = (TCP_SKB_CB(skb)->seq + th->syn + th->fin +
				    skb->len - th->doff * 4);

so end_seq = seq + N + 1.  Choosing seq = rcv_wup - N - 1 gives
end_seq == tp->rcv_wup, which means:

  - the outer !after(end_seq, tp->rcv_wup) test is true,
  - before(end_seq, tp->rcv_wup) is false,
  - seq != end_seq is true, but the mask term
    !(tcp_flag_byte(th) & (TCPHDR_SYN | TCPHDR_FIN)) is false because FIN
    is set.

tcp_sequence() then returns SKB_NOT_DROPPED_YET.  In
tcp_validate_incoming() the segment is not RST and not SYN, so step 2 and
step 4 are skipped and control reaches pass:, after which
tcp_rcv_established() calls:

	reason = tcp_ack(sk, skb, FLAG_SLOWPATH | FLAG_UPDATE_TS_RECENT);

Isn't that exactly the ACK processing of a completely old segment that the
changelog and the packetdrill reproducer aim to prevent, reachable again by
setting one flag bit?  The v2 note says the carve-out exists to
"preserve existing SYN/FIN handling, including simultaneous connect and
retransmitted SYN+ACK AccECN processing", but a retransmitted pure FIN has
end_seq == seq + 1 with no payload, so would restricting the exemption to
segments that consume no payload sequence space be enough, rather than
exempting all FIN-flagged segments including data+FIN?

Note tcp_data_queue() still drops the payload and does not call tcp_fin()
because seq != rcv_nxt, so the residual effect is the ACK processing itself
(snd_una and bytes_acked accounting, RTT and window sampling, congestion
control state) driven by the peer-controlled ack field of an
RFC-unacceptable segment.

[Severity: Low]
Does the block comment above tcp_sequence() still match the code after this
change?  It currently says:

 * Segment controls are considered valid, if the segment
 * fits to the window after truncation to the window. Acceptability
 * of data (and SYN, FIN, of course) is checked separately.
 * See tcp_data_queue(), for example.
 *
 * Also, controls (RST is main one) are accepted using RCV.WUP instead
 * of RCV.NXT.

The new branch inspects tcp_flag_byte(th) and seq != end_seq, so the
data versus SYN/FIN acceptability decision now happens inside
tcp_sequence() rather than only in tcp_data_queue().

The second part mentions RST as the main control accepted at RCV.WUP, but
the exemption mask lists only TCPHDR_SYN | TCPHDR_FIN.  A RST carrying
payload (allowed by RFC 1122 4.2.2.12) has end_seq = seq + len with no +1,
so seq != end_seq and neither SYN nor FIN is set.  With
seq = rcv_wup - len such a RST now returns
SKB_DROP_REASON_TCP_OLD_SEQUENCE, and tcp_validate_incoming() takes:

	} else if (tcp_reset_check(sk, skb)) {
		goto reset;
	}
	goto discard;

so it no longer reaches step 2 and no longer emits the RFC 5961 challenge
ACK it produced before.  Would it be better to update the comment to say
that at the RCV.WUP boundary only zero-length segments and SYN/FIN segments
are accepted, or to add RST to the flag mask?

> +			return SKB_DROP_REASON_TCP_OLD_SEQUENCE;
> +	}
>  
>  	seq_limit = tp->rcv_nxt + tcp_max_receive_window(tp);
>  	if (unlikely(after(end_seq, seq_limit))) {

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831205611.2439538-1-michael.cohen3%40mail.huji.ac.il
