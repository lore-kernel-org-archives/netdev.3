Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FB437881E;
	Sun, 21 Jun 2026 22:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782081028; cv=none; b=IvGaKGwJVlC1nXlm1i8R41yfQEGUOJC0i6OMsYnfWyyStHwy4YMLHA+hFboYHp0VCeVJlL3TjqihEch5b+gQjbuicBcNYySqYaOj2Xn/On5oBe8A9L+m5M2OYwK0YRqYX4l0ArH3bY+YIPBwBCy0h3hLFwepk7ubclQ3MEDDbcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782081028; c=relaxed/simple;
	bh=15B/lacSNFYA2OWblbx5KQn9S79opc/vc2/I8DKfx/c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uQxr2fKJbdRitVuAG3wfTXBFOxhmLkTFF2I6+8cy1pwDZwb00thG4Ag/2imRnoaWiZfS0m1Ch5hJwU0YhghKzgsmYoDhfkNyB9lhLHmVPPV/FYX02q+z1RH5FF6VNAlSeE+SJSWahFLZ+WRJM0HQe2gWRKUbCbGRGDrWBwZYxss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XeNl5Vpx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XeNl5Vpx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9422A1F000E9;
	Sun, 21 Jun 2026 22:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782081027;
	bh=SGNt+35FCNLvntUInR0SXGDQoWDIFm5v5divyZnyAA0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=XeNl5VpxxFpCCsPcp3mucx3jqdx3o3cQdcJG+FxNC1bxwogY8pMat/Kwp0Qlrr+NT
	 tPMmp22+FcSSDFLSSrIFPMhjZewp6lozJcg/HuFYO4IhCfOLkr7T8/sn/ii3CvE8W5
	 Dx5UgEpQspNnOgPF7oN4zxf2quY+qXzM5T0xHRRaCXnM3RiiZuIcIhKQ2Hsm47S+7v
	 8K0p0ef4XFrJSOFGs39PKhLpw9PspuGt99JQPoRI6bq3ePsgh3ahUoaaEgCamy7P7k
	 TVfRLZEUAxiSNJFr2YyNQ2OGkeCqCNHiSW9Z2CG1bBzb76rjYmeGgwUB9nid4z/DUt
	 8AJZIAM+eX3bg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1976C3AAA6ED;
	Sun, 21 Jun 2026 22:30:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ipv6: ioam: fix type confusion of dst_entry
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178208101866.524849.8650145418163928535.git-patchwork-notify@kernel.org>
Date: Sun, 21 Jun 2026 22:30:18 +0000
References: <20260618104336.48934-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260618104336.48934-1-jiayuan.chen@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, justin.iurman@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 18 Jun 2026 18:43:35 +0800 you wrote:
> IOAM uses a dummy dst_entry(null_dst) to mark that the destination should
> not be changed after the transformation. This dst is stored in the IOAM lwt
> state and may be passed to dst_cache_set_ip6().
> 
> However, the IPv6 dst cache path eventually calls rt6_get_cookie(), which
> treats the dst_entry as part of a struct rt6_info. Since the null_dst was
> embedded directly as a struct dst_entry in struct ioam6_lwt, this resulted
> in an invalid cast and rt6_get_cookie() reading fields from the wrong
> object.
> 
> [...]

Here is the summary with links:
  - [net] ipv6: ioam: fix type confusion of dst_entry
    https://git.kernel.org/netdev/net/c/9ed19e11d214

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


