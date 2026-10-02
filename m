Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A5825B0BE;
	Fri,  2 Oct 2026 00:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790902208; cv=none; b=RJ9xnzreGIVd36EEMUBnMNCpFr91hVorACssIFyhHMkeISTgUNyQ2uMNm/yJCj/LH1aC/ZzpgcM6905rsrUM2qYKkcv24nSYPRw+8/PtvIOrpk1nYuFEqP8VRuRkO3aq8ylEcl84qC21aVa/mx0d2QBrJCBVc+5eFI2W3bqKmCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790902208; c=relaxed/simple;
	bh=9xs3qkGea8qURLkJk9KUYWiVNtITyCBNoxjUQEJGdu8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=a9bFzbfJNHlbe9ekARwNkPFy1tNCQT+qRiFZ2g7U8V/nmIIPSlD76tLnknpmeKahPuPjH+uujmhY7VtaiWYjOc9Xy+F9J6kxgF3/t+3QkBzCOhTARChGOCQrJdoTtbJzRcY5ZgaIuq+71+QV54SNJ9nKvQlCqIxE48U/Ap/Mvkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XLe2Sw2e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XLe2Sw2e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 817671F00893;
	Fri,  2 Oct 2026 00:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790902207;
	bh=r2xlnrCag4DQX7J0+zPzOWChOgZMLUFMsCfYWdRoU90=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=XLe2Sw2eSl2uLDueQVOZAMvsc2NddsUPh4KkDUsm8Dh+dSbuGF0f8fXRWZtw+iPIB
	 WPZ2E2wVj2Il7+fdFGywVsS8Rbth7Hm12rDxFnhJlX+KqYhdNrCwhDSuDEHB6X4Q+m
	 WjaNe/J2daZ7LJ1d7mIxx+Sg1Z/m//4E/9FVpwovtNiD9AdojEYjtrb61c3nHI8WeO
	 LJpAFqlTjjMBeL962cr3N8bpKNfyVrYPDRuTtIPgOGspyA/YzRP4aawPQKzEQgPjdL
	 UM+4Lo9Rv/NXK3em6AKYcm8LjfZTVYKePsndSTlsSsONRhwuOJPM3YEuV86hGPFL1z
	 7cuRf88ScPZtA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 772B9381197C;
	Fri,  2 Oct 2026 00:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: octeontx2-af: quiesce devlink health work on
 teardown
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179090220617.3161824.3912138082480407859.git-patchwork-notify@kernel.org>
Date: Fri, 02 Oct 2026 00:50:06 +0000
References: <20260928134129.145-1-getshell@seu.edu.cn>
In-Reply-To: <20260928134129.145-1-getshell@seu.edu.cn>
To: Hongyan Xu <getshell@seu.edu.cn>
Cc: sgoutham@marvell.com, rkannoth@marvell.com, gakula@marvell.com,
 sbhatta@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 28 Sep 2026 21:41:29 +0800 you wrote:
> NPA and NIX interrupt handlers queue health-reporting work whose
> containers are freed by rvu_health_reporters_destroy(). Interrupt
> unregistration does not drain queued work. In addition, each reporter
> setup creates a workqueue in the same field, leaking the NPA queue and
> leaving no teardown handle for work queued on it.
> 
> Initialize work before later allocations can fail, share one workqueue,
> unregister each set of interrupts, and cancel its work before freeing
> the reporters. Destroy the shared workqueue once both reporter sets are
> gone.
> 
> [...]

Here is the summary with links:
  - [net] net: octeontx2-af: quiesce devlink health work on teardown
    https://git.kernel.org/netdev/net-next/c/1b7bc043cd1b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


