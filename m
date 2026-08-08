Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4372D7BF
	for <netdev@vger.kernel.org>; Sat,  8 Aug 2026 20:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786219423; cv=none; b=Cu20+rh0tlNc6Te0/+l4X20gKWlV5FXMtPSAvXIccBS5YHREqdA9wg1NukXJTBycAZ5vS+ds3AJTzvePCTXp7WpKr0aI7fKyjY+yb+1DnZ47Eu0jPMIY9rBi14tIQFvV5nsP0OG1z+RVl/2e71fkaAch9Pw9v+yza/yH8FMLxD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786219423; c=relaxed/simple;
	bh=9i8/x2oXoRbWlGcBX11tDG4yVHRHAV+DObuNhU/K3Xs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mbwb2aN9gTEOlvC8lDgAIzmjtIijSPK9+jkzYiBQ1wxeqATTC+qIkB1IqxbHYaJuWHyfqwhqu6p1ArhJj7zJfvmiL7ozECvin4iG7xZ5FxNcw2Z3FTweiQ1TF+nCkFJAl3BUGtgKN2eFKytpDCfRzdfKTQKrvqfD1jPnD5+7Ycc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o1UHqmch; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o1UHqmch"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAE811F000E9;
	Sat,  8 Aug 2026 20:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786219422;
	bh=t3rHSvBgIuLaznGhqwPBKdpJW/Jp66/f+Qh/bDh+sJQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=o1UHqmchQrIpxVsBcwiyXvGTzQD9xO87wPXPgvwqW+0/3Fvjt5t9DDUuixXVKOwqY
	 zd6mppuFiNi5bzNWtG2MACjMZzArNq7Y+xqulonOrn8uqNxrfebtbNPHHxjVFMlFkW
	 zFd8iQsD1/Oj0OkZtnNYBHV+sq5vj162bS3+QQ65Bg4oI8xz5KnjNVKbyYTnpNfR8w
	 I2mLd1Sm1QSqd0EOUT3/bg025HI9xCyZLDynkxEdF9luU2LBby3ryJqEwlc68rkgcS
	 2/8w1J1p5o6ok9syS0o+Qr3frsqA5YJUhb5kKyaYYPH+xH12qN3g0WUWK5fisg7O/Q
	 hZofjeF8doriw==
Date: Sat, 8 Aug 2026 13:03:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, Ido Schimmel
 <idosch@nvidia.com>, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima
 <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v2 net-next 00/13] neighbour: Namespacify arp_tbl and
 nd_tbl.
Message-ID: <20260808130341.03d18272@kernel.org>
In-Reply-To: <20260807232932.3986667-1-kuniyu@google.com>
References: <20260807232932.3986667-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri,  7 Aug 2026 23:28:38 +0000 Kuniyuki Iwashima wrote:
> The neighbour subsystem is almost ready to drop RTNL.

CI says =F0=9F=AA=B2=EF=B8=8F:
https://netdev.bots.linux.dev/contest.html?pw-n=3D0&branch=3Dnet-next-2026-=
08-08--03-00&pw-n=3D0&pass=3D0
