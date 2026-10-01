Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032BE388E74
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 04:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790829552; cv=none; b=VQgy9FxWMNC52+v8J0F2LDT+EK9pe6V/iHO/0iTQS/PhYKvJmv3xv0gCZjoTubH2ONLx8fvvHLP+0MrDOEWE5rWvp5BBjMHZqMW65KGkPoRYQIH8DRf3o4XywItORNhZvGFdDIHG6KGAdkf/xUf6Ibi3Z8zOHRftLff5R9cUP5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790829552; c=relaxed/simple;
	bh=y42vVJwbBynRKKIw+qvvvkuIGs7bK9KcXB7bsPwpJlw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VwqwkLV1NJMVEl8/cV/dFHt6WWo9Mxg/Uw5CDh7e+wHxmOzosi7aRQkPraVHy+T44osbOkK0GxvmTpK1Q+o/iEY4Y8flLUmMH+FvDLaiFsKhFxGTaKGlUricTPtFVL9gb4XnxbZCNHvSgqhzIbNXE+wtJSPEF9aBS2JXH3NDx2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TDsUEBmY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TDsUEBmY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFC711F00898;
	Thu,  1 Oct 2026 04:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790829550;
	bh=IfPpFg7lEgiITPF69cytqxfsc72Z9HgXXYym3OV7PJc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=TDsUEBmYyOOXQNW0qJj/7HaghP3VWS9eF+8pvrNDZYn8gC4cWWnI5YGvx4n0O7Qeh
	 dRWx/yj/kMyo1N/pvs8OeRpWfoSDPD9036MwTUdhrXVqfpgKJjAWl4UgJK4TiVLMsk
	 r3P60ajcS/NCGo+pKu3N6lgKEHMUQHOsdD7qyywXmmJ/KdYySafD8cfzqFquPdYGc/
	 Kxdk8g0lJw994jljhNWbvImhYTqpSQs32Ps4DJeAVA0REaHw9skcQc4NmT00X7um8F
	 QJuTJuZeKxVTUDY8Ar5sui98ugPpa759qRecw8/Qmandpg29Dc3xjo9pmU7r0BhbLx
	 Md6UatXNlQ3+Q==
Subject: Re: [PATCH v2 2/4] net: filter: add sk_attach_filter_kern() function
From: netdev-bot+sashiko@kernel.org
To: clementwei90@163.com
Cc: netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com,
 jasowangio@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, weirongguang@kylinos.cn
Date: Thu, 01 Oct 2026 04:39:09 +0000
Message-ID: <179082954929.434549.2514967196571467185@kernel.org>
In-Reply-To: <20260929093712.131096-3-clementwei90@163.com>
References: <20260929093712.131096-3-clementwei90@163.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] sk_attach_filter_kern() compiles stored classic BPF
  instructions in whatever task happens to call it.
- [Low] sk_attach_filter_kern() (net/core/filter.c:1570-1590) builds its
  program with bpf_prog_create() and publishes it in sk->sk_filter…

--

net: filter: add sk_attach_filter_kern() function

This adds sk_attach_filter_kern(). It builds a classic BPF socket filter
from a kernel-resident sock_fprog_kern using bpf_prog_create(), then
attaches it with __sk_attach_prog(). The kernel can then reinstall a
stored filter without reading a user buffer or file descriptor again.

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 70dc621672f2e..64d6505a4ef23 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -1567,6 +1567,28 @@ int sk_attach_filter(struct sock_fprog *fprog, struct sock *sk)
>  }
>  EXPORT_SYMBOL_GPL(sk_attach_filter);
>  
> +int sk_attach_filter_kern(struct sock_fprog_kern *fprog, struct sock *sk)
> +{
> +	struct bpf_prog *prog;
> +	int err;
> +
> +	if (sock_flag(sk, SOCK_FILTER_LOCKED))
> +		return -EPERM;
> +
> +	err = bpf_prog_create(&prog, fprog);

[Severity: Low]

bpf_prog_create() is documented as creating an unattached filter. It
drops the original program on purpose:

net/core/filter.c:bpf_prog_create() {
    ...
	/* Since unattached filters are not copied back to user
	 * space through sk_get_filter(), we do not need to hold
	 * a copy here, and can spare us the work.
	 */
	fp->orig_prog = NULL;
    ...
}

With this new export, that program ends up in sk->sk_filter. Can a
filter attached this way still be read back?

When orig_prog is NULL, sk_get_filter() returns -EACCES. Its comment
says this only happens for eBPF programs:

net/core/filter.c:sk_get_filter() {
    ...
	/* We're copying the filter that has been originally attached,
	 * so no conversion/decode needed anymore. eBPF programs that
	 * have no original program cannot be dumped through this.
	 */
	ret = -EACCES;
	fprog = filter->prog->orig_prog;
	if (!fprog)
		goto out;
    ...
}

In the same case, sock_diag_put_filterinfo() leaves out the filter
attribute without any error.

sk_attach_filter() goes through __get_filter()->bpf_prog_store_orig_filter()
and keeps the original program. So for classic filters, the two exported
attach APIs now behave differently for SO_GET_FILTER and sock_diag.

The tun consumer later in this series does not seem to be affected in a
way userspace can see. SO_GET_FILTER and sock_diag cannot reach its
sockets, and TUNGETFILTER returns tun->fprog.

Could this store orig_prog, the way bpf_prog_create_from_user() does
with save_orig? If not, could the limitation be documented and the
comments in bpf_prog_create() and sk_get_filter() updated?

[Severity: Medium]

Does this change whose credentials decide JIT hardening?

bpf_prog_create() calls bpf_prog_alloc(), and bpf_prog_alloc_no_stats()
sets:

	fp->blinding_requested = bpf_jit_blinding_enabled(fp);

When bpf_jit_harden is 1, bpf_jit_blinding_enabled() decides based on
current:

	if (bpf_jit_harden == 1 && bpf_token_capable(prog->aux->token, CAP_BPF))
		return false;

The instructions come from whoever stored them in the sock_fprog_kern.
Blinding, however, depends on whichever task calls
sk_attach_filter_kern() later.

With the tun consumer later in this series, this sequence looks possible:

1. An unprivileged owner of a persistent multi-queue TAP passes
   tun_not_capable() and issues TUNATTACHFILTER. The instructions are
   stored in tun->fprog_kern. The programs built for the queues attached
   at that point are blinded.

2. Later, a process with CAP_BPF or CAP_SYS_ADMIN attaches another queue
   using TUNSETIFF or TUNSETQUEUE.

3. tun_attach() calls sk_attach_filter_kern(&tun->fprog_kern, ...) with
   the privileged credentials. The unprivileged user's filter goes
   through bpf_prepare_filter()->bpf_migrate_filter()->
   bpf_prog_select_runtime() and is JIT-compiled without constant
   blinding.

Before this change, sk_attach_filter(&tun->fprog, ...) read the
instructions again from the attaching process's own address space. The
unprivileged user did not control the bytes compiled in the privileged
context.

With bpf_jit_harden=1, does this let constants chosen by the user into
JIT memory that is not blinded? Could the blinding decision be recorded
when the instructions are supplied, or be tied to where the program came
from rather than to current at attach time?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260929093712.131096-1-clementwei90%40163.com
