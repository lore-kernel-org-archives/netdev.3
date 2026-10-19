Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792427261;
	b=uI2JhYt7OwQKNOjAY86u6o/SAfBW1UKkKA+DJbfPm/Is312Mxq2Ao0zFPejJMyiqRSQk
	 yHFgdkH4+VWvenjiAAfztMMEcOQzIQxTqFMXCTXbsL0JiTHAnKS+8Rq2EHMzpM9oS047S
	 RBR0JLEUHkgDr3ubrosIDgjc7yQqnbG+3p/PR2oEN2N+UZhHo3RIOfkMv4IzdRW0qMT3Y
	 PtDl7J3dVOPxmbjMXeVRv53EJ0pKw0QocCCy9EXfaKlJc6GlnaKaautSzIbOzehUJYAPZ
	 TyVJlKr/0Cuvn99T+Nu0hQnInGIs+QpAgr9ucwlzGL1ySqzPfXu2zrlxbMw8PJ6+7QQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792427261;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=jvYDp8Hgj7nrDsJX6hOppStmzsVdbwBuZBD84+051RI=;
	b=udHtN01qWXp63+CuKP5H6CL7v+1ChPP1nWufAd283H49aN83Wqtc61a0K8F9PlCwmb3L
	 Fnf829RCaBNYflMiAfmnJe/Z1XLhGzi0jza9jPT22hi1LmAC3QZbS787l1zrLMUHeATSH
	 6LZ9o4UBaP7jGC2WwwvWK7woleQXIjvbsm8dnomSkX2GWu5wmlyEXtQFvCDvnB9ckXBqt
	 2mSWZ23FxtUAnSTmMNIpdXm9/iFEPhVdRhi3fRZMKcZPhPtbU7r67epN/mlUulxhb43wU
	 kVrGmRwTHNSE07a2NmmWH9RunRlJyK62voSUgdMVcy3Y8NgbzuIqwQL4nkKR17A5/Qg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b="Vg+MAJ/D";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6E2606A33A
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 16:27:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE6E2606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Vg+MAJ/D
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6afac79b3a3so17008a12.1
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 09:27:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792427259; cv=none;
        d=google.com; s=arc-20260327;
        b=Vs+EeS2ozhx0diT+13IOv49sLlX0sSJvCaqkZTq4pmyxv2MDy/COephWCf+QrS71D9
         LJQfE0gmJb980YO7r/mEQkBqL8OVQZP6I5rOvORBKQV26sGYCUsMF5vxMwFR7VG6037q
         AaKPUTOYiK3thTdXlllozWPZkUBRdPBjcqbeEtii/wbbBoZgsWV/mn4ggwfqvPuAILYp
         Hcd761DeOBIXXhJnBPdA39BKmrEK2iiYw18PJ9tipDuMNbejr7lYysmI1WrUnQYpHhbC
         miV8a0LE4Jz/X0K+nlNVPXync5zc9Xjbwkv6qPoF/Uc7gLC9NJuJXrrYvumk36Qiq2Xd
         7hxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jvYDp8Hgj7nrDsJX6hOppStmzsVdbwBuZBD84+051RI=;
        fh=063oi7RuDvzv1VomBYm82Xj4unkWFItNS9ELyp5nTmU=;
        b=nyMte0uMmTB3vTefYq/Tlf/Djfjb3DH4/aIFA6KbDykJwugadjnAMY7/uJnmJLiRn+
         Z9Xjh49zZbwlXwzhy/NcdCIoizVoo49SKPq4rbNtuY6BEinO229F4OZCSj3pRWgbuXc6
         qdY1yZOlbd1aizObQ7Dkucdbsi+3Fly6pSVTZDCFUBEiC2dJsqEQsMYF0PvpFNWdVPqO
         Z/X05QuFva304jJNw8cA/PiHRAnB0N40UU6G4Ihc9VofN8nmsg2Y7qBsUVw28rYjdEhX
         7OXAG6lTC+mPKPO/l0QsqyS/TKWOZ+0HNLhr5DQfdkMs5wIQWwkfje0eeNYNVrA2GQG8
         yBBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792427259; x=1793032059; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jvYDp8Hgj7nrDsJX6hOppStmzsVdbwBuZBD84+051RI=;
        b=Vg+MAJ/D/s6BzPq2oMNvrIO24+Zc38CbeIk8kxNnS37t+MfRvYxhs+VlXNtz3u+LkH
         eWelEEgPiZ7qckP5A/zjj5zXZjhGCxK7j82MqFjPpAkpUV+miZs+pfj2DQ+MZqS/xEbw
         AD0OuYQDfu/zj2XfCqyx8gu/IwjPONtrUE4BZVMmR4ZHI2/aDKQ8VzQXZcAY+YH4OdhD
         PNQ3YA1pS1x6IsPb5783cUcgNoxeXfjNmbenJBIttZXiD6m7T1jybg3wwwFEVfNTbbR8
         t0FjAq/kPsrGzti+21HaV//wgHfdyyVWokclcAHt79+gJKTK99uLpv6pdKF8WtqqQ0GL
         jdtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792427259; x=1793032059;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jvYDp8Hgj7nrDsJX6hOppStmzsVdbwBuZBD84+051RI=;
        b=TcJzrl+TEcqyWUeTJLlxJzREHfsEOCLoUSlV3rMh07qSERMYhkpbQNHzbTI5v399G5
         8/IrSuxTak8OIxSEPwhsQPOncCt/mloWOwF2ln3X5U39Ikt1NNcR492l7iLZnQGu9fQh
         r3hYk7LHTlWsvnLVWbG8f451yQfAtcM2kogbTV9GrR2HRH5r0B8HF4qHcrgafwcgJnC0
         2zebxwqv4dMvRnn9vmvb44zMx0RDhi+/TH4bDiJRYvyn6RrLhqEA1UAlsOUPOF8PbfJu
         11HcbZoxmQ+QIm5KJMwMicP/18x//pGrA0Vp9OM+Z+Rs8oslyiRBZSjvm0gOTbkiZS9b
         T0Lg==
X-Forwarded-Encrypted: i=1; AKwUvBzN1cn4OvK7vYE3OC7Vna4gYsbCRcfTNajhd1YVjnoFWnkc2OCvrS27xM2jmZVFSCfRHnQR6ZE=@vger.kernel.org
X-Gm-Message-State: AFq9FYI3zlBis08+6kdwFHszuznxi0cFebvRTGLfBCddBpSgjl8BqO3A
	wjSIqgbsO4AqiPm0fVezYGq/nipkXg0etyO1wExqVrKi0qDPLBC3mT/1SxU5guJlGjQ4g44YbuL
	iJLbIhb2rIJ5R7G2fA7iP0CDeWuqXQNWvNvHsV0mx
X-Gm-Gg: AYBFou0DiI6M1+RETZUFLgn0Awvzv3yXRjlckSQAHOUnBKgkAxPE7BCS3gUv7/xxlXs
	0QUMa5VovgP/ZY+1Cx6Qr8I+VnXngzMjAbV6cd4fzgk/SeOZqmBCosRi/6xNhe5JETS2bO5vKKf
	uqqlMxHyoxDFPMNyVfsmRn8FO9X8RVs2DM89vVXab4KFPc1UVepJ7eq3XQSfywftZcKmWd8ZoPC
	obT8pUj3YsqC26RpXT1nBAolrucA4IJRNFOD7RJ4HU5TOTfd4OdZyDjCK88l5vNuRMA7iQi+Wf2
	9a5IP6e3tGeuB1WqN6wnIcf2XFgmVf/EdhVJPdR9nKHbHHohwWTufTyvzZr93BgVW84ROv88u3L
	UB0PfdwL7MafAb84Wp3cc
X-Received: by 2002:a05:6402:4052:10b0:6a6:8513:7e14 with SMTP id
 4fb4d7f45d1cf-6b3ae336676mr18681a12.9.1792427258726; Mon, 19 Oct 2026
 09:27:38 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019-b4-skbuff-bug-on-followups-v1-0-41dbef50b9f7@toxicpanda.com>
 <20261019-b4-skbuff-bug-on-followups-v1-14-41dbef50b9f7@toxicpanda.com>
 <CAHS8izP4qMy9MFxVrRAZR0sec-XmkuxShrPTe2XNvHSKdQh-ng@mail.gmail.com> <CAF=yD-JORWYaYZ5YvpXg46vxCPLoceh3AADe0XKD-P+rpZT5zw@mail.gmail.com>
In-Reply-To: <CAF=yD-JORWYaYZ5YvpXg46vxCPLoceh3AADe0XKD-P+rpZT5zw@mail.gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 19 Oct 2026 09:27:27 -0700
X-Gm-Features: AclHuK-UIC0HG6JOck2i4c0hPYtzFxPXwWW3DcSBGnG1oasbGjmvMuZRGvs17qg
Message-ID: <CAHS8izOA8S5GhPtpaD3EPWS_vBZZABrwqgd_bDKVm50VSuwS3g@mail.gmail.com>
Subject: Re: [PATCH net-next 14/15] net/tls: don't BUG() on leftover length in __skb_nsg()
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Josef Bacik <josef@toxicpanda.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, 
	Fernando Fernandez Mancera <fmancera@suse.de>, David Laight <david.laight.linux@gmail.com>, netdev@vger.kernel.org, 
	xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 9:23=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> On Mon, Oct 19, 2026 at 11:13=E2=80=AFAM Mina Almasry <almasrymina@google=
.com> wrote:
> >
> > On Mon, Oct 19, 2026 at 6:51=E2=80=AFAM Josef Bacik <josef@toxicpanda.c=
om> wrote:
> > >
> > > __skb_nsg() counts the scatterlist entries for a range of an skb with=
 a
> > > copy of the __skb_to_sgvec() walk, including its BUG_ON(len) when the
> > > skb runs out before the range does.  tls_decrypt_sg() calls it on the
> > > same range it then passes to skb_to_sgvec(), so a bad range would BUG=
()
> > > here before it got to skb_to_sgvec()'s error return.
> > >
> > > __skb_nsg() already returns -EMSGSIZE for a frag_list nested too deep=
,
> > > and tls_decrypt_sg() fails the record on any return below 1.  Return
> > > -EINVAL for the leftover length too, with a DEBUG_NET_WARN_ON_ONCE() =
for
> > > debug kernels.
> > >
> > > Assisted-by: LLM
> > > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > > ---
> > >  net/tls/tls_sw.c | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> > > index 312e51270f29..1c578ea47a1b 100644
> > > --- a/net/tls/tls_sw.c
> > > +++ b/net/tls/tls_sw.c
> > > @@ -142,7 +142,10 @@ static int __skb_nsg(struct sk_buff *skb, int of=
fset, int len,
> > >                          start =3D end;
> > >                  }
> > >          }
> > > -        BUG_ON(len);
> > > +       if (unlikely(len)) {
> > > +               DEBUG_NET_WARN_ON_ONCE(1);
> > > +               return -EINVAL;
> > > +       }
> >
> > Ugh, why DEBUG_NET_WARN...? Seems WARN_ON_ONCE() is more appropriate,
> > after all we're downgrading from a BUG_ON(). Another nice thing is
> > that it could have been done inline:
>
> Because that still triggers on systems with panic_on_warn. See also
>
> https://lore.kernel.org/all/willemdebruijn.kernel.140f4eac91ab3@gmail.com=
/

Heh, looks like we have the opposite instincts here and I missed the
initial conversation. DEBUG_NET_WARN_ is fine by me too. Thanks!

--=20
Thanks,
Mina
