Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B41219FC;
	Fri, 12 Jun 2026 00:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781223014; cv=none; b=dKIHI8ersZiAiW0xV1IrsEJGHlR/8XoD6CSXDX4LaESykmQzYeKxGXMCaFIL5Zk+djnsRJl6FuFTN1H8lf9V+nxxGx1NBJtgK57DEu4FoG4Hadv6aaMRqnfMel0QULJs4gH8A2cC1f86xN6g0yueB6C6ZsSstrwUVwpDvxxtN9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781223014; c=relaxed/simple;
	bh=7Mdb8ig3ulyAdSZ/I7o6f86lqNToxFgCbho9Ms1gYxU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TbC2Wmt/AReaVINq0lKy6n/lwao2W5PvyQigm6F15GWNgizB/fJbLaCt2afkWPD67+heO7i6nllI0Xt4HigOOf7Ui2rHmpl9Id7mfKjQeYhoCqlqUBvM+G3WtsGaL7q39l31anT2stuRhgLRCqmFyp3eh5mNwoq663EI/o2uM/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IPVZ9CR0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IPVZ9CR0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B29C81F000E9;
	Fri, 12 Jun 2026 00:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781223013;
	bh=XrUMbaDc8/HfNLNGRKx2Sy7mZ/WrNEmmBFzCmLexcW0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=IPVZ9CR0W8/8S5OWNKFBKeUEPohLPa11r4J7lLDxpbIctJOD82+24UPsUHPcM9loI
	 biWH110x2jnzWZHyzTsdbmP8m2t01Lwjyd2qCRudkit9Vz7NEv77tdPgimVfy0/EW7
	 ENiXrI6GRlV64bxPgScmxDsjv5s9i5K06klZ6caSoPScvD9NG6N3NH0aRoms9vHQ+k
	 FmsCCii2uUdUHURiQ3wWBKw8Upk+471C3RHmSkXy/TDJkhLoIWAkLrNsbMfNGwZ8Ay
	 pP92qrJRkXL3657CTbWE9TXqneB1Nw4RGnqcLt8r61iV99RW3RJx8S5VLjq6lJqmlZ
	 bwkYNntlOfUnA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198413930FB4;
	Fri, 12 Jun 2026 00:10:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [pull-request] NFC updates for net-next 2026-06-11
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178122301064.415137.4307378428317682270.git-patchwork-notify@kernel.org>
Date: Fri, 12 Jun 2026 00:10:10 +0000
References: <1aed7555-3d24-413c-b284-bc85fdd33055@ixit.cz>
In-Reply-To: <1aed7555-3d24-413c-b284-bc85fdd33055@ixit.cz>
To: David Heidelberg <david@ixit.cz>
Cc: kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 oe-linux-nfc@lists.linux.dev

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 11 Jun 2026 20:44:34 +0200 you wrote:
> The following changes since commit 518d8d0199538a4d6d5e51064044ece71e0c42e7:
> 
>    net: sched: avoid printing uninitialized link speed (2026-06-11 15:44:55 +0200)
> 
> are available in the Git repository at:
> 
>    https://codeberg.org/linux-nfc/linux.git tags/nfc-net-next-20260611
> 
> [...]

Here is the summary with links:
  - [pull-request] NFC updates for net-next 2026-06-11
    https://git.kernel.org/netdev/net-next/c/5a031965451c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


