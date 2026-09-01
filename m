Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83988440646
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 15:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788278240; cv=pass; b=Erf9DL9M6mY+x2h+OuZgJ3M8uN9HfOPCNYneNvDm9TTARgNb8XFCNjFvEsaiRe2jf6I3wg3rRH0+Csvz+t6w0f4d+QGIpp7tH/yULI6qbzSbzMhqYvwwY0l9F3GJ1e95e14egwmK4wpu2opjmYDsT68et1NquSinMqm/kopw8U0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788278240; c=relaxed/simple;
	bh=0c8eX5045Wna8ziNden3Y6xoUliGlNqVmMmXrRc2s4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GDSXnbhviHavXBkcnxxe+BnPEPyeUqczAaK+LWJUctItBJFmIiTt+TTKCnS27bApGemScMTJmVnVHNeQWdZkrVYH0WSTt0rYZs8GQG8WHfMY/5XAkyXqs3uLMJGknFYTq7HJF/AMnjljBLdR2QNfZovckrs2YsvuIjfB6ZkKokY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h70ekUkB; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h70ekUkB"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-52de50e77ffso59245831cf.2
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 08:57:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788278237; cv=none;
        d=google.com; s=arc-20260327;
        b=cBO+YnMKNjRUOjojINgFNl+d1d9p+35F6G9vnfmU8v51Ha06JeiAHA4en02L4A1al8
         rLUm0VVivmrxC8/QB+lcgzB21gxRcrNCOotHPyWzaCzH6q2PlmkgDePgoMagqFQ7aliL
         6bo73I2Iy102t5meD4UuXTCVi5sgw6aBDqzJ0Zzsx6n3YN8JOqjZ50c5Ce0nmLC7fekT
         WNGp7LM8imDirfCBYyEnLefn4TdpS1Yg50RJjp8zJ6GcvH0F5hcGkDXi4nCqCYV7wHlw
         KIG9nzO9njrxEUrbz1kBO2nwWJ1uFFP0d+S8kDfdHsVPEAJXYAjqdUGKjFo68vIGWqyE
         /NOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0c8eX5045Wna8ziNden3Y6xoUliGlNqVmMmXrRc2s4s=;
        fh=JK1IG33p1PqE5R+Npow+WTML4ydchIeBdW8IEHy7+5g=;
        b=pa5Km5DvROtzoactOySP2Nm1WJhIzWndUcM+ZrKJjwMzIPndAZVGqqtN+8Gvs62+7m
         be/k3CHLcbb71LQFT9juhm6i+NkVHQbIv1ySkht0DWh4Rro3LeGTuYgOO+StEEu250ck
         IzspkV7Z+gX9T5HFT4x1qNauhkUDCFN15lmUlJiadcyA+QKp9vZeMwce/DFwd9IVQ/7C
         biCvvKey4xTQAsjj+czsGA6SBvHqraUg0yutJQOyFwB02vsJVHtlMpMJ1P8S47lp7Boq
         BfUMcUSgnX98PAtqTL0QNLtOAebV8sz53vUmpo69Kc4rUgrA9IuCruARB2FsVMpGCeWT
         pGAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788278237; x=1788883037; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0c8eX5045Wna8ziNden3Y6xoUliGlNqVmMmXrRc2s4s=;
        b=h70ekUkBwz6octO7VnJrhhKA+mYJWukq9I1chbkeA2Gvcz2scr2RdKQhhVi266s1re
         9xzQoAYfrgutJ7jJkaons/HnVC8f5k2KB6DNJBIcdmrkb2QKjaspRgxZ+IFtbqyJFzxh
         BdUxYZcKOeOSHQJ2FIQtIJ9xJeFlpOxkdmS29WrZgmH4bwfp72AVEymMxDWhHN+ZrpHc
         bK+jcs7DwDS4uRnxhG8TiYfI9vjBsLU6mTTINyLgHzlc+DUg7ZCAqns4qKJdPjbaNb1c
         HsW/1mewYCkq9N+JG788O258jGc5mhJZ9C9DJFoKl0WITlWbsscYpWNwK+tuE1q2Gt1+
         LRBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788278237; x=1788883037;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0c8eX5045Wna8ziNden3Y6xoUliGlNqVmMmXrRc2s4s=;
        b=UqR31/NCnsUDpZbBJUHGYhdNuPmJcH/o5DLGWLdSOrj459lRwLU8lw5Zv5VhY1b3VS
         dVbqOfcXMmNrnTNwFqIfRi7n2cLROHEdwjQpKht00UAYqNocSVb6B8zmGV5xTcBLruAi
         PQS5r6hGqz5vPtPB4gsR5s1dRWPEzimJBcu/n5V/wso1gN84zZl3HUhphjdSCe8XFClV
         xTxAyvcgym+ID2j3lbR1QgYAcT9KWJ2+t9wzO5qN89xIto+ovZijLih52rBKk8dGd57p
         jg79pe0K6zjP1gSUPJgnxVi+IWIt3iyCaDhVilabnZKYuHyzmEy/OQxoX8Klt424HkWF
         DUmw==
X-Forwarded-Encrypted: i=1; AHgh+RoyPZei83gamicbZ+Qu0xhnNgsEoDkqrTJpm4PI0GCafnQ4a+uQ7z5KRF6EihX0ux4WZHX6OJs=@vger.kernel.org
X-Gm-Message-State: AFuF++lxKbCer0+/BJQuEoj5jwTWKBMeQXFcCiHSMiiadycRsp3JKvlI
	H7nqWzLs6MoOzVnhZbitLMbtPiAUfUZeRK+df7OuU/BCSvjPQ26u7EvCqj4TeQow8/pOfLpJ8Ws
	PDxxRPxZqfYWtbA1A1dCqhJ7ikgKCvpyS2f69qzHa
X-Gm-Gg: AR+sD10wbgNPxrDJg6X0Fja0Xw2Sg0z6v1Hb3Z9bro+um610g173B64Wu7VcovcssKA
	KFRDDDFY5oEmBvcbTyFgm0uNXPD91fK/nwrzTrd54fsek9gKZNKYkkXYR3z+kKpwrRoFguuG4zD
	2f9+i5nkJYMMxEi7GB06LJAcqeKdlF3Z1DDVVjN9ae3xJO1+A1k5BSOPwILosNt14D53ychmeHb
	1Uu7K1bW1CB/CEmLSbYeF3ErtcjmXeWxaIDQvRTrmrkbVqM4+ndQaD9bULrDZIbLxO2UDPX6sVP
	m3n3ME3wRowEfeBz+fEnanwsSL05pnNiY+teZXJMb8tZyyRwFqAjns1/ivyOOTfkqyhwtxMtu15
	QTrqgGnEmDDXxINXM2x3Qa1Wy6QmiuCy3v5Vb+zc6LWF/cgSs6PkYL/zUag0aXs5tI0uG
X-Received: by 2002:a05:622a:48b:b0:51a:8eca:78e3 with SMTP id
 d75a77b69052e-52fb938d0cfmr409954361cf.5.1788278236459; Tue, 01 Sep 2026
 08:57:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824033331.1084971-1-imv4bel@gmail.com> <20260824033331.1084971-7-imv4bel@gmail.com>
 <apaAskNL-IvdcR7h@v4bel> <e121d343-9a4a-4f93-86c1-c96dd37f1ae1@redhat.com> <20260901085102.5c58a5b0@kernel.org>
In-Reply-To: <20260901085102.5c58a5b0@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 1 Sep 2026 17:57:04 +0200
X-Gm-Features: AcwNN1V0ZKwY8CxffJ67D9qqHhYGRXD1ZIi8To29JusVq6P0sfEj2LbfZMr-I8w
Message-ID: <CANn89i+px52TtJy3S9=uHxGj3s-WueguRo1Z_4FxO=02KLmwmQ@mail.gmail.com>
Subject: Re: [PATCH net v2 6/8] tcp: fix use-after-free in the lockless
 listener path
To: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, Hyunwoo Kim <imv4bel@gmail.com>, davem@davemloft.net, 
	ncardwell@google.com, dsahern@kernel.org, idosch@nvidia.com, 
	kuniyu@google.com, horms@kernel.org, willemb@google.com, 
	andrew+netdev@lunn.ch, kees@kernel.org, jiayuan.chen@linux.dev, 
	kerneljasonxing@gmail.com, ij@kernel.org, martin.lau@kernel.org, 
	shakeel.butt@linux.dev, matttbe@kernel.org, martineau@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 1, 2026 at 5:51=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Tue, 1 Sep 2026 10:03:51 +0200 Paolo Abeni wrote:
> > > Looking at this further, unhashing the listener and then calling
> > > synchronize_net() lets the disconnect path handle it. MPTCP needs a f=
ix
> > > too, though, because it closes and reuses the first subflow directly
> > > without going through tcp_disconnect().
> >
> > This looks like a more palatable approach: this patch in the current
> > format looked way too invasive to me.
>
> I likely lack context on this, but I was wondering whether we should
> potentially disallow the transitions between listening and data sockets
> instead of fixing these endless bugs?

+2 I think I mentioned this at some point.

Same for IPV6_ADDRFORM : we should not allow transformed socket to
even use tcp_disconnect().
