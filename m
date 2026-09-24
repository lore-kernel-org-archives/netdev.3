Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C2E3D9665
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 17:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790272755; cv=none; b=ZCACQSXYxxSrdph2kwzJ9rWEIa0cV/1iRulW6N9fp/lOMF54DFXNNp4cqH0v0NbCUp8h7N2FAv2yKWoBhxdNiVDU2OHAYXR2SAuw0UAgS2SVVpKsj8hkZeUAfPHAS1EMkzLCeE/aoqLwkctwuYoOwzDHK2yftW00w83rwsgFhwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790272755; c=relaxed/simple;
	bh=kq2p4pSNH5egJr5dYJiGsKFAzGlP5oF2IWT9evtiXDQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S7YA6XS6576w7GU9dTh8ZuiqKgymkTh8KfqnzCpohNavbA5x/gynSCA5lRj5FcEKAgXVONuaaru1y5jVXLFtEWx9e+LM2tpo416ig/7ppEu4daSnTwn8tsZ6O42Ht4mSBxh+jPcqYXzO1IDSGpHRPYWlTaNIydbPUDfVKH6THH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Plmx0XkG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Plmx0XkG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A428F1F000FF;
	Thu, 24 Sep 2026 17:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790272754;
	bh=UnuecOH75b/K6jh9pK4ZlXrmz32ubyHOtqrBu5JqP2k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Plmx0XkGB7gFn3fcWyo+Y12mZszCjmqTa48N4qVetndx4QJdgKFbaGr9Zt7HzyTtT
	 nrhWqxaCU1W2rI44XN+naxcO3mH64RjjoL9Av/g1s6fXhvFuoJL/i7YtKzugbNdF44
	 K9rEdbHns95BACNG5UihpVegTpRe8j3TBjmtzN+8JFfkOKjVDhYFJOM1ZL3QEmDo8D
	 TZPQH/S/xDbKgzgUEnVQwjs62rxQM/We/HosJ6rqI+ynm5Fg9chgSxzaAm39KrX8Ba
	 T5dLoY9DeSr1EDHdhQ2Mk2R4G5aAQxyVTxMNk1mHa75DV+U5vDHthKLCYQITpi7MmT
	 Rg4hi6vgEnVXg==
Subject:
 Re: [PATCH net v1] tun: fix inverted error check when re-attaching the filter
From: netdev-bot+sashiko@kernel.org
To: clementwei90@163.com
Cc: netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com,
 jasowangio@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 weirongguang@kylinos.cn, kuba@kernel.org
Date: Thu, 24 Sep 2026 17:59:13 +0000
Message-ID: <179027275318.2160803.4185895144088175048@kernel.org>
In-Reply-To: <20260923025653.59348-1-clementwei90@163.com>
References: <20260923025653.59348-1-clementwei90@163.com>
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

- [Medium] The re-attach path that this patch enables rebuilds the queue
  filter from a stale userspace pointer, and reads it in the wrong…
- [Low] With the check inverted, a successful sk_attach_filter() in
  tun_attach() (drivers/net/tun.c:755) no longer returns early.

--

tun: fix inverted error check when re-attaching the filter

This patch inverts the error check after sk_attach_filter() in
tun_attach(). A successful filter re-attach now continues on to publish
the queue, and a failed one aborts the attach.

> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 5a302709a68aa..09720883b9a10 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -754,7 +754,7 @@ static int tun_attach(struct tun_struct *tun, struct file *file,
>  		lock_sock(tfile->socket.sk);
>  		err = sk_attach_filter(&tun->fprog, tfile->socket.sk);
>  		release_sock(tfile->socket.sk);
> -		if (!err)
> +		if (err)
>  			goto out;
>  	}
>  

[Severity: Low]
A successful sk_attach_filter() now falls through. If a later step in
tun_attach() fails, can the filter stay attached to a socket that was
never published?

After this point, tun_attach() can still fail here:

	if (!tfile->detached &&
	    ptr_ring_resize(&tfile->tx_ring, dev->tx_queue_len,
			    GFP_KERNEL, tun_ptr_free)) {
		err = -ENOMEM;
		goto out;
	}

It can also fail in xdp_rxq_info_reg() or xdp_rxq_info_reg_mem_model().
None of these error paths call sk_detach_filter(tfile->socket.sk).

By comparison, tun_attach_filter() rolls back when it fails:

		if (ret) {
			tun_detach_filter(tun, i);
			return ret;
		}

The fd can then be reused. One way is to retry TUNSETIFF with
IFF_NOFILTER, which sets skip_filter and skips the re-attach block.
Another is to attach to a different device that has no filter. Neither
clears sk_filter, since only tun_detach_filter() calls sk_detach_filter().

tun_net_xmit() would then apply the leftover filter to packets:

	if (tfile->socket.sk->sk_filter) {
		drop_reason = sk_filter_reason(tfile->socket.sk, skb);

TUNGETIFF would also leave IFF_NOFILTER unset, even though it was
requested.

The commit message says "nothing is published at that point, so the
attach can be aborted cleanly". Is that only true when sk_attach_filter()
itself is the step that fails?

[Severity: Medium]
This path now installs the rebuilt filter on a live queue. Is
tun->fprog still safe to reuse at this point?

TUNATTACHFILTER in __tun_chr_ioctl() copies only the sock_fprog header:

		if (copy_from_user(&tun->fprog, argp, sizeof(tun->fprog)))
			break;

That leaves tun->fprog.filter as a __user pointer from the process that
issued the ioctl. On a persistent device, tun->filter_attached stays true
after all queues are closed.

Later calls reach the re-attach through this path. That includes
TUNSETIFF without IFF_NOFILTER, and TUNSETQUEUE with IFF_ATTACH_QUEUE,
which always passes skip_filter = false:

tun_set_iff() / tun_set_queue()
  tun_attach()
    sk_attach_filter(&tun->fprog, sk)
      __get_filter()
        copy_from_user(prog->insns, fprog->filter, fsize)

That read goes through current->mm. The caller may be a different process
from the one that set the filter. It may also be the same process after
the instruction buffer was freed or remapped.

Before this patch, the rebuilt filter never ended up on a working queue.
When the re-attach succeeded, the queue was not published. When it failed,
the queue was published without a filter and TUNSETIFF returned 0.

With the check inverted, there are two cases.

If the address is not mapped in the caller, TUNSETIFF and TUNSETQUEUE
now fail with -EFAULT. If the bytes there are not valid classic BPF, they
fail with -EINVAL. Does this mean a new opener of a persistent TAP with a
filter can no longer attach unless it passes IFF_NOFILTER?

If the address happens to be mapped, whatever bytes it holds become the
queue's filter, not the program the administrator installed. On a
multiqueue TAP, could different queues end up with different filters?

For this re-attach to work correctly, would it need a kernel-owned copy?
That could be a saved copy of the instructions, or a refcounted struct
bpf_prog or sk_filter.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260923025653.59348-1-clementwei90%40163.com
