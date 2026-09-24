Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0293DB63D;
	Thu, 24 Sep 2026 03:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790219478; cv=none; b=C3NShrtLsXJJIxazIM0RvjGrXOnsxJ5N4VE3IrQRfy8SDYvoRtpNlaw2vaGGdCT8xydxZpMc2xu3NEbDLZoOGNcnfYy7FAZV6rEMmBLak6Yvw0i2YMKaHgYaJbQoMghmHI5OUu3X6LhmaXTJVwjZ615tO72rMzBOAiLSI234dJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790219478; c=relaxed/simple;
	bh=EKricWkaRbr6p1/raLmGsENwzyUBFhpj8g1yLQ785fk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EJaK0LxnrdNqdtE5JDrr/nHV9alY5uKT/LcnTMqI7LOxhCe7dQUgrhVRBPujxqkttHAZ9L1RcWH3O539+iLf3i+bSlsrk+yaD0peDGvuNA1mxW94wTsxbJw7MWY/XFoQ259ZVTeiFw1EXTBuOtvKZpSZHco6y5ugQ0b+eUXknsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HsTu4UVQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HsTu4UVQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94EFB1F00893;
	Thu, 24 Sep 2026 03:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790219477;
	bh=zv7v/cgTT8V2XeWuw5hohGz8KSmgFVTSAFiv4fNDxsI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=HsTu4UVQVEC3qhN2YvuTWbeROl6Ch4EqF2M+4NbOJ+1E1flsslqCrGpO7AGowGUkr
	 pXNysuhvUB+8ocgV3PK3KM3oM3KoFz3o+QlS3HZWxsJNqcYgnrJB/bV1G9cLTcBJpW
	 tgOMKvyuKKHTH3QydpKSdpzkYkK9xZMo6eb5uXMZIp/wDIc+GYemWVmRb89rCC0JE2
	 lfS3GyIWm3XWl7alfoBrg3CFye6Qx5NNjCv6OQD479pJ2uFvUd7aGk87CFq8cKfyLm
	 yxurYy26Hw2VlWVUO+ZMFbr1IhKyVhbV68abotoDogHmPX/V0zXBdDx1NLEUYcmWKq
	 KK15d790+hRtQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569BB39E9611;
	Thu, 24 Sep 2026 03:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [pull-request] NFC fixes for net 7.3-rc5
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179021940715.1297601.1934523831459977462.git-patchwork-notify@kernel.org>
Date: Thu, 24 Sep 2026 03:10:07 +0000
References: <adeaccc1-cc04-4bb9-a28a-61a61d75ba14@ixit.cz>
In-Reply-To: <adeaccc1-cc04-4bb9-a28a-61a61d75ba14@ixit.cz>
To: David Heidelberg <david@ixit.cz>
Cc: kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net,
 oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 23 Sep 2026 22:19:27 +0200 you wrote:
> The following changes since commit fd73f4a6659897191fa0d40695fe370925dd3780:
> 
>    Linux 7.3-rc3 (2026-09-13 14:38:02 -0700)
> 
> are available in the Git repository at:
> 
>    https://codeberg.org/linux-nfc/linux.git tags/nfc-7.3-rc5
> 
> [...]

Here is the summary with links:
  - [pull-request] NFC fixes for net 7.3-rc5
    https://git.kernel.org/netdev/net/c/90c2e97ff824

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


