Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845F74119E0
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 07:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788766246; cv=pass; b=GDMvrbBTOJ6AnrkTUhsjXAwLCqwlDM978zwHObYMyat4bao80MU8fzHg+qqevIncZXafkZXVmzvXclywdybFjWn9rUo+uL+d9xpeprMtVpGi5sa2FreCDLJksi5B8RfUp+TPiH/fxWsUaMA4w3NugJ3XlOM88kc0SSuT66hzV9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788766246; c=relaxed/simple;
	bh=ws1lt2A9wuTY0mZ//UjpSJvqUAKan2kCqa9w0DLo52c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K81fd7YQbNYgb5ec+6LjJ/XV/yx4uYJR4YJ7QPEJqMGSH0rCd+XipCx0BO27lj43fu6sAENvh44QMNrziw6gTmG5BlCkylkqUmXcpx7UJoMfePkAkJicU9HM2YMTG9Jvy5cDkvRgI1Xbizkrl7XUzI1P3dOo9PYn20crAflnPMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=r2xJc220; arc=pass smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="r2xJc220"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-3a1e9f55e03so28723551fa.1
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 00:30:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788766242; cv=none;
        d=google.com; s=arc-20260327;
        b=RQXC6gMD9irBTcf0yJBF9dRwNcyht2MaoOQ/z7a57RBgDKebyalHr9k2ESnve6xtwK
         ZoQQCjQ4T1czj6rtgqtC0hSjHNhZ4X7umur/sPDOKmbUhalJoapq29aP9pu2C6RKOpB7
         8h8BbaKu1dpgvTgW/fZ1cHpbd9XqIiCgErunwkpsZlSnLzphZ0yEnzxDAQBcdS6PQn2c
         aJDxarARG+SuiCMhj2sIWxBKDKEwhaVCK60cRKoya+zm7RxxtXdjyz2dMNIXRWVWfAqL
         RZl7WmwmkogtunTvY9+yeyTd2PVGyLj2GYxSepcRu5jcnK6z7JbUtk5e6M7yOfh75CG9
         xl8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=K8pzZlzdqRIT/RWxSl/nFSJH5gf6fu3+T1v+V4JsYz8=;
        fh=ine+tQB2q30PsVDteuWAMWHPfwZCeKPXdHtFUa7yXgs=;
        b=lnoiUoBm9o25OW6aHWwdPh152RRjUO3awEmBYO4Pn+gdBEAS1dM5++bnRytuVr2hcq
         3xK4yU9nSAXzcLKmbY12YRecJrpEyXN62sV94G7Udf2SgT6HdSupAFgAt68SHahiKGpT
         I6zxUsBGyWoYNqscayzuiv0cVvdtxJTYJtTtUghFVmQBYaJ09IcYmxF5Gj1x2WErKphg
         cyGxnQIGKs6af2MTbjimrberB3jpkW1SmPFBgvK1DIbAQK+IoryK/mQlLLkNSeswH9Fp
         dVPkz+rKtIGpQTjkelqPr79hT9BK7ZffwKQeMLVMuv659lklRQDFr5Am5OZI5kb5/7eq
         QiHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788766242; x=1789371042; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=K8pzZlzdqRIT/RWxSl/nFSJH5gf6fu3+T1v+V4JsYz8=;
        b=r2xJc220Zc65Y7W2MaMaq3YAsTrjViOVCgIePlgRrEVuKOUCWhaobo2ZN7lFvrwJmH
         jwhgA2Ey/xrqrDsX0hTrSZArRxWNUbTJ1BBoXFDAuqPVGWS3uzGaKwJtrj/Q46uRMssS
         o1MQx7lWWvmkB+Y5OpNmQAepBU7XbVWnx3dk+9NRACPts7fAe4ufO3sOWgfakB6qSATi
         BRw1VEHwqp+x4iOmusvYYb8A47gpu6ssJcKBZyybXPBYZQ2Kj63vfBr+ZkF2Or4l2THO
         Q/7Q/eobjosfi0XLUIJxdEXDoTfrjgRLmSfIZn8te4/DI2fK1mfOnuavwXgBtxjZX36d
         suxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788766242; x=1789371042;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K8pzZlzdqRIT/RWxSl/nFSJH5gf6fu3+T1v+V4JsYz8=;
        b=GnP7yERN1IqGsK05q+HebHFOD7Lr6Wrm/MsJrm1s8YzXGj7Gqq1DiK6PO2ANE94LOY
         vASj/y26n1cQCg7eWbP3laOtax0GIvM35fL0jRAXAwwX8PjZqfdocdljPYuj2ABT4Oy5
         fKfh7TJ1c8T5f4yB+y666et708N1WXQfLoCrGwscSjeklfDzNQMoJugJY8EGnuk2Z8Wb
         ntOsTqzoZNL3JEcgqNxEcVFrrC5YzTRk9gwn++tPZv5Qhyr5+jL7tsdhoq4yFY9foddI
         KRxAT2Ef2QoJu2jYty0zWAz/ECwlEWf1VHNVQ2Jot82PYzjwnhsy6Vf8XT8rab+85N16
         LHtw==
X-Gm-Message-State: AFuF++nToznf4juRLuaZz7/lXAS+D8NgVk2jBSIAHo5ECKDOeCyHhOkH
	JOhYTe4Dbuz/dnBJrWOurvHpMEQYvqvz4ytp7G0R+ZSk/ZGGGB0hzloHIHee9ZlJgC8A5e9jH7U
	RQUd+gnfRQ63qotONvFHm0G2jwuQZ3cNvjj77y4Id17M=
X-Gm-Gg: AYBFou0kojUcE3sqiU62AlLUHecnOtVBPqheVJmyz1ELllPYdicra8N4830+QthZ/I0
	oR0cf8jocieZrBQI/c+qctuxcgqoyOJds5umP3TX/9c+S3iGvpXkusQjg6PqMjzGyqjgApyYVvq
	1qs5UmiGTXpKgtaCifk7iAy3pjO8znF2o1IeUprxOpGOPAPVrJ58Q7pUaR8sHqdlkQjEPv/MBGz
	gtDVP8Gt5QZaoEiCR82r0gxZn8uVF7C1xm3hitnFTPSHNEkMJWNV9OBRlknelCPuUWkR1Eq0HNG
	xaa8GgZLC2vR/m6eXK+9Vbs6C3fPx1jGi5ylL4+zf2G9q7Url8aw5wpnLARGcvn+CgAbggGq/oA
	=
X-Received: by 2002:a2e:be1e:0:b0:3a3:314d:1169 with SMTP id
 38308e7fff4ca-3a371b39b13mr25408981fa.1.1788766242436; Mon, 07 Sep 2026
 00:30:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1788668475.git.zihanx@nebusec.ai> <e8782427d0b3cd1854ab8d141eea224b53db55b9.1788668475.git.zihanx@nebusec.ai>
 <CANn89iKdX2-a+VhWa4CyDODSZByk=r5VRq38yQhLYBFRQ1Wy3A@mail.gmail.com>
In-Reply-To: <CANn89iKdX2-a+VhWa4CyDODSZByk=r5VRq38yQhLYBFRQ1Wy3A@mail.gmail.com>
From: zihan xi <zihanx@nebusec.ai>
Date: Mon, 7 Sep 2026 15:30:30 +0800
X-Gm-Features: AcwNN1VDHzbFiSzp25pLBVGEmL8dzveakPy4WZ3YZpO1QfoeCh76H4bfuzwlclo
Message-ID: <CAANe3eQpztNQF_e0qHXxAr+GM39tUdU0FS=1kO0h5LY+v-iVGw@mail.gmail.com>
Subject: Re: [PATCH net v2 1/1] udp: diag: bound bucket lock hold time
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, 
	Pavel Emelyanov <xemul@parallels.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Vega <vega@nebusec.ai>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 7, 2026 at 3:07=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Sun, Sep 6, 2026 at 12:35=E2=80=AFPM Zihan Xi <zihanx@nebusec.ai> wrot=
e:
> >
> > udp_diag_dump() currently keeps the UDP hash bucket spinlock held while
> > running the request's bytecode filter and filling a netlink response fo=
r
> > every socket in the bucket.  A large filter and a heavily populated buc=
ket
> > can therefore keep bottom halves disabled for an attacker-scaled amount=
 of
> > time.
> >
> > Collect at most SKARR_SZ matching sockets under the bucket lock, taking=
 a
> > reference for each socket, then run the filter and fill the response af=
ter
> > releasing the lock.  Resume with the existing (slot, s_num) dump state =
so
> > the next batch can skip already-walked sockets.  Leave bytecode filteri=
ng
> > until after unlock; unlike tcp_diag, a rejecting inet_diag bytecode pro=
gram
> > is the expensive part of this walk.
> >
> > Fixes: b6d640c2286d ("udp_diag: Implement the dump-all functionality")
> > Cc: stable@vger.kernel.org
> > Reported-by: Vega <vega@nebusec.ai>
> > Assisted-by: LLM
> > Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
> > ---
> > changes in v2:
> >   - Drop the hash-list cursor, dump_done callback, extra module
> >     reference, and inet_diag core changes.  Dump state is only
> >     (slot, s_num), so the existing handler get/put around dump() is
> >     enough and udp_diag no longer manages its own module lifetime.
> >   - Batch at most SKARR_SZ matching sockets under the bucket lock
> >     like tcp_diag, and run bytecode filtering plus netlink fill after
> >     unlock.
> >   - v1 Link: https://lore.kernel.org/all/133b6aee9e2c908c9da37d5585b3d2=
cd016906cd.1788187473.git.zihanx@nebusec.ai
>
> pw-bot: rejected
>
> Please limit the complexity of filters.
>
> Anywone needing complex filters will implement them in user space.

Agreed.  v2 tried to make the dump walk tolerate large bytecode;
that was the wrong approach.

I will drop this patch and send a new series that rejects oversized
programs in inet_diag_bc_audit().  Richer matching can stay in
userspace.
