Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB6B2FD1DB
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 21:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769807894; cv=none; b=bXnBm0u9mnXEY1SxQ+UZA2HWcKYbk2HA2eyg4YhC2o9bryziARYnIV+mqZKERra5Tf4kbESYEckHGqwqzTZCI4gnJGMbEkdRrfXEvvyONAYNa9P4c1I+ErT8voqQB3quli8WhoWppJcnz8zdn0PKcpn0myb0CQgrIyqWZV+5oSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769807894; c=relaxed/simple;
	bh=DgrvjnyfUMpSXvD/2ByAeUOV+FMqs8NdKG2apYE+1S8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M4pV8x9IvPhpj1CfEXfQJUXqVgyRjRFtEjiD+drc1RE6bTJPn6ikaSURY2bB9tfdmvWeOvsTj7pd/DfbbtD1xIDOy1Z11T0t8oNhLDci0xb6hu8fa2LHHqdPjhya7c6r6Zep//4HIujDbyHnIxCpI7P7/37EuUej9egzTtVEKQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ew32APdh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ew32APdh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9566FC4CEF7;
	Fri, 30 Jan 2026 21:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769807893;
	bh=DgrvjnyfUMpSXvD/2ByAeUOV+FMqs8NdKG2apYE+1S8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ew32APdhkKh2XbmZfyXxhmRcjywysK0nlB4fIQuv6tA1Qp+K80sexdNFR0vQnQmvF
	 +Xq9IkET0IpDxP12HX5pIFRsycR/CcivEbTMBWnid2DiHYsXsbAG0/snBZ8j4BpLiq
	 KZwIGn3d47JASivLIdFr8z1puzud3UimdR86UoDOoNe5HJQm81nJoXECdyJz3JHQ7t
	 hM2RncYYD4m9SZxqJ7i/GbjJmsYRl9qFyHFv63Iuc9qwhtOQvgEDqOttvazqaCcY8E
	 0swEgq8u04gYC0AlH49vacxxJ3jBRFTxCOzY7Ak3e9iWxbd80g+hkMOJMxZ+PO5SNm
	 qpkFYw6z8Fiag==
Date: Fri, 30 Jan 2026 13:18:12 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org
Subject: Re: [Patch net v8 0/9] netem: Fix skb duplication logic and prevent
 infinite loops
Message-ID: <20260130131812.7f9b1eef@kernel.org>
In-Reply-To: <aX0aVgCBTGpGYaJV@pop-os.localdomain>
References: <20260118061515.930322-1-xiyou.wangcong@gmail.com>
	<CAM0EoMn=bx-AMR0RbFmSj8MjWTxLtB_xo5419AW18paZ9r1wDQ@mail.gmail.com>
	<20260127091556.052604cd@kernel.org>
	<aX0aVgCBTGpGYaJV@pop-os.localdomain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 30 Jan 2026 12:53:42 -0800 Cong Wang wrote:
> On Tue, Jan 27, 2026 at 09:15:56AM -0800, Jakub Kicinski wrote:
> > On Sun, 18 Jan 2026 10:07:37 -0500 Jamal Hadi Salim wrote: =20
> > > On Sun, Jan 18, 2026 at 1:16=E2=80=AFAM Cong Wang <xiyou.wangcong@gma=
il.com> wrote: =20
> > We (the netdev maintainers) had a chat off list and concluded that it'd
> > be great if we (the two of you and one maintainer) met over VC. Either
> > technical solution is fine, but we want to make sure there's no ongoing
> > animosity. No agenda for the meeting, just want to make sure you can
> > have a friendly chat. We can talk about the weather, AI code reviews or
> > everyone's favorite animals. At the end of the meeting we can either
> > decide or flip a coin. =20
>=20
> I offered people involved here for a video chat, *check note*, in
>=20
> 26 Nov 2025:
> https://lore.kernel.org/netdev/aSe%2FIfNSZBTTAfTA@pop-os.localdomain/
> 8 Jul 2025:
> https://lore.kernel.org/netdev/aG2OUoDD2m5MqdSz@pop-os.localdomain/
>=20
> No one responded, obviously.

So you should be happy that the call will finally happen, right?

> Jakub, please let me know how to talk to people who kept rejecting to
> talk. It is just logically impossible to me, and I have tried my best.
>=20
> I wish you best luck for doing so.

I sent you a link for scheduling the call off list.

Which part of this process of scheduling a call would you like=20
me to explain further?
