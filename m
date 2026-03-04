Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2745CF513;
	Wed,  4 Mar 2026 02:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772590206; cv=none; b=byaGDHttw0TL7Ic37WzPKWubfIrkE9H8pKDUeCdGfMcR0cwkHzJehgSCRvrmOhwFhb6PNRQlQKCyi4hFmjuQ4xTSg7htuau2dP1V0xqNq0S4/9FrTHFJtbs2hyXTLPvbnvm1I/QGM1L/hP4Q75bbJyK2Qbx9dAB9u6Jv3mQG+gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772590206; c=relaxed/simple;
	bh=LI/2cEsKO4qwLnP8tIB5hKLxIi93BAdIARtRPbLy+Lk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ESGAy/lHAR8CxncumwTz2HsYxdvzbuoQHzuBLMKHQMVj/yf8sgx64jcVwrn4wOW80p5dWUga7u0CN5DwkcrUxiJtzhHKNody7owQF7qYuaBRyJG01BNsQxCKTAf9aNcjJwoop6RiFFZ4mNe2MIwolTeXUpYEyJIOjHPx8eoXWRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qawm+QrK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qawm+QrK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4743C116C6;
	Wed,  4 Mar 2026 02:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772590205;
	bh=LI/2cEsKO4qwLnP8tIB5hKLxIi93BAdIARtRPbLy+Lk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qawm+QrKgTHQLt5ZFBYmRDg6qaLf1MpWcTgYBzBgKztp4vmf4IXgswliXgO4VMQN6
	 zLMbIa2Th/UWzsf9B2+WwzPIAHBZOEcdXhKCT1gbokSBIv00k51lF4L0RxnIZMOKRT
	 /gRLBIa9b9XgdjhPdVwIUadw/dBxQiPjo4ShCow5osO6ftDS9AQYyu8DXbU8FD3xjk
	 xJB4l+3Y43SR1DfXB0ncDMfqcaKm7E/k8T7hORxYH2KEjRkH+IO7fQIQvDzI097rxC
	 SxLoOrjlgUTtC1nOEZAWxgsaQQjz3qpHbrg+a8nqvUDD57RM1XUndWjaYUiCzLEfxq
	 B7C0gRHzHzqCA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02DE03808200;
	Wed,  4 Mar 2026 02:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4] net: core: failover: enforce mandatory ops
 and
 clean up redundant checks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177259020680.1558550.9680037756049177814.git-patchwork-notify@kernel.org>
Date: Wed, 04 Mar 2026 02:10:06 +0000
References: <20260302064317.9964-1-zeeshanahmad022019@gmail.com>
In-Reply-To: <20260302064317.9964-1-zeeshanahmad022019@gmail.com>
To: Zeeshan Ahmad <zeeshanahmad022019@gmail.com>
Cc: sridhar.samudrala@intel.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 horms@kernel.org, dan.carpenter@linaro.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  2 Mar 2026 11:43:17 +0500 you wrote:
> The failover framework requires 'ops' to be functional. Currently,
> failover_register() allows an instance to be registered with NULL
> ops, which leads to inconsistent NULL checks and potential NULL
> pointer dereferences in the slave registration paths.
> 
> Harden the entry point by requiring non-NULL ops in
> failover_register(). This ensures the 'fops' pointer is guaranteed
> to be valid for any successfully registered failover instance.
> Consequently, remove the now redundant NULL checks for 'fops'
> throughout the module to simplify the logic.
> 
> [...]

Here is the summary with links:
  - [net-next,v4] net: core: failover: enforce mandatory ops and clean up redundant checks
    https://git.kernel.org/netdev/net-next/c/d6ca199568c5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


