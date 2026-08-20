Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548B92F6920;
	Thu, 20 Aug 2026 20:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787256058; cv=none; b=MeARlbq4foEflbG6fgbOtTu7Jj0+TcmeFGC0wR5KUnfuN7KMye/SY/RIyy9JmZzvkuAJLAJjb1JtFlzGJKmbiC8TfrlFnWLYxjwvzGEvUcZ1QHaJPzNrWH80TXNLRVEQsiMZu4VeDt/WGyfBTTg1HAMsjROE9ok/AG0TEusnCTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787256058; c=relaxed/simple;
	bh=EX2mpDdWPX2/qs7tR77bZW2LsOpHrBMQd56JyEU7ig8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Wf/Y4j03DaUPQv1bcDATVQqUVFOMo49sbprKqMIOfV2ObjC7oDNCIl4D7Zp5f7irH7fhLSMju+dhEpLVjBkHBbuAofNEDXycKdMlWhNgKrAomI+4hC8rDwZ/3rNsOewaiDHeHx2ZfAJozDhT+2pOrQ+SyurDeeMbIog7AhMGYuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y+gCCbJR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+gCCbJR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B7D81F000E9;
	Thu, 20 Aug 2026 20:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787256057;
	bh=CWz9mtnaDzz3+elH02ZcSWO5X2uQ+rae2nRpQPczEaM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Y+gCCbJRiH1lyLH28B8zn3I8eqlk4TLIuiuFPHKAOudwWtgZHjAiJIWDoeiWOcyCM
	 4+Z3JSRfbzHTzyf6OiLvF+g+t8889oHsYWKnCDzI/QRPtcBMENTaZ7DUO12riLZHnN
	 Iofva4FVsUmt0BoOYQjLAYTWQLEEf1PUh5ipxXw5KwND6zVDpXOL4LZAj+44VieXdK
	 wzK/RE38qEMCHZiu0Flut9XOCevT+HAPXdXO0gvo03tP07hms7zZWKaPb3YmPma+NP
	 TgtHfcHfvO/xM/DMAwLXCoDPRp4CHJ2k06wVCAW2WfVujbgB5s9yAGa/EMvmCwVKiA
	 EPic4OzakRl0w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A39392445B;
	Thu, 20 Aug 2026 20:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: qlcnic: validate unified ROM sections before
 loading
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178725600713.460874.16217299636512038781.git-patchwork-notify@kernel.org>
Date: Thu, 20 Aug 2026 20:00:07 +0000
References: <20260816052109.4607-1-pengpeng@iscas.ac.cn>
In-Reply-To: <20260816052109.4607-1-pengpeng@iscas.ac.cn>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: shshaikh@marvell.com, horms@kernel.org, manishc@marvell.com,
 GR-Linux-NIC-Dev@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 16 Aug 2026 13:21:09 +0800 you wrote:
> The unified ROM parser reads directory, product, and data-descriptor fields
> from the firmware file.  Existing validation forms table and data ends with
> unchecked additions and multiplications.  Malformed values can wrap before
> they are compared with the firmware size.  The parser also dereferences
> typed pointers at firmware-controlled offsets.
> 
> Valid descriptor extents alone are insufficient for the consumers.  The
> loader reads a fixed-size bootloader regardless of its declared size, the
> version parser assumes a 17-byte tail, and a partial final firmware word is
> read as a full u64.  A truncated image can therefore make the driver read
> beyond the firmware allocation during validation or loading.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: qlcnic: validate unified ROM sections before loading
    https://git.kernel.org/netdev/net/c/5e8076e4e412

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


