Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3021145A1F
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 02:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781059808; cv=none; b=SEZhZGi9zYJ+hG2UJoPLJ/8r9n/cUPGYNlnd61OFhRn0nnCVSzSQFCYC1nQX2oOQNlvmQbWTGjl6Hp3/sKaGd6Nm3ggPNx+kAsh8COK8rF9IBN2a3Toc9oNAnfKp3EdHy1t38yBSuNjwgPM/+nvmgJc3X1RqXX2ZJjLp7D4TqnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781059808; c=relaxed/simple;
	bh=stY0E8LRzxdFUUiib3Ca7Wgifcpl5nDQGX2Qr6+Af9M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=okoyxBEslgTl3BJDuIMMz2a9jbl6I6znVbySypAvFXRHi9mU4vaMJPngWLTtbcsLcPXzbmCun0LGg8qYEv+ZENkLHRWfkbJGOoXKabRqaGXPS0bD5L2rgmUImSKdJTBn3hkxJ1l2ovhf2naPor7G9YRcDqDj/OGCDO/89AdE5AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Olw3XyUW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Olw3XyUW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C3EF1F00893;
	Wed, 10 Jun 2026 02:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781059807;
	bh=kYzkiUak/Nr6n9s5xskIwZFviCrSvm8i6bvZdI+wewk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Olw3XyUWd3QJG4LrEpij40MIT0Bxm2v0Yx5nVuFhtbU9IHrm7qiKbMfDgpETnEbd2
	 cKs/Q/P6C9nueQ9OHmKNOGYvVV2R8nzFUZstV9ZRvJjQhGZDNhEtALRzJ3INKctP5a
	 1RBJU8zGhEYha51wtI4kBzp6476XtrkmB2rkTAVJkEZ3ZSYaGj7qkvAbIK881fBLaL
	 MlFfdaRoxtPsrBYrSTjqfurT50B8mfoIprOFQGBl09+MndTEtvLH3yz+s+yIjeJy0Q
	 noBVA0dhia4psnJfRzKr0+DFuiFy9xTgLaUOKMnTMiGeDeb7qy5fWt3CMRe35KGwCR
	 s1EmoqAIlES9A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A0B3930A20;
	Wed, 10 Jun 2026 02:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v5] ptp: ocp: fix resource freeing order
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178105980539.2805596.14452078462884649454.git-patchwork-notify@kernel.org>
Date: Wed, 10 Jun 2026 02:50:05 +0000
References: <20260608155952.240304-1-vadim.fedorenko@linux.dev>
In-Reply-To: <20260608155952.240304-1-vadim.fedorenko@linux.dev>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 pabeni@redhat.com, vladimir.oltean@nxp.com, rmk+kernel@armlinux.org.uk,
 kuba@kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  8 Jun 2026 15:59:52 +0000 you wrote:
> Commit a60fc3294a37 ("ptp: rework ptp_clock_unregister() to disable
> events") added a call to ptp_disable_all_events() which changes the
> configuration of pins if they support EXTTS events. In ptp_ocp_detach()
> pins resources are freed before ptp_clock_unregister() and it leads to
> use-after-free during driver removal. Fix it by changing the order of
> free/unregister calls. To avoid irq handler running on the other core
> while ptp device unregistering, call synchronize_irq() after HW is
> configured to stop producing irqs and no irqs are in-flight.
> 
> [...]

Here is the summary with links:
  - [net,v5] ptp: ocp: fix resource freeing order
    https://git.kernel.org/netdev/net/c/627366c51145

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


