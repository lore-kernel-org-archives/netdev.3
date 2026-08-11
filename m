Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A90743D502
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 11:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786448156; cv=pass; b=SUP+a/NiBoxYzh3r3SY7Q3raoT7fP6/QLZbxdw5af04jPfZLlxR1iM6pMshZoo69xP2eWLv4/17sGhTz64JKVZSh0YdMkh2SreB0giG4QwwNlhgWpEi+lw2kym0/ymfhWT7rIT2ONiy7R9ijwvzbT8GOPTNlCyJMU58tTjuUMvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786448156; c=relaxed/simple;
	bh=sZh3Eij0Ok2+A/9ZSiA4CIhQ+/ECRnDzpFAm/U342+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bItSwDsTXei6o3slVx23UAI9nbjtQtdHcUcOmXeWHOtiNZYmKIShVnemfkPf0KV/cLze4WhyA37d/6oGFJnK79bM92k9pP8Niz516Fh3ta7Z5Vii2C+jR8vTOOe3ovmMGwo4dliPq1XODaGqjfpUKx1rKFxc/1sCy2aWZupCvu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=sCBTq0Jw; arc=pass smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="sCBTq0Jw"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8486672f03cso2815955b3a.0
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 04:35:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786448153; cv=none;
        d=google.com; s=arc-20260327;
        b=Zqcaz2uW1KYJcxbq+SdZZQuvQPaW8tBNNukA64kmmJTlJwVWqeyL9JHKGANLhbOgUw
         8Dcm6DRrJlnoQHUDN8yWxCC9F59GNUwBR2+28nH8yWkbK/FJ4Rq0X6Ai2I85Rj1iimpU
         zI+d0xhk6EkT8qqsbzgJY7eOdpZHwl+74GZzpzUaw7dlKdX/3KMIpYcIygX1FhnunZWI
         TPD2WMeSarvhQ/0i6dcL87yfmfj7j/Te9cx0g5HyVeZkwHclrNG50AjAyF8r1b+7wvQx
         gd0Bfw2UOK8fuU7EElxqVlt4UsNbRR2TjuvL7pD50t9HQj7LQYxASBNsMaP7GTOk1+J5
         poHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jp9Vd2uMaaGzynTBDdsNCfSLq5DjI8JeAUCgMVAGmX8=;
        fh=ZxT6Y4aHgopkazivbeeWQG76MUvaIehIl8w1m7vBlr4=;
        b=YCaAWRg9sW8R6NmqFf2RSkO0ph99o4CSd+QeorWoXOUzGyYN6ocOFRyfEUq2eFzQD0
         B9F4+Ui8B1G6omw5wf/r2HtlDZEagxnDANZ62W+wJYkBctCJ9h87Ie8Oimoa3TNGG52j
         BgtOso1cELAOxHBhvJl/K89iD89h9+rjP0VDuGCVFM9lGKT+dchnkNr7mi0bTf8AlK9u
         l0Se8qiIuuQK0sAFsI56uQw5XxhZfO+ULA/SKyeVwQiIxRaVIUO4mJ72spAyjP0GfA6z
         OX2DGVwa7xM5tWbpCvkDWFUCxUniL3M/3VeZL1UodU/TNobZYfl5NP7cvSwGg8xOwOPy
         Hr1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1786448153; x=1787052953; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jp9Vd2uMaaGzynTBDdsNCfSLq5DjI8JeAUCgMVAGmX8=;
        b=sCBTq0JwlwdrNWiEaCnUh3MHx6GQvc3QfaorCzVP/lRtKVtr1Jn571xXOZpbt/t/2b
         1gq57XvuFZjnb4pZk2UAAqrV9YvoucNpmsiSJwoL1elx+gBpnTjWEZ5iyo6JRXqMkppi
         vsuLDBLEvR9amghYYJfvCps6GYT4MLyPqjw20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786448153; x=1787052953;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jp9Vd2uMaaGzynTBDdsNCfSLq5DjI8JeAUCgMVAGmX8=;
        b=SrnRI/evq0b9Duj9nnQ1o2H/UNN00Ij5l0CC1pbqLlXgynianPjXuuXL3DOs2yPyDo
         QD2mj0/k82anELJNvS4zNSGiUl8wUvgOAumt/HYVnDaaANVNq6o6XzvnXjPYxvM1kuru
         TRya6Pz3UQTx8q/vjqMBI4OJakKcx44BVyiNn460WPd2NBfOthFGwzx8BCd2O5tOoIN/
         rEsAkA8zTmMWWdM+KJuJ7f28tMZ2DsEid0ZgJ9xxmdpUDL9qIjWvsrstG4rDKBL33Eqg
         MPeACtSGNrr5qQcTnOlDyUEQF/PcQE/eMJ8K0lHqZGGt6nTLdBJvmbi8CXRdJLD8lWtW
         y3cw==
X-Gm-Message-State: AOJu0Yx9bCsrcPhhc8644J4c5Wnnx99TX5Tr0Ea7V7nFAfNtAv4xBBTB
	tS2sDwyJFGoSytQgsPbeu2wE/UuFWtuzmvyEj+tal0opK/BoWgYEdx3LhMKy8Ze8ShifNnSxUHQ
	1rCI2LwtJCuC9kQAyFQyjZQU6CX63jUyt/9iLpwMe
X-Gm-Gg: AR+sD11158H3FY90/Pe4YkAGQUNPGI0HoO9GL6wvz+EGvFRXmk1B2NiayyWJw/E5WbA
	66mvoqvAyQFp/m/M3Y4w3AexDmb55Rhour6KWEvRhio7SvJMh7NR2XQrBITj+MtwXVnEYi/kr3n
	joA0wSM7FI0Us51UOHTQfMnABslOztKD6KFSGAlt+8kqYonBis9vvwuX2nc5nnW1N2rrzHX7tBd
	Pp5kQz0bVBDbSLw8ZOhde9w7cgkp9Nl/NiHQ0aBqXVkyOavil/YwCrnGH9lJZ58BVSTOPELnFcS
	hVMhwk5xUFc8CjWf1kf/qK4QEDULTpmLZMiuiZ/OUPh5BQ==
X-Received: by 2002:a05:6a00:a21e:b0:848:34ad:3d6c with SMTP id
 d2e1a72fcca58-84fa8695cc8mr2102850b3a.15.1786448153575; Tue, 11 Aug 2026
 04:35:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260809094418.901607-1-jhs@mojatatu.com> <20260810170533.5bdc7f80@kernel.org>
In-Reply-To: <20260810170533.5bdc7f80@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 11 Aug 2026 07:35:41 -0400
X-Gm-Features: AUfX_mxWkTu9exAYFDwYL1OJAhg4ArY-lwr_Gk_ito2JtRWdYlQYdALEs9Pt5a0
Message-ID: <CAM0EoMke_qk2jJdWW0rHvZcwMNd7RCG4xGkpNYZpPtrSKg2Q3A@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: cls_bpf: reject dev-bound programs bound
 to a different device
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, vega@nebusec.ai, 
	Victor Nogueira <victor@mojatatu.com>, Quentin Monnet <qmo@kernel.org>, Simon Horman <horms@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 8:05=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sun,  9 Aug 2026 05:44:18 -0400 Jamal Hadi Salim wrote:
> > cls_bpf_prog_from_efd() obtained a SCHED_CLS program via
> > bpf_prog_get_type_dev() but never verified that a device-bound (offload=
ed)
> > program's bound netdev matches the TC netdev the classifier is being
> > attached to. This let a program loaded with prog_ifindex for device A b=
e
> > attached via cls_bpf + skip_sw to device B; deleting device A then
> > destroyed the program's offload state while it was still attached to
> > device B, triggering a netdevsim WARN (panic with panic_on_warn=3D1).
>
> maybe netdevsim has a bug then.
>

Looking closely: You're right. nfp guards at the driver
(bpf_offload_dev_match() at
while netdevsim's cls_bpf path checks boundness, not the device match.

> > Mirror the XDP attach path (net/core/dev.c) and reject the attach with
> > -EINVAL when a dev-bound program's bound device does not match the
> > target device.
> >
> > Fixes: 6c8dfe21c435 ("cls_bpf: allow attaching programs loaded for spec=
ific device")
>
> This commit in itself is fine, nfp checks that the offload matches:
> https://elixir.bootlin.com/linux/v7.2-rc5/source/drivers/net/ethernet/net=
ronome/nfp/bpf/offload.c#L579
>
> Maybe the bound-devs got extended for JIT / descriptor access, and
> that added some extra risk here. So either this is netdevsim-only
> (and not worth the Fixes tag), or the Fixes tag is wrong..

Fixes tag is definetely wrong. 6c8dfe21c435 was fine for nfp; the
semantic shift happened from Stan's fix in 2b3486bc2d23 (made
prog->aux->offload non-NULL for dev-bound progs). c0c6bde586c7 then
fixed netdevsim XDP but missed cls_bpf.

It seems a v2 may be worth it:
fix netdevsim's cls_bpf path (Fixes: 2b3486bc2d23), keep the core
check as defense-in-depth without the bogus Fixes:, and walk
block->ports for shared blocks (block->q is NULL there). Or drop the
core change and fix only netdevsim. What says you?

cheers,
jamal
