Received: from mail-dl2-f40.google.com (mail-dl2-f40.google.com [74.125.229.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18F24E2F3B
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 17:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791221227; cv=pass; b=W3IzCWtPIdvobQ75/ADkvjKqO/ZXWEQtU1oN6CmaihNeGIwXI2Jk5NueJYrt3HVTJosQkjgIx26w9BEIHqD2taSYZBJO8KO5U1kLwc/NKnMwKnBhWs3yaf70XrNsUD+7GeSYlxNV1QlU4jT5cKH/X2pJvB3x58MEM6XmdtVDM38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791221227; c=relaxed/simple;
	bh=SvNUMArrKWFvoS8qkrww/WErXldZpTTjxx1KfsSc/OM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uZ4wB/i4EG+muMlrJodeum9vX2kvjHEk49CP0SDN2CFtH55c5V1Nkn4OwboxLzj1Dmp0WxFIssweautzcs9bXjD6PQn1GXV31RW1vXz2OwSxc9trYclt1UzxccTpr5TPHN4MoViNs/2po6jwzbjVaEjQ+dHDqdwtr1wupHk1x/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T0g7/EXX; arc=pass smtp.client-ip=74.125.229.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T0g7/EXX"
Received: by mail-dl2-f40.google.com with SMTP id a92af1059eb24-14e1fe551c3so519591c88.0
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 10:27:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791221225; cv=none;
        d=google.com; s=arc-20260327;
        b=JJCH7aumVpTDQFnqxYDWimBlpcwcSu/u/0jTXEbRJfHKPT1hwzsgvV+1DGstXVe5s4
         H4JUOt3KoihSdPYq2XcnxyNrJ96FQAnBx2BdvbFB01/m3CLngSS9Gd93ysosH2cotyhF
         DnQ0/LB2/TcV1Ek2xJIWVpM2rbKYtKfSCAIzXBGjqN4Tirr2yP0qgoBuyyn75GJmpKdV
         8SydkrR9jJ6N05GtxvYUxq/hVgPgHd8wU5KqstCL9gLyxeklsrQTwBX+wfBvUuFY/M2t
         aMMmeuwsJOu0dE/xl4fO+o6ujCCfIFtbfNC04q3Oaz3N4ZPahc12lARs8QBm78VnFWo8
         JVYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0fw8n8AkfovFoqxnTVJMYaNAw3G0Dz3Kg4SbR/EI24c=;
        fh=f/hcQmTItXWNW4dmWp235Fd/RZyJKE5Q2njHJTQpChk=;
        b=paPiofPvxSsLAh27pfnF8epKNGD5f/MURCQ/ApIjwTFqFACenDFWYhV6B+7kYdXJLQ
         jVATEz5l/uDFPZfJVG82mhRxUTHpsA+S9LaNFWoltxwxNN/DR1l6+XAIJL1fLR+nc94z
         M5FIsTddgV9BAw20K5iJUwrAT0Bnvj04REDPBcGSpxnXLhynb9eUY6VF7NmNMuaaXDeG
         g4UGJgaXTqV07yrXRLWJjNLJtG1p435820sCs4ncDWmA/Agr4wwf8wgUtoyptA+WMPnT
         we4T3XnBt3L7oZeltsu9zBouVt7m7qomnY7rz3dQaZ/zbPmAqFixE8murvwkxk1khVpf
         mC2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791221225; x=1791826025; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0fw8n8AkfovFoqxnTVJMYaNAw3G0Dz3Kg4SbR/EI24c=;
        b=T0g7/EXXJQCgVmzXibOLowcEQ7WA40dWbRs97CM00RCNGcgTAQ6VbtK9Z6ie4q/h1E
         +Zu9T+P3xeV4aViFhKYBn++ARD6K+VOtyayBdbQCoh/QCSJvJXsRrzBi8bM9e41aX3YX
         MHnvsS1SMq/oI8Ml+OX+2CU/v3hM1H3itcYlz4SbePZ0h9yUlUmpj4QU7SZrFve6w+sl
         4AwMlX3To/hSqHzf6XnieFOJS3nnKjbzzTEQpZQ2UsSAYuULHKl2d/9fzIqjsrUz8Yu+
         l2dBh0Vr4Q65dMRSytXGORkC50q7PmJ/pnJ2lV7FvSnjVwndq+2K94+xWPmwp+Yx9Twj
         r7UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791221225; x=1791826025;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0fw8n8AkfovFoqxnTVJMYaNAw3G0Dz3Kg4SbR/EI24c=;
        b=JpBGP6cDoOFR2qk3CdDjR8zkGbgLmzQNtCMa8vKQcYO8vHp8mjrCXnYLOmLeNOE44Q
         RUeH1nl0bO8IxwAw+LL3h84Spb16X7cO+OeoadxI8R3Jlx/9hhtbbvb4c8DFKXVgbzB1
         DXyaKbRXTNMHoq6tt8fQTMFfx889pO7eYK8+VjTGaHlMry0aDjYmiFt2NxaspZY5yq4p
         F3/HZt0drYKHJTGhhQZqwAuQSztIPQuyrDgArV+w+N2kIYYFuQxj64peWsll5z7j3LP6
         JGBTcPZ5nNbFIOKyv/mw14x8MlKnv5DhY9ZcqRQ52W2VrANnC9NEn7ofuUUCxojrYtZ0
         69Vg==
X-Forwarded-Encrypted: i=1; AKwUvBykeLmmD5gq6xRSAKZUEscpWSKeYFNUDMNdyotekpSKxek9+jmdgRZfyh2wK8OyIr8brfEZj2U=@vger.kernel.org
X-Gm-Message-State: AFuF++lUBuqrTQehGjhdM7vKR9RJpJIh1rEO52Dk7Jazy5u7t30rn9Y9
	cJOOMXsxZsY7ffTuf9Xmq2QGWwgNkvAv8w1QsqzLHNYBuboB4w/omwM8wOxbEw2VLw5sxNO3/R2
	mgSb9f8ApHkOYDcjD2GFR8oseSskdluX31KBVmJF2
X-Gm-Gg: AYBFou2BVS725T601i9XsMxQeB7zUJTuBk05ZDQjAeLMrneER6pCiHYQwf+LezFSzvM
	u4qAcefd1miaiJtWWibc9/wqlBskH5FZI5m5CpB6fSMd6qA9+fhymdbk5gZLLY8NenR7QDLaE/2
	HA9uFsvI79XT55NPBcrBCDg+7aI8CpnUczN2qBfeI4eTXgk4l3SpEPa9JMrXSc+6wJbFHyw1YTC
	O8nk8TLPG/lsUcG+XdmSHrTM1qVtDu0wxShStr6mlMih19tAaV2T/CpVaBxOW65x23eBg95QacE
	cQlQNrtGc6h2UnXHKvSJDXRXR1wCnOO/F6UwlcvAJ/MXExZMMXz+mUeuz2yCq9pbCwXyXCIzQKD
	SPJFlPC432j0cpkIL0BVdEY+9REa0hLP9ik1M2AcQUpDvM0AGkJigYVhtNXLNtcecQr7CpnVDHE
	WTQbJ3i4Q7c3CqgD8X1jVe6g==
X-Received: by 2002:a05:701a:c909:b0:14e:d8ff:1592 with SMTP id
 a92af1059eb24-14f58fd159dmr15279044c88.5.1791221223925; Mon, 05 Oct 2026
 10:27:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261005154533.4147685-3-kuniyu@google.com> <7557423d5efced7e3307ed14a4ad8f364246f3ea738395123f61296ac4cc2284@mail.kernel.org>
In-Reply-To: <7557423d5efced7e3307ed14a4ad8f364246f3ea738395123f61296ac4cc2284@mail.kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 5 Oct 2026 10:26:52 -0700
X-Gm-Features: AclHuK9EJNuLuqVE4teO2iA_KA3FNBEAYhgOEbqAXbKZ3GJJpU1bqQDO7AsTh4I
Message-ID: <CAAVpQUAkMupUTZpL+-QAwYYG+awade04rNSA6jEWGQ3o5uafvg@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 2/9] bpf: tcp: Add a new per-socket flag and
 kfunc for bpf_tcp_ops.
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, 
	ameryhung@gmail.com, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	sdf@fomichev.me, edumazet@kernel.org, ncardwell@google.com, 
	willemb@google.com, ukyab@berkeley.edu, cleger@meta.com, kuni1840@gmail.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, martin.lau@kernel.org, 
	mason@kernel.org, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 5, 2026 at 9:27=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
>
> > bpf: tcp: Add a new per-socket flag and kfunc for bpf_tcp_ops.
>
> TL;DR: The bpf_tcp_ops_set_flags() kfunc filter seems to let cgroup_skb a=
nd
> sock_ops programs call it too, not just bpf_tcp_ops and cgroup_sockopt; t=
his
> is an API scope issue, not memory safety.
>
> > diff --git a/net/ipv4/bpf_tcp_ops.c b/net/ipv4/bpf_tcp_ops.c
> > --- a/net/ipv4/bpf_tcp_ops.c
> > +++ b/net/ipv4/bpf_tcp_ops.c
>
> [ ... ]
>
> > +static int bpf_tcp_ops_set_flags_kfunc_filter(const struct bpf_prog *p=
rog,
> > +                                           u32 kfunc_id)
> > +{
> > +     if (!btf_id_set8_contains(&bpf_tcp_ops_set_flags_kfunc_set, kfunc=
_id))
> > +             return 0;
> > +
> > +     if (prog->type =3D=3D BPF_PROG_TYPE_STRUCT_OPS &&
> > +         prog->aux->st_ops !=3D &bpf_tcp_ops)
> > +             return -EACCES;
> > +
> > +     return 0;
> > +}
>
> [ ... ]
>
> >  static int __init __bpf_tcp_ops_init(void)
> >  {
> > -     return register_bpf_struct_ops(&bpf_tcp_ops, bpf_tcp_ops);
> > +     int ret;
> > +
> > +     ret =3D register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
> > +                                     &bpf_tcp_ops_set_flags_kfunc_id_s=
et);
> > +     ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOC=
KOPT,
> > +                                            &bpf_tcp_ops_set_flags_kfu=
nc_id_set);
>
> The commit message says the kfunc is exposed to bpf_tcp_ops and
> BPF_PROG_TYPE_CGROUP_SOCKOPT. Does this registration limit it to those tw=
o
> program types?
>
> register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCKOPT, ...) puts the set
> into the shared BTF_KFUNC_HOOK_CGROUP hook.  bpf_prog_type_to_kfunc_hook(=
)
> in kernel/bpf/btf.c maps CGROUP_SKB, CGROUP_SOCK, CGROUP_DEVICE,
> CGROUP_SOCK_ADDR, CGROUP_SOCKOPT, CGROUP_SYSCTL and SOCK_OPS all to that
> one hook.

Oh didn't know this.  Although it's still safe with try_cmpxchg(),
I will update the filter like this, maybe with CGROUP_SKB allowed too.

if (prog->type =3D=3D BPF_PROG_TYPE_STRUCT_OPS &&
    prog->aux->st_ops =3D=3D &bpf_tcp_ops)
    return 0;

if (prog->type =3D=3D BPF_PROG_TYPE_CGROUP_SOCKOPT)
    return 0;

return -EACCES;


>
> btf_kfunc_is_allowed() looks the kfunc up in that hook and then only runs
> the hook filters, and bpf_tcp_ops_set_flags_kfunc_filter() returns 0 for
> every program type except a STRUCT_OPS program that is not bpf_tcp_ops:
>
>     if (prog->type =3D=3D BPF_PROG_TYPE_STRUCT_OPS &&
>         prog->aux->st_ops !=3D &bpf_tcp_ops)
>             return -EACCES;
>
>     return 0;
>
> That seems to let BPF_PROG_TYPE_CGROUP_SKB and BPF_PROG_TYPE_SOCK_OPS
> programs call bpf_tcp_ops_set_flags() as well.  Both program types provid=
e
> bpf_tcp_sock() (cg_skb_func_proto and sock_ops_func_proto in
> net/core/filter.c), and the verifier accepts the returned PTR_TO_TCP_SOCK
> as a trusted struct tcp_sock * through reg2btf_ids[].
>
> For cgroup_skb the likely caller is an ingress program running in softirq
> context.  The commit message mentions cgroup_skb only as a possible futur=
e
> use.
>
> The cmpxchg update keeps this memory safe, so this is about API scope:
> once programs start using the kfunc from these other program types,
> narrowing it later would break them.
>
> bpf_qdisc_kfunc_filter() and scx_kfunc_context_filter() both reject the
> program types they do not intend to serve.  If only bpf_tcp_ops and
> CGROUP_SOCKOPT are intended, should the filter reject prog->type values
> other than BPF_PROG_TYPE_STRUCT_OPS and BPF_PROG_TYPE_CGROUP_SOCKOPT?
>
> Otherwise, could the commit message list the actual set of program types
> that can call the kfunc?
>
> This filter is unchanged through 3cb5919af2b2 ("selftest: bpf: Add test f=
or
> bpf_tcp_ops.{enqueue,dequeue}_rcvq()."), so no later patch in the series
> changes it.
>
> > +     ret =3D ret ?: register_bpf_struct_ops(&bpf_tcp_ops, bpf_tcp_ops)=
;
> > +
> > +     return ret;
> >  }
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
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/373369=
89320
