Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9EA341077
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 08:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769156964; cv=none; b=DfgLsj8urfqXA4x9V0sXjX7Y2hR7Xh34Lb29CRldnE6TLvcUnvFWcuiGEclTLWB9kZnGGK5UBN6DYYUKweumsV8HtyXzc5lF8iOLkFYW3SmInhitNkr0YevFlVLSU90MTUHEXDEzHehZt2EqMpLOnRAkpWF3jTgURNIhBKgwGRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769156964; c=relaxed/simple;
	bh=ZAO1eH5Ob+wbUe6Tbrm6BL05d172n5IRN7+saAQo6UU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=frYP7t/R7TR3R64KsuKUwei9ApxUyXYovfkwZeuPIXaiLM8pnR3An94B1gcAvojjmOEO4YxmDJnnI+dyIaqtrjlH1tP+1WFZ65XUjrJCvnG0FrkBoqykixfWk5SGIC/9r043QdZ8iMStl31Ls3uATc/qZCOan9F/Yq1Ur07/HvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JWon6RE7; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JWon6RE7"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769156960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5N0F8qUmQJwh+vKEiMdvVxVXqwMYLaba+2w+ktMYCz0=;
	b=JWon6RE7VfOc2DVA7gYGKeWwiuhs5va9qXmOS/+PI98LB7yAWxfk1YWg8rFHMOHMKrVmYt
	pUA+I5SS5LyOVG97Zi0SXySkKCHeiMgXc/llzj73SBsCJNUl47wcd773geaaPPjF984dVU
	LkfaCf48blrzZSV3JX0+sfBawJrRg1A=
From: Menglong Dong <menglong.dong@linux.dev>
To: menglong8.dong@gmail.com, andrii@kernel.org, bot+bpf-ci@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 davem@davemloft.net, dsahern@kernel.org, tglx@linutronix.de,
 mingo@redhat.com, jiang.biao@linux.dev, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, eddyz87@gmail.com, yonghong.song@linux.dev,
 clm@meta.com, ihor.solodrai@linux.dev
Subject:
 Re: [PATCH bpf-next v11 02/12] bpf: use the least significant byte for the
 nr_args in trampoline
Date: Fri, 23 Jan 2026 16:29:01 +0800
Message-ID: <2250332.irdbgypaU6@7940hx>
In-Reply-To:
 <d91544bd4b513290bf468386c0261f913b59b761c34405839c424f8eaf8b1d04@mail.kernel.org>
References:
 <20260123073532.238985-3-dongml2@chinatelecom.cn>
 <d91544bd4b513290bf468386c0261f913b59b761c34405839c424f8eaf8b1d04@mail.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2026/1/23 16:07 bot+bpf-ci@kernel.org write:
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 41bbed6418b5..b3f912ad18ba 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> 
> [ ... ]
> 
> > @@ -23779,12 +23781,13 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
> >  			    eatype == BPF_MODIFY_RETURN) {
> >  				/* Load nr_args from ctx - 8 */
> >  				insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
> > -				insn_buf[1] = BPF_ALU64_IMM(BPF_LSH, BPF_REG_0, 3);
> > +				insn_buf[1] = BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 0xFF);
> > +				insn_buf[2] = BPF_ALU64_IMM(BPF_LSH, BPF_REG_0, 3);
> 
> [ ... ]
> 
> > -				cnt = 6;
> > +				cnt = 7;
> >  			} else {
> >  				insn_buf[0] = BPF_MOV64_IMM(BPF_REG_0, -EOPNOTSUPP);
> >  				cnt = 1;
> >  			}
> >
> >  			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
> 
> [ ... ]
> 
> > 			delta    += cnt - 1;
> 
> Note that the bpf_get_func_ret block above correctly updates delta after
> patching.
> 
> > @@ -23808,12 +23811,15 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
> >
> >  				/* skip 'void *__data' in btf_trace_##name() and save to reg0 */
> >  				insn_buf[0] = BPF_MOV64_IMM(BPF_REG_0, nr_args - 1);
> > +				cnt = 1;
> >  			} else {
> >  				/* Load nr_args from ctx - 8 */
> >  				insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
> > +				insn_buf[1] = BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 0xFF);
> > +				cnt = 2;
> >  			}
> >
> > -			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, 1);
> > +			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
> >  			if (!new_prog)
> >  				return -ENOMEM;
> >
> >  			env->prog = prog = new_prog;
> >  			insn      = new_prog->insnsi + i + delta;
> >  			goto next_insn;
> >  		}
> 
> Should there be a "delta += cnt - 1;" before assigning env->prog in this
> bpf_get_func_arg_cnt block? When cnt is 2 (non-RAW_TP path), the program
> grows by one instruction, but delta is not updated. This could cause
> subsequent bpf_patch_insn_data() calls to use incorrect offsets.
> 
> The bpf_get_func_arg block at the beginning of this patch has:
> 
>     delta    += cnt - 1;
>     env->prog = prog = new_prog;
> 
> And the bpf_get_func_ret block similarly has delta updated. But this
> bpf_get_func_arg_cnt block goes directly to env->prog assignment without
> updating delta.

Ah, good point, I think this is a valid problem. The selftests didn't cover
this case, and I think I'd better to use bpf_get_func_arg() and bpf_get_func_ret()
in the exit path of fsession to cover it.

Will fix it in the next version.

Thanks!
Menglong Dong

> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21278745581
> 




