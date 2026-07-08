Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A3431352D
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 03:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783482039; cv=pass; b=OzmPk7uoqX11s2SsaPaEO1nTEj+xT9wi2AjobSd8n6k4nG7/EYqSE/C19bRkjyCEdvIZG1r+PgXU/Rfyk1cno8vbXbCHN1z0vGDwnvfcxEDYa2heRplO3JULMlh6rFe5uAfjW/yd1dVaqqYqb/wXHwK6TncGqfTLlrFTFBgdI9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783482039; c=relaxed/simple;
	bh=vyejKawb6c81OKzUc/Dy5VVny4R59bH07JH+ZWAtYmM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DOodFtQVPyoHNExjpTlEgtGp/eOEkCiP91yYnT8ndlXiqLNWqe11UPrpRLWD1vduD1ME6GP3lHnwSEQOf1FEfkf4sdFZyp0PMXwswGsAhklpI950YpNTKk2MpqKY5P9AU2kHSGvR5LWYjFvTsq+iZoTGQpPLpb9Mf4TCsvShFHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PIA/f1zE; arc=pass smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PIA/f1zE"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-92e512a9a6bso7714085a.2
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 20:40:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783482037; cv=none;
        d=google.com; s=arc-20260327;
        b=FBUyop/t3h8n6+ac1UkzHBc1RnNnVdSraAmc6mCOrOnjt5pE19A5bGvE9z/okVhG7X
         Q6ebbzM72XMXXK0EqRSBLMngq3C9SCIzeZI5sb6qJfgZrDCODQxiTAPBUw0+J145HoOA
         sxInE5eWbHLwBzZqSCeWhh0g36S2sG2fQu1mgjNxihna5fxF3Tn3HImi4wqrOFPAddrx
         4GkbLvmvw6af3Tbu/ASX8k9hVnx+UzGzKLoqXfh4qCMyv8AEu7pMso9zIUpif5L3iifh
         DFuaBfsvkYD58TRkfvV9UPyLcFYdy8GMA/kge/V/QOXp7obtQY20ubMo8ShzGIuOqvVP
         gMxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/Qa+4EiSp2Mydw7M6P1zopsrBJak/NLQvEazW1nO0ks=;
        fh=QVRpjxFjDkZb6aaNPh3BNrQvSzweg94D7N/3a9TPaZQ=;
        b=d/Dlaz9Yn7tX7KxBwO1JCQWIheOKr9BxFYSwQDHUNmMfHwk3Lk3rni74Da2JIV4TIy
         UIolef0JYt1mLkFZXWwu0VE3MAvox6HYYcmsnB2rvKzQGOVOdtbiiYXBYjvnkjOU387Q
         ZifA2Ir8C/SA7aWeBYE8gBAQy6buaWcSvNPxkhi7tFK4ztBzkWy3qeNBRahXDaerPygx
         oSX+OzYjvnbmuvvjSdUozuqqdIQTLTBSH6QWoVHrBM/H1l1ccYKMhLY4SHMNu+Rcf2dq
         rQ2esIroS1guqVLi4J994TPLFxkn3wr7ryMSzQn23+2f038KY1Db+BEZenUA276tog/H
         Zjqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783482037; x=1784086837; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/Qa+4EiSp2Mydw7M6P1zopsrBJak/NLQvEazW1nO0ks=;
        b=PIA/f1zEKPkjsbA4Wzh2/sJo8Hbo1i7/WqlfHYfPZNz0nrI1wuRvqcCMDI9YgC97Q6
         rgluiVYRbc/waOrqlgIFbPXTMeWbFwTlRVCOvLD/fBkwypIvGJLN32voAlVlC6isV/X0
         lGSi5+jKraBAtjdwdcBBzUEyLsaproyf/OwPHDCG0wc/EZBEJjYJ4gZR21M3QeO5i/DP
         5+6oNbMQTO5w3W28SPBLdIiQtDf6l0jD17RGpB1HTjnTa96Z2/zwnNkcEltVIOYc3ip4
         UAW3WLDIYfNCO7PD51E9s5a80lGGoE9LhceJpxTsN8qGI9jntdzGjlpJfdiddXfh6Qw/
         91tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783482037; x=1784086837;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/Qa+4EiSp2Mydw7M6P1zopsrBJak/NLQvEazW1nO0ks=;
        b=bukq7bpeCxB5LgoEDAY9lE4bOyR+Etk4HOyFYq+viPND53rq11Bk2Omq/tZ5CqqMIJ
         gllU0l2PYrZIvIuDYl+1cGewyAXr4lsiv9EjAX1Xh2geZ4TtUGLGetIY2FQ1s9GgyYrJ
         Uu+rIv3ifKjuHTMgj1T/VJa98peh9zL3Sazz+BpPZL5FvGQTUNshGAlzlLWev72hZutT
         Y118mekLYxmqH3i8grXbcWCjV4Pa47tAWU6TjvYjbG/MbfYmLbioIpaDxHtwiaBrkHtO
         MqDu5oJzbNSI4spEmP7X2ojdeRwHpakr9H4r064Nqz1TV4XTfQHH1oOxg7gp2B/DwPzV
         kFBQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr2CxObhXzJf7/Pix1tL7sT7M1InSKTlI4h/sydtkw1WzUujMnaA2v8Ybs5XbZGAJoCYb4G6e4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLVO4mCKNfydQw3s6z6LE84mELoDtz6b4SowXuoHm9BDkz1eB7
	eChxwwUYuhoxaa4wU0svO6ot1jbyUCHYG/ss6CpN3QlRBgy1+DMEsuaY39OzO5IjLvQShxZKnol
	KF/Ntm/djBENQF0OFritHN5pEsmCeNuo=
X-Gm-Gg: AfdE7cm12NLk3M0Q+O+jypZ57a0i+k+sHUL/4GgJTfz7nv7lUrLukYScxqEmgNfUl9/
	rDexfdlFzDPv4BYKPvy5qYq/8p/vvED8KrfiyV19OmnT+SH4Ktpnt/Q2LYT8DB8adeJ2mWd9y3q
	2zOwYSRBPgBvT+I+YcDD/KyUS0ejOKdqJWL4qtsDCguGF5txqHpySQngCts+IZqymRv0Ndu/xPI
	hFWjcfEKvM9ojlK/vnAnpOufjzAIcHv8A2dn4lBCJTg7VOYYUY5DOcLlFr35jnjtZBJzFKiraiv
	9lbUgdyUnVCMCjm288oC1T0qH/IXmTVar8EebQ==
X-Received: by 2002:a05:620a:2913:b0:92b:67e6:8ac0 with SMTP id
 af79cd13be357-92ecf6965ebmr59211785a.74.1783482036798; Tue, 07 Jul 2026
 20:40:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c5a6bff16c0885d3ec756a1cdfb623636d0bdb4a.1783479101.git.dwindsor@gmail.com>
 <6702d2f1-dcd4-4b68-b1ac-daa8661235a0@linux.dev>
In-Reply-To: <6702d2f1-dcd4-4b68-b1ac-daa8661235a0@linux.dev>
From: David Windsor <dwindsor@gmail.com>
Date: Tue, 7 Jul 2026 23:40:25 -0400
X-Gm-Features: AVVi8Cephjp7dZrQ7HVqOogT0cobirvdNaVw4_nk_zdryglSi4jSG3SZ13lnB_Y
Message-ID: <CAEXv5_gC_ze_CURdJMHBQ0aLS=uA8GyisSwnwo1YFTd_++4phA@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf, x86: Fix FineIBT #CP in BPF dispatcher's
 indirect-jump fallback
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Shuah Khan <shuah@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 7, 2026 at 11:30=E2=80=AFPM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> Comment style: /* should stay at its own line.
>
> > +             if (cfi_mode =3D=3D CFI_FINEIBT) {
> > +                     EMIT1_off32(0xb8, cfi_bpf_hash);        /* mov $c=
fi_bpf_hash, %eax */
> > +                     EMIT1(add_1mod(0x48, BPF_REG_3));       /* sub rd=
x, cfi_get_offset() */
> > +                     EMIT2_off32(0x81, add_1reg(0xE8, BPF_REG_3), cfi_=
get_offset());
> > +             }
>
>
> Better to emit_cfi()?
>

Yes, thanks. Will do this for v2.
