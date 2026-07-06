Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF013DCD99
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 23:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783379483; cv=pass; b=CWfu0hj2HZN2Kig7jZuW4ICcJb/5hpjeJ+ybDu34VfqMA4Qj11h0F08fKYvqE+xPZcmckFa1ioVx92X5U2pijxKtYvsp3ZL4nRGQIXEiv2nnxxTIjdDz3dr0cLYekr4O5TvyEUXUbd7EogeRIHiodsZu3BTrp4w6oTTkkUSO8xE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783379483; c=relaxed/simple;
	bh=0ldrpoo68rpXzEUw90JeIBxRjusqYN4dYNmPwTKPHGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vtue6VAbmiUX+IWI7FExqwBKp1HTfUhbI+81mK/w8dUTcmiM5T5QfI8mXFlCUc1mG0SO7nKAQbZ6Z6WTZpOXQQ/Oc0ODMb8L+PGpU5pvQI50cC2IhiDOjQyWeTF0g/HD5ZnJIT+QTdBYJwB10Cr8Q1SXqWWtEF29E2EBl+iDrIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NMQQb+IT; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NMQQb+IT"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-664bb15d05dso4995281d50.3
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 16:11:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783379481; cv=none;
        d=google.com; s=arc-20260327;
        b=Cd70KL2OG10E84w48qvbvoCnnevhKbqAYH97VZEiNSwNiVIF7k6c/q5HeX7TiZ3Twz
         s2q2Ja9gXxh5U7e+kf0Z1BoFRJruJBk2miUKZ3Bb8OWOQuzP2nPkCG1kc2P2ZMuEFJ8I
         qUEr24GDdFjFaar1K+cILJT5jVYk1WhY8gF5nq7mXIzkI0kqeo6qGWCE251DX9p2Qm42
         dvec8Q1ZjAb94B2AMQJUiyUFAgoyy+AmxgzE8k3xJK9q3xAKdC3+7h0lfFiLXsnrzZ26
         jISdHOZaGxAiDZ4fwCw0xICmG7WTq5WAP3rFTgfBMKOZ9F5ym/72EPFmbxOZMlICe0GL
         iP2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=r3cdgqapzumwzqnY9k4uVmaR2nHeOOKloBNHyQRqVGc=;
        fh=rIQXLzywgd4qrWOh7TLVn+wCqr0TNDoTlH1NoVZfsAs=;
        b=oYwNRwsgcJXgRSR8OEZveKvRQlflaz3+dLZkkEQnAjb0+JR4ZJcFPw9D5YuCxRik5O
         513O8q1t/gfIYgvIA5BbhO8hV2VsyFLURxEtqtcDH5X3LjRC5c0V2y4Xmj6/TFhEvP+P
         qsQCScuK3kp1QhXe4lFXDDLlPTmeQLzYyKhRbGBNy0FYg7jQhAqgzeogq6QYDN/dzok4
         6d0NWNK2E4lHxuKKZHDLkOJDrmP3SBvyG+dlTJ+SQzzkQLm+DMNK+T6ZXNuz51Acn4N2
         dqj5lXQ5LForkX903kP90cZSwNxCp1/NqFkGAJUxXGlH2YJoXttmXLeXCFZAVWlimmMG
         s64w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783379481; x=1783984281; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=r3cdgqapzumwzqnY9k4uVmaR2nHeOOKloBNHyQRqVGc=;
        b=NMQQb+ITiACZy51nzG8P1ipra2sFOEc9Duwxxsmnx9wdST78spV48OB/YxmfZX96R9
         EPGlvssPnTsNdyIoxqIre1BWGmA5txoWFpqWX3Abzniy5h/eIRmt8pp+l2btLFOYNzSX
         XNvIoGenl3zDP6fllVm2AfZ1J24E6CaqXpUaHO4bouMagiv7LGJ4eK2PzIPkLFhH3zj1
         TK1IKxaDDyWwzeOj2DrGnFfpbZ/tLXf5Cbsqa2Hrw4uZC+FQdgiZ23rcMyrA2trYAkFz
         C6W8kf7X90EVhiaGXd2pXJ13NBflRSZ9EnmlGSpPI5vGtWtTiwbqdyCFRSlUlYMpH1bQ
         W5Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783379481; x=1783984281;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r3cdgqapzumwzqnY9k4uVmaR2nHeOOKloBNHyQRqVGc=;
        b=AJySSiVWKIaVSYnwNSWNcGk580GPTGSxaPl1TXGAwdPZlJ/AeoakDmYclAAmRuXyCF
         93TzylD7SNIH9jv65Hvl/rNjaV4+BqFV8nui6itCR9/qj6uzzUMdTFFhGz/Yb2PKgkU+
         SEuPYgCphkl+QZD9t94BwOZT++byibzV8HAP8IBN1isQXrj8ZGmGHrB13bQZQfUR24nn
         8fCdIr3dqAjIChgFXdZlEK/tmiTmqW6w9/JDBN3QCzsPlUvFx+pHvjycXrfTxymbUz9t
         PlqFotD0nElZc6Z0N2D/yM5L3IiYaeHTZSlauSQnUic4mVqaoxVj3/Ss9YCMZdNot8+9
         vIuw==
X-Forwarded-Encrypted: i=1; AHgh+Rpz+d0EUQ/V6n/Ow95NDUVqTZLza49KTUJ57nZRDcX20rHVnu8S8MXIg+BVZBNenhKYbbtzD7o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj8EzpMgLyOn+VQjNrZwXnd2hUjKWdz635hF4xffSSwvi8kIg3
	YBBnBbAADQKsucIEL3iU0VQ8oqPbOGS6HugKraW+cAMJpxAukYfvyN1/Lv8EghhI3JFgQrBjmle
	eAYYV4NZR5UVXKiLryDgnocSVBETTjcw=
X-Gm-Gg: AfdE7cnrPvbqdoYzgG109iPiP3Hti8Kh+hFowbVBqBlYCfCOerQnojNuNavuP/XYiPL
	tMEiJSYZIRG5nzaiYSUiKTxXW13Q0Z8ZLQp4fvbhRbGFaFGLNSr+B8USAK75DBIUPdR+USv2DCY
	vOhGJ9JVcYvkA2HMHKwqL/brjzuWFfjeVEsmta505tchOTerYGNWuxucykhILEufGC1VjX1iBbA
	qnjgfdg1TotucRC+Y66v9n79ZBvDiGUKch77VCzMGAo14bvp1i0PketUFFmgTAscek5maVH
X-Received: by 2002:a53:d012:0:b0:664:d7aa:3ebf with SMTP id
 956f58d0204a3-6677faee048mr1719697d50.1.1783379481249; Mon, 06 Jul 2026
 16:11:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706171918.317102-12-ameryhung@gmail.com> <53de193473737a3692df075a179e186e996dc26a592b697f2f335d9d4039c943@mail.kernel.org>
In-Reply-To: <53de193473737a3692df075a179e186e996dc26a592b697f2f335d9d4039c943@mail.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 6 Jul 2026 16:11:10 -0700
X-Gm-Features: AVVi8CerpQkWQBGKAnXiwMgd3izzJDVAW6uUXCJoT_umDqP0xKf7SNii83bPR6g
Message-ID: <CAMB2axORKWYVfG_ZSHosX70Kf61bEqtyTnRPhuJy79avBJAHWg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 11/15] bpf: tcp: Support selected sock_ops
 callbacks as struct_ops
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com, 
	martin.lau@kernel.org, shakeel.butt@linux.dev, roman.gushchin@linux.dev, 
	kuniyu@google.com, kerneljasonxing@gmail.com, kernel-team@meta.com, 
	ast@kernel.org, yonghong.song@linux.dev, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 6, 2026 at 11:28=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/net/ipv4/bpf_tcp_ops.c b/net/ipv4/bpf_tcp_ops.c
> > new file mode 100644
> > index 000000000000..3febbc8dd1a0
> > --- /dev/null
> > +++ b/net/ipv4/bpf_tcp_ops.c
> > @@ -0,0 +1,188 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
> > +
> > +#include <linux/bpf.h>
> > +#include <linux/btf_ids.h>
> > +#include <linux/bpf_verifier.h>
> > +#include <net/bpf_sk_storage.h>
> > +#include <net/tcp.h>
> > +
> > +static int timeout_init_stub(struct sock *sk, struct request_sock *req=
__nullable)
> > +{
> > +     struct bpf_tramp_run_ctx *ctx =3D
> > +             container_of(current->bpf_ctx, struct bpf_tramp_run_ctx, =
run_ctx);
> > +
> > +     return ctx->retval;
> > +}
> > +
> > +static int rwnd_init_stub(struct sock *sk, struct request_sock *req__n=
ullable)
> > +{
> > +     struct bpf_tramp_run_ctx *ctx =3D
> > +             container_of(current->bpf_ctx, struct bpf_tramp_run_ctx, =
run_ctx);
> > +
> > +     return ctx->retval;
> > +}
>
> This isn't a bug, but could timeout_init_stub() and rwnd_init_stub()
> simply return 0 like the analogous int-returning stubs in
> net/ipv4/bpf_tcp_ca.c?

The stub function returning int here must return ctx->retval to allow
the next program in the array to inspect the return value. The stub
function are the struct_ops counterpart of dummy bpf program. It
replaces a normal struct_ops program when update_effective_progs()
fails and can be executed.

>
> These stubs are only used for CFI/trampoline generation and never
> executed. The sibling file's int stubs (bpf_tcp_ca_undo_cwnd,
> bpf_tcp_ca_sndbuf_expand, bpf_tcp_ca_ssthresh) all return 0. The
> container_of() plus ctx->retval logic here duplicates the actual
> bpf_tcp_ops_get_retval() helper below.
>
> > +static void active_established_stub(struct sock *sk, struct sk_buff *s=
kb__nullable)
> > +{
> > +}
>
> [ ... ]
>
> > +BPF_CALL_0(bpf_tcp_ops_get_retval)
> > +{
> > +     struct bpf_tramp_run_ctx *ctx =3D
> > +             container_of(current->bpf_ctx, struct bpf_tramp_run_ctx, =
run_ctx);
> > +
> > +     /* bpf_get_retval() is only exposed to timeout_init/rwnd_init, wh=
ich
> > +      * always run via bpf_tcp_ops_call_int(). Its run_ctx carries the=
 int
> > +      * return value chained across the bpf_tcp_ops attached to the cg=
roup
> > +      * and is this program's saved_run_ctx.
> > +      */
> > +     if (WARN_ON_ONCE(!ctx->saved_run_ctx))
> > +             return 0;
> > +
> > +     return container_of(ctx->saved_run_ctx, struct bpf_tramp_run_ctx,
> > +                         run_ctx)->retval;
> > +}
>
> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/288106=
80939
