Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF683A256C;
	Fri,  8 May 2026 22:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778280661; cv=none; b=VdRb+0UeroNMXDqpxVNy1plESU1vAeCX6CwyuW0MoFqDzsZZOcyfg3WcawsePjPql7WumveR+IEZE+6XIJEFMJlNg09wYyq6JQY0K8wBVErhbUPCSvV4ht6biSU/y/eovvRSvgs6OzQHoddSlG8tv9zdCogKUerwAW1M57sMuLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778280661; c=relaxed/simple;
	bh=l9vAPzM8X0DzfK2oHVVmF+NJ4qIFO/fJ9ervAmQxrE4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZsqpkacT+DK5AbuvP9xn1e03qm7UKd7OGIXK5trAqI4oXbXGXbAoUrr09iHbtQyCEKQZ1Xfkc+JPfRClXiY1sczk2U2EcGPD/ZGV/cMwYG6yg2xBltIwKQVdFtZwoqoaboTVO7Dq3fchj1Ims5eZaehuv5YBU3kgpmNYuRSZOgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=td4VH4mx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="td4VH4mx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 635E1C2BCB0;
	Fri,  8 May 2026 22:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778280661;
	bh=l9vAPzM8X0DzfK2oHVVmF+NJ4qIFO/fJ9ervAmQxrE4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=td4VH4mx+12j0T+l8UIabqh4VnvhI2nSuqME62UGjwME9aKkmqmaH8U+57m30iK9R
	 ktFDMRoPQI4/qIewsfhomyB7iCT/1uvX8+gnLauIOqo1GdHm3KKiqEIVggFI7CULlM
	 17Glq9S8XZMJGkh3DjKAFtXKxUMqalLStL04FG3P+dZlAnNnKZkrhYAq5FLS9uluYi
	 QehwFFacyW2q4Cu5Zy0Was+kjeQWI7+UT4PxgZQk3iUlAafscKCSrJ08INm+9hGUbJ
	 kdJIRwj+X5MGl1RLB9jGvQK+YUVdqmlKXN3hMHPn844TVz/+Gvw/H9hr851IVPkfR2
	 LxbI5AwmnEIyw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02CDA38119D3;
	Fri,  8 May 2026 22:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] gve: Use generic power management
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177828060954.880817.417904741851911675.git-patchwork-notify@kernel.org>
Date: Fri, 08 May 2026 22:50:09 +0000
References: <20260506165015.641738-1-vaibhavgupta40@gmail.com>
In-Reply-To: <20260506165015.641738-1-vaibhavgupta40@gmail.com>
To: Vaibhav Gupta <vaibhavgupta40@gmail.com>
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 willemb@google.com, nktgrg@google.com, thostet@google.com,
 alok.a.tiwari@oracle.com, jfraker@google.com, maolson@google.com,
 pkaligineedi@google.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, aleksander.lobakin@intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  6 May 2026 16:50:06 +0000 you wrote:
> Switch to the generic power management and remove the usage of legacy
> (pci_driver) hooks.
> 
> Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
> Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] gve: Use generic power management
    https://git.kernel.org/netdev/net-next/c/e3c683c316f4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


