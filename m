Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1533BE14A
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 21:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790891160; cv=none; b=V6J7i8HUkidNwU9Q+efnsRw7eupdE4tkz+E8I1JY45ccUBw9ek3lhf+UGuTOklE9/P+PPWg3bSEDXaTd4PE5aSVG2yDY4d+gNII8Y4DwY27GeI1sVc32t1iCKj/Hzw4JHk8TD7yvHBX77dbrIAKShTtmAhvfIqq5oQGKPgUqfBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790891160; c=relaxed/simple;
	bh=NOvzU+UHHoN/4hkpeO99yREkUUsIzxgV/5/AZbmgP3c=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Bo4DHUdRRwCRNlN9yyhUFWHyuEYhJOjZAIEeit25gPNRPEUfpa19rRYOyMx8f3gDtyNXgLjEgpIlqUqBDYSAZFHiXsnSGBntxXZe3EkW0GJPYBCHCrouzHuRMVy91XltDncRfyVQzdDQPV6DdP4529EyHcBfKCnbtRC5DEAAKpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jUFWk1oU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jUFWk1oU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B7901F000FF;
	Thu,  1 Oct 2026 21:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790891155;
	bh=utlQ2BxewjKjYi+SFYPC8Hhh+7szRKxIF759bQ3KRf0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jUFWk1oU6zgLDW4Fklog+BpmTuoTHutFG+CfWPhOBgZiR1fA4mRzMyaMETCUG17Rx
	 IsE0CSh1iIFqybvtk1V8BgtIQ1MhK/kK5h/DV5PXy4M2aw3JMhAajqmsmeclRU9h1U
	 T10A0nSSmCZjbkPbDloNuH2v3CfPRybC8xvXaxG5pcDRRjp8k7gdK2qeJhG9E/gqAz
	 MzY8qigG7OvaRGi9ht+qOjzqe2AdNDX3X4gv2dOZBJ2iGAHnW3pYuoX1SSd8GvKGgj
	 TUc6tcpb/aOkZswAExKHVrnq1FbbeJyRkmfFpyG1S+T003oeJU9QFJQ87mYCiH4Rup
	 XcmXr8rMMGqRA==
Subject: Re: [PATCH net] ipv4: free inet_opt after an RCU grace period
From: netdev-bot+sashiko@kernel.org
To: edumazet@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ncardwell@google.com, kuniyu@google.com, dsahern@kernel.org,
 idosch@nvidia.com, edumazet@google.com, netdev@vger.kernel.org,
 xinyang@anthropic.com
Date: Thu, 01 Oct 2026 21:45:54 +0000
Message-ID: <179089115410.434549.2945064150397901501@kernel.org>
In-Reply-To: <20260929214351.856940-1-edumazet@kernel.org>
References: <20260929214351.856940-1-edumazet@kernel.org>
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

- [High] The fix is incomplete.

--

ipv4: free inet_opt after an RCU grace period

This commit changes inet_sock_destruct() to free inet->inet_opt with
kfree_rcu() instead of kfree(). tcp_v4_syn_recv_sock() hands
ireq->ireq_opt to the child socket without copying it. A SYNACK
retransmit running at the same time can still be reading it under
rcu_read_lock() only.

> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> index 4ce38c99fef9e..14ce01092fda6 100644
> --- a/net/ipv4/af_inet.c
> +++ b/net/ipv4/af_inet.c
> @@ -161,7 +161,7 @@ void inet_sock_destruct(struct sock *sk)
>  	WARN_ON_ONCE(sk->sk_wmem_queued);
>  	WARN_ON_ONCE(sk->sk_forward_alloc);
>  
> -	kfree(rcu_dereference_protected(inet->inet_opt, 1));
> +	kfree_rcu(rcu_dereference_protected(inet->inet_opt, 1), rcu);

[Severity: High]
Is there a second handoff of ireq_opt that still ends in a plain kfree()?

With net.ipv4.tcp_migrate_req=1 and SO_REUSEPORT listeners,
reqsk_timer_handler() migrates a request socket whose listener has been
closed:

net/ipv4/inet_connection_sock.c:reqsk_timer_handler() {
    ...
		nreq = inet_reqsk_clone(req, nsk);
    ...
		if (!inet_ehash_insert(req_to_sk(nreq), req_to_sk(oreq), NULL)) {
    ...
		reqsk_migrate_reset(oreq);
    ...
}

inet_reqsk_clone() memcpy()s the request socket, so nreq->ireq_opt points
to the same ip_options_rcu as oreq. reqsk_migrate_reset() then clears
oreq's slot with a plain NULL store, and nreq becomes the owner.

At the same time, another CPU can hold a reference on oreq in
tcp_v4_rcv(), pick a new listener through reuseport_migrate_sock(), and
handle a retransmitted SYN:

tcp_v4_rcv()
  tcp_check_req()
    tcp_rtx_synack()
      tcp_v4_send_synack()
        rcu_dereference(ireq->ireq_opt)
        ip_build_and_send_pkt()
          ip_options_build()

nreq can then be dropped, for example by an RST through
tcp_check_req()->inet_csk_reqsk_queue_drop()->reqsk_put(), or when its
own timer expires. When that happens, the options are freed without a
grace period:

net/ipv4/tcp_ipv4.c:tcp_v4_reqsk_destructor() {
	kfree(rcu_dereference_protected(inet_rsk(req)->ireq_opt, 1));
}

The reference on oreq no longer protects the options, because oreq does
not own them anymore. The reader's rcu_read_lock() gives no protection
against a plain kfree() either.

Can this lead to the same use-after-free in ip_build_and_send_pkt() and
ip_options_build()? Both read opt->optlen, so if the memory is reallocated
in between, the two reads could disagree. That could turn into an
out-of-bounds write while the SYNACK is being built.

The commit message says the other paths that replace inet_opt already
use kfree_rcu(). Should tcp_v4_reqsk_destructor() also be converted to
kfree_rcu(..., rcu) as part of this fix?

>  	dst_release(rcu_dereference_protected(sk->sk_dst_cache, 1));
>  	dst_release(rcu_dereference_protected(sk->sk_rx_dst, 1));
>  	psp_sk_assoc_free(sk);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260929214351.856940-1-edumazet%40kernel.org
