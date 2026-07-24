Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71183F86FC;
	Fri, 24 Jul 2026 22:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784930445; cv=none; b=bn38s/OD4aeVB8nMhLuZyaU5dvymn/v0H9b/3+Ver4BbUkL05wEDzyxvE+t5hVMxxXElxDtN9LGpvAoXEdZ0fhe2HDjpfn26om+HsS00a+MoM58ITI4+RQFQf/rkBaBKsh/6re07w44PSqcursFOV6ygK1l7PwQEid9VQXQdmtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784930445; c=relaxed/simple;
	bh=/bZFpKXdW3uZVIldBX8Lk9CbAETXyW0XsAcbyQ7/uYU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YTm/kceJAp7v9ncWAhWvvSOfTR4f0dQb70N+e4ys74CaoVpwlNKHBwlCNO+HNw9+EqA+5i4n/BVjyXBjL/hYVvKMXFN8v+gQbtJL8ssFQqfelPfZd7pS8FxJ1LeXUElPU1oyF7oQpSffC+zVn4bFOV0QjbRkDeww2KaZb+AApgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kZH7qrlY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZH7qrlY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 764591F000E9;
	Fri, 24 Jul 2026 22:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784930444;
	bh=fK4Z0gN9olURrSd4tww1AtDLoB9iLbjxHxm5ZR+5Ah8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kZH7qrlYUE2PsbX8JB67n+c3JdUkWSj/kl26IBdEUmhF95mbA7K38eijubTTp/Ffx
	 8/UoYLKpGRGjmeJQGuPn277sIcuK90IFcdzYR4O5OHwcrykdki79chWGt65P1ENZRm
	 wbMEn9IZyi3sXuvRnd6OuDL/q38uCFtyV9Vb7tFMjhM+9YALp7kN5WTZ03tjOwxH3e
	 ZPV2DrYdienH6r6GUPAdo0RMlhjyxFrRW8wJO4eRWNI0hOKseSNpECb2KoOEuIqV6R
	 CoD7Eg5Pi2+/lPKbvgi/IvfrVosVcJVf+wbVC/849q86MzoxnXDsw6VSXU4tTPrAGD
	 dtEevbRxYl2og==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0BC438111D7;
	Fri, 24 Jul 2026 22:00:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: drv-net: ncdevmem: Open /dev/udmabuf
 O_RDONLY
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178493041138.3326421.12143530294273860062.git-patchwork-notify@kernel.org>
Date: Fri, 24 Jul 2026 22:00:11 +0000
References: <20260722205442.1894665-1-tjmercier@google.com>
In-Reply-To: <20260722205442.1894665-1-tjmercier@google.com>
To: T.J. Mercier <tjmercier@google.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bobbyeshleman@meta.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 22 Jul 2026 13:54:42 -0700 you wrote:
> Write permissions on the /dev/udmabuf device file are not required to
> issue ioctls and allocate udmabufs. Applications should be opening this
> file as O_RDONLY. The BPF dmabuf_iter selftest already does this. [1]
> 
> Users are pointing to these selftests as examples of how use udmabuf,
> and encountering permission errors on systems where write permissions
> are not available on /dev/udmabuf. Apply the principle of least
> privilege to selftests which use udmabuf by removing the write access
> mode from drivers/dma-buf/udmabuf.c and drivers/net/hw/ncdevmem.c.
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: drv-net: ncdevmem: Open /dev/udmabuf O_RDONLY
    https://git.kernel.org/netdev/net-next/c/be6f0d0bae22

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


