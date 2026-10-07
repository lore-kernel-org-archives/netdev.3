Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04E648BD35
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 11:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791371360; cv=none; b=Zo0wisD7rf5ySaMZA3yXx1xFO8CJChfRVmih6mlILkQJxzz3ce07Tk6JDPqB2DOLnUK8UA1daVh5wl99D49H35OBA83kVLPeJ4UG/PDL/T2fCa+lwmslHrh3YXn9Ba5fmxQORLufsLeenvCIzu41NWVu4+4LifmIhA5LlZpYDtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791371360; c=relaxed/simple;
	bh=8DMF6Po5NeZA8sUTTWo7qUUSIMLASB7Oi6OlVRLSVIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qWi7h3n10IgQkPW5izQeEzlqXcOpmIlpa/VClL7OGWqX8wl1JWyPM4mKzFiZZ6EqDnJUuuEvFhyH3cKrJMNoydQGNotJkvR9aqgw+lHnH/mgI2PAOYmDHVyl+UfKlBmrv6iYBc6t5Obsu9CB+j1LxU2cDdo7kYul/Pe6gUO2jNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mv9T7oVi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mv9T7oVi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36CBC1F0089C
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 11:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791371341;
	bh=8DMF6Po5NeZA8sUTTWo7qUUSIMLASB7Oi6OlVRLSVIw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=mv9T7oViAMazSBuj98f9jRH/SyozP1SKPkyKixqgQW8bP6Vt3/uACgNtzToftwkKr
	 M6vq9Uf83i/YwEPLC0JlPR+u90+POzNqKPzfQg5u4zuj2dQQbc7nCSRTzEqk7vLpPR
	 2khhUEr25IhOcBMPRfOWfkngYT9RDon/ENRzpQrPrIfbON0f1BcetnzQbtpZdpTwp6
	 RboHB7NAGuxbXInAmbLd2TBWfcRKnoJF+lV5IYwODz7I1uPKt1Nhp1jn47PvMAMf0k
	 kdn+W5owQeDRkS/7nFtTrCmtnLie2nBCpo9/HtxX+cZdg9wZbW7OVvP0HhLkBWxHky
	 STlE02hZ4VHiw==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-49dd13a91d0so1237237fac.0
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 04:09:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBw9ZJSN2O4mMBpLWXydzulZrtKP2ziEHxHK4AfGoRL5ZUHjrxPCQmVY8bLQLuSony6n9qTtVLE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLsxq9wpe9A0aJoUKkZJ1Rh2Fd1XVvIkPB4mNFkIjD/heCLp2jO
	K4Oe6EXa3MiVp4yG/TWb5Pqnku1Nv9jnLV9xyfSz2RwM0SRLGYYXHpDsrsBV0QZiRehaic/9CkL
	zus62u0D0PD8rZ1in9ccjwsj6Q469vPY=
X-Received: by 2002:a05:6870:6127:b0:491:4a20:8ab8 with SMTP id
 586e51a60fabf-4a259504734mr1896973fac.28.1791371339997; Wed, 07 Oct 2026
 04:08:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261005145430.12777c2c@nargothrond> <2026-10-06-1-daily-reply-0020-bnxt-en-vlan-447cbe95@kernel.org>
 <cce34174-a70a-4e59-9c35-fd74309b0fb5@leemhuis.info>
In-Reply-To: <cce34174-a70a-4e59-9c35-fd74309b0fb5@leemhuis.info>
From: Eric Dumazet <edumazet@kernel.org>
Date: Wed, 7 Oct 2026 13:08:48 +0200
X-Gmail-Original-Message-ID: <CAL4WiiqSoLb9kdXwdJHH2P55+9214aRRcP-61tdKBhRTK7z70g@mail.gmail.com>
X-Gm-Features: AclHuK_Mya-mXIp8BY93pJkwUEfPaM34qzfLZGG1BzLxjhDODa9HqPyHdCQr-2k
Message-ID: <CAL4WiiqSoLb9kdXwdJHH2P55+9214aRRcP-61tdKBhRTK7z70g@mail.gmail.com>
Subject: Re: [REGRESSION] Commit 447cbe95ebb9 causes IOMMU DMA faults on
 macvlan/vlan with bnxt_en
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Sasha Levin <sashal@kernel.org>, =?UTF-8?Q?Fabian_Gr=C3=BCnbichler?= <f.gruenbichler@proxmox.com>, 
	Michael Chan <michael.chan@broadcom.com>, Joe Damato <joe@dama.to>, netdev@vger.kernel.org, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, regressions@lists.linux.dev, 
	stable@vger.kernel.org, Stefan Fleischmann <sfle@kth.se>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mer. 7 oct. 2026 =C3=A0 12:35, Thorsten Leemhuis
<regressions@leemhuis.info> a =C3=A9crit :
>
> On 10/6/26 23:35, Sasha Levin wrote:
> >> I'm testing the patch on v6.18.55, and it looks good so far. 5 hours a=
nd
> >> counting without any issues.
> >
> > Thanks for the bisect. The root cause is the bnxt_en small-packet paddi=
ng
> > and DMA length bug Eric Dumazet identified, not 447cbe95ebb9 ("vlan: fi=
x
> > skb_under_panic and races when toggling HW VLAN offload") itself, so we
> > will not revert the vlan fix. Once Eric's "bnxt_en: fix DMA mapping len=
gth
> > for padded small packets" lands in mainline, we will backport it to all
> > affected stable trees.
>
> FWIW, better wait a little longer till a fix for another regression
> 447cbe95ebb9 exposed in another driver is fixed, too:
> https://lore.kernel.org/all/CAPa5EdCj3v17tB-SF2JNecq5Q8s1Pranr-XzAFWNpNTB=
PgPG7w@mail.gmail.com/
>

Different issue, and already fixed.

https://patchwork.kernel.org/project/netdevbpf/patch/20261007073027.459868-=
1-edumazet@kernel.org/

This different bug fix will not fix the pre-existing bugs in bnxt_en.

> Ciao, Thorsten
>
