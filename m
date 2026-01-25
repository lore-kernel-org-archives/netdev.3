Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D6730F555
	for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 22:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769381964; cv=none; b=p/Ge5UvnVSQ6Q62tddwnmK8vQuDI5oQroYWMzald6Xny004IboodHopt35N1yzui8qD619mJQUeaT8hAztW4iN5iC363RHMAPvV8JjIYpYOsg9HbHLQaj7Tgr2tBrWK+cAnchcML+HWxFVOav1VrFsgiuHdgeRnzqzSMOwk3rNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769381964; c=relaxed/simple;
	bh=GWImcrbm4kPoT/u9e0fZ3ZMV5NVjg5rpdCL/nD0IScE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t3zYjcQuDkJM913+IQJy8uPA76MyfbWmDG5636Kx63uN8/bZuci04C5blpCvrr6Qiu2uH1EUxiSZBd6YLaLx/43nSHfVtY57o+8yQy/T6bGwbKJWqqjSPDo8rGmjE74Goal2UH1EWmMxgBgj4cezQvx8PcX7/OyIEL+Ceyk68iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lfNvDf6D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lfNvDf6D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16E06C4CEF1;
	Sun, 25 Jan 2026 22:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769381963;
	bh=GWImcrbm4kPoT/u9e0fZ3ZMV5NVjg5rpdCL/nD0IScE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lfNvDf6DHp8nTeakAFgdD3sX0Esn2jf4t5seg1UAoDnxvPK/qBe2i1MOkjNG/65Fd
	 HqcMzpUpa9sbe8BA8wZx/26XvmWUudcSqnareGJCynK4MK03mcld1syI9P7diOhqie
	 MRGLydhK2zh97PeM68pUqm4Kz6JXAB0iEMd9K60VIUP6ryJ43HF185nMhVyrJkcAQ8
	 M4/SYME/qj2AlgIdU38qy5XowHWzxQr8AuV6wpddmNMiWiX3vh0QAYSf3Fas2nUPRR
	 BO5gfQLNDPsQMBPN98Om3S1ZnIdbggGLZwh1TfFIs7dDwUyvlIWikr4uOp+OnQMbTb
	 40dSgsqQ30Ijw==
Date: Sun, 25 Jan 2026 14:59:22 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, <netdev@vger.kernel.org>, Ido Schimmel
 <idosch@nvidia.com>, Kuniyuki Iwashima <kuniyu@google.com>, Breno Leitao
 <leitao@debian.org>, Andy Roulin <aroulin@nvidia.com>, "Francesco Ruggeri"
 <fruggeri@arista.com>, Stephen Hemminger <stephen@networkplumber.org>,
 <mlxsw@nvidia.com>
Subject: Re: [PATCH net-next v2 6/8] net: core: neighbour: Reorder netlink &
 internal notification
Message-ID: <20260125145922.36ba88ad@kernel.org>
In-Reply-To: <f3ef74d5460f14c4d102b8a5857d4a6624da9a5a.1769012464.git.petrm@nvidia.com>
References: <cover.1769012464.git.petrm@nvidia.com>
	<f3ef74d5460f14c4d102b8a5857d4a6624da9a5a.1769012464.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Jan 2026 17:43:40 +0100 Petr Machata wrote:
> The netlink message needs to be send inside the critical section where the
> neighbor is changed, so that it reflects the notified-upon neighbor state.
> On the other hand, there is no such need in case of notifier chain: the
> listeners do not assume lock, and often in fact just schedule a delayed
> work to act on the neighbor later. At least one in fact also takes the
> neighbor lock.
> 
> This requires that the netlink notification be done before the internal
> notifier chain message is sent. That is safe to do, because the current
> listeners, as well as __neigh_notify(), only read the updated neighbor
> fields, and never modify them. (Apart from locking.)

Hopefully we're not setting a trap here that some driver will later
fall into.
