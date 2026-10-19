Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792427014;
	b=5TJV8UdqBHSJ6CegsmBZyp6YXgUZLXgkaTvPHb8E3aBp0YiXzRtTFbluAmlbKicFXtlm
	 46mSRzXMq3tIT7Ui1qwSpxtEuWdz1iXzmVzxf00QAOqnnu7nu9oM2z3chKHlZgXlDFsZZ
	 JPmyMvFONPoXzU+XiIbncavGGl1RMTgfut4XwVdufHD1f91cq3zKIUW4+KakO5G7NFqXt
	 1Ys9KcTRIQw4yQwfIGU34E3H036RPWJBgkpMNdnRvEIcAtmSwzRa+2yQLtNbk6BNAabWi
	 71/9dr7aENxLNJnJHuTkFq9/IeyKPTUSzpGNDsUXbzHKyIeAm1m0UwM6XdZEdihPxhA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792427014;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=DTIxUhdK5WwE/ZvzqZ/orvmnDy6Zp8KzQx6MCWL0bYU=;
	b=2yRMBsKn/Afwqn1s/rupIbGHJ7HKN1eqDg2CKxpAi565NkLG/4iNRQHGiop9GKVTE/m3
	 orYR7gExTjm5V0vhFamFeBDG6P6mY9tvpkVyWmjxKl1nCxDarjV5K+Xre1oviG7s9EA88
	 N8RJTdm3XPunF9TLA5D6fm6T7PqDmG4efIsFofzX+RQNmn4Nf0bqL5+3a5mx/2J7hvqEQ
	 +U75lNXFUkR7TLsX1L5DYh3S7+iNm+1pBMrjfZ6kVMksiB95eTz6xlM6c5vr4CWvKbNr+
	 9NpZNiPe14Coj2mPov+APeAklBcHsR9ZmT68HR6ff649KkeqRLUjxnpEE673iyEOhng==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZQnmfMX7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.179
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8337E606A31B
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 16:23:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8337E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZQnmfMX7
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8a05f2d5cd3so667972b3a.0
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 09:23:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792427014; cv=none;
        d=google.com; s=arc-20260327;
        b=OBtS0nZo497+g7E+T2YzUh08ast0A6UR+O/7aH6Y3AhaBpXg0sbJU0iVK6VTEp29SO
         2RBlPCBsD8/D7FTKrEW+kQdqz2WlC3pIl5xFK3nBVC59zlFaWoQRJFhHo71SswvnZFwG
         fmnozndPf+DyW40+kkdUrGdViLuv1WBQDgfKbaGWBob4+riEnrjjFYWlZ75PHNiDKxMy
         clkC5m/IlV1Ybn0Id1PqrukQuz2nHAgDuTuj8QRR4R/mdqkbN/0hijYBpyQRo77eN7yO
         P479CrYxD4iyrYOY48TEbSrce5IDrz5FCR2RjYane5jw65pU4/Mzp+GJOASKSNQHKgQr
         PxTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DTIxUhdK5WwE/ZvzqZ/orvmnDy6Zp8KzQx6MCWL0bYU=;
        fh=tr2t8IZOLMeKEPKcCHh1dZt6FGfaYw63Yu3atIevpqY=;
        b=Xm+t/87in4aCuvPUAK7WlqoXzOKUnM9iUXpeNlo+7p5sK/J0j7uZAtGFHWZsG3D+DE
         bewiGCJy8LQfU46Q52wxs/gyekrAfktQRZAuattbHJlfugNMt8Pn28IqWJHY4jduRbmV
         OlTXJt0Ci+aTMKptzoKKgxwOfKyAiILovomHVUFyb99xhfm8WA1tKCOTaC10r2t0F4MS
         G9lp+5RcwQ+avaPOQ7KNOR3VDL0GU0s826eYz56BwW7bByzlxTmpfjNC19dDFRwAuzem
         8xoJlEgPpd9o9dKlU3oC8QhUTaIAgpuHujQ3IWIjRKQDv5q8w0E5GmXBEepARnt5l6tq
         KKMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792427014; x=1793031814; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DTIxUhdK5WwE/ZvzqZ/orvmnDy6Zp8KzQx6MCWL0bYU=;
        b=ZQnmfMX7ZcMY3LOvhD3yXqwtvFGBjK6Pxxsvus1K9FIYdephlvmnGhC6+O+2LUn5aC
         rorqove0GeQHuWIaMFcWHYlUZ+SnPGSDeDLzK9+Zzt6ypjx/+MDUBEZK1L9tbbAvihsq
         +T2IAWpuN+r/2XGWTwiPDGjA+Hda5j7HOZSy3eHRTaDlyirMFwJUyrz/6qQqXOpaiUHL
         4cd/XFf0PFN7Ax9xABJhi1ncfZ778X2t11w3dNmc5wv+dqxa7HNn4j9Afs3FkZwYMR4n
         1+8opQE5Yt8d4EgKYHQUIYUn2oYIpXsnuZXr+HO1sLq3e/kDQj4EgZMvcOCz0G19n6Q5
         nTWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792427014; x=1793031814;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DTIxUhdK5WwE/ZvzqZ/orvmnDy6Zp8KzQx6MCWL0bYU=;
        b=Pruoun1LLG/opRR15di5034vG+jiX27IN/NOPoD0dhlJd880U1wqaJkE+lnxSRFhgQ
         uoLdkfjT2SxrSo5u22N3tmBozxOAtjvsrR8Xvm5qBvffHZPghjGuMhg4NgMH3t9ImF7T
         riloEp/IjfJ9QcLMRXKG8oMbb29xs8P2DmfTMiDE9xsbEjAIwaQvuMAI/7nN4dXoDdiW
         b+LueCpWoDnJdOapLdoyNAv+h8aenukgfqQptZO7aT/ewIC9KSxb2tfMU6133TlcNIY8
         ReJ8MJrperOPQLSwGcH0RlziUj9l5TM4MGKUe30/2EOzFO366xUJVAHTsm30qRZXytpq
         nxOg==
X-Forwarded-Encrypted: i=1; AKwUvBzSVCJ+863J5UYh9AahylGsmVe6QpqdUdYilyprzInf2zkb3mZ1zMdVrMmnbD+m+98prOn4b78=@vger.kernel.org
X-Gm-Message-State: AFq9FYJH6yyGGj2elLpCnlW/clc83oydZo5945VDlVm6nBCKrtu7AhHi
	6KBwRmUciHhyYzcYn/jT5VCPD5BQk1fnGp79/x9MWkU2ASz9j1fAB4au0XZIqQuDf4Oec4otuZC
	x9RmZ88sIJGt3jPxuO0BU2MQMoJJTP1Q=
X-Gm-Gg: AYBFou2ZqahyvhKT4MJX022N7kP+EmoGbP0TZpm0+ECcfAPsiGGMMHzjbaX63Cd3+6A
	UxqTQTvgDwPIDROdDtqWAzUlV4qQY5xnEq6D+ci5fi8XmiCdzah2dOy9VdhbH/WLM45FxygL+8Q
	BU+p+Tu8DllQVCgv/8wjEgBQ+RsB0TgzBOwEI5xoy4oINwCO12fLHtjXUxItxNKrRHwfcMvSMq+
	JUxsFDiFzJX2z5S8KwmOhJ6g1VbW9ULSR61K8pMxV10F01huFS+n93dpclR+Zvg72lF9kdD//zq
	pKr+6FkG5hj5ptAYzzPIRFDTexsCgcTp0Zg2QEXoLMiEg4xsh5gDOHOanekxkjOaPEPTNrbM0qw
	IF9JDTE1ffjc8lr6zdvbKkgXpt62N9bLgXkDMoVAeYcYAH/PiZfa8OMOINpvToqAbBlGWrUJMxB
	dF
X-Received: by 2002:a05:6a00:3316:b0:880:f278:6af1 with SMTP id
 d2e1a72fcca58-8a04a44afe5mr5370952b3a.7.1792427013773; Mon, 19 Oct 2026
 09:23:33 -0700 (PDT)
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
 <20261019-b4-skbuff-bug-on-followups-v1-14-41dbef50b9f7@toxicpanda.com> <CAHS8izP4qMy9MFxVrRAZR0sec-XmkuxShrPTe2XNvHSKdQh-ng@mail.gmail.com>
In-Reply-To: <CAHS8izP4qMy9MFxVrRAZR0sec-XmkuxShrPTe2XNvHSKdQh-ng@mail.gmail.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Mon, 19 Oct 2026 12:22:52 -0400
X-Gm-Features: AclHuK9ZHv_xyJSLtrCr1JvpLx2mRNJEtxy6hgM41LaZO6bj4mAjFn_L38w5UDA
Message-ID: <CAF=yD-JORWYaYZ5YvpXg46vxCPLoceh3AADe0XKD-P+rpZT5zw@mail.gmail.com>
Subject: Re: [PATCH net-next 14/15] net/tls: don't BUG() on leftover length in __skb_nsg()
To: Mina Almasry <almasrymina@google.com>
Cc: Josef Bacik <josef@toxicpanda.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, 
	Fernando Fernandez Mancera <fmancera@suse.de>, David Laight <david.laight.linux@gmail.com>, netdev@vger.kernel.org, 
	xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 11:13=E2=80=AFAM Mina Almasry <almasrymina@google.c=
om> wrote:
>
> On Mon, Oct 19, 2026 at 6:51=E2=80=AFAM Josef Bacik <josef@toxicpanda.com=
> wrote:
> >
> > __skb_nsg() counts the scatterlist entries for a range of an skb with a
> > copy of the __skb_to_sgvec() walk, including its BUG_ON(len) when the
> > skb runs out before the range does.  tls_decrypt_sg() calls it on the
> > same range it then passes to skb_to_sgvec(), so a bad range would BUG()
> > here before it got to skb_to_sgvec()'s error return.
> >
> > __skb_nsg() already returns -EMSGSIZE for a frag_list nested too deep,
> > and tls_decrypt_sg() fails the record on any return below 1.  Return
> > -EINVAL for the leftover length too, with a DEBUG_NET_WARN_ON_ONCE() fo=
r
> > debug kernels.
> >
> > Assisted-by: LLM
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> >  net/tls/tls_sw.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> > index 312e51270f29..1c578ea47a1b 100644
> > --- a/net/tls/tls_sw.c
> > +++ b/net/tls/tls_sw.c
> > @@ -142,7 +142,10 @@ static int __skb_nsg(struct sk_buff *skb, int offs=
et, int len,
> >                          start =3D end;
> >                  }
> >          }
> > -        BUG_ON(len);
> > +       if (unlikely(len)) {
> > +               DEBUG_NET_WARN_ON_ONCE(1);
> > +               return -EINVAL;
> > +       }
>
> Ugh, why DEBUG_NET_WARN...? Seems WARN_ON_ONCE() is more appropriate,
> after all we're downgrading from a BUG_ON(). Another nice thing is
> that it could have been done inline:

Because that still triggers on systems with panic_on_warn. See also

https://lore.kernel.org/all/willemdebruijn.kernel.140f4eac91ab3@gmail.com/
