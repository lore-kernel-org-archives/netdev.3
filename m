Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C81C39BFE7;
	Sat, 19 Sep 2026 23:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789861879; cv=none; b=Ihv/eJcZqnEOd+KFmV8uZ7OD/n3/s6Cqhi2OcOrW5QYNqkzamMa59b9clW5pU9Yn1XV5hso9yhlghRusS6y58wOSgJ2ApZlFE0d8+zAu+LpPm8lQw1HkDWWFw2/qYOEOS4s+Y9oIVskVv0zVCjbLF9cGzyZrWALvhRrJl7C/HLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789861879; c=relaxed/simple;
	bh=ExTM/prwA3uW9N45/RsK39KUDUvYh6aNfsLS3lJaLbQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VYTkdGeJ3FTt98QB9APofJWb4iArBqxHRt/+23KSeOWNnkE/fE1cA/NAVQNKlnPuLFLWHRY6g3kMkXqjf7wkGd655oXO0cXwr0JVpLNjzr+l5DSETphy59NW5/AZbQLMbftnDyChqBjSu/fXA72lYw5qo+lON2YHP50amkoMKcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LrQPHQhE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LrQPHQhE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3F6B1F000FF;
	Sat, 19 Sep 2026 23:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789861876;
	bh=9H7cYUaxyrKSHFuxlcv2NgJmh8jNY00jYHElKTKyXQY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=LrQPHQhEvpow53gTH+Eafz+TsOsLnkIFrfjIYgzVEFdTFayZ3HlG7em4b+8qHc5vD
	 DsjyT+8ux6FjC24dIGZpZHk7vTw5YRAge/OzNc2YP9jTERTXz/JxdnkosGBCaqzvPz
	 /sMuLYLTotHi2D5citxfHHXMZmUQAD1EOlkGEuccXqU/Sd7Bj4p0xUC8rPe54kU56G
	 6x3QnuTVebybksIgifjJ2fOOqQa3BSu2053RTtwnBPxIY/ly8d54P08lfBxxfb5rPg
	 8P/Yw8RcGdflG5Hv/v3EdkpNklEKuj1EogMwzZLvy4I1llx8RxVJAZ4QoYMvW3iq6B
	 O+KLt+d3ICoZw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93BC6392447F;
	Sat, 19 Sep 2026 23:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v28 net-next 00/10] nbl driver for Nebulamatrix NICs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178986180913.1496100.6448081038233123934.git-patchwork-notify@kernel.org>
Date: Sat, 19 Sep 2026 23:50:09 +0000
References: <20260914123429.56596-1-illusion.wang@nebula-matrix.com>
In-Reply-To: <20260914123429.56596-1-illusion.wang@nebula-matrix.com>
To: illusion.wang <illusion.wang@nebula-matrix.com>
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 corbet@lwn.net, kuba@kernel.org, horms@kernel.org, linux-doc@vger.kernel.org,
 pabeni@redhat.com, vadim.fedorenko@linux.dev, lukas.bulwahn@redhat.com,
 edumazet@google.com, enelsonmoore@gmail.com, skhan@linuxfoundation.org,
 hkallweit1@gmail.com, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 14 Sep 2026 20:34:14 +0800 you wrote:
> From: illusion wang <illusion.wang@nebula-matrix.com>
> 
> This patch series represents the first phase. We plan to integrate it in
> two phases: the first phase covers mailbox and chip configuration,
> while the second phase involves net dev configuration.
> Together, they will provide basic PF-based Ethernet port transmission and
> reception capabilities.
> 
> [...]

Here is the summary with links:
  - [v28,net-next,01/10] net/nebula-matrix: add minimum nbl build framework
    https://git.kernel.org/netdev/net-next/c/cffde9e49e86
  - [v28,net-next,02/10] net/nebula-matrix: add core driver architecture and HW layer initialization
    https://git.kernel.org/netdev/net-next/c/825e6d230163
  - [v28,net-next,03/10] net/nebula-matrix: add channel layer
    (no matching commit)
  - [v28,net-next,04/10] net/nebula-matrix: add common resource implementation
    (no matching commit)
  - [v28,net-next,05/10] net/nebula-matrix: add intr resource implementation
    (no matching commit)
  - [v28,net-next,06/10] net/nebula-matrix: add chip-wide hardware init/deinit implementation
    (no matching commit)
  - [v28,net-next,07/10] net/nebula-matrix: dispatch: add control-level routing core infrastructure
    (no matching commit)
  - [v28,net-next,08/10] net/nebula-matrix: dispatch: implement channel RPC framework and serialize hardware ops
    (no matching commit)
  - [v28,net-next,09/10] net/nebula-matrix: add common/ctrl dev init/remove operation
    (no matching commit)
  - [v28,net-next,10/10] net/nebula-matrix: add common dev start/stop operation
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


