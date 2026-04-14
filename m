Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D751A3D410B;
	Tue, 14 Apr 2026 10:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776162036; cv=none; b=hMmaKgJiBcVWqZ9Ltx9n5+yVB9uo8tv1AYzODXP43OALIjtmbHY/NxhYXDsPSgSbBW4ViJWX/vFq8jdhswPLAtFEUWvipi3oHIbsDeVtkWoeBDhLAybFzaiqGODGwNJ+fdEY+tBtDkW3IWsu/8xDQEVdounQ34KbHnjBsZag6Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776162036; c=relaxed/simple;
	bh=DB088bkm+R5WzfKl/khDK+zsssDou6km3IYDge0gM04=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KBL/uDCCoaX5EVYIEnfue876Es0Eg1iltiswq1qANdHK6RkC91uw8ofkJQTW+1TYnvVUqvo8WiJfgJlY6zeVcy5pwoou7uec4tPLzGDJmhhJ0ihrg95FKNZHBUYCaZJiJQQKDPrvY5IIC1fLCc/IWIKhPwDMZuKP/D4LBVCHrNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NzAizErS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NzAizErS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 073B0C19425;
	Tue, 14 Apr 2026 10:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776162035;
	bh=DB088bkm+R5WzfKl/khDK+zsssDou6km3IYDge0gM04=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NzAizErS7RdqwA5glbaZAR/AHwe+hpjztJoEJN8bfUPl1Zw0SiUsQ5PwfDQrtrTXs
	 h0T+9r8I+GTXi7ZtjO122qUfZ2dvf7OUwYUCql36lhUP3QE3flEMcN7wK3YOh0mvXD
	 MibOfTVp4SwleJUW0Dw4jEaKzLEPcOuGA22c5FL5ib72XxkHouqHUUWDCDHWU+oDmH
	 bZIpbODTr1VpoRcZ4EfpmcBc5Iw5O7DuobrHD8bJLFjzZ6Q58/XwtSPGgOOs6XVmYu
	 rTWAMYYgn+GALGeniyrQM4SqP4cxAGzBeKSzz8FTy2hCrxZ2S1g2kdMZfX2vGH8KP1
	 kXlZbe5Egg5bw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02D2A380A957;
	Tue, 14 Apr 2026 10:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: usb: cdc-phonet: fix skb frags[] overflow in
 rx_complete()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177616200580.811155.3079803654201633076.git-patchwork-notify@kernel.org>
Date: Tue, 14 Apr 2026 10:20:05 +0000
References: <2026041134-dreamboat-buddhism-d1ec@gregkh>
In-Reply-To: <2026041134-dreamboat-buddhism-d1ec@gregkh>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, stable@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 11 Apr 2026 13:01:35 +0200 you wrote:
> A malicious USB device claiming to be a CDC Phonet modem can overflow
> the skb_shared_info->frags[] array by sending an unbounded sequence of
> full-page bulk transfers.
> 
> Drop the skb and increment the length error when the frag limit is
> reached.  This matches the same fix that commit f0813bcd2d9d ("net:
> wwan: t7xx: fix potential skb->frags overflow in RX path") did for the
> t7xx driver.
> 
> [...]

Here is the summary with links:
  - [net] net: usb: cdc-phonet: fix skb frags[] overflow in rx_complete()
    https://git.kernel.org/netdev/net/c/600dc40554dc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


