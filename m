Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793412200;
	b=Vym8jyeC+g7HmpKw7qD2II0jpZKJPA1Ijy18ynFJnVAfYljAiK6Irt4BXCkR74oglC/U
	 PYHg2bBP9EODt8YuuGIFAMpu5eQxdFz/jkFLGP8zLG66E/0zmmkXJpdyXhqA21WqdMJR9
	 eJEEH880JtmnGVYOLQBMDNh66VWfk4eYaOopur+mRecs/2xj9XuE1EVmghJ1FFFJe9ZAS
	 AeGb6GJzpO8jS5TL4bfBYjVUy95k4n0nZ+DaTbAGYTalTWmPldBytPFru03sim5yBFTia
	 Jvld/l2FgBXTm3EWMC0hvCINykKJh7IiffJ/4DiaW2q++pLlm6QNqFnC3+wDcXpU1eA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793412200;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=hzSX30RmV1UJ0okdb7ZKFGl0A04LAcVrBA3XFv058cc=;
	b=sPOq5UHY4C4l2VY6RYgLtQsBRItcLYEqmRDO77XBBQAayRYz7sKW56gYb08TLUlYxgCp
	 LTSQ4yeexi2K3ts/MU07NBci9Sp/gCvXCGj36TU9FF7Flw/xIFCTIa/VG2lgu8kDZ1yW6
	 5Fad2qNeTifzYfaDsrTwHCrwKn7/rV9n6dQUU7LXcuhtVP+rBzL0e4ec5ZYJ3nwrF9MpF
	 Vh30ywhei2FycRLg8xDEeIClytZd5MNKTGxnu2VQ/alpgXopNkZfSEajecKmgJVScu2pP
	 7E4X+PIyWRB9ydN10TCMqGV5vvK4hGl9TWRacKShplzwYu/uKPcS/5nZ9SBZfroy6KQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NxC4iAkG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8439606A31C
	for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 02:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NxC4iAkG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 394521F000C1;
	Sat, 31 Oct 2026 02:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793412199;
	bh=hzSX30RmV1UJ0okdb7ZKFGl0A04LAcVrBA3XFv058cc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NxC4iAkG/fR0dYHElrdK18uFoXw1j3p0fY5Mdtb7WkEycEIl4+3NLjffL92vXXEDx
	 hhDAIJZhYxsgwfFKwYKdVhTnuC3vx8rsXPLowc1vF+FNpsV5q1QbEN+oo7N2fK6Wyl
	 sqWRj/L4l31TmxvIDtxmXzs4jfiHDBmN1wTs7iE/2M4vz9fsx5llK4DCr8OkIB7sJo
	 VRcbNwwLUkDIMf9K5x+GFrI4wjaE6W42S40U84/s/Z/gJ542vaBq9Z/BnN56OFTHvR
	 CacmcAILUoXcFh7ecv6yLIuTubSykcz66ENZdy/HoHZqeK+YqvxljyySwjADGTXid5
	 nT5mIFe5pFx/g==
From: Jakub Kicinski <kuba@kernel.org>
To: omniameasunt@proton.me
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	paul@paul-moore.com
Subject: Re: [PATCH net v2] cipso_v4: fail the walk on malformed options
Date: Fri, 30 Oct 2026 19:03:17 -0700
Message-ID: <20261031020317.3415448-1-kuba@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <uOcTaW7-g5e97ng6BG_DcH5mlMnpw7KzU25SZjL69pkAVINTMiL26FryLAuYPSNowDo8qwfb9hm_I4dQ1BwpiRe62E-I2TyUkJZ_eBeuLoo=@proton.me>
References: <uOcTaW7-g5e97ng6BG_DcH5mlMnpw7KzU25SZjL69pkAVINTMiL26FryLAuYPSNowDo8qwfb9hm_I4dQ1BwpiRe62E-I2TyUkJZ_eBeuLoo=@proton.me>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
cipso_v4: fail the walk on malformed options

This patch makes cipso_v4_get_actual_opt_len() return -EINVAL when an
option is truncated or malformed. It also makes cipso_v4_delopt() and
cipso_v4_skbuff_delattr() bail out on malformed streams. In addition,
cipso_v4_delopt() now builds the compacted options in a new
ip_options_rcu, publishes it with rcu_assign_pointer() and retires the
old object with kfree_rcu().

>   * a stack buffer overflow when optlen exceeds the 60-byte scratch
>     buffer (return-address overwrite; exploitable for privilege
>     escalation on kernels built without stack protector).

[Severity: Low]

Is the buffer size right here? In do_ip_getsockopt() the buffer is:

	unsigned char optbuf[sizeof(struct ip_options)+40];

struct ip_options is 16 bytes: two __be32 fields plus eight one-byte
fields, and the flexible __data[] adds nothing. That makes optbuf 56
bytes.

The copy into it is:

	memcpy(optbuf, &inet_opt->opt,
	       sizeof(struct ip_options) +
	       inet_opt->opt.optlen);

This goes through the fortified memcpy(), and the destination size is
known at compile time. Wouldn't CONFIG_FORTIFY_SOURCE also trap the
oversized write? The stated exploitability condition seems incomplete
without that.

> cipso_v4_delopt() then drops the
> socket's entire option set (reusing the existing branch that frees the
> ip_options_rcu when CIPSO was the only option)

The patch doesn't reuse that branch. It adds a new drop_all label that
copies the same logic. Could the wording be adjusted?

> Well-formed option streams are unaffected: a socket whose options
> survive the compaction intact keeps them; only malformed streams now
> lose all options instead of carrying a partially parsed set.

[Severity: Medium]

Is this accurate? cipso_v4_delopt() now walks only the compacted region
and fills the stale tail with IPOPT_END:

	optlen = new->opt.optlen - cipso_len;
	memset(new->opt.__data + optlen, IPOPT_END, cipso_len);
	optlen_new = cipso_v4_get_actual_opt_len(new->opt.__data, optlen);

Before the patch the walk covered the old optlen. If no IPOPT_END was
left in the compacted region, the walk ran into the stale tail and
counted those bytes a second time.

Well-formed options can hit this. ip_options_echo() writes rr/ts/srr
first and CIPSO last, and pads only up to a 4-byte boundary. Suppose
CIPSO ends exactly on that boundary:

  - memmove() copies 0 bytes
  - the CIPSO bytes get walked again
  - optlen_new equals the old optlen and hdr_delta is 0
  - opt.cipso is cleared, but the CIPSO bytes stay in the options and
    go out on the wire

Socket options such as CIPSO(8)+RR(8) with no padding behave the same
way: RR ends up duplicated and optlen does not shrink.

With this patch CIPSO really is removed in those cases. That looks like
a second bug being fixed. Could the commit message mention it?

The message also leaves out the request socket path. There,
cipso_v4_delopt() runs on options echoed from a remote SYN when the peer
maps to an unlabeled domain:

netlbl_req_setattr()
  netlbl_req_delattr()
    cipso_v4_req_delattr()
      cipso_v4_delopt()

Would it be worth describing that caller too?

> diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
> index 1aacbbeffbc64..e618cbbd56c6a 100644
> --- a/net/ipv4/cipso_ipv4.c
> +++ b/net/ipv4/cipso_ipv4.c

[ ... ]

> @@ -1992,53 +1996,79 @@ int cipso_v4_req_setattr(struct request_sock *req,
>   *
>   * Description:
>   * Deletes the CIPSO IP option from a set of IP options and makes the necessary
> - * adjustments to the IP option structure.  Returns zero on success, negative
> - * values on failure.
> + * adjustments to the IP option structure.  Returns zero or a positive header
> + * length delta on success, negative values on failure.
>   *
>   */
>  static int cipso_v4_delopt(struct ip_options_rcu __rcu **opt_ptr)
>  {
>  	struct ip_options_rcu *opt = rcu_dereference_protected(*opt_ptr, 1);
> +	struct ip_options_rcu *new;

[ ... ]

> +	new = kzalloc(sizeof(*new) + opt->opt.optlen, GFP_ATOMIC);
> +	if (!new)
> +		return -ENOMEM;

[Severity: Medium]

Before this patch cipso_v4_delopt() could not fail. Can the callers
handle the new -ENOMEM return? On this path *opt_ptr is not touched, so
the ip_options_rcu that still carries CIPSO stays published.

None of the callers check for a negative value:

net/ipv4/cipso_ipv4.c:cipso_v4_sock_delattr() {
    ...
	hdr_delta = cipso_v4_delopt(&sk_inet->inet_opt);
	if (inet_test_bit(IS_ICSK, sk) && hdr_delta > 0) {
    ...
}

net/ipv4/cipso_ipv4.c:cipso_v4_req_delattr() {
	cipso_v4_delopt(&inet_rsk(req)->ireq_opt);
}

The layers above don't see the failure either:

  - netlbl_sock_delattr() and netlbl_req_delattr() return void.
  - netlbl_conn_setattr() and netlbl_req_setattr() set ret_val = 0 in
    the NETLBL_NLTYPE_UNLABELED case.
  - selinux_netlbl_socket_connect_helper() and smack_netlbl_delete()
    (which sets SMK_NETLBL_UNLABELED) then update their state as if
    the label had been removed.

After a GFP_ATOMIC failure, wouldn't packets to an unlabeled destination
still carry the CIPSO option? The same question applies to the SYN-ACK
and the child socket on the request path.

The updated kernel-doc says negative values mean failure, but no caller
acts on that. The drop_all fallback below needs no allocation. Would
using it here keep the CIPSO option always removed, as before?

> +	memcpy(&new->opt, &opt->opt, sizeof(new->opt) + opt->opt.optlen);

[ ... ]

> +	hdr_delta = opt->opt.optlen;
> +	new->opt.optlen = (optlen_new + 3) & ~3;
> +	hdr_delta -= new->opt.optlen;
> +	rcu_assign_pointer(*opt_ptr, new);
> +	kfree_rcu(opt, rcu);

[Severity: High]

In the multi-option branch, the old ip_options_rcu used to be modified
in place and was never freed. It is now replaced and passed to
kfree_rcu(). Is every writer of inet->inet_opt serialized against this?

The Smack caller doesn't seem to be. smk_ipv4_check() is called from
smack_socket_connect() and smack_socket_sendmsg() without lock_sock(),
and it gets here through:

smack_netlbl_delete()
  netlbl_sock_delattr()
    cipso_v4_sock_delattr()
      cipso_v4_delopt()

Only the socket spinlock is held:

security/smack/smack_lsm.c:smack_netlbl_delete() {
    ...
	local_bh_disable();
	bh_lock_sock_nested(sk);
	netlbl_sock_delattr(sk);
	bh_unlock_sock(sk);
	local_bh_enable();
	ssp->smk_state = SMK_NETLBL_UNLABELED;
}

bh_lock_sock_nested() takes only sk_lock.slock.
do_ip_setsockopt(IP_OPTIONS) holds socket ownership through
sockopt_lock_sock(), which has already released slock. So the two paths
don't exclude each other:

CPU1: smack_netlbl_delete()->...->cipso_v4_delopt()
    opt = rcu_dereference_protected(*opt_ptr, 1);

CPU2: do_ip_setsockopt(IP_OPTIONS)
    old = rcu_dereference_protected(inet->inet_opt, ...);

CPU1:
    rcu_assign_pointer(*opt_ptr, new);
    kfree_rcu(opt, rcu);

CPU2:
    rcu_assign_pointer(inet->inet_opt, opt);
    if (old)
        kfree_rcu(old, rcu);

Here opt and old point to the same object. Could this queue call_rcu()
twice on the same rcu_head and free that object twice? It would also
leak one of the two replacement objects.

Because cipso_v4_delopt() uses rcu_dereference_protected(*opt_ptr, 1),
lockdep can't flag the missing exclusion either.

The Smack locking predates this patch, and so does the same free pattern
in the only-CIPSO branch. This patch extends the free to every option
set that includes CIPSO. One example is CIPSO+RR set through
setsockopt(IP_OPTIONS) with CAP_NET_RAW in a user namespace.

> +	return hdr_delta;
> +
> +drop_all:
> +	kfree(new);
> +	rcu_assign_pointer(*opt_ptr, NULL);
> +	hdr_delta = opt->opt.optlen;
> +	kfree_rcu(opt, rcu);
>  	return hdr_delta;
>  }

[Severity: Low]

The kernel-doc for cipso_v4_delopt() still says it "Deletes the CIPSO IP
option from a set of IP options". The kernel-doc for
cipso_v4_sock_delattr() says it "Removes the CIPSO option from a socket".

The drop_all path frees the whole option set, srr/rr/ts/router_alert
included, and returns a positive hdr_delta. The updated Returns sentence
reserves negative values for failure. Yet a malformed stream is reported
as success, and only an allocation failure returns a negative value.

Should the kernel-doc describe this behaviour? drop_all looks
unreachable for options that went through ip_options_compile() or
ip_options_echo(), so this only affects the documentation.

[ ... ]

> @@ -2263,12 +2297,19 @@ int cipso_v4_skbuff_delattr(struct sk_buff *skb)
>  		return ret_val;
>  
>  	iph = ip_hdr(skb);
> +	if (opt->optlen > (iph->ihl << 2) - sizeof(struct iphdr))
> +		return -EINVAL;

[Severity: Low]

sizeof(struct iphdr) is a size_t, so this comparison is unsigned. When
iph->ihl < 5, (iph->ihl << 2) - sizeof(struct iphdr) wraps to a huge
value and the check always passes. Is that intended?

The code further down relies on this guard to keep hdr_len_delta
non-negative:

	hdr_len_delta = (iph->ihl << 2) - new_hdr_len;
	...
	memmove((unsigned char *)iph + hdr_len_delta, iph, new_hdr_len_actual);
	...
	skb_pull(skb, hdr_len_delta);

With a negative delta, memmove() would write below the network header
and skb_pull() would be passed a huge length.

ip_rcv_core() drops packets with ihl < 5, and the local output paths
always build ihl >= 5. Reaching this would need something like
privileged netfilter payload mangling. Would a signed comparison, or an
explicit iph->ihl < 5 check, make the new guard cover the case it was
added for?

[ ... ]
