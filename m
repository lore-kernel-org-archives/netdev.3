Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792927893;
	b=wTXFY63qeZfAGG+hWNYJUpAZrOlIosTewH4rPRP8i8TiA+LOCn6kjYdVWajLyBU8cPd4
	 FLOgOir6XmvdBUpmqg+h8Dr9l3AOE0D2Qo74UxzND80+U8nWCzWD0QNf3hU3UfkBGh7HN
	 J3wmHMb3lNPDuizbriM0Q+XJ2qHsmjpIJHpfY4olx+3vXuKAFtgrJBKAcu0ZaahXZtoEx
	 7eiUQSZTOvgH9AafSJDikSMQurnq6hOmRtgNmxUm5amcZmkoj57N3YXgihOMyxCQZbZm6
	 QpuKXy+s6CsC7zaD8fHgM8Xc1bpaHkuMCQjAN5GgNtXxwObIfZc1Buu7hTq2oXjw0Eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792927893;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Tck4XO6ARx8pN2RCyfyeo9WAfH5Aw9VUxlr2riYTrUU=;
	b=OUxYfQ5CfTXyGyKvwzpaL059q7EmaTw8cBWvLITwogMnQCrnZjbUXZygntOmlBCl0Jjc
	 NWjSkLrdCbUAWiW8iwPrLMN1x+pUxRa29nCLp6BIfJeXrX2vXX+4sr6TG6AK5hAXcSBBx
	 NjJgmTs7BS3UMjUg6FEk7i9FXm/TJZ0BTqGV3PifzuWpXTtTCavS3CXavEFERgLBtts9o
	 1LNKdSmVHEcqYuNK4OsGf0OG/uw6oT4K42PzgDg7I3sWjTnRkJ+jLICxGrqZdIZV7Ij0Z
	 t9azu9iZxARdpj67VVyvSVRQY90WCwGAqyNpfKi7Aj9DsbujfLaGicHclQxF84+V2EQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pcjx9jpi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE81606A32A
	for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 11:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pcjx9jpi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61ECB1F01829;
	Sun, 25 Oct 2026 11:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792927892;
	bh=Tck4XO6ARx8pN2RCyfyeo9WAfH5Aw9VUxlr2riYTrUU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Pcjx9jpiNWVjIVs/3/OXkO9+npospaeVR2pOpRRRGjCWO+e+5UKq7Nxb9IcMaBpPs
	 V0eb/UiwDyOQY2K+GYxO9u+VCrb5YxBZsX0+L0xZIMA0b8juKIL6rZ+Sx+iBUvXvXJ
	 G/ijuubI/RK66gYTkoAD2vWtLxeZvKB/n3IyTP1ZbKtAtlxiwMLjHdiMTLKdCGNAgG
	 VR7ehlOecT7pWwxpDbEbilMnEoomlsP7jEjSIsbHgAIHLpOCR4YfwPshHUaOAh4B1u
	 K6LWfr759oaYhZ/1HdqPsFjSvo5BOFgiRhfndFR98S2+NJ0oh5mbxHdfNQsFQb2G1d
	 m4VoaybTT7SLQ==
Subject: Re: [PATCH net] cipso_v4: fail the walk on malformed options
From: netdev-bot+sashiko@kernel.org
To: omniameasunt@proton.me
Cc: netdev@vger.kernel.org, paul@paul-moore.com, kuba@kernel.org
Date: Sun, 25 Oct 2026 11:31:31 +0000
Message-ID: <179292789194.3134.6820157609745541886@kernel.org>
In-Reply-To: =?utf-8?q?=3CCBLsHx48w8Bn1k=5FXg6kJFliLNkxLCqi8SnkifapxYYpVtll4?=
 =?utf-8?q?w-W=5F2JJePtbk9ssIS701IFJvi0Q2n5l-2GFFe8hNHU9Y=5FCgD=5FsdzcAbILVA?=
 =?utf-8?q?=3D=40proton=2Eme=3E?=
References: =?utf-8?q?=3CCBLsHx48w8Bn1k=5FXg6kJFliLNkxLCqi8SnkifapxYYpVtll4w?=
 =?utf-8?q?-W=5F2JJePtbk9ssIS701IFJvi0Q2n5l-2GFFe8hNHU9Y=5FCgD=5FsdzcAbILVA?=
 =?utf-8?q?=3D=40proton=2Eme=3E?=
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 2 (1) · Medium: 0 · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] cipso_v4_delopt() (net/ipv4/cipso_ipv4.c) still walks the option
  buffer with the old, uncompacted length.
- [High] cipso_v4: RCU race from in-place option mutation in
  cipso_v4_delopt()

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but on its normal
  path cipso_v4_delopt() (net/ipv4/cipso_ipv4.c) changes an…
- [Low] The kernel-doc of cipso_v4_delopt() says 'Returns zero on
  success, negative values on failure', but the function only ever…

--

cipso_v4: fail the walk on malformed options

This commit adds checks to cipso_v4_get_actual_opt_len(). The option walk
now returns -EINVAL when an option is truncated, has a length byte of zero
or one, or runs past len. On that error, cipso_v4_delopt() drops the whole
option set and cipso_v4_skbuff_delattr() leaves the packet unchanged.

> diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
> index 1aacbbeffbc64..d2d95b3a745f0 100644
> --- a/net/ipv4/cipso_ipv4.c
> +++ b/net/ipv4/cipso_ipv4.c

[ ... ]

> @@ -2028,6 +2032,13 @@ static int cipso_v4_delopt(struct ip_options_rcu __rcu **opt_ptr)
>  
>  		optlen_new = cipso_v4_get_actual_opt_len(opt->opt.__data,
>  							 opt->opt.optlen);
> +		if (optlen_new < 0) {
> +			/* malformed option stream, drop all the options */
> +			*opt_ptr = NULL;

[Severity: High]
This overlaps with the in-place modification question raised for the
sendmsg paths. getsockopt(IP_OPTIONS) looks like a more direct way to
corrupt memory through the same race, so it is probably worth covering
in the same fix.

cipso_v4_delopt() lowers opt->opt.srr, rr, ts and router_alert, clears
cipso and memmoves __data while *opt_ptr still publishes the object.
The new error branch only clears *opt_ptr after all of that has run,
and the normal path then shrinks opt->opt.optlen in place. kfree_rcu()
keeps the memory alive for readers already inside rcu_read_lock(), but
it does nothing to keep the contents consistent for them.

In this tree do_ip_getsockopt(IP_OPTIONS) is one such reader. It
copies sizeof(struct ip_options) + inet_opt->opt.optlen bytes into the
56-byte optbuf on the stack under rcu_read_lock() alone. It then calls
ip_options_undo() on the copy, which trusts the offsets to point at
real option headers:

	memmove(optptr + 7, optptr + 3, optptr[1] - 7);
	...
	optptr[2] -= 4;
	memset(&optptr[optptr[2] - 1], 0, 4);

Take CIPSO(13) followed by RR(7). Suppose the copy pairs the reduced rr
offset with __data that has not been moved yet. Then optptr points at
the old CIPSO type byte, and optptr[2] is the first DOI byte. A DOI
below 0x04000000 makes optptr[2] wrap to 252..255. The memset() then
writes four zero bytes around 200 bytes past the end of optbuf.

The srr case is similar. A stale length byte below 7 underflows the
memmove() size to a huge size_t, and a large one moves up to 248 bytes
inside a 56-byte buffer. The ts_needaddr/ts_needtime path has the same
wrap.

Either way this is a kernel stack overwrite. It is reachable from
getsockopt(IP_OPTIONS) racing connect(AF_UNSPEC), under the same
CAP_NET_RAW and CIPSO preconditions the commit message describes.

Most of this predates the patch. But the new branch already unpublishes
and frees the object. Would it make sense to do the compaction on a
freshly allocated copy, publish it with rcu_assign_pointer(), and
kfree_rcu() the old one? Readers would then only ever see the old or
the new option set. The socket and request_sock callers run in
different contexts, so the allocation flags would need some thought.

[Severity: High]
Does this walk still read the stale tail that the commit message names as
the attacker-controlled input?

The memmove() just above compacts the stream:

	memmove(cipso_ptr, cipso_ptr + cipso_len,
		opt->opt.optlen - cipso_off - cipso_len);

After it, the last cipso_len bytes of __data are stale copies of the
original bytes. Nothing refills them with IPOPT_END.

cipso_v4_get_actual_opt_len() is then called with the old, uncompacted
opt->opt.optlen. If the original stream length was already a multiple of
4, ip_options_get() added no END padding, so the walk runs into the stale
bytes. The new checks only bound the result to len. They can't tell a live
option from a stale one.

This seems to cause two problems.

First, valid options can be dropped. Take CIPSO(13) followed by RR(7), 20
bytes, no padding:

  86 0d <DOI x4> 01 07 00 <lvl> <bm x3> | 07 <len 7> ...

After compaction RR sits in __data[0..6]. __data[7] is the stale tag
length (0x07) and __data[8] is the stale RBM alignment octet (0x00). The
new "data[iter + 1] < 2" check returns -EINVAL, and this branch frees the
whole ip_options_rcu, valid RR included. CIPSO + NOP NOP + RA(4) behaves
the same way. Before this patch these inputs looped forever; now every
option is silently lost.

A user with CAP_NET_RAW in a user namespace can reach this on a socket in
the NLBL_REQSKB state. They set those options with IP_OPTIONS and then call
connect(AF_UNSPEC):

  selinux_netlbl_socket_connect_locked()
    -> netlbl_sock_delattr()
      -> cipso_v4_sock_delattr()
        -> cipso_v4_delopt()

Second, stale bytes can stay live. Take RR(7) followed by CIPSO(13), 20
bytes. The memmove() length is 0. The walk accepts the old CIPSO bytes as
an ordinary option (iter == len), so optlen_new == optlen and hdr_delta is
0.

opt.cipso is cleared, but the CIPSO bytes stay in __data, and
ip_options_build() keeps writing them into outgoing headers.

__ip_options_echo() always puts CIPSO last and only pads to a multiple of
4. So cipso_v4_req_delattr() on a request_sock built from a peer's SYN
could hit this whenever RR/TS/SRR plus CIPSO is already 4-byte aligned.

Both cases contradict this part of the commit message:

  Well-formed option streams are unaffected: a socket whose options
  survive the compaction intact keeps them; only malformed streams now
  lose all options instead of carrying a partially parsed set.

Would walking only the compacted region (opt->opt.optlen - cipso_len), or
filling the vacated tail with IPOPT_END, fix both cases? This -EINVAL
branch would then only fire on corrupt data.

> +			hdr_delta = opt->opt.optlen;
> +			kfree_rcu(opt, rcu);
> +			return hdr_delta;

[Severity: Low]
This isn't a bug introduced by this patch, but the kernel-doc above
cipso_v4_delopt() says:

  * adjustments to the IP option structure.  Returns zero on success, negative
  * values on failure.

The function only ever returns 0 or a non-negative header delta.
cipso_v4_sock_delattr() subtracts that delta from icsk_ext_hdr_len when
hdr_delta > 0. The positive value returned here is correct for that
caller.

Could the comment be fixed while another return path is added under it?

> +		}
>  		hdr_delta = opt->opt.optlen;
>  		opt->opt.optlen = (optlen_new + 3) & ~3;
>  		hdr_delta -= opt->opt.optlen;

[Severity: High]
This is a pre-existing issue, but is it safe for cipso_v4_delopt() to
modify the ip_options_rcu in place while inet->inet_opt still points to it?

On this path, holding only lock_sock, it does these steps in order:

  1. lowers srr/rr/ts/router_alert by cipso_len
  2. clears cipso
  3. memmoves __data
  4. shrinks optlen

Lockless readers copy the object under rcu_read_lock() alone. For example,
udp_sendmsg():

	rcu_read_lock();
	inet_opt = rcu_dereference(inet->inet_opt);
	if (inet_opt) {
		memcpy(opt_copy, inet_opt,
		       sizeof(*inet_opt) + inet_opt->opt.optlen);

raw_sendmsg() and ping_v4_sendmsg() follow the same pattern.

So if connect(AF_UNSPEC) and sendmsg() run at the same time, sendmsg()
could copy offsets that were already reduced together with bytes that were
not yet moved. ip_options_build() uses both to compute a write address:

	if (opt->srr)
		memcpy(iph + opt->srr + iph[opt->srr + 1] - 4, &daddr, 4);

With [CIPSO][Y][LSRR], the reduced srr points at Y's old offset.
iph[srr + 1] would then read a stale CIPSO payload byte, which can be as
large as 0xff. The 4-byte write could land well past the 60-byte maximum
IP header. The rr_needaddr and ts_needaddr/ts_needtime paths look similar.

The new error branch above unpublishes the object before kfree_rcu(), but
this compaction path still changes the live object that readers can see.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/CBLsHx48w8Bn1k_Xg6kJFliLNkxLCqi8SnkifapxYYpVtll4w-W_2JJePtbk9ssIS701IFJvi0Q2n5l-2GFFe8hNHU9Y_CgD_sdzcAbILVA%3D%40proton.me
