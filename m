Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793686879;
	b=WeCF2j3Q66fGu7pwuu7wXN8cTgMC4zf122duKWYiPuCOkw09fCFvqbzHBt8JIoPfUVE4
	 fX+7PkJSwatJZfPH5dib7vXKntfjWgkwfJ79QnJz8M642yFYJ/JmLjbEumZtX3b7Ak4v6
	 /8iX6tpZdQpLz+BRw7eCiFMxVb9YW9rNT1Oh5uGcp2SolxealRONIMY/Y6k+jwTHU3JCo
	 FAj6AqCjoXYAWNYrSnAjuo2SasftW/nPS972oyXSKam5vE3IZwhI/innhQHvSM/nEWVF6
	 cxwTXPLXHG2vTK9F1ibpWiC70BUYFmbC6zqEh4dJoKYj+vdYm7VTWvxfJJt5bBhOfWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793686879;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=AZMSs3FPtw+J5Gxe6EAeLlGkWcWvA9QshD+eDU9odgw=;
	b=DC4F66OFs0jAQxV/wi92paE4VNU4X3k5+ua6XC31/BKnwLIrLLDWB9E7RvkzYUWtiA0Y
	 3WnvT5MY0xa0X0T20BcO/7D5aVMJAYJpsE1L1UDUoVMlgYe3AEdV+1xk9QfWpFG2l6LQV
	 2rONEb5MLcdEc/OtZtLZ/PHqPa7eXRCXRJQ45tCEJUDBCJgkK5/Um6TFIONIO+i/prfRC
	 K35qx2zKmTcOe+F7TFnEHQMVg/1oj0N8fEtzEmihfkOBVRipRO/oE9ymmKGkeUIO2Q2ok
	 H/neRY/Zkxk7qfxate57oK3kBSQr/so+dcs3tj7p54EwYjamP9pQnq4NOGRf9/v/szg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hhf5W0l3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054C5606A332
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 06:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hhf5W0l3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FF8D1F000C1;
	Tue,  3 Nov 2026 06:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793686878;
	bh=AZMSs3FPtw+J5Gxe6EAeLlGkWcWvA9QshD+eDU9odgw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Hhf5W0l32qcFv/aSlFpHsnNpZeK53778awUobN3Qt4EVM0RPXBiU4/O++sjBvhEqs
	 1v/UyvK1AbCs/vZot9pIM2LkESZK2o0pYeXwcQiiB/y837rNHj38XsG/PcAjyrjCPP
	 hm/0H/ZoeyKjXbTSByvlg/B1GQTBcOisJEDdLHH1pfCuu4Y+wBxNBXIbffKVh/ze2V
	 n3PqOZ4WJsDREUC4CDNh84YqeZ45XivZgKKuCTTrOoglj6BBmagMEPTSU4lsuddqky
	 rjGXamcHB/4Lt53iUAC41K8yIBcmyi3hbwkLEYAlbxeLTu9ZS8M3vXXqCZwd5Fsahz
	 ntZ+sqULG0/fA==
Subject:
 Re: [PATCH net v9 1/2] tun: keep a kernel copy of the socket filter program
From: netdev-bot+sashiko@kernel.org
To: clementwei90@163.com
Cc: netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com,
 jasowangio@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, weirongguang@kylinos.cn
Date: Tue, 03 Nov 2026 06:21:17 +0000
Message-ID: <179368687768.488856.11634976425449992532@kernel.org>
In-Reply-To: <20261030060043.94719-2-clementwei90@163.com>
References: <20261030060043.94719-2-clementwei90@163.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 2 · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] A TUNATTACHFILTER that fails partway through leaves queues
  0..i-1 with no filter, while the device state still says the old…
- [Medium] With zero active queues, TUNATTACHFILTER saves a program that
  has never been built, so a program that bpf_prog_create() rejects is…

Pre-existing issues:
- [Low] TUNDETACHFILTER does not remove the filter from queues detached
  with IFF_DETACH_QUEUE.

--

tun: keep a kernel copy of the socket filter program

This keeps a kernel copy of the classic BPF program attached with
TUNATTACHFILTER in tun->fprog_kern, so that each queue builds its own
program with the new sk_attach_filter_kern(). It also fixes the inverted
error check in tun_attach(). Programs are now validated up front with the
new bpf_prog_validate_classic(), and the saved program is replaced only
after every queue has accepted the new one.

Link: https://lore.kernel.org/netdev/179027275318.2160803.4185895144088175048@kernel.org/

> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 439565a264ee7..c121ad50f31bb 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c

[ ... ]

> @@ -3070,10 +3141,14 @@ static void tun_detach_filter(struct tun_struct *tun, int n)
>  		release_sock(tfile->socket.sk);
>  	}
>  
> +	kfree(tun->fprog_kern.filter);
> +	tun->fprog_kern.filter = NULL;
> +	tun->fprog_kern.len = 0;
>  	tun->filter_attached = false;
>  }

[Severity: Low]
This isn't a bug introduced by this patch, but does TUNDETACHFILTER miss
queues that were detached with IFF_DETACH_QUEUE?

tun_detach_filter() only walks tun->tfiles[0..n-1], which are the active
queues, and then clears filter_attached. Queues on tun->disabled keep
their sk_filter, because __tun_detach(tfile, false) only calls
tun_disable_queue().

When such a queue comes back with IFF_ATTACH_QUEUE, tun_attach() only
touches the filter when filter_attached is true:

	if (!skip_filter && (tun->filter_attached == true)) {

Wouldn't the re-attached queue then keep running the program that was
removed? TUNGETIFF would also not report IFF_NOFILTER for that queue.

>  
> -static int tun_attach_filter(struct tun_struct *tun)
> +static int tun_attach_filter(struct tun_struct *tun,
> +			     struct sock_fprog_kern *fprog_kern)
>  {
>  	int i, ret = 0;
>  	struct tun_file *tfile;
> @@ -3081,15 +3156,29 @@ static int tun_attach_filter(struct tun_struct *tun)
>  	for (i = 0; i < tun->numqueues; i++) {
>  		tfile = rtnl_dereference(tun->tfiles[i]);
>  		lock_sock(tfile->socket.sk);
> -		ret = sk_attach_filter(&tun->fprog, tfile->socket.sk);
> +		ret = sk_attach_filter_kern(fprog_kern, tfile->socket.sk);
>  		release_sock(tfile->socket.sk);
> -		if (ret) {
> -			tun_detach_filter(tun, i);
> -			return ret;
> -		}
> +		if (ret)
> +			goto out_detach;
>  	}
>  
>  	tun->filter_attached = true;
> +	return 0;

[Severity: Medium]
What happens here when tun->numqueues is 0?

You can detach every queue of a multiqueue TAP with TUNSETQUEUE and
IFF_DETACH_QUEUE. __tun_detach(tfile, false) leaves tfile->tun set, so
TUNATTACHFILTER can still be issued on a disabled queue's fd.

In that case the loop never calls sk_attach_filter_kern(), so
bpf_prog_create() never sees the program. tun_copy_filter() only ran
bpf_prog_validate_classic(). That skips the s16 jump offset check in
bpf_convert_filter() and the runtime selection.

tun_attach_filter() still sets filter_attached and returns 0. The ioctl
then frees the previously saved program and commits the unbuilt one:

	kfree(tun->fprog_kern.filter);
	tun->fprog_kern = fprog_kern;
	tun->fprog = fprog;

Here is an example. Take a 4096 instruction program made of JA k=4094,
then 4094 x LDX|B|MSH k=0, then RET|K. It passes bpf_check_classic(). Each
LDX|B|MSH expands to roughly 18 eBPF instructions, so the converted JA
offset is far above S16_MAX, and bpf_convert_filter() returns -EINVAL.

Now that the inverted check in tun_attach() is fixed, wouldn't every
later IFF_ATTACH_QUEUE fail in sk_attach_filter_kern(&tun->fprog_kern,
...) until TUNDETACHFILTER is issued? The same goes for every TUNSETIFF
without IFF_NOFILTER.

The commit message says:

  Such a late failure does not replace the saved program: the copy is
  committed to tun->fprog and tun->fprog_kern only after
  tun_attach_filter() installed it on every queue.

That guarantee doesn't seem to hold when there are no active queues.

> +
> +out_detach:
> +	/* Drop the copies already installed on queues 0..i-1, which leaves
> +	 * them without a filter: their previous sk_filter, if any, was
> +	 * already replaced and released. The caller does not replace the
> +	 * saved program when this fails, so tun->fprog, tun->fprog_kern and
> +	 * filter_attached keep their previous values.
> +	 */
> +	while (i--) {
> +		tfile = rtnl_dereference(tun->tfiles[i]);
> +		lock_sock(tfile->socket.sk);
> +		sk_detach_filter(tfile->socket.sk);
> +		release_sock(tfile->socket.sk);
> +	}

[Severity: Medium]
Can this rollback leave the device in a self-contradictory state?

Suppose sk_attach_filter_kern() succeeds on queues 0..i-1 and then fails
on queue i. Each successful call already went through __sk_attach_prog(),
which released the old filter F through sk_filter_uncharge(). This loop
then clears sk_filter on queues 0..i-1, while queues i..n-1 keep F.

Before this patch, tun_detach_filter() ran here and cleared
filter_attached. Now filter_attached stays true, and the ioctl leaves
tun->fprog and tun->fprog_kern set to F. TUNGETFILTER reports F, and
tun_attach() installs F on queues attached later.

Queues 0..i-1, however, run no filter at all. tun_net_xmit() only filters
when sk_filter is set:

	if (tfile->socket.sk->sk_filter) {
		drop_reason = sk_filter_reason(tfile->socket.sk, skb);

TUNGETIFF also reports IFF_NOFILTER for those queues.

A bad program isn't needed to get here. Once validation has passed, queue
i can still fail with -ENOMEM from bpf_prog_alloc() (memcg charged) or
from kmalloc_obj() in __sk_attach_prog(). It can also fail when
__sk_filter_charge() would exceed optmem_max.

The comment here and the commit message say restoring the previous
program "would need an extra reference per queue". Since F's
instructions are still in tun->fprog_kern, couldn't the rollback rebuild
F with sk_attach_filter_kern(&tun->fprog_kern, sk) instead?

Another option is to build and charge all the new programs before
swapping any of them in, which would avoid this fail-open window.

> +
>  	return ret;
>  }

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261030060043.94719-1-clementwei90%40163.com
