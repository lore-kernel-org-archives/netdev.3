Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793920810;
	b=oty8uy1KVwNsKSmMhqaj2EkUpDIE6uuT6ru+hJVeH+EyDgJYL960HY/SClHWVjnrPnI5
	 3f1Yxa7Qq30se33zDBepZZ+jDe6Jt/DlKK2TXDLmiFOQhuoHJ6IOodt9C3o1H7dRnvzlX
	 oRnCh7JJKq/mWqS6g2rFmv8GJ5qbBJThPCYtmGTB3cH8aSy03D1v1OGWjxwuEODlj+l1t
	 hkAP16hp1sqHDdvFt2DxKRNr+bwMb2pi5XH3Y41QcvXwOUxcFwMl2DTO13pNlRuaQWWWt
	 kOCtXVQv7C4L8xHcEp9VGf78f7TC8TB/vVSjPIsyt64GnaN45RfU/IDp/6zJE0IM8ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793920810;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=I3LriLqt5gfNkaS3ODQStGRNo7oBu1IRuFacVbTR7Sk=;
	b=eAYSTB7yjpexYf5YonOtcvKojbIIKIt8v+L9Ui50Xw2GDReqFBvSybMpUPQpEgcN9Lp0
	 WwyNT3nDeuE00aURcr1BqWxqb2VYcpOBzYIvGRQgDEqfE0y+zcpfxcLxggys0t20TAl6i
	 lPmjDgoeNnWuk3WatCT6pkzw3Wtk0uhHCGfHyqa+iBJl348PXM0XvDbzY2BqanHPwICJW
	 YsNkvzLAqfH3Yh0WEFkMM6m/hPptPH63dIzm3+vPg7xZyJM3Mx7innNH11hBCh6oipGa0
	 u1ZUJcwcLllVI496HjU8WsJ5gONLTygBrb+hAZMu9Tp6kwgkz9H1NfwlhvtXcOj3MAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cazbQAW2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AB8606A332;
	Thu,  5 Nov 2026 23:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cazbQAW2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4A631F0089F;
	Thu,  5 Nov 2026 23:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793920809;
	bh=I3LriLqt5gfNkaS3ODQStGRNo7oBu1IRuFacVbTR7Sk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=cazbQAW2XKEPN8Q76nPW8PkF45tZBYwYH7TyB4enSr+6rPfO8NBgC0KvaWkZhqvC0
	 HoT0+/uPKEIxMUEW2mwy20b0G5AA58hXZfvZHFYU6noRaQpldXB+Sas5Y4cn+V4A6x
	 xu0cldn3SOCOJOTjbwjNe0V3PXMH9Cqa/HE6hFyhUdphG6bRQqAGmmOQg0A1/mIS1+
	 fC5ORl3+r/8XFYCi5ewYlBMOTfi6IXLSaKhwFQR3C1f0CsGhnviSKZfQGmT8cCfkcG
	 N/uOecMmZk1LJ4VLGdPNYW9at92fHQ6yG0jjgGOaMeLbc6UAveVdifqqw4OEILQVyE
	 4AiUvXEx0VA8w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D837A391B1AB;
	Thu,  5 Nov 2026 23:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] netdevsim: reject port addition and clean up
 ports after a failed reload
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179392080842.233492.7945739633569188610.git-patchwork-notify@kernel.org>
Date: Thu, 05 Nov 2026 23:20:08 +0000
References: <20261030001444.289973-1-omermetekaya0@gmail.com>
In-Reply-To: <20261030001444.289973-1-omermetekaya0@gmail.com>
To: =?utf-8?q?=C3=96mer_Mete_Kaya_=3Comermetekaya0=40gmail=2Ecom=3E?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: kuba@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, jiri@resnulli.us,
 syzbot+88435e204734072bf39a@syzkaller.appspotmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 30 Oct 2026 03:13:20 +0300 you wrote:
> nsim_drv_port_add() does not check devlink_is_reload_failed(), so ports
> can be added via new_port after a failed reload.  nsim_dev_reload_destroy()
> returns early in that state, leaving them behind.  nsim_drv_remove() then
> hits WARN_ON in bpf_offload_dev_destroy() and a subsequent use-after-free.
> 
> Block port creation with -EIO when reload has failed, and delete any
> leftover ports on the early-return path as a safety net.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] netdevsim: reject port addition and clean up ports after a failed reload
    https://git.kernel.org/netdev/net-next/c/39c23556e79f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


