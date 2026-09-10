Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9832036403B;
	Thu, 10 Sep 2026 01:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789003869; cv=none; b=kjBX0eB0Udku7YwRmSnCq1tDh+HdTt+Oom0aRb5CmYr8fVOcltxUoT08FQ8lRMemvANe5S5MdBtCulUdRQ56ylQYiQEVKgRUhC4W11pvllJzUEVaJUgeOoauUPlI/5t0GX7ICOpiIWTWF7sxNgOOeZE4TFnpCImnLoNUF1PJ3IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789003869; c=relaxed/simple;
	bh=bDTc6jI1BmA0oZ3OVWzuKEO00/CAnCkGqELJctJSmR4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OmkqK+7O17uoNQNOFDDM1CntKuDLs87m0Ej5u9d3XjFX+XTqKjOdIhAdvefwpMdUPlH7RpgjN/cC5Yf1X4RqLZwr1HdJc/YDEGMLWPMCF8dmdRrDG+QaXYPBO0v8X1oUh1TyozKahH/MEKeA4eB9dbWvJDXh9FkUhL+SFRWekM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wd3PTpEr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wd3PTpEr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18C6B1F000FF;
	Thu, 10 Sep 2026 01:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789003866;
	bh=8XPwstDtkHETmPVIB6J1Duz+hiJLoNXh4efcWyxV2bs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Wd3PTpErE7khPS1vyPRDZSZmovSuwcLOYSgaE9rRWV/P8Go1Y3IkzxBUuwNYlWR+j
	 AQuhIm/LF/yLf9mT9XBGWKgeVvSqxr+waJ6zMMCiTRE+HpCtDzKks+0aqJnHo3NtyW
	 GcxieK5s0+TMBTu6mDHAi7r9q4OqQ4ZSTcjS4qRLy/xgFEOlaynhjGFYMg4jPoefli
	 f/ZV9tia76I4Bs/2uEIORFRZ78hW4uJB12UCxJdNvtH5GqLsRe/QKjLH7e36noaQSJ
	 ZgDMqWKMwtw7Z+31gamon09goBdnXA1OqI3+RFAd/OtTNop01MrRtNwV6dqiNxCO10
	 4xRc3SnHbCb+g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19AE2380CEC7;
	Thu, 10 Sep 2026 01:30:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] docs: networking: page_pool: Use
 page_pool_put_netmem_bulk() in the kernel-doc directive
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178900380388.1141351.12222446095741061422.git-patchwork-notify@kernel.org>
Date: Thu, 10 Sep 2026 01:30:03 +0000
References: <20260905084711.40105-1-kmehltretter@gmail.com>
In-Reply-To: <20260905084711.40105-1-kmehltretter@gmail.com>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: hawk@kernel.org, ilias.apalodimas@linaro.org, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
 corbet@lwn.net, linux-doc@vger.kernel.org, skhan@linuxfoundation.org,
 rdunlap@infradead.org, aleksander.lobakin@intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  5 Sep 2026 10:47:11 +0200 you wrote:
> page_pool.rst asks net/core/page_pool.c for page_pool_put_page_bulk().
> Commit 024bfd2e9d80 ("page_pool: make page_pool_put_page_bulk() handle
> array of netmems") renamed the function to page_pool_put_netmem_bulk().
> Since then the directive finds nothing and the bulk release helper is
> missing from the rendered page.
> 
> Use the current name.
> 
> [...]

Here is the summary with links:
  - [net-next] docs: networking: page_pool: Use page_pool_put_netmem_bulk() in the kernel-doc directive
    https://git.kernel.org/netdev/net-next/c/bcf03907c5ec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


