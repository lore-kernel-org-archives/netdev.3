Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E58044AB9B;
	Tue, 21 Jul 2026 21:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784668840; cv=none; b=fsgaluLcWu9LSWBWFFgnvlz9H+eMd76uxD0R0QrALCRI4L5mIekfivP8FHRF67VU9Ky6uAK2FVFi0d9qXTVDR2J/dZ4YyBNiOH5G5UsHismSGgCLQJJemzxPsndzKDaaNjmz+OvAyzoRwTXID8YJrAoYe8sLTu/M0kNdEG9Db54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784668840; c=relaxed/simple;
	bh=UTaS3SSXbAq6UhJLmKP4rEMeEx5xTXDhR21bQn2F2A8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=W7IPQtuT53fqrzU0hgCI0/kzwEXiZF4z5TlUtBlgrm2JqiQuJRTRneg7QpxUd+yMnvbpi8z5yOCPrgMy5IIiNn64MksVr+yZFeE3Zw2a+c1U/rdcr8VAzaFDp+cj7E0dsYrnhIr6s2yq2/HVUV8zC79ti0kbS8kFhUEyk5lDnOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j9dRyiwl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j9dRyiwl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E74EE1F000E9;
	Tue, 21 Jul 2026 21:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784668839;
	bh=8tU1xvbJKWJ/xIZ4j1CFTf0UFEI9HGKIM/VoSNFdX/I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=j9dRyiwlBN8uZuREQLzyK4WcDXbjNmsm6PWNGjuKT9O+GOsmGMNRzH3U3/SEkZexj
	 WjPQZa5YCDnNalP0EM/3oKMR50ndMAuOunA5+ZpTUhqhMLo8Waif1+w3/81fPfBZ3v
	 ipbO9SKwO1N0CUVoWX+iYog1+b4NksseI+d/6RXn/eZR1jhoBwR/2ArSzmLLUjuXOR
	 q3PlvZe1pqDmVXpLSgT37ShFZipfRDStDesxGff7tpAaRNrvkpaM0Nk1TCikY1Rt9z
	 HmEj20EuPRv8K6StPDUvjX1pLcLpJGSWqTrLZk7yxzdzEJimfs4QN2lkmvi7m2YgoF
	 65o+3aliPqeHg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A9D380820D;
	Tue, 21 Jul 2026 21:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: mctp i3c: clean up notifier and buses if
 driver
 register fails
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178466880840.1074610.12315387391533380302.git-patchwork-notify@kernel.org>
Date: Tue, 21 Jul 2026 21:20:08 +0000
References: <20260715072517.13216-1-mhun512@gmail.com>
In-Reply-To: <20260715072517.13216-1-mhun512@gmail.com>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: jk@codeconstruct.com.au, matt@codeconstruct.com.au, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 ae878000@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 15 Jul 2026 16:25:17 +0900 you wrote:
> mctp_i3c_mod_init() registers the I3C bus notifier and then walks the
> existing buses with i3c_for_each_bus_locked(mctp_i3c_bus_add_new, NULL)
> before registering the I3C device driver.  If i3c_driver_register()
> fails, the function returns the error directly, leaving the notifier
> registered and every mctp_i3c_bus object created for the existing buses
> allocated.  The notifier is left pointing into the module that failed to
> load and the bus list is leaked.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: mctp i3c: clean up notifier and buses if driver register fails
    https://git.kernel.org/netdev/net/c/03d1057305ef

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


