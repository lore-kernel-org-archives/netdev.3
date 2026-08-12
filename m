Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B0C370D4D
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 01:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786498888; cv=none; b=VGUfNBpm/fQwg8NbOKw8k/DAkzwOqH734KOWqkEzqAzxHT7isuyPl8C+ZvNolu71Ol/uLYCVD1ulgfovQBfhlefCz1z8sYLZnVGRgVtRUSUfbYf5P0quhmjDFF2Vm9uVMbHd5bPZdUmCpv2mjTv2iSrHY7SCOWfxp0cAAEbIqBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786498888; c=relaxed/simple;
	bh=abjt0/zStOi6/NfQ5AQNzoFqbfebpg65RsBj4KpDAkM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rZGatW7Fia1AbT84hCJYbDTo47gnHLpLtG51XnbWUXVbR1z/9kvmVJ2Pf7twmcz2g5QsLw5lhob5GZHsm6o7W5JASagMmSJWJ/RPM9o7aQQZzvD/5MXzH32Jk2gSN2Ay9TQAOVQkIK/BvHP+sj7tHD5ZB96ihKkAeva4CKjxCtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WOV4c1i5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WOV4c1i5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F0D61F00A3A;
	Wed, 12 Aug 2026 01:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786498887;
	bh=ditGbQ8LcITH0+TgcmyHndM0d7ZNlm0PM5jqHj4C8sQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=WOV4c1i5lm+7GCLj3CPzZhWFpELI3NAsKkj8TY4BoVgew7L9Ev9p8sHmz2xrLxAW/
	 SEt0ZfXdL1hlRNhzspKpynOmHuABps4JzxJB/G3gQXriUXgaMI7IeiVqWwPxi1FIgd
	 a0Ggxv+bsml5+XjJgmaJHZd5xoiy8BPL9hrbwpbZYQhTEW0WUFAzASfbXlhgNa6/T5
	 biKk/b9d1wJ6wD4tyRq1FiZ7jTQOndUwGDUbYpwZO1EEzzCU/dQsdCQe6tanDTAHBd
	 isjwq2ayF+IrtTKNS8QzgGE7RufM2e2vzHjUS3YGt8ukCGIZBQZ3bmjQvoqpn32ihh
	 AAix+/7P6NKmw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939A83809A3C;
	Wed, 12 Aug 2026 01:40:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] bnxt_en: enable PTM function
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178649884313.1230679.10484570162666134870.git-patchwork-notify@kernel.org>
Date: Wed, 12 Aug 2026 01:40:43 +0000
References: <20260806201849.3161402-1-vadim.fedorenko@linux.dev>
In-Reply-To: <20260806201849.3161402-1-vadim.fedorenko@linux.dev>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 somnath.kotur@broadcom.com, andrew+netdev@lunn.ch, kuba@kernel.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  6 Aug 2026 20:18:49 +0000 you wrote:
> The patch mentioned in Fixes missed one main point of implementing
> proper PTM support. To make it fully operational it has to be explicitly
> enabled. Add missing call in probe callback and disable it in teardown
> callback.
> 
> Fixes: c470195b989f ("bnxt_en: Add PTP .getcrosststamp() interface to get device/host times")
> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> 
> [...]

Here is the summary with links:
  - [net] bnxt_en: enable PTM function
    https://git.kernel.org/netdev/net-next/c/5838193edcca

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


