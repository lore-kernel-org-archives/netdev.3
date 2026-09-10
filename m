Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53375335555;
	Thu, 10 Sep 2026 01:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789002674; cv=none; b=P+Rh4TR4tp/ofUV5AHcBWGs9z1rJRIPkPcxrJmURcTF5p3MmrNiuav4CRy49jK65ZyNzDT+KIHNgJvBwCrqX3rvojsIx6UK4LZzj/w3G9IeL4JHj9Zsr63XT4FiFOUEUEXrRGT7I61j3tRHGbcSE2bBhQo/7l2F6CQfmYkGcsc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789002674; c=relaxed/simple;
	bh=kbxBb8dAaihiqwTvKBznpQ9Us96wwzaiEJuugVyTxn0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JPIAAfZcyN3R60XPjJFjtKrUq6kcmQYWX026QTV3JasnZsCoQa/3CoHAHGNBYg36FIDUJAVNUu+uzMBk+BqwHiMqXKKTBhmUZvWWVSndO77wA+Hq340mp9CfwKGUvJNtdnQs2+MN2aiLaZdezGpDv5jigmaGABTjHmVh6orTSsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJyHEiFV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJyHEiFV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E6FD1F000FF;
	Thu, 10 Sep 2026 01:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789002671;
	bh=pUY1if5ii6d52LgsHoArzybLsSlb2J0742aCTIQz9E8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=CJyHEiFVn+kAJe1KF+yjl0fz0U1wQJaGapkf5c+5A6I2srXTOrIHC82uKjcBlJ4LS
	 H4BYvpbRcfU3X0XcCX378HdiHLl0+GbYHt1jqv/gmoxXFxfYr8LR1xiWTaUms+BKA9
	 X+rfSL93K8SRoRh7ZOrTiQqaSZib87VY34JjrX3/nb4+nbiVJhuOEpFAgu4o+qfA/c
	 pCvm/ORaCHLop3wdp51SKJb4hdJyC/ufk3XBEHs9hg6l3F10+ByAz9reQsDcLUCDxr
	 FOqp+OAM7DEDlPgHzZ4zKLkFsjw4Lb9QBluvnNcAahjAmx+IHcw+4FO/WediGiyfsE
	 lM8fWnqgvJWZQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56902380CEC5;
	Thu, 10 Sep 2026 01:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] docs: mctp: Fix the struct mctp_sk_key name
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178900260887.1135028.15413724982275942438.git-patchwork-notify@kernel.org>
Date: Thu, 10 Sep 2026 01:10:08 +0000
References: <20260905095150.42180-1-kmehltretter@gmail.com>
In-Reply-To: <20260905095150.42180-1-kmehltretter@gmail.com>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: jk@codeconstruct.com.au, matt@codeconstruct.com.au,
 netdev@vger.kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org,
 skhan@linuxfoundation.org, rdunlap@infradead.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  5 Sep 2026 11:51:50 +0200 you wrote:
> struct sk_key does not exist; the type is struct mctp_sk_key.
> 
> Use it.
> 
> Fixes: f4d41c59135d ("doc/mctp: Add a little detail about kernel internals")
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next] docs: mctp: Fix the struct mctp_sk_key name
    https://git.kernel.org/netdev/net-next/c/0b799884350f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


