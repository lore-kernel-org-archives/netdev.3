Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793065327;
	b=zJPv1CXbqCZwKEyY3N4LBmL1Izh7TdJLUpsoh2EEZoJ6+px6OSYcf1OxJPMeH3BdoEsb
	 7q1ub/1H/i+mgs38IdIyzzsz5G0JiVwxvwtwgpV6aLUg+pL2TFXFPPMYkz5aAmMZGht8p
	 nAyI6s5UR11lCcHg09k08JdMxyIb+yS+qxlGfxpBuFgQ/XeghHoRw7g4zXjqhbhmVWT4w
	 MaBtjDArMXCPsu9+mkzm4bk4qxg+dxfZpC7vstYQ9t25TB4L+xIaZGf9w3AHFHyIu0coW
	 BB2DURC6HowRoE7U+PcNw2/h4Oo7lAUSu0uev4+4AtPTc1/uMo8Q4NSlgrhc0YjPlpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793065327;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=PxhKt4ewbW887pppfVDxKOmckuc+6YqylYK09wMwPvI=;
	b=DDFjHitmOxQpYzhsxb4p5BI3+4F/PXj4XdlhwHzBZEk/R4e5JxFGroI/f3jhj4JcfJrK
	 mJEORBl2IWaXe1TTWzMeb+PEsWt06Peppz0487WwokNJFJN49VLIfQ4jyFA9aaFF5zxne
	 VZAZiuHWaEzHxKtyVZMV9oQndzvbEwTtCp2GykX7zIsZ/QCQH5p3jE0JvOadiYygotE7x
	 9Tzme0RnxjVZ/bSTv+tA+jzy6Y9KEZSAHtf2tnm9CzwwphRIgVEeEoEnletyX0gLV6puc
	 LlYYhgUkw4ooxkthMOGMPrlvo261Zl0iK31EY/0T+owOlnGv8+6A2Sz5v1uknii5Nhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b="g/knnsl9";
	arc=none smtp.remote-ip=209.85.215.197
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8363606A322
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 01:42:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8363606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=g/knnsl9
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cd6969473a4so2135093a12.0
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 18:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793065326; x=1793670126; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PxhKt4ewbW887pppfVDxKOmckuc+6YqylYK09wMwPvI=;
        b=g/knnsl9kYCBewBGyHtxjeHICS2L5Hw2DX0ijDDaApZ9CtRSJQb0PUvpWyfuQm6QKD
         u1UZXxnLQKcUxB9pelvME0T/DlAsnUI+BAJ2zdQNewrqRxvVjMdIXLao3KvVgt49MU1/
         2YvLfXRoAGImmM54FcAQDb335sU6X1Ui6kfv64hTrLch1yPWyrD98rNbaJcSqNzYTnqi
         LW4aEtMi087jzeXNqTicPKEBAfwOGWGFdXHEsmeaY6IfQ3GwSS6Wtqna3nqMyeSP5Wb9
         ppr1c/F305tfTNV6G86eNtFrWjySieAu8zAUrxzjctjvCI87LUjBkUBxQ9LrHTZtybn4
         1Vqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793065326; x=1793670126;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PxhKt4ewbW887pppfVDxKOmckuc+6YqylYK09wMwPvI=;
        b=EblZ83Sd8pLbBvkkE3I24hq4HTzFoBcM4CpwlvJgIY8TxCN7RDqX+OB0Sz9YgQIfeX
         I/eiindRtqNdEhXxdIuc2v7fQgUVpSepkG3iR4oKf7QyVe+fuiQT4WhFZ0ChKb1GMTRX
         9wWxaW5j/ywDo6dJly3JRHKCk3Xcl6oFFwGgH8yCvWpDZfWJ2OJ/mL5u+WJmU5xDBki7
         d8uY42xMb8nnsGkjiuI7aP26Twq1IhP6RwdpJAF6PXR47vL492VIp/Vu0e5Xf+M8qffl
         B3c/3s69OQvpxiZDzHDKkqbqMNgAAnt74Ziuk5YpSrdFmF6hjkUZOX9lPdMTJVeVl3O2
         Ij5A==
X-Forwarded-Encrypted: i=1; AKwUvBzb6JBtlGaD+VG2qYCu2Jau2Oiy8qgew4dFMsvGSDKBzQCUgAAZ5wNFJoyyaH0dngMblM2NXdw=@vger.kernel.org
X-Gm-Message-State: AFq9FYIQerMZowthjfA9pkx9Nz54a4oGnKsuo0ZEsLR+dL6MZeGzSdbv
	x4DVqp7yeE7pylTpdsLo+/VTEKPfmayZ50gJBLuhtbMINb9Y1H7kQRjiqhEnRFpGKnsQc8b5C9W
	hOhvm2g==
X-Received: from pfff18.prod.google.com ([2002:a05:6a00:bd12:b0:8a2:1bc3:8884])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1f0e:b0:874:705d:f63d
 with SMTP id d2e1a72fcca58-8a368a9fde8mr6298199b3a.31.1793065325885; Mon, 26
 Oct 2026 18:42:05 -0700 (PDT)
Date: Tue, 27 Oct 2026 01:42:05 +0000
In-Reply-To: <tencent_287A56749EA8448A970F2715FFF29F334108@qq.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <tencent_287A56749EA8448A970F2715FFF29F334108@qq.com>
Message-ID: <auABC6uMYxXmPqtb@google.com>
Subject: Re: [PATCH net] af_unix: order MSG_PEEK references against garbage collection
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Yingjie Wang <1075151112@qq.com>
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, 22 Oct 2026 22:05:36 +0800, Yingjie Wang wrote:
> Commit e5b31d988a41 ("af_unix: Give up GC if MSG_PEEK intervened.")
> made unix_peek_fpl() invalidate unix_peek_seq when gc_in_progress is
> set.
> 
> scm_fp_dup() increments the received files' reference counts before
> unix_peek_fpl() checks that flag, while unix_gc() sets the flag before
> reading the same reference counts. The reference-count operations and
> flag accesses are relaxed. spin_lock() provides acquire ordering, but
> does not order the earlier flag store against the later file_count()
> loads.
> 
> On weakly ordered machines, GC can therefore miss the reference acquired
> by MSG_PEEK while MSG_PEEK misses gc_in_progress. unix_peek_seq then
> remains unchanged, allowing GC to classify an SCC as dead and purge a
> live receive queue.
> 
> Add smp_mb__after_atomic() after scm_fp_dup()'s reference increments and
> smp_mb__after_spinlock() before GC samples the reference counts. This
> ensures that either GC observes the new reference or MSG_PEEK observes
> the active GC and invalidates the seqcount.
> 
> LKMM admits the stale/stale outcome without these barriers and forbids it
> with them. An explicit AArch64 model gives the same result. The original
> workqueue layout in that commit also lacked the PEEK-side ordering, so the
> incomplete handshake dates to e5b31d988a41.
> 
> Fixes: e5b31d988a41 ("af_unix: Give up GC if MSG_PEEK intervened.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yingjie Wang <1075151112@qq.com>
> ---
>  net/unix/garbage.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/net/unix/garbage.c b/net/unix/garbage.c
> index da774f56ca648..c3ed00f52b04e 100644
> --- a/net/unix/garbage.c
> +++ b/net/unix/garbage.c
> @@ -329,6 +329,14 @@ void unix_peek_fpl(struct scm_fp_list *fpl)
>  	if (!fpl || !fpl->count_unix)
>  		return;
>  
> +	/*
> +	 * Pair with smp_mb__after_spinlock() in unix_gc(). get_file() in
> +	 * scm_fp_dup() increments an atomic reference count, so this ensures
> +	 * that either GC sees the new references or this thread sees
> +	 * gc_in_progress and invalidates unix_peek_seq.
> +	 */
> +	smp_mb__after_atomic();
> +

Thanks for the patch, and sorry for the late reply.

Actually there is another thread going on for this issue and
I suggested another aproach, so ...

pw-bot: cr



>  	if (!READ_ONCE(gc_in_progress))
>  		return;
>  
> @@ -614,6 +622,12 @@ static void unix_gc(struct work_struct *work)
>  	WRITE_ONCE(gc_in_progress, true);
>  
>  	spin_lock(&unix_gc_lock);
> +	/*
> +	 * Pair with smp_mb__after_atomic() in unix_peek_fpl() to ensure that
> +	 * either the file-count reads below see MSG_PEEK's increments or
> +	 * MSG_PEEK sees gc_in_progress.
> +	 */
> +	smp_mb__after_spinlock();
>  
>  	if (unix_graph_state == UNIX_GRAPH_NOT_CYCLIC) {
>  		spin_unlock(&unix_gc_lock);
> 
> base-commit: f4377bf85887f57b59abb5479f7660a81ffe4449
> -- 
> 2.43.0
> 
