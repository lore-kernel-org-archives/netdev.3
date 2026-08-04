Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317EE47B413;
	Tue,  4 Aug 2026 21:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785879529; cv=none; b=pD/0L7ep+dP0hyokirft/zY50sWgtYk4QT7h1XiZq+u2+0VJFPPh8CxfDGYtZBfwkBOKrzS32eCFbbQxs1QhDdS5WO2xllLyD7PEcCseqMkOWH/rHx2d1HRRMQ1isLPLADQk99GSQGBfJq/1tB0UOQ/7dY/4gcbjMSDBZDjjFgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785879529; c=relaxed/simple;
	bh=UK3iLZgth5RKF7ZAIeS18ZMikwsPP1qSZJDmFynRGRs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GPoGWmcy62BWkcSRBbTABg1syPJ8zNTj8g4pLEcdqX5DwPXEnE5zFPlPZkust09Zfyp+ja/3JafhP5DK/HdNybLBIG8ywOFzHu4CeCfQpqZUog+gu50ozWjKIqBZP/OxUt0CQYxZdZ9ndt/8NX+9fmrjfDMhf870XO2zFU3hO7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJdz7ZLX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJdz7ZLX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F19BF1F000E9;
	Tue,  4 Aug 2026 21:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785879527;
	bh=0Q4O3AL+SNRdL07VMANylJ+pN0x9c8wvXlyXzxv5uNo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=IJdz7ZLXJEHozcG1U9tikyOlt/MsXii0k9AnoPvVjJKH6uofUoG6/ssFkuTGlmSKu
	 7hG4uuRoycoRh8B6d3JtUTzWvD5ime2GZMmoLGpfNbX86tJmev2wzdCB2dG2zzgBci
	 eTSVZ2EhCw1qTZH54jHjuJgg5nrilUo+6cSX2n7ZDKJ9UwW3ZHVkqKCfu/MjLCVbhw
	 U4F1CGNA/vwNdDY2kEWBzKZVgs0XfrjaMCw3OKm0+ZjNGPLstl+zrJyagQFH2xUp6b
	 A9OkSjkiOgYYK+txwU7H3HQluE0/YGEz46sc31+4NullGa/pq0MwOwWKHecYW+Y7Xn
	 2kDFhXsAeXVxg==
Date: Tue, 4 Aug 2026 14:38:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, kerneljasonxing@gmail.com, kuniyu@google.com,
 bjorn@kernel.org, jiayuan.chen@linux.dev, kaiyuanz@google.com,
 willemb@google.com, asml.silence@gmail.com, sdf@fomichev.me,
 bobbyeshleman@gmail.com, fw@strlen.de, Neal Cardwell
 <ncardwell@google.com>, Ralf Lici <ralf@mandelbit.com>, Will Deacon
 <will@kernel.org>
Subject: Re: [PATCH net v2 2/3] net: devmem: return EMSGSIZE on type
 mismatch
Message-ID: <20260804143846.6fb87860@kernel.org>
In-Reply-To: <CAHS8izMK_GNTmoUnkNB4iJv-7msx0F+vugg+-dTCcyRxyk3YQA@mail.gmail.com>
References: <20260803171441.408014-1-almasrymina@google.com>
	<20260803171441.408014-2-almasrymina@google.com>
	<20260803125414.500138af@kernel.org>
	<CAHS8izMK_GNTmoUnkNB4iJv-7msx0F+vugg+-dTCcyRxyk3YQA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 4 Aug 2026 08:36:40 -0700 Mina Almasry wrote:
> On Mon, Aug 3, 2026 at 12:54=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Mon,  3 Aug 2026 17:14:40 +0000 Mina Almasry wrote: =20
> > > When a devmem payload mixes with a standard page payload, return
> > > -EMSGSIZE instead of -EFAULT. This enables tcp_sendmsg to seamlessly
> > > fall back to creating a new segment instead of failing the socket sen=
d. =20
> >
> > Sure but AFAIU this was discovered during a ML discussion,
> > so the change is an improvement for net-next rather than a fix.
> > Do you have any reason to believe that real applications hit
> > the error?
>=20
> No, I don't have a reason; I just thought it was a straightforward fix
> you might want to take in net. I can definitely punt this to net-next.
> I'm a bit unsure whether you want this series reposted as v3 without
> this patch, or if you're going to take the other 2 patches. I guess if
> I don't see the rest merged I'll repost. Thanks!

split and repost please
