Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0742F3614
	for <netdev@vger.kernel.org>; Sat,  1 Aug 2026 00:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785543015; cv=none; b=cUNTNCRaYJvyyfxjoq598+LlELU8LSUtDsowg2J9sv5C2nauwDdfCJC+xsGuSOpNlByeujDac/3ITepWftoCA4lQEMVxFYogfNiEr/YHBK0Kyp1dVdAyQO39/w59vFfox2dOcA9WQAuYgmVEiw2PN2zNBRTJWt6gNINFTcCvsFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785543015; c=relaxed/simple;
	bh=mZf2LQVUNJVaA5r01xxWlYRapiX0XL4vnswB79eZjFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UphpD/7+qUo2FQdLI1BZ8FUATBNwKumiDEaT1vr7ylbow5oN6ku+in+SGyW3K9h+4DYBPtEJFH+HPoe5gKXIUKWPhNuaVHeb+fkURxjuaRfPP7O+cFcWd9WNsYWYrq+18lhcsnlj1YLgTGnHy03u3kLTQnS6o8p8g5UPxHSSuaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JH7j7Olz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JH7j7Olz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34A211F00AC4;
	Sat,  1 Aug 2026 00:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785543011;
	bh=cGFfNxhizTQ3k9dlDYT0oJ+sA/niwo0EpDP+mZn5Tlw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JH7j7OlzHgAgj67c07UEyTfTQXXEKAnEkxyPNWQoWkA6Q6POsd0Wz57MlSXISpHui
	 ZiUtvBRP9gyK4M/Xv347Koz6T7Yr3uQh145sIOHvU/gWFeQzSz66HWJDaURvQ2sh2a
	 riBpnbwJ62B3EBMbJ9cweEs2VonkYzcM9Au3YumtlJDPASpRaiCHcFVYHc7XMVEucN
	 V8c5hJSpdS9lciLgZRu42CIiemAK9nosTjY3CcQRBJ5SqqEpMc2gSKdTbSG6Pb8TgY
	 l6fsplrBHVMrK71GJsrH6BlGgA5JwH5ZmCeTub1qMPasvPHsBWXqhjt6P0R52i6sdw
	 fTCxqfBlM1Zjg==
From: Jakub Kicinski <kuba@kernel.org>
To: enjou1224z@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	edumazet@google.com,
	ncardwell@google.com,
	kuniyu@google.com,
	davem@davemloft.net,
	pabeni@redhat.com,
	horms@kernel.org,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: Re: [PATCH net v4 resend 1/1] tcp: bound SYN-ACK timers to reqsk timeout range
Date: Fri, 31 Jul 2026 17:10:10 -0700
Message-ID: <20260801001010.1287747-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <891a220c362e3266efdf6b1aa9dc3e52f6825c00.1784735392.git.zhilinz@nebusec.ai>
References: <891a220c362e3266efdf6b1aa9dc3e52f6825c00.1784735392.git.zhilinz@nebusec.ai>
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
--- Patch [1]: [PATCH net v4 resend 1/1] tcp: bound SYN-ACK timers to reqsk timeout range ---
commit 319e164a9bccb22bb455177e690c982f75111c61
Author: Zhiling Zou <zhilinz@nebusec.ai>

tcp: bound SYN-ACK timers to reqsk timeout range

This adds a new MAX_TCP_SYNACK_RETRIES constant of 63 and applies it as a
runtime clamp on the effective SYN-ACK retry limit and on
rskq_defer_accept in reqsk_timer_handler(), and on max_retries in
tcp_fastopen_synack_timer().  It also converts tcp_reqsk_timeout() into a
saturating helper tcp_reqsk_timeout_sk() that returns rto_max instead of
performing an out-of-range shift.

A few questions below.

> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org

[Severity: Low]
Is this Fixes tag pointing at the right commit?  git blame on the
baseline attributes tcp_reqsk_timeout() and its shift expression:

  include/net/tcp.h:
	u64 timeout = (u64)req->timeout << req->num_timeout;

	return (unsigned long)min_t(u64, timeout,
				    tcp_rto_max(req->rsk_listener));

to 207ce0f6bc131 (Kuniyuki Iwashima, 2025-11-06), and the rto_max clamp
to 1e9d3005e02cb (2025-11-06).  The new helper also depends on
tcp_rto_max()/icsk_rto_max, which are recent additions too.

With Cc: stable on a patch that changes observable behaviour, could the
tag be adjusted so the affected tree range is clear?

Also, could the changelog state the concrete user-visible impact of the
pre-existing out-of-range shift?  In the reqsk path the result was already
bounded by min_t(u64, ..., tcp_rto_max()), and in the Fast Open path
inet_csk_reset_xmit_timer() clamps 'when' to max_when, so the observable
effect looks like a mis-scaled timer rather than memory unsafety, and it
requires an administrator-configured limit above 63.

> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 2c5b889530b5..a53d1b808aba 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -183,6 +183,7 @@ static_assert((1 << ATO_BITS) > TCP_DELACK_MAX);
>  #define MAX_TCP_KEEPINTVL	32767
>  #define MAX_TCP_KEEPCNT		127
>  #define MAX_TCP_SYNCNT		127
> +#define MAX_TCP_SYNACK_RETRIES	63

[Severity: Low]
Where does 63 come from?  The neighbouring MAX_TCP_* constants are
write-time validation limits for the corresponding interfaces, but this
one is only a hidden runtime clamp, and 63 matches neither the width of
the num_timeout field (u8 num_timeout:7, so 0..127) nor MAX_TCP_SYNCNT
(127), which bounds the very same icsk_syn_retries field.  Could a comment
explain the derivation?

>  /* Ensure that TCP PAWS checks are relaxed after ~2147 seconds
>   * to avoid overflows. This assumes a clock smaller than 1 Mhz.
> @@ -882,12 +883,22 @@ static inline u32 __tcp_set_rto(const struct tcp_sock *tp)
>  	return usecs_to_jiffies((tp->srtt_us >> 3) + tp->rttvar_us);
>  }
>  
> -static inline unsigned long tcp_reqsk_timeout(struct request_sock *req)
> +static inline unsigned long tcp_reqsk_timeout_sk(const struct sock *sk,
> +						 struct request_sock *req)
>  {
> -	u64 timeout = (u64)req->timeout << req->num_timeout;
> +	u32 rto_max = tcp_rto_max(sk);
> +	u64 timeout = req->timeout;
> +
> +	if (req->num_timeout >= BITS_PER_TYPE(u64) ||
> +	    timeout > U64_MAX >> req->num_timeout)
> +		return rto_max;
> +
> +	return (unsigned long)min_t(u64, timeout << req->num_timeout, rto_max);
> +}

[Severity: Low]
Does the changelog rationale still hold once this helper exists?  The
changelog says:

  "Excessive retry or defer-accept limits can therefore drive these timer
   paths into invalid shift counts before the request expires."

  "Clamp the effective retry and defer-accept limits in the regular
   request socket timer path, clamp the Fast Open retry limit, ..."

But req->num_timeout is a 7-bit field, so it can only hold 0..127, and
this helper already saturates for every one of those values.  Both shift
sites now route through it: tcp_reqsk_timeout() -> tcp_reqsk_timeout_sk()
from reqsk_timer_handler()'s mod_timer(), and tcp_reset_xmit_timer() in
tcp_fastopen_synack_timer().  With that in place, are the three call-site
clamps still needed for shift safety at all?

Conversely, the effect the clamps do have isn't described anywhere.  With
a configured limit above 127 (for example sysctl_tcp_synack_retries=200,
which is writable today), syn_ack_recalc()'s

	*expire = req->num_timeout >= max_syn_ack_retries;

can never become true, req->num_timeout++ wraps 127 -> 0, so the request
socket never expires and keeps retransmitting SYN-ACKs, and each wrap
re-runs:

	if (req->num_timeout++ == 0)
		atomic_dec(&queue->young);

underflowing the young counter used by the pruning heuristic.  Could the
changelog describe that effect instead, and say why 63 was chosen over
helper-only saturation, over 127 (the field width, matching
MAX_TCP_SYNCNT, so no currently legal configuration changes behaviour), or
over write-time validation plus a Documentation update?

>  
> -	return (unsigned long)min_t(u64, timeout,
> -				    tcp_rto_max(req->rsk_listener));
> +static inline unsigned long tcp_reqsk_timeout(struct request_sock *req)
> +{
> +	return tcp_reqsk_timeout_sk(req->rsk_listener, req);
>  }
>  
>  u32 tcp_delack_max(const struct sock *sk);
> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
> index 56902bba5483..b74212bae3dd 100644
> --- a/net/ipv4/inet_connection_sock.c
> +++ b/net/ipv4/inet_connection_sock.c
> @@ -1056,6 +1056,8 @@ static void reqsk_timer_handler(struct timer_list *t)
>  	net = sock_net(sk_listener);
>  	max_syn_ack_retries = READ_ONCE(icsk->icsk_syn_retries) ? :
>  		READ_ONCE(net->ipv4.sysctl_tcp_synack_retries);
> +	max_syn_ack_retries = min_t(int, max_syn_ack_retries,
> +				    MAX_TCP_SYNACK_RETRIES);

[Severity: Medium]
Does this silently truncate limits that are currently reachable and
honoured?

The write side is unchanged by this patch.  In
net/ipv4/sysctl_net_ipv4.c, tcp_synack_retries is registered with
proc_dou8vec_minmax and no .extra1/.extra2, so 0..255 stays writable, and
Documentation/networking/ip-sysctl.rst still says the value "should not be
higher than 255".  tcp_sock_set_syncnt() accepts icsk_syn_retries up to
MAX_TCP_SYNCNT (127), and do_tcp_getsockopt(TCP_SYNCNT) returns the stored
value verbatim.

Since req->num_timeout can reach 127, limits in 64..127 were previously
fully reachable, so a listener configured with tcp_synack_retries=100 (or
TCP_SYNCNT=100) now expires request sockets at 63 timeouts while
userspace still reads back 100.  Is that divergence between reported
configuration and effective behaviour intended?

The changelog says:

  "This keeps sysctl writes unchanged while bounding the timer
   calculations."

The write does still succeed, but its effect changes.  Could the changelog
and ip-sysctl.rst be updated to describe the new effective ceiling?

[ ... ]

> @@ -1086,7 +1088,9 @@ static void reqsk_timer_handler(struct timer_list *t)
>  		}
>  	}
>  
> -	syn_ack_recalc(req, max_syn_ack_retries, READ_ONCE(queue->rskq_defer_accept),
> +	syn_ack_recalc(req, max_syn_ack_retries,
> +		       min_t(u8, READ_ONCE(queue->rskq_defer_accept),
> +			     MAX_TCP_SYNACK_RETRIES),
>  		       &expire, &resend);
>  	tcp_syn_ack_timeout(req);

[Severity: Medium]
Can clamping rskq_defer_accept only here make TCP_DEFER_ACCEPT unable to
ever complete?  The other consumer of the same field, tcp_check_req() in
net/ipv4/tcp_minisocks.c, still compares against the unclamped value:

	if (req->num_timeout < READ_ONCE(inet_csk(sk)->icsk_accept_queue.rskq_defer_accept) &&
	    TCP_SKB_CB(skb)->end_seq == tcp_rsk(req)->rcv_isn + 1) {
		inet_rsk(req)->acked = 1;
		...
		return NULL;
	}

secs_to_retrans() can legitimately store 64..255 in rskq_defer_accept
(its loop is "while (seconds > period && res < 255)"), so with, say,
rskq_defer_accept == 100 the two deferral windows disagree.
syn_ack_recalc() sees 63 and sets:

	*expire = req->num_timeout >= max_syn_ack_retries &&
		  (!inet_rsk(req)->acked || req->num_timeout >= rskq_defer_accept);

so the request expires at num_timeout == 63, and the documented "last
chance for data or ACK to create established socket" resend moves to
num_timeout == 62.  Meanwhile any bare ACK arriving in that window is
still swallowed by tcp_check_req() (62 and 63 are both < 100), so the
request socket gets dropped by __inet_csk_reqsk_queue_drop() instead of
being promoted.  Before this patch both comparisons used the same value.

getsockopt(TCP_DEFER_ACCEPT) also still converts the unclamped value back
to seconds in do_tcp_getsockopt():

	val = READ_ONCE(icsk->icsk_accept_queue.rskq_defer_accept);
	val = retrans_to_secs(val, TCP_TIMEOUT_INIT / HZ,
			      TCP_RTO_MAX / HZ);

Should both sites be clamped consistently, or the clamp dropped here?

> diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
> index bf171b5e1eb3..bbedf2b9e1bc 100644
> --- a/net/ipv4/tcp_timer.c
> +++ b/net/ipv4/tcp_timer.c
> @@ -467,6 +467,7 @@ static void tcp_fastopen_synack_timer(struct sock *sk, struct request_sock *req)
>  	 */
>  	max_retries = READ_ONCE(icsk->icsk_syn_retries) ? :
>  		READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_synack_retries) + 1;
> +	max_retries = min_t(int, max_retries, MAX_TCP_SYNACK_RETRIES);

[Severity: Low]
Does the clamp cancel out the preceding comment?  The comment just above
reads "Add one more retry for fastopen", but at
sysctl_tcp_synack_retries == 63 the computed 64 is clamped straight back
to 63, so the extra Fast Open retry disappears, and for sysctl values
above 63 the "+ 1" has no effect at all.

	if (req->num_timeout >= max_retries) {
		tcp_write_err(sk);
		return;
	}

means the TFO child then hits tcp_write_err() one retry earlier than the
comment describes.  Would MAX_TCP_SYNACK_RETRIES + 1 be the intended
bound here, or should the comment be updated?

>  
>  	if (req->num_timeout >= max_retries) {
>  		tcp_write_err(sk);

[ ... ]
