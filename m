Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42321511E8C
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 14:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790863842; cv=none; b=blpjj+W5RP0F3VGXChVP0s5LukA3xPJ9p+r/ggJXvYxuijO1qw04sxiT7WMGsEL9+X3KB/4pWKptZKGbdGjIydDZXjbpXqn+aXS7F4mtGc5MMFlYg2jwNcxQs9BXdqiVtyZQmYBABjHCg+1BpbtUpf/EhryJGtceUaFaIEG4aZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790863842; c=relaxed/simple;
	bh=Hn/uAtBMcFK8vvZQM9H1HJomGdif2I72752dIIbRmFg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ASYRCZuC6RYYfhwjKWPC9WiddwG2J2WcuJvPDtkFiyyh9g3qfsobrrK20riWr72BCNP0UWDuLBg9h9xrJ4X76MMSx/HdsJK/290WKkrshzf8DGc6/KN5Nl8A291QaPfbdqeng+R25HukzHCFLFQ/sMdS6M02dvKqiRTQs7sYYho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kccL0OMA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kccL0OMA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7673C1F00898;
	Thu,  1 Oct 2026 14:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790863840;
	bh=EJ4P12cv7U54drcqGEnowQJKocgQ7sK/Zp/d55vftXg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kccL0OMAV3hbsiUgbe3s0BY0MS6QX9/JhXf18EVtekPfkf3Apr9bELW2dxtQlTTbw
	 r6yNMUGVMBzQvCBqgwlSBs/qy9jjarPiKliSk3f6JtvCky0WLWHjqdTWrZfjNgF8dO
	 14yrkGML1UZIaII74Z1lBJisCL0gYhbFnXsGZ0NXqRrEQCNIhIAmt1xw49PMZ+udc8
	 JP+mZxb8RCzw7eW3FTwxlbvL3fsKrsPDbLJLmee1rRAa2F7BGqhJJdiwaTkkdkGv/g
	 Z3bFSFxiM/uwdY0KcRY5vhEPc6iOzDrhp46oHxmf70oiQXsIyWD9tWtFJdUg3WEy9J
	 r4eAdnf9RzTGw==
Subject: Re: [PATCH net v3 2/3] tun: fix inverted error check when
 re-attaching the filter
From: netdev-bot+sashiko@kernel.org
To: clementwei90@163.com
Cc: netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com,
 jasowangio@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, weirongguang@kylinos.cn
Date: Thu, 01 Oct 2026 14:10:40 +0000
Message-ID: <179086384006.434549.3211680680874111813@kernel.org>
In-Reply-To: <20260930080746.135017-3-clementwei90@163.com>
References: <20260930080746.135017-3-clementwei90@163.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The series cannot be bisected, and the commit message only
  states the ordering constraint in one direction.

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but the TAP
  filter lifecycle treats disabled queues differently on detach and on…

--

tun: fix inverted error check when re-attaching the filter

This commit fixes the inverted error check after sk_attach_filter_kern()
in tun_attach(). Before the fix, a successful re-attach returned early and
the queue was never published in tun->tfiles[]. The patch also detaches
the filter again if a later step of tun_attach() fails.

Link: https://lore.kernel.org/netdev/179027275318.2160803.4185895144088175048@kernel.org/

> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 22fb34e745bd9..c796048742f9b 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c

[ ... ]

> @@ -783,8 +784,9 @@ static int tun_attach(struct tun_struct *tun, struct file *file,
>  		lock_sock(tfile->socket.sk);
>  		err = sk_attach_filter_kern(&tun->fprog_kern, tfile->socket.sk);
>  		release_sock(tfile->socket.sk);
> -		if (!err)
> +		if (err)
>  			goto out;

[Severity: Medium]
The commit message says:

    This has to come after the patch that keeps a kernel copy of the
    program: ...

Doesn't the dependency also run the other way?

At the baseline, tun_attach() called sk_attach_filter(&tun->fprog, ...),
which reads a stale user pointer. The inverted "if (!err) goto out" only
fired when that pointer was still mapped and held a valid program.

After "tun: keep a kernel copy of the socket filter program", the call is
sk_attach_filter_kern(&tun->fprog_kern, ...). That function works on a copy
that tun_attach_filter() has already validated. In practice it succeeds,
unless it hits -ENOMEM or SOCK_FILTER_LOCKED.

In that intermediate commit, every re-attach with tun->filter_attached set
would take goto out with err == 0. Both of these paths reach it:

  tun_set_iff()->tun_attach(tun, file, ifr->ifr_flags & IFF_NOFILTER, ...)
  tun_set_queue()->tun_attach(tun, file, false, ...)

TUNSETIFF, or TUNSETQUEUE with IFF_ATTACH_QUEUE, would return 0. The queue
would never show up in tun->tfiles[], and tfile->tun would not be
published.

This patch, the next one in the series, fixes that. However, both patches
carry the same Fixes: 54f968d6efdb tag, and neither one says it needs the
other.

The first patch looks like the standalone fix because it stops reading the
user pointer. If a backport takes only that patch, could re-attach break
for every TAP that has a filter?

Would it make sense to squash the two patches, or to note the dependency in
both commit messages?

> +		rollback_filter = true;
>  	}

[Severity: Medium]
This is a pre-existing issue and was not introduced by this patch. The TAP
filter lifecycle seems to treat disabled queues differently on detach and
on re-attach.

TUNDETACHFILTER only walks the active queues:

drivers/net/tun.c:__tun_chr_ioctl() {
    ...
	case TUNDETACHFILTER:
		...
		tun_detach_filter(tun, tun->numqueues);
    ...
}

drivers/net/tun.c:tun_detach_filter() {
    ...
	for (i = 0; i < n; i++) {
		tfile = rtnl_dereference(tun->tfiles[i]);
		lock_sock(tfile->socket.sk);
		sk_detach_filter(tfile->socket.sk);
		release_sock(tfile->socket.sk);
	}
    ...
}

For IFF_DETACH_QUEUE, __tun_detach() runs with clean == false. That path
calls tun_disable_queue() and tun_napi_disable() but never
sk_detach_filter(), so a tfile parked on tun->disabled keeps its
sk_filter.

tun_attach() only touches the filter when tun->filter_attached is true. It
never clears a leftover filter.

Consider this sequence on a multiqueue TAP:

  TUNATTACHFILTER           (queue Q is active and gets the filter)
  IFF_DETACH_QUEUE on Q     (Q moves to tun->disabled, filter kept)
  TUNDETACHFILTER           (Q skipped, filter_attached = false)
  IFF_ATTACH_QUEUE on Q     (re-attach branch in tun_attach() skipped)

Would Q then be active with the old classic BPF filter still installed,
even though the device no longer has a filter? If so, packets on Q would
still be filtered or truncated.

The baseline behaves the same way here, so this patch does not change
it.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930080746.135017-1-clementwei90%40163.com
