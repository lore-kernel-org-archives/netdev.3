Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7385A3264D8
	for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 01:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790385701; cv=none; b=lActol7p4ESc+2r75g6Wt1KPe7XOjWJCel/VUKCneWR/thpBQD5f/2sFsuf9ftCCm//Sa2TPeVVYcXnWKRulvcBPAbXkkUJcECucummzVfYaSe93O76pVRjfTQ4KTOeHzkrt0frI7NydITm+hIsCqdPlWBAMBg6eMiiKJQHYcTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790385701; c=relaxed/simple;
	bh=WqOgj4HqqYvf2kIh/5zDbGfIEhfBM6njMocXgSWEqN8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=T1UuoQHZlbr2VHGGJ7Tdk5dvJjUQXALg1HuCFLx7BLp5HJ+mK/e/IuxUc65O2nE4pgMpN1YPwh/Q0wWV37ySB9WEKiT+fMTn+Y0hcavV9fxi5D74Cloqvexg6uGFIUZs+J6c13SqwwnEtfkL6lWCrA0KpBP5QfrS7uqpzpbJXhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i9mHMUae; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i9mHMUae"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 225901F00893;
	Sat, 26 Sep 2026 01:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790385700;
	bh=Zjdfz4Pvy2OkNRLTniQIX3hvRsZsmEA+LiimrLxfG4I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=i9mHMUaeTMwGqRwvYUg1LQAXl4GMlnbU9n/f+SLE1xytWcF3SkKwiJeNUMccb3Atu
	 PtMXdNIJ0U2V2SnCEyUCA7YVAbiYUthJBSgqy+ubAQdA0Gm9T3UCpf33qyhftKGOyY
	 E5qOXw7p4clmFWPM5FobM2QLsDUpA+O8s3+DNMCa9W89z0fu0fZc9PKEGKgxxgBCyT
	 mogjcizrJvwPCoRSuq4IrpvRBdaXT85FhpFT64gwtrzbdfB42FzCAbG34h4kzqwziZ
	 u5SiKgMq4lDgH0zrGWNwAFAvt2vi+b+mda3oNI56s7MKD2Ze0RVrpzgCsI/pEel/+6
	 PARSDfdJwFhgw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A163809A08;
	Sat, 26 Sep 2026 01:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] dpll: fix LLM nit picks from the spec scan
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179038562739.3233155.5991706076295448084.git-patchwork-notify@kernel.org>
Date: Sat, 26 Sep 2026 01:20:27 +0000
References: <20260924231211.568213-1-kuba@kernel.org>
In-Reply-To: <20260924231211.568213-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 vadim.fedorenko@linux.dev, arkadiusz.kubalewski@intel.com, jiri@resnulli.us,
 ivecera@redhat.com, donald.hunter@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 24 Sep 2026 16:12:08 -0700 you wrote:
> Fix issues found by an LLM scan of the Netlink spec for DPLL.
> 
> Jakub Kicinski (3):
>   dpll: do not truncate the requested pin frequency before checking it
>   netlink: specs: dpll: declare pad in the nests which carry 64-bit
>     values
>   netlink: specs: dpll: drop the reference to DPLL_MODE_DETACHED
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] dpll: do not truncate the requested pin frequency before checking it
    https://git.kernel.org/netdev/net-next/c/7f92b7f381ff
  - [net-next,2/3] netlink: specs: dpll: declare pad in the nests which carry 64-bit values
    https://git.kernel.org/netdev/net-next/c/398f802dba01
  - [net-next,3/3] netlink: specs: dpll: drop the reference to DPLL_MODE_DETACHED
    https://git.kernel.org/netdev/net-next/c/863da457b407

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


