Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7B81A6819
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 21:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773525123; cv=none; b=F+EG6nTLuxyKK+1TJfuVR4seSm4Lej935q0DEwAus+PvpcMKYCSNJZZgLH9rxqe27WZtD3eMNNbibWJ8+q3pnFP6wUD5Kpm4TuDOTi0587SnNTClTatH7eHoMZ1xNtp6PWWQUMbT2AnGWYGLfl5lhFXxX8RaCRxp3c7OzGq6A4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773525123; c=relaxed/simple;
	bh=UPYq0NlNjl2ED61JZnMdwPQk6YbawUXEt/+51o2jiAU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nBEIvHhQ9JZiSrphy7VexjHlSQVg+dE9Auwk1ImJh4x18yH1iG8NxQmW07NTxxavq7Xo6AfZf2kLUu4jWb81nBJef4NZveq7Vxe9RMOYT8c5rs1rKurfpRwvMG2PkM+44pcDU8DGbo2nmuYyJVum5LLsg6eZWon4EC/5i+HTJk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RICRGkp9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RICRGkp9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15BDEC116C6;
	Sat, 14 Mar 2026 21:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773525123;
	bh=UPYq0NlNjl2ED61JZnMdwPQk6YbawUXEt/+51o2jiAU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RICRGkp9n1N99hpgdUjHWT8bAbtrLMShpNmebvkkTRcX2u4WdnNMYaktocIpQSsDM
	 bbyNHjIrJDI+jgATnAWEo88yYHN+/DRz9bZGpbKZbtogkautq14AiM0CmNj0TExQE4
	 oWx21RJBWrhCk7C/pcA53ut+QA7Z9nldaUOlnaltxrWSzI6vlFJnVq8NO67DVXXKJ0
	 zAlnkRPXIJ7taxF5k443BDP4WmKb4sR/EKISKMdoNzyCws66DE3n7y/mN6HRBWFriy
	 lez6dx2yHxupRQcj1CJGfb4Zj1QtAR2Ub5cy0OU1CTxEDNaVUKZOLz+ZLe1Khtr+2S
	 Uba8Lze6RgvtA==
Date: Sat, 14 Mar 2026 14:52:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Neal Cardwell
 <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH v2 net-next] tcp: add cwnd_event_tx_start to
 tcp_congestion_ops
Message-ID: <20260314145202.778a8535@kernel.org>
In-Reply-To: <20260314180802.50222-1-edumazet@google.com>
References: <20260314180802.50222-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 14 Mar 2026 18:08:02 +0000 Eric Dumazet wrote:
> (tcp_congestion_ops)->cwnd_event() is called very often, with
> @event oscillating between CA_EVENT_TX_START and other values.
> 
> This is not branch prediction friendly.
> 
> Provide a new cwnd_event_tx_start pointer dedicated for CA_EVENT_TX_START.
> 
> Both BBR and CUBIC benefit from this change, since they only care
> about CA_EVENT_TX_START.

BPF still not building :(

  progs/tcp_ca_kfunc.c:121:33: error: use of undeclared identifier 'cwnd_event_tx_start'
    121 |         .cwnd_event_tx_start = (void *)cwnd_event_tx_start,
        |                                        ^~~~~~~~~~~~~~~~~~~


https://github.com/kernel-patches/bpf/actions/runs/23096281431/job/67089276918
-- 
pw-bot: cr
