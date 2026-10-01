Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A87357CE8
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 04:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790829550; cv=none; b=UOFWjM4msCjq2V2VYMoCsmw41HSPTW7xO21ShKg2rmbN8/DU/G8YiXeL7+cGYq8K7RaOKTaGZt/eC2n608Q5zgKJ9NIcDliY3B8kplO3O7rmTeoSstYcnem1qbCIniK35Zuh7I/yQ10TFriOsgQkIpWmsQM0Q5sV2OFTbf5k5WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790829550; c=relaxed/simple;
	bh=RmmTiNdiyo0qF2Ob8dmnOOKxLKvQl92aoOppj6L2Tqk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K3eJHosLeeOigoT8ltEZ8KePVa6ECryI9w5CEUNu4SiTVflipLh86h0ec1RrDjFh0ftvcKqlrnPaoUHxoHSqralKaSZY1rBs6OTcdoKgrrnvIYdGEkGB8KpbSDWND5L/MP3ynvP8ecae8DyaCoJJAspEpfGhvdtOHny3NWbRh7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dBhcZxlq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dBhcZxlq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABD301F000FF;
	Thu,  1 Oct 2026 04:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790829549;
	bh=ktGm7RGm3ZRTOdVwurZD9HJS3dt8ff7ayAaZjDU1FAY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=dBhcZxlqabB4luw/d9dLvXL0VTp7aYpSCJbjXrhPlp9sQLR/0XRhPYJ63tryR+F7n
	 3xF+aFJn3LLazKYv6FJPrqchK1p4WJzc5nOAiv7T37pqofp82M2MBFrxtztHITkWbp
	 2o5V2G0OvmQWtjAhORsX+GF4/QV/sPPidilOW0hhUFPz6awLC2Nhf2esvJ8S5WjkPc
	 gSLWHnfk/HK3PoG2UMj1KFQYqHtb6s4U7W9v3uCUrvEX0YFtZvv5ujJiNN2tTSlOT5
	 8dirJ35vO4r8UGpEVhUev7AmUP6Y4xCtk7BXlMUwljfgfaq9Jq75jVbBZ6LteomiZk
	 qmdQaSaQJdctg==
Subject:
 Re: [PATCH v2 1/4] tun: fix inverted error check when re-attaching the filter
From: netdev-bot+sashiko@kernel.org
To: clementwei90@163.com
Cc: netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com,
 jasowangio@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, weirongguang@kylinos.cn
Date: Thu, 01 Oct 2026 04:39:08 +0000
Message-ID: <179082954820.434549.8088576077074233607@kernel.org>
In-Reply-To: <20260929093712.131096-2-clementwei90@163.com>
References: <20260929093712.131096-2-clementwei90@163.com>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] This patch un-inverts the check in tun_attach()
  (drivers/net/tun.c), so a failed filter re-attach now aborts TUNSETIFF…

--

tun: fix inverted error check when re-attaching the filter

This patch fixes the inverted sk_attach_filter() error check in
tun_attach(). Before, a successful filter re-attach returned early and the
queue was never published in tun->tfiles[]. Now a failed re-attach aborts
the attach, and the filter is detached again if a later step of
tun_attach() fails.

> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 5a302709a68aa..a2fffef3735fe 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c

[ ... ]

> @@ -754,8 +755,9 @@ static int tun_attach(struct tun_struct *tun, struct file *file,
>  		lock_sock(tfile->socket.sk);
>  		err = sk_attach_filter(&tun->fprog, tfile->socket.sk);
>  		release_sock(tfile->socket.sk);
> -		if (!err)
> +		if (err)
>  			goto out;
> +		rollback_filter = true;
>  	}

[Severity: Medium]
A failed re-attach is now fatal. Can that make TUNSETIFF, or TUNSETQUEUE
with IFF_ATTACH_QUEUE, fail on a persistent TAP that has a filter
attached?

tun->fprog only holds the {len, filter} header saved at TUNATTACHFILTER
time, and filter is still a __user pointer:

drivers/net/tun.c:__tun_chr_ioctl() {
    ...
		ret = -EFAULT;
		if (copy_from_user(&tun->fprog, argp, sizeof(tun->fprog)))
			break;
    ...
}

sk_attach_filter() then reads the instructions again, from the address
space of whichever task is doing the attach:

net/core/filter.c:__get_filter() {
    ...
	if (copy_from_user(prog->insns, fprog->filter, fsize))
    ...
}

Consider this sequence:

1. Process A issues TUNATTACHFILTER.
2. A exits or frees the buffer.
3. Process B issues TUNSETIFF (without IFF_NOFILTER) or IFF_ATTACH_QUEUE.

The copy in step 3 fails with -EFAULT, or the program fails validation
with -EINVAL, and the attach is aborted. Before this patch the attach went
ahead without a filter. If the stale address happens to be mapped in B,
the filter is built from whatever bytes are at that address.

tun_set_queue() always passes skip_filter=false, so IFF_ATTACH_QUEUE has
no way to opt out:

		ret = tun_attach(tun, file, false, tun->flags & IFF_NAPI,
				 tun->flags & IFF_NAPI_FRAGS, true);

A later patch in this series, "tun: keep a kernel copy of the socket
filter program", seems to fix this:

- At TUNATTACHFILTER time, tun_copy_filter() copies the instructions into
  tun->fprog_kern.
- tun_attach() and tun_attach_filter() switch to
  sk_attach_filter_kern(&tun->fprog_kern, ...).
- The selftest reattach_filter_without_user_buffer() covers this case.

Would it make sense to put that patch before this one? That way the
stale user pointer read is never fatal at any point in the series.

A smaller gap is still there at the end of the series. It predates this
patch. If TUNATTACHFILTER is issued from a detached queue fd while
numqueues is 0, tun_attach_filter() loops zero times. It then sets
filter_attached = true without running bpf_check_classic(). Later
attaches fail with -EINVAL until TUNDETACHFILTER is issued.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260929093712.131096-1-clementwei90%40163.com
