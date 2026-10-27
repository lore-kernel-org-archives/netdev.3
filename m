Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793095785;
	b=jdALegIu4KfKRhzGnENuoFvv98jgJaxS34TnfI5bAl3bhgN/5fjuVPMBvFhVdDDY0Aox
	 g1YwZVVvhzwPQDP9nBLu0gxIhxKHQ1rtaZkncWp9ypA0k6PVHyOFwJYg23dcOmDVbtgLa
	 h2iRZ7tcouVAkxAUDSIJLB91RGkA2OqrSXfOsd6Xi7OdUYVZEmX3uadVY+3UwVU6H2KoS
	 ODkCPCgPA9g6NKqwENaqQLGx+RkZ4XsoQWC01xcb8KHu2cBDrBKcOb+LVOtd9Lpp1DreR
	 btsSh+hm95UsCAWzySRnRASbL+6avK3T9N2WMEXn6P+7LOgg4XS1WfSr81yNLYWwDAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793095785;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=H2UUJnxC0RvDw/ifFK3LmbQevmjCJ6QsIRP+Qsn24Z8=;
	b=sNRWhOprQB2HeHK0Y2jvc3og/kZBRLB3/oIhOfsLBLjZwpUDNuveqOWPBJ2XWBqtCw9G
	 h7SSDhM2ipkwO3NfAHOJGweT3sDlvyQM0Q8t3FiNfQR7hEVd5aT5pqjBRtuUqYSh6GNHE
	 KWUYRKgyjuguxXOq5chZ1gL9+ufd06ToSyjM7VPnXf0H1OYej2qp7ICJ/qTi2hR19S0uv
	 s/vq69O4g0Nblg8S7qtrLSPYm2IC0du7ph6uYT/gfAAXO0c8eQt9ke7xIjin7L+R3l9Be
	 F18Ove5Uhto/M+2iHf8gwLBtljR2feD/AbM8r2M+PIweUFEwkrRmA/ZdpNSi5q/sNLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZE4JZrYu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A209606A31B
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 10:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZE4JZrYu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E9961F01825;
	Tue, 27 Oct 2026 10:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793095785;
	bh=H2UUJnxC0RvDw/ifFK3LmbQevmjCJ6QsIRP+Qsn24Z8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZE4JZrYuffOn0hfakUIUGuYUhWMzHnmtsbHDFqcxEzwfWEkhciY2fs2PXu7UOH4HV
	 vFs5nGKg1VKpJxyAB2xxtNEcpNT2ImRhjJGJ7b5AuJ2zsKskagrsry6ffbLP82MUOJ
	 8Ajw00AibCUSjZcPklmIe2Xa4bVqNou9K2nv4PbShIIlb8wLgQ4jJb7uAhv5pY8FDe
	 KYIm0rM5cyyng04JktwfyPJAO3Hd8VQROaiuxzHUnj8mvK8GyRzi7+UBUHGqurIUHL
	 lf27vywXYxvRxctCg92iGBbOKh+xb7IQTwpyZbyrncIEDW1IzcS5Lv1z6ubyAiavl9
	 0Q3J4b8ApJh2g==
Subject:
 Re: [PATCH net v7 1/2] tun: keep a kernel copy of the socket filter program
From: netdev-bot+sashiko@kernel.org
To: clementwei90@163.com
Cc: netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com,
 jasowangio@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, weirongguang@kylinos.cn
Date: Tue, 27 Oct 2026 10:09:44 +0000
Message-ID: <179309578401.3134.11519975030981154705@kernel.org>
In-Reply-To: <20261023092239.186665-2-clementwei90@163.com>
References: <20261023092239.186665-2-clementwei90@163.com>
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

Critical: 0 · High: 1 · Medium: 0 (2) · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] bpf_prog_validate_classic() does not run "the same checks that
  bpf_prog_create() performs", although its kernel-doc and the commit…
- [Low] The kernel-doc for the new exported helper
  bpf_prog_validate_classic() (net/core/filter.c) says it returns "0 if…

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but a filter
  replacement that passes tun_copy_filter() and then fails on some queue…
- [Medium] This problem wasn't introduced by this patch, but
  TUNDETACHFILTER leaves disabled queues with their old socket filter,…

--

tun: keep a kernel copy of the socket filter program

This commit keeps a kernel copy of the classic BPF program passed to
TUNATTACHFILTER in tun->fprog_kern. Each queue's filter is now built from
that copy with a new sk_attach_filter_kern() helper. It also fixes the
inverted error check in tun_attach(), and it validates the program up
front in tun_copy_filter() with a new bpf_prog_validate_classic() helper.

Link: https://lore.kernel.org/netdev/179027275318.2160803.4185895144088175048@kernel.org/

> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 242899f7fd071..e7d9f4480a89f 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c

[ ... ]

> +	/* The instructions are only verified when a program is built from
> +	 * them, which tun_attach_filter() does once per attached queue.
> +	 * Check them here as well: with no queue attached that would not
> +	 * happen at all, and, now that tun_attach() treats that error as
> +	 * fatal, every later attach would fail with -EINVAL instead of
> +	 * rejecting the program now.
> +	 */
> +	err = bpf_prog_validate_classic(insns, fprog.len);
> +	if (err) {
> +		kfree(insns);
> +		return err;
> +	}

[Severity: High]
Does bpf_prog_validate_classic() really reject everything that
bpf_prog_create() rejects? Its kernel-doc and the commit message both say
it does:

  "The instructions are verified with the new bpf_prog_validate_classic(),
  which runs the same checks as bpf_prog_create() on the copied program."

The helper only runs bpf_check_basics_ok() and bpf_check_classic().
bpf_prog_create() also goes through this path:

bpf_prog_create()
  bpf_prepare_filter()
    bpf_migrate_filter()
      bpf_convert_filter()
    bpf_prog_select_runtime()
      __bpf_prog_select_runtime()

bpf_convert_filter() rejects any jump whose converted offset does not fit
in s16:

	if (off < off_min || off > off_max)
		goto err;

__bpf_prog_select_runtime() can also return -ENOTSUPP when a JIT is
required but did not run.

Take a 4096 instruction program: BPF_JMP|BPF_JA with k=4094 at pc 0, then
4094 BPF_LD|BPF_B|BPF_ABS loads of offset 0, then BPF_RET|BPF_K.
bpf_check_classic() accepts it. convert_bpf_ld_abs() expands each load
into 12 eBPF instructions, so the JA offset grows to about 49128, and
bpf_convert_filter() fails with -EINVAL.

Suppose every queue on a multiqueue TAP has been disabled with
IFF_DETACH_QUEUE. tun_copy_filter() stores this program, and
tun_attach_filter() loops over zero queues and then does:

	tun->filter_attached = true;

>From then on, every IFF_ATTACH_QUEUE, and every TUNSETIFF without
IFF_NOFILTER, calls sk_attach_filter_kern() in tun_attach() and gets
-EINVAL. With the corrected check, tun_attach() then takes the goto out
path and the queue is never published.

Isn't this the "every later attach would fail with -EINVAL" case that the
comment above says is avoided?

When queues are active, the same program fails at queue 0, and
tun_attach_filter() calls tun_detach_filter(tun, 0). That frees fprog_kern
and clears filter_attached, which doesn't seem to match this part of the
commit message:

  "a TUNATTACHFILTER that no verifier would accept now fails early and
  leaves the previously attached filter in place."

The sk_attach_filter_kern() kernel-doc in this same patch lists -EINVAL
from bpf_prog_create() and -ENOTSUPP as possible results. That also
suggests the two checks are not equivalent.

Would it be more reliable for tun_copy_filter() to build the program once
with bpf_prog_create() and then destroy it, instead of calling
bpf_prog_validate_classic()?

[ ... ]

> @@ -3064,6 +3127,9 @@ static void tun_detach_filter(struct tun_struct *tun, int n)
>  		release_sock(tfile->socket.sk);
>  	}
>  
> +	kfree(tun->fprog_kern.filter);
> +	tun->fprog_kern.filter = NULL;
> +	tun->fprog_kern.len = 0;
>  	tun->filter_attached = false;
>  }

[Severity: Medium]
This isn't a bug introduced by this patch, but does TUNDETACHFILTER leave
the old filter in place on disabled queues?

tun_detach_filter() only walks the active queues:

	for (i = 0; i < n; i++) {
		tfile = rtnl_dereference(tun->tfiles[i]);

TUNDETACHFILTER passes tun->numqueues as n. A queue disabled with
IFF_DETACH_QUEUE was already removed from tun->tfiles by
__tun_detach(tfile, false) via tun_disable_queue(). That path never calls
sk_detach_filter(), so the disabled socket keeps its sk_filter.

When the queue is re-enabled with IFF_ATTACH_QUEUE, tun_attach() skips its
filter block because filter_attached is now false. Nothing clears the
stale filter, and tun_net_xmit() checks the socket filter directly:

	if (tfile->socket.sk->sk_filter) {
		drop_reason = sk_filter_reason(tfile->socket.sk, skb);

So could packets on that queue still be filtered after a successful
TUNDETACHFILTER? The baseline code has the same omission.

> @@ -3075,7 +3141,7 @@ static int tun_attach_filter(struct tun_struct *tun)
>  	for (i = 0; i < tun->numqueues; i++) {
>  		tfile = rtnl_dereference(tun->tfiles[i]);
>  		lock_sock(tfile->socket.sk);
> -		ret = sk_attach_filter(&tun->fprog, tfile->socket.sk);
> +		ret = sk_attach_filter_kern(&tun->fprog_kern, tfile->socket.sk);
>  		release_sock(tfile->socket.sk);
>  		if (ret) {
>  			tun_detach_filter(tun, i);

[Severity: Medium]
This is a pre-existing issue, but what happens to the device-wide filter
state when a replacement filter passes tun_copy_filter() and then fails on
one of the queues here?

sk_attach_filter_kern() can still fail for a single queue. Examples are
-ENOMEM from bpf_prog_create(), the optmem charge in __sk_attach_prog()
(the new filter is charged before the old one is uncharged), or the s16
conversion failure described above.

If the failure is at index i, tun_detach_filter(tun, i) removes the filter
only from queues 0..i-1. It then frees fprog_kern and sets filter_attached
to false. Queues i..numqueues-1, and any disabled queues, keep their old
socket filter.

tun->fprog already holds the new header, so TUNGETFILTER reports a program
that is not attached. Because filter_attached is false, later tun_attach()
calls skip sk_attach_filter_kern(), and those queues come up without a
filter.

Doesn't this leave the device with some queues using the old filter and
some with no filter at all? The baseline tun_attach_filter() and
tun_detach_filter() pair is structured the same way; this patch only adds
the kfree() of fprog_kern.

[ ... ]

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 70dc621672f2e..bcc7906353fef 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -1476,6 +1476,27 @@ void bpf_prog_destroy(struct bpf_prog *fp)
>  }
>  EXPORT_SYMBOL_GPL(bpf_prog_destroy);
>  
> +/**
> + * bpf_prog_validate_classic - verify a classic BPF program in kernel memory
> + * @insns: instruction array
> + * @len: number of instructions in @insns
> + *
> + * Run the same checks that bpf_prog_create() performs on a classic BPF
> + * program, without allocating a struct bpf_prog.  Callers that already hold
> + * the instructions in kernel memory can use this to reject a program when it
> + * is configured instead of when it is attached to a socket.
> + *
> + * Return: 0 if the program is valid, otherwise -EINVAL.
> + */
> +int bpf_prog_validate_classic(const struct sock_filter *insns, unsigned int len)
> +{
> +	if (!bpf_check_basics_ok(insns, len))
> +		return -EINVAL;
> +
> +	return bpf_check_classic(insns, len);
> +}

[Severity: Low]
Is the Return: description accurate? bpf_prog_validate_classic() passes
the result of bpf_check_classic() through unchanged. For a program that
ends in BPF_RET, that result comes from check_load_and_stores(), which
allocates:

	masks = kmalloc_array(flen, sizeof(*masks), GFP_KERNEL);
	if (!masks)
		return -ENOMEM;

So the helper can also return -ENOMEM. Along the same lines, "without
allocating a struct bpf_prog" is literally true, but the helper does still
allocate memory.

tun_copy_filter() passes the error through correctly, so this only affects
the documented contract of the exported helper.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261023092239.186665-1-clementwei90%40163.com
