Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBCE25B088;
	Tue,  2 Jun 2026 21:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780435204; cv=none; b=iepA2opNP+sLz9HYFmIY0ZQRgnHJdxp9E2l72d95D03SRyZu4U4p14gPWy45tDmozSfXcWvHSg72kazD9795Qi4J4o234svfso7uKArjJTy0YJf8dB5IPjBbrolkS0AolmZUyCOwu9N6q+5klHHSMSi7T9YnjytZ5XSnXw6SGpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780435204; c=relaxed/simple;
	bh=jUsIEH70+A2yS7esLvVSDG99NIDaJCY9szZqDiWen9Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=E+OHyvu0fpFjwI29qdl8qvyX1nuSG2ZD8ElD4DoZvuqpkR/gB5x5tWkLInT7fO1ET8sUMp+IC/05/31zEGCtYywB9lIr5KneQQXtHj3cmP/z8eHyDw/PBzPJMXViCf7BHmaqkLDc+b0FhD0c/3P3aePSJqhh8YdC6rW/JB4sW3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QMVMhcLw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QMVMhcLw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 893CB1F00893;
	Tue,  2 Jun 2026 21:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780435203;
	bh=dfebTjwExKvQJQi7Hu9+LLd0ZURbyWtmZItEOJJW5mM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=QMVMhcLwpZgk9ZGqVDmF3d85jcpTUAIYGJ3xomvXHZbe1EQjJJwR7NEEAgEvMrdvE
	 Iu07hTmqFaL2hk8OgRXkznwye9nqN1m3WcC2MVv0OISClPmO7cRkBjrLqFVBck/Imk
	 8nwULEI1/C+hyyNCkjZjiXw4q/UHa8NChBWZ/AYGnIgwEOwiRuGyzNDaAni3D8YwLE
	 N3PsKuNyYCxH3iXLPhYWf6s5IEi1FEHXrzFx8mw5c19q9u1cbJQ0k0AU/ei+sPQJRc
	 9fK2Cc98dJU0XXK+po7JtZDgs8MbtFF7jT7g9CR6sC/cV5t31jpKxk37oCZQCF00y4
	 MLCVlvipM+b2w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A343811A72;
	Tue,  2 Jun 2026 21:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: lan743x: permit VLAN-tagged packets up to
 configured MTU
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178043520515.1054744.8222539332561002723.git-patchwork-notify@kernel.org>
Date: Tue, 02 Jun 2026 21:20:05 +0000
References: <20260529210300.433135-1-davthompson@nvidia.com>
In-Reply-To: <20260529210300.433135-1-davthompson@nvidia.com>
To: David Thompson <davthompson@nvidia.com>
Cc: bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 29 May 2026 21:03:00 +0000 you wrote:
> VLAN-tagged interfaces on lan743x devices were previously unreachable via
> SSH and failed to respond to large ping packets (e.g. "ping -s 1469" given
> MTU=1500). In these scenarios, "ethtool -S" reports non-zero "RX Oversize
> Frame Errors". According to Microchip AN2948, the MAC_RX FSE (VLAN field
> size enforcement) bit determines whether frames with VLAN tags exceeding
> the base MTU plus tag length are discarded.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: lan743x: permit VLAN-tagged packets up to configured MTU
    https://git.kernel.org/netdev/net/c/8173d22b211f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


