Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46144078E7
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 21:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787261141; cv=none; b=rTl4sSUz86OTeaEEQsGaNug/1jf8oBuE9hKlsHY4ypdJIxGk+VUZ5iQZ2HutRmM4I2exlkqsuwrEGug5iVlz4lm6bqSe7H7tHvBvdEUufWQR3bjQhIEZf9xRkhPmOsreySnLtOwHSkdhsGEtefCYl9bk8ZzcTihHoynD8fpdilo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787261141; c=relaxed/simple;
	bh=BZ9aB6omG243670ackGYEsFDybb5NORvn4hep6C4lbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rCnLod7cdwPQRruJjN+LjAnlvS9eP5to38KMalj1tiMjNuDefwduRWJ6RliaUQm48eoR9C2brEbeXwuPUSfVKTWXLFb3KKom8XCCEq2NUYtZGuFJh+KKPLHFV8q3ov6ccDcuqzfARTAEV6eBeam7/8rdJsCQFIJMBlnz7Mnr8Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TTWJdDUI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TTWJdDUI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 107CE1F000E9;
	Thu, 20 Aug 2026 21:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787261140;
	bh=6TAjbOvNHT6S4+ujLQl+XGkxe/kyJb2xPBjlekft7vk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TTWJdDUIj42SGsUtD1UMx1UBZ8QgOHFGk2G+tgOo0Sm3B571vHZyDH+lElb1c4FPp
	 0cpx+WjrogRZvbxS/BK3MsT+N7wtMGDjo13uzoyZajbE8TVpPDq4B+qf4KlqSDFKTP
	 5I7/Yzc8plAcOt+dNO53VeP4z0irT6t2E3weVjRbt/21NXlQpSuxWjAUHRjoPXzpr0
	 i0DZjsD5JTxlVdUa3NEOwQn12SCxHh7D7rPQXSCQpg7ffyBwY7TGg3UHgKT4LWxMH5
	 oQU3aG3NMJvKRMAwRraTVYvSjobNgV4LWZvkjALENCC99OWs8tfZ7FviIxwZsYebLA
	 NE7KQD/cWMQhA==
From: Jakub Kicinski <kuba@kernel.org>
To: michael.cohen3@mail.huji.ac.il
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	edumazet@google.com,
	ncardwell@google.com,
	kuniyu@google.com,
	davem@davemloft.net,
	pabeni@redhat.com,
	horms@kernel.org,
	tamir.shahar1@gmail.com,
	amit.klein@mail.huji.ac.il
Subject: Re: [PATCH net] tcp: reject completely old segments during sequence validation
Date: Thu, 20 Aug 2026 14:25:39 -0700
Message-ID: <20260820212539.1180651-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260818205230.1146138-1-michael.cohen3@mail.huji.ac.il>
References: <20260818205230.1146138-1-michael.cohen3@mail.huji.ac.il>
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
tcp: reject completely old segments during sequence validation

tcp_sequence() previously only dropped a segment when end_seq was strictly
before rcv_wup.  This patch also drops the boundary case where end_seq
equals rcv_wup, as long as the segment consumes sequence space, so that
such segments no longer reach ACK processing.

> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 0f60a1dbf927..e51c76884460 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -4844,7 +4844,8 @@ static enum skb_drop_reason tcp_sequence(const struct sock *sk,
>  	const struct tcp_sock *tp = tcp_sk(sk);
>  	u32 seq_limit;
>
> -	if (before(end_seq, tp->rcv_wup))
> +	if (before(end_seq, tp->rcv_wup) ||
> +	    (end_seq == tp->rcv_wup && seq != end_seq))
>  		return SKB_DROP_REASON_TCP_OLD_SEQUENCE;

[Severity: High]
Does this new clause also match the crossing SYN+ACK of a simultaneous
connect(), and does that re-introduce the behaviour fixed by commit
23e89e8ee7be7 ("tcp: Don't drop SYN+ACK for simultaneous connect.")?

When a TCP_SYN_SENT socket receives a bare SYN, the crossed-SYN branch in
tcp_rcv_synsent_state_process() moves it to TCP_SYN_RECV and leaves
rcv_wup equal to rcv_nxt:

net/ipv4/tcp_input.c:tcp_rcv_synsent_state_process() {
	...
	tcp_set_state(sk, TCP_SYN_RECV);
	...
	WRITE_ONCE(tp->rcv_nxt, TCP_SKB_CB(skb)->seq + 1);
	WRITE_ONCE(tp->copied_seq, tp->rcv_nxt);
	tp->rcv_wup = TCP_SKB_CB(skb)->seq + 1;
	...
}

The following tcp_send_synack() sends a segment with TCPHDR_SYN set, and
__tcp_transmit_skb() only calls tcp_select_window() when TCPHDR_SYN is
clear, so rcv_wup is not advanced:

net/ipv4/tcp_output.c:__tcp_transmit_skb() {
	...
	if (likely(!(tcb->tcp_flags & TCPHDR_SYN))) {
		th->window	= htons(tcp_select_window(sk));
	...
}

The peer's bare SYN+ACK then arrives with end_seq == seq + 1, i.e.
end_seq == tp->rcv_nxt == tp->rcv_wup and seq != end_seq, which is exactly
what the new condition rejects with SKB_DROP_REASON_TCP_OLD_SEQUENCE.

Since th->syn is set, step 1 in tcp_validate_incoming() short-circuits
before step 4:

net/ipv4/tcp_input.c:tcp_validate_incoming() {
	...
	if (reason) {
		if (!th->rst) {
			if (th->syn)
				goto syn_challenge;
	...
}

Is the simultaneous-connect exception in step 4 still reachable after this
change?  It requires seq + 1 == end_seq and seq + 1 == tp->rcv_nxt, which
is the same condition the new step 1 check now filters out first:

net/ipv4/tcp_input.c:tcp_validate_incoming() {
	...
		if (sk->sk_state == TCP_SYN_RECV && sk->sk_socket && th->ack &&
		    TCP_SKB_CB(skb)->seq + 1 == TCP_SKB_CB(skb)->end_seq &&
		    TCP_SKB_CB(skb)->seq + 1 == tp->rcv_nxt &&
		    TCP_SKB_CB(skb)->ack_seq == tp->snd_nxt)
			goto pass;
	...
}

With that path taken, tcp_rcv_state_process() returns before tcp_ack() and
before the TCP_SYN_RECV to TCP_ESTABLISHED transition, so the visible
effects look like the ones described in 23e89e8ee7be7: a challenge ACK is
emitted instead, TCP_MIB_INERRS and LINUX_MIB_TCPSYNCHALLENGE are
incremented, establishment is delayed by an extra round trip until the
peer's pure ACK (seq == end_seq) is accepted, write() or send() right after
connect() returns -EAGAIN, and bpf_skops_parse_hdr() is not run for the
SYN+ACK.  Connect-to-self over loopback follows the same path.

Would restricting the new check so it does not apply while the socket is in
TCP_SYN_RECV with rcv_wup == rcv_nxt, or ordering it after the step 4
simultaneous-connect exception, preserve that case?

Cross-instance finding from sashiko-gemini (9561356177ca94322be4fdd8e89990a9b84fa51eecb45d5907ec165c8b9ca68e):
[Severity: Medium]
The patch breaks IPv6 flowlabel rehashing (ECMP repathing) on spurious RTO for non-SACK connections or when DSACK is disabled.
