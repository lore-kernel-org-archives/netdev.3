Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E4C304BCB
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 04:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774411822; cv=none; b=IENdRZgIqk6qp4xmJWnXf3XGkIL//jAgBzwF8vqR72AGdLfhaWTKvRgetxFPOPRXClusAj2ALCjXDQNsUb78Q9+NfhhTvljkX7DUichAIT6wP8VH6NC1WwSJzQTfGk4XwfjLTd4kGYNmZmTRZBLqKzeTRqcfHiQ95J2JH/PEfE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774411822; c=relaxed/simple;
	bh=jYKfzvh+GY2opyJ14MTi+0lboEJgdj+Pqs/mGQs/j2g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IpVjVx0ITit+YTP+YhKYeqexezNWMdxXIcLkl/QehpNyezo7KP7rDNfwUcZqlAGA/9IKJvQX97sOJ1Nr4tCchQqcwPGrVkNnqCz3mwc1bp0BO6ObhZ1dePzDhJHcUtTxbB0ZxnHpE6DwczEMtmbSeBLL6UigeZL9MXtI+u+vC+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ST/pPAuk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ST/pPAuk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76173C2BC9E;
	Wed, 25 Mar 2026 04:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774411822;
	bh=jYKfzvh+GY2opyJ14MTi+0lboEJgdj+Pqs/mGQs/j2g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ST/pPAukANm/Na+4AaFAR0gYtEAqlx/gWi1KBn23xTeqhoEVa8mMDExFawWL6qLqn
	 avRKywALQi5+CMrLvJmk04dDZ3IQUdmIGtvnyMEcJZatiy5+cCDlswjwnR+sYCULM4
	 XItuaJlN4J3pRgaqwYnD8CqiYeiSvUtlEuRgXrW9TIOR8YSqSHLVmGqpja00jIFHR+
	 dAU+mEpLa4vxdfkdF4ZswoxXeIzpkqmosGCYNcylGyNgV7lGJdynIGvH9dbG/WpdUr
	 YzVgqYr1NEUAgaDBG4n26axyqcrnfvqJRAYkW4iz7LgwN++izgq7up0hHxgZLzgcBl
	 3jmb6HgdRaxVQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FF963808203;
	Wed, 25 Mar 2026 04:10:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] rtnetlink: fix leak of SRCU struct in
 rtnl_link_register
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177441180978.1422230.12088697952037517136.git-patchwork-notify@kernel.org>
Date: Wed, 25 Mar 2026 04:10:09 +0000
References: 
 <e77fe499f9a58c547b33b5212b3596dad417cec6.1774025341.git.sd@queasysnail.net>
In-Reply-To: 
 <e77fe499f9a58c547b33b5212b3596dad417cec6.1774025341.git.sd@queasysnail.net>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, kuniyu@google.com, kuba@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 23 Mar 2026 16:19:43 +0100 you wrote:
> Commit 6b57ff21a310 ("rtnetlink: Protect link_ops by mutex.") swapped
> the EEXIST check with the init_srcu_struct, but didn't add cleanup of
> the SRCU struct we just allocated in case of error.
> 
> Fixes: 6b57ff21a310 ("rtnetlink: Protect link_ops by mutex.")
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
> 
> [...]

Here is the summary with links:
  - [v2,net] rtnetlink: fix leak of SRCU struct in rtnl_link_register
    https://git.kernel.org/netdev/net/c/09474055f261

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


