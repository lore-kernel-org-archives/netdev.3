Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35654A23;
	Thu, 27 Aug 2026 19:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787860271; cv=none; b=JCe5lyCfNvyPsDiDQ/wO/W0EC4Ir3tYsKjjWs3x9I1aLhlyfGbTT0vFy8WZqDbmg4pwedoSjM+VFsPpk9bMYX7w/0QSO1xzzx+BFtfJOYAmj/SfDnhceRljcwCCLuOTmbPK95C/P3zjkv4Vja94KMAcFugqzfTce4/v73fGhJ6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787860271; c=relaxed/simple;
	bh=gi6EEfn42pmfbo6G8w4gmk8Zbb1EMivO/F4J2vz5bVk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VzpI6EGkQnTmF5/2e8lSA6kQsWkLmNM7gKB4La8+ooPJR9oQ6NBgbg4f4mnqKd6u4ukDfTQHttfNTfu6eytR/pMkwkiizCxUqKtQNcYgBlADlNjCWYrRlWJ2vjJ8ZxhQfdKKNjJzLxLdRufluVN7yZ37ubVvQNKYNgf52HbLbUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g5GrJ/I1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5GrJ/I1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 676B31F000E9;
	Thu, 27 Aug 2026 19:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787860265;
	bh=Mr1qnd8CrWymBtTapPQOUTLOI46O+x38oadzGcyvHW0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=g5GrJ/I1AQpFylWAExHK0NaYy/QTD0oYY8EM2itWTRZU++N2nUZYf59Z+4Xlb3k60
	 qHk1odNVSvtldALHeHJqhEGLrT111SQtHf8baVeltYVooHIHOsW4hFUcLFTAgXO3w1
	 uOB1F3LaDsJcnOgbkLzryvrHL5dw52c+7S6Tt/ijx2c0CdrfJu9Lq+GNvHtkrDG/eg
	 +5yIBifw7C0padc929GiPwVIv5EUxONM9WerQZEk0i9lZVun9JTlE59C4vIH/sJkHq
	 o+ZD2Kxl8EPgZoYmCg8kH4E18rrOpZZB9FYm0zpM213R2onKHJ9HWIOmfwWwDq8+0h
	 z1qTS4JhlRITw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197A83809A8D;
	Thu, 27 Aug 2026 19:50:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] usb: atm: usbatm: fix invalid ci_range initialization
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178786021064.1820029.761555165031523021.git-patchwork-notify@kernel.org>
Date: Thu, 27 Aug 2026 19:50:10 +0000
References: <20260826133258.8306-1-kartikey406@gmail.com>
In-Reply-To: <20260826133258.8306-1-kartikey406@gmail.com>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: duncan.sands@free.fr, 3chas3@gmail.com, gregkh@linuxfoundation.org,
 edumazet@google.com, horms@kernel.org, linux-usb@vger.kernel.org,
 linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+6665d3db5fef15914802@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 26 Aug 2026 19:02:58 +0530 you wrote:
> syzbot reported a shift-out-of-bounds in __vcc_connect():
> 
>   UBSAN: shift-out-of-bounds in net/atm/common.c:382:32
>   shift exponent -1 is negative
>   CPU: 0 UID: 0 PID: 5987 Comm: syz.0.18 Not tainted syzkaller #0 PREEMPT(full)
>   Hardware name: Google Compute Engine/Google Compute Engine, BIOS Google 08/05/2026
>   Call Trace:
>    <TASK>
>    dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
>    ubsan_epilogue+0xa/0x30 lib/ubsan.c:233
>    __ubsan_handle_shift_out_of_bounds+0x36d/0x400 lib/ubsan.c:494
>    __vcc_connect+0x14b4/0x19c0 net/atm/common.c:382
>    vcc_connect+0x328/0x8f0 net/atm/common.c:498
>    pvc_bind+0x272/0x380 net/atm/pvc.c:52
>    __sys_bind+0x2e3/0x410 net/socket.c:1976
>    __x64_sys_bind+0x7a/0x90 net/socket.c:1979
>    ...
> 
> [...]

Here is the summary with links:
  - [v2] usb: atm: usbatm: fix invalid ci_range initialization
    https://git.kernel.org/netdev/net/c/a60fd8c6dbaa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


