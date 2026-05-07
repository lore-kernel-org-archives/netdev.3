Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42049280A58
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 02:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778121659; cv=none; b=cmLJVAqTsfo3mYyAyIz7cvjbdy5Q+bEuD3GrpH/qKvSmadFIMTpxNx0pywQFwJEtIhbYH8BnmDLe2v+SrAsak70MtEb94cV3I2m6MicyAa7aNXa2GHOPaNtudG1CkUb4r95J/pq/KIUEpULG1wp2umIbFTkbBb2A9Y1fmnAPOq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778121659; c=relaxed/simple;
	bh=zhPqOeH/edNtTx2ZLooVQ+5uJzweXou7454HjimraDY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=i04zo4YGbcrEZNvUCa3cBfXnf9FVD0kfr4+HyMlikdu5dH9zwbtgYgpSoxHoxzBMPxItUXcoc5m1hAFvmPu3e00b4DyHpBh/GWAWxW78V4qJcOcY4UEd+2stf82htNK1Mquan7nKK3PB31nLHP3lS4y3mty/izEWCEZGFKekseQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LZDpFvQD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LZDpFvQD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF20BC2BCB0;
	Thu,  7 May 2026 02:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778121658;
	bh=zhPqOeH/edNtTx2ZLooVQ+5uJzweXou7454HjimraDY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LZDpFvQDZwS2AAsoGuqe/uOG4fKbIL9Lqj4hSpqhpgjCmddkLPOuNOnQV9gljuQlI
	 JQnXYrh/yrAutVtDLYNBEXn7ToZY53YluLwXr3Sqd3iSQ8KcZjiWBQn8vS0rsCRX5Q
	 kLQuPEZbNcQv9A+KW/AUjLLpRGWqNT/uP1vvHjymjDZ4TNUhCy6TftlUdZdOAq3Xi8
	 Nr9Agm8YsoIi0ixko9ScwZVDTi1gzJBS6YFM5lgnp+c46b52Wchc+VQMyH4qzauk+O
	 rltfEHnxr2Jbttvf6ErWK/S4TwtkpEOhPjDLOlLam0P7ELXpfsRk+f7S1JRXp/n3ui
	 Ug0+kEI6YzBew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CE5739308A0;
	Thu,  7 May 2026 02:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/3] [net-next] w5100: remove MMIO support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177812160830.3310619.8635292405431424793.git-patchwork-notify@kernel.org>
Date: Thu, 07 May 2026 02:40:08 +0000
References: <20260505180459.1247690-1-arnd@kernel.org>
In-Reply-To: <20260505180459.1247690-1-arnd@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: netdev@vger.kernel.org, robh@kernel.org, linusw@kernel.org,
 brgl@kernel.org, arnd@arndb.de

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  5 May 2026 20:04:57 +0200 you wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> This driver supports both SPI and MMIO based register access, but only
> the former has devicetree support. While MMIO mode would have worked
> with old-style board files, those have never defined such a device
> upstream.
> 
> [...]

Here is the summary with links:
  - [1/3,net-next] w5100: remove MMIO support
    https://git.kernel.org/netdev/net-next/c/5e138e0ec32b
  - [2/3,net-next] : w5300: remove unused driver
    https://git.kernel.org/netdev/net-next/c/68edebbd0e7d
  - [3/3,net-next,v5] w5100: remove unused gpio link detection
    https://git.kernel.org/netdev/net-next/c/dacf281771a9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


