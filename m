Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EFE3101A5;
	Tue, 22 Sep 2026 00:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790037082; cv=none; b=UD4VLMlCqwpLIILAbzXKwFjkTL9vq+pMMVgaPeqhrn5/jqL1ixINI0cI9Z328W+7Nxnx3aG8RUyHC/eP49VobqxPdc6Y/B+QXHPJiWw/eMtXr4n4ZtbsEpPNzKjgQeCjPclhMg8N35zMTILr2W7g5BaQTEhuB2mbIfmY2qiTZZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790037082; c=relaxed/simple;
	bh=HGdO6Q2UybSYb4HojdmvCI2wDITlm1oXqv0UbWjYbeU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=T7f3OkHTtgo2gWi2SrNa+qJOc/V2UPnf2m8AY/9Ok0k4HXV8aLDuXn6LIHaxsRYMBXq9U6b9SaqgQBOTrUtSXKJk71wufRGtI2YgPQ6wtNo/GWxoZwk50v9GeEyH2MJZZFefNKNiQMcqoz19jic7N79mWm0aLtnN7OXEmgrxwrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N+TedPrT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+TedPrT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76F411F000FF;
	Tue, 22 Sep 2026 00:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790037079;
	bh=bdVwG81yUZxA3ukKYmZQbWpOjgAecnAEw7YPqtRKm9Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=N+TedPrTCZxBvECjRKAEnAF2REzn3G6QdITIa3B+KnzKPctKJM6zDvsWYArIT8oda
	 e4A36CTj99UgcSWjp93yLVnIDfBccStlKMrYbYUeDgNzXuTdOjChDYmwtDOMN0qiro
	 cMrx3woiwZh/okv21kD4JaRFvIr2wYYqmThVgZx05BxkFyRfNKbFwTrsi59fcHpqNy
	 +mM0C15BMiQts6FFigBQA0uJmEoGMqBiEV1NEfUmPKQqpjWjbfojV7Nm3Adib3/4ge
	 J2PhAixAhVYModak3x9Yv+kuqiLUf9yP1lttGVhR5WTjGOTSN8fn/G3z1GT3u9XhaW
	 ktIZQhRwGYofw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 196E43930203;
	Tue, 22 Sep 2026 00:30:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: alacritech: publish the PCI module aliases
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179003701064.3305732.11767539708390864419.git-patchwork-notify@kernel.org>
Date: Tue, 22 Sep 2026 00:30:10 +0000
References: <20260920034651.18109-1-hppiscas@163.com>
In-Reply-To: <20260920034651.18109-1-hppiscas@163.com>
To: Pengpeng Hou <hppiscas@163.com>
Cc: linosanfilippo@gmx.de, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, horms@kernel.org,
 richardcochran@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 20 Sep 2026 11:46:51 +0800 you wrote:
> The SLIC driver has a PCI ID table connected to its pci_driver, but does
> not export it. Its module therefore lacks the PCI aliases used to
> automatically load it for the supported Alacritech adapters.
> 
> Export the existing PCI table without changing device matching.
> 
> The issue was found by our static-analysis tool.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: alacritech: publish the PCI module aliases
    https://git.kernel.org/netdev/net-next/c/4d68b3483721

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


