Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793238412;
	b=MntpStnEDY1p2JR5EP2xsqfb9IETrBU1ubkrRMxf/YkavyYSS1wmQOkm+qkQx0Q6BR4k
	 VzNzvVcQHYX+/zpZvg0YMKEqHuCb49mAgJx1/sxADu9byqnxm91ckQzF3+bqmSEzxzZ7w
	 Ce52fm3S1ksyOJNSZokatUij8JH+B4vg1rZwjcMOEL/xHnoixSJ1W9iGAQn4fJ67fqVYd
	 dtjesHXq6b/jCXu8252J2d/Lqe/4bgXiKG+RllYpfL/JYZmNd8H2VBvqEwzhFXGdiR0Ch
	 QGTfxXzlMHD4L3FH0jPDPyTjOVaMuP6/LF3KELWqliV6c2J4bYWFh5eU37U1b9zymig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793238412;
	h=DMARC-Filter:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo;
	bh=/DFFyL9atwd2XPn+ecGOBzUsLUVUm/XOwLPyVN9YT1c=;
	b=Ll1hatPahmyUR+tzj1pmfxRrmw1Oms56VgQQqjJQ6npu3W9KPnHQXxomj6yChO05VapW
	 ADsAVwb1LY5IzTzhEw7e7u4qgjfSof8wE6cs0AQ4Ke5UMHCUmwvTvuH6j+S6V2NG5bGWR
	 +TdcSQfzXUTml7N2FtkCQ14Ju0hdXEjFWY4XBpq1Q6CXaTMl788mIDX+Pj2kDOp8/wxYU
	 voslQqKaqyuiMj+bPzi43lPTbMRhLewukIfg9db+dRYYDHv05b+pghuabCHZddbaDXddm
	 Yr8b3YHFgh3eAFg9302BtoVgaX6TVkO4bKLf9OX1eLQJBKGBmOvEBsMpe8wj32aRWwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b="Sn5dM/FL";
	arc=none smtp.remote-ip=220.197.31.4
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CADB606A31A
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 01:46:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0CADB606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Sn5dM/FL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=/DFFyL9atwd2XPn+ecGOBzUsLUVUm/XOwLPyVN9YT1c=;
	b=Sn5dM/FLPmuv4eXxuj8Xidf9orpX3tGeKCfvXOlPiYhPGMzdwnceR6ZIsfhxjy
	r67Y+7CB732spYUiy7OXy2CP5ARdcFsKzGGOXAr0wmNdcReAev6JCTTov1pp6f/P
	dbm53TOtRtau6aL6ImgHlkCXbP/hSafE9bz7Tdo5kRqfQ=
Message-ID: <5f3ce099-1074-4416-b758-276aa9112bc3@163.com>
Date: Thu, 29 Oct 2026 09:46:23 +0800
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v8 1/2] tun: keep a kernel copy of the socket filter
 program
Content-Language: en-US
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
Cc: jasowangio@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, Rongguang Wei <weirongguang@kylinos.cn>
References: <20261028093235.148649-1-clementwei90@163.com>
 <20261028093235.148649-2-clementwei90@163.com>
 <willemdebruijn.kernel.32a846b2c565b@gmail.com>
From: Rongguang Wei <clementwei90@163.com>
In-Reply-To: <willemdebruijn.kernel.32a846b2c565b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD3P2VvpeJqUTmVDA--.20677S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3trWxXw4DtrWUCr4kury3Jwb_yoWDKFWxpF
	W5Wa15tr1UWF1IgwnIvF48AFySqwn7Xr1UuryrGa45uF1qgr1fC3yjgrW5u3ZrAr4kCa10
	vF1UK3sxWwn8AFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UfxhJUUUUU=
X-CM-SenderInfo: 5fohzv5qwzvxizq6il2tof0z/xtbC-hHYRGripXGLpwAA3D



Willem de Bruijn wrote:
> Rongguang Wei wrote:
>> From: Rongguang Wei <weirongguang@kylinos.cn>
>>
>> TUNATTACHFILTER copies only the sock_fprog header, so tun->fprog.filter
>> stays a pointer into the address space of the process that issued the
>> ioctl. tun_attach() reads it again whenever a queue is attached to the
>> persistent device later on.
>>
>> Rebuilding the filter from that pointer is not reliable. With the inverted
>> check below, a failure of the attach was not fatal: -EFAULT for an unmapped
>> address, -EINVAL for bytes that are not a valid classic BPF program, -EPERM
>> for a locked filter and -ENOMEM all ended up in "err = 0" for a new tfile,
>> so the queue was attached without a filter. And when the read succeeded,
>> the early return meant the queue was never published at all.
>>
>> Keep the program in the kernel instead: tun->fprog_kern holds the
>> instructions, and each queue gets its own program built from it with the
>> new sk_attach_filter_kern(), the kernel memory counterpart of
>> sk_attach_filter(). The copy is freed when the filter is detached or
>> replaced and with the device, and tun->fprog is left untouched so
>> TUNGETFILTER keeps its uapi behaviour.
>>
>> Also fix the inverted check, which made tun_attach() return early when
>> sk_attach_filter_kern() succeeded instead of when it failed. Neither change
>> works on its own: with only the kernel copy, every re-attach returns 0
>> without publishing the queue; with only the check fixed, a re-attach that
>> used to succeed without installing a filter would start to fail.
>>
>> sk_attach_filter_kern() builds the program with bpf_prog_create(), which
>> does not keep an original program, so SO_GET_FILTER returns -EACCES and
>> sock_diag omits the filter for sockets that use it. tun sockets are not
>> exposed as file descriptors, so this is not user visible.
>>
>> The header and the instructions are checked in tun_copy_filter() before
>> anything is replaced: a TUNATTACHFILTER that the classic verifier rejects
>> now fails early and leaves the previously attached filter in place. The
>> instructions are verified with the new bpf_prog_validate_classic(), which
>> runs bpf_check_basics_ok() and bpf_check_classic() on the copied program.
>> That does not cover the s16 check in bpf_convert_filter() or the runtime
>> selection in bpf_prog_select_runtime(), so a program can still be refused
>> when it is built for a queue. Such a late failure does not replace the
>> saved program: the copy is committed to tun->fprog and tun->fprog_kern
>> only after tun_attach_filter() installed it on every queue. A queue that
>> already took the copy is rolled back, which leaves it without a filter,
>> because the program it ran before was already released; restoring it
>> would need an extra reference per queue.
>>
>> The inverted check was discovered by manual code inspection first.
>>
>> Fixes: 54f968d6efdb ("tuntap: move socket to tun_file")
>> Link: https://lore.kernel.org/netdev/179309578401.3134.11519975030981154705@kernel.org/
>> Signed-off-by: Rongguang Wei <weirongguang@kylinos.cn>
>> ---
>>  drivers/net/tun.c      | 125 +++++++++++++++++++++++++++++++++++++----
>>  include/linux/filter.h |   2 +
>>  net/core/filter.c      |  67 ++++++++++++++++++++++
>>  3 files changed, 182 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
>> index 242899f7fd071..13ce62aa0f142 100644
>> --- a/drivers/net/tun.c
>> +++ b/drivers/net/tun.c
>> @@ -197,6 +197,7 @@ struct tun_struct {
>>  	int			sndbuf;
>>  	struct tap_filter	txflt;
>>  	struct sock_fprog	fprog;
>> +	struct sock_fprog_kern	fprog_kern;
>>  	/* protected by rtnl lock */
>>  	bool			filter_attached;
>>  	u32			msg_enable;
>> @@ -722,12 +723,67 @@ static void tun_force_wake_queue(struct tun_struct *tun,
>>  	spin_unlock_bh(&tfile->tx_ring.consumer_lock);
>>  }
>>  
>> +/* Copy the filter that @argp points at into the kernel, so that it can be
>> + * installed again later, independent of the ioctl caller's address space.
>> + * @fprog_kern receives the copy, which belongs to the caller until it is
>> + * installed or freed, and @fprog receives the header, with the user pointer
>> + * kept for TUNGETFILTER.
>> + */
>> +static int tun_copy_filter(struct sock_fprog __user *argp,
>> +			   struct sock_fprog *fprog,
>> +			   struct sock_fprog_kern *fprog_kern)
>> +{
>> +	struct sock_fprog fp;
>> +	struct sock_filter *insns;
>> +	int err;
>> +
>> +	if (copy_from_user(&fp, argp, sizeof(fp)))
>> +		return -EFAULT;
>> +
>> +	if (!fp.len || fp.len > BPF_MAXINSNS)
>> +		return -EINVAL;
>> +
>> +	insns = kmalloc_array(fp.len, sizeof(struct sock_filter),
>> +			      GFP_KERNEL_ACCOUNT);
>> +	if (!insns)
>> +		return -ENOMEM;
>> +
>> +	if (copy_from_user(insns, fp.filter,
>> +			   fp.len * sizeof(struct sock_filter))) {
>> +		kfree(insns);
>> +		return -EFAULT;
>> +	}
>> +
>> +	/* The instructions are only verified when a program is built from
>> +	 * them, which happens when the filter is attached to a socket. Run
>> +	 * the classic verifier here as well, so that a bad program is
>> +	 * refused before it is saved and before any queue is touched.
>> +	 * bpf_prog_create() can still refuse the program later, when it is
>> +	 * converted to eBPF or when no runtime can be selected for it; the
>> +	 * attach path returns that error, and the saved program is not
>> +	 * replaced.
>> +	 */
>> +	err = bpf_prog_validate_classic(insns, fp.len);
>> +	if (err) {
>> +		kfree(insns);
>> +		return err;
>> +	}
>> +
>> +	fprog->len = fp.len;
>> +	fprog->filter = fp.filter;
>> +	fprog_kern->len = fp.len;
>> +	fprog_kern->filter = insns;
>> +
>> +	return 0;
>> +}
>> +
>>  static int tun_attach(struct tun_struct *tun, struct file *file,
>>  		      bool skip_filter, bool napi, bool napi_frags,
>>  		      bool publish_tun)
>>  {
>>  	struct tun_file *tfile = file->private_data;
>>  	struct net_device *dev = tun->dev;
>> +	bool rollback_filter = false;
>>  	int err;
>>  
>>  	err = security_tun_dev_attach(tfile->socket.sk, tun->security);
>> @@ -752,10 +808,11 @@ static int tun_attach(struct tun_struct *tun, struct file *file,
>>  	/* Re-attach the filter to persist device */
>>  	if (!skip_filter && (tun->filter_attached == true)) {
>>  		lock_sock(tfile->socket.sk);
>> -		err = sk_attach_filter(&tun->fprog, tfile->socket.sk);
>> +		err = sk_attach_filter_kern(&tun->fprog_kern, tfile->socket.sk);
>>  		release_sock(tfile->socket.sk);
>> -		if (!err)
>> +		if (err)
>>  			goto out;
>> +		rollback_filter = true;
>>  	}
>>  
>>  	if (!tfile->detached &&
>> @@ -817,6 +874,17 @@ static int tun_attach(struct tun_struct *tun, struct file *file,
>>  	WRITE_ONCE(tun->numqueues, tun->numqueues + 1);
>>  	tun_set_real_num_queues(tun);
>>  out:
>> +	if (err && rollback_filter) {
>> +		/* The filter was installed before the rest of the attach
>> +		 * ran, so drop it again if a later step failed. Any
>> +		 * program it replaced is already gone: this leaves the
>> +		 * queue without a filter rather than restoring the
>> +		 * previous one.
>> +		 */
>> +		lock_sock(tfile->socket.sk);
>> +		sk_detach_filter(tfile->socket.sk);
>> +		release_sock(tfile->socket.sk);
>> +	}
>>  	return err;
>>  }
>>  
>> @@ -2400,6 +2468,7 @@ static void tun_free_netdev(struct net_device *dev)
>>  	security_tun_dev_free_security(tun->security);
>>  	__tun_set_ebpf(tun, &tun->steering_prog, NULL);
>>  	__tun_set_ebpf(tun, &tun->filter_prog, NULL);
>> +	kfree(tun->fprog_kern.filter);
>>  }
>>  
>>  static void tun_setup(struct net_device *dev)
>> @@ -3064,10 +3133,14 @@ static void tun_detach_filter(struct tun_struct *tun, int n)
>>  		release_sock(tfile->socket.sk);
>>  	}
>>  
>> +	kfree(tun->fprog_kern.filter);
>> +	tun->fprog_kern.filter = NULL;
>> +	tun->fprog_kern.len = 0;
>>  	tun->filter_attached = false;
>>  }
>>  
>> -static int tun_attach_filter(struct tun_struct *tun)
>> +static int tun_attach_filter(struct tun_struct *tun,
>> +			     struct sock_fprog_kern *fprog_kern)
>>  {
>>  	int i, ret = 0;
>>  	struct tun_file *tfile;
>> @@ -3075,15 +3148,29 @@ static int tun_attach_filter(struct tun_struct *tun)
>>  	for (i = 0; i < tun->numqueues; i++) {
>>  		tfile = rtnl_dereference(tun->tfiles[i]);
>>  		lock_sock(tfile->socket.sk);
>> -		ret = sk_attach_filter(&tun->fprog, tfile->socket.sk);
>> +		ret = sk_attach_filter_kern(fprog_kern, tfile->socket.sk);
>>  		release_sock(tfile->socket.sk);
>> -		if (ret) {
>> -			tun_detach_filter(tun, i);
>> -			return ret;
>> -		}
>> +		if (ret)
>> +			goto out_detach;
>>  	}
>>  
>>  	tun->filter_attached = true;
>> +	return 0;
>> +
>> +out_detach:
>> +	/* Drop the copies already installed on queues 0..i-1, which leaves
>> +	 * them without a filter: their previous sk_filter, if any, was
>> +	 * already replaced and released. The caller does not replace the
>> +	 * saved program when this fails, so tun->fprog, tun->fprog_kern and
>> +	 * filter_attached keep their previous values.
>> +	 */
>> +	while (i--) {
>> +		tfile = rtnl_dereference(tun->tfiles[i]);
>> +		lock_sock(tfile->socket.sk);
>> +		sk_detach_filter(tfile->socket.sk);
>> +		release_sock(tfile->socket.sk);
>> +	}
>> +
>>  	return ret;
>>  }
>>  
>> @@ -3418,17 +3505,31 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
>>  		tun_set_sndbuf(tun);
>>  		break;
>>  
>> -	case TUNATTACHFILTER:
>> +	case TUNATTACHFILTER: {
>> +		struct sock_fprog_kern fprog_kern;
>> +		struct sock_fprog fprog;
>> +
>>  		/* Can be set only for TAPs */
>>  		ret = -EINVAL;
>>  		if ((tun->flags & TUN_TYPE_MASK) != IFF_TAP)
>>  			break;
>> -		ret = -EFAULT;
>> -		if (copy_from_user(&tun->fprog, argp, sizeof(tun->fprog)))
>> +
>> +		ret = tun_copy_filter(argp, &fprog, &fprog_kern);
>> +		if (ret)
>> +			break;
>> +
>> +		ret = tun_attach_filter(tun, &fprog_kern);
>> +		if (ret) {
>> +			kfree(fprog_kern.filter);
>>  			break;
>> +		}
>>  
>> -		ret = tun_attach_filter(tun);
>> +		/* Install the copy only after every queue accepted it. */
>> +		kfree(tun->fprog_kern.filter);
>> +		tun->fprog_kern = fprog_kern;
>> +		tun->fprog = fprog;
> 
>     struct sock_fprog has padding between @len and @filter (6 bytes on
>     64-bit). Because @fprog is uninitialized on the stack and
>     tun_copy_filter() only writes its two fields, `tun->fprog = fprog` can
>     copy uninitialized kernel stack bytes into tun->fprog, which
>     TUNGETFILTER then leaks to userspace via copy_to_user(...,
>     sizeof(tun->fprog)) when CONFIG_INIT_STACK_ALL_ZERO is not enabled
>     (KMSAN kernel-infoleak).
> 
>     Zero-initialize @fprog (e.g. `struct sock_fprog fprog = {};` or
>     memset() in tun_copy_filter()).
Thanks Willem.
In v9, the zero-initializes the caller's header in tun_copy_filter() before the
two fields are assigned:
	memset(fprog, 0, sizeof(*fprog));
so the padding that TUNGETFILTER copies is zero instead of uninitialized
stack. Everything else about the header is unchanged.

