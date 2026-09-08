Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025D74AD7E6;
	Tue,  8 Sep 2026 09:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788859267; cv=none; b=r483b/7CU/GUcdrxf1gC9mY8Vgj2PagzHydfVAsBFKEMnOKxGO9KVYDJ5pwp8AspnLWrOOXCV+M227rc7Wp1+fDYiFVEwhYYQF1GJfDxoDR63cSSJXhfQ9qaZT/ej7mGgtuzAr+auaISn/o9sVehejIQ8JI3Fuj5PAhdy75pDFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788859267; c=relaxed/simple;
	bh=y50Ojfv5VkTBJPFZ0chnmlHeWcVQPMv+rHT31BA3sBs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=G6IkVR7w93BPeCLVUZNOqkpcRjThr1BYGhQs2ctwDxzJ+Y/hpe8RxahOjBRFf2jc2VEYo+wqgnEFS84wU5KfNpDTZSAoaavQxHU2KFEKWoGrFIJOAkm3omULacQa+OlTiwG94C95DM139IWxW8Jj2alNGs/E15VW8nfKDTIyCAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lv7hJOyf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lv7hJOyf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97FA31F00A3A;
	Tue,  8 Sep 2026 09:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788859265;
	bh=C0Wc1z0UK/jSMdHMVCi2Qy2vKtOSdoNgOL/Z+mNx+pw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Lv7hJOyf8TCEIxn5H+5OlVL7TM3S00stkbY0SKUdInDMtRjnLhi86sCgTZvKgGOAh
	 oiTdyX+AAoevCo4hw5WNo/nDMZrdrbR2nwCIssraucQYMZRbdS7ILxtGpkD5LUESk9
	 UP4Jil9WfBYwPmfp1CQdenM39moO//Q6tuYcPqyuiTTkRTjx/GixVFAeGuYN/7+4iL
	 kbb9B/P5VWJRjD/ga9yG2aZ93ZEpRZz+gfykw+wMfBEXLEhLucIlKhO9HgXFZ6YVTI
	 h2cqhw6PdHnB/L1jzW3RNoHVhDN9I+bw4ycWTxSPuGqyirgs7T29uZd62EkTGoY0NC
	 +RkDoyjZ+mPGQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9396039E8A73;
	Tue,  8 Sep 2026 09:20:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: marvell: mvmdio: Handle errors from
 optional
 IRQ lookup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178885920436.3407595.13954843751051119614.git-patchwork-notify@kernel.org>
Date: Tue, 08 Sep 2026 09:20:04 +0000
References: <20260903074638.345952-1-phucduc.bui@gmail.com>
In-Reply-To: <20260903074638.345952-1-phucduc.bui@gmail.com>
To: Bui Duc Phuc <phucduc.bui@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, o-takashi@sakamocchi.jp, dakr@kernel.org,
 bhelgaas@google.com, u.kleine-koenig@baylibre.com,
 chris.packham@alliedtelesis.co.nz, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu,  3 Sep 2026 14:46:38 +0700 you wrote:
> From: bui duc phuc <phucduc.bui@gmail.com>
> 
> platform_get_irq_optional() returns a positive IRQ number on success or
> a negative error code on failure. For an optional IRQ, -ENXIO indicates
> that no optional IRQ is available. Other errors should be propagated so
> that the caller can handle them appropriately.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: marvell: mvmdio: Handle errors from optional IRQ lookup
    https://git.kernel.org/netdev/net-next/c/3ef961d01c2c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


