Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C76051AFF8;
	Thu, 15 Oct 2026 10:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792060829; cv=none; b=ZutHAyfUtAJw/81WQlIWqd4CGRjxZbH5Ijo8tBvBUUDuD3ZX64vgum67YI5nTSDR5kSDfrIp+w4u2vnUzZJ+PjQJ79aNhiY5FaciFqHT3xxnHw9WUf3GTX9fEbEhYKySXt3CZdSSifNITUdn8iVYhIUMJ7dA0hOCHcit97q8oCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792060829; c=relaxed/simple;
	bh=BB83UFSkvSwNnHBhPKkzhgQC/37IoS1UzVE7TcRlf/o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Vthmxicw1VXAQLhxL+GbKtYwLCQxfRtVSnd2505o8EJqo5QIAQ4lISPFTDcuJC1Gpi/M8lr4P/cKEA+O1oQifSnLmzPY8YVJ1lZSg2MBXlLvu/oZ3m+DESjIcApdqNVAmtItwJv0MsIevhetYC7y3BbqgH9QFzWOtA2091sfRcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GbBd75To; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GbBd75To"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD21C1F000C4;
	Thu, 15 Oct 2026 10:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792060827;
	bh=Ouhx/79EoCU+mdR0Ui7GOT0ddR/OWySR4Y1rx26r1/4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=GbBd75ToQJLYSmQwCJjARb4XJDgJ06WdC9KAkBAQE77hocpEOVoAJqN6AyPzFw+F3
	 sRXSPTqZ0dnZbFySEUMliD9iBfBkGIB1RY81PiQjZpx1EWw0+TEJZcQpweeD9aquvV
	 jZYw08asO+Gc3rfagN/JKLGeeZpr5VOqa7mpjkM25WRV5jrWQkPKof32MFcfrqN4AP
	 1G0X0IWU4rlF3Ecj+nwkkEwZQc/RfPCaSX6JxV1DyUYQU+hg3r8NQ5FhalySr8B4Dv
	 7bGwFNtp/MUwmpMgOjAz6doCLcCffA/NqmmBJHQuo7sZOZqRn4qsrE4mi76sb/wfy3
	 iMojn0T2hpPHA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B4444392EA58;
	Thu, 15 Oct 2026 10:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5] net: ipv6: seg6: report lwtunnel setup errors
 via
 extack
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179206082626.3345829.11915873624677495814.git-patchwork-notify@kernel.org>
Date: Thu, 15 Oct 2026 10:40:26 +0000
References: <20261009152015.462383-1-g.goller@proxmox.com>
In-Reply-To: <20261009152015.462383-1-g.goller@proxmox.com>
To: Gabriel Goller <g.goller@proxmox.com>
Cc: andrea.mayer@uniroma2.it, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  9 Oct 2026 17:20:13 +0200 you wrote:
> seg6_build_state() rejected invalid configurations with a generic -EINVAL,
> so "ip route add ... encap seg6 ..." sometimes reported "Invalid argument".
> 
> Add extack messages to the checks that lacked one, and use
> NL_REQ_ATTR_CHECK() for the missing SRH attribute so that userspace can
> tell which attribute is missing. The checks themselves and their return
> values are unchanged.
> 
> [...]

Here is the summary with links:
  - [net-next,v5] net: ipv6: seg6: report lwtunnel setup errors via extack
    https://git.kernel.org/netdev/net-next/c/a39a3a32785e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


