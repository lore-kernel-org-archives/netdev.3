Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C6423BD05;
	Tue,  4 Aug 2026 23:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785886849; cv=none; b=NyuHOGPZEBncWq/p9fDw6DARvMYwqbmnBsg6X8LqQ5oP7l+w3f5ERaLzEhD1nrVf4Mg9iRK+WtpKCXUydzBXthS9f2UE2t/2suKPhw8ThYrUGowpEefd9O9tY6O07pGjSCOVANiy7k73uETYEMnUjRZkIiM4dowkNDr1W9YXskQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785886849; c=relaxed/simple;
	bh=lmnHW96J01EwG8vhVQeIxdirEjdDjC2fco1qg3Yj0CY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=brgTZHMu3iIqgf5l3wh5aJ9OICgvwuPNQlQlukSqLAKajRltos553HcZPCJA/7qu48KUR3thE/FXAODBZxkN2yQgZmAtLqZb8XgO5rwfbK6aWNT8g5J98N1X3O1X2t03nTQuKTZR0mD81AxjWQ7uNlTtqpT7vbrIrkSe25M0EpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+0EzfbG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+0EzfbG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 468631F000E9;
	Tue,  4 Aug 2026 23:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785886848;
	bh=4/rpGrm0KTuj3qO8JIFF2+Wbg9RlC07mCtV6ss1M6FY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=L+0EzfbGnKJic0MASbQfA0GgvmBK9zcx0jaBIg4PV3UzC1MM4U0GHvJTbY//24MrS
	 ZToSIgFAAKIYE2GJGqDYTL8SrsU+QAcwnzDApZWFD7+3fVyluGzyM/jX6IBSbLr//0
	 W2ZxbxmTktB9r6nCC9GRwx+SEa6IJsgNd2LMWQZu977U6zaqpSp1RQzTDf/DJHOZxs
	 2jgcjdAl21/hleCOK69J/2DlmjcqvAIe3lvqvhOsyZg9XsIMlZ9Rd3k2XQLrjEyPM+
	 ZCpaaFHenPqYCeTVezZGD4svFC3yB56IF6bQPVu5Q3Uzkcofgnmm2TzH3AztauOfIP
	 9Ho7ilHDaoJGQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0AE2392664C;
	Tue,  4 Aug 2026 23:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] macvlan: require init-userns CAP_NET_ADMIN to
 raise
 bc_queue_len
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178588680839.3832654.17823545159620196508.git-patchwork-notify@kernel.org>
Date: Tue, 04 Aug 2026 23:40:08 +0000
References: <20260729200621.2521588-1-xmei5@asu.edu>
In-Reply-To: <20260729200621.2521588-1-xmei5@asu.edu>
To: Xiang Mei <xmei5@asu.edu>
Cc: thomas.karlsson@paneda.se, andrew+netdev@lunn.ch, davem@davemloft.net,
 doruk@0sec.ai, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 AutonomousCodeSecurity@microsoft.com, tgopinath@linux.microsoft.com,
 kys@microsoft.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 29 Jul 2026 20:06:21 +0000 you wrote:
> IFLA_MACVLAN_BC_QUEUE_LEN accepts any u32 and becomes
> port->bc_queue_len_used, the only bound on port->bc_queue. rtnetlink checks
> CAP_NET_ADMIN against the target netns only, so a user who unshares a
> user+net namespace, creates a veth and puts a macvlan on it can set the
> backlog to 0xffffffff and flood broadcast frames until the host dies:
> 
>   Out of memory: Killed process 141 (su) UID:0
>   Kernel panic - not syncing: System is deadlocked on memory
>   Call Trace:
>    vpanic (kernel/panic.c:650)
>    panic (kernel/panic.c:787)
>    out_of_memory (mm/oom_kill.c:1166)
>    __alloc_frozen_pages_noprof (mm/page_alloc.c:4914)
>    alloc_pages_mpol (mm/mempolicy.c:2490)
>    folio_alloc_noprof (mm/mempolicy.c:2591)
>    filemap_fault (mm/filemap.c:3565)
> 
> [...]

Here is the summary with links:
  - [net,v2] macvlan: require init-userns CAP_NET_ADMIN to raise bc_queue_len
    https://git.kernel.org/netdev/net-next/c/1a930d5734b7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


