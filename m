Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92809409289;
	Wed, 23 Sep 2026 23:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790207482; cv=none; b=estZHZzZXxwA+fbaih5yLFt5fEDpoqgLXnkMAP+j7XISPaSgfZUP79GbpKYZHKGzcdgg+URLvY8glw1rIwsyR5XvYeIpLQ5tCJVXMS6EcKgsHrHgPXRw8JGQt3T5HN8EFYfPfBOFQwvJXBCPXyL+89SIpxBdIYYH/YBdvt5ojW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790207482; c=relaxed/simple;
	bh=IV39LzdXi9w0N8wUuz0GXpNT3PBeOwlXh6SfY9+EsNw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tdEMWsrLLwC2hPbicZxf9uKLdfZV79F2GW2KVZzVtdre65B97e11MNgm+m7Uq9IhIzvS6BdfdLgy/RBmIZKDc5dVYusDNu8dTwwczv6q6lEvCCgaQiK/dDkyEN0jtIC/MMxylwNDUx3ZGwurREEbE8EovmJz9IC2D18LbwZ8t2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CZVvW3hH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CZVvW3hH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 754061F000FF;
	Wed, 23 Sep 2026 23:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790207481;
	bh=ru5Myrap6AZnFp1IqzUz1H5DLyFG9FKAqj95PbXWklU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=CZVvW3hHXS5mh81F3fb3QJm/jfzedcYtrBs8vl6K9QnrEnhJgPFxPpQekkCq4aHbU
	 EaiiUpkSiYTW1K0GqbzTy3B+PvBR6N5aQkaPNzkOlAKhSQO5NX4kauXQLeuxDra8E8
	 r+UbBZSFDNksaXErKbdZF+Ub8cbBKDzFAtq83R1EDnqHGe8Nsp5qBDldAosS5juh4k
	 8WFDiAlB/Hp+nCVpyhZ4v7jgFOZe6mMybs6MLuOshHhJekQzXgeDJ9TSumA8HCkokE
	 Y93X8e8us6642LMDCAprwGdWFtt+5tYdsuepCds5FUtXTR3KGcATxh90XCfZebiQYD
	 H+WoUw1IcWt8Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5688C39E9602;
	Wed, 23 Sep 2026 23:50:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: sfp: add quirk for XikeStor SKT-2.5G-100M
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179020741089.999807.4569868820819171963.git-patchwork-notify@kernel.org>
Date: Wed, 23 Sep 2026 23:50:10 +0000
References: <20260920192632.72729-2-jan@3e8.eu>
In-Reply-To: <20260920192632.72729-2-jan@3e8.eu>
To: Jan Hoffmann <jan@3e8.eu>
Cc: linux@armlinux.org.uk, andrew@lunn.ch, hkallweit1@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 20 Sep 2026 21:26:10 +0200 you wrote:
> This 2.5G copper SFP module contains a RTL8221B-VB-CG PHY which can be
> accessed using Rollball protocol.
> 
> Add a SFP quirk to enable Rollball protocol. It includes a small delay
> to avoid unnecessary attempts at reading PHY registers before the
> module is ready.
> 
> [...]

Here is the summary with links:
  - [net-next] net: sfp: add quirk for XikeStor SKT-2.5G-100M
    https://git.kernel.org/netdev/net-next/c/a9e94a7faa56

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


