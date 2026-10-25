Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792926510;
	b=yv8WR4FG19Jeyki4WR2kY3GNa7IYINVt6/Y75aFOy9lmDQT607VwApuubmAa+BOBBeaz
	 wtWLrZmLPPFJUm1m8epIHBSbZZjQoMGFCNH1lGP3cISYJdACtKO9xovhJ3XdLQpW66Gwa
	 L0mLE3/cQpDMiiudZv8MFZKLDSniOzAFAxKB7b94/w8Nq/wNAoUhiSD1UySsWpkzjaN7J
	 BzSI5H8KH1eiMvQ5G0bijCD1e5gHjwpOqgrNWof1A4+2dYj9mKst084+O/GqjKF4Lx2Yy
	 4Z/7v8xe2jJ95/94X4rm5U4VDY1pB7evJON4J2E8rrVeR0e12jGRauefinOZ5NlCBOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792926510;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=wEzkguLKY1rpIgRrc4H7ztH83Nki19t4+s0LVafzaNo=;
	b=pMtnO/Z/XOMfTe9h2jdNRxGgyeQg59E1AxTni89HPC+2+op6EePY8F47GLckquFdNJGZ
	 seGzrgRnf3ygHnV7/BAFm1fijDhPKqYgCBll+zhbM+x1F12I90IsQB+uMB4LIt6GK+JHn
	 PlxOg2XgwElku9L2jVUnNfE6qfC9EZ1tiS+GmUdhshGRyvEX9I8S/C0Vqmoc9eSwDGeqy
	 USGIDUXydB3gEbA9hVQrI2a/L3rCZwYANITjntV1q0VIxgKYHuozd1d5QIBmEg5NaUJpc
	 84APk+MjI/DQZZKxoPIZ2J2CQYcVF89RhRHTfvDhcKkH3P03pr+PwgD5crrcyBEZsVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mPxuPQgM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702EA606A31A
	for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 11:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mPxuPQgM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 045331F01828
	for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 11:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792926510;
	bh=wEzkguLKY1rpIgRrc4H7ztH83Nki19t4+s0LVafzaNo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=mPxuPQgMxfEDZTdMPkDxxdWwNa6PrJx/NVFqZmuB3SPbUZVeekbuEiPHJYsHtaWSt
	 QPFXyMH0oxP2hakIPiZicfu7/QNidspSa7tL6xzgG5tXj/jCHOE8OV6RQs6DfNE2iE
	 gCzCtFk0hPR2neN9dMqV0i3ys43OKIbx/ipK0sJenJxBhO3QmoJX/uxFv7OWwNXoG/
	 ZhKuG1IAEKE4Kv8UIVu4dMscjRVnODjDSGOwCcKNY5QME456FNfpBnPsDbNixVp1Jb
	 4EOnW+kKqRd1RwhkI8DIFetyHX0xcCUtrF/wgzSdOn7KrlfqKxd5g0zWxmzGjzuEco
	 ggnRPovzVz5fA==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-483c607ccb4so1169026fac.0
        for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 04:08:29 -0700 (PDT)
X-Gm-Message-State: AFq9FYLT2JgYmOmI9Q/UXAU+vVDtPKwojkJqqqj0NC82qjwvGfq7SU1j
	R6mxeGbF6TUKEV4leM7o6z3uw2jesSv9l0cZpxcTeigqJco6PkHjQh3A1IaZngt2ARaHbjuQ53G
	RQUMQOE3GieSc3ednO7AfFJFYZPz3IYU=
X-Received: by 2002:a05:6870:c255:b0:49d:d2cd:67f3 with SMTP id
 586e51a60fabf-4a83f5e6e35mr2538036fac.49.1792926509339; Sun, 25 Oct 2026
 04:08:29 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261025090048.27870-1-yzwlhm@gmail.com> <20261025090048.27870-3-yzwlhm@gmail.com>
In-Reply-To: <20261025090048.27870-3-yzwlhm@gmail.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Sun, 25 Oct 2026 12:08:17 +0100
X-Gmail-Original-Message-ID: <CAL4WiiqSB3+u57zR0VmZ8CH8Tk2zgV9te3+GTVq+BmEJGh1O2A@mail.gmail.com>
X-Gm-Features: AclHuK9cDAKvvJ8ZEXqhScsj1KYIKsa5DRpjovDC98NpIPSRlhcjT4sZpye_5Ys
Message-ID: <CAL4WiiqSB3+u57zR0VmZ8CH8Tk2zgV9te3+GTVq+BmEJGh1O2A@mail.gmail.com>
Subject: Re: [PATCH net 2/2] tcp: Add KUnit tests for bind fastreuse caches
To: Zhewei Yuan <yzwlhm@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le dim. 25 oct. 2026 =C3=A0 10:01, Zhewei Yuan <yzwlhm@gmail.com> a =C3=A9c=
rit :
>
> Add eight KUnit cases using real TCP binds in isolated network namespaces=
.
> Six check the tb/tb2 reuse caches for SO_REUSEADDR, SO_REUSEPORT and both=
,
> with explicit or automatic ports. Two guard against reinitialization
> when an owner or another address bucket already exists.
>
> The six first-bind cases fail before the fix and all eight pass after
> it, using matching tests/configs; both conflict guards pass before and
> after.
>
> Run with:
>
>   ./tools/testing/kunit/kunit.py run --arch=3Dx86_64 \
>     --kunitconfig=3Dnet/ipv4/.kunitconfig --jobs=3D8 --timeout=3D120 \
>     inet_csk_fastreuse
>
> Codex assisted with test development and review, following requests for
> real binds, cache inspection, automatic ports and conflict preservation.
>
> Signed-off-by: Zhewei Yuan <yzwlhm@gmail.com>

I do not think we want this LLM stuff.

300 lines, a new Kconfig option and a .kunitconfig, all to peek at
tb->fastreuse and tb2->fastreuseport. These are implementation
details, and this test will break the next time someone touches bhash.

Bind conflict behavior is already covered by selftests
(reuseaddr_conflict, bind_wildcard, reuseport_addr_any...),
and they keep passing with or without patch 1, since the bug only
causes extra conflict scans.

If you really want coverage of the performance issue, a selftest in
tools/testing/selftests/net would be better, targeting net-next.

Also, please keep the changelogs and cover letters short.

pw-bot: cr
