Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88C3372EFF
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 04:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792126565; cv=pass; b=ECtmmrwUWrptnzVakqUPSwJSI8l8PWXFD4gqiS9j4ksYEdydKQ2lOX/YCetPHvt0aG1IrPx8aCZT5zvekSGI9yHGQQwDgS7Eh30QndyBlNBpr0d5d78OO8QsPdCWVAb57TElax+xyaUvH7zi55Z08OUzbMvd4zZ75xLS/zksZ94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792126565; c=relaxed/simple;
	bh=bHEyx5CWdu87K8jT+B4RRZF0X7+omCHa3P6e2tPw5rI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b7vrLvAASaDWS2xKhbIPXnNXKyUU+FT1Kicp3uRLj6Cf4H09aLMs9ds0SSY3OzNAbLxNFYtChlDONzo2iZf1rSJzeieZBaW2YbjU3bSXT9FDKB26FCLoutsj/TNYkBT+9/H8P3gG0aidGSxGmji6bjOCFMCjFuBByRK6Nvbo5dA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=UyPhnG7c; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="UyPhnG7c"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-8b0e21048f8so7696837b3.0
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 21:56:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792126562; cv=none;
        d=google.com; s=arc-20260327;
        b=OkGrtElAutzc+6ZgghIh5G52RE4MxwhJ7WiFoFjv+tcZUk5NKi4SZQz8ObzgoDKqAB
         fPfJ3QYzJ48tf1+Z1PWS1JNsNeONDYzbfY09PqLWTxNhYE1KfcvvstbPndO8jKtFtxWP
         fzxu4IqKRICHfQZt6Jycxa3WN8G2MdKQisI2O7D3qKAFO03ofEP+5i5UtqarhuXtdTjj
         V0Qoy3DvL1TlVWTxlmKAoz8hzK4j74l6PXbdS1RHKofX9hOxhWYUVlVurhnCG/WiW44n
         GyVEZzdOFOHj84w6HBjsCBWPJKhqHh5ftcNgS0dDBWJQCES5LMB3XycG7znUP1qzK6rR
         UXEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bHEyx5CWdu87K8jT+B4RRZF0X7+omCHa3P6e2tPw5rI=;
        fh=3Bfwu2C1ZPcvqyZdEKUbCTRFMO+APbvaajEIKZkC55E=;
        b=cqW4fZxrlWVfOJ340U01BO4hoph8znziXKp3D94Gt5FlTNPSAiGiO1RW3vgO600sEC
         LDOlf+h21FXr0cr65HLHteqNabXfn1cGg7FfvBmQitg9ai2CvRfWP6xD0yWEidfc4t2P
         kYGGsFvtOTmQuzK1dyMWubGsEA0SwW0v5oKazXWUwoS++7cbA3Vg8IzkVgKUf+MJINUQ
         QkwfLiXQ7Wqw92bQ/sYePIFol3hcrPsN5KivSiHs/nJRWmaGdZnBtTK3e8GS8gfnwH5Q
         m3JjMkYIcCHRWQXeGyS2WcLGI4Pp1CvHHcHH+c5J1+ur0MBQlzA/EAuUT4LTldHLhVrJ
         cB0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1792126562; x=1792731362; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bHEyx5CWdu87K8jT+B4RRZF0X7+omCHa3P6e2tPw5rI=;
        b=UyPhnG7cHz7RLi+YfpC1XpMlizYeO6ZG+v5wPSVqkpVwgIKftAKEcOWe1xJoaOInus
         u+13Xz9y0QfpLfvKnCYVe7ACTx7S2MIQMpTkYxvVBzTpTqtQZKVi5kAfIN7qp9PX0Jve
         2xlWyqE3u8R2CSozO6tSml0y++5LuOEr8660gKlJyqO12uyYEEjO/mVwD84qiORXGDn3
         uHRgIojTMTGHZU2zNao/FImmM4fegqyA+kMnnu63lKVdNrXPEGcn9TSZtNjGepxQbT+o
         ELauO4xt14b2GL8vFD9shYda5kEzKnQRUpd9oJvO4eJqA9M1PjbDjMqJzjxc4xYs/GXd
         Ksxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792126562; x=1792731362;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bHEyx5CWdu87K8jT+B4RRZF0X7+omCHa3P6e2tPw5rI=;
        b=fNEpfw4jBEfb9aLJ/drBv5uT3ns3jx5rfgOZqq+Z5PkyqAomxonRop4gYavCwIJF23
         JNgbHkbhUal13rUUJUfHiypUmd7IoA8EhbXv7JBFxfEFCOAY7GUg/TZo/a2/UY6e+CEA
         m6yUKTYRZengawIwbSYfudX2S0q96Oh6nFjlbgrP+2dC0tYwf8zh86eqZLJd0kkPN9JR
         UkDY5Vqv2FxcNfi10CcMd2bOeNO5ZyKcAV8pt4+orLo4230Wc28pKC5moKu8l6JVoXWt
         ui3KxIJBUqyM5QVhzJw/9zCIe9CtWhmAKkwE1sy2U79Ewa+v70RBIT+ExzSKDN+GhuBr
         6QLA==
X-Gm-Message-State: AFq9FYLh2p151EACaMmKLOpX0bXQiX97v+f31BURrlvweOD/bi83x2/h
	NBF/ib4ys7Tl8K1Gz+7nVJIZbkMnHs72SvcVQh8BKL47g2mDQHE/uO3EXU7I/l4Hc07Jq3cI0uM
	03JFuPiORe0D5xE4a71jzECGg5/KQg8VPX+YZL3vQJyY=
X-Gm-Gg: AYBFou2VwTDGQfBQrUD/P3/UV6iZ+8U53l7DGk7zR7I2/PeC6xVp27XcXTENKgejgXE
	enjul2gzrpwBN6TAa7b9XOP05Yoa4q2fekrCXD6vNKJPPssreZIlRyck9acfuRr8uCdcAQ9XRjd
	G12GuqrZLSMYuL0KpERYTad+PxLtAN0YEome3lnJGgtcOZys+pSEjj/7cni53frcACXrZwK13Pc
	3fWWBVqEAw4d17FG6DEGZy4BLo+f4FIiFPXT/Vi+Xynycolw/+B1Hm5ghIxLkmlnV6ELSXJxkOy
	I2witG0x65S+olNBjTIfF064OO5tfPpPBTrTvY8qwrN5j4EJiRWn/maABxe5tuoUPV8v7mRicFF
	wdFZjy95oxC3CApMs97rN
X-Received: by 2002:a05:690c:6213:b0:8aa:5af3:e420 with SMTP id
 00721157ae682-8b07ed1e710mr81711707b3.11.1792126562578; Thu, 15 Oct 2026
 21:56:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1791978740.git.zhilinz@nebusec.ai> <ae0f5aedfff54432f75c7bd4d369166c028497b0.1791978740.git.zhilinz@nebusec.ai>
 <DM5WMW2M6YYO.2X4FN4OPSQGJH@gmail.com>
In-Reply-To: <DM5WMW2M6YYO.2X4FN4OPSQGJH@gmail.com>
From: zhilin zou <zhilinz@nebusec.ai>
Date: Fri, 16 Oct 2026 12:55:50 +0800
X-Gm-Features: AclHuK-R2uMw61ooPFJuj3FAuAmc4ceDB4I1tQc0aEakP9ODeTb-n3CB2dzp8Y4
Message-ID: <CANB6i5wui9AzpQy1MKrEUcd1ifUuE64uZc14GQ9WegtnThxrrQ@mail.gmail.com>
Subject: Re: [PATCH net 1/1] bpf: reject unsafe pointers in TCP congestion
 control access
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net, 
	edumazet@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	martin.lau@kernel.org, kafai.wan@linux.dev, yhs@fb.com, vega@nebusec.ai
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2026 at 10:25=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Oct 14, 2026 at 07:57 PM Zhiling Zou <zhilinz@nebusec.ai> wrote:
> > bpf_tcp_ca_btf_struct_access() authorizes writes based on the BTF type
> > and member offset, but does not check pointer modifiers. A BPF program
> > can use bpf_rdonly_cast() to create an untrusted tcp_sock pointer and
> > write through an allowlisted member, bypassing the read-only cast.
>
> Not anymore. It was fixed in July. See
> commit ac65c710cc64 ("bpf: Reject writes through untrusted BTF pointers")
> and the follow up
> commit ee9ad135b208 ("bpf: Reject a store through a fault prone pointer")=
.
> check_ptr_to_btf_access() rejects such store with
> "only read is supported" before it calls any btf_struct_access callback.
> progs/tcp_ca_untrusted_btf_write.c is the same prog as your PoC.
> All of that is in 7.3-rc1, so net tree has it and this hunk is dead code.
>
> The splat in the cover letter is from 6.12.95.
> 6.18.y and 7.2.y have ac65c710cc64. 6.12.y and 6.6.y don't.
> nf_conn, sched_ext and hid-bpf callbacks in 6.12.y have the same issue,
> so patching tcp_ca alone doesn't help there either.
> Pls send the backport of ac65c710cc64 to stable instead.
>
> pw-bot: cr

Thanks, Alexei. You=E2=80=99re right. The verifier rejects these stores bef=
ore reaching
the TCP congestion-control callback, and the relevant fix is already
in the net tree.
My reproducer was run on 6.12.95, so it does not demonstrate a bug in
the current
net tree. This patch is redundant there.

I=E2=80=99ll withdraw this patch and prepare the stable backport of
ac65c710cc64, as suggested.
Sorry for the noise.
