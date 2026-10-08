Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02BE36B938
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 16:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791478634; cv=pass; b=WkG7/xnBs19+7F2RYE6BR2lMk8GSr0aiOyuBXJFvJ/4FTg47wRC/PbNxYFlvcCxwWWmhSwi0//gjeFcSPFJKkrCOU/cVQtu+3VS4hk4+dyn6DSdMNPpfW5aS1Iqg4l2LyIAQLKBHGw+B9RrDdJp8+yRz5qYtwRAj+Or8QmgJwWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791478634; c=relaxed/simple;
	bh=EealUt9yiKAPBbty3N6lJ+RKIaJuWiPigp/WfkIyv8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I6i3+XT6BSYcfkvJavndhqUAWQjpH6ON3Cm4WwLoaiJK/JtbWKs8AnrLzSDy4ULt5NW1IIfM/mCqYeZeL0/sxu4a5Rx/razs7N9hwhEwYe9t5mV/eQ07nNZLMNmCgt1sDcMHHqoGitFtMFKIQP0ECB2DKCI9bN0bP32/yaGluk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rrOtiKX/; arc=pass smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rrOtiKX/"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-82395ae2ea8so4787388a34.1
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 09:57:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791478632; cv=none;
        d=google.com; s=arc-20260327;
        b=hK561gEqObhscis9WU8wLckRd+BSa7T51IZA0ZPdIC1tGZ124exMs7L5Mqf3HXbHNE
         Vu65UFn3arG/pqIcP2VJiVURzYEJYn1nkRjSQR2LTy3138lHDovFoeFIZ6wB3fLdbwOL
         TZfzyXZzsSpB0m4Ey6Imdl56vZpJiPL2cKMEpyRlpblfPsar3ukrPWe1rA3nFXiKJAxU
         pC7TN+q97ouPOGYihBoAdRiTIzXv79km9zlnifqSS0sFcsN6oUt4kAeeM/rh/Stpcr64
         6i8LPHmQTPd82Pr3eAGsLnCrIfGJVUL7yaiUlCTCSYGcS/2hhPZIC7zk+l5X8Oznb8u9
         rsMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6ikvmCV3JRP1ZJXHNQL45uRqJpRc1YzVn+kqIi57H0s=;
        fh=Kyxvs7FWgL9lEtEeLKSnqZfB4ngKza6HxQiAYXRJReo=;
        b=OnOpEfxVo7bdbsRi8K2sAN0xHvgaDVi9cXm7ww00WFVpBmHt11nHTlxIlZ5Mp5IVoL
         iFTK8dJRKxSUJy16ig00RDeeDoFLJIoMxJn1DeGK72/YG5NhLtrv6E9Il0xiyCofjLDV
         q1kJiEzsRMBZdrH1PHjP2+5cP76p8d+c90YjyEnScEOaM43aRiMalxV4t1YD3tXnnl8p
         TS6C18KpoX8YGKhA/0GewPQp7EHfkzotEI50uBcsDCJ3e2JMeJNjr5PFk0M6FnBAs5dD
         qSOW80dYjdE//tImrlKGIGA4yu4eQNhvCoqkFdHuM+JqkcjrZtlJFeOYCI3GkJOp4e23
         YfaA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791478632; x=1792083432; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6ikvmCV3JRP1ZJXHNQL45uRqJpRc1YzVn+kqIi57H0s=;
        b=rrOtiKX/qR052mg0YczBITnG6m1T97A5mIB3Eck7JbGqUntLurbcA93IQkxzl3OV6c
         IcNyQVIyWK1hQzMIVL4N3ZQo8WuNf2BzVl/04noUNa4oO0/9UjBK4DXEZBpXOywOaQHM
         g7ZAde5aYM+ObOfJueOvCbCwMX5BuMPVId2NwhjQ+sD/3tF5mtnk5sjBW8LIrqbVkC9r
         lQPK4Ym+kalKdsDdyYO4RNRSImPn3kvUE5Bfej3kQihJE2tOgFH+MPAlhW3j0WLfq09a
         rowhnBA9dYyUwfYLs1LO3UBSqDZ/rMQQ5bB/yow47/naEklzBK4PCn75VQh9/hr8fIBo
         g/gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791478632; x=1792083432;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6ikvmCV3JRP1ZJXHNQL45uRqJpRc1YzVn+kqIi57H0s=;
        b=HwbZvMFPlifnNTiUEpkUSB6Qt2ciyt/6VUIfvyybWOkTuDBGA2spZvRFHSM2sFbYyy
         jxM7iZqH/vaxo8BGdVjgJb57UG+vOr9HhnZszQCN/VJH9onNi8yu1WUgGlMupF6gfwti
         moGwfIpvx+XUhBSmnYtjf0PibI0ly2kFei+GU3NkgG/DrVCgDWhtEoPDZFi2zL34PHBr
         oyjSsUnOBTcrQsCaSqCnmbqUoCewcdQMcRc8/uGiBweOqO0bSeLCWkp/5bK/fdDKuV1a
         e3gR6/aHBpTWj8MHtZPsvJ22inUdQpfb8YScZ7toRSPzEMumhH+kHVxZh9l2cmCsPEcT
         eh9w==
X-Forwarded-Encrypted: i=1; AKwUvByhylZ72YF+Y6Ni3ZhHT2gfxe+4xE418BGgjPHIDGB6RN+Gla2FkzvhYKxl6KLZTxVbchKpU2w=@vger.kernel.org
X-Gm-Message-State: AFuF++nwK9cDb7lO/DuTLIoL/K4xUCh1v4exCOUKRAfmBi+jABwKDIyA
	Hi0OE0W+e75SgD+A5mBQP6NDHkIaN7F/H5uf5+jo1ZVJDGgrz8x9zx0ytRxtLEa0EClBJ+o2nrm
	o66x9UqV5Tzw2d/ocl6r3me/NPbXm6P4=
X-Gm-Gg: AYBFou00IKnFg6okqtnKA8I+EvQrC7eCq8/0bmaDZ2ECf2TGtWd/5wexLvHheVyRS6u
	AFq8y3HBMk4b4+xSTgxk86cDyG4KBC1gnoBUXQ1C0b0+xOPKNYzAw5ddjVcs1P3q4fZl3szt+U1
	C00/3bHksyuUMS8ONrG4dZFhDMAzhgDgHPLhGvTOI3Yoo8Vou9fG9fs3IhufsSbMtaEGvpACnP2
	7Ry4j7lD+Ffh4tjama5QSVrdEUo9lDLtiDsGLnEDs/eJc+HuPttiPe/gXS/6v2fh2VBAbm4n4fL
	YGOSvzf88wWU5aiVIeGpfI60Vtgup5ZFOEV8Kk99k4buFoqQwG8oxw==
X-Received: by 2002:a05:6808:5394:b0:4f5:aa1c:d948 with SMTP id
 5614622812f47-4fc48c0cfb4mr5098718b6e.65.1791478631140; Thu, 08 Oct 2026
 09:57:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008031604.256498-1-kuniyu@google.com> <20261008031604.256498-6-kuniyu@google.com>
In-Reply-To: <20261008031604.256498-6-kuniyu@google.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 8 Oct 2026 09:56:59 -0700
X-Gm-Features: AclHuK_Xg7cFIkTBf_GUj7s-jv3sHiyOpgy6IlwJDWYXH05-Kw-Ya4SMvWFtvb4
Message-ID: <CAMB2axNXeYUioMLkqJjSr=9-LEGkxfH87HXYoXT1PgPrdr22nQ@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 05/10] bpf: tcp: Check BPF_SOCK_OPS_TEST_FLAG()
 after cgroup_bpf_enabled(CGROUP_SOCK_OPS).
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@meta.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 7, 2026 at 8:16=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.com=
> wrote:
>
> BPF_CGROUP_RUN_PROG_XXX() macros guard __cgroup_bpf_run_filter_XXX()
> with cgroup_bpf_enabled().
>
> However, even when no SOCK_OPS prog is attached, callers still
> initialise struct bpf_sock_ops_kern (memset(), etc.) or evaluate
> BPF_SOCK_OPS_TEST_FLAG(), which loads tp->bpf_sock_ops_cb_flags
> from a cold cacheline near the end of struct tcp_sock.
>
> Similar to bpf_tcp_ops, let's check cgroup_bpf_enabled() before
> BPF_SOCK_OPS_TEST_FLAG() and struct bpf_sock_ops_kern setup, and
> rename BPF_CGROUP_RUN_PROG_SOCK_OPS{,_SK}() with __ prefix.
>
> Since all direct callers of tcp_call_bpf() pass 0 and NULL for
> nargs and args, they can be folded into the new tcp_call_bpf()
> macro.
>
> All callers of tcp_call_bpf_{2,3}arg() check BPF_SOCK_OPS_TEST_FLAG()
> and do not need the return value.  These are replaced with the new
> tcp_call_bpf_flag() macro.
>
> Now, bpf_skops_hdr_opt_len() and bpf_tcp_ops_hdr_opt_len() are
> just NOPs without bpf prog attached.
>
>   $ llvm-objdump -S -D --disassemble=3Dtcp_established_options vmlinux
>   ...
>   ;     asm goto(ARCH_STATIC_BRANCH_ASM("%c0 + %c1", "%l[l_yes]")
> >>ffffffff825127e6: 66 90                       nop
> >>ffffffff825127e8: 66 90                       nop
>   ;     size =3D MAX_TCP_OPTION_SPACE - remaining;
>   ffffffff825127ea: b9 28 00 00 00              movl    $0x28, %ecx
>   ffffffff825127ef: 29 c1                       subl    %eax, %ecx
>   ;     return size;
>   ffffffff825127f1: 89 c8                       movl    %ecx, %eax
>   ...
>   ffffffff825127fb: 2e e9 6f 02 43 00           jmp     0xffffffff82942a7=
0 <__x86_return_thunk>
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Amery Hung <ameryhung@gmail.com>
