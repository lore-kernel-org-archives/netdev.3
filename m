Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA383BE14A;
	Mon, 17 Aug 2026 20:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786999271; cv=none; b=r9TuZhaYiO0MyBiZERuZ4NlHv+7lBehT4CXW7ePVzZIYRt1kk0NTIuLMcuhJPrc52pxMXEElB5ogNJ500JsPtv76r3LwTpyaSvfBwkXxh1SGdtPzMy8lXSJiHq2Uj69nAww+Ye/6D6P1QSoNr0Gq0FjkwmFe2BiLhskmtsNylg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786999271; c=relaxed/simple;
	bh=G6xidEOaciYX5OokrwPeB8VhADXVhxaErBXabLSSCXQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Pr5auk5r4fKZZomPfvwR1NFKBV4ZjO1qT0MmzZjTJK4ywxXRao+DfUW5EMz0OcBYg0dOIqjC7sfWfbhIRpijryeuGMzNW46MuKPKDfN2BRElHwP7P4qU5PEnkH9wBGiPwCW3N3HQgCkj0sRIG1/mUHQYM9w+OBRIu4QGnAqCog0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BVspRVNi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BVspRVNi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 782021F000E9;
	Mon, 17 Aug 2026 20:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786999269;
	bh=tgMo4+ZccAH/oz55CFn91mo2q6OR8uZdWdlfhiHevz4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=BVspRVNiYIL6SK3iNqQF/xl2RNE2evJssr3BWRTfV9YbS4AX7pSnVfh2fQFGMNr3i
	 JCY7sSazqVFXlCZLqiYk0Ina4ybt5wxtxcxalNAl9H0MaO30zJFD8R1xUW1sKT3S1P
	 5e/a6Xsdya/WLR+sD6chjVMwQsv+wHIg+ukjQ0nFFoiivyLSiBULr+samHfoY8UV6w
	 JHk+jpTxH8uwjePhhsdRszKv/dIJkX+d5m8KEp8u1OnPgYi7/3InfGHrihqNT70Hmv
	 tsxStRLD7zO8B3nOICQTFtdtheYo2/AzPXv0oTVFmiKyA7TQaKAe3DQ05qcYU9LWcP
	 Ana4Uh4zL9sEw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09E43926265;
	Mon, 17 Aug 2026 20:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/2] net: sfp: quirk support for XGS-PON ONT
 sticks with unclean EEPROMs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178699922138.1728655.8887848793591612023.git-patchwork-notify@kernel.org>
Date: Mon, 17 Aug 2026 20:40:21 +0000
References: <20260812154708.2201266-1-tillo@tillo.ch>
In-Reply-To: <20260812154708.2201266-1-tillo@tillo.ch>
To: Martino Dell'Ambrogio <tillo@tillo.ch>
Cc: netdev@vger.kernel.org, linux@armlinux.org.uk, andrew@lunn.ch,
 hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, maxime.chevallier@bootlin.com,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 12 Aug 2026 17:47:06 +0200 you wrote:
> Some clone XGS-PON ONT sticks return EEPROM reads where the vendor PN
> field contains non-printable garbage past the legitimate string instead
> of the SFF-8472 mandated space padding. sfp_strlen() then can't trim
> the field, the exact-length check in sfp_match() rejects the quirk
> entry before the string comparison runs, and the quirk silently never
> applies - so the kernel honors the module's spurious TX_FAULT and
> eventually disables it.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/2] net: sfp: allow prefix matching in quirk lookup
    https://git.kernel.org/netdev/net-next/c/f53167e29b8e
  - [net-next,v3,2/2] net: sfp: add quirks for OEM XGSPONST2001 and FS XGS-SFP-ONT-MACI
    https://git.kernel.org/netdev/net-next/c/03fa69146f2f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


