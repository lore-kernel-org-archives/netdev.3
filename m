Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E26038399C
	for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 20:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787430679; cv=none; b=FKEQ5f1RDbl0QAnb2+Hdipv/lBAl27Ri196HrOJqykWREQXv9cWWZ6Osj9mrCLXI8tMSZN27qT+FxB/Py7PRLGKQxf4VTgEAgd9UvM7Qb0RzQx5GQJ1e6l0loxHXxGN7YfypRTP/rT56vdao+/wzPzJwcTaLK4kNkdFMLYiSK6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787430679; c=relaxed/simple;
	bh=YvKBf8K5pX+vq9v3qnTzymqxR0CHtRjMab7p2Kab8lA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cXQKbgrCRUti6U8yLjs2x9WMPfRvmfIpgwsoYn10xptdgYJU6D1ACN0KNuJJYKdR0dJLJApDXgYof/UbSOFp/RoCYwywqpJn7JgIifzmgXyoWoLnkRNonJVh3q+gC6tEhbx2Db+7aTRn53Ed5SzFQbJaLx2xFv0FJrwnEAQL3Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EaxJx+3H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EaxJx+3H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D14E61F000E9;
	Sat, 22 Aug 2026 20:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787430677;
	bh=ETZxRWYH7GNAtJgc/eoEURY+wauuA3n6LMIP/ZBAP4s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=EaxJx+3H/ttuK6WH8HSipqdbFVtcm+MUqdZ2MRYx0bOhJfkYWEC1ECis+Qt2PnUq8
	 XAglEJiaIcwFj9pK/ME5rzopR2sxpR25t36pk1rWWlBXv/wYWEkqE9hETIqtGVsPzt
	 /sG/t6VBGyD7DFfLcWp/ffyrqiySAKjvLUr+K/xDbFUM43/kf/hJuZU/a/yQAIXc+4
	 1BzeF9sHanH1pMdbadog7EFmDsIaxRU76N1LaufAQptulzqwNapRmDhO5T1c0/JVDA
	 OHMhkow1KIBZQ9tCjHw+6ElUb7TjSA9nfVdQUAz4LcxLxJ+7ONPryemlcEoHRaKYAR
	 aWjwCdJdmZ2Fg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A55380CEF9;
	Sat, 22 Aug 2026 20:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: libwx: fix concurrent bitmap overwrite in PTP
 setup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178743062638.1819488.16681314131778251958.git-patchwork-notify@kernel.org>
Date: Sat, 22 Aug 2026 20:30:26 +0000
References: <6C7EC12D69217315+20260818074721.45536-1-jiawenwu@trustnetic.com>
In-Reply-To: <6C7EC12D69217315+20260818074721.45536-1-jiawenwu@trustnetic.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, mengyuanlou@net-swift.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, vadim.fedorenko@linux.dev

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 18 Aug 2026 15:47:21 +0800 you wrote:
> In wx_ptp_set_timestamp_mode(), the driver copies the global `wx->flags`
> bitmap to a local variable, modifies the PTP-related bits, and then writes
> the entire bitmap back using memcpy().
> 
> This Read-Copy-Update pattern is unsafe and introduces a critical race
> condition. Other asynchronous contexts (such as Tx timeout routines or
> GPIO IRQ handlers) update individual bits in `wx->flags` concurrently
> using atomic bitops like set_bit() or clear_bit(). The memcpy() write-back
> can silently overwrite and drop these concurrent changes, potentially
> causing the driver to miss critical module reset or PCIe recovery requests.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: libwx: fix concurrent bitmap overwrite in PTP setup
    https://git.kernel.org/netdev/net/c/f05516dd7b86

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


