Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDE43C0633
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 12:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789475338; cv=pass; b=N+lKYmIR5mjlnjU4LtwRCDwoljazrFYkS1du4ylcYLHUfvubx2Tu9DhVCzRgfoedDsI91c4HQ3fYorFMM14qMTngzgceiJPoeSRiOqJRNEoRk9AWC2TZCjMMs9oUdC31Uq6Xp9rJPKnmNd6zT8e6sJDDv9O3n0BWuojU/G4IJwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789475338; c=relaxed/simple;
	bh=vQqJaaExSCmg2mcEKdaCpU5otXtQE5qipBcvetgfzS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S6INlOYaugzegFNo91LpcH5qAxbrsIctKr/dZDRnMugYyx7zJ5GrFqvzZboHtHwLNh61VRYncevbhO/QInEO6HTzs1ykiBRqipTi0YAV0ZMG31vWfszhFsvC6POXUQH2Ndoc3iOfG8sc2vpe/rJERj2i7m/bZZxk5Gy9qY3lp8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N2zNSned; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N2zNSned"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-52ff0eea420so7667081cf.0
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 05:28:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789475336; cv=none;
        d=google.com; s=arc-20260327;
        b=fd204fRkwUAq0NbdfiqgUYh/7QBOGJAq6nVTtU9nrJOEPP9ZUnYIPQXMUJLx6lX7Ub
         V79i0t/BQC+W2kTsTOPRSjWUUm8mHQayngTcDXYSO29laNVdsQ18mN11adL9yTkgnpW+
         H0ek8VHuUPA87VR7sbfbuYnfeBL5FstTLxUp+D3ez/DvZarMqE9ZjsW8JceZzX/Sj39G
         zV8AC4Bbof1/M8FbrbPBznb1Aw3rL3TlS0zv7NtgqR2FDLKAv3i4O6Esmi0bd1igM11u
         92D2v/UsqIYvxMwEEyYM9XAd94U0Y3oJ1ulaPh2oGmtob5whkfQ9kfPgcsm3diQ0+Adi
         anZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uT7e+1Xt9oHbsz2S+z1imXerWgaT4PgfuJHK1QwlFQk=;
        fh=NNZmocIoQq6aIYEwUkIHtS8cRRlOMf30EBKPWOhIH0I=;
        b=s/Rj7TzFyaz/jtQQiIOJKRaAn8PHJjlvuew5vYk3tcCZ0dyWwtqihZ3ndJXCCEEfQh
         0S7YmPFMkq6TKg1LTrh4LA99UoRi3DynUFSSS3LOTvggsz1aH8yh1LSmEnWiTXytd36J
         gg1j1PzroOQRj71gJw1HIstQ5xhqKx0PS1W6yuM/hNFgf7oKEk8IhZP6cI912t/QOqhB
         XcNwfdtm/KxnDa9/f+cfA49VVyRcTfhCEwSUSjEl7nAWV0OJPLUzV+gTuOwUYzP/w77Q
         niHuTrWeSE8nl9XGaURXRzHgjspSk/Q37hyJBKslQ1Kl+cG/8u2oZ7WpmUFKAWwje6Od
         H62w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789475336; x=1790080136; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uT7e+1Xt9oHbsz2S+z1imXerWgaT4PgfuJHK1QwlFQk=;
        b=N2zNSned4C0R9DHn1M0f8Hf2jZFaZsHH1p96QswCEx6fRLVwKFlfY83sG0uZ4fnPAK
         /b6fc8teTTt9aindRon+qQ0oX5sHv9R9GQF22R6vz/1uM/gXajPKtAzlOqVUHRMeDEJ+
         4DoWu2eIXsqvBXphBZcWLEF4n0uikLKPiD68eT9z7TBNe7b43uS46gIDOfeNTrw6V42v
         4BkcK60/uVZLKEvcv16uR44jsJKoPcO567Vap1UjB5Oqtq9TNNLKSB8nUa0tzcVLKw3U
         OQIlHoiChHovv7CrYxOC68Rg42O+nOnswG7aOCr6PvjTkI12ndcfjdH33QJqD2IiRsrI
         ttPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789475336; x=1790080136;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uT7e+1Xt9oHbsz2S+z1imXerWgaT4PgfuJHK1QwlFQk=;
        b=KTmG2JaERL8cOr9QTBCZzwELkqgJpU1X2Iz5ommDYw1krssKmpRtmrkw6wi1OtCP4G
         VfgGUURNJZWHayGZ1vJLDSBx2y5riL3s+kHr30fg/2mUENSiCaagqHwtTRtvp7g9KzyR
         C7gQFxuWSOf79FYt8M7C4H7zAGANC9E32wYb8SQoRBpTFpetxPNT8hupM2OyBtqoOy1H
         PsqK/VoM9S4Qy1yyl9ervGQWeMUAX8QzZs5w1ugUEzZYqOFCjaClo6A3ZZxPpzMQPw3V
         TSTq+NuHNVo/5cZ2Hs7xHaY6UEhdvCA9AoD6aXf3U/nmngcu/2M4j2QfZP+zYCsgO4Em
         vPKw==
X-Forwarded-Encrypted: i=1; AKwUvBzYfzv5rbHXqFNTFvur63PY6LMczo2m0Sv9yJd3j6CBqs4hgxDepB5jH8NZLyt+E403bDx21C8=@vger.kernel.org
X-Gm-Message-State: AFuF++mietXsvfSbYEgRIVQs69Mieo7hIQigBYK70aENj6gr0qEHOeSK
	dPc8dp0UrrsovZdzIkb1ozvwjD4XRjlVrElcYqmhnEpUv6mjPIwcqaChzYISuPKLKwXMKrlulfZ
	sO+cTb8lDCBF/ISWfahV0r+L+fOyRZ7NwrPpJmXjKb6NewXhjI/O6cClm5pw=
X-Gm-Gg: AYBFou3zD9ZLsoBRppZjGCIi+EK88l/BUlrJJ8gE1yUEOaWGifvSDtTKQoc6fgWsUkR
	B9oe++XUJ2VI1YZ4o9Pzqf4cEIiWLKljMgFPBeznIbuTjgMdgAhcruN1ZkKJ4Urpv6qx2Odw+YM
	SDYGXcQXRH/pcNKn51fQce4o8G2KjTkYE+HwVNM9JwPEursLrqi+rjrmZ0i5Eo+FtZS0ynjqlqZ
	w3qPiUFIn2sWsDyc+dzHSv8HpTCLnuzP6DO4RTxnYOdIopkpIrUfwkyQmZ5tYeMj3+/PvbX1LOO
	AdlolFkRbfpPJQP8ximt8R7RRIs/s3X78/w1q0sh36lghCrC+fVqvpzwAp3MtdEzi7AqqVs2XyU
	Svx9Q2tmT+g0Vp2EmICM05uJuKeJCDqbAVnAXJurK8h7uR/X6VHcKqzo8s90rEYQjon5Vst7jBr
	fTnw==
X-Received: by 2002:a05:622a:144f:b0:530:f0ca:9ab1 with SMTP id
 d75a77b69052e-53119f52beamr48643721cf.41.1789475335575; Tue, 15 Sep 2026
 05:28:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911133146.3440982-1-victor@mojatatu.com> <20260914191108.55a1a4f1@kernel.org>
 <CAM0EoMk7CZA2qAPEfvZ_+tUDkcUYF5nanaxER1soLJQZqMuXxQ@mail.gmail.com>
In-Reply-To: <CAM0EoMk7CZA2qAPEfvZ_+tUDkcUYF5nanaxER1soLJQZqMuXxQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 15 Sep 2026 05:28:44 -0700
X-Gm-Features: AcwNN1UBy41Um_5KI5m2D-7iyle44r2y--8W330pYgRvx1ArXAS-O7egRh3UF_k
Message-ID: <CANn89i+pkwNwyQF4tRM+Hb1a7YA1qUqdk2tHonUMEycY23j0rQ@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: Avoid quadratic handle scan in qdisc_alloc_handle
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Victor Nogueira <victor@mojatatu.com>, davem@davemloft.net, 
	pabeni@redhat.com, jiri@resnulli.us, horms@kernel.org, vega@nebusec.ai, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 4:51=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Mon, Sep 14, 2026 at 10:11=E2=80=AFPM Jakub Kicinski <kuba@kernel.org>=
 wrote:
> >
> > On Fri, 11 Sep 2026 10:31:46 -0300 Victor Nogueira wrote:
> > > This is a less intrusive fix meant for backporting; a cleaner approac=
h that
> > > uses a per-device IDA over all qdisc handles is planned for net-next.
> >
> > I don't think this is net-worthy in the first place.
> > We have a ton of code under rtnl_lock.
> > We cannot provide any protection from malicious netns admin from
> > overloading the machine.
>
> That is the one million dollar question.  We labelled this as net for
> this exact reason. i.e malicious container could overload the whole
> machine.
> But it borders on "hardening" (improves performance), so net-next as a
> target sounds reasonable. It was a coin toss.
>
> Since we have a few similar "grey" issues in our pending queue - so
> where's the line for net/net-next?
>
> > Nothing against the patch itself, but if you plan to do something
> > else in net-next let's just go with that from the start..
>
> We could resend the same patch for net-next, the alternative "proper
> fix" is more intrusive. See attached.
> Another option: Is this worth fixing?

A really useful fix would be to get away from RTNL :)
