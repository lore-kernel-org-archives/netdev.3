Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D5B50AC30
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 14:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790863841; cv=none; b=JRwRgeEi+SwdcLLr6h/r5TC8l9nW3L+N/J8ZV3VUIF/Z6B/mcIBs8MUU52JkPl0Qq8KtYjsEtuC9kVf7W9oT9AuWNj8f41dnYnTp896kGnTNWe0bcznWhzPCJsq+DIHfVDjCYJgmbvLSHG5GenVjujCEMjkWQSCKbIfC20lUOJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790863841; c=relaxed/simple;
	bh=oIjOCPTu2HtY4d7k3pXz8j9lOGASdj93oaTY7yym51s=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bYrmOlyB9U8nj3kctxpnAEswpb9VKVEI7d9eDGGYp7e+UbkYJDp5zTpRZrdi610RsBbS8Nv6FOhdU1/OOYOe9XV3wndYMOzM0OTKDO6XhBpxThqQbn5Q16xdeTg4FOOFkfwfvgOFwDdLiFeokQzViAhZfuRcz6UwoGWLaSoW1jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kr/Ycv4X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kr/Ycv4X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A8C71F000FF;
	Thu,  1 Oct 2026 14:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790863839;
	bh=VyPfWY5hTRBT6abnFinLMCKDwK6KvouaYEQFXqFjvKc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kr/Ycv4Xlq0gfqn8v/8CctMcGaVpDU4SKoOsLd+lANyG5o0MUj7KsJtUwlgi5y5yZ
	 fvYyd4ldG891dFQTuuHx4U376x+tgKu1nYfKVoH9RNedL19Ijbv5Uy2/b8JCc2nN8q
	 HlrHOB2ZP3WiLYwheIRQ5BgXy5TwwS4XtpuAfd8wfuN3If4JhHGwy1VIe27xYD9Biw
	 C5BI0HWgCOrWjuhmmd+DhOur0yCWrG0yhubv8GB3gXUcw+0FDjJMme576qCZlnqx9t
	 6L8J5fh2q7HYA+/2k3gSs03Tkba2r6DwgI/Z4YaihGNF7mLOwrpCZcGdLlQVVQWAYl
	 rBFbysJS+og0A==
Subject:
 Re: [PATCH net v3 1/3] tun: keep a kernel copy of the socket filter program
From: netdev-bot+sashiko@kernel.org
To: clementwei90@163.com
Cc: netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com,
 jasowangio@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, weirongguang@kylinos.cn
Date: Thu, 01 Oct 2026 14:10:39 +0000
Message-ID: <179086383901.434549.6742700086527768803@kernel.org>
In-Reply-To: <20260930080746.135017-2-clementwei90@163.com>
References: <20260930080746.135017-2-clementwei90@163.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 (2) · Low: 3 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] After this patch alone, tun_attach() in drivers/net/tun.c still
  has the inverted check `if (!err) goto out;` right after `err =…
- [Low] The commit message gets both the old failure mode and the new
  helper's semantics wrong.
- [Low] The new exported helper sk_attach_filter_kern()
  (net/core/filter.c) builds the program with bpf_prog_create() and then…
- [Low] The new comment above tun_copy_filter()
  (drivers/net/tun.c:726-729) says the kernel copy lets the filter "be…

Pre-existing issues:
- [Medium] tun has no compat translation for the classic filter ioctls.
- [Medium] If TUNATTACHFILTER replaces an attached filter and
  sk_attach_filter_kern() fails on queue i (for example -ENOMEM from…
- [Low] When TUNATTACHFILTER is issued while tun->numqueues == 0, the
  classic BPF program is stored without ever being validated.

--

tun: keep a kernel copy of the socket filter program

This patch changes TUNATTACHFILTER to copy the classic BPF instructions
into tun->fprog_kern. Before, only the sock_fprog header was stored, and
it pointed into the ioctl caller's address space. It also adds a new
exported helper, sk_attach_filter_kern(), which builds and attaches a
program from a kernel sock_fprog_kern, and tun_attach() and
tun_attach_filter() now use it.

Link: https://lore.kernel.org/netdev/179027275318.2160803.4185895144088175048@kernel.org/

> tun_attach() reads it again whenever a queue is attached to the
> persistent device later on: unmapped there, the attach fails with -EFAULT;
> mapped, whatever bytes it holds become the filter of the new queue.

[Severity: Low]
Is this an accurate description of the old behaviour? tun_attach() has an
inverted "if (!err) goto out;", so an -EFAULT, or an -EINVAL caused by
garbage bytes, falls through instead of failing the attach.

For a new tfile, xdp_rxq_info_reg() and "err = 0" then overwrite err. So
TUNSETIFF succeeds, the queue is attached, and no filter is installed.

A successful read of mapped, valid bytes returns 0 without attaching the
queue at all.

The follow-up patch's message talks about "a re-attach that used to
succeed without installing any filter". That seems to contradict this
one.

> sk_attach_filter_kern() reads no user buffer and attaches the program like
> sk_attach_filter() does.

Do the two really behave the same way? sk_attach_filter_kern() builds the
program with bpf_prog_create(), which sets fp->orig_prog = NULL.
sk_attach_filter() goes through __get_filter()->bpf_prog_store_orig_filter()
instead. As a result, SO_GET_FILTER and sock_diag readback give different
results depending on which helper attached the filter.

> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 5a302709a68aa..22fb34e745bd9 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c

[ ... ]

> @@ -722,6 +723,34 @@ static void tun_force_wake_queue(struct tun_struct *tun,
>  	spin_unlock_bh(&tfile->tx_ring.consumer_lock);
>  }
>  
> +/* Copy the filter that @argp points at into the kernel, so that it can be
> + * installed again later, from any context. tun->fprog and tun->fprog_kern
> + * are updated only once the copy succeeded.
> + */

[Severity: Low]
Is "from any context" accurate here? The only consumer,
sk_attach_filter_kern(), needs sleepable process context and the socket
lock:

sk_attach_filter_kern()
  bpf_prog_create()
    bpf_prog_alloc()          <- GFP_KERNEL based allocation
  __sk_attach_prog()
    kmalloc_obj()             <- GFP_KERNEL
    rcu_dereference_protected(..., lockdep_sock_is_held(sk))

Was the intended meaning "from any process", or "independent of the ioctl
caller's address space"?

> +static int tun_copy_filter(struct tun_struct *tun, struct sock_fprog __user *argp)
> +{
> +	struct sock_fprog fprog;
> +	struct sock_filter *insns;
> +
> +	if (copy_from_user(&fprog, argp, sizeof(fprog)))
> +		return -EFAULT;

[Severity: Medium]
This isn't a bug introduced by this patch, but tun has no compat handling
for the classic filter ioctls. TUNATTACHFILTER, TUNDETACHFILTER and
TUNGETFILTER encode sizeof(struct sock_fprog) in the command number. That
size is 8 bytes for 32-bit userspace and 16 bytes natively, so the command
numbers differ.

tun_chr_compat_ioctl() only converts these:

	case TUNSETIFF:
	case TUNGETIFF:
	case TUNSETTXFILTER:
	case TUNGETSNDBUF:
	case TUNSETSNDBUF:
	case SIOCGIFHWADDR:
	case SIOCSIFHWADDR:
		arg = (unsigned long)compat_ptr(arg);
		break;

The compat filter commands therefore miss the native cases in
__tun_chr_ioctl() and end up in tun_vnet_ioctl(), which returns -EINVAL.
tun_copy_filter() is never reached with a compat layout. The result is
that 32-bit userspace on a 64-bit kernel cannot use these ioctls.

This copy is being rewritten anyway. Would it be worth adding compat
command translation here, perhaps together with the compat-aware
copy_bpf_fprog_from_user() that SO_ATTACH_FILTER uses?

> +
> +	if (!fprog.len || fprog.len > BPF_MAXINSNS)
> +		return -EINVAL;

[Severity: Low]
This is a pre-existing issue, but only the length is checked before the
program is committed to tun->fprog_kern. If TUNATTACHFILTER is issued
while tun->numqueues == 0, does the program ever get validated?

A multiqueue TAP reaches that state after TUNSETQUEUE(IFF_DETACH_QUEUE) on
every queue. __tun_detach(tfile, false) lowers numqueues but keeps
tfile->tun, so tun_get() still succeeds in __tun_chr_ioctl().

In that case the loop in tun_attach_filter() runs zero times, and
bpf_check_classic() (via bpf_prog_create()->bpf_prepare_filter()) never
runs. filter_attached is still set to true and 0 is returned.

After that, every tun_attach() fails in sk_attach_filter_kern() with
-EINVAL until TUNDETACHFILTER. The old code had the same gap: it stored an
unvalidated header when numqueues == 0.

> +
> +	insns = memdup_array_user(fprog.filter, fprog.len,
> +				  sizeof(struct sock_filter));

[ ... ]

> @@ -752,7 +781,7 @@ static int tun_attach(struct tun_struct *tun, struct file *file,
>  	/* Re-attach the filter to persist device */
>  	if (!skip_filter && (tun->filter_attached == true)) {
>  		lock_sock(tfile->socket.sk);
> -		err = sk_attach_filter(&tun->fprog, tfile->socket.sk);
> +		err = sk_attach_filter_kern(&tun->fprog_kern, tfile->socket.sk);
>  		release_sock(tfile->socket.sk);
>  		if (!err)
>  			goto out;

[Severity: High]
With only this patch applied, is the check after sk_attach_filter_kern()
still inverted?

The program is now built from a kernel copy, so the build succeeds for
any valid program. On a persistent TAP with filter_attached set, TUNSETIFF
without IFF_NOFILTER and TUNSETQUEUE(IFF_ATTACH_QUEUE) would then jump
straight to out and return 0.

That jump skips all of the following:

  - ptr_ring_resize()
  - the queue_index setup
  - xdp_rxq registration
  - sock_hold()/tun_napi_init() or tun_enable_queue()
  - publishing tfile->tun and tun->tfiles[]
  - the numqueues increment

tun_set_iff() and tun_set_queue() report success, but the fd stays
unattached, and later reads and writes fail with -EBADFD.

The reverse also happens: when the build fails, the code falls through and
attaches the queue with no filter.

The next patch in the series, "tun: fix inverted error check when
re-attaching the filter", changes this to "if (err) goto out;". It also
adds a rollback_filter sk_detach_filter() on the later failure paths, so
the code is correct at the end of the series.

Could that fix be folded into this patch, or ordered before it? Otherwise
a bisect can land on a kernel where re-attaching to a filtered persistent
TAP silently does nothing.

[ ... ]

> @@ -3070,7 +3103,7 @@ static int tun_attach_filter(struct tun_struct *tun)
>  	for (i = 0; i < tun->numqueues; i++) {
>  		tfile = rtnl_dereference(tun->tfiles[i]);
>  		lock_sock(tfile->socket.sk);
> -		ret = sk_attach_filter(&tun->fprog, tfile->socket.sk);
> +		ret = sk_attach_filter_kern(&tun->fprog_kern, tfile->socket.sk);
>  		release_sock(tfile->socket.sk);
>  		if (ret) {
>  			tun_detach_filter(tun, i);

[Severity: Medium]
This isn't a bug introduced by this patch, but what happens to the
remaining queues in this case? TUNATTACHFILTER replaces an attached
filter, and sk_attach_filter_kern() fails on queue i, for example with
-ENOMEM from __sk_filter_charge() at the optmem limit.

tun_detach_filter(tun, i) only detaches queues 0..i-1, then frees the new
kernel copy and clears filter_attached. Queues i..numqueues-1 keep the
previous sk_filter.

The previous copy has already been freed in tun_copy_filter():

	kfree(tun->fprog_kern.filter);
	tun->fprog_kern.len = fprog.len;
	tun->fprog_kern.filter = insns;
	tun->fprog = fprog;

So the old state can't be restored, and queues attached later get no
filter. The device ends up with some queues unfiltered and others still
using the old filter.

The old code had the same prefix-only rollback, since it overwrote
tun->fprog in place before attaching.

[ ... ]

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
> +	if (err)
> +		return err;
> +
> +	err = __sk_attach_prog(prog, sk);

[Severity: Low]
bpf_prog_create() is documented as creating an unattached filter, and it
deliberately skips orig_prog:

net/core/filter.c:bpf_prog_create() {
	...
	/* Since unattached filters are not copied back to user
	 * space through sk_get_filter(), we do not need to hold
	 * a copy here, and can spare us the work.
	 */
	fp->orig_prog = NULL;
	...
}

This helper now attaches such a program to sk->sk_filter. Does
sk_get_filter() then return -EACCES for these sockets?

net/core/filter.c:sk_get_filter() {
	...
	ret = -EACCES;
	fprog = filter->prog->orig_prog;
	if (!fprog)
		goto out;
	...
}

sock_diag would also leave the filter out. sk_attach_filter() keeps
orig_prog through bpf_prog_store_orig_filter().

tun sockets can't reach SO_GET_FILTER today. However, this helper is
exported and declared next to sk_attach_filter() in include/linux/filter.h.
Should the difference be documented, or should orig_prog be stored here as
well?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930080746.135017-1-clementwei90%40163.com
