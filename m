Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B08E2BEC5F;
	Thu,  6 Aug 2026 01:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785981047; cv=none; b=CfpJPIAB8KI0pyLXBmoPbc0dGNVbr7vIMmdv2CkO9PkOXmS+P6NHHOneE2kWyxnx3a7plnWG5GnE3mTCivlRJuICp5kRB4ahONsEtDAAJB5ZQfaLfOxPzT2GAhsrtxWQk5NgPzL4DArk07XzagcHtx+EWg8Adtx8c7BEBzlRvqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785981047; c=relaxed/simple;
	bh=tAMMQjNhGIjtYigYPXLbIqf60e9hxZn6ZT0m6GgPn1s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Mfjai3BwNOfQ1BbbGij1wCE2sxzk016tVRu1ZM6qmg10kiDtyefZiM9Kdv/JHasxvjDr2CYe/N6N72mSTPie7J2bEWvawNX8T/lLsDtMmLusm2JT7tlM3w3oz3mQ5sFCESNpOnbMfdqq8lVsd+pUH7xikonxaAvVC1VjPCS7phA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XFET1JEJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XFET1JEJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 390591F000E9;
	Thu,  6 Aug 2026 01:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785981046;
	bh=HBIvkpG8LHk7T/NKaEz4Dw8okdueHRs3+I76hjIY0aM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=XFET1JEJfnikPgIu59n1jEa8MFejh2fpGro6hOwJ4cUvDCLOR9U8P/sf3Lv0SWqoS
	 t1SgxTU8SnHlaNRKHqS3TJcfJ1slRn186vV8rPeS+hV/1MxLnbqSPl2NpOOsJTZnQk
	 aHWBAk8PpE/I7ET75OOb+zpnomlcNu9RTsfed+BqtiMceJxQi3Kju9q4qDrYAPvP7b
	 hHJbeWG19Lw87AIir5Bt8TPn7c6aurlS6mKWdxV4rvNXJ6xid5J1/QIjoyeeZdKF/6
	 WS4KuhMkHd+a8MXidLG+ZR61UXqP21HwhCYfGGP1PgGBEXGUue2lWTFh1fdsdIwYJf
	 lPy1i6tkaNYIg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1988D392FFF5;
	Thu,  6 Aug 2026 01:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] pppoe: remove redundant xmit wrapper
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178598100564.602736.18007852020430435735.git-patchwork-notify@kernel.org>
Date: Thu, 06 Aug 2026 01:50:05 +0000
References: <20260804094336.109364-1-qingfang.deng@linux.dev>
In-Reply-To: <20260804094336.109364-1-qingfang.deng@linux.dev>
To: Qingfang Deng <qingfang.deng@linux.dev>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, kees@kernel.org, ericwouds@gmail.com,
 nbd@nbd.name, manizada@pm.me, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  4 Aug 2026 17:43:34 +0800 you wrote:
> Merge __pppoe_xmit() into pppoe_xmit(), its only caller.
> 
> Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>
> ---
>  drivers/net/ppp/pppoe.c | 20 ++++----------------
>  1 file changed, 4 insertions(+), 16 deletions(-)

Here is the summary with links:
  - [net-next] pppoe: remove redundant xmit wrapper
    https://git.kernel.org/netdev/net-next/c/eaebed6b2f50

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


