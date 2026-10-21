Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792541717;
	b=DDYf1gSi49DB7vv0MgFOWRBDKMvydtnpQd9exghi81wCJ9KVl1kfMVrdH/1AV++qc0zr
	 2yg/pvs9xnqh17NmL/yrfGQaISAozypCCsl5v6pbQt/ZafK+49pSGadTF53bJYe+SMZG3
	 kMdo8DGJDBmogMa4LJbzWNrcctCnyW8Gkv51Wr/PBkbAhTdFF5i7sEdUbAieUnxWoU4i7
	 mDlvcuRBf8WHcjoTui7uno7+G4dZJOD+zIF0jnV4MK1gM5xOKIAmzoi9L0YsqIPy2foaJ
	 qHXmNODXjU0f7zjl6u3AlLlaZXIvIDOTaqeRnQZRDVcaiHn8DYm1z6tXHqDyJWu0TeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792541717;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=p6ayw1vDth8yxVe4wLunRQiGPZCUrKa+fg0X1po4CMQ=;
	b=IxUVHUpAYeo6HilhDpk8kymmbUrxUsUJEXSIrBBpEXvRVZWtZRXoVpEYMO++wNtL1fps
	 XIZ3nkbqFKAEKbw8mDvG6vC+SJZ3H2uhocu0uxuuNDQJnRg+REXOKHQh4vG/c7CSwr7j5
	 y2mra6uPah4Umtrp03PVBY6HxbQwVFPf18vYIYVfuIIC6A8JKjJFG8DBj9929y0JWiIQP
	 5bQnkgIw7k8B+2PyZf0rzlFC/kRgx99voBRTYHR/NvIYzhhrm767KakyQaB+Nw7wlVGsM
	 hmrU2NXXtJip02PiA9Hqq38sknox87VnzhfONBPf2OdKYv5anYc5YnvxqGmNYrsqgpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="G911/u0x";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81241606A31A;
	Wed, 21 Oct 2026 00:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G911/u0x
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFF111F000CA;
	Wed, 21 Oct 2026 00:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792541717;
	bh=p6ayw1vDth8yxVe4wLunRQiGPZCUrKa+fg0X1po4CMQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=G911/u0xrMactUzVu/rxHddLPB000LJdqdGrGod1W1vUfTRa7HULsLpSPD/iBtESd
	 FE6zM8QZ8xkQpKlVRWzj9+s+JhNlMTN/ihBsTptNg/n/fG9s4YNoUWI2svYxsft5TB
	 /999oaZMxpIF0p6F6dKuAe5QySi/ELKoT+nf9fkL/u8VxjqbBj0sCfX0AEkX+29tki
	 31L3H3TBb/LwRkZQobAZExwnss09hFHj6oaP77GG4v8IX2d5vpkOWnrLKkiGgW7GWq
	 jaOYSPFO213297zYaxCHeNE9/MPVPcKhnFHN8j2Jwx3uSlkvnsQBIqZGsGSiZK1FCH
	 J3VSTqbQ/MEHQ==
Date: Tue, 20 Oct 2026 17:15:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rishikesh Jethwani <rjethwani@everpuredata.com>
Cc: netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Sabrina Dubroca <sd@queasysnail.net>, Eric Dumazet <edumazet@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan
 Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH] tls: keep TX and RX hardware offload on the same device
Message-ID: <20261020171516.055585ec@kernel.org>
In-Reply-To: <CAKaoeS1ZYkdJn7ih=RnPYjfYV9MO3k1Lo43+uKrEuLMMN4U21Q@mail.gmail.com>
References: <20261013202647.2206263-1-rjethwani@purestorage.com>
	<20261020133601.2081ab1f@kernel.org>
	<CAKaoeS2WHQ6QH5XJ+T0RLuxVDJAOtzdfVz0V6gSoZ7n5GJkFdA@mail.gmail.com>
	<20261020151924.41e22eac@kernel.org>
	<CAKaoeS1ZYkdJn7ih=RnPYjfYV9MO3k1Lo43+uKrEuLMMN4U21Q@mail.gmail.com>
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

On Tue, 20 Oct 2026 16:05:06 -0700 Rishikesh Jethwani wrote:
> On Tue, Oct 20, 2026 at 3:19=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Tue, 20 Oct 2026 14:01:23 -0700 Rishikesh Jethwani wrote: =20
> > > On Tue, Oct 20, 2026 at 1:36=E2=80=AFPM Jakub Kicinski <kuba@kernel.o=
rg> wrote: =20
>  [...] =20
>  [...] =20
>  [...] =20
> > >
> > > Thanks, I'll use a ctx_netdev temporary and send v2. =20
> >
> > Is that a name you've seen anywhere else in this file? :/ =20
>=20
> Yes, tls_device_down() already uses ctx_netdev for the same
> rcu_dereference_protected(ctx->netdev, ...) lookup,
> so the name is consistent with existing code.

Ack, thanks
