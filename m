Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2272459EA
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 10:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787826075; cv=none; b=YNBlpgYNjP7xVaNJxzotPG/JycOLBoaPgBOBaGm/eWAZalSK1EJhHeiXabMliTBzCTGy/LTc8lU/v16wafV3qoYXV8litr3mMReCq4TKadxok+mKeOzBkc9aKymREPjzs0iTmJdCMVCDaTyAdlmZAjDVRcJt8NaJh07gzDZQr38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787826075; c=relaxed/simple;
	bh=M+RFut8EktA9Ilot34nMAW1wVV6d1ZhQHPOf683WHwY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VZJfNBFVCAKOKxtj12InqpNTMqHs6HV4023VC9Rv1ubNM2TBBY5CQJJcMFNYgue0fRjiaDn4Qa5CSeaFuS03yvXOM+BniBYZ9P3b4RvC7ItibyY65xVfHJRbFLlE/SSSbmvsqEqyFLDhALrsZf0C3tJLYUUcpqCL5nZfhZTnEHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VYnL9d8d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VYnL9d8d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E87E31F000E9;
	Thu, 27 Aug 2026 10:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787826062;
	bh=BwPbpU0Nh44iaH9SFKRn5zdTSsrQH5c9OxzuIIxp8T8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=VYnL9d8deE7ZT53jHji5V34mRdVSTwyQPzNgUXaQWbU/Wg5cqtRfye/rK5vvhbZcl
	 pFDIKQXUFIkQBwaqwZzICyllDL1m79B4TD93HVSnlGRa2+GcNPkN0Qxt+23PGGj33i
	 YS3gCoeW7avuccP+MffCqX+yWklLWj95EOAhjEo76GpdlSRq63ei9kvCO9TQLOi1tf
	 Dz2cbuwki+YSi3F9Jqi7DWbQQbY3+wEbtSTKIxc3cosmbmmRTSE2UTMnDhbUtoU5Je
	 6EF9aLEQ+ejtcJDvf+efFLkx2m03Zem+jLwUIwkTfaSWRaIQStDmGey65S5jkgPg81
	 tvfX0qYCJJ4Bw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0AB93809A18;
	Thu, 27 Aug 2026 10:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: wangxun: use BIT_ULL() to prevent shift overflow
 on
 32-bit archs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178782600740.1149245.16577803441749400206.git-patchwork-notify@kernel.org>
Date: Thu, 27 Aug 2026 10:20:07 +0000
References: <45F5565CE6AC4329+20260824072119.48399-1-jiawenwu@trustnetic.com>
In-Reply-To: <45F5565CE6AC4329+20260824072119.48399-1-jiawenwu@trustnetic.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, mengyuanlou@net-swift.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 jacob.e.keller@intel.com, horms@kernel.org, aleksandr.loktionov@intel.com,
 fabio.baltieri@gmail.com, larysa.zaremba@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 24 Aug 2026 15:21:19 +0800 you wrote:
> The macros TXGBE_INTR_MISC() and WX_INTR_Q() rely on the standard BIT()
> macro to generate interrupt masks based on the queue vector index.
> 
> On 32-bit architectures, BIT() evaluates to a 32-bit `unsigned long`.
> Since the number of queue vectors can be up to 63 on txgbe devices,
> performing a left shift of 32 or more results in an integer overflow
> and undefined behavior. This causes incorrect interrupt masking and
> unmasking logic for both the queue and miscellaneous interrupts on
> 32-bit systems.
> 
> [...]

Here is the summary with links:
  - [net] net: wangxun: use BIT_ULL() to prevent shift overflow on 32-bit archs
    https://git.kernel.org/netdev/net/c/63c885688f38

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


