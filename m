Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F28915E8B
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 00:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780966208; cv=none; b=OxThCeTphxLRdX6jyzvkRCLc5T3L0JBFhcVm+gmgN+fn2uilj7zyZCHuYWni0Forcp9xK3Z4/cDlW70k21V7N/9qo3E+JF0BQ1IO5q8OCQ3HqqG+hgU4L3HqQOUKblQ36SOaqrGioFRnL1xlEUhjAaQ75sye0s/9342ImWKv4JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780966208; c=relaxed/simple;
	bh=CGv12sGWgvTsMe3tUUkZv2uVtgDGrxGHxoOAfIvRjqY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=i3l6smvPWLMD2IamdxUVkdqTzORHyF06wAT2ZReGD3tSUSzAxmE7yNZhDHWWGGRWJA+YszBGsmvCW+tOIk+uYp5daf6ZMVpVGzKzaKy0jgUWhiVXsknFGW61xlAvlhAckpDLA6L1QNlkELK62DGDatD9CUC54X2bEzCA/b+X+yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nxCFhPVJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nxCFhPVJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADBA11F00893;
	Tue,  9 Jun 2026 00:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780966206;
	bh=4BRXMV3z09C+VLLFp+LaCDk0k636ZM/sYVGzBdOde60=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=nxCFhPVJxbWAm9zofD/TeEXR0Z/vWCUPbCAxc0vkzG15bpHR85+3dWlizk73kP+my
	 GGG5PaDHK4X+dc+r8nlXzBSlDwOJ2FDpf45Vit4VnWSQrAwI1U0RNJPLK0zrm2c5Yo
	 pgAFecJEB7f2uXCEBPfvrZrpMApNhmG9Pwm5O3LDJkwitrj6OSX4Am6JFEHHmDV+5B
	 rwGAnXfFX2Og+jued0/nUOYtI0X8qumuwOdCBNJcQVw7tH74ClmOYfYYbD11EWx6iW
	 hktvwQ4xI1DNWkS8BK8x1gUUVRO9QV+hFb7rwkAfQMFzmgti6/nqg6y1oSLRytiotU
	 l6bO6VuRfiaYA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939D83812FDA;
	Tue,  9 Jun 2026 00:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] netdev: fix double-free in netdev_nl_bind_rx_doit()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178096620539.1733035.1756660792083140288.git-patchwork-notify@kernel.org>
Date: Tue, 09 Jun 2026 00:50:05 +0000
References: <20260606012124.4060950-1-kuba@kernel.org>
In-Reply-To: <20260606012124.4060950-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 sashiko-bot@kernel.org, bobbyeshleman@gmail.com, dw@davidwei.uk,
 daniel@iogearbox.net, razor@blackwall.org, sdf@fomichev.me,
 willemb@google.com, kaiyuanz@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  5 Jun 2026 18:21:24 -0700 you wrote:
> Sashiko flags that genlmsg_reply() always consumes the skb.
> The error path calls nlmsg_free(rsp) so we can't jump directly
> to it. Let's not unbind, just propagate the error to the user.
> This is the typical way of handling genlmsg_reply() failures.
> They shouldn't happen unless user does something silly like
> calling the kernel with an already-full rcvbuf.
> 
> [...]

Here is the summary with links:
  - [net] netdev: fix double-free in netdev_nl_bind_rx_doit()
    https://git.kernel.org/netdev/net/c/c849de7d8757

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


