Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E622A1FC7
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 01:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771984151; cv=none; b=D7uWyVWue2IahytcZSTYfxtwbT4o44vT/IZGeomIO7OnlUwO4SFGEqAX+zvo1ny7KygO7pKN6IbJyj8tQ4ImYPflOtl4kj7AxHmpFvtIX7l60ie5mT14UWMZfzP+AAVmAkMRFdIwdBZIUeAxesAw7nFJRiP7mRZI+TqSJB3iYCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771984151; c=relaxed/simple;
	bh=BKecuLxxsoO4d9l/uMD9NnqyrqSECOB371UrynbH51I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R7sFLphqlI8JPcnX2mjXhp0EBrL5jcWOXR3O7kQo8S1WIlSbP2eBWhlKvrXG2AR7qzhXBOVIlWr/+sLlXks/Sm3LGV1ALINThHKigL1HEfubYGDRdCMW2hufeI/kxe/LMYqVxYg/iQwIcrOXz/XNatA4454X+LHnn0tfirfjdtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kRtoee47; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kRtoee47"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 599C4C116D0;
	Wed, 25 Feb 2026 01:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771984150;
	bh=BKecuLxxsoO4d9l/uMD9NnqyrqSECOB371UrynbH51I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kRtoee47sTmqDafzcqILZefLz7s7LpQhXktIWPq19X9oM+wTi88e4MBlzRbllX+HS
	 Tsln6t8TXn7mWuz5U91/QJrBserIo1kKNsRa+vUNxeVza8Mk5l7j2NyviBgpQ07Wcb
	 kDaGJ7KW2fQ+Ui67Lyx2bnZG5YbpQWILRgvdhjIkOBTzesdJJZjFiJnvUAaLIOWNAk
	 EgY6pJb9VoivQjwdOK6aBMuMsli/O+AYz92Mp0by2z/OKxXQk/A7KG5mthit+OHMgo
	 Cgi6a+Bz3ddkGCTv6zDKwyHgClbXBlmhkl9MKiXa6LdJyC4QjghScaxB2jEIteYSDd
	 3hlc3CZSor9Ug==
Date: Tue, 24 Feb 2026 17:49:09 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima
 <kuniyu@google.com>, David Ahern <dsahern@kernel.org>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] ipv6: move ip6_dst_hoplimit() to
 net/ipv6/ip6_output.c
Message-ID: <20260224174909.59f52345@kernel.org>
In-Reply-To: <20260223153342.892477-1-edumazet@google.com>
References: <20260223153342.892477-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Feb 2026 15:33:42 +0000 Eric Dumazet wrote:
> Move ip6_dst_hoplimit() to net/ipv6/ip6_output.c so that compiler
> can (auto)inline it from ip6_xmit().
> 
> $ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
> add/remove: 0/0 grow/shrink: 1/0 up/down: 47/0 (47)
> Function                                     old     new   delta
> ip6_xmit                                    1481    1528     +47
> Total: Before=25076476, After=25076523, chg +0.00%

allmodconfig is not happy:

ld.lld: error: undefined symbol: ip6_dst_hoplimit
>>> referenced by xfrm_output.c:348 (/srv/nipa-poller/net-next/wt-0/build_clang/../net/xfrm/xfrm_output.c:348)
>>>               vmlinux.o:(xfrm_outer_mode_output)
-- 
pw-bot: cr
