Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432A625B0BE;
	Tue,  8 Sep 2026 01:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788829281; cv=none; b=W3eYTomUXijAV1jgwfxKRNVDKcKtaLG8cNLVMwneuMjJuj+vTNa4fIvnVI9OY8xvBoYEdzT7pPcKtFCstwpuLxvIuXQNvAsuTDOQ7svVPTYxyPvyrZWZk0BcLT+4R+DPGJstcm5VeiNxvkiqojmmwFOLZEnmczOHXTLl5T23T84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788829281; c=relaxed/simple;
	bh=znf7VHJ/v4Xk7teQ6+uCVdPq8PnI/IuGHJxi29xX3MA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NvIOiza8hNYLGMY8uUNMxQhq96Cb+9w7+1r7OypTaM1deIruq7FaN47lPYxd5kZRnWB2RvVnP757OqsrO77PADcbAUYTaF9E5C4mTWSB/VgH314bWtFi1t/THntJ28Xql0Hp+mofbRSLslgfu9cew/+5WZ+s8PL6/TopPVDOE1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Md1yoDDS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Md1yoDDS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A3631F00A3D;
	Tue,  8 Sep 2026 01:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788829274;
	bh=/9PYFysBUKyRm3BokYVYJK8H+xhicz9AVUwEIAtqWS8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Md1yoDDSo0bBFUNZ9YCZSV40muUH7iYHqOlCDC6bHUp3+f1CndxpxJ8aZ5QXc2F6Q
	 qF8YnnRx0RKZI+ekMSgRziIjNzRLSzuO50mBuGKAwFa0N7UBi+LdEiz3o9aN7eNVmQ
	 6nEflZAWhMkN2/eoPz5pr5XAy/kIKAWoLAOUMr4a/BoMysdwehI5FuSVpXQ3AA8hRR
	 wCn7Q1FoN45IQFoLcmb4l/iOXdsegXvSI+fQT5eF1MV8Qkegp2SD07C8SwI9eFFLWZ
	 Cdyvm86UlP3pD77/vmN5xfRMyHcMHr3BIreDkIyu/1z44AtVNL36HsBI8W7PJTHekp
	 +kSXd6u3zYY+Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5686A39E8A5D;
	Tue,  8 Sep 2026 01:00:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] atm: fix typo "protcol" in comment
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178882921288.3227186.3949850625552915412.git-patchwork-notify@kernel.org>
Date: Tue, 08 Sep 2026 01:00:12 +0000
References: <20260904123638.39273-1-hemanth.selam@gmail.com>
In-Reply-To: <20260904123638.39273-1-hemanth.selam@gmail.com>
To: Hemanth Selam <hemanth.selam@gmail.com>
Cc: 3chas3@gmail.com, linux-kernel@vger.kernel.org,
 linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  4 Sep 2026 18:06:37 +0530 you wrote:
> Correct "protcol" to "protocol", reported by scripts/checkpatch.pl using
> the misspelling list in scripts/spelling.txt.  Only touches comments, no
> code changes.
> 
> Assisted-by: Cursor:claude-opus-5
> Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
> 
> [...]

Here is the summary with links:
  - atm: fix typo "protcol" in comment
    https://git.kernel.org/netdev/net-next/c/bc6fe9d301d5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


