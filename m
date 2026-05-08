Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BB512CD8B;
	Fri,  8 May 2026 23:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778282474; cv=none; b=YfKvJpFYxcgYBYQSX0PWLuK6XVAvxgCJPBae16mvd/qGk8LROR/1LNUUKRT0sIodCim6kB1SuagrNuUBf4rz9+L6S2qjPJQ1ZqJQJainUtwxg3aMOEGvotPm77w9Zjey5mdkPCVhYYuJZkbdPYMqGTeSZEQBaZobD6h5NrAegyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778282474; c=relaxed/simple;
	bh=pSIUvfmRSzTJPBMVYA+UHNzV3MqNiOvXD7aLrFNv8iU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=m+QXyMNnnisRHEYdlQLGWC6CS+opGk9CrYCsyowELE7GfRO7xC5+UKSHV+R6JbOPtjZpL4MDvvM0FHUSiyld0ZmGvSrNq9MZrluDYG9Jwskh2L2F56c2vfaFHsJmGK/qiZZFiQfK4jp6bq5invSmg6nUeJXk9nfLBL4BBX6PhxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bPw4DV+7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bPw4DV+7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6113BC2BCB0;
	Fri,  8 May 2026 23:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778282474;
	bh=pSIUvfmRSzTJPBMVYA+UHNzV3MqNiOvXD7aLrFNv8iU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bPw4DV+7wsPKkNOsTOLgrgMu+oLF0NAj8SYua046g4s/bW0h8onDrgfRUniXOVNr2
	 McknivoYGLBenx2Hne0MKpcyqoCQ/0jGxxjEn9caMkeHMfmfwMdLpHVzKBqSwhA+G8
	 YBJpltvGZucUJM6N1UbKuZL3/f/MqTCNDo7rA/7cJWS6vE2BXoSbkGttLDIsauaHUH
	 I5MH5Rh9gaM3mWmApHe+qBL+2q+dr59C5n/5PT4iN/Qz9BOqngcRYpUBrjOFjFaBaE
	 BFE/EUMZgR/sfXvnSnAsq+U7UBit14hWkieYUT2UXGoW8wyOk6K0uAqjFVBynEF/zx
	 llSiJ9ipMsiGw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02C5E38119DB;
	Fri,  8 May 2026 23:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: phy: dp83867: add MDI-X management
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177828242263.890779.7434407913066087321.git-patchwork-notify@kernel.org>
Date: Fri, 08 May 2026 23:20:22 +0000
References: <20260506141918.13136-1-l.ellero@asem.it>
In-Reply-To: <20260506141918.13136-1-l.ellero@asem.it>
To: Luca Ellero <l.ellero@asem.it>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  6 May 2026 16:19:06 +0200 you wrote:
> ethtool on this phy device always reports "MDI-X: Unknown" and doesn't
> support forcing it to on or off.
> This patch adds support for reading/forcing MDI-X mode from ethtool
> properly.
> 
> Signed-off-by: Luca Ellero <l.ellero@asem.it>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: phy: dp83867: add MDI-X management
    https://git.kernel.org/netdev/net-next/c/be0e8db6935f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


