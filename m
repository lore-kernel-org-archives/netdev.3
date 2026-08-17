Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF1D35DA42;
	Mon, 17 Aug 2026 19:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786995977; cv=none; b=tT43TvXiiaiaBNDJAFllzRRCaYF0lxRckcoLXK5GwxG4ZTRgkoSl3yH7LynzSlobgr2M33e64TeokZhJpRIQBRZi6hAJdTJS6eDKvQ/hJjtaAn9bTO0P5P3gKX4tTFXHD9fHoJ7OBhGvoPvaxRzbknMPXc/2xrA02E6U9CaDSKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786995977; c=relaxed/simple;
	bh=7sFG7IKe0TjqOwhZhr+gHtjf2ZVa30iVJC5PcHnFdH8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WEe0Gw+im2rpSbSF/kBHXQpb2zBop9PvmMcPDgK4GqzNPQFjo7x54mYyijncATjaRECBgBdzaro/jIQxNKZib8KxzA9jCc78pA5ux+sAAwhP7OOmv1yiwzhDbFttMzV2q9EVN7OnP1mUTuG50kmxYNyfIdi/fl0Sqm8CEnwxFW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YfqBC1zX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YfqBC1zX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71B111F000E9;
	Mon, 17 Aug 2026 19:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786995976;
	bh=wqn44WbkbVRRvfq3n4GCmvsx8PC/4xHXMLWv/tMFrCo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=YfqBC1zXSF29dI5+LY6kciQXFXrTjJ4CHmsWpjx4UGuFZkbMm0+VyZmGsPqZmSBjP
	 mv5TdAn/0siWJEECzDb4BWRlxX3+ogiHclvhKTihUvrFuKtYeWBixwXJQuStC/ruL1
	 /CPcTrVmKEWhGyXN5qTiCquKK27x2kfhAqqBZ8h/+AMtay0PgfWFIjmzb7Xrb5F9v5
	 4mjBJUHuUcpO39OZkDa+pl9xGoP3B7t4zrxeHfasWY7h3j8KH880YIYzLIXoe8xSqP
	 ySuluUGt/M9oWh8D6AiG+Zg3GDrxskiUbwRl5fhyCwSWJ6fHdXVLfgYmxsW2Wf7r5u
	 7V9ksgBPKEoRQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09D63926262;
	Mon, 17 Aug 2026 19:45:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [pull-request] NFC fixes for net 7.1-rc8
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178699592843.1691257.18400258097143079777.git-patchwork-notify@kernel.org>
Date: Mon, 17 Aug 2026 19:45:28 +0000
References: <4bcd0efa-cd97-485b-a7ba-6db8e3c4d3dd@ixit.cz>
In-Reply-To: <4bcd0efa-cd97-485b-a7ba-6db8e3c4d3dd@ixit.cz>
To: David Heidelberg <david@ixit.cz>
Cc: kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 oe-linux-nfc@lists.linux.dev

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 11 Aug 2026 18:27:50 +0200 you wrote:
> The following changes since commit db2ddb87143519e20a95aa36c60b36107b736a58:
> 
>    Linux 7.2-rc7 (2026-08-09 14:54:50 -0700)
> 
> are available in the Git repository at:
> 
>    https://codeberg.org/linux-nfc/linux.git tags/nfc-7.1-rc8
> 
> [...]

Here is the summary with links:
  - [pull-request] NFC fixes for net 7.1-rc8
    https://git.kernel.org/netdev/net/c/a22054d74333

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


