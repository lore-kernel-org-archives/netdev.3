Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC09323BCF7;
	Sun, 11 Oct 2026 23:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791759740; cv=none; b=uSs7ocHRfZ2zcLVTw+2nYVDkpOGzstyoI47iapNdWW2g08V2XgdrJ8tRve5uydB/MAmPf+qGUBwF+0ZtnR2iM1SRRgwbgjLLyifkRPBvkDkhexmNQHBJ+LO3ra1FL5TrqxWVChs4Hd6ise2BNwBxxauqop6HGPHn3O7p+m+rYHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791759740; c=relaxed/simple;
	bh=+LrpSHi83rg43ATDcwnlytRa93Im8h1st3CGeqOd/LY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Krtap9a9VNknEC9NTXoPvrb0TvBdyFdPYmowadH/6VEiDsR7j0dhxq2j2WJY/ZXldaTLkj9J9IgzwCY6L5WAG39zsWIvdenQQcPD0vkRe1+WAOpU5Iic7V1NY4pRsjJFceaNEGd/dZ7Rxt/RTOMdh0GVCQezL9D1h19Z8HWErsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aFnHjWlP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aFnHjWlP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4F7E1F0089B;
	Sun, 11 Oct 2026 23:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791759739;
	bh=BMnwnSmmh2hW4aGAkK60qX2n3aHbKT63XD1QC30Rr9Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=aFnHjWlP7yNtmJtHuDiMq+1Ptf/98BvwcvGh3omVzvfRvl+khkd1JusycK0Dfk2vZ
	 wutHGRdyA5AlkwvgK7lFXYKU4rI3xjRM/t8wHC+xBUFXN0hmWxtebeEriEv5rSG7wn
	 jRDWgQQEF4fzGyEArx7Dd95KEDXCdVDdTlNMvzYM0FrJzV68k9NuxP+Kprk6R2OC2E
	 CeBvkWrLqJT/XGnXwpItlZfw4k9MiNReWNVz4gNVori006Zw9cm8CA9/I8/ro60JZr
	 as67voQdi9bI03VATm2v6RWPeh6rUutlKGbx8OPPIXDMzEN51ebjsWGeMvKFTkZhFl
	 CByzUzH5XgaQw==
Subject: Re: [PATCH net v2] tcp: do not send a SYNACK to a broadcast or
 multicast address
From: netdev-bot+sashiko@kernel.org
To: theodorlarionov@gmail.com
Cc: edumazet@kernel.org, ncardwell@google.com, kuniyu@google.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 11 Oct 2026 23:02:18 +0000
Message-ID: <179175973842.434549.79608444362932465@kernel.org>
In-Reply-To: <20261008114942.1376889-1-theodorlarionov@gmail.com>
References: <20261008114942.1376889-1-theodorlarionov@gmail.com>
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

tcp: do not send a SYNACK to a broadcast or multicast address

This patch makes inet_csk_route_req() reject SYNACK routes that have
RTCF_BROADCAST or RTCF_MULTICAST set. A SYN with a multicast source that
is looped back with its dst attached skips the martian source check. Its
SYNACK then goes through ip_mc_output(), and sk_mc_loop() reads past the
end of the request socket.

> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
> index 6a30f11384547..aa928015cd143 100644
> --- a/net/ipv4/inet_connection_sock.c
> +++ b/net/ipv4/inet_connection_sock.c
> @@ -779,6 +779,9 @@ struct dst_entry *inet_csk_route_req(const struct sock *sk,
>  		goto no_route;
>  	if (opt && opt->opt.is_strictroute && rt->rt_uses_gateway)
>  		goto route_err;
> +	/* Never send a SYNACK to a broadcast or multicast destination. */
> +	if (rt->rt_flags & (RTCF_BROADCAST | RTCF_MULTICAST))
> +		goto route_err;

[Severity: High]
Does this cover the syncookie passive-open path? cookie_v4_check() in
net/ipv4/syncookies.c does its own route lookup to ireq->ir_rmt_addr.
The only check on the result is IS_ERR():

net/ipv4/syncookies.c:cookie_v4_check() {
    ...
	rt = ip_route_output_key(net, &fl4);
	if (IS_ERR(rt)) {
		SKB_DR_SET(reason, IP_OUTNOROUTES);
		goto out_free;
	}
    ...
	ret = tcp_get_cookie_sock(sk, skb, req, &rt->dst);
    ...
}

In the syncookie case, tcp_v4_syn_recv_sock() uses that dst as is.
Neither inet_csk_route_req() nor inet_csk_route_child_sock() runs.

So it looks like a full child socket can still be created with
inet_daddr set to a multicast address such as 224.0.0.1. Active opens
already refuse this in tcp_v4_connect():

	if (rt->rt_flags & (RTCF_MULTICAST | RTCF_BROADCAST)) {
		ip_rt_put(rt);
		return -ENETUNREACH;

The ACK that completes the handshake can come in the way the commit
message describes for the SYN: raw IP_HDRINCL, nft dup or TEE, with
saddr=224.0.0.1. tcp_v4_cookie_check() passes any non-SYN segment to
cookie_v4_check().

The cookie can pass in two ways:

- cookie_tcp_check(), after a recent overflow. A netns owner can set
  tcp_syncookies=2 and send one unicast SYN. After that, ack_seq/seq can
  be brute forced at about 2^-29 per packet.
- cookie_bpf_check(), when a BPF program is in use.

Once that child is closed and in TIME_WAIT, a segment from the peer
would go down this path:

tcp_v4_rcv()
  tcp_v4_timewait_ack()
    tcp_v4_send_ack()
      ip_send_unicast_reply(ctl_sk, tw, ...)
        ip_route_output_flow()   /* daddr 224.0.0.1, no rt_flags check */
        skb_set_owner_edemux(nskb, tw)
        ip_push_pending_frames()
          ip_send_skb()
            ip_local_out(net, skb->sk, ...)
              ip_mc_output()
                sk_mc_loop(tw)

sk_mc_loop() does not check sk_fullsock():

	case AF_INET:
		return inet_test_bit(MC_LOOP, sk);

Wouldn't that read inet_flags past the end of the tcp_timewait_sock
object? That is the same out-of-bounds read this patch fixes for request
sockets. This path comes from reading the code at this commit; it has
not been reproduced.

Could the same rt_flags rejection (ip_rt_put() and drop) go after
ip_route_output_key() in cookie_v4_check()? For symmetry it could also
go in inet_csk_route_child_sock(). In practice that one only runs after
inet_csk_route_req() has passed, so it is just an inconsistency.

Another option would be to change sk_mc_loop() and
ip_send_unicast_reply() so they do not treat non-full sockets as
inet_sock.

>  	rcu_read_unlock();
>  	return &rt->dst;
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261008114942.1376889-1-theodorlarionov%40gmail.com
