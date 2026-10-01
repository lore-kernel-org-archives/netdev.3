Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBAA27AC57;
	Thu,  1 Oct 2026 00:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790814080; cv=none; b=eUA3bfSWuTAMrABMBKfX0paMOOoBFc/K1wnrkXWaKD4P0BUTDWIGtLNEDbeeaFRLdq0+Hx7ItLly96bI7qDhJS5+GM4mBubRbsVmHoKTFb5bXKRcqLj9XBTVYAYRoRr9JwAZITn1ofYTnXtS8sjuKMsu3TOtpIgXtB2nmnKxgpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790814080; c=relaxed/simple;
	bh=NQQ5IbTdZBVNpT2YqGfBp3ufEZkur+LN5szGAWpoJto=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rLqOB2E8KjHTLp1mnY4WYSeX430c7masj7FZz6YmxuD7NaA+8lht4tJLiLrddfPYtHBCaR06VQl2ZjyiPi4j9AhEJQlSB58qJOpNUX3zUcdpMbHMfHrMOmjr6+HnYNeZXDFrAm3fIFnFWvFskNWs9mGq01nUq3SDPysEhcMvICo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=khpMXBnG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="khpMXBnG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D05F1F000FF;
	Thu,  1 Oct 2026 00:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790814078;
	bh=NQQ5IbTdZBVNpT2YqGfBp3ufEZkur+LN5szGAWpoJto=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=khpMXBnG5aBEcB8PzWMBs4Zvg626IAiZJObAq0Oar709KBClEGSGnjvu4fa+LEqQb
	 TaNGoL8ijY4vOfODBHHj82t6NBmtRLT6Ysf+LlERnIRrB2l/KsYTbQinf1aalFCWuG
	 Gis8AY2/zwUX/yqUtPHZJQ3/TXlYYDiRgfRnkbEsZLEKGEthWCPUH5wplVPpE+cMhj
	 IyQaka54FNvH0l9i5Wi037TWCCl6flEwBvlDTY+K3T+UqT8JwWZ/Dme9kz008vXSWU
	 /S+WbJ0aSP25bZOfj7BvxfqboZrgfDvV7BS6COMhzjiJiuNzwVY/HiUuauMS+vMi5g
	 CPtWpcVe0rJFg==
Date: Wed, 30 Sep 2026 17:21:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: edumazet@kernel.org
Cc: Quanye Yang via B4 Relay <devnull+quanyeyang.proton.me@kernel.org>,
 quanyeyang@proton.me, Eric Dumazet <edumazet@google.com>, Neal Cardwell
 <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, "David S.
 Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
 Geliang Tang <geliang@kernel.org>, Mat Martineau <martineau@kernel.org>,
 Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 1/2] tcp: annotate lockless access to
 sk->sk_err
Message-ID: <20260930172116.42e1ec0f@kernel.org>
In-Reply-To: <20260925-mptcp-sk-err-net-v5-1-0cac04d6ea48@proton.me>
References: <20260925-mptcp-sk-err-net-v5-0-0cac04d6ea48@proton.me>
	<20260925-mptcp-sk-err-net-v5-1-0cac04d6ea48@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Sep 2026 05:47:56 -0700 Quanye Yang via B4 Relay wrote:
> Subject: [PATCH net-next v5 1/2] tcp: annotate lockless access to sk->sk_err

Updating Eric's email just in case this isn't ignored intentionally :)
https://lore.kernel.org/all/20260925-mptcp-sk-err-net-v5-1-0cac04d6ea48@proton.me/
