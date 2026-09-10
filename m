Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AA231F9A8;
	Thu, 10 Sep 2026 01:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789002069; cv=none; b=JqM1Wu7vyictajhaK7xecfC59PzfPOcd10ZmnnuE8h1WCR/xS2FQfkm+q/xdGBtMumWTQcs8J63Kc9GvAfRb1les+2zq95UclUH7CJEFstrD8AlG5Ktdz0odCbDqX6HsLj04wmmYvcjGwzSho6L073bH9JCY3uN/5p4wMS8sfQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789002069; c=relaxed/simple;
	bh=uGIKqBFiardxryf1GQo1phZUgI0L3pwR9k1YeRaiGWg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eq/lTQ9eTKXJBtiLvjc/MgeVpUV+KTiFGIraSGXBlznOyU3g9i8ChDMy+eIrDjuHl+uKjJAbs/9BgCVGm4Xr29kM9RqdXDhoCFwh9wSIO/mHqsWRJQ0ypCP4VOn8+1BNV9IdKvwG9tfewdv2uPQqFn20VcuCSDkw0vCmpzAZX5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nk8lNzPV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nk8lNzPV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D7401F00893;
	Thu, 10 Sep 2026 01:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789002068;
	bh=Wf0FXJ0mjaw37uiiaeSOBJCsdo59cFhu0Vnlio9KzMM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Nk8lNzPVFRKttHwSIdJvubnpKoBKEvCRznHnx5RNSYkme9zItCt2wS9ywZYqpWrtj
	 eJboeNRwPwRotFcpKe3ImneXKuzwbZ24Dn/RP4mi2jAY+nQnOj8PwydQhTD8mP4YGw
	 Ors2FZXWYD1NBUOsLLWfMyxBUnRTOe+ndIV3CEAiMANWXCJu1bJXwj0XDT05vt5dgA
	 huyWB1wLhhwdGn9zQ+Ycy/ELeJHrhqBtlznPNPJdsXUEsN5VxiM8UNK21hlZVyPsqW
	 pbq7v11E8ccuClSyh+zQOauisKhG8XZnalwoJOEyBVCYTFBfqkZDqxbTXF1V4xcH87
	 6K40nsjZ2Ofcg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93873380CEC5;
	Thu, 10 Sep 2026 01:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3] net: dsa: lantiq_gswip: SGMII/2500BASE-X and
 flow-control fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178900200612.1131357.8936201184825979176.git-patchwork-notify@kernel.org>
Date: Thu, 10 Sep 2026 01:00:06 +0000
References: <20260907134818.16670-1-havran.jan@email.cz>
In-Reply-To: <20260907134818.16670-1-havran.jan@email.cz>
To: Jan Havran <havran.jan@email.cz>
Cc: hauke@hauke-m.de, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, davem@davemloft.net,
 daniel@makrotopia.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  7 Sep 2026 15:48:15 +0200 you wrote:
> This series fixes three issues in the lantiq_gswip / mxl-gsw1xx DSA driver
> found while bringing up a MaxLinear GSW145 over SGMII on a Marvell
> Armada 7040 board, with the switch CPU port running 2500BASE-X and the
> user ports at 1000BASE-T.
> 
> Patch 1 reorders the SerDes NCO clock-rate setup ahead of the SGMII shell
> reset. Without it, only the rate the switch was left at by the straps or
> the boot loader links up; the other rate comes up but forwards no traffic.
> 
> [...]

Here is the summary with links:
  - [net,1/3] net: dsa: mxl-gsw1xx: set SerDes NCO rate before SGMII reset
    (no matching commit)
  - [net,2/3] net: dsa: lantiq_gswip: handle SPEED_2500 in gswip_port_set_speed()
    (no matching commit)
  - [net,3/3] net: dsa: lantiq_gswip: fix GSWIP_MDIO_PHY_FCONTX_EN value
    https://git.kernel.org/netdev/net/c/59fb389ad6bf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


