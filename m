Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6CD2F5A36;
	Thu,  6 Aug 2026 01:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785980450; cv=none; b=bqIZsmYUvjm1mbxFrG8dQzTPbMI+hL5dDz0oiKDqcJ3GDnnEUV9GRXI/ZTIbRMhM7y+IOXrqNF0QqdVCEmmqhv9IAfzoGbcxzGuuBxntWdfT7HYz8/CwqXK2EuSGVY28NGcO2BBmr7O5xwc60grPdgM2i3IeDIU4fOs9ZrVq0uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785980450; c=relaxed/simple;
	bh=BoqJcEU00R6WLoT1rdDHWfwduCYFnb+SEE7uFRPbz3I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ugbj4zmZnyemRz/HZG6RhbHwelGPute+YDUj2STjplqGy9/g09Ic8a1iO4V3flQZiSfngk5YHMPoAkjCJoy3Yeolf+wIQ6mlNErD2f4CaMzE0cynG/S5S/MzXeVl9745sK2QoUrGTfLcPdRQfJQ0xc3JWDYsPxyTEN8ukIhBvbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cyzB4mNG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cyzB4mNG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED2EB1F000E9;
	Thu,  6 Aug 2026 01:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785980449;
	bh=P7WIeM8Rx7X2twfXGV91t1GSyzjePmrAq1NMknos9A0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=cyzB4mNG0ubuCbLGyyRC+tQiH7BT8f1WN7iSHgpxZ41zB+ZahC1wYeMutEc86hOA/
	 rFGPlVjF/dR+YYXB4bmDxJMaSAJPLUlFUuArIc/qXbWx8Fr+dQKYJ0oFV0l8Xa2jFj
	 CHVwy5GasMSqlR+nEoXuEJmFhRPZLeOOSUTdeQ0C98ryO2oqaGayCqcWUHIAkNwyB7
	 6z90mgT1S/hCCkyHtwsg1fa0N4tQhkkA2Nf9KjcD3vBwq/hE1LoVMKhVwoEV0HShKb
	 fGstJgJaQIALNXQAJzU+Po9yrVFyzW7JSLEyGbX0z2B080vyCxgslfTlaPz1tDSON+
	 JuLEMi7A2Ywaw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A28392FFF3;
	Thu,  6 Aug 2026 01:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: tulip: remove xircom_cb driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178598040839.599522.8669819859721166117.git-patchwork-notify@kernel.org>
Date: Thu, 06 Aug 2026 01:40:08 +0000
References: <am48DR5FC-xTY3-D@ThinkPad-P15>
In-Reply-To: <am48DR5FC-xTY3-D@ThinkPad-P15>
To: =?utf-8?q?Pablo_Vallesp=C3=ADn_Aranguren_=3Cpablopva014=40gmail=2Ecom=3E?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-parisc@vger.kernel.org,
 gregkh@linuxfoundation.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 1 Aug 2026 20:33:49 +0200 you wrote:
> A possible bug was found in investigate_read_descriptor() and a fix was
> proposed. Since this is an orphan driver for hardware that is old,
> removing the driver was suggested instead. This patch removes the driver.
> 
> Link: https://lore.kernel.org/netdev/2026080158-next-diligent-b4ce@gregkh
> Signed-off-by: Pablo Vallespín Aranguren <pablopva014@gmail.com>
> 
> [...]

Here is the summary with links:
  - net: tulip: remove xircom_cb driver
    https://git.kernel.org/netdev/net-next/c/ff3a8694c2e8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


