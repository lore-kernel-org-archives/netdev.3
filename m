Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794616808;
	b=sTqReVnIuvSffM/OwFpd67nIKIgKVytZm8k2+iCqS5OvoBnN0dHmVueN2P9TrTx/uKLJ
	 Q8LCqWFxoDcglSmgzhTOx8gpKc1qp32qdjp90kAk1raJMexdcVN/uqoeWDe1IhN+h149u
	 /L9yGdnSnJXbXjNEBNw52Cxt+gwwk97gZzDtQ2n6iVR/Tx/3KcnpRAl2ebntVVNthmAJ2
	 9JiFwte7iJ9QJm+OQC4NVT92VAY5HGX+jl0RttpAmLaMZEQcrzgevs8gbG7ScX6zB0v43
	 aNpNZT2IPD5rF11ULzEqWpNUjkeJyn/t2azhQmNgaln/vaZhzfbgQKlEg4uCvWWnazQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794616808;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=yT1oZWjML81Zl/+wtc1kSjx7J51jUZuj/o24AQDKFI4=;
	b=vIbnkVOGmZzlYaZvPDtrHkp50k2uq2vMvwem3UDkVc4IJQhcS0bIKHJ6lcZbkGt88Mvs
	 jojDfz/2j0Vr+AatAvNsze4A9PSw0uk1QJL4ZlHr/Gq2i4JtU64+VAR+jBTR/Dd7z94EX
	 d/NYcxX1Y3S086jDVZw48kXDnjfufTzjjf5CHn+iSeTGIe50UQ+P3O6iS93W4bvKRVXHd
	 NZslHuTkST+RAa/UN7E820IVqDhQZxjHIhkZhEe3IMPTPjfNre4MPAMMgKtldO6ufL5Fv
	 d6jFOpuBPVvU0JwBpuE3qzF/do5NS6SQ7CNEwthmcagIVM3NMg7uDuTN9labTYlwJnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=elTd2YPa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFC1606A881
	for <netdev@vger.kernel.org>; Sat, 14 Nov 2026 00:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=elTd2YPa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41E441F000C4;
	Sat, 14 Nov 2026 00:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794616808;
	bh=yT1oZWjML81Zl/+wtc1kSjx7J51jUZuj/o24AQDKFI4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=elTd2YPaTkmiDf+jge3a7FIfwcsWdBXHr18h0wSiQXk3bWqrPZ9Nieu6kMGEpUv0N
	 BMx/hfZdHnWtuU59zpjG682SWfvLsJLJjSaYn5vGin4F/c3j8mXJ7VS7ezNx2Op94/
	 rIiyw2UHhRtCch/5f+qpxY1kmlfyg7tNs6JjXHithGZqJCkuPh00dp2B0e/Aux0ONi
	 thekLGvVfTa4cO49m6IYjED1AwiwRkDciSUGneoZOPUbE6IYkQY+feO0538TRxMRB/
	 I441JozlaRtx7f2hNSTqR9sAkldUG85fPPZug+kWO6LyJQNprhr4Cb3icyfjej1unU
	 MKnogm1Gqvkkg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A378380821F;
	Sat, 14 Nov 2026 00:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next 0/4] selftests: move the AF_XDP test suite
 from
 bpf to net
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179461680703.1918448.12801730957369528334.git-patchwork-notify@kernel.org>
Date: Sat, 14 Nov 2026 00:40:07 +0000
References: <20261109193048.1006986-1-maciej.fijalkowski@intel.com>
In-Reply-To: <20261109193048.1006986-1-maciej.fijalkowski@intel.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, magnus.karlsson@intel.com, stfomichev@gmail.com,
 kuba@kernel.org, pabeni@redhat.com, tushar.vyavahare@intel.com,
 kerneljasonxing@gmail.com, bjorn@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  9 Nov 2026 20:30:44 +0100 you wrote:
> v1:
> https://lore.kernel.org/netdev/20261105134117.977655-1-maciej.fijalkowski@intel.com/
> v1->v2:
> 
> * Patch 4: add xdp_hw_metadata to TEST_GEN_FILES via COND_GEN_FILES,
>   as net/lib/Makefile does for xskxceiver, so that net/Makefile passes
>   NIPA's check_selftest.
> * Add Stanislav's tag.
> 
> [...]

Here is the summary with links:
  - [v2,net-next,1/4] selftests/bpf: drop the test_progs AF_XDP wrapper
    https://git.kernel.org/netdev/net-next/c/f34d7544eddc
  - [v2,net-next,2/4] selftests: net: add a generic rule for BPF skeletons
    https://git.kernel.org/netdev/net-next/c/8698de5e7146
  - [v2,net-next,3/4] selftests: xsk: move the AF_XDP test suite to selftests/net
    https://git.kernel.org/netdev/net-next/c/e8f9d8237988
  - [v2,net-next,4/4] selftests: net: move xdp_hw_metadata from selftests/bpf
    https://git.kernel.org/netdev/net-next/c/d01fb5c81130

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


