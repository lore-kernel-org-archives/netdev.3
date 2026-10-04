Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FB632B12C
	for <netdev@vger.kernel.org>; Sun,  4 Oct 2026 06:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791095997; cv=none; b=okBFLgyZaNIPq+hJN/hyt0R2utby6iAF6Bp3Sysl8O+IVq5nsgXaepcCLenatX8khzZAHtDpxo145qVTWyJ29h1YIA45y8d9yw5M8SsddlXZnPXu6FwVZSeQ2PNuQH6VCGfScMXNP+rX5Rs5ArGRdBri1JIDcQA3XNbqVLbE0lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791095997; c=relaxed/simple;
	bh=qPlZ2s8wjUrr4VAb+9q75pXhsRDuGN0RHvHORHWYNbU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fQ/HgvaXIUXYHQMZYqCAfu3LNsz+x2NcVW4l4JEZpjCsC+H9cdA+6Blsg8GSGAAQS8aQnIaaMSsNjTNxRhQdqS21JHMlFJYsnIGiQcAgKMjpUuHRCbcxCKU0Pg0eOt9MQUJkY2V/SW1aaujzXqywHoMQjuZLZaAdQQ4cAdPLvxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UqHqY0wj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UqHqY0wj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89A901F000FF;
	Sun,  4 Oct 2026 06:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791095996;
	bh=l4/xRMLI1Wy47abrNQshKpQSWH2neG6HlS+VWZDiCDw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UqHqY0wj0VfA3cEc1vMyo4DgoDb/ycXKSWihYzAy4UcI1+/lcsCJmvA+KQoihs2Ox
	 Spx4aKggWgnB+JqTwF4pEp8GOF1jwUwjPBGOVb7rzoBoRQjayg8gJuM48NvQ9SX9El
	 oGQtQQFbk8MdDxli91uiKcKBGG8UPUOb9jqq7INpjhb/bFbijOmP2aEtMZm3Sb33eS
	 Fr06ZddjouCtYXKDsKVP5TUyc4Hx4ws3T4UV0dsQMoGe2ldyxfYu69IRcU+azjhGyT
	 6Mz9KMPyKFqNXCxVUphnOO6E+veluSMX59ssuzabVF3wDrga8aXE3BxkTIuROcbnnU
	 pZXc0HmhagwiA==
Subject:
 Re: [PATCH net v4 1/2] tun: keep a kernel copy of the socket filter program
From: netdev-bot+sashiko@kernel.org
To: clementwei90@163.com
Cc: netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com,
 jasowangio@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, weirongguang@kylinos.cn
Date: Sun, 04 Oct 2026 06:39:55 +0000
Message-ID: <179109599504.434549.16794375515097963280@kernel.org>
In-Reply-To: <20261003063859.136895-2-clementwei90@163.com>
References: <20261003063859.136895-2-clementwei90@163.com>
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

Critical: 0 · High: 0 · Medium: 1 (3) · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] TUNATTACHFILTER can store an invalid classic BPF program and
  still return 0.
- [Low] The new exported helper sk_attach_filter_kern()
  (net/core/filter.c:1570-1590) attaches a program built by…

Pre-existing issues:
- [Medium] TUNDETACHFILTER does not remove the filter from detached
  (disabled) queues, so a re-enabled queue keeps filtering with an old…
- [Medium] TUNATTACHFILTER and TUNGETFILTER do not work for 32-bit user
  space on a 64-bit CONFIG_COMPAT kernel.
- [Medium] Replacing an attached filter leaves the device in an
  inconsistent state if attaching the new one fails partway.

--

tun: keep a kernel copy of the socket filter program

This patch makes tun keep the classic BPF filter for TUNATTACHFILTER in
kernel memory (tun->fprog_kern), so it no longer re-reads it from the user
pointer every time a queue is attached. Each queue gets its own program
from a new helper, sk_attach_filter_kern(). The patch also fixes the
inverted error check in tun_attach().

Link: https://lore.kernel.org/netdev/179027275318.2160803.4185895144088175048@kernel.org/

> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 5a302709a68aa..b58ad67b77ad1 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c

[ ... ]

> @@ -722,12 +723,47 @@ static void tun_force_wake_queue(struct tun_struct *tun,
>  	spin_unlock_bh(&tfile->tx_ring.consumer_lock);
>  }
>  
> +/* Copy the filter that @argp points at into the kernel, so that it can be
> + * installed again later, independent of the ioctl caller's address space.
> + * tun->fprog and tun->fprog_kern are updated only once the copy succeeded.
> + */
> +static int tun_copy_filter(struct tun_struct *tun, struct sock_fprog __user *argp)
> +{
> +	struct sock_fprog fprog;
> +	struct sock_filter *insns;
> +
> +	if (copy_from_user(&fprog, argp, sizeof(fprog)))
> +		return -EFAULT;

[Severity: Medium]
This isn't a bug introduced by this patch, but does TUNATTACHFILTER work
for 32-bit user space on a 64-bit CONFIG_COMPAT kernel?

TUNATTACHFILTER and TUNGETFILTER are defined with the size of struct
sock_fprog in include/uapi/linux/if_tun.h:

#define TUNATTACHFILTER _IOW('T', 213, struct sock_fprog)

sock_fprog contains a pointer, so it is 8 bytes on 32-bit and 16 bytes on
64-bit, and the encoded command numbers differ. tun_chr_compat_ioctl()
passes cmd through unchanged:

	return __tun_chr_ioctl(file, cmd, arg, sizeof(struct compat_ifreq));

So the 32-bit numbers match no case in __tun_chr_ioctl() and fall through
to the default tun_vnet_ioctl() branch.

Even if the numbers were normalised, this copy_from_user() reads the
native sock_fprog layout, and TUNGETFILTER writes the native layout back.
Nothing on this path converts to or from compat_sock_fprog.

> +
> +	if (!fprog.len || fprog.len > BPF_MAXINSNS)
> +		return -EINVAL;

[Severity: Medium]
Can TUNATTACHFILTER now store an invalid classic BPF program and still
return 0?

This check covers only the length. The instructions are checked only by
bpf_check_classic(), via
sk_attach_filter_kern()->bpf_prog_create()->bpf_prepare_filter(). That
runs once per attached queue in tun_attach_filter():

	for (i = 0; i < tun->numqueues; i++) {
		...
	}

	tun->filter_attached = true;
	return ret;

If tun->numqueues is 0, the loop never runs and the program is never
checked. filter_attached is still set to true and the ioctl returns
success.

This state can be reached on a multiqueue TAP. TUNSETQUEUE with
IFF_DETACH_QUEUE goes through __tun_detach(tfile, false), which leaves
tfile->tun set. The same fd can then issue TUNATTACHFILTER while no
queues are attached.

With the corrected check in tun_attach():

		err = sk_attach_filter_kern(&tun->fprog_kern, tfile->socket.sk);
		release_sock(tfile->socket.sk);
		if (err)
			goto out;

every later TUNSETQUEUE(IFF_ATTACH_QUEUE) through tun_set_queue(), and
every TUNSETIFF without IFF_NOFILTER through tun_set_iff(), would then
fail with -EINVAL from bpf_prepare_filter(). This lasts until someone
issues TUNDETACHFILTER.

Could the instructions be checked once in the TUNATTACHFILTER path,
whatever numqueues is? One option is to build and destroy a throwaway
prog with bpf_prog_create(). Another is to run bpf_check_classic() on
the copy.

There is also a smaller behaviour change. A bad header now makes the
ioctl fail early and leaves the previous filter in place. Before, it
failed on queue 0 and cleared filter_attached. Should the commit message
mention this?

> +
> +	insns = kmalloc_array(fprog.len, sizeof(struct sock_filter),
> +			      GFP_KERNEL_ACCOUNT);

[ ... ]

> @@ -3059,6 +3102,9 @@ static void tun_detach_filter(struct tun_struct *tun, int n)
>  		release_sock(tfile->socket.sk);
>  	}
>  
> +	kfree(tun->fprog_kern.filter);
> +	tun->fprog_kern.filter = NULL;
> +	tun->fprog_kern.len = 0;
>  	tun->filter_attached = false;
>  }

[Severity: Medium]
This is a pre-existing issue, but does TUNDETACHFILTER leave the old
filter on queues that are currently detached?

tun_detach_filter(tun, tun->numqueues) walks only tun->tfiles[0..n). A
queue detached with IFF_DETACH_QUEUE sits on tun->disabled instead, and
__tun_detach(tfile, false) does not touch its sk->sk_filter.

When that queue is attached again while filter_attached is false,
tun_attach() skips the filter block:

	if (!skip_filter && (tun->filter_attached == true)) {

Take this sequence: attach a filter, IFF_DETACH_QUEUE on queue Q,
TUNDETACHFILTER, IFF_ATTACH_QUEUE on Q. Q keeps filtering packets with
the removed program, while the device reports no filter.

>  
> @@ -3070,7 +3116,7 @@ static int tun_attach_filter(struct tun_struct *tun)
>  	for (i = 0; i < tun->numqueues; i++) {
>  		tfile = rtnl_dereference(tun->tfiles[i]);
>  		lock_sock(tfile->socket.sk);
> -		ret = sk_attach_filter(&tun->fprog, tfile->socket.sk);
> +		ret = sk_attach_filter_kern(&tun->fprog_kern, tfile->socket.sk);
>  		release_sock(tfile->socket.sk);
>  		if (ret) {
>  			tun_detach_filter(tun, i);

[Severity: Medium]
This isn't a bug introduced by this patch, but what happens to queues
i..numqueues-1 when replacing an attached filter fails on queue i?

tun_detach_filter(tun, i) detaches only queues 0..i-1. It then frees
fprog_kern and clears filter_attached (see tun_detach_filter() above).
Queues i..numqueues-1 keep the old sk_filter.

Failure at i > 0 can happen through -ENOMEM from __sk_filter_charge() or
the allocations. Failure at i == 0 can happen with an invalid program.

By this point tun_copy_filter() has already freed the old fprog_kern and
set tun->fprog to the new program. After the failure:

- the device reports no filter
- new queues attach without a filter
- some existing queues still run the old program
- TUNGETFILTER returns a program that is not attached anywhere

Memory safety is not affected, because bpf_prog_create() copies the
instructions. The unwind logic is the same as before the patch.

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

[Severity: Low]
This isn't a bug, but bpf_prog_create() assumes its result is never
attached to a socket:

	/* Since unattached filters are not copied back to user
	 * space through sk_get_filter(), we do not need to hold
	 * a copy here, and can spare us the work.
	 */
	fp->orig_prog = NULL;

sk_attach_filter_kern() now attaches exactly such a program to
sk->sk_filter. When orig_prog is NULL, sk_get_filter() returns -EACCES
and sock_diag_put_filterinfo() silently leaves the filter out.

The commit message notes that tun sockets do not expose this. Even so,
the comment in bpf_prog_create() is now inaccurate. Unlike
sk_attach_filter(), the new exported helper also has no kernel-doc to
warn future callers.

Could sk_attach_filter_kern() save the original program, the way
bpf_prog_create_from_user() does with save_orig set? If not, could it
get kernel-doc that describes the limitation, along with an updated
comment in bpf_prog_create()?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261003063859.136895-1-clementwei90%40163.com
