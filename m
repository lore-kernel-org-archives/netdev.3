Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793022812;
	b=q9s6BQSdpReaonqzHEML6otCGcgHDOing1bHQR6Y6bmOcq8ZVD4bdIM4gEkEQGHc6SgY
	 QHp1jYaOWqjKSppzG/E444S6f47340ftg+A35vSJ5nDKIkSa2IpzcHFDBr6fxyn+JCfAp
	 ObPN0sPPUmRaYjSLki+t6mRQSpp5ztxjgritU/9UOQqNZT3Z1dVzR/6sENFSKiAqMgGZA
	 GGAlatkMuWCNZXCkJ7fGLJ7PZOOzCRyHAdWnV5jHvsrbvOBM/YQSvtPuU5nKukLw5xS85
	 qgtZ0ejovlNIhz+834HXgAlDXwO+mjv68zmpW7Bd/Tm8HXF4OHCyXcziXdxQlf5YlfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793022812;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=vrfzXv/ccKZrHyimwscWwKIpEaYPjB6OOpe7bAi/4L8=;
	b=RuDDe8q4CkgjYAHkzSfYEoEtBRXh9RaSeQaJ5QgvIszK0zIsV85PE7GGC4ZyZBJvn2SR
	 +mHGQ+mzUJChuEduhOBA0h9WdpT+gt+fJybW72rlXueMd8ZGsush/KEVXpP9erPLc4+r9
	 rhnL7Tl4uRryRD+yeGbGvJIxQWjXQvP5rkBDjVTZtE3EB2UT1xQT1r7lVZK2FQuni7VRZ
	 xy3zHdTp2GLt1/HP7XFMx98v05VhbumzC9KsNput5EE8jluLKspKDnIkNLsJatzeGocbR
	 iueXwwGYqP3WMe76nHmPSnw3Bb8PHNUD+oVThVR5/wh4khZG6/rLPTBs7+NYYNe4zgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c9LT7RiH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11870606A331;
	Mon, 26 Oct 2026 13:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c9LT7RiH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8F8B1F01829;
	Mon, 26 Oct 2026 13:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793022811;
	bh=vrfzXv/ccKZrHyimwscWwKIpEaYPjB6OOpe7bAi/4L8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=c9LT7RiHw6KJ1VARX/LtW2MFOl+XrKV7GCOaYVTnXgftnbs2YZNS4Gijdhx/LxrZq
	 8zby5X1WCVtmsA4+dQ8o0qEP96FycxU9ObUjQedJf21dR7XQAVklvhpJTgLbUygZa2
	 ANMfWIWGuI0lBsX7E5QFXf48k6MGS+4kYUZFcpef5WiKzFTnnpl4UL8FMjtTD6Mz7p
	 II5P9+T+8WafsjIDHKtBOUMs8mXmeMC40e1stAgPYOC+4K0FAyklNeyHoX36g8AL9B
	 sXcAAOxYxnVyOmasHr3NSLZYDJGmVM5DWtcdlfpE1i5X3sRQPvJGVrbmpinZIpnmJI
	 bj4eArodIS+qQ==
Date: Mon, 26 Oct 2026 19:23:21 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Chunkai Deng <chunkai.deng@oss.qualcomm.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev-bot+sashiko@kernel.org, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org, 
	linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	tao.zhang1@oss.qualcomm.com, peter.chen@oss.qualcomm.com, jeff.johnson@oss.qualcomm.com, 
	konrad.dybcio@oss.qualcomm.com
Subject: Re: [PATCH net-next 3/3] net: qrtr: implement shutdown()
Message-ID: <at9XxF32WiKBEJQY@debian>
References: <20261016-qrtr-add-shutdown-v1-3-e1cc01ca5919@oss.qualcomm.com>
 <179248895481.3135.9231497728918795508@kernel.org>
 <20261021133531.55da7de5@kernel.org>
 <9f76467c-5b21-40a2-95b8-e91cf1e1b47c@oss.qualcomm.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9f76467c-5b21-40a2-95b8-e91cf1e1b47c@oss.qualcomm.com>

On Mon, Oct 26, 2026 at 06:23:18PM +0800, Chunkai Deng wrote:
> Yeah, this is a known limitation and the commit message calls it out.
> 
> The sender sleeps on flow->resume_tx, which hangs off the node and is
> keyed by destination node/port, so the socket has no way to reach it.

It is fine to defer this fix as a follow-up patch, but I'm not buying the 'no
way to reach flow control' from shutdown() callback claim. Why can't you just
store the 'qtrt_tx_flow' pointer in qrtr_sock and dereference it in shutdown()
callback to wake up qrtr_tx_wait()?

Storing the pointer here is fine since all callers of qrtr_tx_wait() hold
lock_sock().

- Mani

-- 
மணிவண்ணன் சதாசிவம்
