Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0113B5111A5
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 10:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790678085; cv=none; b=rtK1dzhBXrAfu8j0TIPA/ind1uz4NZ7+HqfH3Ogv1aL2jemiubA+PqehrGcYiipWaQ27kRhOMcGX7j/fjg0OGAA+5prVjxvmBgQLIHPIKExpYVPK7BilNhCWZLh4YYys07Y5UffvzlOTsbRi3C7L4N7dzKIB5Fqy7JCj6nyI8q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790678085; c=relaxed/simple;
	bh=bZHbQTh8sNBEhhhKH6CxuYEsb7+RqdaJD1uFH41EVlY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=pnqqVjvqUgkyit6IV0WitmrPLbiH5ADDw2FHdkKkY7FFbX8KEn1cLswIlcpQFwGcudHPf+XOYHAXaCJhmfTc9/wNoCWrlIaNl2pP7V2tBJEpNyU7tr6eL1+8siBO9fkxneC9Vg/W6LvuDGfFFdUsStpcdjvZkKHkErtCYgC+Los=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cGg3FE04; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cGg3FE04"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30DF21F000FF;
	Tue, 29 Sep 2026 10:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790678068;
	bh=L5BtSENqFS7ryOpBxwmg2ZxR/OQehhyQdnkUtvkDw4M=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=cGg3FE04ITN2OGPo7o42VX0I3sxzriV0fSh30VoEmwXIPhNE9UfkpErpiA0exJo36
	 CLcc71xSS6a6DanvRugVut1COoZ9P3yLYF0yHgBSfYH4lXcs4AuYEVVBig+Elk5R18
	 vRrL4ab3EUQvrWDqBFHnEXYFibkI7H9Pmd6jBC/av0CrodIOBP0u2DqpODmeSEE3Mg
	 Se9eumlmEnIla5g4nNQDICCTpvbMiqx4XJlEpwVWX0X3Kwt0lx90bO8Yy5pHgioWbk
	 wKvcsRjxNvHIbWAZPUZex3W3Q3EyyYe5lkpPDTdfZzyg+RRfnwkymDwetCw/HFNaXk
	 hwngM05EAG3vQ==
Content-Type: multipart/mixed; boundary="===============6527939886633122306=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8edfca6d5f5f89f19158fb9b1595f565f550beee37dd874026baf17c936226a8@mail.kernel.org>
In-Reply-To: <20260929093712.131096-2-clementwei90@163.com>
References: <20260929093712.131096-2-clementwei90@163.com>
Subject: Re: [PATCH v2 1/4] tun: fix inverted error check when re-attaching the filter
From: bot+bpf-ci@kernel.org
To: clementwei90@163.com,netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,jasowangio@gmail.com,andrew+netdev@lunn.ch,davem@davemloft.net,kuba@kernel.org,weirongguang@kylinos.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 29 Sep 2026 10:34:28 +0000 (UTC)

--===============6527939886633122306==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 5a302709a68a..a2fffef3735f 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -728,6 +728,7 @@ static int tun_attach(struct tun_struct *tun, struct file *file,
>  {
>  	struct tun_file *tfile = file->private_data;
>  	struct net_device *dev = tun->dev;
> +	bool rollback_filter = false;
>  	int err;
>
>  	err = security_tun_dev_attach(tfile->socket.sk, tun->security);
> @@ -754,8 +755,9 @@ static int tun_attach(struct tun_struct *tun, struct file *file,
>  		lock_sock(tfile->socket.sk);
>  		err = sk_attach_filter(&tun->fprog, tfile->socket.sk);
>  		release_sock(tfile->socket.sk);
> -		if (!err)
> +		if (err)
>  			goto out;
> +		rollback_filter = true;
>  	}

Does this change the behavior for cases where tun->fprog.filter holds a
__user pointer from a different process?

When TUNATTACHFILTER runs, it copies only the sock_fprog header:

    case TUNATTACHFILTER:
        ...
        if (copy_from_user(&tun->fprog, argp, sizeof(tun->fprog)))

This means tun->fprog.filter still points into the address space of the
process that issued that ioctl. When sk_attach_filter() runs here, it
calls __get_filter() which does:

    copy_from_user(prog->insns, fprog->filter, fsize)

in the context of the current process.

For a persistent TAP, if process A creates it and runs TUNATTACHFILTER
with a filter array on its stack or heap, then closes the fd, and process
B later opens /dev/net/tun and runs TUNSETIFF on the same name without
IFF_NOFILTER, the fprog.filter pointer may not be valid in process B's
address space.

Before this patch, when sk_attach_filter() failed (which was actually the
success case due to the inverted check), the err value was overwritten by
later operations (xdp_rxq_info_reg() followed by 'err = 0'), so the queue
was published and TUNSETIFF succeeded, just without a filter installed.

After this patch, if the pointer is unmapped, __get_filter() returns
-EFAULT and TUNSETIFF now fails. If it happens to be mapped but holds
other data, bpf_prepare_filter() usually returns -EINVAL and TUNSETIFF
fails. When the bytes happen to pass validation, they become the filter of
a queue that actually gets published.

This affects both the persistent TAP case described above and multi-queue
setups where another queue is opened after the buffer holding the original
filter has been freed or reused.

The next patch in the series, 508f529200c5 ("tun: keep a kernel copy of
the socket filter program"), addresses this by storing a kernel copy of
the filter program. That commit's changelog describes exactly this
behavior: "unmapped there, the attach fails with -EFAULT; mapped,
whatever bytes it holds become the filter of the new queue". It relies on
8c6a2cf8bd0a ("net: filter: add sk_attach_filter_kern() function").

Until that commit is applied, this patch changes the re-attach behavior
from succeeding (without filter) to failing (with -EFAULT or -EINVAL).
Both commits carry the same Fixes: tag, so a stable backport or bisect
that includes only this commit would encounter the problem.

Would it make sense to reorder these commits, putting the kernel-copy
change before the inverted-check fix, so every step of the series works?

> @@ -817,6 +819,11 @@ static int tun_attach(struct tun_struct *tun, struct file *file,
>  	WRITE_ONCE(tun->numqueues, tun->numqueues + 1);
>  	tun_set_real_num_queues(tun);
>  out:
> +	if (err && rollback_filter) {
> +		lock_sock(tfile->socket.sk);
> +		sk_detach_filter(tfile->socket.sk);
> +		release_sock(tfile->socket.sk);
> +	}
>  	return err;
>  }


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36552651982
--===============6527939886633122306==--
