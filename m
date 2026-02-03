Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393D331197A
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 17:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770139598; cv=none; b=ZflSfv1DgmBSF3as1aIKq3jgj9sktPNK/xvbE3xT9qgiaf+9C1VRnIqpyLrueZvJ9T5aS0YLAztzlnDsuAvFv1fU79Qz1m62KMi68cSqgc7LYX8GvUAwxrZTa9w6nPiA7P+5ibvM6EFxzut+6Q4ZBxnGwVWfX9sjyoCIBed2bHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770139598; c=relaxed/simple;
	bh=IrL/IsVyXY+jd6coKppEwCofIGbOeIgNfDbnpYMc+nI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QQ7dr7uTMBN7ZQEJG0CvDMvBw6Of0hRyHu9U+NpW8Q3eMiuE7Q5qc6pza5b8ehnJFtNjRlBK1Th2AWVnGW0SAtGnoF7DNpklxhcaBHptrmwSthkpHv2RCE4CDWdp7TrMb8gwfbLkcMIBdoK+XEHzuUYHMadrXCuDp4fyLijbwJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tokaXIh4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tokaXIh4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23ADBC2BCB0;
	Tue,  3 Feb 2026 17:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770139597;
	bh=IrL/IsVyXY+jd6coKppEwCofIGbOeIgNfDbnpYMc+nI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tokaXIh4mJkA9A2wps2JGC+JN60csYa3I3gEtqsdA4igNrobzu220Kv4l3jn1cIrF
	 N6EJgTmMQ0J3RW7V1I3HYSDuaVjCSHqwrPA8ua0+D90iBlNEWtnVQACWf24cSI9/y1
	 PReyVptyB8rmbpL4JAHfN5vFCEMUDqGl6wKj8E2U+K19rt/gVBRL9SV2KG3vIGtApI
	 Ap0Een9gsjEJM2byCklZzAG4J7zQ4GOouq6gJFotYJRSI2Uz9vMXKPOUSyU6CSJBKb
	 wPSkmjiZOYlBlxqTkmNKCpWX1WUubgV5sZC5OOuD5fS5Cz2gUEuUukXil6E1vVjekr
	 wna7I7EC9Vrhw==
Date: Tue, 3 Feb 2026 09:26:36 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Neal Cardwell
 <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 3/3] tcp: make tcp_v{4,6}_send_check() static
Message-ID: <20260203092636.20c6bb6e@kernel.org>
In-Reply-To: <20260203144053.83193-4-edumazet@google.com>
References: <20260203144053.83193-1-edumazet@google.com>
	<20260203144053.83193-4-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  3 Feb 2026 14:40:53 +0000 Eric Dumazet wrote:
> tcp_v{4,6}_send_check() are only called from tcp_output.c
> and should be made static so that the compiler does not need
> to put an out of line copy of them.
> 
> Remove (struct inet_connection_sock_af_ops) send_check field
> and use instead @net_header_len.
> 
> Move @net_header_len close to @queue_xmit for data locality
> as both are used in TCP tx fast path.

Seeing this in allmodconfig:

net/ipv4/tcp_output.c:1482:13: warning: unused function 'tcp_v4_send_check' [-Wunused-function]
 1482 | static void tcp_v4_send_check(struct sock *sk, struct sk_buff *skb)
      |             ^~~~~~~~~~~~~~~~~
-- 
pw-bot: cr
