Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A041A9B46
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 13:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781185810; cv=none; b=htz/XwVZ+W8SDuiP/iux4prmico9hqooe/A2+R1qBGu+Sc2bEZcHk9dxSJ4uax7TTSmdLztQksNF/kY3t6DYle6QXc7DEw/9zQ7juFspyboXSmu7idVqbUuoT8WdkLYPVnk+1QldgiU8k0A1wuLrW/bmJB7fjJ13JKmiLHRapvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781185810; c=relaxed/simple;
	bh=a4RY9OeQkQDeV7uZ4+j3MYBAfsI2lVCJnABhwOFPfLU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KWvB5PgniiLZ8GdotzIEq/13ZlhuQk9CKb95sbTTQftXCDlprWJKfyjHUAVfyE3dgZ6qWfo64EkrpObEJr0BVSA/gCSfZ+VW0sV4XxRAtbY3IavTaBFeUXeBfHAjiYCgaMv1IICjuSZH1b8HiD33zjP1iEwMjr65JEV7Voe3IBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yz5VBkQl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yz5VBkQl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A5141F00893;
	Thu, 11 Jun 2026 13:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781185809;
	bh=Z39XaCHIqLPA68lcDfmcR+vYYFpLpa4iJzy0mnpNCnc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Yz5VBkQl3JjgibePHAlab1Z1IUnLRphvUE9QRDNA8CKP0LPUI5c7ZwYiOddL6TiU9
	 MLjU/GRzsMPLPzvG0aGhSniLWTFxrXSdPxn4P/0y3scJ3kUTUiyqHtZaCO7TCCOOT4
	 OnIaIBbkj4xsJDOjXTadmsoSxdmmR1qwWiivZUw4+WpvbibNfckM2zou+JCS8y91EQ
	 SYWxzkb6A+Hr9tI2Yxnw2KY5OvMfRUFVQkvKCeInUSKz9X19rXaTEBPfgKQ7EfiL/I
	 rfa6bDVU1LCTSH4vsvduMPkkf90JPAdrgNxA4h3Jvrha+7TkmMYirDgIKINK11juWV
	 q1lDY2nJP9+Hw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197B63930E5F;
	Thu, 11 Jun 2026 13:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: sched: avoid printing uninitialized link
 speed
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178118580664.3971116.2333385312602465859.git-patchwork-notify@kernel.org>
Date: Thu, 11 Jun 2026 13:50:06 +0000
References: <20260609183353.1109641-1-kuba@kernel.org>
In-Reply-To: <20260609183353.1109641-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 vinicius.gomes@intel.com, jhs@mojatatu.com, jiri@resnulli.us

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue,  9 Jun 2026 11:33:53 -0700 you wrote:
> sch_cbs and sch_taprio print ecmd.base.speed, even if
> netif_get_link_ksettings() failed. When netif_get_link_ksettings()
> fails the ecmd may not be initialized.
> 
> Use the always-initialized speed variable instead.
> The semantics change slightly because UNKNOWN will
> never be printed, but that doesn't seem important
> enough to complicate the code for.
> 
> [...]

Here is the summary with links:
  - [net-next] net: sched: avoid printing uninitialized link speed
    https://git.kernel.org/netdev/net-next/c/518d8d019953

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


