Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5483EDACF;
	Thu, 19 Mar 2026 16:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773938419; cv=none; b=GOjN64hjNU/vNLPpdixEjBaYRwoX1y6hfpfrqVbT2AzsVSRY9M4JfZKvAuj7p+M8pBHJmk5enBA55F0+yH8yryqx0KFyLolqlf4UBUaj5iSlEkpKH1rcHqOigW48TZXwGekAk3GezLYufEPq1hzD9loi3BxfpCKEGew+2JSlBhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773938419; c=relaxed/simple;
	bh=Jd1OQsNo4DnD9/PJaR0H8lGXeHVq+G+uJrv+cuJs3aI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DWHPR5y5sNmp8O7u6OZ9n6B/SI2XTFNewFIHhlzCyoXFcjzJ47PM0e4wPfGXhZI+S29chNWVuWUIzppLsAaThqm0TianxPljvdpHvAE5AuDT1kmnb1S9hGyabCWKM4wrGyRniK+uWQ+1Mj2Fh7dmKrAOuIxSTIavC3lXkrWsjIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kr3buVA5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kr3buVA5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDCAAC19424;
	Thu, 19 Mar 2026 16:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773938418;
	bh=Jd1OQsNo4DnD9/PJaR0H8lGXeHVq+G+uJrv+cuJs3aI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Kr3buVA5IoiE4pWEdR5Y4grd8QLtHOsJEFc50NEgJn1FPTXJZ5CzMwrKQ4HJBL8hP
	 2w6F13c1WBTeX0oJ83EHvBM6e8PovTquA2rVOrXezriftcpH3oGUrt2/Cci/5sgYpi
	 niL943vra13+VlQUvUo42vsvPMwVj4aWZWA4JZ5wIZ91eCgrZskF6jBq/9iI0/0vZa
	 nXJntZ6yXGySKKNH+EEwjCXaVFhutf5oafj8Dx1fyM8oL6rqFnwzdpofpp7eUXKL81
	 8e43nPnFsNdF359RC2i/j9OQnU+Bg0ErMiM++qsDSGVWC9MMXbtJK4LxGLOv1IpxTB
	 LSqGTbrahZRUw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02E0D380692A;
	Thu, 19 Mar 2026 16:40:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: dsa: bcm_sf2: fix missing
 clk_disable_unprepare()
 in error paths
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177393840950.1701817.11167614861040516729.git-patchwork-notify@kernel.org>
Date: Thu, 19 Mar 2026 16:40:09 +0000
References: <20260318084212.1287-1-mohd.abd.6602@gmail.com>
In-Reply-To: <20260318084212.1287-1-mohd.abd.6602@gmail.com>
To: Anas Iqbal <mohd.abd.6602@gmail.com>
Cc: jonas.gorski@gmail.com, florian.fainelli@broadcom.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 18 Mar 2026 08:42:12 +0000 you wrote:
> Smatch reports:
> drivers/net/dsa/bcm_sf2.c:997 bcm_sf2_sw_resume() warn:
> 'priv->clk' from clk_prepare_enable() not released on lines: 983,990.
> 
> The clock enabled by clk_prepare_enable() in bcm_sf2_sw_resume()
> is not released if bcm_sf2_sw_rst() or bcm_sf2_cfp_resume() fails.
> 
> [...]

Here is the summary with links:
  - [net,v3] net: dsa: bcm_sf2: fix missing clk_disable_unprepare() in error paths
    https://git.kernel.org/netdev/net/c/b48731849609

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


