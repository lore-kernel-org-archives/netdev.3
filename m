Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB18A17DFFA;
	Fri, 11 Sep 2026 02:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789094133; cv=none; b=sjrnmBTgyf6oOw7JoUxZNZeWPtJSl0uujfKURNKmzX6D5/qUsMKKYLu5hLWz6wKKdUK47nc222OQhbZDbg+ppLO/cy2mWgwx/+7kHr1192g/XUhMyZobku6iEDKA+kVVUp3EJbvt6bX/8C66qB2owJJAWmYui3wUOH2YYVmQVKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789094133; c=relaxed/simple;
	bh=B3yYD2AFKjeUBr0w4mQ3ApAOBVYI811KTlK02ZBcS6s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GzGf2CYMouGF6w5QWiWkElxjHUqdHLsko/LJzP5mUq1ATv6u7myuNdFHMAPOksFC9KuFVk2jS9wYONSiAoK7o3pF0qlplrWG3yUPeFC3zPlNLgcuNtaF/5zGL9YF5/iHf/Xu3iOJq+TZE7yiLj7jd+HudMEDPkBypo/AMXld/rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NHljDe0j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NHljDe0j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F1871F000FF;
	Fri, 11 Sep 2026 02:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789094132;
	bh=B3yYD2AFKjeUBr0w4mQ3ApAOBVYI811KTlK02ZBcS6s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NHljDe0jB9NFNAPH0KiT+7Ser4OK5rfeQsbkAWUSe5MqLi7Ka1dzf0pTTyXmnEoEc
	 lfxFcS1t0sCSZz48k72mq2AUoSp1edGhV7PVXfJFMtSmd0MkgeDBXUmxZYThvbzqN/
	 LvJkqOe6UOYJRdXGSxJ1MhgCWbtVmRIkgT+UHgFlsdsoJRmMitmf0Zh+cnSF6KhZW5
	 XoFBXJJqLaFT46CpXfQiO7lKt44qAKcsCxWdTjIFxP7pq7ay+dRvRm7E52sQqu1nWY
	 vWLSCmU03GrEJfSaM66ADUYnrosvcp3wLSekJVhhasq7SMFyTWCH7aXRUjIz1J3/UO
	 fsjONrMFPiK0g==
Date: Thu, 10 Sep 2026 19:35:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?QXNiasO4cm4=?= Sloth =?UTF-8?B?VMO4bm5lc2Vu?=
 <ast@fiberby.net>
Cc: netdev@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>,
 Danielle Ratson <danieller@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Greg Thelen
 <gthelen@google.com>, Ilya Maximets <i.maximets@ovn.org>, "Matthieu Baerts
 (Netdev Foundation)" <matttbe@kernel.org>, "Maxime Chevallier (Netdev
 Foundation)" <maxime.chevallier@bootlin.com>, Paolo Abeni
 <pabeni@redhat.com>, "Remy D. Farley" <one-d-wide@protonmail.com>, Simon
 Horman <horms@kernel.org>, Stanislav Fomichev <sdf.kernel@gmail.com>, Heng
 Guo <heng.guo@windriver.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next 2/8] netlink: specs: conntrack: add
 uapi-header
Message-ID: <20260910193531.3c327c4e@kernel.org>
In-Reply-To: <20260910221733.1021864-3-ast@fiberby.net>
References: <20260910221733.1021864-1-ast@fiberby.net>
	<20260910221733.1021864-3-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 10 Sep 2026 22:17:22 +0000 Asbj=C3=B8rn Sloth T=C3=B8nnesen wrote:
> Define uAPI header, as needed for C code gen.

You mean your own code gen? We don't support real codegen on conntrack

tools/net/ynl/generated/Makefile:27:GENS_UNSUP=3Dconntrack nftables

