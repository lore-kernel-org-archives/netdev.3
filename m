Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B2131E855
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 23:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788478362; cv=none; b=R1sGjWuqds1ZPdELQSRW9gaxrVWn/yCJWCmSRgXEBUzrIwLamxzwAl4Lq0W15EhKUFCGkwFezobZ2ySR/a4uUoaEwz6IgQ1B0EAXJB/ZHmvVnhRdDFP4AcRUJRr1XFrLgYtAscYOk7KfDZaQVH62x5jBtAsDI3rsPCPPCsPF9h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788478362; c=relaxed/simple;
	bh=0/d6wgfVZOEkiTkgYwArp/+2AYxqf2Go8wZ0MXle6DM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FbaVw/iP/pzd4oxql+tCnOQXEJXvM8mcnotwxmNzcUArX4L8HjVYLhUs0dKyjQFSfJ8RHmbai/NlgdTFbJwDX1RpaMw4pG8Kfk577xqG2iRToKPaUhbRc+yGAsOcBDI7H3a2Z3zXu+bzuL12OD43eKlHMl1d6I3zeQIjRV1iwUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B5U92y+p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B5U92y+p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66AB01F000E9;
	Thu,  3 Sep 2026 23:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788478360;
	bh=0/d6wgfVZOEkiTkgYwArp/+2AYxqf2Go8wZ0MXle6DM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=B5U92y+pgE/W07rr42JCwzdBUZz0sCrsNtcaosG+44rcMU5/YUbid3dK8QXibioT3
	 Dv33jV3Aq8RY/hZ5Smksww2uPNeQquuB80PI82tJLyhuZmoI84qKmdQHntX7ooanus
	 n0lvtHcUFIwNiN52Uq7CeHyCAk8a8eLrnSVoPLm+IVI4BzX7tmfHzkswg4i9d489EV
	 4IN1LdbAl2BuR0O/w43synKDkqFeUJmBwIjDprpdZi5dAfpadvM5AB08c7P1dBWEvv
	 AICaubQ2najvKRwGKLgcik7/+ddJ+VQWWZArU8U8FQCou1S11x2qMzEzV/aBcxUNjG
	 WEG7FUOfA2XvQ==
Date: Thu, 3 Sep 2026 16:32:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, Bobby Eshleman
 <bobbyeshleman@meta.com>, Daniel Borkmann <daniel@iogearbox.net>, Nikolay
 Aleksandrov <razor@blackwall.org>
Subject: Re: [PATCH net-next v3] netdev: avoid skipping objects on race with
 device disappearance
Message-ID: <20260903163239.0b4a8309@kernel.org>
In-Reply-To: <CANn89iKQN1i1XswLUpvc-gHQLQAz+qqOSB1g-YCKo1UaYDnM3Q@mail.gmail.com>
References: <20260903221154.3359889-1-kuba@kernel.org>
	<CANn89iKQN1i1XswLUpvc-gHQLQAz+qqOSB1g-YCKo1UaYDnM3Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 4 Sep 2026 01:08:11 +0200 Eric Dumazet wrote:
> On Fri, Sep 4, 2026 at 12:11=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> =
wrote:
> > If the currently dumped device disappears while we were mid-dump
> > we will get the next device without resetting the sub-object ID.
> > This is quite unlikely, it was reported by an AI tool not a real
> > user. Let's fix it for better dump consistency.
> >
> > We only intend to cover the case where device A disappears
> > and we skip over sub-objects of device B which was stable (B existed
> > before and after the dump). We don't intend to provide stable
> > results for any device that gets created or deleted during
> > the dump. =20
>=20
> SGTM. Note an ifindex can be reused by a new device, we might need to
> add a dev->dev_cookie
> (64bit unique number) like we have for sockets and netns to also catch
> this in the future.

That would work. IDK if it's worth the LoC, tho. The existing workaround
is to subscribe to NEW/DEL notifications, do the dump, and then "apply"
the notifications. The notifications carry correct state of the objects
which were modified, the dump has to cover only "stable" objects.
At least that's the excuse I'm telling myself :)
