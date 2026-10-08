Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38034F7CC1
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 21:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791493433; cv=pass; b=V17iWXu88xwdkllKFFXltNUGFOxVKqpPSxkyVIczd+JJLxtmkYShuX7+NR53IPLlsquF/E3Ai8cpvXM8jwn7RfRaMIiXDl8WiH1Gn5MlCPt8XI39dfWr2lPEFv12jfc/u36m5xHrcc1xUzJHseDq5rrRtpZotRU/k8SA954BlXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791493433; c=relaxed/simple;
	bh=vl6P2d7bzS5ltJJCjjguAr4o4FboZty4KMxvPMf44as=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ikomK0MYjcKUm0i8Jx3T71b3VurCEGn9xQjNATC7a7eoFJunE8Vj/D5TrBePixQcvj3OKRXIDqVVcPHoTEnZEBn4ZGGftFlFyjncBCdzSwDxvnQ7qFr1G9BnzALVA5Oytu/4Ghy2hTJO08QQW9111LuM/eSSqJ8/v6Io8jWpvqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UXb/7leP; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UXb/7leP"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-675676afc3cso4064204d50.3
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 14:03:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791493425; cv=none;
        d=google.com; s=arc-20260327;
        b=DzZtRVX2JjSiR/PEvp43kfMvmkkA75vRK+L1LqH+7R+z/IY7Zb0XewjnJ6Gm/l5FhH
         xdNkNYWgw8NfXfrzs34hqDh4vs8dzqg1RcXfLrldRivKuFCAJHZy3P9PIzs37eT0gFb8
         SQNTH01y97hIOteZmL1MrCNwWsK8z/TOLkvc92l6F+77ZYYkCVhE8fnJjAduC4JMnScH
         weVxBhjdaQ6k3UvBAjQGyAohLO89scYs8QbNSTY7fndUnTRvK91NXe7ayqazLLo1+O5g
         Yz66FUP30Gwj98k4inynlLaLDnSVcXQPKDF7Tbq79iP01bU4pIwxoUzezzBZ0hXUa9yv
         xEOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vl6P2d7bzS5ltJJCjjguAr4o4FboZty4KMxvPMf44as=;
        fh=8RlJa7dWi+SFWDmfA+zrnjsm2rsIky4UKkWmv/eTFX0=;
        b=IE+F4aygDLCWnkcwViNk0ULJsePB+SGw3qFtaPx5gqDQ0+6hfTiPDvBa5BiCQ9Wi0a
         UizNTy1siDSOuT9fx50yhLLLyvW2QjgIN0tylyOE1ImAH9RjAa1zdi63tWaqjrS3RbQw
         hQkhMG3EgudmBV7LBUk9iprh3Xa9aT1QIO6yn88DQtVy+tD/DA5TWT1eqNI7mkhm4W+R
         zv716sjbEdaUNVoCFgBDrkSZqWQqXYB9EtblFDVYfJY6p984JpAvVI1L9MKk1JPZgI1x
         QiX1icS762WUZYOFQYyWLmn4MJOAqpzmu4BoeprwVXALIjwS6WgZUcPUlo4etzFe3o9a
         f8Eg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791493425; x=1792098225; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vl6P2d7bzS5ltJJCjjguAr4o4FboZty4KMxvPMf44as=;
        b=UXb/7leP6TGNYUifCSK0ZJavuFWdrwXthwZiI6/dWlDhkOz4RHlfPFOujRweRjd/ks
         OiWVTAmZK3nO0GggLSZfwN8B2gWdsKQnsSA10Ke8dGWQcFCYicp3IP29KG+cTVlhft1w
         MqB6+615PiU0qCOGJw3Q6YbiFMFan84RlyjV7Yza1ad85M2NkQJjvLH25YMwb4W7MkWm
         YhFIrndChRBySsVyrWboOrEPjUSAZ5+X4aSujD0WUKIkNPX7+GH6Z6rbyigdR49T1uSW
         qp6t7DKOC3r4nvc8GB5W9LGamVawPCFTigLsreM+nINugjPbXlzsMQ41BFDXrMOH6PHD
         SCQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791493425; x=1792098225;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vl6P2d7bzS5ltJJCjjguAr4o4FboZty4KMxvPMf44as=;
        b=GCans749Si1iNPMga2B5fCfQDT3TBuQRaJiM7YJNf0cDG0wPF9DDrG9aaZnG+b+ljG
         WgBnNF4jIhb7lkZFbvDbIlqLBeyqZUIRF7A54DsSLsW4tX4hnDwcpWRrjS0Q53czoOiy
         9FfxdU18vV5egIaCuFjKRJ+iFq1cJFNsUielXCj1jhWD0NSZlQ23NCr2rsX6adK4koos
         nBbJ8fPKQeV5WV95lQ7DkYstykJ453KccnyREk9quKA30BhgpFqotXTPTxEquC3SLoXY
         ir+F2ALMHej1ovyVsn60QBwN5iAZ63NQIx2mKlbRbopezURlWgT2ijekAsBW9f6iG5JY
         izvg==
X-Forwarded-Encrypted: i=1; AKwUvBzDZQLotWzWtUOxnXmwmr/iCeQTt1fG/VsSwYKsNWpcfeYZhX6efPM0fBLjcVQuwKyw5s0Z1oI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJZgRo8+S5NRVn2sdWJsDQxASDkjDzjV7XBVmVKU6jbnLd6guJg
	kzs11KFH9s5wRumU27sDLyaZlwZq3INQErMH2yjng+i1LCRTAptLUzRuCwmf+QzUzxjoPghdUvc
	nuxkGocvNnLarl5ZKogfoVNzgIyoIQ0w=
X-Gm-Gg: AYBFou1HOAAqtibRSUkP4LAD7LYHiX1znzdBjJpRDMtSGaC4We7KV2FoOyBBCxpXYRU
	dE9bM2682/AKU1ZmWuVG251/PfC+qVlfl3EEf+h4jDigYnkq2vFmjiOXVlofTdRSSLf/fJykYzt
	sDXxoNLZNG00yl486sNynvlCoxjPYHzGElDs11gwQNg9+0uOvzA0HAZWFm8zbfhSfRrGSsp+Kly
	yu4wBvqrFavMOljxjRmec2LkpviQIzNcczGlojxN0tcWf7rNeSJNDCLofojaQeP/K14cQx/L6b8
	5pTgWc+yt9EkeZ2XbpeC2LkMc8bn9RL2e21PNqAsvW7dWU8mJRfu1BLG55q5z5TvXphcznog/+X
	xP5OWuXfO7nZLe5HpBV3OE/11S5H42Qh3Q11BqphDLKUlEMDD3MFi
X-Received: by 2002:a05:690e:11cd:b0:674:1e05:9b81 with SMTP id
 956f58d0204a3-6793628e483mr25302d50.91.1791493425421; Thu, 08 Oct 2026
 14:03:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008124106.665014-1-Jason@zx2c4.com> <willemdebruijn.kernel.cf8fec88827c@gmail.com>
 <CAHmME9r+O=3i4JP94P0-gFwghfWtD=vLa1g3KB-LvW+xFbJWHA@mail.gmail.com>
In-Reply-To: <CAHmME9r+O=3i4JP94P0-gFwghfWtD=vLa1g3KB-LvW+xFbJWHA@mail.gmail.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Thu, 8 Oct 2026 17:03:06 -0400
X-Gm-Features: AclHuK_qKmc6ZKE8_x2MdYae4trfNS2WogXUatNfjY-lv9_2jJsmiBMEjOiQbLM
Message-ID: <CAF=yD-LO0u5z8SU_Aktu0-0aeM-1UknYsGc+rCpD3y9bpwxtwg@mail.gmail.com>
Subject: Re: [PATCH net] udp_tunnel: drop packets when hibernating
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: rafael@kernel.org, lenb@kernel.org, pavel@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, linux-pm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	=?UTF-8?B?SsOpcsOpbXkgSmVhbg==?= <jeremy.jean@oss.cyber.gouv.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 8, 2026 at 3:58=E2=80=AFPM Jason A. Donenfeld <Jason@zx2c4.com>=
 wrote:
>
> Hi Willem,
>
> On Thu, Oct 8, 2026 at 8:37=E2=80=AFPM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> > Jason A. Donenfeld wrote:
> > > The kernel's various networking applications keep churning away after
> > > userspace is frozen during hibernation, even as a memory snapshot is
> > > being made. This can lead many network applications to an inconsisten=
t
> > > state, replaying packets and cryptographic state changes. For example=
,
> > > on wireguard, there's the possibility of this sequence:
> > >
> > > 1) hibernating begins
> > > 2) handshake state cleared
> > > 3) keypairs cleared
> > > 4) new handshake round trip completes
> > > 5) machine memory is snapshotted
> > > 6) packet is sent using new keypair
> > > 7) machine is restored to state (5)
> > > 8) packet is sent using new keypair
> > >
> > > The idea is to prevent (6) from happening, especially if (6) and (8)
> > > contain different data, but the same key and nonce. Presumably the sa=
me
> > > issue applies to other users of udp_tunnel too.
> > >
> > > Fix this by just dropping sending and receiving packets during the
> > > hibernation sequence.
> >
> > A few high level questions:
> >
> > If the issue is reuse of key + nonce during send, why include receive
> > side functions? Specifically tunnel (encap_rcv) functions.
>
> Because I suppose (4) probably shouldn't be possible after (1). I
> explicitly clear the result of (4) in a PM notifier. It seems wrong
> for that to then be violated after. Similarly, userspace doesn't get
> packets after that point either.

Since this is an issue specific with security protocols and reuse of
their state across freeze and restore, is that the more suitable
location for this check? Drop transmit of packets with that risk
(unique for that connection nonce) only, if freezing.

> > Is this a problem specific to UDP tunnels?
>
> The stateless nature makes it more poignant there.

udp_queue_rcv_one_skb is the UDP hot path. Since it touches all
packets, the last resort for adding checks that are relevant too only
a small subset of packets.
