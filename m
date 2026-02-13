Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5470347C7;
	Fri, 13 Feb 2026 02:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770951019; cv=none; b=LcWBAarfwrZ7fa7UW+PMkxwEWoTMbbiOwtWjmyRSNmg9rP3H2NZV5KPUiV0Bw1kx6S7CBj8XE1RRHN3YzVouNNhLmkfaNnvs/RoetTK9vCiZ/jM4OLSyZ/BnRmkwZIackQBFveWH3ewhU6Is4xTNmc9KDR8aArUg3e0B164ID+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770951019; c=relaxed/simple;
	bh=a4dcIPI5bc3ns8GoD0kP3vv75/MQpGeLDkm0Wfvh1/I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=R+kWTqiej8gTJPOH7dqx8EReFMMYhDGLp6I1zto623z3KdSe/Lom3p3AE00OBMFsWyglrt4MdBHzabNuvxvq7wb6n1befjJd/2r67UoPyIRR8heFCoUbozMpEeURFyO6DAOEnLFnY6JaAVcV6NCQdgCEqdI163TTQdhZ/oJafKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rM7I8u5B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rM7I8u5B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DF54C4CEF7;
	Fri, 13 Feb 2026 02:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770951018;
	bh=a4dcIPI5bc3ns8GoD0kP3vv75/MQpGeLDkm0Wfvh1/I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rM7I8u5BHF03mTKOWzVqx3fpJRlHiH7SmrlJuYE14I9ye0RSMq2f+K2UGdrS0nBWZ
	 sUbomiBPXwy28aQivZiztgDF3ERxBLGqst34BGUcBSUib+iIegcN+yy6wJeieCWqy/
	 OSO0FYD4Cmych1LO4Oh2UXiN6K5Ei/Zpguukv37AqKDEukWe+0fsoyHFIvy6QORUxS
	 Qs4jb40UcNP3Hvjk7fw7W283jJC9p29Ei1c1d2SwqwiEXkDS9bF5jbyJ+ZtWouBGqH
	 B49heHFsg1FNwkpUdr+I8FPtv37AWCLzM05BecH8cDh1HDLs297CIh2pnVfsxcsCFN
	 DFLqRa5LBS+YQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C23DA3931093;
	Fri, 13 Feb 2026 02:50:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next] bng_en: Remove duplicate include
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177095101232.1819996.3801611459080724370.git-patchwork-notify@kernel.org>
Date: Fri, 13 Feb 2026 02:50:12 +0000
References: <20260211032021.2719742-1-nichen@iscas.ac.cn>
In-Reply-To: <20260211032021.2719742-1-nichen@iscas.ac.cn>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: vikas.gupta@broadcom.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Feb 2026 11:20:21 +0800 you wrote:
> Remove duplicate inclusion of <net/netdev_queues.h>.
> 
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>  drivers/net/ethernet/broadcom/bnge/bnge_netdev.c | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - [net-next] bng_en: Remove duplicate include
    https://git.kernel.org/netdev/net/c/fe6515f5952c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


