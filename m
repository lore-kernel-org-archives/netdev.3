Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF419339371;
	Wed, 12 Aug 2026 23:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786578617; cv=none; b=oUCKJDsAeApoWUCQXVyeoqj9fDwoTPs2Nr/BSRXdRsXnLXeByf/tQ6oRzZ+U/U7ZHtIG2t08Gs/OL/IXEOHWLFT1qQCZjKpQY0YGSJHAvqgzWLUpE/ekFYy6fQ4IWp/QMhHp5s7Uk9sji7X/uhJiZ9iYdZk96keZQ0lM2z1rprk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786578617; c=relaxed/simple;
	bh=NZEHT98wnBzl1nLH2oGNdp3GXG4fp3awwkb6WPmUMzM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=thD1mXRkxuR48IzFdCtx7jgTGDfW4hQwdgMCVZIF0ZMoJQrLzN0hj/AOSIwiqQlvF7beZPOux+bRzS+zflBkfZ+VXiJZAwasBjOInPDOuOirJM1kAw83XYcRCCszc01bkZIP9fhXsM87omPxS8/siqqO38MRsWXVNLxzzpOrQj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kq/7aTun; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kq/7aTun"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 273021F000E9;
	Wed, 12 Aug 2026 23:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786578616;
	bh=Qzi2HAi0WNr/zXscfYBuZPWUrITA30dodKVPDEL1sH8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Kq/7aTunIbD1xKg/NWyFJXWDWKrmKd5mwbgZCCDOQTsFsGE44qqemMPIIN4DKx7X6
	 YTVp2k/KGinZgstnGQf/m0pZQxbmj705XT8dfBWeS1qW6Buh90Lm5rYa/sziGpj9BC
	 zRtWfyTR629RXf4tkz0PMBKxXurKPs4/T9ucheeoNp56oBW8F1e5VljngKthGhoW4B
	 Tt0OSx7O1rtkSIJjUp3MOIlbRLEC1UeKqJhNAuDhX1KkIjLgSYkI/AjK4x8tJaDur+
	 xkJPxLPWHTq143Tz1aXhrN05eLiDPQ0Ynv41/kRXmMDYk6ZXXaz7aHPomFNuFa6ySu
	 yOIsGrBMHvmlw==
Date: Wed, 12 Aug 2026 16:50:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Bobby Eshleman
 <bobbyeshleman@meta.com>, Pavel Begunkov <asml.silence@gmail.com>, Ralf
 Lici <ralf@mandelbit.com>, Will Deacon <will@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: Re: [PATCH net-next v2] net: devmem: return EMSGSIZE on type
 mismatch
Message-ID: <20260812165015.502a6ce1@kernel.org>
In-Reply-To: <20260810201213.2708375-1-almasrymina@google.com>
References: <20260810201213.2708375-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Aug 2026 20:11:48 +0000 Mina Almasry wrote:
> When a devmem payload mixes with a standard page payload, return
> -EMSGSIZE instead of -EFAULT. This enables tcp_sendmsg to seamlessly
> fall back to creating a new segment instead of failing the socket send.
> 
> Fixes: bd61848900bff ("net: devmem: Implement TX path")

Please drop the Fixes tag and repost this _after_ the devmem fixes
you're sending are in net-next.
-- 
pw-bot: defer
