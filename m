Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC183E6396;
	Tue, 14 Apr 2026 15:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776181448; cv=none; b=CoAAV1WZ/K9MbOOyrQu1qS0ctOf31ud2mT+OVo7R0nt7NPjZXEThxbHMM1qulW9AXiBqEF7yVJB6u/GQ21i/zzhXphLJox7j2HU7Q0eO5Gillhkyxl+RXj78bfljEhWqGJWaRJd7aRax/nsb3gCeLSKo8szlxZfcVB0DWTqkwCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776181448; c=relaxed/simple;
	bh=GOEHN8D4mrXLesq3Uxwxg1mrKL7Yav8u1R6lnIlIxfs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WyxeFb0LrcdT6mu8lnwxo8JpE1nREZyoGWAxzbELnxjdHmhuy04ZEpynvAAu+0fme8/THhlCkfQa9VPdQxW9w4mOMERr+dysKYLn5I8lhgpnnsaQjRhVgF8dXD7kaye8F5xxufGcL6+u+JJOup7T+LVdPgKCchDqZTerzbtHMRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lG3NAFvp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lG3NAFvp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A88CC19425;
	Tue, 14 Apr 2026 15:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776181447;
	bh=GOEHN8D4mrXLesq3Uxwxg1mrKL7Yav8u1R6lnIlIxfs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lG3NAFvp4uV/avU7Keluh5lA044kTwGigw0dtOcBFsT/SkWas1n5pMgD1fD3QgWZO
	 T5FgsgvIdFbVWp0Yo3F+gYIuuohxZjGOqjFFKei2sD2aNLTKSk4c31G2OeSnW5PORL
	 I7XuhwVrlaUQSyKMLJpYpOgwytC5MKrODYcI7uDn/PpssWe4JWbhJehzfzrSEvgyiX
	 dapobBBO1yB9Y882/R+KSYYP22kgMIQZCoDy+8i2QrI9r5Gu/m+FS51PjTwlfPTgEL
	 KWDxEEAmcej3DOx46/LCH6VE1sD/qtGm18rOlxnepUioDWDCLiSeYCKhX4JnWUImDu
	 swVJJKmHkEFVw==
Date: Tue, 14 Apr 2026 08:44:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Shardul Bankar <shardul.b@mpiricsoftware.com>, kuniyu@google.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, janak@mpiric.us,
 kalpan.jani@mpiricsoftware.com, shardulsb08@gmail.com,
 syzbot+f2fbf7478a35a94c8b7c@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] wireguard: device: use exit_rtnl callback instead of
 manual rtnl_lock in pre_exit
Message-ID: <20260414084406.779336af@kernel.org>
In-Reply-To: <CAHmME9rwKae5b9PYzuqmwG3p05iZ=jqyp6LQefg0OsB3OP6oWg@mail.gmail.com>
References: <20260413151232.1004611-1-shardul.b@mpiricsoftware.com>
	<CAHmME9oXoXykXq_emkA3v8nG2VR28CmRP2+WmhrvGJc0ZbPfpA@mail.gmail.com>
	<20260414081824.0edf6113@kernel.org>
	<CAHmME9rwKae5b9PYzuqmwG3p05iZ=jqyp6LQefg0OsB3OP6oWg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 14 Apr 2026 17:40:03 +0200 Jason A. Donenfeld wrote:
> On Tue, Apr 14, 2026 at 5:18=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Tue, 14 Apr 2026 15:28:37 +0200 Jason A. Donenfeld wrote: =20
> > > Thanks. Applied to the wireguard tree, and also added the missing
> > > __net_exit and __read_mostly annotations in the process. =20
> >
> > Hi Jason, while we have you - do you have a PR for us for wireguard?
> > We're going to be sending the net-next PR later today.. =20
>=20
> Sent!

Thanks!=20
(I'll apply in a couple of hours once the CI had its way with it.)
