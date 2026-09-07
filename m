Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA8D3C1D77
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 23:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788823403; cv=pass; b=gC5yI5lxW9xgWu8fnOhXqXK76X/Mi0p+wGDc1i/07LsO68xw9vMBtlbTsQXhIqDDOPwkJr6Rtku1RrVf4OaNZYJTQDyg9dCu/+eXSHVy2ZjjXupy2nqyweLdsvRGdNOgJgiuZyyp2fXt/5Of6q9kFvPUKFLG0xH/hxX0ti/NJaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788823403; c=relaxed/simple;
	bh=jfAp60OBp4doOiN+x+Yf0On7RHIw5hZfHkDWrPwTz6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SFDTAbKpBufoZzGeEhwrQDsagQdTmZDkOS4xea/omKhFJyVCb083YVpZlWg9e8fINbiZD2PgTLaM9QV4jNAOQKWRUPWP2Lg6n1Y25zHlmYJKHteYbAo1rUQERBKrkm5KmBuVYBzT/o2wWcAuqNGJWjS1w+gQ6svuXYZCSl2ArRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HpzOhlsq; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HpzOhlsq"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-398a5aad413so2994528a91.3
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 16:23:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788823400; cv=none;
        d=google.com; s=arc-20260327;
        b=DlFzpEfu4y663Mm73SWu+3Nl4AzGDWwGi+zo57ba9BrmquKjMrp3uSV2ZyZCFYJeUQ
         Jju67/RNCz+8CGSrV4GqR3s/aoWd6mMeGSyhZAYaHgkn0LLQ3e71hlwPQxLMkCnGY8Hm
         pHCps2hbF5dgg9+vd7PVULqr1wEw8DWw3CCsrJOfOvXIYQz99LSGTD4/0epxVE1igB0P
         DyVGHAN8ChiPcvdLTTw2hHFPv1qhGy15aJI/GEFI8IMi75p27wFycD6KwlJrAdJ3ElOy
         GZ8fd2kUw2hW7f3czh8Mx7/t2lkHeY42yeQi5R/BG6UiDgAB5UjyD24bxbmdAFpdAa4g
         sVmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0IgSRwxcuB6vnZUxcMMegnldun7vRf9Aq4Po2V8pKwA=;
        fh=whguyLWexIAnmh9ll3T47SCzsyMSiDbmhE43JrKClO8=;
        b=Fih2p6Opu9DUfMZYeYyG0RGxfP5+krGkE1YgmkZ3DlW2R/7x1zSG96uft5fYw1raw0
         7BXej+xW9yvB1+DH2sjbJfpVYc3KlZWRbY31u0joNZkuF+1WbTW7p3ph+nI00xJehls/
         Os2bsz9mrws2J2y/CETE5sQ1WGP2xtOzGBiVczJgjj1yJouSyd0jmkh8mnGReVjG43oz
         n+DTIWmJQpGKppMZ2LMDTbzW/i/7sCHbreld2vdizSUeCRiSoZr6TF+hhEqGLaS2GUqu
         RWH/zDT/MSOAGLndqtsxBnwjBVj0B7EfvIuCTH2R3M8Bfzaa7BS7gBMj+4d9aS2HRhaB
         GDQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788823400; x=1789428200; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0IgSRwxcuB6vnZUxcMMegnldun7vRf9Aq4Po2V8pKwA=;
        b=HpzOhlsqs1wTA1S2qEtpNxFT1eY274fqC9BMPpUDx7bLrVEmt9ohAcHvk8GzPshCwF
         0FZ4a2Fu5wZ9jdxdoX6XCAMO/ZGDKwHAWmd9hQCF6knaaR5gPMgHzZzD5jeMFGWHsDeZ
         wxZo1TolvpdeZZXz+SSaHfWdqhzrXkW8JxDgeF6oy45jtfELHkLKYenRq46VlNd5sw4l
         Tk7P9wFAQYfexwEhMQXAhFSAuWpMDlrcEid9kRzOkYHbD5ALyZj0d6ICGSHLXdM401qL
         /i9diuZHsYJu8lnsAbDbDgcA3xUc4k6Vxv5o90HrsCwQlBhQ0761KsOO+fYpPPUuAJnd
         GS7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788823400; x=1789428200;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0IgSRwxcuB6vnZUxcMMegnldun7vRf9Aq4Po2V8pKwA=;
        b=P/u8soAH6Jyl98qgg4miu74frI3CnJoNn/CccvSZlciO1wf59tN5cfdfrnDQhbsYJv
         PN2DB+wWmtsKZSMwZHcbBma3wizyuZX929Rq/gYYE2u3bOMskeZq9oMP8o3RcicyMPZB
         3uvb/H63nSMQa3KyqPsUJYQNv8Ew5MZ+HV1zsyX2RDYJg5chtxMhhtmGZwogmIMYJPiN
         BwVdWrlzyN52pJxMavPthNc3XgWZBdy3j64MYE4l+pnv0iAnHNoirMc8WwWeCa23NmNj
         ONtAiPn7p9+1BWbMw8PGbiXfmvYBETDs/8QHXXunKdJ7V3c60rZ8v3F5jgP6S52uYHXm
         T3Nw==
X-Forwarded-Encrypted: i=1; AKwUvBxrG441nmRHcdwASJosMu8BrI+xsAzqQrCRcsfYIu9OF24m+THk8OKIo7D8nlzC7Py5GrYjYJo=@vger.kernel.org
X-Gm-Message-State: AFuF++mT+AbU+EdYwOOcrHFT9MBYvbFX9u/7hbD0/D4A5bdnlyW4T++b
	pvf5ghW+EW3oA6vKDyJeEjLI9ErqCQ9KIxxiJ1I18hggTnOmYQk0BNUvcKG20iMM5tF5pffQI8K
	GwPLs9Eo8NJ56HmV1ujB76isRmLxrEf85CImbd0xr94cuyWiU5fvNkJwfTlQ=
X-Gm-Gg: AYBFou0DUxWBTX7tBZU9kiXNx4m9CRZKOSjlfga9xtpc2n1vI2VXK7WX5aUidN/goCx
	VkYvZGElwFcjJ7aITdLeKvBu52+bbzfxI6gw9U1oZSgJLcKWijclqtJpoCLARg3KrqwBmvSpDSC
	kvXSMga20VGhLQw5BKcg8dld8ggW5NwcVwLNMwu5hKeKc5ibo0Hmu0vvOZtG1mBspmC3TuVjDiG
	9+/Cv5Fc9rcPJg/QPCGpf0C1ZQhziJ4DhenVNEOnkAxBKR5QjgkZfLRNywCHdpHFF5/Sj/p5/0x
	3u9I/AmAF0H706ZZP/4fc3GAcMUhjRfrmfbbK/EUCKFf1ZhWlvY2IY7baRnXRG7ru83uJBFLmeW
	J+NGu/5Gp7EkC9CEzBAf0jODttWnNR1yEt2sQ497Pq1IGDzcwrpii1NQV
X-Received: by 2002:a17:90a:d2c7:b0:398:9bd1:3216 with SMTP id
 98e67ed59e1d1-39b262e4e02mr36924728a91.23.1788823399150; Mon, 07 Sep 2026
 16:23:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260906074135.185212-1-jiayuan.chen@linux.dev> <20260906074135.185212-2-jiayuan.chen@linux.dev>
In-Reply-To: <20260906074135.185212-2-jiayuan.chen@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 7 Sep 2026 16:23:06 -0700
X-Gm-Features: AcwNN1Xz9UhdXiFIx-Dg3fA6cQJzjy8WgHXHsftsUBO_tigszkI2pXJJ9JByUSk
Message-ID: <CAAVpQUCzacvL7n0DejvtYQB2ZnHiUM_sg4-d==iviyvVKv=_xg@mail.gmail.com>
Subject: Re: [PATCH bpf v2 1/3] bpf: Fix out-of-bounds read of sk_protocol in bpf_sock_destroy()
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, Xiang Mei <xmei5@asu.edu>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Shuah Khan <shuah@kernel.org>, 
	Aditi Ghag <aditi.ghag@isovalent.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 6, 2026 at 12:42=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
> sk_protocol lives in struct sock, not in struct sock_common. A timewait
> or request sock handed to bpf_sock_destroy() by the tcp iterator is
> neither, so reading sk->sk_protocol runs past the object:
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: slab-out-of-bounds in bpf_sock_destroy+0xc7/0xe0
> Read of size 2 at addr ffff8881047d11b4 by task test_progs/428
>
> Tainted: [W]=3DWARN
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x91/0xf0
>  print_report+0xd1/0x630
>  kasan_report+0xf3/0x130
>  __asan_report_load2_noabort+0x14/0x30
>  bpf_sock_destroy+0xc7/0xe0
>  bpf_prog_c3dd61f9d9cd9f37_iter_tcp6_timewait+0x9f/0xb7
>  bpf_iter_run_prog+0x538/0xde0
>  bpf_iter_tcp_seq_show+0x26b/0x4b0
>  bpf_seq_read+0x424/0x1210
>  vfs_read+0x197/0xe40
>  ksys_read+0x119/0x240
>  __x64_sys_read+0x72/0xc0
>  x64_sys_call+0x647/0x27e0
>  do_syscall_64+0xe5/0x610
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> Only check sk_protocol on full socks. tcp_abort() already knows how to
> deal with TIME_WAIT and NEW_SYN_RECV socks. Also fix the comment, it
> never matched the code.
>
> Fixes: 4ddbcb886268 ("bpf: Add bpf_sock_destroy kfunc")
> Reported-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
> Closes: https://lore.kernel.org/bpf/20260702224519.800135-1-xmei5@asu.edu=
/
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
