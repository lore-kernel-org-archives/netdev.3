Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7863BFE21;
	Tue, 28 Apr 2026 02:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777345149; cv=none; b=ufx7Jcfyq3otdM4OBjJzK9Xn95nkjYy0U6zDwArsEUVap0Hj1GyzbuMCuGRk9kmoQPwhLxTQMSSmbpFD964Fi8rsUi+h9sUUVzIeVGS5N4Qg4PHfWYD84UEFK6g/dexOnQ1iLlMHTs0qq7dT2KOvXJDvQMLBu9BoEfvP5a5nry0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777345149; c=relaxed/simple;
	bh=vK2AtjGksWl/OYrLSVrYlyi0HA7ynU+N7XwEgJijOas=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uF1qFN9YLpA6foA/IA30pq2GuujtYq/ireq/1xT+AJJ7jWCdSBBtYhCfSscQ8vmU8jQs71k7liIodye9v8iZLqBULax+jEa8AcFSEwb3i3sEIsJ2TelVP+MfhKeKugGggOp7E3wNyGDMzoqxZGQ6ybzyXLgGKlbBfeJJBd2xNE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gjh5BZzH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gjh5BZzH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63ABEC19425;
	Tue, 28 Apr 2026 02:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777345148;
	bh=vK2AtjGksWl/OYrLSVrYlyi0HA7ynU+N7XwEgJijOas=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gjh5BZzHH8ONcSMMrID3PahKJqztEgoa/keXyZZMauIMprX+bUbGUXhb1yYoXFQjx
	 NeUj1XIwsKrHKtcg/cDZmrcQ3snP93eQ4eMlCrjyXz4C/T6UrPrjxawXPz2PB+nybY
	 9iw5Q7IjRH3iNmx8UpS+GpTLCIzU7KJZO9OPwIkfm8EQIh0nBtxQgUxYcue0uJIyHC
	 MoAkmaRMEkZ26wD41RhQzjT6X/GBjytY+u/WNUHq2K1YikMAu9hP9vaQWu5PVdZpt+
	 pbfo7ahYvwcVJf6hLGM9urlVOGdvsNeZEiUHVcJ/F9kAc7LhKPCBKN+AzwUESclhxU
	 vk4KpNLvKOjXw==
Date: Mon, 27 Apr 2026 19:59:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, Yibo Dong
 <dong100@mucse.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, MD Danish
 Anwar <danishanwar@ti.com>
Subject: Re: [PATCH] net: ethernet: rnpgbe: mark nonfunctional incomplete
 driver as BROKEN
Message-ID: <20260427195907.681544b6@kernel.org>
In-Reply-To: <CADkSEUjrFBLFQEHBaKaGe3SxdT95GFQ8hCbgNaF7ZgVVB6txLg@mail.gmail.com>
References: <20260425041816.19070-1-enelsonmoore@gmail.com>
	<20260427165959.3a294f1a@kernel.org>
	<CADkSEUjrFBLFQEHBaKaGe3SxdT95GFQ8hCbgNaF7ZgVVB6txLg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 27 Apr 2026 18:09:24 -0700 Ethan Nelson-Moore wrote:
> On Mon, Apr 27, 2026 at 5:00=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> > We can keep the vendor as is, this doesn't enable any code compilation =
=20
>=20
> I disabled it because otherwise an option for Mucse devices which
> cannot be opened appears in menuconfig, which is confusing.

it's fine
