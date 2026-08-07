Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0746D377A8D
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 08:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786089945; cv=pass; b=isd25gVcQ0m40aryodeHQ8el3xjvWJKxgiEx/rbhG/rbJF+5PfhkMMMHIBK9ZIL9zuQD9T/TiGMegCt/2okhua9yqOr9UOaPlny+/cgDz0XXjce+YUS4QWP16foIDvNC6ORfILfZb7dmYnR1bDh8EIg1H7RSNK4EI5YC0itpwkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786089945; c=relaxed/simple;
	bh=oBSLUeALxK2mQhj3ycbejPHmkcN2bDUHj3PQWDuwt4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jg5aKjHzf2/8KdXOgel04vZO3NQQCNCXcc0cWN3TTwBn4hWXX4NUlCDFsNRNG9aOdLFQGHSBQwKUGFqejnrek5l17kPSJnLDlnIk2t0dPZwtW620RqKduQO3P8vXWfwiUW2z9kuDe5NMizi+W9AGIpMse7FNdREiB0tMflTxEtU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=K1hF94wH; arc=pass smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="K1hF94wH"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-39c7fd45465so25135281fa.1
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 01:05:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786089942; cv=none;
        d=google.com; s=arc-20260327;
        b=Q8jzuTbfgsL0i/8ktrt4pGbNm9X3Mo9GPf7dh0XDSWJ6BuaeJ/ttOernHKzTHlV9X1
         w5c3DU3X7TsUnkLCdTkmgXxRGUNpTgbFPp4Z/hKrBjeWMIBICxcMKmEMnC/B0aAz1Pw3
         O0dQ1jwW7TAFAyg/FAklu5k4suoZgyshOb6EXpPDwj6fubuMlhN7MTqD6dNz7wA88k7h
         l40ppALRjP3fYHkxkjia56JOaZAl6Twlr/F+SKg3S4gyIHltDjvmgoFqsNj2Rg9+h+Nc
         8w5cOQ+3ScJv6dTi+GpBkk+RLyelLiGmATaxOqsfWoWuv+lEeaLG5AXPp2Oq2x9tlLnz
         mQ0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OKakl6P7JpAsPOM14zRfjMCdXJDFaGYpoI2nR2ruN+Q=;
        fh=zb7bMxClPP/6ljgM1rHUP2A+FZfKoIkONDtssNMpZ1U=;
        b=SNMkgZAuyZgYWBU2jsfA1vgch5LEdmlpEAF+vJp56DZmqtmvThdo0wUJbZDQ2j27WC
         vAmHz3nFByJynk5/d+ijST+Aj3QabqVdE4TiOA5Ym/OP0bteIVQCPUZ2pA3LUvKru481
         GRMVDHrwv5a9qXOHU6dT02tOvne3Kmkb+htkGo3mDUu1LAL1pw3hpbNoudrSkzOAiEWJ
         q17KAdx9gV3KK23Npat5YGI8gJohkmAoODcvfxAq8SWgD+Zj70ck6YE9fGNn1CxnFRp/
         Eb9n4Yd0t2hMxBV3cfnioGb07qc6MFJDEZl7Od2S4epQkW+zsNM8ZUH321T5ByjTy2IK
         gr1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1786089942; x=1786694742; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OKakl6P7JpAsPOM14zRfjMCdXJDFaGYpoI2nR2ruN+Q=;
        b=K1hF94wH5b2WJ0vqVvX7dCIRM6ePzq7PyNddEZro5/qMUQCTzGKW47mShVkQNWvpje
         82vpTjZKR3C61c4Ef5kV2v/ouQldEniU3AindJQqDA5LDhaGqs4yOd7bFCGLWdUkfQDw
         F1cptgo/6nyucEUYwnBjv+j6CI2Wy0biUP8ufI6srweuc0BUCreGPLtdKwXfiEOv9Lab
         zkcZkZDId8QA4ctn/VdFUtSmMFuwQJB8znoYP7YwGx3sLa67EGrs651tW3sVnewvvwX7
         5rGpwa+CO10R+SEVlFPkhgeW0yYsDijLcMF17ifcVVS0YvRVbW04iDFw5UcVwfs+xf0C
         AYSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786089942; x=1786694742;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OKakl6P7JpAsPOM14zRfjMCdXJDFaGYpoI2nR2ruN+Q=;
        b=LmJwqlNZ8/D921u3cKmLMJZPRoX+G49ytlaKpVh4f0fx40N32pjN5GtW1b4+Hnrvkq
         o1DZabfGs4bsMHHH+77LhOopzC4baF+JwBfMApgSYtHfbdIbE18q9ZNnCuZ+BxTh7k8i
         yfpKo8PD5tROLWluCIuqjmftAXn/ieUVy/oZn3vUr/iS+b7OyBgL4Wk5w9nFrKHqFguR
         rTAM+EE3p/qGzudCxpADvNWuzjFm2iG+oI7RPosgyO+V5PJBLsiPTkq8Wk77B3Ntf7o0
         CxstBQ5n3IxVJ/bBZaXHBqc5iWV7lqQofO3maO0QCQUhcp8omL7Thw3cp5K45OxjqNhz
         96Cg==
X-Forwarded-Encrypted: i=1; AHgh+RolyIrPYJZR96djhaJeMpVLnyVHe0Vbojdrw+h+UFCbtyRroJpyg8GQp/dirGfRYC2KGUVajs0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj6XIPX+o8jABjSJzwwrI1+4v5wv6v49NXvEuwLV+RGWHRdyKE
	9ZgmsU5NikJq7fkvxPQH3mXMyQTk4SCXUC7R+tio/+6kQMC718dF4HuwuRvHsnC8IIcmsr7Oq1x
	GvxY8EkFDq8vKbTW5vwMcnCyPlOr/WM/lzUMiRCqnlP0=
X-Gm-Gg: AR+sD11Wxyeehti5DZy6XNyQQgJr8uGQ1VeX8WcsOI73UY6oqqUncSaRkXJ66vBEg4y
	XBUoRktPgdg3xI8Hj9El1EkJw1HwBX0ALYQrwiqSFif2SoDpiFQ9Qdn0zWgYj9DLH0W8TVc2I8c
	GppR9+HgVyvCt2kpKUbYPQ7WixC8wYHCs7mepAh7tVzoCnLsCMlYTIofV8Wfq5H7ZzwFdli6RHx
	PTshppzZL+/TG31O+eJm4Okd7lQr0PqsvfomaR4zTcB1Akrz58YkU4En36W5Ly2ob6xnuvAbdu0
	yzIAki5eAQq5gbX8XsQ/OOpReZ5oRSpYl4i0mK4lKTiD9svXpDRltY7DFnBWTUdB4Df916wpN5E
	j6sWh6SMn+Hbj
X-Received: by 2002:a2e:a54e:0:b0:39a:fd6e:cac6 with SMTP id
 38308e7fff4ca-39fbb31824emr25488821fa.25.1786089941645; Fri, 07 Aug 2026
 01:05:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1785995291.git.caoruide123@gmail.com> <202a6f62-6ffb-4f18-9168-66621b2963f3@kernel.org>
In-Reply-To: <202a6f62-6ffb-4f18-9168-66621b2963f3@kernel.org>
From: Nebula Security <vega@nebusec.ai>
Date: Fri, 7 Aug 2026 01:05:29 -0700
X-Gm-Features: AUfX_mwkrsTStAIMuBqX2jClx5RWNubkdHGe6Fv8dElV3JTzKRJ9hQSS-zgSWDs
Message-ID: <CAHYtud03+zYTwFtbz5-aMNDrbijnH7v=5QXoyiCrL88hgcckoQ@mail.gmail.com>
Subject: Re: [PATCH net v3 0/2] mptcp: fix request migration ownership
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Ren Wei <weir@nebusec.ai>, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	martineau@kernel.org, geliang@kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	ncardwell@google.com, kuniyu@google.com, daniel@iogearbox.net, kafai@fb.com, 
	kylebot@openai.com, david.lee@trailofbits.com, caoruide123@gmail.com, 
	sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 5:43=E2=80=AFAM Matthieu Baerts <matttbe@kernel.org>=
 wrote:
>
> Hi Ren, Ruide,
>
> Thank you for the v3! Here is a quick reaction, only about the
> reproducers, not about the kernel code:
>
> On 06/08/2026 13:14, Ren Wei wrote:
>
> (...)
>
> > Changes in v3:
>
> (...)
>
> > - Added a packetdrill MP_CAPABLE reproducer and decoded warning.
>
> Nice, very appreciated, thank you!
>
> I confirm they work well!
> > // poc for MP_JOIN:
> >
> > // Minimal reproducer for a stale subflow_req->msk after reqsk migratio=
n.
> > --tolerance_usecs=3D200000
> > --non_fatal=3Dpacket
> >
> > `sysctl -q net.mptcp.enabled=3D1
>
> Small details to help you next time to look at packetdrill reproducers
> for MPTCP:
>
>  - You can add new tests in gtests/net/mptcp/<dir>/<file>.pkt from the
>    MPTCP packetdrill repository.
>  - Then here above, you can add: `../common/defaults.sh`.
>  - And execute your tests with run_all.py from the gtests/net dir, e.g.:
>    ./packetdrill/run_all.py -lv4 mptcp/<dir>/<file>.pkt
>
> These tests will then be executed from a dedicated netns, using many
> sysctl settings: this helps to reproduce issues in a more controlled
> environment.
>
> > sysctl -q net.ipv4.tcp_migrate_req=3D1
> > sysctl -q net.ipv4.tcp_synack_retries=3D1`
>
> (detail) Here, tcp_synack_retries can be set to 0, then the sleep at the
> end can be reduced.
> > // Listener A and the owning MPTCP connection.
> > +0     socket(..., SOCK_STREAM, IPPROTO_MPTCP) =3D 3
> > +0     setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) =3D 0
> > +0     setsockopt(3, SOL_SOCKET, SO_REUSEPORT, [1], 4) =3D 0
> > +0     bind(3, ..., ...) =3D 0
> > +0     listen(3, 8) =3D 0
> >
> > +0.0   <  addr[caddr0] > addr[saddr0]  S   0:0(0)         win 65535  <m=
ss 1460, sackOK, TS val 1000 ecr 0,    nop, wscale 8, mpcapable v1 flags[fl=
ag_h] nokey>
>
> Also for next time, when validating the listener side, feel free to drop
> the TCP Timestamps option if it is not required (like what you did with
> the other test): that makes the .pkt file more readable.
>
> (...)
>
> > MP_CAPABLE packetdrill reproducer:
> >
> > // Reproducer for MP_CAPABLE request token ownership during TCP req mig=
ration.
> > //
> > // The first listener owns the request created by the MP_CAPABLE SYN.  =
A second
> > // SO_REUSEPORT listener is added only after that SYN, then the first l=
istener is
> > // closed.  The SYN+ACK retransmission timer migrates the request to th=
e second
> > // listener, and a later request timer destroys the migrated request.
> > //
> > // On a vulnerable kernel, inet_reqsk_clone() raw-copies token_node.  T=
he clone
> > // is not the token table owner, so destroying the migrated request tri=
ggers the
> > // MPTCP token ownership bug.
> > --tolerance_usecs=3D250000
> >
> > +0     `sysctl -q net.mptcp.enabled=3D1`
> > +0     `sysctl -q net.ipv4.tcp_migrate_req=3D1`
> > +0     `sysctl -q net.ipv4.tcp_synack_retries=3D2`
> > +0     `sysctl -q net.ipv4.tcp_timestamps=3D1`
> > +0     `sysctl -q kernel.panic_on_warn=3D0`
> > +0     `sysctl -q kernel.panic_on_oops=3D0`
> > +0     `ip tcp_metrics flush all >/dev/null 2>&1 || true`
> > +0     `tc qdisc replace dev tun0 root pfifo >/dev/null 2>&1 || true`
>
> Same here for `../common/defaults.sh`. Then I guess you only need
> tcp_migrate_req=3D1 and tcp_synack_retries=3D2 (set to 0 to reduce the la=
st
> wait), and "wscale" will always be 8 in the S(.) instead of depending on
> the environment.
>
> Cheers,
> Matt
> --
> Sponsored by the NGI0 Core fund.
>

Thanks so much for the detailed suggestions! We learned a lot from
them, and we=E2=80=99ll definitely take them into account for our future
patches.

We=E2=80=99ve also tried using packetdrill as the PoC for patches in other
parts of the networking stack, but some cases don=E2=80=99t seem to be full=
y
expressible with packetdrill. Anyway, we=E2=80=99ll try our best to use it
whenever possible.
