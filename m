Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490D929A32D
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 02:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781575218; cv=none; b=jjD0OZbRhdDydOEPLlthAnMmyNl9nu0tYLImVNADwxyAEvwmzvrJlnAyovvqDDdHNtyrxLKFbOhe9tNYMUnlOUZ8YhmyX3q3MTjkNJl4Xf+BDYIFEachm68rhKP6eaXbFEaQ7vq5d+fiMM8djKQdvLIT5At1yQ/YBK+Fy2JTsUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781575218; c=relaxed/simple;
	bh=vEXmrfg1nMKnX1qx0w1Haz2dk+Kz0b115ABhkLNtdxE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uTcmd8TfZ6FVZmmYtYDlOjO8E3a3vbZ6SuLLVq3LDjMq8YhlqrDEuNjk2wzSwPajsFdMj+xgQ6Q6v6SdXf7M3wSO/Q0Xvr9H8MLZYw0clL4m1/NMRetPiW27mezGxrB+7J178PHP3/8Kf1Zm07meqSeuHYJvENKxoGc2xjDznPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ir+4DNhe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ir+4DNhe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E651F1F000E9;
	Tue, 16 Jun 2026 02:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781575216;
	bh=2+yws9DwwwmEPbNFXXWWmYjeE0HrGhN3GF/HkiC+mCc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ir+4DNheXUTxi6iTLiSOqfigpDv2EcJsknh20CH1r2o1WyNvVyD9IVPT9rzZ6zMfr
	 e3/+KLvS642SiS6upYhDyhqHQCMCTW7tZb6loYIYDlivvHGvRedjCLVHhD5sP0MQKk
	 IC27xPgKJFimJcD93wN9bEDei0wLVVlwa78qx6Hd/iyvBHPZGvQn8EjXU8fdEeNiyA
	 vm9196vJgw6tcliabKlciU0S7nRpyITiA0r2doiDfUSjMeK3i76N0nkDs8HZ+wbFO0
	 ofhLu+2gNSVX5SvTUdhlY9XRVgcY4m37pUM6Ky/GXfZlut5klvoQCa+ZNy3iJAwBUJ
	 TEOcvMIaX2PpA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198F43839A26;
	Tue, 16 Jun 2026 02:00:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/4] Extend netkit io_uring ZC selftests
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178157521163.385458.4898169417299272969.git-patchwork-notify@kernel.org>
Date: Tue, 16 Jun 2026 02:00:11 +0000
References: <20260614102607.863838-1-daniel@iogearbox.net>
In-Reply-To: <20260614102607.863838-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: kuba@kernel.org, razor@blackwall.org, bobbyeshleman@meta.com,
 dw@davidwei.uk, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 14 Jun 2026 12:26:03 +0200 you wrote:
> Small follow-up to the HW net selftests, in particular to add a
> selftest showing that also large rx_buf_len for io_uring ZC is
> supported with netkit queue leasing.
> 
> v2 -> v3:
>   - rebase to latest net-next
> v1 -> v2:
>   - Switch to cmd(..., ns=cfg.netns) (Bobby)
>   - Add mp_clear_wait for large rx_buf_len test (Bobby)
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/4] selftests/net: Move netkit lease hw setup into per-test fixtures
    https://git.kernel.org/netdev/net-next/c/bc5c25c8f684
  - [net-next,v3,2/4] selftests/net: Use public NetDrvContEnv API in nk_qlease fixtures
    https://git.kernel.org/netdev/net-next/c/96fda937b4c1
  - [net-next,v3,3/4] selftests/net: Add netkit io_uring ZC test for large rx_buf_len
    https://git.kernel.org/netdev/net-next/c/5024cfc8a37b
  - [net-next,v3,4/4] selftests/net: Add hugepage kernel config dependency for zcrx
    https://git.kernel.org/netdev/net-next/c/74ac711839a1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


