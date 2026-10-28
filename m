Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793229788;
	b=LEvw6FTubVr+bvEahj1B6MCNs83q+2YZwQHK9X2vH4HH6XYkweghb9AVKBMJcAlLxVhm
	 GeT0N2lXt8EgjEZifT0Rk0OtR5i4j95lhZX611zX5RFWEsLIEr8v2PbWdTPdm9w0PP3su
	 8WtYisRQS6faadajcu680T4K/1GIEc7L9zqTAU4Gfkw05ZLV9nDKpRcQMv2+lZtkAlGIo
	 cJf+caDrpf8gfV9OxNayxSCpKf6HmUQR2ysGpTtV3bzHFUYkpf3JOZ76qQjMsmXstFhRg
	 BC9VJcEsGNWHjkzxSl4dBqi3GqrPif4/K0EZ2jMcChMzkDxT/d+m/wzPXoH5H6FzI1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793229788;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=siS9tKJrzzyUZocyxRqmx7YU4OiiuwHiHfyCYQ99NZI=;
	b=jbSRX65EcdKfhRoUxsiYnh4sxLXhYc5g+/YCkcNbqdyS/IQmi8gtZuksz47jgjcYBjFw
	 Th6IrfhaxKVRkO/yay+VFnVaIbQYYtg5nSN7QvQ3n3svGsPSEKvFUffLzLl7joHR5GGZ4
	 UK7QO+ovg6Yv0wjatJ3/jgGfsWAMmSFZl5SVhfoVGnpkY54YvNMt2q0BUFP9XI+YGDeV6
	 AAj4ydbgCCSfDHMFDuDRvilaJjrjZNtzECJg3s0tdNT1hKavJMJBClqeFBJ/GLoBU1nDQ
	 glMl2dfBmpcXuXgK8yDYBTJc3Ly+yL8mwxke+9dDGHipf+K/Pjp+dVv0jSpMfa567Og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OngGMp1s;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBD0606A31A;
	Wed, 28 Oct 2026 23:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OngGMp1s
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68E031F01825;
	Wed, 28 Oct 2026 23:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793229787;
	bh=siS9tKJrzzyUZocyxRqmx7YU4OiiuwHiHfyCYQ99NZI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=OngGMp1syV4MyuQfzYiRvEL+Z9vkJbHzykEVyJdKqq1L+QaQqUxZsRFDKJvj3bH8f
	 C7BIZBnO15XcJvEa1hQMLyK3uXjVUyvsmzGeWlEWu/GPVwlJ2U133p93Df/CP1qfXw
	 nUyQNEeMJxO5K9nE/wcAK5pNFRpJ0sQuInXp+bLotSVNFnQfdEbZDGsYbLjSBFIXic
	 +ZiMlWhMhy0isOq7HrFIpmawxeS2Q5tkKCvmkomw6RaPtoaDA4KeSM09XfTi0ceOq0
	 67UVv5KY6pLwiVtvbeNR+6lVk7Y5mhAfSQIFkwGvuZiyQjDNHTbjlFBpirxvD4+kOb
	 los8PE9hdRM4g==
Date: Wed, 28 Oct 2026 16:23:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev-bot+sinfo@kernel.org, netdev@vger.kernel.org, Andrew Lunn
 <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] net: dsa: motorcomm: Isolate all ports during
 chip setup
Message-ID: <20261028162306.60befefa@kernel.org>
In-Reply-To: <CAAXyoMPaA3UH=pWaDN0OHKaHDqdFXhnm67GN1b7m295=pqwrTA@mail.gmail.com>
References: <20261026230300.1108190-1-mmyangfl@gmail.com>
	<179305591469.3327.15926756079213213876@kernel.org>
	<CAAXyoMPaA3UH=pWaDN0OHKaHDqdFXhnm67GN1b7m295=pqwrTA@mail.gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 28 Oct 2026 15:58:39 +0800 David Yang wrote:
> On Tue, Oct 27, 2026 at 7:05=E2=80=AFAM <netdev-bot+sinfo@kernel.org> wro=
te:
> > This is an automated message. This series looks like a fix, but its
> > commit messages seem to be missing some information:
> >
> >  - How the issue was discovered, e.g. hit in production, hit during
> >    development, syzbot report, manual code inspection, LLM or static
> >    analysis tool scan.
> >
> >  - Whether the issue was actually triggered, or is only theoretical
> >    (e.g. found by code inspection). If it was triggered please include
> >    the symptoms, like the stack trace or error messages.
> >
> > Please do not repost the series just to address the above. Instead,
> > reply to this email with the missing information, so that reviewers
> > can take it into account. If the series needs another revision for
> > other reasons, please include the information in the commit messages
> > then.
> >
> > The evaluation is done by an LLM so it may be wrong, if you think
> > that is the case please reply and explain. =20
>=20
> HW Tested.

Whether it was tested is the only one of the 3 questions which the bot
did not ask you about. And if it did ask you you should name the
platform.
--=20
pw-bot: cr
