Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030AB331A56;
	Tue, 18 Aug 2026 15:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787066029; cv=none; b=KTQdYORaAdL8nv/IfGoE7UcNZ2essg+KrvnYEsK1Voe8/hBavALxjo4QAbAifQS/BasqlAucgOROPL1fqJftrp6wMW5c72Y4Okaj6pLastW01qUdBPutIpbHgUQuIAps1j7l60lgAQjZ0/KnNI3Z0URAw2sgDAL38elWuueWAFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787066029; c=relaxed/simple;
	bh=jKlAHGIyW1XdEBNc87mOjTF/CATWDxpt9ldjR+KIfeg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bw9+T19uOdxinBAvUeTYPXjoJAMaENNtDZ/KbW0MC+UrYtinLNZS1yfZ6N6vhtkyVYXPSfeiVUm4JJeDI90byyUxSvdn/bWn1Z4Pn7dPwHSjGzgv6F7sB1J+QXnOTso7YbXZ3toZY1oYkyGrR++NS9dBgQ+lTxGEjuEESbcdLPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CkCfsRv8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CkCfsRv8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ACF51F00A3D;
	Tue, 18 Aug 2026 15:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787066027;
	bh=vtz5ohmkgx1ZhqgNUkiQeH2Xmb5qLJN/8P7aP6EiZU4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=CkCfsRv8xFr6NKNGhYqI4u0vlK5cbB9siaOYUmlDGK1mCf4nZjia1Eh5Dw0Uh0JGB
	 r/D/mbR8xZG5zKgUaQKaQ8lyfjwi8cbD2SZvkAUKT7GOBIW/yHHYwae+auhQNCHyHL
	 ZgdPJsczLIdl5obd/lWz6SecgK9Jo4uCB9d94EFB82MUeunTd4OWnkrSu3w391XM2F
	 X0vLOL1+IpzorwVyFyAuwTqJk658+5jXgQL+yZbRhTGFnUGJ5iw8pCL8EFsb+L4fhL
	 SJbx7biVNLcpkmz5LV6n6AFEKJXwrQTMJ2g/VyQdLx4SO4gZG4UPcgMbWnKyL4YoZX
	 6NxYex8HAr4QA==
Date: Tue, 18 Aug 2026 08:13:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ziran Zhang <zhangcoder@yeah.net>
Cc: Eric Dumazet <edumazet@google.com>, Neal Cardwell
 <ncardwell@google.com>, "David S . Miller" <davem@davemloft.net>, Paolo
 Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuniyu@google.com>, Simon
 Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next] tcp: fix mdev comment in tcp_rtt_estimator()
Message-ID: <20260818081346.03773154@kernel.org>
In-Reply-To: <20260818085153.18509-1-zhangcoder@yeah.net>
References: <20260818085153.18509-1-zhangcoder@yeah.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Aug 2026 16:51:53 +0800 Ziran Zhang wrote:
> The old comment "mdev = 3/4 mdev + 1/4 new" only describes the
> common case. However, when RTT drops sharply, the code applies
> a finer gain of 1/32 instead of 1/4, resulting in:
> mdev = 31/32 mdev + 1/32 * new.
> 
> Express both cases with a unified formula using variable
> gain g.

## Form letter - net-next-closed

The merge window for v7.3 has started, and therefore net-next is closed
for new drivers, features, code refactoring and optimizations.
We will only consider applying net-next patches which were posted
before the announcement:

https://lore.kernel.org/20260816155953.072d73da@kernel.org

Fixes are obviously welcome at any time. net-next patches may be sent
for review and discussion only with an RFC tag.

Please repost when net-next reopens.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer
pv-bot: closed

