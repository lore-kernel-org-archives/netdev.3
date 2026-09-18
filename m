Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633BE3624DB;
	Fri, 18 Sep 2026 01:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789693280; cv=none; b=DAWCpwwi8ytVU4c+1xyCGreZwlhA5QpEsiNfaZvj7X/4rMrDJm1i0XsNWnrO7pJD30pMGb3sCnBjATL1pwOnoV+NU6wQL5nebJQwpAcJ5pVoaSe7cx+mklOTi8vjH3SL238ArO4HKPOjOKjK3RzgXDHqxgkbKAe3aHeeVdmwvj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789693280; c=relaxed/simple;
	bh=xhKMPU9Tt1PJ01m+rlI4+yuoY0qMLBilnC0JuxzGyjk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ta9CUcSfEzYJNdSoBYUPRt+5CdBHEfeclw5Jv/dfSO5HDt5pQI2WWQkG6lQrB29YobCbHUJ2onXo4D+vLl8xU/NLt0inxHfiPxftHbANUdfBpooO5QxYtE4Ruir5JrXxfFWKyto36iZ7yrHS8dveknSSPlabGzyJ51Gjl4X8DZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ARAcB6MF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ARAcB6MF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC9F21F000FF;
	Fri, 18 Sep 2026 01:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789693279;
	bh=iSORypKsH95nFL6MzWxYE3lj6mY5UYNtZIbcPdcX6CQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ARAcB6MFNzJBgT4KnaUtm0+OPD15Lew4YynY6iHweTxH7PHmKYD5MUAZFmKH4lDAs
	 1f6mzc9vY0JuvD4SBZ1WQdRo62mscRnZ6+FG7T5LgtTxwoTrD1yDoTxph7Yy+nHd0u
	 hq/uvs1KJxwMZGpj/jyq7avAPE7FWrNLyC8QsY1dj6OEFHQaLF21Ygiv9BKcUmwGOL
	 URqsgrZ9u/D4GDeRxj+q2KywJlyu27aZlSfuwPeEzpKtN7txhNV+b7L+zyEB35paaB
	 gzKtvJ1fLgyE6LNLpZGsP5P51+LO1eKWUvLWSr5/g5YKhxgsKvkTNquyYmKUqjB+nu
	 cD4CK4SOpm4dA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93AC9380820D;
	Fri, 18 Sep 2026 01:00:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Documentation: net: dsa: Fix bracket
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178969321212.204321.7004684428104055282.git-patchwork-notify@kernel.org>
Date: Fri, 18 Sep 2026 01:00:12 +0000
References: <20260916123458.314458-2-manuelebnerli@mailbox.org>
In-Reply-To: <20260916123458.314458-2-manuelebnerli@mailbox.org>
To: Manuel Ebner <manuelebnerli@mailbox.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 16 Sep 2026 14:34:52 +0200 you wrote:
> Add missing ')'.
> 
> Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
> ---
>  Documentation/networking/dsa/dsa.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - Documentation: net: dsa: Fix bracket
    https://git.kernel.org/netdev/net-next/c/a0afc297a048

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


