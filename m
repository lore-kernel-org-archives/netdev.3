Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A973A7F4E;
	Thu, 25 Jun 2026 02:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782355235; cv=none; b=eu5sb+lYKiqZft5Hcu4XeZxxppZfHic7cRuC5YnYm73tUzRE5I4tfDsC5f6OQiJ6VyeB2RbiTg1XCM1kLZTy160oFjephGtiSGkSFEESDLBbHhaBdcLgSjqxrYeZEG9HknGMusx4PF/fEOrIB+1XlX9q4+LmT5Dj/x6Z5lMgl3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782355235; c=relaxed/simple;
	bh=rX3XmZP71HSRI4WS0Wtx0rS8ZJaYt92AceqJPkmks1w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CZFdRda0boeZ8CtYTKwDauIdKZAfuyyCI7+Rcp+uPBMaoV7MKxE+04rGx6GifcxB92l83unENYpu8hEIZFCzRdVoJbxyW2Tp50nyI44ZRSKLH6kmc3MCe9bQHF7dbXeL6UpDGTYxjEtOzlmN/L0RT5iEoSxchAiBhUkMzZa/QKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V2SlsrY6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V2SlsrY6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCA4C1F00A3A;
	Thu, 25 Jun 2026 02:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782355233;
	bh=A+oVeHrsUVC8bRiRf77SQD6LgVvJyKOKm+ncDz0MjJg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=V2SlsrY66onCE04zEVuPxJarwSVv9ALK7WUBs7mcDth6j6nTUy3Z4vODcCMv2bR0r
	 1YI4tqa1ThBGSzqKsKSJUXOuebW6NIUlvdiMuKansfXHRaW/j57PFMoekTE6X9Mtsu
	 H5TmDKtZ/lwD6ulBE/Qgv8bkbB+bvR0B+mKzDS6T62HSrtEBzm4p3w7jTGU/E1PCV9
	 RujV430tQqAStXZW7O9iwICdW4hlGY+raiD9t57CV2UvIhLeqj4mUpXtYy1TkGX8sC
	 nRG3G2jD71fY6duN4gbWvAkh9HunvE2MAzbYJfkpsCtTscMZXb40Ik3YCHzbJoNVml
	 soNyOC6ojy4GA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5692B3AAA6DE;
	Thu, 25 Jun 2026 02:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tools/ynl: add missing uapi header deps in
 Makefile.deps
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178235522202.3091545.15269584684983413822.git-patchwork-notify@kernel.org>
Date: Thu, 25 Jun 2026 02:40:22 +0000
References: <20260623070818.2161810-1-linux@leemhuis.info>
In-Reply-To: <20260623070818.2161810-1-linux@leemhuis.info>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, donald.hunter@gmail.com,
 riana.tauro@intel.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 23 Jun 2026 09:08:18 +0200 you wrote:
> drm_ras includes drm/drm_ras.h, which is a relatively new header not yet
> shipped in most distro kernel-header packages. Without the explicit
> entry, the build might fail with a message like this:
> 
>   drm_ras-user.c:19:10: error: ‘DRM_RAS_CMD_CLEAR_ERROR_COUNTER’ \
>    undeclared here (not in a function); did you mean \
>   ‘DRM_RAS_CMD_GET_ERROR_COUNTER’
> 
> [...]

Here is the summary with links:
  - [net] tools/ynl: add missing uapi header deps in Makefile.deps
    https://git.kernel.org/netdev/net/c/636838ebb74a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


