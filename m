Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49059326927
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 04:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787631067; cv=none; b=n5m+7M/bbTMOatv7QVWE0799xgWv23FoHiupu02xTuZoZI9YBkt9Q5jA9b0zpCJcOixKFPGMqg86u1D37J4xO4YGhE/SrSMknIOTHKVrmxYZsFVTU8TwrTDc3VPDiDT+LSb0ftLuM7v+5OMZnJYaqVORcsiafRPicjyPq535TTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787631067; c=relaxed/simple;
	bh=UtxYjWBGixsdcfwKdpl/ZJJCKxDw3p+aJgccqN07gSw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nUsxVH6ySIesV8C9Wxulj9kRE71p5zRF1Vfp3af42TeeNK8yzYkcUcRPl4On5rmLbGiaOlOjDJKlvdjHPmlMcW+F9WnuDB9Ht9h68G8vjXVTwuU6fAoGrrdhpzSpcCd1O3NnPw7e6djPhrgxXq238mJHkREpe3FymIxBNb6Pag4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cx0d40T1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cx0d40T1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA4C31F00A3A;
	Tue, 25 Aug 2026 04:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787631066;
	bh=fC+kLw84oCTMLoY5bXxFC0X35yYWiTPuANIssf2rNbg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Cx0d40T1zENK7khYkaxNmCTyDA5K3v6ZwoS1E7glk7lCUAhtlPz594OJQeNVOB+wJ
	 nzJy0L012dtmB6ZadgySvWLZr5dPbkUDhUcg/ybKw8OsVo9rjqSFhevVrEY3I75ZaQ
	 94w7vEEMk6NVr3BH1iHPAwBXvGQm9xyMHsVPpO5xZoKMQPIVRZiitN3QieX0uk8/mw
	 OVmEYm/vZz4SLcWp1JVYvXNIjv+rtI22NXb4Q73AIGnjq2TZK9bfRj1oHEr0LAI+tJ
	 piZGXUb1jFk5jv23odGNC9XaK3lF932PoHoA1Y2hkjU++omP8vrRiy4DdQhDGo4kb7
	 abCFOkgqzEDfg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 62DE63924A47;
	Tue, 25 Aug 2026 04:10:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2 v2 0/2] ss: fix vsock port filtering
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178763101313.3232246.1112979804356427442.git-patchwork-notify@kernel.org>
Date: Tue, 25 Aug 2026 04:10:13 +0000
References: <20260817-fix_vsock-v2-0-47e544221eae@redhat.com>
In-Reply-To: <20260817-fix_vsock-v2-0-47e544221eae@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: sgarzare@redhat.com, stefanha@redhat.com, netdev@vger.kernel.org,
 stephen@networkplumber.org

Hello:

This series was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Mon, 17 Aug 2026 14:54:19 +0200 you wrote:
> Vsock port filtering is broken for ports in [1, 2^31−1] (i.e. any port
> whose u32 representation has bit 31 clear, which includes all ordinarily
> assigned vsock ports).
> 
> To reproduce:
> 
>     ncat -l --vsock -p 27354
>     ss --vsock -l src :27354   # shows nothing
> 
> [...]

Here is the summary with links:
  - [iproute2,v2,1/2] ss: move lport and rport in struct sockstat from int to long
    (no matching commit)
  - [iproute2,v2,2/2] ss: fix vsock port filter
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=8016d5a12e6c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


