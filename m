Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71B33195FE
	for <netdev@vger.kernel.org>; Sun,  6 Sep 2026 23:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788736727; cv=pass; b=e3nw4gjqHs0VjEpSQRiIquNRn01Iwm6iZZlPV77z+GtPy1LyY9uOs/XTV7gs3NexyoIM388yrJBrvQOpkPEuSYvW61j1owLdoG/HE0ZIp9lFmYKIJUWk+nlGJKD5eIpgvihBuF5BCG+95Nbyz+Gw5oi9AkJfVq/F3zk3OImdO7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788736727; c=relaxed/simple;
	bh=724XBBM18e/5/TAVSEA0cDWj19CNMiPpyAaDTnCZGLo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rkobp8dipYEY0MP2ax9dp0AwHKO5WjBU3jT/yZ+slgCIINGX79xxEGeob4hcbcNvtePsAjMLBYL7pqrjPy6Z9GP9quqc96FcJCxZ2rvR7530EChRFK7XEdWMyq6iOTLSn3N46UTEztTRicG1nffEZEe8Ou5X1/bTb3WKL3epfWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U0SQSRcQ; arc=pass smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U0SQSRcQ"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-85339ed040aso2170646b3a.1
        for <netdev@vger.kernel.org>; Sun, 06 Sep 2026 16:18:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788736725; cv=none;
        d=google.com; s=arc-20260327;
        b=eZ/69H7JlPgt23Co7wp/EzpXWqDHm2jUGoNIPzfqksdxfHmH2+KJwWiim+HmBKd382
         GfuCLbxKSNqF73UpL8nwBI/++l67hzydCNAbqmim1blXufyd26FXMpCz3oPNSifo2d98
         QJqGtl+9S7IkQpppEjpi0tomHi7m3ccDiTJxpqGylEJgk+Trss0DrwuOtWf9udNM6pUN
         +k0uAbH79iwzfifGU3CyDaoa43XWqrYc2ADeQrBpmWtdZpwLy+mLoLrL23uU4sG9KSqq
         Ii0kbNR8vZX41sCxWtcDppLFsXzX3sveJgkkzrKtxUkWvXg2NctJvRhE4G8AoD35q0//
         2DuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/lolE45Uhyd+sThQbwL8EFg5+bmDGsCrRM5xzs+E9ks=;
        fh=IsPHG0k72sGBl31uIxBOC1qMbtwUJbZaSTHjhVtzbno=;
        b=FfulpRC+TzFYSwsGBHeXyRxXbm27O5p5owpW3/KjzR6IAnw5HrQPGPofUFpdcpIoD8
         6qXj6dplsRPVznYr7vS1k0zQ0Udb4EOlEg3f3wjL+l4K65kQwjyojAnaj7KL3X+99j/h
         zFpihMyuOh5pQ842X4XMxkAVa4VQMRHz8nP3Z16OJBk52pqHdTjyhvERBiUVaaSZksBf
         SJ4VcKDk8zkJVZ/evIBBe2e4VrVjbvcFm3kO6PpMZM67z5nDmc3MZWC7N1sqIyiqdO4q
         STpsGT0YRX5oDheHpgkE0VHAQ84387gLEbslfs9ckJozkYpQ9Admn6XEIAH2K3O7ldts
         qygA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788736725; x=1789341525; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/lolE45Uhyd+sThQbwL8EFg5+bmDGsCrRM5xzs+E9ks=;
        b=U0SQSRcQpQGzr9UR8MK+L9br7STH2Yj3Gw/0QQtpr2LsD7ahUiJPVL6Hd5qyU9tIIK
         LYn9bdXjdL64w/Vt62iOZr+0E6AtPvOvgSMO3Lpo4cyMfumMjOPfrIPqqz+aP/SPxtp6
         PKT78kyRXTaqAnSnkIJEk3RYEVUHwla2xZ4VZKe8qbIfh6mr9kfeMJ/VKro0SxcMWyoF
         X8cS15YfGT6ccabKtuGTcw02h4s0rbfgMU8RbQOL5A5L3KuIVTjjfip0nMIjHVcjmEtt
         M4lQdXCKLE14sGYggseBHXhbq71cm0Ao0+Jqs8JT2t47o3mlf2z3XxfcRwATtyvFSEZV
         aAQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788736725; x=1789341525;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/lolE45Uhyd+sThQbwL8EFg5+bmDGsCrRM5xzs+E9ks=;
        b=gxapbQS9dSQbEnMElWegGrUApHPyCwPP0iO38N0RAv0HchmVNOyLW3VyW4ualZ7p0n
         bx5AjbaVEWCzl4PKo2kofmRWK2rIu62wZZkJTYhoHuLqRuFrhHDSmYVYG2I2lqgmMAE9
         D2C/1G9fpUDfLuvonUU1za3qp1wTWs6G13Wg5XV7s9pq32icKQd7BN05iAJtr97Ah6px
         53as6tfqKFIEYXiSgaKnni+tlbVCxMdl8s8QeGRg0oIF+xBDiA1ai+yJk/50FRqSXMPf
         Tx0Z4bywTBIZHgY+i7SQ1dDXryi3KPyiXTxy8wgFjlj8gwsWU+PUZd72vDaJCiiOZxg6
         SUHw==
X-Forwarded-Encrypted: i=1; AKwUvByy9O6C+dDfXkv9WVwnthz82Ho4tKJ1GsrHe9oyj+ReH7k5j9/iQZpWiDl7V85wnJuJ2etAhqU=@vger.kernel.org
X-Gm-Message-State: AFuF++n96L/1BjmgINqSAGQHP27ZEjYwd3AvpuIkgXsrkjeSyzXEKKqw
	sBKx29fOzKzT+fP4kIMUIluQ0mFFC8jDbFj017m9LrSuPnfy3QabNuwjIyHaXNaO1RhoY9FmsXS
	5mOrttqr+0AFWl4TqN0kWAfZIITfanyU=
X-Gm-Gg: AYBFou0dQZnpjcX8O6vCJmVT+jad/7z8wXXOGWyZUN4mRk23Rb+qysnAFkuf9LYhW3S
	yeydiJNKOmJIcIVUWdGcAcYfOjNhJmSoCvGtnXgTypNIJZbj1ecOLLxpSIEJd/zgPwRZ98PHb9+
	PkP+L6p9sTd/ytMJ/m8K7Ws6rcU9lBoQE1feY5JA+rI3bvo9RNI2z6juaWQCTuPDFqpkC2xb3B9
	xh9vZadp3GQJ9xy9PQjrbTeBRnm+4uwWG8v0buFXEU1k0HJtiDwbMrnm6nREm6ZZJYTrtJ1iR3/
	x0omEIjwVKyyO5qVF8BXyCVBCG2nfDZWFQq2DVSngkjqQgkG5ssg3dFgcXifH9scA5g4SAekGYc
	iJCadT+JXlvH2/XPHgIOVwCt32LXKZ5ESzeSL6K0=
X-Received: by 2002:a05:6a00:13aa:b0:84c:5b65:ef86 with SMTP id
 d2e1a72fcca58-86168e88261mr23644101b3a.17.1788736724956; Sun, 06 Sep 2026
 16:18:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <apl_5AVsAYLjVX5C@sirena.org.uk>
In-Reply-To: <apl_5AVsAYLjVX5C@sirena.org.uk>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 6 Sep 2026 16:18:33 -0700
X-Gm-Features: AcwNN1WQk-B2sF_oTeT_a5F-7sgNbJL45Qm1_BHeZkWfObnP1i9S5tuc4ycX_W8
Message-ID: <CAADnVQJuAGh0P0sw3wWWPAmq1OmAX27KNiCYn6__rZkGs0hPrw@mail.gmail.com>
Subject: Re: linux-next: manual merge of the bpf-next tree with the bpf tree
To: Mark Brown <broonie@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Networking <netdev@vger.kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 7:10=E2=80=AFAM Mark Brown <broonie@kernel.org> wrot=
e:
>
> Hi all,
>
> Today's linux-next merge of the bpf-next tree got a conflict in:
>
>   kernel/bpf/backtrack.c
>
> between commit:
>
>   e3e4f66cc4b72 ("bpf: backtracking shouldn't clear outer frame R1-R5 for=
 callbacks")
>
> from the bpf tree and commit:
>
>   5bbb242c08590 ("bpf: Handle R2 as a return register in precision backtr=
acking")
>
> from the bpf-next tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>
> I'm not entirely happy with this resolution but I think it's OK?
>
> diff --cc kernel/bpf/backtrack.c
> index 47282ffeeaf94,653db80bcc47b..0000000000000
> --- a/kernel/bpf/backtrack.c
> +++ b/kernel/bpf/backtrack.c
> @@@ -533,8 -538,12 +537,12 @@@ static int backtrack_insn(struct bpf_ve
>                         from_subprog_call =3D subseq_idx - 1 >=3D 0 &&
>                                             bpf_pseudo_call(&env->prog->i=
nsnsi[subseq_idx - 1]);
>
>  -                      /* Sample the return registers before the callbac=
k
>  -                       * handling below clears R1-R5.
>  -                       */
>                         r0_precise =3D from_subprog_call && bt_is_reg_set=
(bt, BPF_REG_0);
> +                       r2_precise =3D from_subprog_call && bt_is_reg_set=
(bt, BPF_REG_2);
> +
> ++                      bt_clear_reg(bt, BPF_REG_0);
> ++                      bt_clear_reg(bt, BPF_REG_2);
>  +

It was more involved than that,
but now the conflict is resolved.
