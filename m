Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E843833F377;
	Sat, 26 Sep 2026 01:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790385703; cv=none; b=ofTAWHfYhJ44eYdXy8QgqbJzEvTNk0ZlI0Uk3rXT2gRMUv80jbWcR8F89qPoY3romXWpdGh/v8+PQ1E0SCDaveG8St6I9mQVA2XZ3RagrBs6mgUAOHWgsuDx8QqmRyg8jo06VR0KttMn6lyiif0cCLixdHnR/Pult/ad5TzieLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790385703; c=relaxed/simple;
	bh=Use0pE32ogAwU5d8hr614h2vqMOADP5SCjyIMFKvfig=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=flBvFwuE7Yf6BH+cwSEBA1SH5t6dIQxzDmhMEKGuJTh6np7azwPqBb43JUscQ8z0eq+EBW/adklB1IqDXz2nhUkbFsMuHZxm4WcAppxajxHrkcihkeQ82KD2JZJV7CxJCnUhg9pXTGIo1lnGfjucWWwZuICpqVJeeslHBP4LgEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BB0V/Db0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BB0V/Db0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B35E1F000FF;
	Sat, 26 Sep 2026 01:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790385701;
	bh=QHRvdHFjekTFqVEf4zlIu+KVtV50cJSjDXCyBnzRDAM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=BB0V/Db0Hwh/5Un0oNkcjOIMOUxvN7wBoxJtu9zQdatjnmSgqwfOEom6ZMXrczGs8
	 eFY01SUvi8nZfyQ38q/8dd2auuMldybfmaRbb82rodt+kPfXqJOdaGOpDHsnSrFdIY
	 zuWa3e1fUIK0Q12oKQj4keVqpmIea8Nwu94VbTgWTu1AyIKupdHrcyNh3vkOXTIANT
	 GwRB2RVtE06NUzZuNllYcDPqzFiNyaVkbghmUPNXSotmr/fCK2JFsn1HnH5V+xGvOS
	 C/ubJyaQfh+0h/nFVcDVakHyOv5Y2W75Zgedd3MEr5BHbvZf6yqAWlSSFsqgpHE3vt
	 C/k+BagHq+vyg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56CC23809A08;
	Sat, 26 Sep 2026 01:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] octeontx2-af: nix: Log TX scheduler queue
 validation failures
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179038562889.3233155.15749156890016187840.git-patchwork-notify@kernel.org>
Date: Sat, 26 Sep 2026 01:20:28 +0000
References: <20260923033500.1752732-1-rkannoth@marvell.com>
In-Reply-To: <20260923033500.1752732-1-rkannoth@marvell.com>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, sgoutham@marvell.com, sbhatta@marvell.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 23 Sep 2026 09:05:00 +0530 you wrote:
> From: Subbaraya Sundeep <sbhatta@marvell.com>
> 
> Emit logs  when is_valid_txschq() rejects a scheduler queue
> mapping so misconfigured TX scheduler allocations are easier to
> diagnose.
> 
> Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
> 
> [...]

Here is the summary with links:
  - [v2,net-next] octeontx2-af: nix: Log TX scheduler queue validation failures
    https://git.kernel.org/netdev/net-next/c/3c21842f999a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


