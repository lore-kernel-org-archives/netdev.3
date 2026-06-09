Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF3F224D6
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 01:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780967247; cv=pass; b=sQmy5kXDGDGFbMYIixtOin9O4IUPFj5gGDgzrEM8bKB5iJXMhckmJfDL6e7XTjSZIhFl9DoYprfLv9Il4XYs9ztVxfSufKnpAM+45Rbr12io0pYJ3zNFn03abYDfkXskkoruG4SKBkDpbbo3k4AY2qpuezBOeMuPC/A+VOzx5JI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780967247; c=relaxed/simple;
	bh=TUXOMu54v6+na+whvk1ESLh266Ot4xCD2YX0riRX+YI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ImpfLompuuocQfpCGPwpMReYczoG6pCxyd3zsq0LoXaj2tZ4oEtmysOvm/IEcydr3/KVVODQwSkFCRytcB8ZF4JFfdhu8Rb/urmUrLxi8MjdMFy67Uy2YRswjzIWcK9BPahrQ4LypTzalJe/tXNDe4wwbuWpxsBzcjkYj1ywoJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aYzqMwwl; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aYzqMwwl"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-51778077b28so56305651cf.1
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 18:07:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780967245; cv=none;
        d=google.com; s=arc-20240605;
        b=SGFeSc7FigpbAZJTLm/0tzBBxUC65mfUyIiP+cmcav3vgWelE6Zht7ykm6aGZ3y8IK
         mGpryWOvjXVuXEzVJt/YLxUcxJI1BHjqcOgQP2E4Meys0mrMH892iQE1lC6TLqSy0Wks
         McamCK5CjxNiftn/Wf2LCxCJy1ALY5td6ixW9vacGyYYlhadiPy6m7m6H4ZKA3Jr6Svy
         JYE4oa+dp3h0sCJCucPFlDi9uVWu/dRxJn6SZ65H2u3GKpbp1FvHf60Qx75CRhiRC0/k
         7/KyqA8cUEzW79pYzfajo3AM3XM9+1Fzyk2dq11bB1EY10v+jjJBFwt9g+4y0c7j8Vao
         mLUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Vfx/2On+kwh6IUGdeIUOC144dVd+UYAPL3ktk1AghkA=;
        fh=rg8QP6p4pB4rCh1wmOllnFNS3VXpoz9Z9kiPMRVI324=;
        b=jDJKjUGrG/wJJcFDTbXGvjU7mCsUnRJ5CGTchGo7oZqOArbAh7ROiPUIdcbkrHnBmB
         niXEcLXxO2pIBltSvcBMePWJ+lxmHPKgRVsN2pqwlwNDfamzxDQkjTasJTLbROF7Jgx8
         zmm3AIoUs9GJUxLTydh+nNwPFTzG10YibjBIWVckatIHzii36fbbo17fjboHCx/iq038
         QFGmDpyzHs0K51ZrveQVcrsdLX0dZ8TyrICuKiEJMUOelu0IpJJSvPO606JWD9HyxbEZ
         iHmPEMrpq1JmT0cPDHuUxukvTuvbIqkI41gMzLQ9g9ztyIbUs809Iiiey0wJKIPPbXNb
         vGwg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780967245; x=1781572045; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vfx/2On+kwh6IUGdeIUOC144dVd+UYAPL3ktk1AghkA=;
        b=aYzqMwwlRhr2NtxZ+ZLtWleqZcNAzv72x8UTJ5vqnBsZLnvTb+dn/cOvdrYmdtS/B9
         OFON+58N1FHr6TtVBxOiCjbd8Y8DudmQjvXcQ9KzyBC13cxg2MeJ7icGJDjTRbS2Q4KR
         t46TtWVys5nO351eRCDtuiMOOFByRELUz3En0rIbqBlr0jM82gP3y2B1m5ebAVP4KeLI
         YebT0IR9ZvoRYapj+oMulpvPsLgHxhVMLqw9d7cktaDNMnBvCy8ihCgHVyBgs3UScZH1
         QYJc/Ogzt3INyjRhNnYHBcBOjP7YrJGx17GkO1pO50HGb5s8kIBT2QFGHCtmjoA8rG2L
         m0/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780967245; x=1781572045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vfx/2On+kwh6IUGdeIUOC144dVd+UYAPL3ktk1AghkA=;
        b=leHdoKEbSe6xN9QfPuldqMWZrO2LmeDsPNa95w3b6O5tX7rYe1cf6fSde+KxZJdOOz
         Q6NAn+rjL9qc+qqlNU+uvR5PnJ/IRmP/hnILcOwFWNynKNl+kSeAF6aN9AyKXRunIjUY
         QSM3wep0djKJFWuqQPq/vBEhfk0bjE1+X5pPxU3374lXVWawoPHS9axCoEl6atAcRvFd
         gvXQj7hDiouwPaKdfdHsr+yDpkF2uOtvQ4I3vhEi9hPCV0b3oe5RTxrPbdodJlUX83vQ
         Pqbe6yAHsEq4qYLgTSkjAlv7QHQnypYopkIWIka27sck+dQB3+t4dzoKNNCMrOKl9LX/
         gHmQ==
X-Forwarded-Encrypted: i=1; AFNElJ8P/ujFDWsRyMdyfH+nVS15BRiJ2Lq2gmhWB6Qj/sCjPpBLzddvp7KDevwKMFViGiZ0qX6Pifk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXTB9sGPGFiB/nRyWl7AygqNfh5QmVQFe4Nnxl5jgdX8tOvCva
	FUcVjqLRkzaqIKQ3RwVNN01plxK04sapMy1pwoJGE3FIGkGTRpLoq3ljB6e+PsrKsWIyzLMnlqm
	Mb7KghJgtTfeDx9umVBOg9pAXOYbskF8yAyomHdd1
X-Gm-Gg: Acq92OG7kNfONbOe6qcotvxLdpEksjY5lz7rQdfLH7rO35MfUV8pFMTQCAQrceAX+ik
	vU/6zyA10pkdZDyVxHbG6P7oTrcARaeq6oZtde1TIToHE4TD7B+ds3Il0pC6jOporJfYlC2l3aG
	hhkHqAZ8iMEsaA7x0eAA8FsQmvRWTi17wS3R3rd36y6eV5M2Ij6OGU24QVvHNoow79j4T3YUIK6
	bffA3tqibi/4mXPwsZBkexgfD7kCzG9UQKH3TdsrL0O/DLizJNeYH1hgbEi5de/XZMczcRR/Pjy
	HVEoFzA1QDGXt0WCovDSv6KzQ3/hBXU1VHLfL32oNi3NFmV7LYDMyMSd0jIeMsZma63L9fAdQdh
	hwpW6DGfcHp32wU/bGWdLJFXz0rnH
X-Received: by 2002:a05:622a:4d09:b0:516:e290:991a with SMTP id
 d75a77b69052e-51795be8192mr275915361cf.40.1780967244571; Mon, 08 Jun 2026
 18:07:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609000059.1234072.bc8844db0200.cake-overhead-underflow@trailofbits.com>
In-Reply-To: <20260609000059.1234072.bc8844db0200.cake-overhead-underflow@trailofbits.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 8 Jun 2026 18:07:13 -0700
X-Gm-Features: AVVi8CcBXqIz7dS5hxyx15Zqsi44X_dbAP916we_iM0WQNzaY_FL8BFeSPx12h8
Message-ID: <CANn89iKCkHBsnvSX3y=_f0UdUXeeh3=WZkWaiRTx1nHEXWkbnA@mail.gmail.com>
Subject: Re: [PATCH] net/sched: cake: reject overhead values that underflow length
To: Samuel Moelius <sam.moelius@trailofbits.com>
Cc: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, "moderated list:CAKE QDISC" <cake@lists.bufferbloat.net>, 
	"open list:TC subsystem" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 5:06=E2=80=AFPM Samuel Moelius
<sam.moelius@trailofbits.com> wrote:
>
> CAKE accepts overhead values that can make adjusted packet length
> arithmetic underflow.  A negative effective length can wrap through
> unsigned arithmetic and become a large value.
>
> Such configurations make rate accounting depend on integer wraparound
> rather than on the packet size userspace intended to model.
>
> Validate overhead settings before using them in adjusted length
> calculations.
>
> Assisted-by: Codex:gpt-5.5-cyber-preview
> Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
> ---

We need a Fixes: tag

pw-bot: cr
