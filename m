Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574173932C4
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 19:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791489510; cv=none; b=cGvpSktXzeH9V5vd2qwYsONlyYLI0B0+/lqhcZ72OgpUPtMDBp0uaUAmsXcun8EjH1MdKcS8ZainS4mBLYhqAigRFQan0jdRLmjBIx6GX+OH5+Dm+cY2Lvg1qbaWhehW+ZVjcrkHmT7+X48s1XOdQXBZRDXuiuCwLgdOqTHe8DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791489510; c=relaxed/simple;
	bh=hcwMIGp/ItvbKuWskirhr0jAfYMcYkEhubcSn70VxP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nc4PpiPKu0yn2LEWyyCLRUjDk5WzjiHKQvR2jyUxI8NE/pbZt/vpMiJXl38THP+CUhwoQ6moV3igsa9KW5TE3yOOxj0pMFY9mteFRdt3SslFDs2x6mLocTu63zKvx+mvnqggFjzdORIU8wvj7elJdIRRxkZ9TnTKaposv7ez4s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=byk0fhLu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="byk0fhLu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9C1E1F00893
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 19:58:28 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=zx2c4.com header.i=@zx2c4.com header.a=rsa-sha256 header.s=20210105 header.b=byk0fhLu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1791489507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hcwMIGp/ItvbKuWskirhr0jAfYMcYkEhubcSn70VxP4=;
	b=byk0fhLuwV0E+h+PsDqR2rhg9zYLjnlAcw1tlE+kaEhBdJ8YBwhDRVXU/bZvOfh0Js/DtA
	L8/XmYUGJrm1i0xqQrDRpwEsp7N/94tsdrK+BtS60v9cVR/7hjrMTBb8fbR2oV7qhkkc8X
	W9n3bxNUuBgsyBFzS0Rrafbxg77l1BI=
Received: 
	by mail.zx2c4.com (OpenSMTPD) with ESMTPSA id 4f432833 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <netdev@vger.kernel.org>;
	Thu, 8 Oct 2026 19:58:26 +0000 (UTC)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c2e8e738ae0so536130666b.1
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 12:58:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxe9B/TVsOH8pRJuNKbvHdUG26t2APDB6qK1iMnWwdaEtYcuH460BUghUxVVrdnsMHUzUTOm3s=@vger.kernel.org
X-Gm-Message-State: AFuF++lpkzBs4UY1yUyiCzVyzggG1KysTgFYPqEFndx03FOOr5ZvU1p6
	epXF7r1ptALAOOt5QgpGs2yQOcgSU2XoUMoDnC1gP0EUXUFYiNEED1Q4zXFVZp2tpN/0bFCf+9q
	l/xDyT31wRfVlwLXeJaGdbaWLJZ9Qmj4=
X-Received: by 2002:a17:907:d516:b0:c2a:cf73:63fe with SMTP id
 a640c23a62f3a-c317bb4a7aemr611808266b.6.1791489504577; Thu, 08 Oct 2026
 12:58:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008124106.665014-1-Jason@zx2c4.com> <willemdebruijn.kernel.cf8fec88827c@gmail.com>
In-Reply-To: <willemdebruijn.kernel.cf8fec88827c@gmail.com>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Thu, 8 Oct 2026 21:58:13 +0200
X-Gmail-Original-Message-ID: <CAHmME9r+O=3i4JP94P0-gFwghfWtD=vLa1g3KB-LvW+xFbJWHA@mail.gmail.com>
X-Gm-Features: AclHuK-nMRR4vDW6p8Uf5Up3EywswkHru31OUDV8tShUhR4s3Srh0YZqfW9UwsA
Message-ID: <CAHmME9r+O=3i4JP94P0-gFwghfWtD=vLa1g3KB-LvW+xFbJWHA@mail.gmail.com>
Subject: Re: [PATCH net] udp_tunnel: drop packets when hibernating
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: rafael@kernel.org, lenb@kernel.org, pavel@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, linux-pm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	=?UTF-8?B?SsOpcsOpbXkgSmVhbg==?= <jeremy.jean@oss.cyber.gouv.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Willem,

On Thu, Oct 8, 2026 at 8:37=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
> Jason A. Donenfeld wrote:
> > The kernel's various networking applications keep churning away after
> > userspace is frozen during hibernation, even as a memory snapshot is
> > being made. This can lead many network applications to an inconsistent
> > state, replaying packets and cryptographic state changes. For example,
> > on wireguard, there's the possibility of this sequence:
> >
> > 1) hibernating begins
> > 2) handshake state cleared
> > 3) keypairs cleared
> > 4) new handshake round trip completes
> > 5) machine memory is snapshotted
> > 6) packet is sent using new keypair
> > 7) machine is restored to state (5)
> > 8) packet is sent using new keypair
> >
> > The idea is to prevent (6) from happening, especially if (6) and (8)
> > contain different data, but the same key and nonce. Presumably the same
> > issue applies to other users of udp_tunnel too.
> >
> > Fix this by just dropping sending and receiving packets during the
> > hibernation sequence.
>
> A few high level questions:
>
> If the issue is reuse of key + nonce during send, why include receive
> side functions? Specifically tunnel (encap_rcv) functions.

Because I suppose (4) probably shouldn't be possible after (1). I
explicitly clear the result of (4) in a PM notifier. It seems wrong
for that to then be violated after. Similarly, userspace doesn't get
packets after that point either.

> Is this a problem specific to UDP tunnels?

The stateless nature makes it more poignant there.
