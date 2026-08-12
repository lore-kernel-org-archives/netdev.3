Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D58131E822
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 00:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786495851; cv=none; b=MiBYIB991TchpLLQ4hIoGNgDcOUOmc1zRY2FQefLOpF1RYmHRkWvetST43cF/DCkpE4bCRadk+YT+fNSUNVHdlphrNAa7dGA/irbGNGOUOpmBvEZcz9nnyUCqp34nqMfme3Be9QchF1XPKzTSIfim4VFmn0FFWfav6Yw7ULDDd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786495851; c=relaxed/simple;
	bh=EDWqp01h0IqbZTCbvLld/HoO1D725jYGBGAqTNtAFy8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=O/BiMlkc5CpnDU21mHiDU2Qb2mgAcFDc4FrPv5lV2UwYRkMG8LeGq2bVMfEYYdihWleWgwMqeGfgJ+H5kR0HyKGW+nDl6PpS47UrQKryofJ0pcGGzqUVXk4TaFEINQ920GSTmh8FGZWX6X9ffiH7I9lXf4aFAxdGo21nw9thFE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=goXRt/OE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="goXRt/OE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EAF81F000E9;
	Wed, 12 Aug 2026 00:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786495850;
	bh=AERHQee1PYYPeUfsIstylas6Z61xnFXh/9sDf2FFWPE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=goXRt/OESbyhFCSMV67zxVWRCE2I5YIfSRKYUDSCU8tzt5YRy5NW7Oav4Gt5cDJox
	 OO62fpzUY0Xtej7YS+lTIEfOYTddIsH3b/IMBsERJ6DVuMwqzAPG2yAjbV/PqMPnWK
	 n005h3UoEPDjbGs3Ur+8iuD813LfJGHePNADTQSGMGOy93g07JHEngsbAvrgqtchQ9
	 K/O/cRps7Ge3KRbCmaCpJeaOqbIaVrwsXg4HBWfik+9xkXOp2CJZujmDg3SQczNcB4
	 ZHmejPstXmUG24pbQC2t+eyf5r0DwUtIcyLenIIA2JU1EWYZU4PHCEiXyaGEY/YqSf
	 l6FNAolYUB/lw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197F53809A35;
	Wed, 12 Aug 2026 00:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] af_packet: Don't send zero-byte data in
 tpacket_snd().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178649580565.1217141.15269126551177731579.git-patchwork-notify@kernel.org>
Date: Wed, 12 Aug 2026 00:50:05 +0000
References: <20260810150447.1220864-1-edumazet@google.com>
In-Reply-To: <20260810150447.1220864-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, willemb@google.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, syzbot+30b93b6845b19cc38581@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 10 Aug 2026 15:04:47 +0000 you wrote:
> syzbot reported a WARNING in __dev_queue_xmit() triggered via tpacket_snd():
> 
> skb_assert_len
> WARNING: at include/linux/skbuff.h:2753 skb_assert_len
> WARNING: at __dev_queue_xmit+0x21bc/0x4970 net/core/dev.c:4781
> 
> Call Trace:
>  <TASK>
>  dev_queue_xmit include/linux/netdevice.h:3448 [inline]
>  packet_xmit+0x243/0x310 net/packet/af_packet.c:276
>  tpacket_snd net/packet/af_packet.c:2907 [inline]
>  packet_sendmsg+0x28d6/0x4eb0 net/packet/af_packet.c:3134
> 
> [...]

Here is the summary with links:
  - [net] af_packet: Don't send zero-byte data in tpacket_snd().
    https://git.kernel.org/netdev/net/c/6bcd76c134c5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


