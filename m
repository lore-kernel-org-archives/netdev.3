Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35F4480946;
	Thu,  6 Aug 2026 15:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786031489; cv=none; b=BtErOe43s56FXJa7ynVivp6MjGmfimdi6l01aAsNWbxueX2rIMzuqhwwre2Jc49b9Xvmhzg1LVlhOuM+r9Jtw6wx9iYGY7K47paJmpDMB25FEJN2Skl5Kg1J0BrKVr14GqpjThPLwNzuoC9r32NTGw1vieaCloAvsglv2E8uURc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786031489; c=relaxed/simple;
	bh=8PxX8LvP5JiUPLQmkKcRNCwy34eTrzO4ZTeiAdO7ghQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lwe2uY+m2oKpic9sL2/Bf1UEfHcTBSBBy0C9QBoQWOhYTQ2+jacjTqy3+Ug9pWQ3hqxMtKZQwnQ8I+rxxZ2lUvL1gZNrVXno4Jwxlmxj9SReASZNHVEx9SndAP29pR5g3HQSojXGDhHvy9RzklIWpYjlmmK8NHk9ju7kv2eLXVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mw59hiYe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mw59hiYe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89F6F1F00A3E;
	Thu,  6 Aug 2026 15:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786031473;
	bh=KvGGOuAZAgBSdysnskIqMS6piXvrX8vCLDcaix7cRZg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=mw59hiYe5XkWVUt5bmh6ueYW+It9B9VsOsy+faJuSq2qI4QjTXeSixb45WMD/kNhz
	 trEw3RAmR8itWDxxycB0z7hEFGZO/4rEg3HHapeD4U7FTGUfD7A/FHov+JjbwEYbjQ
	 1gvqDJznjXsP+DytKHPsHuBTR/dw3CvVAeumq15lBREfpqLwctQj3UVwClPtriULdY
	 Glbj7p0DM+hQXdEY1oJQHL5aHlZFohj5ColGUw7cvw1HnKnWUXv3dcK+Fwxl3uNm0B
	 pYk/sKRiCPemVL6xZbmrPIN+4F6nGJ5FGxfg42LtMdw00en0mR3i9wZHnoj34u0BFw
	 me2YNDX6rfu8A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197F7380820D;
	Thu,  6 Aug 2026 15:50:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] usb: atm: cxacru: properly kill rcv_urb on error in
 cxacru_cm()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178603143263.1348318.9398157117704385774.git-patchwork-notify@kernel.org>
Date: Thu, 06 Aug 2026 15:50:32 +0000
References: <91edfa4c-a63d-400c-9f00-31f3e1f98c00@mail.kernel.org>
In-Reply-To: <91edfa4c-a63d-400c-9f00-31f3e1f98c00@mail.kernel.org>
To: syzbot <syzbot@kernel.org>
Cc: syzkaller-bugs@googlegroups.com, nogikh@google.com, 3chas3@gmail.com,
 accessrunner-general@lists.sourceforge.net, gregkh@linuxfoundation.org,
 linux-atm-general@lists.sourceforge.net, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, duncan.sands@math.u-psud.fr,
 linux-kernel@vger.kernel.org, syzbot@lists.linux.dev

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 31 Jul 2026 10:15:20 +0000 (UTC) you wrote:
> From: Aleksandr Nogikh <nogikh@google.com>
> 
> If cxacru_cm() encounters an error while submitting or waiting for snd_urb,
> it aborts and returns the error without killing the already submitted
> rcv_urb. This leaves the rcv_urb active.
> 
> When this happens during initialization (e.g., in cxacru_atm_start()), the
> driver may ignore the error and proceed to call cxacru_poll_status(), which
> invokes cxacru_cm() again. Attempting to submit the still-active rcv_urb
> triggers a warning in usb_submit_urb():
> 
> [...]

Here is the summary with links:
  - usb: atm: cxacru: properly kill rcv_urb on error in cxacru_cm()
    https://git.kernel.org/netdev/net-next/c/d87cabf0b673

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


