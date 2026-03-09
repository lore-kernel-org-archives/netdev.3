Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111B338F947
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 10:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773053233; cv=pass; b=fPzJr2sDjl6iqUpeIM46WPHBqs4N+BSuHUGtBpPAsdL2l56ibJKB9H+mb/dck/CqEZUmsEdTFwwzQIVFKx05qBLnkA4vF2gHGCT0tbahoSjelMcKVEF+BDTQnwIFvErdfZTxVnj6asiUh+E8r50b/X+pCPy5PNQ6BI4GPKxZeFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773053233; c=relaxed/simple;
	bh=WaGNRP8zBcq+FN96X1EiSW9HiX0AA+iytSmfZgPgEiI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u724M7SqSeypL1NyDRrQi/UoiDjT3DoxAq6/GRWVkJbD30DpbMEgQTOcWhJmDKxh8zYUNbrAm0Qlz424uNdhd/IlP/JhOBOieHy7L4pK2k2lyaOG+EqktliAl/LFwE1xgqJEEfpETKXUVBwe6PdVFUkPc3PadR42ud68Dtdpih8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=alSYCNSh; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="alSYCNSh"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-79898953985so63285057b3.1
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 03:47:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773053231; cv=none;
        d=google.com; s=arc-20240605;
        b=jnQY1VI4kdI6tMGjgvlyVzkWXcjl7BnRtc+tqsFnI2cfVShpvhyTFyJs4XzQcqkIzf
         cVutp25cqI+vrDSVpxqYdhivi3liR51jKvkDtLreeNjY/A4zZj4Lj9/OQaJGGOZpbH6Z
         geQ0ieL2fzYZaa/EWewy0n3qJTvba9RIBNDJEAqOgl3GbH7CWpBJemmx9BIjKZsjs8iL
         xsBi49/w27M5t3zlP1DtSIoji2ZFyEKuUtiCdjW8Bi2nx3lG/sFvzoXgutGEoLwXFJ+Y
         Kxk+/6yTPOg1IWbO+lITvtXrEarWQ+0kuu5BXJgIVMQtHhEldHzRbaUarZXPlUSmlaCg
         OyXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WaGNRP8zBcq+FN96X1EiSW9HiX0AA+iytSmfZgPgEiI=;
        fh=V/X30X7HjtLxDTkjnjWF30ljdSkoK61JR2uxzB9Bb8I=;
        b=Hj0USO0nFUak1gy+MZ+i8EY1PmtkdMgfDA4pnwnKBG+Ms95Yl0QR5uNjnW7/+QKF1w
         Iz6+bOoqKL8MLPsPYCaPhGd2XCu257pBCZHFk3bsnA/CFw2fHiQg/FoJZk4ul0asDNYb
         Q7XfwrdniX6/lTBXBirD7AhkE/EpmzzF3kr9UOgqqcUDnvLHeDwHTSRsNPPsKo/PwwaO
         cIJ1Wwvl78hiypeS2TRcVVZKWRrhKX0bWqPJYhVW8/8VWLvshT9TB3Uez5Hbg7pWP+Ym
         ih5b5qjnqpxiccsA6FIfhOwu6CddbvDicGxc3CMhFLyxGFx2wf+uZ7c/R+L1uqGTlFs8
         TayA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773053231; x=1773658031; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WaGNRP8zBcq+FN96X1EiSW9HiX0AA+iytSmfZgPgEiI=;
        b=alSYCNShrDmE37FWShOjhdt91KxEtlZs0wXmwGLxbNJmXHljBdLwFqr65D/eJn/W8p
         SkMyWzGPC4MvVuNiG6qpfafM7fB6yxFxDpjU8+WqLRDCPh79aiud16E2FMA95ZWNr15n
         KogLHXsirPpAhQiHibxFs6cSb+fmeUtKvJcZ0QeTMeFOLXdEYjbeVwqHUyMLiogtvzxe
         wynDYRdo7Ko4XvhnZZlZEeDSeR1zIK1YgY3AkA/79Z7DXfuqeRnepoTPZmoUdA0R8gZ7
         5c26IiVE8yYO5SGgb70GpPJmXTfKrHhnGFV4+optegmmGEPB3KjH6ZrAUEn117mb5CkX
         Jgpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773053231; x=1773658031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WaGNRP8zBcq+FN96X1EiSW9HiX0AA+iytSmfZgPgEiI=;
        b=hGfFw05YQ3far4kFaiY4goPsGjDPkcDSoWsysKyvjGA0t9StqLGaKhqN26ozZ1T58j
         U+l5mxSOnNWwR9XVgEKfIep2F5QP8Y3FeNXUZP9SEIaNuvvhOgFdez/FgOeZzXtg0CdL
         NRSvM8o7TTCG6LdxwV1LOcjsPuNSHj1GM1bL846wcbnQ+2xZjG+GJn5lBExMmnlPaS0l
         PlsvSM+whMFsDNAY1MII4Vb4KWKeLLJSiFZXkiSdUad1KhROkW88a3Obw9NDNdma1Z2L
         0LS3uKm/r/SeHviMUvFyw/XWK3Lm1wQBl5JuFm7KVfB8JOT10amMTVe/S376+R7LzGk5
         Th9w==
X-Forwarded-Encrypted: i=1; AJvYcCVjYDqTtszgQWWIdw11TJb2aFCYXuwETko/YL4/vgceQ6J1RJyKUqjLiyNENdqKbo93q5dwE3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxQNDn4FFW0j5CVuFQfhSPIDaYvZCaKJCUZgcbuIYm9UmaakmN
	TjIhmJgfcWXYb/cugkjuAdbLbnpBHujbD8ue+O8gYRxVZ68VCr89Q0MDM+IYhPUPFWgAqP584w7
	SGWmhS2j1Vz10nHBxohQQaIpqH5mpYis=
X-Gm-Gg: ATEYQzzPi9tOwoMg5cM4sC8Fe/pgS/hpvmw6ns95ASfWquf0lvoDZaB8tM/L0IqCNnh
	evJpwezJjeDK5yQFJE0HvoUCer1JP1eRwbuQSN22xLt1Txo6znIfuJ0z1Kke1PuKzstYrQWn30K
	/EruLLkVkOAPzISb7fCTcYH/VhXk1ZLiMgsy0SRTzC86Ch2Rl1h1n3o7o3catlei7qqt/ZRcHeC
	BRi+fc6mZLfc6IMRi8TbWKa+6M2keUgdg7riA13rmHazfxFAsLAjzmbnL6xugU1wIZSfb65l3ZM
	RwCaaCXozHCozgpA
X-Received: by 2002:a05:690c:f03:b0:798:740f:6af1 with SMTP id
 00721157ae682-798dd6e9b55mr95462887b3.24.1773053231166; Mon, 09 Mar 2026
 03:47:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305013852.3769-1-dqfext@gmail.com> <20260306170411.49912ae1@kernel.org>
In-Reply-To: <20260306170411.49912ae1@kernel.org>
From: Qingfang Deng <dqfext@gmail.com>
Date: Mon, 9 Mar 2026 18:46:59 +0800
X-Gm-Features: AaiRm52EFkMctGTRXJyZVgZys-IhjRENIU0NTzUX9qDahsc4Ed7hvqKpp3xPVQc
Message-ID: <CALW65jatv71b7G6jpr4g-6j520RjLBDJMH8uta5MPJHmEM1S1g@mail.gmail.com>
Subject: Re: [PATCH net-next v5] net: pppoe: implement GRO/GSO support
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-ppp@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Felix Fietkau <nbd@nbd.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jakub,

On Sat, Mar 7, 2026 at 9:04=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> Please add some selftests.

I haven't written a kselftest before. What tests should I include?

I think I can add a local ppp server and client over veth, and test
the connection with ping and iperf3.

> --
> pw-bot: cr

Regards,
- Qingfang
