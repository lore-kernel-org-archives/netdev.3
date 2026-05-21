Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC08F32B11C;
	Thu, 21 May 2026 02:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779329427; cv=none; b=dlXBH/WcwcbHD9aalfed6ojFf+XuMF8Rx+TnvaeKC7HkcuQStR0sV+Nyhuoxv12eegR46+//9brEhC7aFmipWkuVc38Zo0kWVIGCafqn9h2IrOTjpGXvk98NnGD40XBCK5bX4n/aS6MokZj6RHJGbMtZqHAIE82b6GkgMMPSUC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779329427; c=relaxed/simple;
	bh=aHbPkvkTN2X+chLMnwQxH7k1WwkhKbPBDLsT23l8TH8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EJ9uJXXJ5+wovzDqQFAGhNrYOS8pliU3wn9fcG2O4+YzYanYRozta8hDSO6ea+QpXYTkEC6nm7Tm417/E2RG+fSMIs+q4iUHuZH8p9D6zYZGnni/wBJXE1ZhHo4T8lOCSK0rKSIYqVDv8YD6zOOMjdjf+q6j/sKixQMjeglwH5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FrkZJTIG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FrkZJTIG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A56411F00A3B;
	Thu, 21 May 2026 02:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779329425;
	bh=JQGv5fGLioyFXKA/RjoTXdM4ANGnA3mtYUUhokOIPQ8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=FrkZJTIGOGalPM0Z2ihhjy9CiLwf2e7FXJK2c1czDjiFsmOT0oQf6Ewoyo3eoGldw
	 77fElNJ5S0QOhlajAEfRY4RzckdNPiBWtMgCQbncxUe5ANHbfiV1F3pBUH9pIkj1Yy
	 IbkKPaSaIgGgn6toX0MXpY8qXMD3yXP1kpMXWsvAM06ruY765uZJsaV8eK0qWT5+C+
	 doNmlQVdYFp2L4fTOkP/Yi7cM+5TGkGwgDHkT0wGBPrI7JwoM5BLhAICe/NESysVmc
	 6fYIJemQcWVvJY9yEkjhxZSJN4wbNdlLhcO6+zD6WG08CDM1jQuD7+NeTZtvun1vFs
	 lwELglYqe8WUQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198693930C38;
	Thu, 21 May 2026 02:10:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] MAINTAINERS: remove obsolete file entry in NETWORKING
 DRIVERS
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177932943563.3832404.11237969089123850847.git-patchwork-notify@kernel.org>
Date: Thu, 21 May 2026 02:10:35 +0000
References: <20260519091646.302458-1-lukas.bulwahn@redhat.com>
In-Reply-To: <20260519091646.302458-1-lukas.bulwahn@redhat.com>
To: Lukas Bulwahn <lbulwahn@redhat.com>
Cc: arnd@arndb.de, kuba@kernel.org, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, lukas.bulwahn@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 19 May 2026 11:16:46 +0200 you wrote:
> From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> 
> Commit 5e138e0ec32b ("w5100: remove MMIO support") removes
> include/linux/platform_data/wiznet.h, but misses to remove the file entry
> in NETWORKING DRIVERS referring to that file.
> 
> Remove the obsolete file entry in NETWORKING DRIVERS.
> 
> [...]

Here is the summary with links:
  - MAINTAINERS: remove obsolete file entry in NETWORKING DRIVERS
    https://git.kernel.org/netdev/net-next/c/24117f2f1dd4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


