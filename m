Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5825B417BD9
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 07:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788766905; cv=pass; b=MY3eNsksRjXiIuRHXv2B6FLZctqUqXc2d+OagXzbgNfDT8DlEC3CEWnXFoVRkWn2RMVgfeUSr0s9QNKsM0X5pUT2N5qaL0X/+4sQSGfjoYweLjEOl/vusZ7XQi8wCnQ2v8PFByjCVzdwAL0djCQgdEoMkloTjwTtQqD6qrzcE6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788766905; c=relaxed/simple;
	bh=QKjvgmeZzGEaOpz3gNTV5TQ4+j80gPA1r1+NsciZfkc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uIAOnX64UW/HhGZ57CZOdfTPcVHMO6yQGTyVWyxMTXiVK1LaSlagL3yO1BScqAxBMh3JKBDngmYignvvUVEhTpyb+I7BnH8gGfBtDPLaBVpSYYQXZD2i/Y84bPwImQzPGdlT0kGNb41FhxgzQ2EYA7E6AbvlsS33VM1uH8yRgQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=tE1VOsdn; arc=pass smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="tE1VOsdn"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3a20c95e412so27210551fa.1
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 00:41:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788766901; cv=none;
        d=google.com; s=arc-20260327;
        b=cTEQnrguXlQKvtVN9kLwwXbgDlXgkr7AUIzBrNr9IDYSTapb9mIEq+9osNJg2hEVdh
         ddQ7Eoc+fk+34dxE8fE5pkOB4L2dUX7OmRX0QzTL3C3CJqTVq6fY/M+2pldJrLLhpYha
         vM2VFgxHvUUwg6bNZjoNHRj4coGFSOx0c82ow/15Fim4VVv4RYnelJz8GrJJtuULCNTM
         F5Zwk73nUusQhPksymxN9PyWDr5VsjOiaWXq58/ASveMgVFcufahBCcSYp0A8lfAn1sL
         4o9oM1Kxkga9KlGmPqCVqfVz+9wRx1d6AsF8UnY1scz41CtqMDNHPfQvO7BlxTneFAla
         ZRug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BH9WMir8rF2hqn5Htua6dfyRLLaHMRp/CMdHgEBBKQA=;
        fh=HAcQy8C4YzEycmjsF3en6cb1pU6RTzLm+CDFpZHQYhc=;
        b=oPzjSObRS+1gbTDWokAN++A4wR2Q8B5ks7HdPhQF3dJYh0vY+YMRc4DZxmN0xuml+d
         +0OJv/ctMVcv7SF+9b4qpht8PEWfat6nt20Si7dmST6WtyfG4SHXMBicqMyZhg4eenfX
         CVeOru3Ld7QgsGbL7nu1bpzMOGgwc26gScKkhE28h9xkn8107UugPz6Ovc/SfhfPBOh9
         W4/yrwBIKJSKDNl/OfzdK4csGshoUax/LeqZyqQvtAa5S5+wFKGSr8OXXq1C5bHvhbRZ
         eqwZge9V9SdKpkTyKAE657BAVKVaV7q3m/ft73axPlqEoEzq9Aq1WnYrn0eHbM5T/DPu
         8r6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788766901; x=1789371701; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BH9WMir8rF2hqn5Htua6dfyRLLaHMRp/CMdHgEBBKQA=;
        b=tE1VOsdn0HBsn78ZbWEqbsgTuwQ3F1SMSe/52v0opUisM8ohTsP2QouD/nMe+q9U6B
         GTAtfx07P5cLiUH4o9Cb9Rj8D4kSvIxxWBvqFrEt2s+sQ//fQuaQueokxj8yK4J5iFJL
         2+4iZUo/7XZ2Eqvao+FuRRrEShLphXqC9w33yyweTMm0SoF9lNQUXW1/QU/BmfzCIfD+
         T4Bcta3UBDR1ELd3CARFsvVuc7DDZW2BwJ3Q5PHGsUbQYI/lhmGuZE6urcaKRkD4QMOo
         p9OxDdk5I300G/QQcUzGC649IEgk9t25h0behUz5PTiaqut1lZ4OSZCseTI05LEq8w0v
         xiVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788766901; x=1789371701;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BH9WMir8rF2hqn5Htua6dfyRLLaHMRp/CMdHgEBBKQA=;
        b=Do1O1g/ErvHkLweMHg4P/k5bqMy2/np6ohN0rHO6YxVl0jRcGTvjkboL8DG8lzByuK
         r/fQGp+fpHtTv7j4yWRnrHD4fg/0CFsTgNzz5oARFu8vKmTjgq4RUA0HoHtp3AHar3z4
         4E/abraUT58yHL/DM7fOXoqQaeYA7A+/rccB0OskOxWfLc0Tdy2f6dHKKe+281jRD6in
         wCxQb2v05eH4cuNEKgZsCPoe2h4/8PAvRdXU5UaF9kYpiJ5vAQAs98MJyV6soBwo90EI
         pmBHvTNm4npEhS7g44itLCwDRyRonzT8DBw230nhq3nyiDZGS6ydhi82A7kM6mBFGDqs
         aDTw==
X-Forwarded-Encrypted: i=1; AKwUvByHLgA/PE4Jh6uEF8x7jBsLBnqPiCLf8E/gLwI7SIEl2yd3++XTRgygSFtiKVMYceGMlRwIg8I=@vger.kernel.org
X-Gm-Message-State: AFuF++m+CrcAIcTC/J9vUgs8ujsbQBdEs61BUjPWQtlcxyzzt6m6PICn
	llaAAca11dJ4R0xXsrnEs1FmYHHaQmuN5gGUQim6CSgq1qDgktj38YKFY0CaQ2sX4rmLV8x3Fu9
	0T8EMZ6U+QFBg3rGdNkik0BE2yEwDZW173pZ4q3UwCbtYTaJcFpChlAx4L8sM2g==
X-Gm-Gg: AYBFou1H753+UX9YBwfkwQiVUOl4Kdtx5vJpAs+9fDf5mR0i00q68gig705iJE/z7f8
	E/lwmlwce5labC4zC1rs7XJvrRroCUcOXnKmF8mp2DMCJEsVLdqAmOF2O/yNj2/6PaT8eckO8bh
	kf1Izg2jWEXg9HdEiWzbItun5JuDp8IGvelHmMlnT+t7QylBe4XyzZHIceEKjV8BJ/Be2UC7a2d
	hhr4r8JPzVHh8gin4+alPWFRUkGdkOS9t2vGVzujtvYA1Rtm6w9K3XfOAPadp74GVGCRYYXSvLV
	DgFevkCFpdKyLB+usqCQ7AfD7f6B5uP2x04dCV7qddwgU+AKVugfHLMWdzxPbRgDdfC4htSJbjo
	=
X-Received: by 2002:a05:651c:15c1:20b0:3a2:fda9:34fd with SMTP id
 38308e7fff4ca-3a371bb4496mr14915881fa.9.1788766901322; Mon, 07 Sep 2026
 00:41:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cdc628415cf10721480a51ce14837f846ec778c2.1788248601.git.zihanx@nebusec.ai>
 <178875495405.219967.5594821749566554418@kernel.org> <CAANe3eRBOQud=bMgLnPbD_yUYUkJtT=GBqtY+GR0ZtU0_kbzhg@mail.gmail.com>
 <CANn89iLn+Xi9cEphy3nR4bGnFCownrWa9rTZ=AnijArDFo2O7Q@mail.gmail.com> <CAANe3eR=sQeTRNuewiqo0ZFwS6fk=HtxvT6TMGhq8F5Pqdxovg@mail.gmail.com>
In-Reply-To: <CAANe3eR=sQeTRNuewiqo0ZFwS6fk=HtxvT6TMGhq8F5Pqdxovg@mail.gmail.com>
From: zihan xi <zihanx@nebusec.ai>
Date: Mon, 7 Sep 2026 15:41:27 +0800
X-Gm-Features: AcwNN1VzGJxnqabKgTDT5QXQvwkk_pkpIGT7iWj3PbbALy5PgIuN8fmhJFOeJSY
Message-ID: <CAANe3eSbySUA=RreUvFxBaE4xFp5Ob1uapgFn86UYO4J8WuXzA@mail.gmail.com>
Subject: Re: [PATCH net v2 1/2] tcp: diag: bound bucket lock hold in tcp_diag_dump()
To: Eric Dumazet <edumazet@google.com>
Cc: netdev-bot+sashiko@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mptcp@lists.linux.dev, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, ncardwell@google.com, 
	kuniyu@google.com, matttbe@kernel.org, martineau@kernel.org, 
	geliang@kernel.org, gnault@redhat.com, fw@strlen.de, stable@vger.kernel.org, 
	vega@nebusec.ai
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 7, 2026 at 3:15=E2=80=AFPM zihan xi <zihanx@nebusec.ai> wrote:
>
> On Mon, Sep 7, 2026 at 3:06=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
> >
> > > - bind cursor UAF / dangling tb2: valid
> > > - unconditional sock_hold() on unpublished TIME_WAIT: valid
> > > - clearing s_num on cursor mismatch: valid
> > > - lockless cursor-membership checks: valid as a concern
> > > - commit message overstating bind/ehash fill-under-lock: valid
> > > - missing note that MPTCP needs the follow-up patch: valid as a
> > >   backport note
> > > - endless re-scan of the same bucket head: not valid as a
> > >   guaranteed livelock; duplicate output after a rejected cursor
> > >   is valid
> >
> > I just saw your patch today. This is absolutely insane.
> >
> > Please limit the complexity of a filter to something reasonable.
> > Absolutely no sane user is using a very complex filter.
> >
> > Same for UDP.
>
> Thanks for the feedback.
>
> We will drop the dump-cursor rewrite.
>
> A follow-up can cap inet_diag bytecode complexity in
> inet_diag_bc_audit() so TCP, UDP and MPTCP dumps share the same limit.
>
> Please let me know if that is the direction you want.

To be clear, this series is dropped. I will send the bytecode cap
as a new series.
