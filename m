Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4F718DB26;
	Wed,  5 Aug 2026 01:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785891650; cv=none; b=TOHaGLtkPBlQ5rel0wxuJrbZCsQJgBka+6zHdC+o3EuK3TpNi4Ng9BFa/9XDr56VuvnIXtN7vFeSLAqtyXgdf90bS+VYEWJmn49UqMb8kK7zDY8WmbCxR09qhIrXFzOdS+Sp98gGuMhYqSWeQy37kikwSkFOOihAPrN6ZYoo6lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785891650; c=relaxed/simple;
	bh=M5iUuIAEkOe83cYPkVI4Kkb/3iUes9/pw7bKHsb19vM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lmm9pPweMHM4QnCjapyI9qEiVuexQszs8zftRk+MQlFys2lRS6lRrI72KQLd9qRqld17xz/uGvueKtO5kMZ5JxsRkJvOpcRjHL0eGlvZrq/PND2BpzuFPmeVn6FzqP4gIBZZg8IhGX0Qr6ViN8EBRx1HR3KQa4LCjum3wIMUz14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RF85tYGh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RF85tYGh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C92EE1F00A3A;
	Wed,  5 Aug 2026 01:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785891648;
	bh=wDoFFK8k5YTxmRnKscMNyLZY+muzZHuYjeYkOMRXrgw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=RF85tYGhiHjm4uKEo6TkqefkpcwefKhKJq9/2Jlh8vaqy6UKnmGfglB6gY4WtX+RB
	 g3uMxUym+TA80Pcie3lZ6/FjKqvM134zsd5ySqspot8vYK3oVDvkuBDe4F1MSjY1tP
	 tMPfXZf/mLT6faoINwrYE9u3oeQ9vMaeKNi+Mf7xTdgwzWxcVDu0D9LfPQB8B7kzk+
	 68TLfFuLW+eZN+heFN1zkWLtcThdT2/mT8CRfzjstHj2yfiRw0AQ0PhCK96/2NhUaw
	 sCIgFltDMj64gGpqSTbyDwmm1oLoM2rC4m4979s7z3U5e68pfEagOi/MMH6AGxI9hP
	 K6Y0lPpuZgGSw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5691F3926663;
	Wed,  5 Aug 2026 01:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: airoha: fix ARRAY_SIZE() division by zero
 on
 UP builds
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178589160888.3856351.13210051056800049801.git-patchwork-notify@kernel.org>
Date: Wed, 05 Aug 2026 01:00:08 +0000
References: <20260731-airoha-spinlock-array-fix-v1-1-863a7e239a5f@kernel.org>
In-Reply-To: <20260731-airoha-spinlock-array-fix-v1-1-863a7e239a5f@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, nathan@kernel.org,
 ndesaulniers@google.com, morbo@google.com, justinstitt@google.com,
 horms@kernel.org, aleksander.lobakin@intel.com,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org, llvm@lists.linux.dev, ojeda@kernel.org, lkp@intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 31 Jul 2026 17:47:38 +0200 you wrote:
> airoha_alloc_gdm_device() initializes the txq_lock[] array iterating
> over ARRAY_SIZE(dev->txq_lock). ARRAY_SIZE() expands to
> sizeof(dev->txq_lock) / sizeof((dev->txq_lock)[0]), but on UP builds
> (CONFIG_SMP unset, CONFIG_DEBUG_SPINLOCK unset) arch_spinlock_t is an
> empty struct, so sizeof(spinlock_t) is zero and the expression is a
> compile-time division by zero (undefined behavior), reported by clang
> as "division by zero is undefined [-Wdivision-by-zero]".
> 
> [...]

Here is the summary with links:
  - [net-next] net: airoha: fix ARRAY_SIZE() division by zero on UP builds
    https://git.kernel.org/netdev/net-next/c/c509971352a6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


