Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BF72C21EB;
	Wed,  4 Feb 2026 03:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770177256; cv=none; b=Bg7P1/5vjUmZLvGNubhNJD/5wWAIh4kqKPGSkqUMwQl5mUapTk0uNWHkEnZ3oeg6ALHFqO8BXuc7PPEuE2zAE6AvUeA5fwKZ9o7qRinKHrq7YhijQxCKXRvdpsAELeG3rRaUhjmHw0p9bWywER3nlEFBUJKIt9zwr6xnszyJPPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770177256; c=relaxed/simple;
	bh=JfvJdjP9ALmgcB1djDN/2/mYdI+tzqZNeVhi2LeRlHw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BjLvzfGbki6u8L8VGBy5kAs5q3E/tlnV6VRJUZueaEE1x1AHidG0kFLNY0gbpYTzPgWY6B32cWjVQYKPY9wv4J9Nh9z4lcN7hzupz8dFhP11ezVtexZnTXpKoSqCe8RTPLQ5ZOQqeLrI8rwXBnwoBeincaUP0C1P/cdAiNZgxK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZTkfiW5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZTkfiW5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0A9CC4CEF7;
	Wed,  4 Feb 2026 03:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770177256;
	bh=JfvJdjP9ALmgcB1djDN/2/mYdI+tzqZNeVhi2LeRlHw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fZTkfiW58FlkqFEOqSbmwvwwWXD/wA4jUHjwDrAbWJ7RluBt17EtgOYv1BkXGGlOZ
	 qqtOmM94fWeY6QbEvEcsKq6ZCqnPYCkqhZzLsVquCTJCUyYO4enH5J8S/GKUJQlWIl
	 jfD562jhkVXBpSqjqZ/XcCG0GFI7/Qh33LSH3LdKJZdc80/QWNWs9zNUo+eJ3UHFLO
	 W75zBwhSL0hCzXueJkOQ8tqJW/H8o8XUVn8t4dGfcG8aqGnGGf+Ylt/NiaV0g9lyTi
	 lfqjfRASRfSswCDYjDX3Ek95t/MJl11uAjJUer5JJ1jK+kLE9pM8H3Ld9CFXxrlwmH
	 T95yBU0V1l8eA==
Date: Tue, 3 Feb 2026 19:54:15 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, Simon Horman
 <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Oleksij Rempel <o.rempel@pengutronix.de>, Eric Biggers
 <ebiggers@google.com>, "Russell King (Oracle)"
 <rmk+kernel@armlinux.org.uk>, Peter Korsgaard <peter@korsgaard.com>
Subject: Re: [PATCH net-next v3] net: usb: sr9700: remove code to drive
 nonexistent multicast filter
Message-ID: <20260203195415.7e462c91@kernel.org>
In-Reply-To: <CADkSEUgoOyeUqGHXqimczdo1M0S6C20GOpKH5OuEeaRhFnSTDA@mail.gmail.com>
References: <20260203013924.28582-1-enelsonmoore@gmail.com>
	<20260203194317.07432b29@kernel.org>
	<20260203194447.0ce4ffd7@kernel.org>
	<CADkSEUgoOyeUqGHXqimczdo1M0S6C20GOpKH5OuEeaRhFnSTDA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 3 Feb 2026 19:46:32 -0800 Ethan Nelson-Moore wrote:
> On Tue, Feb 3, 2026 at 7:44=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
> > On Tue, 3 Feb 2026 19:43:17 -0800 Jakub Kicinski wrote: =20
> > > Not sure these annotation on the get are useful =20
> >
> > * annotations on the review tags
> >
> > synapses misfiring over here. =20
>=20
> I will start moving them to the changelog in the future.
> Do you want me to send a new version with them removed, or are you
> going to do that when you add your tag? Either is fine with me.

It's not a big deal, applied thanks!
