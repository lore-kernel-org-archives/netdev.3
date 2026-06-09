Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74264261B92;
	Tue,  9 Jun 2026 00:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780965614; cv=none; b=BOSizQRKBRaBPG/s99T9msOgtGUYy7dZjFfxCunqbRB+6Lg9a80BOlzPDFhW8KTaTPNIbTAP1XZw/quUFfZQ1s7A6oIKLQnKzZr7n9nS8CvFZFebyQv9Z3dz0EstTg8boAr43UojfPkDKBb0c6T1APWpCT3qJwCIN3BTX2Thc+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780965614; c=relaxed/simple;
	bh=hq9HpipbrHLUcCNDFXCuHkrMlc7wYl8mC2uOMYoTDds=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kfqzfHtZyIfy14qTWyxkyrytC1uJYrYh2muISGMGRa+ZqtA+RU2jElO6hulAVwdJd6RW9d7CJwKu+AnjS6X6+gp1zTITZdET00qDhNrVIDp7XNs49hJ/fyjW+e671T1Pqw302EsauV5bW3iea1qDq2xAkMsTQtlHE706GNVA54o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lF5WlKvd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lF5WlKvd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E1351F00893;
	Tue,  9 Jun 2026 00:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780965613;
	bh=kA6ctB1S1irr0qxXxLBZAIjmp55Qfd7J37oEWwwGYZc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=lF5WlKvd8KDVZJ1tfezyC9KDf3MfH06jJoF+6zKIJxIH++KUkd55QY6rk0IpP1XTL
	 SVnXNvXkwcscAWY6BZPBCAtQMwpoK9GhcSTIDOGUX/FIY4O4Ktrn53L/NQu/GHk+2q
	 O70N18sywCslaOIt3arLH+OPqJFZUWjknLO4CtpCfrxKmJ67L2p8zKV+f+CsxOVpKb
	 tB7XcxwyUSUkV6Ma3z2ZDmSWG4wjGjf8BMgbrABt7bszx+PfHADWjnIRjN8Ygpz2rr
	 A8CSJICEWVfoj9hDdeZoKb9vSaVnmyXRTOe/+Emq5fIxJdtXQOSv/PcjiFd7TdJf63
	 iZmk215wDeumQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197CD3812FDA;
	Tue,  9 Jun 2026 00:40:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv2 net-next] net: ibm: emac: Clear MAL descriptors without
 memset
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178096561164.1730160.12681740323501157661.git-patchwork-notify@kernel.org>
Date: Tue, 09 Jun 2026 00:40:11 +0000
References: <20260603230754.5535-1-rosenp@gmail.com>
In-Reply-To: <20260603230754.5535-1-rosenp@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jeff@garzik.org,
 rdreier@cisco.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  3 Jun 2026 16:07:53 -0700 you wrote:
> Clear MAL descriptor rings with explicit field stores instead of
> memset().  The descriptor rings are carved from MAL coherent DMA memory,
> which may be mapped uncached on 32-bit powerpc.  The optimized memset()
> path can use dcbz there and trigger an alignment warning.
> 
> Use WRITE_ONCE() for each field to prevent the compiler from merging
> the stores back into a memset() call.
> 
> [...]

Here is the summary with links:
  - [PATCHv2,net-next] net: ibm: emac: Clear MAL descriptors without memset
    https://git.kernel.org/netdev/net-next/c/f0ba7f385de1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


