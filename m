Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6181D555
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 00:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780013654; cv=none; b=thBjgCdQnj8fLlbmXWGVEEOXoewDOZNgNmq26iicWUKnWskAsUuapgEncHS9Ri6YxwfilyDMkV68tH7rTYVWCHTCpelhQc7t7fxcZbBly3RdiUW94L0p7R/6P4ejPp4A1G5yeFvRoZRZVvAJDYbEP4Wl/zXnQ+vmua8yB1gUe6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780013654; c=relaxed/simple;
	bh=DD+rNaGKkxFg/NAxlW0Crae/hjZux4n54f1PywCssCM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RYFjuTzTSLxamtDA/pngH7PVbfG9XU7KvjM+a1oxzMYBtAK/HDun2eEkDDGe7jJ50Ezzt0oh2xHHyeO8U0AidSAEVj+EMzob5BdkQbR5LfRmZwPeUbNFDhLKJ/YsxlLZGN9l3bWs0orMQNj45LlJ2HqdIePimb2HznMdUTmAOvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQF0kBZ6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQF0kBZ6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 137561F000E9;
	Fri, 29 May 2026 00:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780013653;
	bh=PZ80I4Q04V8uGwV2eqQomYAEzm5pmWHhpixyf6rW9JI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hQF0kBZ69s7CGcYpW8lZmNXXFoZ3kF6tBjGdGfBG74j1QpNh8VEsdvH17RQqKjnj0
	 aVGWopYfLG12cukp3Am1w475DutCx7etmP+4dlK1MH3/U25itBofX3gq5zzK76Xwpr
	 y+tHrCZUdh75q4TR7szGtOzVrkEMY8EWsI4TXu61oB1BMZuaP11Its48e3dEGw5oSN
	 5kZYzU31cpjqLCDOKJLYRmtvvdK12myX89zpCMucPIb0TjDcPgRVx402mcQ9jE92e0
	 JZ9te3VyEW55/XkhSUKvuOBrSvycmBj+BnTbnIzeAqtj7m/dLqb+vWmR9khQGyaK1g
	 9RQawecTXPyVQ==
Date: Thu, 28 May 2026 17:14:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann
 <sven@narfation.org>
Subject: Re: [PATCH net-next 01/15] batman-adv: drop batman-adv specific
 version
Message-ID: <20260528171412.7a60e8f7@kernel.org>
In-Reply-To: <20260528142924.329658-2-sw@simonwunderlich.de>
References: <20260528142924.329658-1-sw@simonwunderlich.de>
	<20260528142924.329658-2-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 May 2026 16:29:10 +0200 Simon Wunderlich wrote:
> +#define BATADV_SOURCE_VERSION "linux-" UTS_RELEASE

What purpose that does "linux-" prefix serve?
The unwritten rule is that the OOT drivers have to append something 
to their version to distinguish themselves. In-tree version is just
the pure kernel version.

To be clear, definitely a move in the right direction. I hope we can
move _all the way_ in the right direction, tho, without still defining
OOT-feeling version.h file with a dedicated BATADV_SOURCE_VERSION
