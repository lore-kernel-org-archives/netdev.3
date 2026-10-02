Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3D246C83D
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 09:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790931608; cv=none; b=QsYfXnAMndXqhH96oKzvxGLSDLQnnEB6V3bK8Bb4/jy2Ga+r8cV/d9zPETm1ikh5FZzYUlJe/wB2tZ8Wp95ZIkwDuqYAlW/beiNuOB2bUWxtgvD/NtMOi8JGmjcMHtJQq7CBLAmU6XUFfkrKNtwARQ5DXpcmA4UtuVdSfacrbaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790931608; c=relaxed/simple;
	bh=p34nal+0hmeHWcwuvt+wLYCjxoceR9d56juJ07623c8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VLAYJXChzXSYotnmj6AosPNzwKdGQFWLfcS2CqEDnVFAQHm2p6AHJUE545vdrN7SApIrsC8WSvcJNwe3OEZTxFRfQhdruNLtPWWUNws5S1JzZaCtA0MXrdwPCYgzFeJ5zK2V2hcSnl+RF317BnVkP42oz5oqyId+xEGneolS4b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mgAKy3mT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mgAKy3mT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B2D01F000FF;
	Fri,  2 Oct 2026 09:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790931606;
	bh=R899i6fNNeLsnKDH7n4JBkpIJSaduZ+PASGdARFptkU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=mgAKy3mTg9mFuFJCIqoNH5MeBDpSlCJnp3QihfET4j846DNBwHOjHBN6xzJEdJ9ya
	 pEa5qTyBbXNsoMxYXz19Rug4vVXtUFB623QQFnie+WhGaGkcpF1puDd9G0gYRMmlg2
	 9QBSfseXwtXyDGa5VTY2f3u/49XyJEwwpjLf7UKqCJIldILH6Qiro1oUXuJRiySRsn
	 /Y+KGuLvcmMxKsd2QarNuZRGbQMNCOB72C7p2JaFCqV4tHOcukex7YeURoEqIovaGs
	 4we3OC7LizNYcxPHpDTtsKACq8hHubMJDff8DsOZa2KUkoim9Y0CYHIE/H8vq6aiSf
	 pNkAq8RrSF6Ug==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A30A38119DE;
	Fri,  2 Oct 2026 09:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] cxgb4/ch_ktls: disable softirqs around tid_list
 erases
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179093160502.3296213.7186270682457157246.git-patchwork-notify@kernel.org>
Date: Fri, 02 Oct 2026 09:00:05 +0000
References: <179070264839.12871.11715792321728503844.idr-bug-51@gmail.com>
In-Reply-To: <179070264839.12871.11715792321728503844.idr-bug-51@gmail.com>
To: Sang-Hoon Choi <csh0052@gmail.com>
Cc: ayush.sawal@chelsio.com, netdev@vger.kernel.org, lcy8047@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 30 Sep 2026 02:37:34 +0900 you wrote:
> chcr_ktls_cpl_act_open_rpl() inserts into tid_list from the receive path
> using xa_insert_bh().  The array is shared by the adapter's connections
> and initialized with XA_FLAGS_LOCK_BH.  However, chcr_ktls_dev_del() and
> the chcr_ktls_dev_add() error path use xa_erase(), which takes the XArray
> lock without disabling softirqs.
> 
> When cleanup runs with softirqs enabled, a receive softirq for another
> connection on the same CPU can interrupt the erase and spin on the lock
> held by the interrupted task.  Use xa_erase_bh() at both sites to match
> the insertion path.
> 
> [...]

Here is the summary with links:
  - [net] cxgb4/ch_ktls: disable softirqs around tid_list erases
    https://git.kernel.org/netdev/net/c/4c9dc0faca98

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


