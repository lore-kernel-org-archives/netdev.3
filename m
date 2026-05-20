Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF0A346E7D;
	Wed, 20 May 2026 23:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779321552; cv=none; b=jJ25MuN1LgiRQ7nhbk1FhIg4muud5+PP9RoOIP0MAZmV9tLlHmzSX2OEk9HkPQcNrexngFfZPc684UnizIYszvttifF7ay66NSLiVfZTEDJU1kBTb+VzSvZQJEWt4XD8vJNQPchQbRKoNNdS3tk3a/IwfQGtSuuwhdhONBk3hdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779321552; c=relaxed/simple;
	bh=tZ4w/Cf7aX6DFaeTnL15SpHjEU7OjP0mVO6Y7AWLweU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bvSEuyYqb78Z8qquxwYw+zyDJ5aHB0OoSXLvoSh8G2+UK3s6gArkbJdFWJjR+ejIiemTd2g4OXChthEeKCirPSRiLHJmtJELd+OPvkxfLfZxVobCUvDeb54FA+8mXwmmeyFjdjjUeAVeNN7l7BtufzCtmAdJ951JMXtQGXEIZcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EQ2ca/Wg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EQ2ca/Wg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A83D1F000E9;
	Wed, 20 May 2026 23:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779321551;
	bh=GgSk2xjle+o5w0hl20ShFxqteYe0X3Jm9DBMWwVDBPY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=EQ2ca/WgDtNTIxm25zbtHihu1q4/MDFKUVpv/hLnZ7Kx7hLLIVyutiSJ+oZs7Typp
	 dgIb5CPziVMJlzYr/uwWzuJ/IPWgMbTSSfJv77pKrPNJQF7By440LE4gpbJ0VE9QEj
	 Kk74mweKiI3B2TH0vIMytPIcu7tO8Z3Shmk93aHbOhYQVxJ4FvkSvk3nydxkSDqJwj
	 3dGvwAMxSTClo4H06Zw2Al1DycZsww6jg3m2VwiM+/z0CidL2uLNrhvTm7jlx1zG/b
	 43UHK65hBLc7z923Lb6JPOtu5DwHAD68tTiKv86KJQ/9Oi1szccvpkG8A2Qe0c9P3J
	 WWRoBckAVd1Xg==
Date: Wed, 20 May 2026 16:59:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Chris Snook <chris.snook@gmail.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH net-next] net: ag71xx: Unmap TX DMA buffers on
 completion
Message-ID: <20260520165909.0ac7bf4a@kernel.org>
In-Reply-To: <20260517214302.1450433-1-rosenp@gmail.com>
References: <20260517214302.1450433-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 17 May 2026 14:43:02 -0700 Rosen Penev wrote:
> Store the DMA address used for each transmitted skb and unmap it when
> the skb is completed or cleaned from the TX ring.
> 
> This keeps the streaming DMA mapping lifetime paired with the skb
> lifetime on both normal completion and shutdown cleanup paths.

This must obviously not matter on the platforms where this driver is
used, otherwise we'd run out of memory in no time..
-- 
pw-bot: reject
