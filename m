Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FEC45A28A;
	Tue, 21 Jul 2026 22:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784672446; cv=none; b=VugegCVdNvU/YyNei5iy1ywsXuMGqvZmNILHPod2Ibd7LY9vuFW+F3c8apwJM/uPmdIb0D/B8sKgquWM2CJVcsLECcePv4ETk2Bvj+4GwsT/4gBJkO7gJoaE/20QpYh5Tj878TBS+yOGepOwuIc0NoUTju+q3SBGntLUVjz/xOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784672446; c=relaxed/simple;
	bh=aDGcAFbaxJ7sZ4aSqfxi/AJv9sB3lrrmjZITkBZNPcs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Bih5Q0I+IOOgVfMbUJp2Be7Dd4YLgg/IjcO2GDO6Bc48I7pAEkfa3otBkh/k5GgAvB2RUZ52wGs11kdh19Kia2Q0GcUA4iQ1kqJsoq0Sf6kPWzzyCVAazDDj9kbUaUb/J3GJk5VEDpyrtwja15sN/MK7Lm0e5Uz9K5hPrKGfaYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V0ckJiRt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V0ckJiRt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 778CD1F00A3A;
	Tue, 21 Jul 2026 22:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784672445;
	bh=WL+d2Qg/4QdgDvZuDCf5tX9w+rHmaAqtzVcXeIn65qE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=V0ckJiRtiPs+hBecnSfGx1dyir1fgQG4gPD1HLY6rbMUDAmVIZPxExXFzimDwjSAa
	 vHFwG40Pn79hQTg8VWWFRV8VFb3nq6tfePJphfuuQilHgZQvkbqQrqW5Yxp06+8u1z
	 rHRkVz6gPRRHtfdRLQkBsZ+oOjQ6BmyJYKHwFmyIxtvShizxnzHSw5SxWZIbSvV9Cb
	 00/XraW0BY6piO+xpCG6OmGEgsHzvtKpuQ8r6TsHWkicqdJKNQtcymlRbuoZS+Zz10
	 Jbx4D4Bx07zGMdEisfWCC0HlFhvO2RIh+iyPIvAY7hcj0rS2jDlQYQRM9+9gipjtMG
	 DIzmSUjA+NIag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199DB380820D;
	Tue, 21 Jul 2026 22:20:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] nexthop: initialize extack in nh_res_bucket_migrate()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178467241464.1119846.16249715215886377152.git-patchwork-notify@kernel.org>
Date: Tue, 21 Jul 2026 22:20:14 +0000
References: <20260713221551.3344650-1-xmei5@asu.edu>
In-Reply-To: <20260713221551.3344650-1-xmei5@asu.edu>
To: Xiang Mei <xmei5@asu.edu>
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 petrm@nvidia.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 AutonomousCodeSecurity@microsoft.com, tgopinath@linux.microsoft.com,
 kys@microsoft.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 13 Jul 2026 22:15:51 +0000 you wrote:
> nh_res_bucket_migrate() passes an uninitialized netlink_ext_ack to
> call_nexthop_res_bucket_notifiers(). When
> nh_notifier_res_bucket_info_init() fails (e.g. the kzalloc returns
> -ENOMEM), the error is propagated back before any notifier sets
> extack._msg, and the error path formats the stale pointer with
> pr_err_ratelimited("%s\n", extack._msg). With CONFIG_INIT_STACK_NONE
> this dereferences uninitialized stack memory:
> 
> [...]

Here is the summary with links:
  - [net] nexthop: initialize extack in nh_res_bucket_migrate()
    https://git.kernel.org/netdev/net/c/6347c5314cee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


