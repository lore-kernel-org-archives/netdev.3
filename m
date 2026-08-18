Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A102E3A48C2;
	Tue, 18 Aug 2026 16:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787071859; cv=none; b=m+O7SvRlCK//yueJNFFlBmhSeFfY85eOpCWBVwkUpLtDiaOYxZ6TGwD4YHjhaCWHWSC7FBp9Mtrez9lVjCOBUg7mXqcl1qMuO0DY3EwVzPOikWJUM/J0Gx26Ic/1B5f4Fu3ShHPeCuXh9e+BlYUxE+jvQ3I5NKEiIl8Az1jNaFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787071859; c=relaxed/simple;
	bh=KEzXSQ06kdEX5GrgJGFxvGymbOVHnAy1j+aRkO77UDc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cHMn8SuVA3SQQ/jd06EHlPSx8OZ3uMyuUR15ZqbbFJLSCsJS6AEbWjACxz98toMC7PHDvtf+yHVW9ZYxeZf/EUmJDm8+Vgdpw7iYU2zMRsPC7SHlGKE2/egRtJE5DhQ5UwJ1vsHkRTHL1YQ1GDyIiG2YHZN7p5V+l/Pe8jt9dDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X2EvYDFA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X2EvYDFA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EDC31F000E9;
	Tue, 18 Aug 2026 16:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787071858;
	bh=mf6wb53WI/NeDjtjz5gwiu64N4VAt6kEByiml0w9Qa4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=X2EvYDFAJBlNw/fcNQKC+4IJ9bLgJPS/nwPNVrVSdYf/Li62pLmYHIUe47C9tLK0p
	 9kQdy5dnEZ4ni2FYv7KGwXmu1SG4JpSZrdQ/YVtJHxCqLgRLKEFHch3aP5Pe+7cl/Z
	 6k53J1D7nXGRtaYZWYJpC8G5DpDKa7m8mUmLAaOQvhs3Wcawfxg/WOXJ9b+urf+aRd
	 CDqaBoXoHtMr0eYqxZTmgNpjOFzMVwgRshbwetEEpM225KPjLTmuXysr/zz0Liu7zH
	 NcXeqJRNa8acgaItKwitCNTDRZG2CbjWC7x8yBZv26wGtprTxBV50EbX1q7LKsyPTa
	 rvATpjcb4SdUQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568B13927043;
	Tue, 18 Aug 2026 16:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ptp: vmclock: prevent read-only mappings from
 becoming
 writable
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178707180990.2177226.15958799767207354932.git-patchwork-notify@kernel.org>
Date: Tue, 18 Aug 2026 16:50:09 +0000
References: <20260813174707.14809-1-suruurism@gmail.com>
In-Reply-To: <20260813174707.14809-1-suruurism@gmail.com>
To: Abdifatah Suruur <suruurism@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, dwmw2@infradead.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 13 Aug 2026 20:47:07 +0300 you wrote:
> vmclock_miscdev_mmap() rejects writable mappings of the shared vmclock
> ABI page with -EROFS, but leaves VM_MAYWRITE set.  Userspace can map the
> page read-only and then upgrade it to writable with mprotect(), after
> which the guest can corrupt the host-written timekeeping data (sequence
> counter, UTC time, TSC offset) that the vmclock ABI defines as read-only.
> 
> Clear VM_MAYWRITE on the read-only path so the mapping cannot be
> upgraded, as i915 does for its read-only objects and as fixed in drm/vc4
> (CVE-2026-68445) and drm/panthor (CVE-2024-53071).
> 
> [...]

Here is the summary with links:
  - [net] ptp: vmclock: prevent read-only mappings from becoming writable
    https://git.kernel.org/netdev/net/c/a5edadbae57e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


