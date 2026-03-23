Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AF732C302
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 19:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774293039; cv=none; b=qtQEUdKF5KvG1X2frcRRokQ8K9b/EfShbfcUOedvs7AwQ8VvilyAFCq09wSCo9Nc4QJa1kQO0eUriCa2K6Actz/Ud+29mpkPjwC1Sd/eyPPyI1GvgsSfrNRUjH4LFKlxtKhdH7dXhVsHKbaHWyKTjAHWAByFL1qQtybL8GCI3l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774293039; c=relaxed/simple;
	bh=rpgxfqJaDDJ4keHv4qFxsCKI239xumfJ0Ns2FA8xyVc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tSAmARmNLkya1s/2N116aJHPBrftF54y+k2FznJKWR9mInkTyYzWThjvZxsw1LFVcwWUDcStny3c9ya/kjJsXp4EfearIaGzoeoq4LrT2tNJN/S3rgRKLz0MpG54XncxqmYOSxdFyQ4IwweyGLXAozny/ym5C9Qb7eUZH+M0kK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mQDapHdx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mQDapHdx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63B9DC4CEF7;
	Mon, 23 Mar 2026 19:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774293038;
	bh=rpgxfqJaDDJ4keHv4qFxsCKI239xumfJ0Ns2FA8xyVc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mQDapHdxs6EJHkR1yaQ9yJYYeRP9zKWJulmCX92wv3z2S51+LDIT4asJfKYvQmx40
	 01C6YNiXSyS4XbQ8OS1DCAoDTn+4X3Z3VEBqJ2Pl/mtjF3UfPDtAeOiHEnL0RznlXr
	 FXNGIzLEEy7wpRNLry/A3GpTrv3kEZckg+5D+EtxYRRfxt6eI+RVcVB+RTlnm/Ws1X
	 Q1ygJkJZAmqofVbd22zsujqU1FlpmeFd+NDYQBje09UXoqemAjSMPfI/Le/tYBNjKT
	 R6VIvjM+aUFbAty92QC2vt/WFUBpPYYnMNmc62WcggKkDw1rO80S2NBpU3TJwzv6d2
	 1kSCC1Y9BHwIQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02E673808200;
	Mon, 23 Mar 2026 19:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH ethtool-next 0/2] Pause storm tracking
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177429302653.275706.5732819511251471255.git-patchwork-notify@kernel.org>
Date: Mon, 23 Mar 2026 19:10:26 +0000
References: <20260314001737.494082-1-mohsin.bashr@gmail.com>
In-Reply-To: <20260314001737.494082-1-mohsin.bashr@gmail.com>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: mkubecek@suse.cz, netdev@vger.kernel.org, kuba@kernel.org,
 alexander.duyck@gmail.com

Hello:

This series was applied to ethtool/ethtool.git (next)
by Michal Kubecek <mkubecek@suse.cz>:

On Fri, 13 Mar 2026 17:17:35 -0700 you wrote:
> This series adds TX pause storm event tracking support and updates the
> documentation for the PFC storm prevention timeout tunable.
> 
> Mohsin Bashir (2):
>   ethtool: Update pause stats struct
>   ethtool: Update doc for tunable
> 
> [...]

Here is the summary with links:
  - [ethtool-next,1/2] ethtool: Update pause stats struct
    https://git.kernel.org/pub/scm/network/ethtool/ethtool.git/commit/?id=582ce2791d19
  - [ethtool-next,2/2] ethtool: Update doc for tunable
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


