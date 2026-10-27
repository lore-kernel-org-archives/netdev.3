Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793109928;
	b=1vYsqQzl80vPgo/LH+Wjg12/TU09/xEUTg7ygz/HTGqVXDrfNySJx6DnWtp1V/D0mRs+
	 PyqOgvrVqzY4DOvAwovD808N67Lur9UJKM9JWoycK3l4Jpeq0akguFd/MiiRqNhjlDX19
	 695YJysRPz/Tp1WF86VHsDEMnK9kdvRyrnw8BpdAfv9JqIdtNAJd0SfoTlGp30eDdZVlt
	 ogSqHm+q156s/r1jQ4JDGZolOXMTmQ5om4JajsayP8DZaA1PczUsqUTXBBkkZ9e6gvoph
	 xkimFrIQMVVJyq2r1VNP37iOB+2cb3PbnfIaKlWH3KfdyswtDPU8nLeIS42vzX24Q/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793109928;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Iop+eIWxjZIW6uottq+HbmMrDgO+DhHU1tnkWo06GP8=;
	b=sh8h9WH6Idfj7wCOwicCNuKvdNJQxeqf1NzbJhJ+Z//fHkdIehTC19kd+6jiLdDAA50B
	 GIGhNQV5wazO9kVSXxmgKowfSsAiB5A1b6F7w1urmKpXuf9pLX2+s83FFOfaMLLXL+osO
	 iazkMZLzScFExa42XsHCPi9A9xCnVq7HkV8rORMfHhQmm6y8sY/V35mJy8e3DKCR73K0T
	 y74WfSTWugDcS6kXXR9YTCTRp4Hisu+oXefiOf1k+9XZZkZ6jheqrjIYPFKP0e0+aAODE
	 AKZA7WDIeOid/f3HcVCAxnzXauWvZdkwNBIe1cLCCSstJ38Nv+IQ2WHF6RqEVk8zKLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KDKRVJD7;
	arc=none smtp.remote-ip=209.85.221.182
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606C8606A31A
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 14:05:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 606C8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KDKRVJD7
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-5eafb65e169so2864135e0c.1
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 07:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793109927; x=1793714727; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Iop+eIWxjZIW6uottq+HbmMrDgO+DhHU1tnkWo06GP8=;
        b=KDKRVJD7WZjpirgzRwhdX7atV1mGA4pbiHCuJUNcNM2GMREq6N/2/tkC6aIBrGh/3H
         dmt856lj5iNMOJuOcS+c8OurvRDbgI5X0AYTi7ReEqERhgHdClm9+tlaZLKj5P6zmU0t
         zUrMEDEMo2oHg0kK/SbsI2bO1UwQJavbW9l5pAEZ/lTjFwyO5Gi14zpoiPLMEnIhVL6W
         6FvHKcHMnPevokvOm+p6F0F/TbQ325t43LzY69JYK+pD/W/BjH3SsZsZSIJKr2WQn2Uy
         88dyv5IKtijqXJ2+GhoqzZ4+11vxQcAYyGWtPexA3e2xVH0kAIKuNlsWflKvrOmSp+eU
         47wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793109927; x=1793714727;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Iop+eIWxjZIW6uottq+HbmMrDgO+DhHU1tnkWo06GP8=;
        b=EM5tWHMlIcngIEMHzezCIrIyWTiLLR1TNcxYo9kOtGAJSwXYcqJalPG8onOVCtpW45
         ZzyPWYytVvSzGR3GYLq1gYVneUDO7ai69g+T2QGBOesRkyiUEI4eVX3AjIm+R1lCPDs4
         MCoubGkKipbSd60E1OUxSj4avBuAemtKqA8Gdz+ujxl/VL5XLOrrAKX+8oNGNKfIVBG0
         0E/PDYHOqdmOKNmKlVVQdykimiI48MASIvKVEjvgaIHgpj6S0N7azmi80DFMvo/rXmB3
         HZOe6yT0eBquyK9aDuCSVHtR6fDC4bklIUoVYsJYYf5/diKntQmtztwzSgtBQvcvKVuq
         cuqA==
X-Gm-Message-State: AFq9FYIEjRkD5f+xVDH5daDYbPfDXACye7iM74lQnx/SGU6I47AoWVhT
	gUSosezOEta7IVWp1wZnoYoX3boZAlxbFstbH3O6/7TWAhJ/h2lLJnmu
X-Gm-Gg: AYBFou1nzlaBOBSUEykbt8hSWsQ3mVQHReMs3BZduvDpH6oI89ijJ/h+U7iZadHA2OP
	rwVzFpBn+Xots5vXh5H+PcXAANy+ZCP9N0PTUMkx+xIQRowvGfdIycLngXwlnIsLz2n4K7jU5XM
	y5IF4l15UsupdIbe+nOvDExMi3O04LpmXhkpu0buadkn9cV/34B/LTQxf3ikKR4FN7EcmQRQFSh
	pRAMjV+FAL1bPT8U+BS6jKPa8+kvxSJYdI3x9mMa071OXm2eG6fLZ4WQiMYyAQ721mt0RDm2DWl
	HjQPiPs362QBg77oRBqLI1dZnGBj19QvJLIDx4XkVKA16bPjB1rdK1NsdCJW464lkcfO9jXr5NG
	RX3WUZlETRIkFtfoJiYcE3qP+PqD2aEiXnjj1PnlY7QVDxHSfpAKqrsCuRiZFnKh4lWeYbzVsFp
	s39tnUujazltPAoVAQ9EMvzWpvnfcxJKx8jXRjrLFy4VbyV4ZJf1J6M5yrzdfqJOPk8MOmivu6K
	ml78X/RHQggWJ4qXRNlZgoZAWCr83iJXuEdZUIB8mExO3CITc6cdzPWzmOWUyfgcBgBb8QManyL
	Nh2j+uDV6beQwMSqSu4pH+YxhOaZB0vSqM6aerJ5UaLPIMHOqPmQUucw1G5L2MkpnS7aHgK/fb1
	jHrD3bwgZTE5huCKtW64=
X-Received: by 2002:a05:6122:3b89:b0:5e6:82ca:c551 with SMTP id 71dfb90a1353d-5ec23374c31mr3948016e0c.22.1793109927236;
        Tue, 27 Oct 2026 07:05:27 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec23067632sm11586456e0c.0.2026.10.27.07.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 07:05:26 -0700 (PDT)
Date: Tue, 27 Oct 2026 10:05:25 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev-bot+sashiko@kernel.org, 
 clementwei90@163.com
Cc: netdev@vger.kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 jasowangio@gmail.com, 
 andrew+netdev@lunn.ch, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 weirongguang@kylinos.cn
Message-ID: <willemdebruijn.kernel.39836b1948cab@gmail.com>
In-Reply-To: <179309578401.3134.11519975030981154705@kernel.org>
References: <20261023092239.186665-2-clementwei90@163.com>
 <179309578401.3134.11519975030981154705@kernel.org>
Subject: Re: [PATCH net v7 1/2] tun: keep a kernel copy of the socket filter
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
Content-Transfer-Encoding: quoted-printable

netdev-bot+sashiko@ wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
> =

> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 0 (2) =C2=B7 Low: 1
> =

> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchw=
ork
> know by including "pw-bot: cr" as a separate line at the end of your re=
ply
> (one such reply per series is enough).
> =

> - [High] bpf_prog_validate_classic() does not run "the same checks that=

>   bpf_prog_create() performs", although its kernel-doc and the commit=E2=
=80=A6
> - [Low] The kernel-doc for the new exported helper
>   bpf_prog_validate_classic() (net/core/filter.c) says it returns "0 if=
=E2=80=A6
> =

> Pre-existing issues:
> - [Medium] This problem wasn't introduced by this patch, but a filter
>   replacement that passes tun_copy_filter() and then fails on some queu=
e=E2=80=A6
> - [Medium] This problem wasn't introduced by this patch, but
>   TUNDETACHFILTER leaves disabled queues with their old socket filter,=E2=
=80=A6
> =

> --
> =

> tun: keep a kernel copy of the socket filter program
> =

> This commit keeps a kernel copy of the classic BPF program passed to
> TUNATTACHFILTER in tun->fprog_kern. Each queue's filter is now built fr=
om
> that copy with a new sk_attach_filter_kern() helper. It also fixes the
> inverted error check in tun_attach(), and it validates the program up
> front in tun_copy_filter() with a new bpf_prog_validate_classic() helpe=
r.
> =

> Link: https://lore.kernel.org/netdev/179027275318.2160803.4185895144088=
175048@kernel.org/
> =

> > diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> > index 242899f7fd071..e7d9f4480a89f 100644
> > --- a/drivers/net/tun.c
> > +++ b/drivers/net/tun.c
> =

> [ ... ]
> =

> > +	/* The instructions are only verified when a program is built from
> > +	 * them, which tun_attach_filter() does once per attached queue.
> > +	 * Check them here as well: with no queue attached that would not
> > +	 * happen at all, and, now that tun_attach() treats that error as
> > +	 * fatal, every later attach would fail with -EINVAL instead of
> > +	 * rejecting the program now.
> > +	 */
> > +	err =3D bpf_prog_validate_classic(insns, fprog.len);
> > +	if (err) {
> > +		kfree(insns);
> > +		return err;
> > +	}
> =

> [Severity: High]
> Does bpf_prog_validate_classic() really reject everything that
> bpf_prog_create() rejects? Its kernel-doc and the commit message both s=
ay
> it does:
> =

>   "The instructions are verified with the new bpf_prog_validate_classic=
(),
>   which runs the same checks as bpf_prog_create() on the copied program=
."
> =

> The helper only runs bpf_check_basics_ok() and bpf_check_classic().
> bpf_prog_create() also goes through this path:
> =

> bpf_prog_create()
>   bpf_prepare_filter()
>     bpf_migrate_filter()
>       bpf_convert_filter()
>     bpf_prog_select_runtime()
>       __bpf_prog_select_runtime()
> =

> bpf_convert_filter() rejects any jump whose converted offset does not f=
it
> in s16:
> =

> 	if (off < off_min || off > off_max)
> 		goto err;
> =

> __bpf_prog_select_runtime() can also return -ENOTSUPP when a JIT is
> required but did not run.
> =

> Take a 4096 instruction program: BPF_JMP|BPF_JA with k=3D4094 at pc 0, =
then
> 4094 BPF_LD|BPF_B|BPF_ABS loads of offset 0, then BPF_RET|BPF_K.
> bpf_check_classic() accepts it. convert_bpf_ld_abs() expands each load
> into 12 eBPF instructions, so the JA offset grows to about 49128, and
> bpf_convert_filter() fails with -EINVAL.
> =

> Suppose every queue on a multiqueue TAP has been disabled with
> IFF_DETACH_QUEUE. tun_copy_filter() stores this program, and
> tun_attach_filter() loops over zero queues and then does:
> =

> 	tun->filter_attached =3D true;
> =

> >From then on, every IFF_ATTACH_QUEUE, and every TUNSETIFF without
> IFF_NOFILTER, calls sk_attach_filter_kern() in tun_attach() and gets
> -EINVAL. With the corrected check, tun_attach() then takes the goto out=

> path and the queue is never published.
> =

> Isn't this the "every later attach would fail with -EINVAL" case that t=
he
> comment above says is avoided?
> =

> When queues are active, the same program fails at queue 0, and
> tun_attach_filter() calls tun_detach_filter(tun, 0). That frees fprog_k=
ern
> and clears filter_attached, which doesn't seem to match this part of th=
e
> commit message:
> =

>   "a TUNATTACHFILTER that no verifier would accept now fails early and
>   leaves the previously attached filter in place."
> =

> The sk_attach_filter_kern() kernel-doc in this same patch lists -EINVAL=

> from bpf_prog_create() and -ENOTSUPP as possible results. That also
> suggests the two checks are not equivalent.
> =

> Would it be more reliable for tun_copy_filter() to build the program on=
ce
> with bpf_prog_create() and then destroy it, instead of calling
> bpf_prog_validate_classic()?

This sounds to me as the perfect being the enemy of the good.

Even the addition of calling bpf_prog_validate_classic is a nice to have.=

This series fixes a real issue.

Yes, some issues are still only discovered later when the BPF program is
built. But as long that late discovery is also handled well, that is
acceptable.

