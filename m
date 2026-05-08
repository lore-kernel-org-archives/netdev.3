Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7D8256C6C
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 23:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778282309; cv=none; b=WZNuON/PSwrc8HADfFQNvel+vP/k08Hx/bqagBW3wE/CJ2aUrZdFoSei9oMw1hnWVtteU5QJvW9jSN9Ns5uLXboFFvzlbSZQbkNKBKcfhhnr1cYN1RRbFoA5/6bEywDM8+UtiH51TbUtz+7l55ShPmMrLsUSjzoaLsFURVBkIXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778282309; c=relaxed/simple;
	bh=xpnX+qAbaGUlVLFiael2rU4Vzg73cKqaeZn4VAKNnRU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N85HOSF7RjZayc9QID5Y+3SrhHKiHstytSyRpx/MUhm0c/CFVvVo+OqShLGNQtlqxaVIJlryUB6SUjFHMzAx7ghSUUIUk1etNPCpSTwqmypApj2jXKVar6Ncp6MdpDFazJtj4eO/9cyrErwInO2Y09si8eiRRSijYuFkI38VyTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JkwqRXKs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JkwqRXKs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31C95C2BCB0;
	Fri,  8 May 2026 23:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778282308;
	bh=xpnX+qAbaGUlVLFiael2rU4Vzg73cKqaeZn4VAKNnRU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JkwqRXKsMOZOtwTtOknWzpeiHI+zHlMy2XA6SXGWy7y/lE+asDfMgl5fVNeqr7KzS
	 JVQAPC7DLwgT75fAzzhFK7z1i0YBjrnqpfUYfwI/V6WHQhtjGCO4OsqRyccAuHeHhw
	 SbvwBAhTeQRJTOHLk1OBR1bpdw6siOe1AMOBxsEFymtv9byuBOaBNiLMonGS46VkYc
	 RKe+uw2dfx2XH9QiQLLp4B+be6K7Gt1J/vFGcQSHKVkcijKJYo9FDtgE4E+Skr0bwh
	 q56TOR8rj/Nxrrw2dGM3nUeYTTD5/wo6T9y1yy73o9SPYi8o+OF5BOO6rfBPTicojM
	 AuGLr9dyRnaEA==
Date: Fri, 8 May 2026 16:18:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, David Ahern
 <dsahern@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net] rtnetlink: add RTEXT_FILTER_TERSE_DUMP support
Message-ID: <20260508161827.15b114eb@kernel.org>
In-Reply-To: <20260507174547.4125412-1-edumazet@google.com>
References: <20260507174547.4125412-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  7 May 2026 17:45:47 +0000 Eric Dumazet wrote:
> We can later avoid using RTNL when RTEXT_FILTER_TERSE_DUMP
> is requested, as none of these attributes need RTNL.

Since this is uAPI I think we need a better name?
TERSE_DUMP doesn't explain much, my first thought was that you'll just
trim some ancient attributes to make things smaller. Sounds like you
want it to be lockless. Also GET will effectively support this bit
too so _DUMP is a lie.

Maybe RTEXT_FILTER_LOCKLESS or RTEXT_FILTER_NAME_ONLY ?
