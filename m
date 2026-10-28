Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793202848;
	b=e/jx85H6MM+7/rbojMuTvVFQm5tCA9Ouy5YNwp6vR++xpH/hsI5LaKZhYVzO76wprPop
	 DWbD0QtVds1ZA1TxcpoTPQtSLEs4ezyWJAD7woKy4W2gpzpy3gAhfnbCoufSl+RvX29GR
	 S/fQT5AMWzkd5dJDiQZ7GhYNKAggbv/X524d2zhpWCn9iuy1lkQX/syT0qgfrDVsLxkyi
	 FeBv/ShT4VYjuYBK+OcneiA3RHStwuG6iCIA96EFq7/ETOMz9+Avn8YByp5cdcDBzXBzj
	 GjrfOKjB5fI5vBqMQtTqB+2K+bB7g8wDPer7oMsSccgWBGM2YrUraSGK5I16O7OIKLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793202848;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=O9u+zw245djWn8p5UfKDPkEVTaUlfNEg26SGy48womQ=;
	b=umjRmvLn/hl4r75hyYUbh9uGP3wQewUD9TGbW3Fr7Z/R/Raqu8IP8WefIh01tce69TQV
	 Gd9g0A23nMqvN22gAhFAU/xlpg6hhouGGJ2KkC0JYgUjPsH9TwWYX/cSBMj+/N4N9ug2k
	 GsbsZPisb1K8yQeU60C/c9QuTbvVrlhW2yX5sbjyIybfwQoAQHBJCYMQ9S3IQCeK5whJw
	 K7Z47e0Zb/L/YUwGoAKpUTepiy3ptesYBfzh5LAB0tpxS6OQCw8XpU12hXM3HOLvAh7zv
	 TZe/jRaLQxu4ghakrI3idWbVrkFrkQANWk6+xLuAS7pzVma291rpfgpcYnLFDlmkBpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HbfWacY+;
	arc=none smtp.remote-ip=209.85.128.179
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31F4606A31E
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 15:54:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F31F4606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HbfWacY+
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-8ab37e44643so8240107b3.0
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 08:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793202847; x=1793807647; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=O9u+zw245djWn8p5UfKDPkEVTaUlfNEg26SGy48womQ=;
        b=HbfWacY+jgcZGyyI5yuc56az5unWtkL68dZb7NlhP/va+Z7jXT//17ZPhrS55mmBXB
         jEe7DG0qGinh8IWWQveqe4lCpsrW32Xyys2hv8dlVTRYyrxv6SqhTJmwiLoTkwc1rLvT
         uVUpLf9Jtz475wGSCU+S0XdYoxiQU4skkEI447dRysSi9t5f7u6GnGcY3+MzHaYOKKUR
         B8bCb9bt7rApgcgk2ufJ+3Vx6LNKQufHcpfNt2+ubUPGD4syagZeawXexbNPpP3zfdRX
         +yhg5/p1t5TJY8FRQsFrkGA2F5DfPqo2fO1Wr3MCqT3AkmrxoAj9Pz8ZgDArx9U6ZQ4T
         44kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793202847; x=1793807647;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O9u+zw245djWn8p5UfKDPkEVTaUlfNEg26SGy48womQ=;
        b=THELOUJ13LlHUAxX+Cw4brr4RPjUvgSxb+XVF0tx/KgVsjmrpVsIkc1L5yvtY7d+J/
         6FbH0YiEVz487ZzHjtYzeMtegAuM2DrGXlsvAzNGaPnGHE76rKg+Ljya5WfiiCa+0wi3
         ylJMuEP0PVRwqiFgFHoE0dMmWOfbntnDUGDFuj1EK0PfdNrHXFTYM0tfGkpbQf4lBiTQ
         +3QUuOFfKHsMwTLZZA+uLuuRdceSF3FO2kq6IRu7G0SVjNhgwjXybZlI9WFBRXr+c9FY
         v1Wpc7G6J8jkz2cmkrfocdjs8zV/58kqGlUXCgk7qL9JRraA21mT7azwXkDDOh4A8fg8
         T3YA==
X-Forwarded-Encrypted: i=1; AKwUvByf03LOgJ8+at6ARHmiM8BWjw/ur5iwwQXg+4r7El//jNI0glnBteexi8vbMYhd7hTZagYdwhI=@vger.kernel.org
X-Gm-Message-State: AFq9FYINpGO4Iz+1p4NzOTy4F9+TL+IrYRdKQMw9m0qlh6nfHEEoMXJL
	DRgv7UAZdzFbYvKBqJ52FKIzSidW8l2ecijZ5G9Krr48ssJXOy4DM1Zc
X-Gm-Gg: AYBFou1t1AipK7BqOVnTYM9abs5o8Df9M/gMkkieJg3vWPU6wjr6UvOXELK+8ABUmuV
	iMwaR7ov2qJ/8QsS1k1QXehF/vTH+2+sNVmTOmAWMhXr0xCKGn4BWjTIfQOGCVxSDxCY1HiQzD4
	/ukGYGOYzD2g79T/BcaKgnjbOGI7/lcWa5LA07Ta9BtKDsPiZbqx2OY2Pz943FtrUR64HZfPXnN
	/Xc5yeDPx5qYqIb9kU7UxkmmJW4DQMX7r99hyM2mq+tyFGa6MGcffayHUapASIkt1B9RgkFVkna
	lyRazKMurIqRa5BKKaOEHI8qm43WFtA5Gr/AJlicn2nHffTaH0aDZ+Nt5kSlCwktKbowed93Rd1
	mTXfWCIbZwTitAfaZE7UfLAkfVCjn4aVc55TVc2uzQ1k92Fb8VBEhxaax7//JKTt2h6dMUq+MQg
	z1hriEycckewEy2N9HSKrmXs6xQXB7EsimjrwPMvvVbWoXsyjjOwqW+Do0KvSaNSdjw8uIDZGQF
	eFYtWRUVYRkUXX+GTkGTlymzmZ3VVUTpLAI54ot0BOHHxwSSzmugtmPny0SPL9S7NLcHIk+O91X
	7yjU3EdiEUSQkj4PsDf1Nqw5hqC+NidPI359BOHAZPwenY8iL/bRAQlnvmdwarxr+HZ8KeZEtAO
	k2unB5c1ObbV4b8FoOk8ez1sLj1YXNXZv7L1uDkQR+3Oy8UJnxuU/sr6/rsf/UxeNGRuH
X-Received: by 2002:a05:690c:314:b0:8b1:bc81:6ffe with SMTP id 00721157ae682-8b1bc81771cmr11698417b3.94.1793202846831;
        Wed, 28 Oct 2026 08:54:06 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b19e636170sm29905627b3.42.2026.10.28.08.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 08:54:05 -0700 (PDT)
Date: Wed, 28 Oct 2026 11:54:04 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Rongguang Wei <clementwei90@163.com>, 
 netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, 
 jasowangio@gmail.com, 
 andrew+netdev@lunn.ch, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 Rongguang Wei <weirongguang@kylinos.cn>
Message-ID: <willemdebruijn.kernel.32a846b2c565b@gmail.com>
In-Reply-To: <20261028093235.148649-2-clementwei90@163.com>
References: <20261028093235.148649-1-clementwei90@163.com>
 <20261028093235.148649-2-clementwei90@163.com>
Subject: Re: [PATCH net v8 1/2] tun: keep a kernel copy of the socket filter
 program
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Rongguang Wei wrote:
> From: Rongguang Wei <weirongguang@kylinos.cn>
> 
> TUNATTACHFILTER copies only the sock_fprog header, so tun->fprog.filter
> stays a pointer into the address space of the process that issued the
> ioctl. tun_attach() reads it again whenever a queue is attached to the
> persistent device later on.
> 
> Rebuilding the filter from that pointer is not reliable. With the inverted
> check below, a failure of the attach was not fatal: -EFAULT for an unmapped
> address, -EINVAL for bytes that are not a valid classic BPF program, -EPERM
> for a locked filter and -ENOMEM all ended up in "err = 0" for a new tfile,
> so the queue was attached without a filter. And when the read succeeded,
> the early return meant the queue was never published at all.
> 
> Keep the program in the kernel instead: tun->fprog_kern holds the
> instructions, and each queue gets its own program built from it with the
> new sk_attach_filter_kern(), the kernel memory counterpart of
> sk_attach_filter(). The copy is freed when the filter is detached or
> replaced and with the device, and tun->fprog is left untouched so
> TUNGETFILTER keeps its uapi behaviour.
> 
> Also fix the inverted check, which made tun_attach() return early when
> sk_attach_filter_kern() succeeded instead of when it failed. Neither change
> works on its own: with only the kernel copy, every re-attach returns 0
> without publishing the queue; with only the check fixed, a re-attach that
> used to succeed without installing a filter would start to fail.
> 
> sk_attach_filter_kern() builds the program with bpf_prog_create(), which
> does not keep an original program, so SO_GET_FILTER returns -EACCES and
> sock_diag omits the filter for sockets that use it. tun sockets are not
> exposed as file descriptors, so this is not user visible.
> 
> The header and the instructions are checked in tun_copy_filter() before
> anything is replaced: a TUNATTACHFILTER that the classic verifier rejects
> now fails early and leaves the previously attached filter in place. The
> instructions are verified with the new bpf_prog_validate_classic(), which
> runs bpf_check_basics_ok() and bpf_check_classic() on the copied program.
> That does not cover the s16 check in bpf_convert_filter() or the runtime
> selection in bpf_prog_select_runtime(), so a program can still be refused
> when it is built for a queue. Such a late failure does not replace the
> saved program: the copy is committed to tun->fprog and tun->fprog_kern
> only after tun_attach_filter() installed it on every queue. A queue that
> already took the copy is rolled back, which leaves it without a filter,
> because the program it ran before was already released; restoring it
> would need an extra reference per queue.
> 
> The inverted check was discovered by manual code inspection first.
> 
> Fixes: 54f968d6efdb ("tuntap: move socket to tun_file")
> Link: https://lore.kernel.org/netdev/179309578401.3134.11519975030981154705@kernel.org/
> Signed-off-by: Rongguang Wei <weirongguang@kylinos.cn>
> ---
>  drivers/net/tun.c      | 125 +++++++++++++++++++++++++++++++++++++----
>  include/linux/filter.h |   2 +
>  net/core/filter.c      |  67 ++++++++++++++++++++++
>  3 files changed, 182 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 242899f7fd071..13ce62aa0f142 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -197,6 +197,7 @@ struct tun_struct {
>  	int			sndbuf;
>  	struct tap_filter	txflt;
>  	struct sock_fprog	fprog;
> +	struct sock_fprog_kern	fprog_kern;
>  	/* protected by rtnl lock */
>  	bool			filter_attached;
>  	u32			msg_enable;
> @@ -722,12 +723,67 @@ static void tun_force_wake_queue(struct tun_struct *tun,
>  	spin_unlock_bh(&tfile->tx_ring.consumer_lock);
>  }
>  
> +/* Copy the filter that @argp points at into the kernel, so that it can be
> + * installed again later, independent of the ioctl caller's address space.
> + * @fprog_kern receives the copy, which belongs to the caller until it is
> + * installed or freed, and @fprog receives the header, with the user pointer
> + * kept for TUNGETFILTER.
> + */
> +static int tun_copy_filter(struct sock_fprog __user *argp,
> +			   struct sock_fprog *fprog,
> +			   struct sock_fprog_kern *fprog_kern)
> +{
> +	struct sock_fprog fp;
> +	struct sock_filter *insns;
> +	int err;
> +
> +	if (copy_from_user(&fp, argp, sizeof(fp)))
> +		return -EFAULT;
> +
> +	if (!fp.len || fp.len > BPF_MAXINSNS)
> +		return -EINVAL;
> +
> +	insns = kmalloc_array(fp.len, sizeof(struct sock_filter),
> +			      GFP_KERNEL_ACCOUNT);
> +	if (!insns)
> +		return -ENOMEM;
> +
> +	if (copy_from_user(insns, fp.filter,
> +			   fp.len * sizeof(struct sock_filter))) {
> +		kfree(insns);
> +		return -EFAULT;
> +	}
> +
> +	/* The instructions are only verified when a program is built from
> +	 * them, which happens when the filter is attached to a socket. Run
> +	 * the classic verifier here as well, so that a bad program is
> +	 * refused before it is saved and before any queue is touched.
> +	 * bpf_prog_create() can still refuse the program later, when it is
> +	 * converted to eBPF or when no runtime can be selected for it; the
> +	 * attach path returns that error, and the saved program is not
> +	 * replaced.
> +	 */
> +	err = bpf_prog_validate_classic(insns, fp.len);
> +	if (err) {
> +		kfree(insns);
> +		return err;
> +	}
> +
> +	fprog->len = fp.len;
> +	fprog->filter = fp.filter;
> +	fprog_kern->len = fp.len;
> +	fprog_kern->filter = insns;
> +
> +	return 0;
> +}
> +
>  static int tun_attach(struct tun_struct *tun, struct file *file,
>  		      bool skip_filter, bool napi, bool napi_frags,
>  		      bool publish_tun)
>  {
>  	struct tun_file *tfile = file->private_data;
>  	struct net_device *dev = tun->dev;
> +	bool rollback_filter = false;
>  	int err;
>  
>  	err = security_tun_dev_attach(tfile->socket.sk, tun->security);
> @@ -752,10 +808,11 @@ static int tun_attach(struct tun_struct *tun, struct file *file,
>  	/* Re-attach the filter to persist device */
>  	if (!skip_filter && (tun->filter_attached == true)) {
>  		lock_sock(tfile->socket.sk);
> -		err = sk_attach_filter(&tun->fprog, tfile->socket.sk);
> +		err = sk_attach_filter_kern(&tun->fprog_kern, tfile->socket.sk);
>  		release_sock(tfile->socket.sk);
> -		if (!err)
> +		if (err)
>  			goto out;
> +		rollback_filter = true;
>  	}
>  
>  	if (!tfile->detached &&
> @@ -817,6 +874,17 @@ static int tun_attach(struct tun_struct *tun, struct file *file,
>  	WRITE_ONCE(tun->numqueues, tun->numqueues + 1);
>  	tun_set_real_num_queues(tun);
>  out:
> +	if (err && rollback_filter) {
> +		/* The filter was installed before the rest of the attach
> +		 * ran, so drop it again if a later step failed. Any
> +		 * program it replaced is already gone: this leaves the
> +		 * queue without a filter rather than restoring the
> +		 * previous one.
> +		 */
> +		lock_sock(tfile->socket.sk);
> +		sk_detach_filter(tfile->socket.sk);
> +		release_sock(tfile->socket.sk);
> +	}
>  	return err;
>  }
>  
> @@ -2400,6 +2468,7 @@ static void tun_free_netdev(struct net_device *dev)
>  	security_tun_dev_free_security(tun->security);
>  	__tun_set_ebpf(tun, &tun->steering_prog, NULL);
>  	__tun_set_ebpf(tun, &tun->filter_prog, NULL);
> +	kfree(tun->fprog_kern.filter);
>  }
>  
>  static void tun_setup(struct net_device *dev)
> @@ -3064,10 +3133,14 @@ static void tun_detach_filter(struct tun_struct *tun, int n)
>  		release_sock(tfile->socket.sk);
>  	}
>  
> +	kfree(tun->fprog_kern.filter);
> +	tun->fprog_kern.filter = NULL;
> +	tun->fprog_kern.len = 0;
>  	tun->filter_attached = false;
>  }
>  
> -static int tun_attach_filter(struct tun_struct *tun)
> +static int tun_attach_filter(struct tun_struct *tun,
> +			     struct sock_fprog_kern *fprog_kern)
>  {
>  	int i, ret = 0;
>  	struct tun_file *tfile;
> @@ -3075,15 +3148,29 @@ static int tun_attach_filter(struct tun_struct *tun)
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
> +
>  	return ret;
>  }
>  
> @@ -3418,17 +3505,31 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
>  		tun_set_sndbuf(tun);
>  		break;
>  
> -	case TUNATTACHFILTER:
> +	case TUNATTACHFILTER: {
> +		struct sock_fprog_kern fprog_kern;
> +		struct sock_fprog fprog;
> +
>  		/* Can be set only for TAPs */
>  		ret = -EINVAL;
>  		if ((tun->flags & TUN_TYPE_MASK) != IFF_TAP)
>  			break;
> -		ret = -EFAULT;
> -		if (copy_from_user(&tun->fprog, argp, sizeof(tun->fprog)))
> +
> +		ret = tun_copy_filter(argp, &fprog, &fprog_kern);
> +		if (ret)
> +			break;
> +
> +		ret = tun_attach_filter(tun, &fprog_kern);
> +		if (ret) {
> +			kfree(fprog_kern.filter);
>  			break;
> +		}
>  
> -		ret = tun_attach_filter(tun);
> +		/* Install the copy only after every queue accepted it. */
> +		kfree(tun->fprog_kern.filter);
> +		tun->fprog_kern = fprog_kern;
> +		tun->fprog = fprog;

    struct sock_fprog has padding between @len and @filter (6 bytes on
    64-bit). Because @fprog is uninitialized on the stack and
    tun_copy_filter() only writes its two fields, `tun->fprog = fprog` can
    copy uninitialized kernel stack bytes into tun->fprog, which
    TUNGETFILTER then leaks to userspace via copy_to_user(...,
    sizeof(tun->fprog)) when CONFIG_INIT_STACK_ALL_ZERO is not enabled
    (KMSAN kernel-infoleak).

    Zero-initialize @fprog (e.g. `struct sock_fprog fprog = {};` or
    memset() in tun_copy_filter()).
