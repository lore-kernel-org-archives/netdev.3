Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F0A30EF77;
	Wed, 15 Apr 2026 03:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776224829; cv=none; b=QAr9J9ZWSa1ySGOM0LvWoIEcPOs9oUdAvAfu6toQ8TmCpAyjCWqXDt5y7VwFNwgBTjULqe+qeAA/p3BaShpYFhMFtHvkzbjmuBKx4oiWJ5JN0YZ+s3uAXEJATw6rliy8eWIfMSQvKwzs/gbCRBFJqf9OGx+mYDOj6C5k+QUQugI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776224829; c=relaxed/simple;
	bh=vTQLmEU2QJ8QC88BUxkxuz4lKZC51r9vXV6RciCcqSU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FPR5QmTc8O9FpY55WbiyfZKyBAjO3nB9t7gmFvEGRiN8muu/mNCTAC9b+XWKyy2HFwNPLDWnOss/pG1WHG2b2ZH2yjSq1RIHEJ1sq+JhgENbLGeUdeXWrRdcfCIwGX6a3nkXJN5aWHAR97mSKkdljKSd4a9gIqU+Z7uV6U+6Z+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ge6yHjQp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ge6yHjQp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 085AEC19424;
	Wed, 15 Apr 2026 03:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776224829;
	bh=vTQLmEU2QJ8QC88BUxkxuz4lKZC51r9vXV6RciCcqSU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ge6yHjQpsujpJMUYSJh60RW8a32uHGqtIH1ndoo1z6uzzaNl5UpWTiBhahFskjOWa
	 MPOqzuUewdbM6NGGOE7MM+7VJiZ1hFOQDwH5n4oJys6DkObtHtVStFAtcvRDmFZnmv
	 XXJBI5nDYLat9mGUG28qU6XyTord5ao2kNzI68TDKYSOS9kN4V+T27CzqXbAhnG1Ti
	 i5NhrtVC0Vb3Bhx0DviK9Aeq9mj2GIoXCjDOtP26EjOGvePp/h1kDTS14XTdWYdOXz
	 xxEUA8abRqJvvjUOR6GMM/liCi48ML5IzxAJJ4CYpoax0/BQabWt80MCI4kZwQYfBV
	 FKhd2VSywIKaA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FC553809A33;
	Wed, 15 Apr 2026 03:46:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] Networking for 7.1
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177622479911.1597933.8403499739357682194.git-patchwork-notify@kernel.org>
Date: Wed, 15 Apr 2026 03:46:39 +0000
References: <20260414193324.1390838-1-kuba@kernel.org>
In-Reply-To: <20260414193324.1390838-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, davem@davemloft.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com

Hello:

This pull request was applied to bpf/bpf.git (master)
by Linus Torvalds <torvalds@linux-foundation.org>:

On Tue, 14 Apr 2026 12:33:24 -0700 you wrote:
> Hi Linus!
> 
> You'll see a conflict with iouring. The resolutions are self-evident.
> Redo what
>   222b5566a02d ("net: Proxy netdev_queue_get_dma_dev for leased queues")
>   1e91c98bc9a8 ("net: Slightly simplify net_mp_{open,close}_rxq")
> did in iouring, vs changes from:
>   06fc3b6d388d ("io_uring/zcrx: extract netdev+area init into a helper")
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] Networking for 7.1
    https://git.kernel.org/bpf/bpf/c/91a4855d6c03

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


