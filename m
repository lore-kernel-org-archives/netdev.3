Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F9A37F755;
	Thu,  6 Aug 2026 15:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786031489; cv=none; b=IGZHkukMaHm+qZjZvrEonAPlZqx8RSnl/pX32frDoGXXg7z0er1Q7Q7ot/7RBeqjlprog8Nb+8GZLHbD4yQjGTb/ryV/7hgB4ivtgoMiYhWjxn/C7XgqFnICMMM5ug+WwBBRk9LaDvYU6n/3e3ndhkAAHlIMsImxcPlNq5Y1ccA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786031489; c=relaxed/simple;
	bh=ok+pAFh4kEaZ7fwfpTfq6uPxVrunyWvWZav9P5wZMWQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SVFUsdKa51VosLHveaCvpw1Xdv/aXZfao6oQtW/y8h0Rm57J/9AQtUfubNUQuLB0KvEsekBNGRDSzse8835jQ2VYfXMZsN1vIbJkTjRCK+OwsbKtmiMyCp4HlF/55bgfoPHvYtlXk7SsfaX+7JDfT+lsk5tO2Fx+J8YPF0TIKKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ObWBWLsG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ObWBWLsG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C1C01F00A3A;
	Thu,  6 Aug 2026 15:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786031476;
	bh=b5DNUSt2EZq3bgSalZ4Jzd2kT5p/THgrZ/c9eyp/P7A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ObWBWLsGSo+oyTB0EQaZAd1cZp9hfbH5DBhOuIdxnKrPDBT+Og+LVkwhL+zOD4oEh
	 sNdDPqxq2tM4CcSL/bPv17fnaTJsTmYz6o2dSCWwNNXvpwC28sFa90ir6Dv3GWS/wX
	 w2rKPs7ad6AZRTBE3WSiZ4A0yhC3A/X6kiuF4ha3HtOApzoqD67+tUHYMxRIf1Fouv
	 VOpjggBJhkX0ovjwF2QGChujfN/gWRxbURkqG5Mm1bPF4N3g0zzGBWX93BmoitDOki
	 GsPXLgCK+3ia4hJyHxI2AVHIga2L4SImfVMz6RjXBdooPtYNde7qNZX39GcSZXk/L+
	 rR6ANYzvoW2iA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19813380820D;
	Thu,  6 Aug 2026 15:50:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] usb: atm: ueagle-atm: fix array-index-out-of-bounds in
 uea_bind()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178603143563.1348318.6670988207691284327.git-patchwork-notify@kernel.org>
Date: Thu, 06 Aug 2026 15:50:35 +0000
References: <20260802-usb-ueagble-atm-v1-1-340f085b04aa@gmail.com>
In-Reply-To: <20260802-usb-ueagble-atm-v1-1-340f085b04aa@gmail.com>
To: Subasri S <subasris1210@gmail.com>
Cc: castet.matthieu@free.fr, stf_xl@wp.pl, 3chas3@gmail.com,
 gregkh@linuxfoundation.org, akpm@osdl.org, gregkh@suse.de,
 linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+92f5bf49bf4ac75223ca@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 02 Aug 2026 11:59:24 +0530 you wrote:
> Add a bounds check on the global variable modem_index before
> using it as an index in sync_wait[] array whose size is NB_MODEM.
> 
> Reported-by: syzbot+92f5bf49bf4ac75223ca@syzkaller.appspotmail.com
> Tested-by: syzbot+92f5bf49bf4ac75223ca@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=92f5bf49bf4ac75223ca
> Fixes: b72458a80c75 ("[PATCH] USB: Eagle and ADI 930 usb adsl modem driver")
> Signed-off-by: Subasri S <subasris1210@gmail.com>
> 
> [...]

Here is the summary with links:
  - usb: atm: ueagle-atm: fix array-index-out-of-bounds in uea_bind()
    https://git.kernel.org/netdev/net-next/c/37a5e120118a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


