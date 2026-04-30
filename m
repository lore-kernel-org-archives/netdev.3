Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651CC1F5EA;
	Thu, 30 Apr 2026 00:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777509653; cv=none; b=DfL0I8hTl+xoweC/bN/yC9nCRpkFRfgRDxkXbramsCaEFGhI5w3ldEUodxrPAEem25MbDo+f/ZRrI2MZGWb8DGesQGHKDMkYz1wm00Lb7KuS981VXCt4k7empQ0oxbIlcsg+KO2WJDnLef0TGv0nz0I53+LEj10ohQH7mxvH/90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777509653; c=relaxed/simple;
	bh=nlYobtovDncPDpyseKiR2uUju0BsBAuUQN0zoEAskzM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NLuZn3TkdhvewhynvdMwUbqfzvJNWihq1cgFNT6++ul6EMP2rxn9xlGY1sA0QnDtW+Hqq8sxSkCgr5sfS92rBwe+2bQ+j+PKYuOowTFaRoUVC5WEa9WLBJWmGMoTTY7/t8bvAoyMrkwYU5XFApKKxz9QHHly4J1Z/aNwA3o7mrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qWVd2Oj8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qWVd2Oj8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CD31C19425;
	Thu, 30 Apr 2026 00:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777509653;
	bh=nlYobtovDncPDpyseKiR2uUju0BsBAuUQN0zoEAskzM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qWVd2Oj8heP7d2dxMbABUt/M8xKDIKirUvGpmv0cgm7gSxyXB5EqOx+VNfKbYYHiA
	 ObjhGA92etLRuzDvf+ydU9UhxgScB8Z2anpCVNpSuAOOyxVM8O0QSBUGfdZw9iHpy7
	 QVr2Dr+Xn7a/tPMVag/ICs77QzTm/Olacb8xA2MAwo2k5yrI1LGQlw/pcxN4voqNSt
	 /f+HYw3rZWd6MXijqBGkmtzj+wgUw866qGOaXbNnHSynPYj1/iYSApwPBRShKpbcS7
	 IJr6+nZYP26eyZaACbd5POjv+MLX4J+K2eRxg2bK/fF+Vpdtr+udDdwspzoybKznFe
	 614ciCX1Zd6vA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CD703809A2A;
	Thu, 30 Apr 2026 00:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: add net_iov_init() and use it to initialize
 ->page_type
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177750960830.2238701.18021000357122170023.git-patchwork-notify@kernel.org>
Date: Thu, 30 Apr 2026 00:40:08 +0000
References: <20260428025320.853452-1-kuba@kernel.org>
In-Reply-To: <20260428025320.853452-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 asml.silence@gmail.com, axboe@kernel.dk, almasrymina@google.com,
 sdf@fomichev.me, hawk@kernel.org, akpm@linux-foundation.org, rppt@kernel.org,
 vbabka@kernel.org, io-uring@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 27 Apr 2026 19:53:20 -0700 you wrote:
> Commit db359fccf212 ("mm: introduce a new page type for page pool in
> page type") added a page_type field to struct net_iov at the same
> offset as struct page::page_type, so that page_pool_set_pp_info() can
> call __SetPageNetpp() uniformly on both pages and net_iovs.
> 
> The page-type API requires the field to hold the UINT_MAX "no type"
> sentinel before a type can be set; for real struct page that invariant
> is established by the page allocator on free. struct net_iov is not
> allocated through the page allocator, so the field is left as zero
> (io_uring zcrx, which uses __GFP_ZERO) or as slab garbage (devmem,
> which uses kvmalloc_objs() without zeroing). When the page pool then
> calls page_pool_set_pp_info() on a freshly-bound niov,
> __SetPageNetpp()'s VM_BUG_ON_PAGE(page->page_type != UINT_MAX) fires
> and the kernel BUGs. Triggered in selftests by io_uring zcrx setup
> through the fbnic queue restart path:
> 
> [...]

Here is the summary with links:
  - [net] net: add net_iov_init() and use it to initialize ->page_type
    https://git.kernel.org/netdev/net/c/735a309b4bfb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


