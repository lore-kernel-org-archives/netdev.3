Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BFE1A6838;
	Sat, 12 Sep 2026 01:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789175999; cv=none; b=OVAcHrL7xuvO0XT+/0Ynari3g4wnR17Ti+D+yUNlGF3g+8DyvVFvqpLLwWtXqCRQKyNr1UVGa3SsnpBMpZ3sapEfT0F3ACpTwkl9xFD1fbFgiur+Ybt0CpcOcsan/qalReP4TtUrDd7mf6l0evoVGUmR2cCTgrSBsFs3+G0T+OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789175999; c=relaxed/simple;
	bh=S5WJuLkmN/8VBiUyWmYZ8z6Zvi4V1Wqn7ma3J3c/Hfc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rZIdDHlUWQuL9hh3rUs1aK2SC3n+GO9vx1GlbfDlnPHJDpp/xE21+TMjb7RDwfdJI00HWKlehMpaQ5rW5wHYmDN+ZzJEtPlm4gm8UYHgLJaPRt6Whbg2dMmcoP/42quModgWNcCePAZbh3gjGx0uzomJiMCpYgwtcPnrNzJqtVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f4sv6tCu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f4sv6tCu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E3451F000FF;
	Sat, 12 Sep 2026 01:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789175998;
	bh=ZYcy4/6OA/EPIdzKHMx2xuitb5UBMDtdsKy6hKD2wRo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=f4sv6tCuB+khtwP951p8qaRZJOqRGvetOQ+A0VsWTq1bj/N1o9lMTozlDrC0N43n2
	 Cllbq+mq2ZUf0xetJiT/0jCgjEBBxmKoWrl/TFIsDkjacaGzyjx6YEPWId9uNrttRV
	 6iPptMnuecDRrCZYCf8pTf4hp7qvd/Wb6sTVAr6PkuNlRrc3gzya/hUCsyAhmmE88m
	 3h6aF7obeOMA4DJIRHPE8fnQ7l/c/enq+Jd8OHxr3X91YQZ1uc3dQImZuoQHER3vCa
	 L4OBt6vJl4iqS9Bgzan3XiKMFtBFFlKgTxTGYP2QGE4KMnBH13CUlKO/dJaL2d6KbO
	 IVFbdI9Xr90Fw==
Subject: Re: [PATCH net-next 1/2] net: add sockopt_expand_out()
From: netdev-bot+sashiko@kernel.org
To: leitao@debian.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuniyu@google.com, willemb@google.com,
 dsahern@kernel.org, idosch@nvidia.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, david.laight.linux@gmail.com,
 kernel-team@meta.com
Date: Sat, 12 Sep 2026 01:19:56 +0000
Message-ID: <178917599686.219967.7073291341401255599@kernel.org>
In-Reply-To: <20260910-getsockopt_phase6-v1-1-e681e102d5b8@debian.org>
References: <20260910-getsockopt_phase6-v1-1-e681e102d5b8@debian.org>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 4

- [Medium] sockopt_expand_out() (include/linux/net.h:82-93) mixes two
  length semantics: the growth predicate compares @size against…
- [Low] Undocumented linkage change: net/socket.c drops `static` from
  sockptr_to_sockopt() and include/linux/net.h publishes its prototype,…
- [Low] sockopt_expand_out() (include/linux/net.h:82-93) rejects a
  kernel-backed optval with WARN_ON_ONCE(!iter_is_ubuf(&opt->iter_out))…
- [Low] sockopt_expand_out() is introduced with no callers and the commit
  message never names the options that 'write past optlen today', so its…
- [Low] sockopt_expand_out() installs a caller-supplied size_t as the new
  count of a user-buffer iterator with no ceiling at all — no INT_MAX…

--

net: add sockopt_expand_out()

This adds a sockopt_expand_out() helper that regrows opt->iter_out past the
optlen userspace declared, for the getsockopt options whose reply length is
derived from a count stored in optval instead of from optlen.  It also makes
sockptr_to_sockopt() non-static and declares it in include/linux/net.h.

A few questions below.

> diff --git a/include/linux/net.h b/include/linux/net.h
> index 470100ae71077..de0ed362b3779 100644
> --- a/include/linux/net.h
> +++ b/include/linux/net.h
> @@ -70,6 +70,31 @@ static inline int sockopt_init_user(sockopt_t *opt, char __user *optval,
>  	return 0;
>  }
>  
> +/*
> + * Grow optval to @size, for the options whose reply is sized by a count the
> + * caller left in optval rather than by optlen. Those write past optlen today
> + * and userspace relies on it.
> + *
> + * Call it before writing through opt->iter_out: it re-anchors the iterator at
> + * the head of optval. Only a user buffer can be longer than the optlen the
> + * caller declared, so a kernel-backed optval is refused with -EINVAL.
> + */
> +static inline int sockopt_expand_out(sockopt_t *opt, size_t size)
> +{

[Severity: Low]
This isn't a bug, but the helper lands with no callers and the changelog
never names the options whose "reply is sized by a count the caller left in
optval".

The first user shows up in the following patch of the series, where
ip_mc_msfget() in net/ipv4/igmp.c calls it for the IP_MSFILTER reply.

Could the changelog name IP_MSFILTER, so the semantics of the new helper can
be read against a concrete conversion?

> +	if (size <= iov_iter_count(&opt->iter_out))
> +		return 0;
> +

[Severity: Medium]
This test compares @size against iov_iter_count(&opt->iter_out), which is the
number of bytes still remaining in the iterator, while the growth action below
re-anchors at the head of optval:

	iov_iter_ubuf(&opt->iter_out, ITER_DEST, opt->iter_out.ubuf, size);

For ITER_UBUF, iov_iter_advance() only bumps iov_offset and shrinks count;
ubuf keeps pointing at the head of the buffer.

So if a callback ever calls sockopt_expand_out() after copying part of its
reply, does the write cursor get rewound and the already-copied bytes
overwritten?

The same mismatch has two more effects: a @size that fits within the declared
optlen can still fall into the kernel-backed -EINVAL branch once the iterator
has been advanced, and the no-op branch can return 0 with the cursor sitting
mid-buffer.

opt->iter_in and opt->optlen also keep describing the old, smaller buffer
after the expansion.  Only ip_mc_msfget() assigning opt->optlen = msf_size
itself covers that up:

	err = sockopt_expand_out(opt, msf_size);
	if (err)
		return err;

	opt->optlen = msf_size;
	if (copy_to_iter(msf, IP_MSFILTER_SIZE(0), &opt->iter_out) !=

Nothing is broken today, since that single caller invokes the helper as the
first operation on a freshly built iterator, and the "call it before writing
through opt->iter_out" rule is stated in the comment.

Would comparing against opt->optlen (or iov_offset + count) and refusing a
partially consumed iterator make the helper's verdict independent of how much
has already been written?

> +	if (WARN_ON_ONCE(!iter_is_ubuf(&opt->iter_out)))
> +		return -EINVAL;
> +

[Severity: Low]
The changelog says only that "a kernel-backed optval keeps the bounded
iterator and the callback gets -EINVAL if it asks to grow", but this path also
emits a splat.

sockptr_to_sockopt() builds an ITER_KVEC iter_out whenever optval.is_kernel:

	if (optval.is_kernel) {
		kvec->iov_base = optval.kernel;
		kvec->iov_len = koptlen;
		iov_iter_kvec(&opt->iter_out, ITER_DEST, kvec, 1, koptlen);

so the state this WARN treats as impossible is a supported construction.

Following the reachability at the end of the series, the only caller of
sockopt_expand_out() is ip_mc_msfget(), reached only through the IP_MSFILTER
case of do_ip_getsockopt(), and the only kernel-backed entry into
do_ip_getsockopt() is sol_ip_sockopt() in net/core/filter.c:

	switch (optname) {
	case IP_TOS:
	case IP_TRANSPARENT:
		if (*optlen != sizeof(int))
			return -EINVAL;
		break;
	default:
		return -EINVAL;
	}

so IP_MSFILTER is rejected before any sockopt_t is built and no in-tree path
can trip the WARN.

Could the changelog mention the WARN as well, given it advertises only the
-EINVAL?

> +	iov_iter_ubuf(&opt->iter_out, ITER_DEST, opt->iter_out.ubuf, size);
> +
> +	return 0;
> +}
> +

[Severity: Low]
The caller-supplied @size becomes the new count of a user-buffer iterator with
no ceiling here: no INT_MAX clamp, even though opt->optlen and the getsockopt
optlen ABI are int, and no MAX_RW_COUNT limit of the kind import_ubuf()
applies to the same ITER_UBUF construction.  The comment above says @size
comes from "a count the caller left in optval", i.e. from user data.

At the only call site the value is bounded, so nothing overflows today:

	copycount = count < msf->imsf_numsrc ? count : msf->imsf_numsrc;
	len = flex_array_size(psl, sl_addr, copycount);
	msf->imsf_numsrc = count;
	msf_size = IP_MSFILTER_SIZE(copycount);

with psl->sl_count capped by net.ipv4.sysctl_igmp_max_msf, and the write past
the declared optlen matches what IP_MSFILTER already did before the
conversion.

Would a clamp on @size here, or a note that the helper is meant only for the
legacy options, be worth adding for future consumers?

> +int sockptr_to_sockopt(sockopt_t *opt, sockptr_t optval, sockptr_t optlen,
> +		       struct kvec *kvec);
> +
>  struct poll_table_struct;
>  struct pipe_inode_info;
>  struct inode;
> diff --git a/net/socket.c b/net/socket.c
> index c05d86e63abf7..29a0f7f8e2cab 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -2437,8 +2437,8 @@ INDIRECT_CALLABLE_DECLARE(bool tcp_bpf_bypass_getsockopt(int level,
>   * It is important to remember that both iov points to the same data, but,
>   * .iter_in is read-only and .iter_out is write-only by the protocol callbacks
>   */
> -static int sockptr_to_sockopt(sockopt_t *opt, sockptr_t optval,
> -			      sockptr_t optlen, struct kvec *kvec)
> +int sockptr_to_sockopt(sockopt_t *opt, sockptr_t optval,
> +		       sockptr_t optlen, struct kvec *kvec)

[Severity: Low]
The subject and changelog cover only sockopt_expand_out(), but this hunk also
drops static from sockptr_to_sockopt() and the header hunk publishes its
prototype.

The cross-file user only appears in the next patch, where do_ip_getsockopt()
in net/ipv4/ip_sockglue.c calls it:

	err = sockptr_to_sockopt(&opt, optval, optlen, &kvec);

Since ip_sockglue.o is obj-y and CONFIG_INET is a bool, no EXPORT_SYMBOL is
needed and nothing breaks.  Could the changelog say why sockptr_to_sockopt()
is being made global here?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260910-getsockopt_phase6-v1-0-e681e102d5b8%40debian.org
