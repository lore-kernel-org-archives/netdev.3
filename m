Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2471121E097
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 00:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779929403; cv=none; b=onp3n+7j1b09dTZub0e1vrfgVNytquySi5X9+xHC/j7b8M/AEHmMuhVMAur3BkLYI7HRau+uEAdpfJWq5mDB6gXQbnwFfIooi/neDU0zfrOwdxJDICrkroqHwnZ+f7fIR6YBEcHf0DTOe+RQWSmoq32WXCzH5xzJ6b3zQbSwUPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779929403; c=relaxed/simple;
	bh=pT6uoE6Oqf5GNB5FJdKfwImYyJM8qnQs0dy3TZ/i/Q0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Uzj+p6a5keDiz0eUhAGT/rMoe1y7WVIHxD5L53WVqpL7aBMn6v3KmY/b5+7Ue+w7B9uYH2W9FsEeGu47U7bj6HdVUtZ4dIjUQ1gjZpYL/vuKiy7RGb+QydcF9ZCJEzJCWrZo+n1wILMXeF73i9icqz0O0hZfs9zd9fjeqMNZDQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hk7hOrcC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hk7hOrcC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BB811F000E9;
	Thu, 28 May 2026 00:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779929400;
	bh=JilAlvhTQR4Fns/WzNI4hUHEULD/eTtPpCYnVAmlcJs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Hk7hOrcCgmEYeQuKBm9SXvWYxR2hhEE6D1bPldDVRdNeBWwG9iUmDGpoZs7I4cH2d
	 PTfAi9nPjMp5PBnnbAAEz1e85E+FwwxxsJJ1BnmtGQcMHYPG3GXpaB95GNLyR2pIRo
	 nKGwJLDd70wi4UtXi4FS2vHe2VJPqeC1bOWGiKl5r96ioeAHG85ixcJaZTa0hSaSqw
	 WRJk6RVwvdGQ1GQTvSqCyKFamUKTMp6bcWNcttQbyl/rw5eU6rDs5JR/f7jr06ySH1
	 EyBc+JV/DfqhCyW5RlW4QWi+LvVWK5pEWLGoOCByrRalIt92e6yEFFOSItFnh+DXRu
	 zNVLxhslWOYTg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93B4F380CFDE;
	Thu, 28 May 2026 00:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: page_pool: check nla_nest_start() return value in
 page_pool_nl_stats_fill()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177992940540.700169.1846951496298474354.git-patchwork-notify@kernel.org>
Date: Thu, 28 May 2026 00:50:05 +0000
References: <tencent_A82EBAB365A8B888B66FDCF115A3DCB8880A@qq.com>
In-Reply-To: <tencent_A82EBAB365A8B888B66FDCF115A3DCB8880A@qq.com>
To: Zhao Dongdong <winter91@foxmail.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, zhaodongdong@kylinos.cn

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 26 May 2026 14:51:56 +0800 you wrote:
> From: Zhao Dongdong <zhaodongdong@kylinos.cn>
> 
> nla_nest_start() can return NULL if the skb runs out of space.
> page_pool_nl_stats_fill() does not check the return value before
> calling nla_nest_end(), which can lead to a NULL pointer dereference.
> Add a NULL check after nla_nest_start() and abort the message if it fails.
> 
> [...]

Here is the summary with links:
  - net: page_pool: check nla_nest_start() return value in page_pool_nl_stats_fill()
    https://git.kernel.org/netdev/net-next/c/36d0d876c45f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


