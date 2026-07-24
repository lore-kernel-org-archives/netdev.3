Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FE635CB6F
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 03:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784864194; cv=pass; b=XvixWUdp09L58tvH3JaACo9ReGGEukizWsMNg83cEg6hsx+JoJl5Ve0NtlgDx3IBrqqbAzX9CpVMARYvxuzqbud9lOLvn0S6rdzQTb4zNsJ818XwiA+R8bcsQUKCmPWQL3rbj6iFTIP1qVpvLaT3OOFIKhDMcNwJeNHFsnHDVK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784864194; c=relaxed/simple;
	bh=8HcC/oA7PCfFjJtXkAhXIBjiaFdK3uVq2t3mipV6lmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pwf2igPHAsSGj4nI/ErGOSTjXYOgFKFIkPY8iE256SdMOiicR5io3ChasutCxXC/e2kHMOXdEkFixRDwfQsuOdo7KEz//AJ1BSNGGMs6kuVfMbQmskW3VbFBDyFCHCOQMHB9gkirE5AbGkqGBJ6241dukTawU4CiGuSGfaKt/9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lm803m7M; arc=pass smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lm803m7M"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-84a32ff53fcso236212b3a.0
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 20:36:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784864193; cv=none;
        d=google.com; s=arc-20260327;
        b=C4Dg1W0WqpUdWWFB3m/z3yKTrD8skrt1ilzCWnaryqVxaI+Qfr8CsRLywlIRHSuf45
         MZ+EYP9pnZ1WykjWHWaV8Pk6SX5w2Xh6ykvGvKQnf3GPKHIQS+dXXV6DsadJiY4xlTVS
         Fp30tPGOAmnPJW0c5dLdy1stLk8wJJLnkF7UJVNztI+xZpErvZ9smvGyLD+laXLeeUh/
         J6W0J5ow0bs+Jw5LWjaCJvxGZd4+iMEgj7f/LcuSy7Y8LSzoyUkzcgiSuEpQIS1Twx90
         itDez6UkYKVLMvDHHi/ew3jo25ops6hv0SSQPv6CA9yutdp6m0XOpTZRdfCHeL89sibB
         vSBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8HcC/oA7PCfFjJtXkAhXIBjiaFdK3uVq2t3mipV6lmc=;
        fh=OSYFR3nrLbx+UP2qofRCvLygZjvlVUfPhyMYO5ac/oU=;
        b=JVDePfcXMaFDDRxNMv+h2TjsXtwmkLYMxRXjrGYh2ApbFc81QlOcg77lKpozrwztSM
         IJEL7Q34UqKh3eu6XKI95mN5b9+9QRfilqDa0RDf1cMWRqZ670RPNC5EJvxG00igN/Gh
         ZaMteGlqn4Y6ctqE/eFSEilj3iUKAlzaTOXKduq6nnSd+K9KMqEVpYFGVewby0ugDQi0
         Qz8eLvOVjbF8iQSx9/KLhovXjtLc+Gv1U2gJHSe4YGLruNNIlopsWxqGxZSxIPzjkDMh
         /kEbZor5or+xUn3LQdsTVv4Fc+IaxHYvaRRRgQYxZuvAe3i6UrLvENYlHUbQzv0klG+O
         4DHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784864193; x=1785468993; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8HcC/oA7PCfFjJtXkAhXIBjiaFdK3uVq2t3mipV6lmc=;
        b=Lm803m7MRz8oCrZj/ij+be88C9vmMlFFXVR1GnW6kMgHROfMHJXdB+hHTgay+Ay7rv
         tiIvSYjPDLD3f0RCEmYyO5B/7G72RQ19t5PKY+Cn5Tn3FOD82VbjaVZcVDXBvnTAR1Ho
         KTry4nZM04Se05ltRrKQENmbrXBbPsxiLD4XbUPa9ERL+8XmyQzsLlSjl7Fdrh4ohGgN
         eCARNJysLfZQEj6Wj12WUIk47qFZQlaLKg/Xll6pbKo8yxIfaicqLt9ynNGu42B2oXHY
         yifoGJTarjv9tMUCEOXBQT+mhHJP3t0KNKncTuubFGLBD19rEZS1FGHhc7k24bqnIH1a
         6BpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784864193; x=1785468993;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8HcC/oA7PCfFjJtXkAhXIBjiaFdK3uVq2t3mipV6lmc=;
        b=ZKblx98yj0G+4inqA9Mg1DEDFn9w9Ag31QmMf+ab2woYEFBFY6VmaoWLmb6JeolRDO
         htXreUpJ5fp4vu9y2DzmvaBQwiIC2UQB/4PoMDJYcx/G0gSZ8RuDgCzEeLs7Psa8dwcX
         0bxPAC0oG1JKA8WhsJQLVOPn2e0jkQTksz5YSwdQld7kxnZgihWoEHbI79hzyMfbCvQ3
         zDoJTUsIE2QRi1c9E9CIweV7FGhCy729e6atp3dE8wVnXjwpxU22VysEVz4OyjK4vC5I
         wqyO2pOev+TqlWb4tTFY+oenOmmqZLlY0VMFlJBeRn6QgQuc34z0T5QSexGZtL9a0QA9
         qYoQ==
X-Forwarded-Encrypted: i=1; AHgh+RqFvWXjUD52B5hK3ZcrjfNpCkqQ44jkBM713iMOJXQh/BNCn+h1Mt2pnVao27xSAEoyduPteFA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRGhBK7VF+41vY1Edjr6mN5oBQgePu28qefrSG+klBx0s+M4hh
	tIa1NeW6/7pyuX9QyXuPzyAh/5o6xizpse61tCg7KwCQwQ32jCFiZhcBdz64EE9mYwK8N9Qpx8k
	w5adO1JqBLWOLcN5u37LMgO3ANHjOebUlnO714Ec=
X-Gm-Gg: AR+sD10xv5fcyCq/cHcY21xk+rkv+o10qrZHKIxQ+MM+fdvDgIfnfR/P3Mt5tjCapJ5
	Ls3gh4Rahip6PfC5gT53QiQcT9vprDOjOuOqpydwhdpSa4a7Akv61b3RTXMGMMOdqnLp58pJ3B/
	i8H5mrkqvJVpX3efOxa7DdyHeQXeS+3LjwVKasDW1dmOTYacABJXRR5wceJ5iOp9d/wDI7jqMwV
	ot2pAshGUfhF1tHATidPLaF996egZ05SauDAoy/EKQuqrV9bHagj656IcCTudjDlPEeqOK370of
	96h2fGblNOUyQUDgZw==
X-Received: by 2002:a05:6a00:a90e:b0:842:5a18:9af0 with SMTP id
 d2e1a72fcca58-84e3ddebe70mr2100467b3a.0.1784864192764; Thu, 23 Jul 2026
 20:36:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721084935.12312-1-q.h.hack.winter@gmail.com>
 <3e4b1552-57d4-42ad-a244-a91b74b8dae1@gmail.com> <willemdebruijn.kernel.3e74e4fda69b@gmail.com>
In-Reply-To: <willemdebruijn.kernel.3e74e4fda69b@gmail.com>
From: Qihang <q.h.hack.winter@gmail.com>
Date: Fri, 24 Jul 2026 11:36:21 +0800
X-Gm-Features: AUfX_myMQCLMi8B49UslUypNDm75uADo-4b77-P1llJQTPfcQ7oEOs46vfJYVgE
Message-ID: <CAH78Gvuoqf89L8dm-FwRBzCGm9LaB7H_vt3MsOY5QPd0o_zhrw@mail.gmail.com>
Subject: Re: [PATCH net] packet: use a consistent hard_header_len in send paths
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Daniel Zahka <daniel.zahka@gmail.com>, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Agreed. Caching hard_header_len fixes the RAW paths' inconsistent skb
arithmetic, but not the SOCK_DGRAM race between headroom allocation and
header_ops->create().

I also missed packet_sendmsg_spkt(), which needs the same RAW-path fix.

Would you prefer a v2 covering the three RAW paths, with the DGRAM
callback headroom issue handled separately, or both issues in one
series?

On Wed, Jul 22, 2026 at 10:26=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Daniel Zahka wrote:
> >
> >
> > On 7/21/26 4:49 AM, Qihang wrote:
> > > packet_snd() and tpacket_snd() read dev->hard_header_len multiple tim=
es
> > > while building an skb. Device reconfiguration can change this value
> > > concurrently, for example through bonding device type changes.
> > >
> > > For SOCK_RAW, packet_snd() stores the first value in reserve, later
> > > allocates headroom using LL_RESERVED_SPACE(dev), and then subtracts
> > > reserve from the skb headroom. If hard_header_len decreases between t=
he
> > > reads, the skb can be allocated with less headroom than reserve, movi=
ng
> > > skb->data before skb->head. The subsequent skb_copy_datagram_from_ite=
r()
> > > can then attempt an out-of-bounds copy. Hardened usercopy catches thi=
s as
> > > a kernel memory overwrite attempt.
> > >
> >
> > Wouldn't there be a similar issue in the SOCK_DGRAM path with
> > dev_hard_header() calling skb_push() after packet_alloc_skb()?
>
> Good point. this does not use hard_header_len directly, but e.g.,
> eth_header() assumes ETH_HLEN is available to push.
>
> Simply caching hard_header_len won't resolve this. dev->hard_header_len
> and dev->header_ops (incl .create) are not updated atomically.
>
> I missed this earlier, but besides packet_snd and tpacket_snd, the fix
> is also needed by packet_sendmsg_spkt.
>
