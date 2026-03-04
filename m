Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3C5231A21
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 02:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772591071; cv=none; b=Zz0/uxrDpfCdvW0Xn6VmCyVaQSmUnoWnEyo0c6kSYeyB2afgVnVLNW09DR5NJdYvGGETINvsesPqy4bxeaO0Q0XmJVxlh8uB0a6HRpQBwCTb2ALRf0pqRslnrJLvH6LoE2PtjJo2/DyyZXdh4by/fVraUoaGa0ivHBdg1yMDwEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772591071; c=relaxed/simple;
	bh=ZeeW69wkixY7DJrZ1C17sb88zbZ7AUfO2C8xO7Dnaq8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rpFAYCm9I/AP3sPTmqziUhK6+aLh6WBl/9AFhqo/zevb5gtBO0EyGb9XyocTHjfTTldaO6VhvcrsBLWRs5bR9/rzHNXU2wvIMciVLSmTWQ3vSbbzORXqBspOT5EAGjweXFwDvNucNzS2yI6PZ5rqyEPoZOgivxNEtSGiFyzAvVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RkcZzY8+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RkcZzY8+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27B36C116C6;
	Wed,  4 Mar 2026 02:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772591070;
	bh=ZeeW69wkixY7DJrZ1C17sb88zbZ7AUfO2C8xO7Dnaq8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RkcZzY8+/MA7NnIrhVConfQq8gTFDCk66xlo2h7wKL3K3ndZyzDyJP0KZ3LL6lEgC
	 3ZhvbqV2cFAk8PUJXrwUCzxocl759MGA8gaFRqx0FPIzlkb6QSieJjcY7Aabq/vJoV
	 BSYMYgsDBQ+9doUvDkAmUNaUqNbq8bt8GOg+5j+dXEL0NwX1R3UAx9pXpT16JVdX6t
	 MA+BnNSdJU9Zt9ivEG+EpHOv/AkDtna+AtS9vKP56Fr46lC64DeZMN/1tAibOJVDSB
	 914NsChthU4VspcJwm6OLuEL+r8PJZXV3D93Xlq3bpyu0yEd5Jc5rMSjAJ5T8WYJbm
	 b4lm2B9RhfA2A==
Date: Tue, 3 Mar 2026 18:24:29 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima
 <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, Ido
 Schimmel <idosch@nvidia.com>
Subject: Re: [PATCH net-next] ipv6: add IPV6_CALL() helper
Message-ID: <20260303182429.49645ce8@kernel.org>
In-Reply-To: <CANn89iKBDxAqT4MGGuQ8xxXjbNRo7HadXoYYq5QpyP0S_4rfTA@mail.gmail.com>
References: <20260302154201.1621117-1-edumazet@google.com>
	<20260303170841.218b0816@kernel.org>
	<CANn89iKBDxAqT4MGGuQ8xxXjbNRo7HadXoYYq5QpyP0S_4rfTA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 4 Mar 2026 03:13:40 +0100 Eric Dumazet wrote:
> On Wed, Mar 4, 2026 at 2:08=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
> >
> > On Mon,  2 Mar 2026 15:42:01 +0000 Eric Dumazet wrote: =20
> > > ipv6_stub use is racy, we should add READ_ONCE() and WRITE_ONCE(),
> > > even if this pointer can only change once.
> > >
> > > Add IPV6_CALL() macro to factorize the READ_ONCE(), and perform
> > > direct calls when CONFIG_IPV6=3Dy. =20
> >
> > Does not apply to net-next.
> > It sounds like we're going to remove IPV6=3Dm, however, perhaps transfo=
rm
> > this patch into that removal? =20
>=20
> This seems orthogonal, unless the plan is to force IPV6=3Dy ?

I thought if we remove IPV6=3Dm we would delete ipv6_stub completely?
