Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F918306756;
	Wed,  2 Sep 2026 00:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788309475; cv=none; b=n18kfL0FsJUmlCMPSrKjL1mta9S635VXySlnqK6cFLbAWbc8z2vNwZTIFvVBh/QQhd/01kQy1VjQttieGJkMUyIcfOSbzbMjb2fw66jdn76MRK2zt7q3iJ77B4VwqS9FEY6IceAgn1QeaXMhRG+ZOeg6OCjJ2+dPEB5pXTRowJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788309475; c=relaxed/simple;
	bh=OBo6+udVr3H8oeH41MBJl5ECSGNr9fOFdpWSdMXy9s4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dNYOUcNUY6fhnbnoRa0RcR3yMhcrC8ucXP2QSh4axXcc+8BgD8iYMx2Mbs14bWaBLiUwNNaBeCyd1p9nERwiYD9S0M4I02ymZgEpg0/QR2xyU0P3VLY9HYFEk1avpKK68TzZcurVedi5ohkjJZe5RKdMTMCa3wkAAeYlqojQwMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GABx1Ke6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GABx1Ke6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEA051F00A3F;
	Wed,  2 Sep 2026 00:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788309473;
	bh=oYWmx2wno6h4ry2zN3j6ODRI3VuRitZoxEXbSc/4HK4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=GABx1Ke6G98FszhEZsbELjl+7HkWoFVkoTh4tjxunl/BjdTRHYgBZTaNO5t9z+72+
	 OOjXu8PmmxDxY2rMVA9R2ZIExYm6YL+uNjXIX9TO7kwOi4bKIDQGBo3M9u2xmqRCN5
	 IGfukLWz8T70Q9Lz2YxNf3WYMv3zA8TZT4C98GygHIh36bVsfafmHPmjM7Aqw7R87r
	 z0rUplB4SJBaJ3pYKpxYYOEYQKHWwEvtKYaungYgjB5nTroYo5JmmXq8l2ZHz4zsG+
	 GLbFDXe0YomXi9PUKwnKwca7J4JdzALONgux+8JqVQLprbY10uGAEsKBp9GtQEXgM9
	 yX/1SHEgkoJKg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56AA23926244;
	Wed,  2 Sep 2026 00:36:57 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: fbnic: validate mailbox TLV extents
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178830941589.1844276.5812467706926788766.git-patchwork-notify@kernel.org>
Date: Wed, 02 Sep 2026 00:36:55 +0000
References: <20260830142516.38145-1-pengpeng@iscas.ac.cn>
In-Reply-To: <20260830142516.38145-1-pengpeng@iscas.ac.cn>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: alexanderduyck@fb.com, kuba@kernel.org, kernel-team@meta.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 30 Aug 2026 22:24:58 +0800 you wrote:
> The mailbox path warns when a message claims more bytes than the descriptor
> but still parses it. The attribute walkers also validate a child TLV before
> proving that its declared span fits in the parent remainder.
> 
> Reject invalid mailbox message extents and bound each child attribute
> before type-specific validation.
> 
> [...]

Here is the summary with links:
  - net: fbnic: validate mailbox TLV extents
    https://git.kernel.org/netdev/net-next/c/c29b37ed7a4d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


