Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D503231835;
	Thu, 18 Jun 2026 00:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781742072; cv=none; b=bRRD65jwUZQABUEgBYrZQhun7JxBU4lWLV422Ah+Yzt/OVnt4Vn8rD83yMIP9bMfHi9QZC5gCXH4m8hLkSpPLqFWkAw3ZPh2LZygjUvKFxZAh0H457Bb7pPdxqf87V1tUHzMXe0VGLlfQQQwlgnBy6H3sUIG2tARtzU6XJBUkcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781742072; c=relaxed/simple;
	bh=rihE8P1LlQgL09Ut+uShtWZAbwSxBawYuflRPlcjjcM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WUGMgCTKqr5rjx11alAtblVtFWgqNLfnJmiClsfa0yXvigl73puEgFCQbol2xJdhcl/lwIzX67BD0uKhFSKM1muoaTY/iqIL/1rXVBDnmQ6xIbxAIl2Gi0sU0vZlJL9qJoYN0qNQNagU+Q0mUPwEYXJIfCfzdEfo85ohWtUWxGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TVEDfkmu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TVEDfkmu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0582B1F00A3D;
	Thu, 18 Jun 2026 00:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781742066;
	bh=CTqlYi+hhRRQgCdk3v8qgENr6TJHgRiZ4CVkU2tocJ0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=TVEDfkmuNOtz86e65B32eT3VB7BTyAaiJQ4oSmKLxocEK+3MK8Z0DphiwpUoeTd2X
	 KePKzKhFYGCm4U8T4LlUWZoyIbl+MkDIr5PnKhH/BWziIQbkI6nKygeAm/0wuVfTSc
	 6wXRKcgGuoS5zcWWFxcC7QSLkvHaRUIGBL7Mz8x0rcUMEdQzbty4VHIfWOCH4dgnqU
	 5TTO+Vi/8EagZm/O2DvLdkAMphIcY8tZGMWU4rj6O1xshoEqaFl+k68UN8AcbrybS3
	 0m0EdRWFFYfdIEaPHmj6t58b00ueRhBO0YBxcRi7FHcvGuSEKor78Tmv5kZfDaQBxq
	 Nk9VD9MOQ4DhA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197E0393102B;
	Thu, 18 Jun 2026 00:21:01 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] octeontx2-pf: Fix leak of SQ timestamp buffer on
 teardown
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178174205963.1875263.1360010491725524418.git-patchwork-notify@kernel.org>
Date: Thu, 18 Jun 2026 00:20:59 +0000
References: <20260615030704.504536-1-rkannoth@marvell.com>
In-Reply-To: <20260615030704.504536-1-rkannoth@marvell.com>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: amakarov@marvell.com, davem@davemloft.net, jesse.brandeburg@intel.com,
 kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 richardcochran@gmail.com, andrew+netdev@lunn.ch, edumazet@google.com,
 pabeni@redhat.com, sgoutham@marvell.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 15 Jun 2026 08:37:04 +0530 you wrote:
> The send-queue timestamp ring is allocated with qmem_alloc() when
> timestamping is used, but otx2_free_sq_res() never freed sq->timestamps,
> leaking that memory across ifdown and device removal.  Add the missing
> qmem_free() alongside the other SQ companion buffers.
> 
> Fixes: c9c12d339d93 ("octeontx2-pf: Add support for PTP clock")
> Cc: Aleksey Makarov <amakarov@marvell.com>
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
> 
> [...]

Here is the summary with links:
  - [net] octeontx2-pf: Fix leak of SQ timestamp buffer on teardown
    https://git.kernel.org/netdev/net/c/a056db30de92

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


