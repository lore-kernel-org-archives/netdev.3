Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA0C3D5C07
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 23:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781306416; cv=none; b=NBNeuA3RdADLKNeLFNU2o3Cm4aJCukQYo9peQSbsA7O8HXMkYsykKnaqYVA5Rcl8XcMR3qky7nNpQ0ar7upJw0DckHXx81sLLjAxhvP5k0yeiUuOynlzm4z3pbyX5ZoE0G7hV2DpIAAwLOMNNJUeoPcnsL85uJ1wyRnFXrIrktU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781306416; c=relaxed/simple;
	bh=YxtU4XUJSJFtaw3P4YaUyCGmk9ESMJGW7VFNKLUi6bo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=U+BMLQmP7DLqLaOXdxQcGjoVKPjaemRUKuSSX+RBMlbApGS3pS/xnAWSRHrXc2OIa9D7ykBVvwOvCM4P7xcLZZWNWYNqzafzX61b5BCswFGrwn5LvEvQMbVY+g/RmE+xw41dK3k/p5gGhaGATaoRENJ7+ctQqEzLGl54LtHB2oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PfRXj8pr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PfRXj8pr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B56CB1F000E9;
	Fri, 12 Jun 2026 23:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781306415;
	bh=f2E4ZVZmxgGjJe6bLJagnl4w+BbGvc2KZMMid0U2qxc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=PfRXj8prUxSvzr3CTOAKlmjMonB6UdfaYoO1iHp0/zh5iVuuQaDkml94chJgM6oSf
	 hG8/30taXbHQ6bu0yRXFBO/yDORxykjgvcRt4Tj4DZA/rILyTmNzbXF1vjhINXOkFF
	 U5Ncwsxh3gS+ZFOIg27BDpt5BYCG3JLEukA4hHuN+TIEQeYYHj49/7e60EBJ//V9Iw
	 nQOfRHtTUDfCl0Y2+KudnQNrqWItD3JNvZRSyVEAr2c4JXVoofDRzHRJFrbw5gyka7
	 4IykxEBocJF5rPRQtn+roS96dpPLGt+1Fv9ZDActzxA8VOz8OcmvrXQIjiUe8pPdDk
	 nJw1dk3Nd+CUw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9391C39E9601;
	Fri, 12 Jun 2026 23:20:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: ethernet: sis900: correct CONFIG_VLAN_8021Q macro
 name
 in comment
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178130641213.1287691.13481787190165825914.git-patchwork-notify@kernel.org>
Date: Fri, 12 Jun 2026 23:20:12 +0000
References: <20260609175656.20574-1-enelsonmoore@gmail.com>
In-Reply-To: <20260609175656.20574-1-enelsonmoore@gmail.com>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org, venza@brownhat.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  9 Jun 2026 10:56:55 -0700 you wrote:
> A comment in drivers/net/ethernet/sis/sis900.h incorrectly refers to
> CONFIG_VLAN_802_1Q instead of CONFIG_VLAN_8021Q. Correct it.
> 
> Discovered while searching for CONFIG_* symbols referenced in code but
> not defined in any Kconfig file.
> 
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
> 
> [...]

Here is the summary with links:
  - net: ethernet: sis900: correct CONFIG_VLAN_8021Q macro name in comment
    https://git.kernel.org/netdev/net-next/c/0182b218a074

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


