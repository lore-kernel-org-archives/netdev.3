Received: from mail-ed2-f32.google.com (mail-ed2-f32.google.com [74.125.228.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909552AF1D
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 07:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790752073; cv=none; b=IOblkBms87EDcZvAlZMPhWa1lRqDSJauOt6PMTeqryAfz8kQvNnkANCbDYm67ylDevC8hYiIju/BNMy9bm7M1EGjseyCfMRHf/5lrIjcN48D2aWlqrZ5U/Q2UNTSaJVzkYMhOC+TKF/U1o6sTV8PRfjm9ZK6oHQogi6umiPUEsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790752073; c=relaxed/simple;
	bh=rtEvlpc5RFKwgsy5Faq1Dvca+J9Y2+1PDgdNAuQ81Ko=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oe9b8nDH5x/z/r+9mqQC991lOqpCRLwT2wzOk4iE+j2rq3KcJl38aAQYzqcQGOvNaZJpaiI64RO8ZH6f1tR9gsfkwky1wL5EjnXk5FaKAbklq+TnMtb+U0CwwcsbUUlPXad3TTs7qfDq/OwLKenUP1l4teNyH3/b8TVw1xT+80k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Szt92RVN; arc=none smtp.client-ip=74.125.228.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Szt92RVN"
Received: by mail-ed2-f32.google.com with SMTP id 4fb4d7f45d1cf-6ad186afdf4so1068575a12.0
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 00:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790752070; x=1791356870; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yPxo5oIesTw/2A8ukKykJpHFhPhcqo3C0UATOY1SYVs=;
        b=Szt92RVNxsQONHzDiByv/n6PzMGv6h4y6UjVPybFbLRgpjjr8QfsRew1uLr9hQLYxx
         v70iODpytwPPiZYybLrv13lZWJUfKQw07NWrpb+D7hNlOLrXmxPPFWiy1WUI9OceA/sK
         I25m64P9h0V38DW/pjKltS3kqj2FjuAo5ymbtKRxkG8XCSrYjUvotKHL2+yE3F9rKsjz
         Q3+0TLkQl8cLx+wRkjEesdTx9do2aCfAijl1cwDEibmvR8j9goP/sE1l+ksr3fFFp6AT
         NMdtazOwUg0Yw4UG/z79KEpHrmSYqR8lYQZNc4as5C53Cf9aSkDxPTbRJxJCL9HlEaCv
         Y7Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790752070; x=1791356870;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yPxo5oIesTw/2A8ukKykJpHFhPhcqo3C0UATOY1SYVs=;
        b=DSNV0Lcg6fPFr06NBSxe4MQHyK4dtRMbFql37eL9BDxhJ1saW2t2vWiNWHFeL5QMaY
         oEKUKwVfUCnlCeVZFotD6cpxSm+sR4PGKn71HILqi1lnkb9N9P8Y/n2PQYWMN8YKH38h
         G+SHQy0bpXH53yxw+9roWo0dsp6zX3STRvEnOBwsuLXgzWl4LfjzrST8TAJyPms/+wPM
         Lg+DGLQmCbpcBL1PvUmTckwb7/3obykmL29oBTn70Uq3NyCgiOLut1CzSosDAfcHGlbd
         XJ2rzvbRuIhh0jLZpT0t/JTQh3zulU35SMz8RZX/MN3ujVfdK0Rab6ek0WtAfjpGTHJv
         ZZXA==
X-Forwarded-Encrypted: i=1; AKwUvBzoJI93bcMFqGndGDYS+vo7LX1wKn4FHE0qrNFQlrj+xBMYWTOB39C0aH8iFQrJaycFUy9cZZ8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLNRLcepiFCyCth+Dy1MyRlwLpQjADWAL348+wBwYcxwROIMNCh
	VZbf5IB3ZPCJoLsM/pEh9Yjssz/pyuDGhnMSa03IbZqL0PeM9deYhYP7
X-Gm-Gg: AYBFou2y53GMQX94tqeJi8DrtTTxgS3ZGAXlO9tlqr9zkb7hFzIGKSGpmpc0Q1bdlNX
	AETWhD0HPHsy+Tv3hzgGTETvVtvpO6Oh2k/EBIkvn1/iAEVy2Xl/srNzfP27aO6LIEo5b0QBTXT
	q0+URRrvidfVJeMnqTdB44idQ/lMsBRm5ZNv/zTittWP+0bKMqHuatrQvPYRhbAhSsWG8OEdjaH
	6mCTJaDFzmTKPAE8Yoj8/WP5+VsR36qk51GVfT4m6eqSM1Jj+LwlOZOlialrvwhk0bftJC02fMC
	GM+vc3u75uFVLMxuFFdmcrwDEIBpatYEf/4utUS426U13Xt7WY/ziyJO9QIKEi3pwv1pY6SHjn5
	vNDCerjPfxsmjZxNAyiZ9I413fRCwgfm5cgw+cQYR50jPErEvJdKGz/UEvZc7KWcMirM/Vtpcao
	ml+fBVno8f09NQ8sGpBWWBtq5fwoz1PORzNz+BfIT0lodtV43innNnqI+9Yg==
X-Received: by 2002:a05:6402:4613:b0:6ae:160a:58a6 with SMTP id 4fb4d7f45d1cf-6ae19963b9cmr194812a12.36.1790752069491;
        Wed, 30 Sep 2026 00:07:49 -0700 (PDT)
Received: from krava ([173.38.220.48])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ae1558d9b5sm325750a12.17.2026.09.30.00.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 00:07:48 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 30 Sep 2026 09:07:47 +0200
To: Mark Brown <broonie@kernel.org>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Networking <netdev@vger.kernel.org>,
	Florent Revest <florent.revest@linux.dev>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the bpf-next tree with the bpf tree
Message-ID: <ary1Q48NrlD4i_Zf@krava>
References: <arvRs4KdojDnW1O6@sirena.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arvRs4KdojDnW1O6@sirena.org.uk>

On Tue, Sep 29, 2026 at 03:56:51PM +0100, Mark Brown wrote:
> Hi all,
> 
> Today's linux-next merge of the bpf-next tree got a conflict in:
> 
>   arch/x86/net/bpf_jit_comp.c
> 
> between commit:
> 
>   17637e1a581a2 ("bpf: Skip detached progs in trampoline images that are still in use")
> 
> from the bpf tree and commit:
> 
>   29fcf9ce4bbdf ("bpf, x86: Use global buffer for trampoline size generation")
> 
> from the bpf-next tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This

lgtm, thanks

jirka

> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> diff --cc arch/x86/net/bpf_jit_comp.c
> index 6bca87457e872,6c7a0578760e7..0000000000000
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@@ -3817,25 -4152,15 +4158,15 @@@ out
>   int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
>   			     struct bpf_tramp_nodes *tnodes, void *func_addr)
>   {
>  -	struct bpf_tramp_image im;
>  +	struct bpf_tramp_image im = {};
> - 	void *image;
> - 	int ret;
>   
> - 	/* Allocate a temporary buffer for __arch_prepare_bpf_trampoline().
> - 	 *
> - 	 * We cannot use kvmalloc here, because we need image to be in
> - 	 * module memory range.
> - 	 * Since it must be writable use execmem_alloc(EXECMEM_MODULE_DATA)
> - 	 * that returns writable memory in the module address space.
> - 	 */
> - 	image = execmem_alloc(EXECMEM_MODULE_DATA, PAGE_SIZE);
> - 	if (!image)
> + 	if (!trampoline_size_image)
>   		return -ENOMEM;
>   
> - 	ret = __arch_prepare_bpf_trampoline(&im, image, image + PAGE_SIZE, image,
> - 					    m, flags, tnodes, func_addr);
> - 	execmem_free(image);
> - 	return ret;
> + 	return __arch_prepare_bpf_trampoline(&im, trampoline_size_image,
> + 					     trampoline_size_image + PAGE_SIZE,
> + 					     trampoline_size_image, m, flags,
> + 					     tnodes, func_addr);
>   }
>   
>   static int emit_bpf_dispatcher(u8 **pprog, int a, int b, s64 *progs, u8 *image, u8 *buf)


