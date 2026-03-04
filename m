Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3A232ED58;
	Wed,  4 Mar 2026 01:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772587842; cv=none; b=sUzu6XT/qqBpL8sc60ImdNDdX+e6orcGNSDpccFqwWJoAqvxYYag/wdI6XE6yytQo9VlhiVMw36Tl0CiNWNg55LPDH7EiIwG0hAjP5QmnZnpa5fwjjzUoWH10v5HP7+rEdm1tytL5qzrCWmuRhL3EQTjikg0yLPxN7Iznj3wzz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772587842; c=relaxed/simple;
	bh=v0spz6zycLGHWW4CpULPNZmqE/CwAExEJbdkdVT/GvY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pyZ9ylAGowrGMd49Brj0vl04rK9clRl/d+C4h1/DDqCDGxCxD5rIl4qmP7F3LRNEmOGPx5F5Q6UaJHkjMk1/+3vTy3oQh1m2q6YiCO87XM9hmuozkA13V8JxVYjXg+2wXF+nADtaF097R7pWYGO8VJLqz4HJBnQPuJArbEfCJ5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJoHfH5S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJoHfH5S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34DC0C116C6;
	Wed,  4 Mar 2026 01:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772587842;
	bh=v0spz6zycLGHWW4CpULPNZmqE/CwAExEJbdkdVT/GvY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kJoHfH5SevufvAOw8NAa1tAAbW3FHBCAMT/5EHEb+Wywl0Vyt41Sy1uzLrnwX4Xat
	 UTUAX++Hvt7SB4ea3XPvsRqu58199bNKx9J6gykY2rr6c9YIAQR0BDXDpvs5EKpoRg
	 p0PjnRy/AQ8gJaXaeS6nscbbeGwZzyLhBaR3zA3STabnpxrMtwOxd24uuG9dWuloF0
	 ujha1uholOK5HEgVky4XVmjGAKqyfblbY4Tc+hMpHZqwJdtBRKiX1ul/MUWfOn1lFK
	 Mc3WsQE/PnylVFfzUS+tEmB/oPjP+EDZFkmvs9B3/IDnXV44povlorvmsgyhPIaysf
	 xfCANbplv1JvA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CE473808200;
	Wed,  4 Mar 2026 01:30:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1] NFC: nxp-nci: Replace strcpy() with strscpy()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177258784304.1546050.13043250991778322020.git-patchwork-notify@kernel.org>
Date: Wed, 04 Mar 2026 01:30:43 +0000
References: <20260301135633.214497-1-tomasz.unger@yahoo.pl>
In-Reply-To: <20260301135633.214497-1-tomasz.unger@yahoo.pl>
To: None <tomasz.unger@yahoo.pl>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun,  1 Mar 2026 14:56:33 +0100 you wrote:
> From: Tomasz Unger <tomasz.unger@yahoo.pl>
> 
> Replace strcpy() with strscpy() which limits the copy to the size of
> the destination buffer. Since fw_info->name is an array, the
> two-argument variant of strscpy() is used - the compiler deduces
> the buffer size automatically.
> 
> [...]

Here is the summary with links:
  - [net-next,v1] NFC: nxp-nci: Replace strcpy() with strscpy()
    https://git.kernel.org/netdev/net-next/c/66e807f96f4e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


