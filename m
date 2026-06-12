Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2523D5231;
	Fri, 12 Jun 2026 23:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781307009; cv=none; b=bZiEnEpNjsT6Ajr7QKo75PwxxigfxK3xHrBJouFfxKI1/1QGAmtJ9ALKJaHG8vHJff4d1Kh/+zBysMGMk+xpMFKbCidH0tZIIrX6DzoNvbqRi8ZNDEvxLujjPK2r18E/covpIt18UnYDanBTOJnGU50ek5jTeI1bU5R1J2KyEP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781307009; c=relaxed/simple;
	bh=eo+WUzg/att0IsnELRzgKAMYVi9fz/WMA0kSQQiyC8Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=s9SVXf2g5iAIi3JyuA4+aG1aljAAsIMrzKNqJk/GoF46jxdX9Lx6ESpbLsd6LZoAQB2k2KVJBZgtHcK6AIpIJFJ0WNk7OLz5RcCgKC7xG7qE4f8JR4QXktCuQ1EkcDcCs8doqugCj2tGRX/n1uobhqaQ/2e2BMdy/u2jgQ8Kh84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NPN4tdCA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NPN4tdCA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00B381F000E9;
	Fri, 12 Jun 2026 23:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781307008;
	bh=a78Ydabh7K/+xnyLol+3opjSmu+u+3N/j5nDh7dKSQg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=NPN4tdCAqZxDQlPMvjAFf0qo5Z6bIaSl9OFwVkzQSEB0uNFJwTRGX7ls+DN5NgP9V
	 HfPGiVHsk2VD3lY0HOj/YBPTKm5A/b6DGhlTN7DUgn3EG8ZaoQxPRrCVoPQmIBrAT8
	 M39e5dGfBv/qjmR80abj51X/+4IJMkINa9rDDX8086suYBWLLe0tIIb2jLQKeawXoY
	 jLGfE5BLpA8NU+GSLfcv23EVls+tvuMp9fBsFSNCq6tlVpk4T/1p71Ap1Ym/EJr995
	 /eDSAsvcdMRyIacZeBZ4Gx5EkOKh4P7RtDq+Esdb0OS5eXazaJY+0/nFRXEQtSd0aH
	 cxKi0g/3r3f2Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0ABD39E9602;
	Fri, 12 Jun 2026 23:30:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: hsr: simplify fill_last_seq_nrs()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178130700464.1289947.14178453595763880988.git-patchwork-notify@kernel.org>
Date: Fri, 12 Jun 2026 23:30:04 +0000
References: <20260609171545.1051322-1-ynorov@nvidia.com>
In-Reply-To: <20260609171545.1051322-1-ynorov@nvidia.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, fmaurer@redhat.com,
 bigeasy@linutronix.de, kexinsun@smail.nju.edu.cn, ynorov@nvidia.com,
 2022090917019@std.uestc.edu.cn, luka.gejak@linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  9 Jun 2026 13:15:44 -0400 you wrote:
> The function checks the HSR_PT_SLAVE_A and HSR_PT_SLAVE_B bitmaps
> for emptiness right before calling find_last_bit().
> 
> This pass may be avoided, because if the bitmap is empty, the
> find_last_bit() returns >= HSR_SEQ_BLOCK_SIZE
> 
> Signed-off-by: Yury Norov <ynorov@nvidia.com>
> 
> [...]

Here is the summary with links:
  - net: hsr: simplify fill_last_seq_nrs()
    https://git.kernel.org/netdev/net-next/c/8058d9755ecf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


