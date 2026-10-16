Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C6D334374;
	Fri, 16 Oct 2026 01:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792114814; cv=none; b=La3a2GIIqi4J8jil2aF4wkkxSA768Gazu2CtG6EI6aZHnjaJ8EKWXwIFClLqqhSljyTMNp06/E0ijEwVuyuCtkJty0iOwB8ZIUukQFWUfXTxbtlA3NJbx2esuGLGFCjI/DrY2s02diwvHwAqtTVTAWrQ219SKFQNUGkJcRC1eVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792114814; c=relaxed/simple;
	bh=GRlEUPU43csNWJdDqp87XRCrr7jF8qwnw4wkamEgibY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GA8j5hS6K8NkSMUpv0uePz0cDO82vhEsGhyXvwQJTd44fP5WOJ9Tv1WHYH07WuOmfisq4NDL5BcGqaq7c23bO34jpN4IJqND7gHjR/ug9QlhaMCDGES0dRpuL3g5N0YN7S5qy6U26FHpkrEa5AFnPbPZzJ5nRvQ6hfRUTp65bgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UhoMK90L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UhoMK90L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 068841F000C4;
	Fri, 16 Oct 2026 01:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792114813;
	bh=4mbeRdOBiYMJ2XpRPzevtJHiRAQAP3Dz+k67N+KbBRg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=UhoMK90L4X8czDPj6+cumadDL2F7/OeGe2P1ypQTU1fLroLg15RXf54eQUj7Qzxmo
	 U0AqMn+9zX2/6XlBNaCLNEQwLjFIy6zjKeaSXcniD91T6aGJMl43VYFYV6Ga4D98bQ
	 XVUZHT/EEbbjUPAPbHupf2cUBBepdtEJVCMZXqPqwFENpvTy1hc9GuiCauNDClrRIv
	 aZolriH1wiumxpjpzD5jamog1NEg4U+eMauQkd1q99nKqUYLg/FDza3LkRHOy6YQLu
	 an2htym558vgz8yllBcrfJPDN0Kd2+hZvfKmLdEgIeQLg+dGZgxZZ7kN+xIyOWPjZ5
	 4YaxXttQWt92g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F16213808209;
	Fri, 16 Oct 2026 01:40:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: emac: mal: replace devm_request_irq with
 request_irq to fix probe error race
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179211481152.6630.904619087958285096.git-patchwork-notify@kernel.org>
Date: Fri, 16 Oct 2026 01:40:11 +0000
References: <20261007183821.928263-1-rosenp@gmail.com>
In-Reply-To: <20261007183821.928263-1-rosenp@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  7 Oct 2026 11:38:21 -0700 you wrote:
> devm_request_irq() is a managed resource: the IRQ is not freed until
> devres_release_all() runs after the probe function returns.  In the
> probe error path, free_netdev(mal->dummy_dev) and dcr_unmap() execute
> while the IRQ is still live.  If the shared IRQ fires during cleanup,
> the handler accesses unmapped DCR registers (crash) or the already-
> freed dummy_dev (use-after-free).
> 
> [...]

Here is the summary with links:
  - [net,v3] net: emac: mal: replace devm_request_irq with request_irq to fix probe error race
    https://git.kernel.org/netdev/net-next/c/dabe6a847748

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


