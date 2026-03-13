Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48CF33689D
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 22:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773439631; cv=none; b=GfDKD1LTn4TOxb5xv4vqOyd2KkEVZ+TYE69TBFjhiWzClSIqAgY9D/9n99VpbWOlpd5JAcZblzvCDDzIjYWuuU9hlJD+jSL2ouiAM5vFzLLn7AdKbtOLR3H0Bn6rtS7XcWOzDfe+l3RME/b+mRQBNcxPZz9rPzRBGG5PyV3UdDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773439631; c=relaxed/simple;
	bh=36xZjDqxgbQRJoF9T+tfKZC50MAytjkKOe8z2qmQNKc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K7uT51/1Iq0T1GqpvvATPGui8SXQAV8tEuUDqCsxaIumpAnI3EoB3yw8tru7HdgqkBJQiB3N841kPWPPUfnOU0zI3irppXjJKBvf3Bvss2mqOcpKMx71MJJA7h4pvOqTuXMC11PfasjQtwIShZsRxyixc8s/vLFvOwzNz5ifqvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nuuEtUCl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nuuEtUCl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30B6FC19421;
	Fri, 13 Mar 2026 22:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773439631;
	bh=36xZjDqxgbQRJoF9T+tfKZC50MAytjkKOe8z2qmQNKc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nuuEtUClOYvgi5pB/X9IddMd+8PbTcMzUabvZCtelt0Lwkk4jZKg19JPArphJMQHO
	 85fz/0waIL/PD1pH83U7D3KS0JphaCLKwA5tNClr1IK/9rpo9mgv+aIIgQL7HVAR02
	 TTzut8L4b5NH9uD5UYYcK8QXSxdWGINPUL0He+2qWq4nM557O7vOcfqPLrGjx8gpDU
	 +szE6/myLqrpegd8LAJk5tCcpgMkxcv6Z04QxxdxVALCWpXpaINd0wz5r1NQmY+Hzb
	 l36rsHwAdAZYCGHzFtiQcjXHEbnKSAIKGgPZPG7hZukrEDMxQKjy+fPKP9Sm5mg9tQ
	 Tdaw7mFW16Zsw==
Date: Fri, 13 Mar 2026 15:07:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Neal Cardwell
 <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] tcp: add cwnd_event_tx_start to
 tcp_congestion_ops
Message-ID: <20260313150710.0edaa6b9@kernel.org>
In-Reply-To: <20260313202802.1201129-1-edumazet@google.com>
References: <20260313202802.1201129-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Mar 2026 20:28:02 +0000 Eric Dumazet wrote:
> (tcp_congestion_ops)->cwnd_event() is called very often, with
> @event oscillating between CA_EVENT_TX_START and other values.
> 
> This is not branch prediction friendly.
> 
> Provide a new cwnd_event_tx_start pointer dedicated for CA_EVENT_TX_START.
> 
> Both BBR and CUBIC benefit from this change, since they only care
> about CA_EVENT_TX_START.

BPF selftest are not happy:
857
  progs/tcp_ca_kfunc.c:121:33: error: use of undeclared identifier 'cwnd_event_tx_start'
    121 |         .cwnd_event_tx_start = (void *)cwnd_event_tx_start,
        |                                        ^~~~~~~~~~~~~~~~~~~
-- 
pw-bot: cr
