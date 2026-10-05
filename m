Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FA13ABD90;
	Mon,  5 Oct 2026 22:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791238222; cv=none; b=eqr7tZqjp2JYtTH5AxtCYpehcXIbht4SH+WAcFk3oo8DZhZYF83V4HR7LCsrLcgZYdCKLpcT2CLlUCm9y9LanMallg+u47ZUqWHaSSPxFfhjkpJXI0SKZp48P0MejcPUdJ9J1NkX9RUe/w+gJsowZH4czeKwsG7M3RyzDKAnsno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791238222; c=relaxed/simple;
	bh=ahK8cK2udUrdd0u5KlZ1soDFiOM8rIx4BAxkXAwcdUE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=H/sYmLg+B1Rm+MciSOJgYRgYhhMBj70Pupwx+qmMKfzsrKw69AAapfUJOnp2+phlnu4lN/5D1U5NjOSQUi+oFRgO5ZLvDRn64gyAKiWv8M+At3NlS+DqHnVt+ZN2SRwV6tPbjaw80Q0VcdEZB7XFgPS5clF4HQ6h26OIHVuQkCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BlMoZge/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BlMoZge/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 430441F000FF;
	Mon,  5 Oct 2026 22:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791238221;
	bh=k5b5B2DfrZK50ang5Lg/RTHrsdZiAJdV/AyM4qZLPjw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=BlMoZge/rt2/5YalitW4S34DV7NhyhxZyOklWojx7IOGW7RoojBQ8G+Cx2zQEli3m
	 v7NWdLLZkzw9mUfMdP5NC/Xtc1VBwKekWCjULjE/hNYvjuTgHDMMllXh5zN4oGFyYu
	 XBadJiIaFP0eHV1qp2ZMyz8dABImlFjWvJ9CqOtG3pDDAriMODVMkmhDQWH/CNYVvl
	 /1KU/3mexAKpS3etlowIvcyHE0p3+MLYb7JZvoWCy7LXWu/8Aq1l9OJT9Hxrfm+pzE
	 q49es/iX/f5gH2+wJD+PehUAqJgonF58UU6Kbjkniwo1rIbN7fIoYpabH9ABiNs4Lz
	 sIKCWDnMZ4y8Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A26D3926672;
	Mon,  5 Oct 2026 22:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] dt-bindings: net: Convert hisilicon,hns-nic
 to DT
 schema
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179123821977.1914306.4726000433244904464.git-patchwork-notify@kernel.org>
Date: Mon, 05 Oct 2026 22:10:19 +0000
References: <20260930201851.71082-1-robh@kernel.org>
In-Reply-To: <20260930201851.71082-1-robh@kernel.org>
To: Rob Herring (Arm) <robh@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, krzk+dt@kernel.org, conor+dt@kernel.org,
 shenjian15@huawei.com, shaojijie@huawei.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 30 Sep 2026 15:18:49 -0500 you wrote:
> Convert the hisilicon,hns-nic binding to DT schema format. It's a
> straight forward conversion.
> 
> Assisted-by: LLM
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
> v2:
>  - Deprecate port-id property
> 
> [...]

Here is the summary with links:
  - [net-next,v2] dt-bindings: net: Convert hisilicon,hns-nic to DT schema
    https://git.kernel.org/netdev/net-next/c/05e40209cf75

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


