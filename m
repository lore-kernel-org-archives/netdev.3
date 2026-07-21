Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF1C43C063
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 22:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784671238; cv=none; b=PUtPzZTAK9OAjvQT4L5iO79V2Y3YZQOKvySPuPU1IVoJGG+kDZs2uYa+C1W9gpmEWmCObfrnm93fkw3yV2spJyj8SbfR3vU8J8m9Fq1RXz2hklHF6AILMgR5QwsCTcDC0VR80hRil4KhFQpYI+A37A9BGmyFRimqWc+kgiJwdhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784671238; c=relaxed/simple;
	bh=a7NmvRod0ycKPThkvBsiiKdoeEslZzdXC5SHsj+JKMY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lN40Z2hJ94IT/s03RP66694wf9Vh/l4wMR7JNRfw2wHcErcjwjdpVq+Yc52yzrNzK7DveL/8pEi5mxE2DCE1BbFXbhPrBZmezUARlggcD0OAu4UiPeotnFwatGB4EGxYdsswCo6vo+r3LkSyG7gy0TZfdKKHJvxzNZpcAq9vnB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fJWiB8je; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fJWiB8je"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 360FC1F00A3D;
	Tue, 21 Jul 2026 22:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784671237;
	bh=1xsulARyB6HV25+UUYwCDk++X4GuYr/dsor1hu+vS0k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=fJWiB8jedh8Q7fw5tIH5wMBG7sY5Hh1CZbl4kJMMShLWcdIx6oeWB9rbUnDbFtIIF
	 h580QWTXqfhOYc0ETgZ7admvJOmWciAGEvhvRV46qBVHgsH+8GjQr6L/Q49kkLfSY2
	 121FYHrnWGu15NCMu9KOjI2D/PBtS9esHV7fYBV367p5UcA1DxPotxH8MS2DGwdH92
	 5H91NM6xRINuNzkwOGz5+8eFNgF0nxmubrWs3MVTnRlf3WlfKVmDnuHbd90PyFa+7e
	 gvmMsvzpeFXGEiZXkTU0bthjdpM6QcLbuwbMOYsyRzYWk72nEqoKVO78SushMXlSOU
	 8AAMQrxZP510Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0BD4380820D;
	Tue, 21 Jul 2026 22:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/1] tls: device: push pending open record on splice
 EOF
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178467120638.1102577.6415763309162665275.git-patchwork-notify@kernel.org>
Date: Tue, 21 Jul 2026 22:00:06 +0000
References: <20260709224436.1608993-1-rjethwani@purestorage.com>
In-Reply-To: <20260709224436.1608993-1-rjethwani@purestorage.com>
To: Rishikesh Jethwani <rjethwani@purestorage.com>
Cc: netdev@vger.kernel.org, john.fastabend@gmail.com, kuba@kernel.org,
 sd@queasysnail.net, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, leon@kernel.org, nils.juenemann@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  9 Jul 2026 16:44:35 -0600 you wrote:
> Hi all,
> 
>   A kTLS socket with device (HW) TX offload can leave its final
>   record unsent when sendfile(2) is called with count > bytes-
>   remaining in the file and the connection is closed without a
>   trailing write. fs/splice.c fires ->splice_eof on the socket in
>   this case, and tls_device_splice_eof() pre-patch only pushed
>   partially-sent records - a fully-assembled but still-open record
>   stayed pending until the next write, which an abrupt close()
>   never provides. TLS_SW is unaffected; tls_sw_splice_eof() already
>   handles pending open records.
> 
> [...]

Here is the summary with links:
  - [1/1] tls: device: push pending open record on splice EOF
    https://git.kernel.org/netdev/net/c/eaa39f9f8ac8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


