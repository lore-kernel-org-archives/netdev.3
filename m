Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794279316;
	b=LiiE8jJUd3m6PR+XLPrRfuJGEqFkD1P7Wxq/qfPFb16RsS8cSuckS+eV2ujHfcq9pfKk
	 LicrvthgxGMXa67MoNXA/rFvHv0M2aag+FMR7vyN5gIbF3LZFbnAXxVooGIX1+jyHDFDV
	 eUZtMEef7F6lBngfN2tq4lwY+ME9fQ3lccYeB572QcJHguKnEhgvtOEfAdEWDmHUFJoKU
	 Mf1qM2SXGRHLbTS+LsKy+rUcO6u6EAIV00AKrETyUw2JcWJGzg0w+LsX1bM5B7BI1HYH1
	 yjcYsRkVak+WSqrdRNABqjBTWvInsye3aA2YiCJ/22HbOJwVnbqAUGjLdKEzfmVIPsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794279316;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=oJaEuoFNLVSbavjQsEt3AA3w6CDlj0c674f+jDJSa18=;
	b=4L0t3vmNDmUMVFY6Oh+6Zuesp660VB+2QWxK4OE1J73mo4nXwFnjqxF1x63Rt2EatSJX
	 HGq0mQ4d6Wi32mBbryMiXF5fcWMvsJc+Mz9xBwFDQigqF2/LKRbrqmz/FGTSnJEoiAEyh
	 56B0HXjt4lfs57wt8vRd7bvo7N0IGkKRujfnhRsUFxqdKY2Atdx/5ODNkqoZk9OgQib6V
	 lv4l5Na+NrKlPJAwk8zQRGpw15VrMS+AOqaw9W1VkTWb3LU6jkDpbLQ/yI3cvjlz024PG
	 dtmcDjQnbtOsMJ8qnGiRTKU/KmzgU7agqXviNkxRO3nIQrXw3vPLx3MxS/OQ04TtBCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="aM/H+2BN";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFFF606B0FD;
	Tue, 10 Nov 2026 02:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aM/H+2BN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29F401F0089F;
	Tue, 10 Nov 2026 02:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794279316;
	bh=oJaEuoFNLVSbavjQsEt3AA3w6CDlj0c674f+jDJSa18=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=aM/H+2BNJs9cSn6tDl85nJsvj5sxjfAFnSN7kshrWMgjBE5ZERnOsuk8n3ky8zMaW
	 bbgf1ABOR6a2MK06Gzp87FKXDvGF44EOhendcL1tKygax7lAdluiDMPA1t6duggv7x
	 Ii/UOASLzhbB4YSRaA/mT069TeX3Szykldmcb8hQW5zpxBwWlHyj9uz6hd8XakY2rI
	 TznoWeSWhW668cjxZORyRcAeyLmEzaufh+2R1GH1CDISRea5L5HrrSw9G7edt4tcuB
	 jfu65XbgQOrgmuYp3m5AdZFp1sDnh1WT1hIOwwmCr0H/wgoRUlFdMiyfYEMex402N0
	 Ic1/yKq5J+ggA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 20F91391AFCB;
	Tue, 10 Nov 2026 02:55:16 +0000 (UTC)
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
Subject: Re: [PATCH net v3 0/3] net/sched: taprio: fix RCU stall from replayed
 schedule entries
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179427931466.3612825.9604247532140652999.git-patchwork-notify@kernel.org>
Date: Tue, 10 Nov 2026 02:55:14 +0000
References: <20261104141713.355958-1-krystianmkaniewski@gmail.com>
In-Reply-To: <20261104141713.355958-1-krystianmkaniewski@gmail.com>
To: Krystian Kaniewski <krystianmkaniewski@gmail.com>
Cc: vinicius.gomes@intel.com, jhs@mojatatu.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, vladimir.oltean@nxp.com, vedang.patel@intel.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  4 Nov 2026 15:17:10 +0100 you wrote:
> syzbot reported an RCU stall with a software taprio schedule made of a
> single 127 ns entry. When advance_sched() falls behind, it replays every
> missed entry inside the timer interrupt and the backlog only grows.
> Patch 3 makes it continue from the entry in progress instead.
> 
> Patch 2 fixes a pre-existing wrap of the cycle-time-extension sum in the
> software and txtime-assist paths. Patch 3 relies on it. Patch 1 prevents
> a saturated extension from handing over to an admin schedule whose
> software timestamps cannot be represented.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/3] net/sched: taprio: reject software schedules that overflow their timestamps
    https://git.kernel.org/netdev/net-next/c/57fb90fed7d9
  - [net,v3,2/3] net/sched: taprio: prevent cycle time extension overflow
    https://git.kernel.org/netdev/net-next/c/593632c1e1f5
  - [net,v3,3/3] net/sched: taprio: do not replay missed entries in advance_sched()
    https://git.kernel.org/netdev/net-next/c/7a48731e43e3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


