Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E6A275AEB;
	Mon, 27 Jul 2026 22:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785192043; cv=none; b=nLTdLyDB+lolkHB7yOHOBhnvADqXYIZK/8RoxmyBcHPIXWjSf5A9NEC7Rt51bz7/ij3l2CsmI/HSnlVYMDMWVBPQlQVCIW/80767w6a6eq+Cmuqyl+++42RZjKxuW1XcJmber/wXJrxUW5o9xvh1LZuu6Xoiy3yCTS0KQiyuW/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785192043; c=relaxed/simple;
	bh=1n9UPqQH6Ue6BORHOdJyp3+frqGhEWrLdGIKYR6oXXk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=o2C3f2m5SJm7SMEWvCh//gqWd8qqLInFu2z8cS5t3vl5Zjh4MU03bkfB8R8eFXweC9q+rf46j1w7ddRza8qJs2AAgPD5e6REkOp823ElguNkjiwbAUU0k69RAQS8gGT8f31QUVg3/CrMHlgaN+ep0ExX//6oBi8DvluTLwr2qOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g7ebtjJg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g7ebtjJg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D33D61F000E9;
	Mon, 27 Jul 2026 22:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785192041;
	bh=SPxWThgAif4j7FQiVAM1dayqvQknIuOutk26osiIhaE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=g7ebtjJg8NJpHBRsTEQWP/eWd/EPBWl8gRqf2Gcb+GpEX4gmu4doQIyA9cNUfdn45
	 PCdBoFwrHnvQzgDWChJAIJM/JvEvrs+2DrUB0YoH/CvYLU7nfqHP/36shZksiSanJ6
	 D97fKBABVhOAMzsZw0yt3bGaDuHPqHGR5ozpJ/Di6Y+eU5EzPajSm6CuzXItcIHJmQ
	 ctDzS+DeujOpMIiaRWmJSFWLzVZmmxL9sbyQZUYGTLHPkUgadOUo8S6yd/XekQVkQg
	 Rxrqd50awRl8gTGvtDVV53eAdRKqS+vHEoKj45KNhoRReZ55KBRius9t45p5UYLuI6
	 BqChjpXSe+3jA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56823380CECF;
	Mon, 27 Jul 2026 22:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] unix: use kvmalloc_array() for BPF iterator batches
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178519200690.1443317.6277614677776965399.git-patchwork-notify@kernel.org>
Date: Mon, 27 Jul 2026 22:40:06 +0000
References: <20260716025103.118200-1-xiongwm2026@163.com>
In-Reply-To: <20260716025103.118200-1-xiongwm2026@163.com>
To: Weimin Xiong <xiongwm2026@163.com>
Cc: kuniyu@google.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu, 16 Jul 2026 10:51:03 +0800 you wrote:
> Use kvmalloc_array() instead of open-coding the element-size
> multiplication when allocating the Unix-domain BPF iterator batch.
> 
> Signed-off-by: Weimin Xiong <xiongwm2026@163.com>
> ---

Here is the summary with links:
  - unix: use kvmalloc_array() for BPF iterator batches
    https://git.kernel.org/bpf/bpf-next/c/3c6e8a37eff1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


