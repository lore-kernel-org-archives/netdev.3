Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8343B3502A7
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 01:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791337429; cv=pass; b=clO48XUOBsTRe5Crcr/steuOaEATVagEl5KMj/kmOCb235f47wByyVc0VdS/GClGc1NQnHr45CbJNnm41tiqykI+8rZGkuaomcNngIY+O5ZHZxVNvftYe/5ADusS2aEttBgrOg9tPX09+BAv6PlM+uszcp1O5Ds9B8B+sg/4g4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791337429; c=relaxed/simple;
	bh=MBWdR1GxlvvVqaEyNujZIDbcJb/clAS5HIycWC0LYf4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cj8yTO5CBYS7nrvwsUKaz6WaDrwtxnVOuB4yu4B3B1ZlttBEa6g0JtoDDid4oLom27q04FD54u1oja7NS8Zq+zxVMMtwW08FHY5s7S/Jcz0ZEdHJQiqy6LTEONCW7e7sck6aEI78X+4AMygksIVLwsXPHwnQAgPUZoRj/VI92Rw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=octane.security; spf=pass smtp.mailfrom=octane.security; dkim=pass (2048-bit key) header.d=octane.security header.i=@octane.security header.b=VIy4kl8K; arc=pass smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=octane.security
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=octane.security
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=octane.security header.i=@octane.security header.b="VIy4kl8K"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a16c1608faso15453915e9.0
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 18:43:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791337426; cv=none;
        d=google.com; s=arc-20260327;
        b=SMiBxoVDIEbqUUq3NlKRuWahm3DyV3111d7lnY69D722Uf7I6NUqxqKLqUxmzF0aQT
         24+P0y2Z2euOfVJHnOU0xZPUR4JFescsB5cgRhxkasAvrKdM33EjrxmdpGTTxL0FGJ07
         jRtvOuwOoNYrGHD0E5EsXr9OHTp47FMVreCFRv5Rcw+73923BVii6FlwfyzL8quWc4bE
         +Wjv/vvakxVgtZOFQio/3MjoV6g/zOCvA6BMNvdNm7k6SPXj/ejYlLuOLro+ndULM8Sz
         l+mzpJaNPJ7nfmUNg9NqcLIIuVTo4byuOSai7f6QUnohisGW0sbGCVwv75U9M9xWHe9M
         xptA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Z2R0isuQWmYfjmDBBvPENUql08JMDQxxwrQkmjzWgTc=;
        fh=0Z6DA0bp0dRNTLFsg/QoA7ysMvN4y38kEuuW+sDIJlA=;
        b=gXhM1C1k4OePf5VGL+IOalR3M1+ShQMhVW8MLcCEbRlQSXS809VfzJeW1pvFTtpvwI
         iRRorvZwSkKF/dZfpuxxIMqawRIHc2946ngagIytDlh9yTZMBb/8dWhVcE1MkR19iRP8
         xNDR4hxiQOYepm6MzTUeFp1Axck0oRlA3Xe4MjTvYgSVQoRcZv2mE3yNVpPAzHUbu/bH
         scftM734nESvwmJZNIGsRpnFqE0UpUIKuJf28Uarst+xy0UVWp5RuFIppEfxYq+NiMQH
         iwkGt7QxEP/kqamyKjFul3P5Duxzf5mIfI33J1kUS+YrzaeUlCjJpQ8PCMxQuqOMvx5b
         Altg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=octane.security; s=google; t=1791337426; x=1791942226; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Z2R0isuQWmYfjmDBBvPENUql08JMDQxxwrQkmjzWgTc=;
        b=VIy4kl8K9nyYoJ4xTaIvuOA3XJmxtego6NP/Ovxz2YwHq14dsATF9Xh4SapdlJs+CQ
         /x09sWIL4C0wt3+QbNVyKeMrZziS2GNd/ysyZG87MI5kC/yRzi477L5C3V6tCTwvleye
         X+wb+N2Ala64VzrjYlOCm+rToIPHHRhctloxc93rgGhabklyurVXeah5ZJpfg8l0nPJY
         y+h8I8t51fp8wJj4dhBV8CVjtPZQY3YUeChHLeJ0q2KDG+3fxuM5qyyyUnwuxJuHSGOF
         wAbWM7BiabaQjuWnhDnfVcBuoDGOcBr7PSdFMjFFtxU0cQbfZjEH0tUhAqAbrM4TPksA
         9sew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791337426; x=1791942226;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z2R0isuQWmYfjmDBBvPENUql08JMDQxxwrQkmjzWgTc=;
        b=tkymVFn8AwgVBigCppE+tGKhV6H9qleCHt6M5juw4g8EztQ9CPfO1Y1XDEVMC9jR/m
         ooy5fNukibIl9icu6KPb8X2b5HXsGaFMJfpKsa+y5nE7BdncGP/LUuB706Jwci9eOnBM
         PYp5h07wRb18Bf/B+2f+KxQ137Ytw++EI0l8tM3+CWKdVta4Jta+cJKJVgOdRjxew5Hi
         N3rTF0LhhvJW/bi1rC7fJvzikrpE3CNBgpMlmEWvqM3MZceAxFuycYsCaSpt6N5dOoLB
         zn6nBOaEhH92s0BiqC0kZm23lgCcZpFvyVqqhtd7Rrv25Rvcu7KPdC9TS7oJcIFX0Zr0
         6viA==
X-Gm-Message-State: AFuF++kmXM4bjGTaBMEv2inzNvFLTy+m1FUy6IDKqh35VZ5ORyrIcDOC
	yKbeqB24TqY9jGbYnSo1mwm5xmJH01UhwxQaHFlybMVe7wafINolWwfTNXnYUzBCvNkOiMj362Y
	kUgrrzppdomITEl4h1dM/C93/mEiUN2vCzDqE2DF+ZA==
X-Gm-Gg: AYBFou3WMlFN+w17F3PQKJ4k9mKGPYIaIBfvhTLP2JZ2ijgfnpT/lmLShKgL4g1kOTy
	viJJfFwfs+Cz3beurllvgNcyoO1WFkIX/TUSGKpi5I4I5n4ZuZIHqnRPxlfXymDVW7vfVYVEkYK
	dNh7Iu2LR31hvzL2pVJXBD2k4L4mqRKbu5I/OCdvprtIlGezO9M6hBa9JQ7tGC35UFfPzodGmSe
	h7e7/4wDzilcWl8IAp9ax2bufbnuJFxPNSpK2qbtZzKdx0vfI+rIp3c4dppRxIQmzunoHtjqcXk
	HXcwQUReCWUp5SWHpHOp37gytYsSMgXvv/s+TOTPXJWrQKUKJL1w/YGreH98kiyU+vcYpoPAwL6
	z85iTRTB7BJWG8DLz4XgyT/ECbiLfY1jP9TyuR+m8Jjo=
X-Received: by 2002:a05:600c:3f0b:b0:4a0:ec5:46d9 with SMTP id
 5b1f17b1804b1-4a180080187mr8701305e9.0.1791337425901; Tue, 06 Oct 2026
 18:43:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261006125720.81227-1-shubham@octane.security> <661e8b900c97d701382af26462bead7277eaa41f.camel@kernel.org>
In-Reply-To: <661e8b900c97d701382af26462bead7277eaa41f.camel@kernel.org>
From: Shubham Antil <shubham@octane.security>
Date: Wed, 7 Oct 2026 07:13:34 +0530
X-Gm-Features: AclHuK8z21OahSGKxZJkHHl4QwGCa6UFLpgcI58u5NRwTzLJWRTQgLKYVsOlN_Y
Message-ID: <CAEBzjKEFZdKWHa5puYH6dKvaesCf-KGmZ+Z=fFECRi_0PhiY_A@mail.gmail.com>
Subject: Re: [PATCH net] net/rds: ib: drop fragments shorter than the
 header-declared length
To: Allison Henderson <achender@kernel.org>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org, Giovanni Vignone <gio@octane.security>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Allison,

Thanks very much =E2=80=94 I'll carry your Reviewed-by on the next revision=
:

Reviewed-by: Allison Henderson <achender@kernel.org>

And no objection at all to crediting the earlier private report:

Reported-by: sungbyeongchan <tjdqudcks0424@naver.com>

This bug was found and reported by our team at Octane Security. Would
it be okay if we add Reported-by tags for the people on our side who
reported it along with the first reporter in the V2 patch?

Reported-by: Shubham Antil <shubham@octane.security>
Reported-by: Giovanni Vignone <gio@octane.security>
Reported-by: Robert van Eijk <robert@octane.security>
Reported-by: Paolo Gentry <paolo@octane.security>

I'm happy to send a v2 with everything folded in - your Reviewed-by,
sungbyeongchan's Reported-by and ours. Just let me know which you
prefer.

Thanks again,
Shubham Antil

On Wed, Oct 7, 2026 at 6:43=E2=80=AFAM Allison Henderson <achender@kernel.o=
rg> wrote:
>
> On Tue, 2026-10-06 at 18:27 +0530, Shubham Antil wrote:
> > rds_ib_process_recv() accepts an incoming RDS/IB fragment once the
> > receive completion reports at least an RDS header
> > (data_len >=3D sizeof(struct rds_header)).  It then trusts the
> > header-declared total message length h_len: for the first fragment of
> > a message it stores be32_to_cpu(hdr->h_len) in ic->i_recv_data_rem,
> > and rds_ib_inc_copy_to_user() later copies up to h_len bytes from the
> > fragment pages to userspace on recvmsg().
> >
> > The number of payload bytes actually received into the fragment page is
> > data_len (after subtracting the header), but it is never checked agains=
t
> > the amount the fragment is accounted to contribute to the message,
> > min(i_recv_data_rem, RDS_FRAG_SIZE).  A fragment whose header advertise=
s
> > a larger h_len than the payload it delivers is still linked onto the
> > reassembly list.  The fragment page comes from the per-CPU receive cach=
e
> > and is not zeroed, so rds_ib_inc_copy_to_user() then copies up to h_len
> > bytes to the PF_RDS reader, including the uninitialized tail the receiv=
e
> > never wrote.
> >
> > Reject a fragment that carries fewer payload bytes than it is accounted
> > to contribute before linking it onto the reassembly list.
> >
> > The issue is reproducible under KMSAN with two hosts over rdma_rxe
> > (Soft-RoCE); the same reproducer confirms the fix stops it.
> >
> > Fixes: 1e23b3ee0e94 ("RDS/IB: Receive datagrams via IB")
> > Assisted-by: Claude:claude-opus-4-8
> > Signed-off-by: Shubham Antil <shubham@octane.security>
>
> Hi Shubham,
>
> Thanks for working on this.  This patch looks good to me, you can add my =
rvb:
> Reviewed-by: Allison Henderson <achender@kernel.org>
>
> Also, this bug was found and reported privately by another contributor, w=
hom I had
> counseled to send a patch publicly before I had noticed this one.
> https://lore.kernel.org/netdev/20261006205204.1322102-1-tjdqudcks0424@nav=
er.com/
>
> I find that patches equivalent, and this patch was posted first. But I wo=
uld like to apply
> the reported by tag since sungbyeongchan was the first to report it.
> Reported-by: sungbyeongchan <tjdqudcks0424@naver.com>
>
> Thank you both for working on this bug!
> Allison
>
> > ---
> >  net/rds/ib_recv.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/net/rds/ib_recv.c b/net/rds/ib_recv.c
> > index bd6cb3ffa..fee77b6d7 100644
> > --- a/net/rds/ib_recv.c
> > +++ b/net/rds/ib_recv.c
> > @@ -949,6 +949,15 @@ static void rds_ib_process_recv(struct rds_connect=
ion *conn,
> >               }
> >       }
> >
> > +     /* h_len must be backed by the payload actually received (data_le=
n),
> > +      * else the unwritten frag-page tail is copied to userspace.
> > +      */
> > +     if (data_len < min_t(u32, ic->i_recv_data_rem, RDS_FRAG_SIZE)) {
> > +             rds_ib_conn_error(conn,
> > +                     "fragment shorter than header-declared length; fo=
rcing reconnect\n");
> > +             goto done;
> > +     }
> > +
> >       list_add_tail(&recv->r_frag->f_item, &ibinc->ii_frags);
> >       recv->r_frag =3D NULL;
> >
>
