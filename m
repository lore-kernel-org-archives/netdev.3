Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE1C3195F0;
	Mon, 25 May 2026 21:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779744601; cv=none; b=ZL6PO/lsQlVluLupj+kjEhpipUMKaAwRUUkxNceGG2yIQADcl3/IyZ6QZxMoDEvFcL0U8dze0bRKcd5JwzVhTXZ0KUIzApPhhA8vLm56Jyp8EiCJfrBexjfhF8+EWgM/uoxAkxjtCjlLBljMceLxoDUOuHqr7zmOpwijhb0PGnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779744601; c=relaxed/simple;
	bh=3PNCYyliCHWxqGmmAgRQY98P0pzMZiU3jdzRQIr26y8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TuPmWy2p3DTbzyA3Ggf7CxzeH19ObzfYRB5topwcwx/9rrHW1dff5F3KHF7Luu6dn1H4Ec3xoJ3zNabkGRNDadi5UnFhylyojk2NQwy3GJgwiF2G7uDTk+Dnw2Bc+XrRdq0t35eFZ277hFRL5sJucH4PGXA32SOQyOTjFGIFGlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/0jh2wh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/0jh2wh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C575C1F000E9;
	Mon, 25 May 2026 21:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779744599;
	bh=NK1t6TFFoo+dYQhbITIw8vatGsRI+lV1KaFx5qPZY1c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=D/0jh2whoNHe2LOpL4O1Hdpbz2bq3xtjUziuAVLxOexNpdbq4xlnAZ21qsn4kkv/p
	 P1QeEEhnzaPKycb2vm09NjJVYPw1JcXVBbZbke7UihG5iEbGRkY8+hmwZ8VfnXu+wr
	 gWKuwr7ZhaAKGj7j/A+MfzMNMdAJNM9YgN1m6oPh63rp/qnHydT8WrixZHSOHBKCy8
	 l0J64/tPF4X+YuvfDA9ekfIkSwWpA24CucVD/a9hFHR903A3aZOcv+A3kAgNk6wSms
	 PsCnSfqhpfVOUKEgojEaP2R+Roq1U0q1uLsjK5g3093M+5a8ojPZBhK2iayeMxRvaw
	 lATZXMvsNk+Bw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93D00380AA76;
	Mon, 25 May 2026 21:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: hsr: fix potential OOB access in supervision
 frame
 handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177974460614.3120854.888800455184302027.git-patchwork-notify@kernel.org>
Date: Mon, 25 May 2026 21:30:06 +0000
References: <20260523130330.61880-1-luka.gejak@linux.dev>
In-Reply-To: <20260523130330.61880-1-luka.gejak@linux.dev>
To: Luka Gejak <luka.gejak@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, fmaurer@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 23 May 2026 15:03:30 +0200 you wrote:
> From: Luka Gejak <luka.gejak@linux.dev>
> 
> Ensure the entire TLV header is linearized before access by adding
> sizeof(struct hsr_sup_tlv) to the pskb_may_pull() calls. Without this,
> a truncated frame could cause an out-of-bounds access.
> 
> Assisted-by: Gemini:Gemini-3.1-flash
> Fixes: eafaa88b3eb7 ("net: hsr: Add support for redbox supervision frames")
> Signed-off-by: Luka Gejak <luka.gejak@linux.dev>
> 
> [...]

Here is the summary with links:
  - [net] net: hsr: fix potential OOB access in supervision frame handling
    https://git.kernel.org/netdev/net/c/f229426072fc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


