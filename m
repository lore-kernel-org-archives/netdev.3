Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18ADC23B632;
	Tue, 24 Feb 2026 01:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771897202; cv=none; b=ewRQK2IBcWau12Pu+6GKCyVy+znLCyHa09vW7zhpBFY6BuOQx+zfxMu6X9KJpd2Cx0YWilvu6WIo/UKLXL5rCvQWEbgliIgYjHzBCE+Hv7qCOlgEH8oedLNrf4DtK7Bl4xwrsFh2YzFLOXN7H9icghZ7F5TndlqEVT+9pc861dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771897202; c=relaxed/simple;
	bh=9d13LfFAJlCjfN5rEwceGsgcKdyz2nR+4uFrt8xRH/A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HDANKeWp21Ms3QXWDO0C+2uyCoKw0negIiius1zo2ycB3EFsT9FUU07ZjJ5Tudi4YzL8a4/5TjLDrdLk3pjhJAFTvzu1SgQ/7HEn7KYGp/qdOPEypp0JOMukNtddu4SUhJTUq/q+Hu3L2AOt6IDcPGcAo96C9T3wA44ZWlyDpb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dKeFQONn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dKeFQONn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3D2EC2BC86;
	Tue, 24 Feb 2026 01:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771897201;
	bh=9d13LfFAJlCjfN5rEwceGsgcKdyz2nR+4uFrt8xRH/A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dKeFQONn0zM5N06Y/Qmscbv9EaZJyYGgJfLVc4qfC/Se1d+8NOjZwNLRDIunos9/K
	 CS/ENSktQxSBb4EDl1TTHBVp7UktxTyNEPbYU3/Hlo99z1aBufi854XkzM8usFXSv8
	 K9LxKDgjHM+O99V9mQiBCUgP9Isx1sr0grtK6uAKlhZx7ynk0JMKR0Uwn1PYtmV8+O
	 uHgDRJcajvHtMRAe2sDBqIww7IpBmlXkuPY36kO+FfFsJEP15TVanHfHlnM9Z9eYR6
	 JLEpCTNeYHPLWH6YA2n1zoMEiMd/fM50jKURig07z8ezzrumQdhpTRSDsLnMUT+iXo
	 e5dKfiVvG1EoA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02E453808200;
	Tue, 24 Feb 2026 01:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] dpll: zl3073x: fix REF_PHASE_OFFSET_COMP register
 width
 for some chip IDs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177189720779.3267776.3948157481591432271.git-patchwork-notify@kernel.org>
Date: Tue, 24 Feb 2026 01:40:07 +0000
References: <20260220155755.448185-1-ivecera@redhat.com>
In-Reply-To: <20260220155755.448185-1-ivecera@redhat.com>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, horms@kernel.org, Prathosh.Satish@microchip.com,
 vadim.fedorenko@linux.dev, arkadiusz.kubalewski@intel.com, jiri@resnulli.us,
 pabeni@redhat.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 20 Feb 2026 16:57:54 +0100 you wrote:
> The REF_PHASE_OFFSET_COMP register is 48-bit wide on most zl3073x chip
> variants, but only 32-bit wide on chip IDs 0x0E30, 0x0E93..0x0E97 and
> 0x1F60. The driver unconditionally uses 48-bit read/write operations,
> which on 32-bit variants causes reading 2 bytes past the register
> boundary (corrupting the value) and writing 2 bytes into the adjacent
> register.
> 
> [...]

Here is the summary with links:
  - [net] dpll: zl3073x: fix REF_PHASE_OFFSET_COMP register width for some chip IDs
    https://git.kernel.org/netdev/net/c/4cfe066a82cd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


