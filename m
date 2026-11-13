Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794538389;
	b=BiXZvEf2UNxI2T3uYhfgT9EGOPsA/0bmFwVYQW5bWRYm17Xl1krk7PahVaJVq+d6dTBV
	 NcI3LbsQEhaIWPZRALu+i/+V4RLmRBwBrjgs0BU5Z1/FMBfA9xlh2PzgOwF4c3ncIgWsn
	 gOImWqYMqr1UtGNb/vO0jHsS1a46566250HAMaC2QKWd8o//1k7cVZW35yHq3R9jOINPE
	 Ypy2Z0cKnQkLn2HwzGZo7UpmQfxyqtFijlI5tewnk/TOV78hDCPKy+BOQyJ5XR5G//5ga
	 ESdwDLSRKMZ/oVmJe1vT/bm8xa/Ti68fgOeZy+OZI6CAmXEjb8Hks+5lXK5pnZbK2Kg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794538389;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=2O3WRSStq1Vvx0xfIc6410rBWX9ccYZ1VYC/roGW1EY=;
	b=YYZWtM/cFiEU225cjhyFdUMRTX5WsltHiJ70TFmNzBLTFgf1ZujqOMC3wHSjyL7qelTC
	 1rjHU+MhM0NCZEjit+xySnsYca5gG8QT32Q2EZLz7jk8Sm1qo7b1lIjVM+ekFgao9Qw0B
	 rJRQgKn2RvEY2IuxUi6AGA1vHzOutg7OvNN+Rpm4OLVBpQKnscK0AZzQI5MPHFLpBWv7L
	 ELeV1PYaq46Rh9iTByssiTNMgenIc09ybKNy2Yn3+6QQRwJkUE7B4YYgu3Lqx+6E3qBBs
	 z8S8wqE+sQwLx3E2aJXD3SOJbLTS1bE30jpuo9y169USDSfEndhBDmN6+MAMuvjREJg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Qeo0RI1i;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.46
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D17606A327
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 02:53:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0D17606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Qeo0RI1i
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6b791a4b732so3144a12.1
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 18:53:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794538387; cv=none;
        d=google.com; s=arc-20260327;
        b=jdq1LBmxAFQ9kx2II+aWUpUglmtPxu5OQ5Ujtp4U4VvLB1iA4B1Q7vmhCrfxcfevxJ
         PXvm6LmRnIg2HbwVBzIyle77JFn61DvQxkBnPktnoMkSAtLcbeRLKhKtobOCe/tY6sfY
         aZvQd9MjNnRULOJ1Pqfv0WFtJoaSuEEe5SdJvNl61E3TIqOAyMPsuTMcIjysFgjBwEUS
         +8FKBynz8k0z5GVH+hHbeKArk+jwLaAtnLLHabywanGG/lOptWTk0i0ONcNt1Ww1nCGY
         UM4WKW6//hxbIFN+jkSiF6NLeG4+O3zXBMO18xodlWXQ+RozG/qD2BjXDYhSP4Cwe7Hs
         EFDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2O3WRSStq1Vvx0xfIc6410rBWX9ccYZ1VYC/roGW1EY=;
        fh=vaRfhfuVWBgecNVPttRYINfb/xmecJG73yGqszwyHFg=;
        b=ZGz/eMfFBpoznkwNU7Rr8i7VbUtrdfrvg3kbWM90J1NA95qAMnoKQOny6kbJpQ5DhT
         OHbSNXs5QitN8MAionrzERVBHenq0tyvMTTJEcUv29oSlWTy60cMz2wm9ZFjBv+6qW5L
         qt68SFrmRDaJE+8JYuD4ZqVG2ILJUJvehKFKs1IRc564ta1KilNo2JAffgXNU4iIxZuZ
         zE1Aeu/Pj/zQ6UVJrAxC6Z36hwdowm/JhOQy13jUCuC0aVTl0jnlsWin1dUVQxFMnmkC
         8yU+ich6gHTl6wwGku9nghSBfkZNwNoaZ6MzenUKSruNHUawYr6da9YkiycbL1j9L3ar
         OmiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794538387; x=1795143187; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2O3WRSStq1Vvx0xfIc6410rBWX9ccYZ1VYC/roGW1EY=;
        b=Qeo0RI1iwE7m8f8yyAZqt9JgJty1N8DfjhIajrv/f+mo0v1rDLQqFYysxFaJ01SMDs
         qAGcGF+W5xkdCg2woJ/gHEF+WRl4KaX55SmYZmtdt309sptmLdcmHwf6qjJo3pRg9beQ
         zWRJaFrc+I6DVV63y+GyeHVikpMqJWH4UE1gTiVc2h7TQ6RswcscINT5k/ou200KN8PP
         opUZOhbXTl6iXV93wPfRdNyq/rST955uBV640ycRW2SCIxDjkm6+1KIZxZI697bT1L/F
         GRXdqQ3AZaoJAoRUS3dTcEDsgo4DUV7kp2dHA/vUB7QntVqcyGITghY8OTukfaZQHfTD
         YYtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794538387; x=1795143187;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2O3WRSStq1Vvx0xfIc6410rBWX9ccYZ1VYC/roGW1EY=;
        b=TmND/z7aEmgb0A+1ISpdEvpjDuAiOgT/QKYuwWXtQ1CTFjbMLheczSPkM8msncQNjt
         w+0k/Wv38ehsM7pITw4krmgx2VInOR9oUKSUtlZg6W1kJZCdi4cilIHaHNloQmpPsmT3
         WOFW463kamlImAaIo5+5rgIRZbk3HRz4fa0pOUWZo1T8mQzW2Rldvbdetw5yULN6epds
         5IM9GRMwi3cevYilKWdfDrASf9BPHrxKF8Ch7DhmIaYkRKcAqS4gLoHXcX5sM3XLig4q
         llEVee3wYnFa2xjs83/gGApQlukMrbz5LtOwuyOVU95VtFBesiEN9+ZQF8EcT/KiElbn
         SVdw==
X-Forwarded-Encrypted: i=1; AL+hErEjlbf7mN/XIbpiQPzYe+bIPbe8ynu0CFV6/C7bWiXQkipRGFukzmwgYsySWoop3fQQQ1nZECw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9+lz8RoZDhL7CqM7/m0M1zhKwggKnk2q7GburnbIJ4NFI5+8xc
	yy8Zfl2l7KNVQaWxHKEUChQ/DhSJSzXZk2w+W5rRqBsNCOuhC0wUIQB3MgowmtAGkEjVTAA/V3w
	5vCUKLr+O5DQF0DgkGHgSpXewPLmoXja2WKq1zEhK
X-Gm-Gg: AYBFou143VsuG2shkYVS+COsLAhMSWQx7YUT+8MfBpZt38RZb/kEaYEA1mls+D0JEUQ
	F7MiKnQ6a8o5h1fYKREE+HxR93Nomg1/qKN8Ml3X0pHfGsZkEbeRpnfZyDy89YTJsfWQluT78eV
	4X2cwMI3SShh/OxoG3Yo+51Z+ZlIj9eNCg3gIPFswoThCr34ug9IknFoizzhvORulgPTY89EZhI
	BPPAdcJHbGeTmqHZmfsc7focyu6kqXgC6Oi1+U47O6pxHz83Tb9XSSpSM8sUH+V4nrPeg7vMQ7p
	rXSiBUXUYElds/CudyZTbRtfPsCrBpTOSr1X6VIUfc2UjTiIEhoS3VaXJYAqYM4ZWGM8LQomwje
	6uo1B0mWUNCwLMVanFpJTfK0oeRCpDG8fxJs=
X-Received: by 2002:a05:6402:a306:b0:6b5:5d24:5d90 with SMTP id
 4fb4d7f45d1cf-6b7c33b4044mr56230a12.3.1794538386913; Thu, 12 Nov 2026
 18:53:06 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261113-b4-skb-segment-clone-fixes-v1-0-f777fb06f3e7@toxicpanda.com>
In-Reply-To: <20261113-b4-skb-segment-clone-fixes-v1-0-f777fb06f3e7@toxicpanda.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 12 Nov 2026 18:52:55 -0800
X-Gm-Features: AclHuK9d-OZyOUmV1lIF0VeyETtaPUgRdB2dnMJi2UF6wS1XHEI73N1NOhsn2oM
Message-ID: <CAHS8izPUReUBbsVYf4dOpfjHhVrOhW9VCn9PDZ6k5Y720eVMug@mail.gmail.com>
Subject: Re: [PATCH net-next 0/4] net: skbuff: skb_segment() fixes for
 frag_lists without SG
To: Josef Bacik <josef@toxicpanda.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Fernando Fernandez Mancera <fmancera@suse.de>, David Laight <david.laight.linux@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 4:21=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> Hello,
>
> Sashiko's review of "net: skbuff: don't run off frag_list in
> skb_segment()"[1] found two problems in the branch of skb_segment() that
> clones a frag_list member.  Both only show without SG.  That series was
> applied before I got to them, so these go on top.
>
> Patch 1 is about a member that has a frag_list of its own.  The clone
> loses the nested data and the next member goes out in its place.  My
> patch made this worse: for some layouts it turned a NULL pointer
> dereference into wrong data.  Nothing in the tree is known to build such
> an skb.
>
> Patch 2 is older and doesn't need a broken skb.  Without SG the copy
> doesn't move the frag_list walk along, so a member that has already been
> copied from can still be cloned.
>
> Patch 3 makes the GSO KUnit test compare the payload of the segments.
> It only looked at their lengths, which is how I missed the first problem.
> Patch 4 adds the layouts that went wrong.
>
> GSO_BY_FRAGS is left exactly as it is.  It needs a fix of its own, which
> I'll send separately.
>
> The bug that patch 2 fixes is in released kernels.  Both fixes change
> the condition as that series left it, which is only in net-next, so I've
> based all of this on net-next.
>
> I tested this with the net_core KUnit tests at each patch, with each
> check taken out in turn to see a case fail, and with a throwaway KUnit
> case that segments 100000 random layouts and compares the payload.
> Without SG, out of 10000 layouts each:
>
>                       wrong payload   -EINVAL   right
>   nested, net-next               61        78    9861
>   nested, patch 1                 0         0   10000
>   valid, net-next                79        39    9882
>   valid, patch 2                  0         0   10000
>
> The results with SG, and with GSO_BY_FRAGS with and without SG, are the
> same before and after each patch.  I also ran SCTP over veth with
> tx-sctp-segmentation off, and the tests from the earlier series under
> KASAN.  Thanks,
>
> Josef
>
> [1] https://lore.kernel.org/all/20261104-b4-skbuff-bug-on-followups-v4-11=
-b7ffeb364f5d@toxicpanda.com/
>
> ---
> Josef Bacik (4):
>       net: skbuff: don't clone a nested frag_list member
>       net: skbuff: don't clone a stale frag_list member
>       net: compare the payload in the GSO KUnit test
>       net: test more frag_list layouts without SG
>
>  net/core/net_test.c | 199 ++++++++++++++++++++++++++++++++++++++++++++++=
+-----
>  net/core/skbuff.c   |  12 +++-
>  2 files changed, 190 insertions(+), 21 deletions(-)
> ---
> base-commit: 676f3aace662fbbc180b3898b190a372fa2a516b
> change-id: 20261112-b4-skb-segment-clone-fixes-79ddc7ec0494
>

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina
