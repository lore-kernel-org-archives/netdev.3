Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A25B363C73
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 01:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789693278; cv=none; b=gY+Ziixdg5M308EXCSdbb4j2yBebpDsytWm8AQ/JxkFjPLjuwjl2T7Znl+OsuxfRxzaQhA/CFL+VASHZGVqdfH6I8zsb3deBKhR4FpphvZGUktkEdNiXL2ZHlXeYn9N+K+GyC7nXlUA9T/FHf2KWPmr+U3RbQ0xzUOAJy8hp7XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789693278; c=relaxed/simple;
	bh=qI0SOybqk4aJuMrp6f8kXrB87lMMPBPHW+rh6imQPgw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kkG8/8OagXq//JuDGEyTk02Nv1pINTqWN6qwixcDaQQWEQmz7irpdY8UHfsw9WHCDtJm/bqAsHGdW64OS5SY45syxp+Bd8D0Fcog+RC1QMljtZYhADPkofs/QP+fj7MNsRRF4IM8c8uKTUO7tka2FnDMbS6vgJc1m2bDpCChEfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U9jX0ipg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U9jX0ipg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED6441F00893;
	Fri, 18 Sep 2026 01:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789693276;
	bh=AfNrAyHoftWyR4vTo5Fd9AKud/wWBgBDIFICSAvw8G0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=U9jX0ipgfic37SSrmMGuqDsEFOiA2WgnP72Ejq4uSxcOj6FL+4aWxtxfVMx5OpFxi
	 fwpQJrQjZ1IaJRwa3+XNV+tif+H+2o3sFScX6Wpcm3gG/kogIiF7tPl53MFfFO4lpy
	 wSk1SuYitGrsh18qjHQkEM6lnKO27o8dPL5FWUH9TRcdPVcTGzjIcln8QwNLGz/hOl
	 6EBeO0xklBk2VmWUURqe6zTqHPFOLrXo8IJEIpIn74mLnjJN9smeqMES1FRlY54Gsp
	 MPYjr3rIO8nRM1pXHUphY3OKsTtSX7aTscfHesjbapF9qPXMLKl9/ILxiUOC9EQ9HI
	 7wn5vUd+eDCfQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93927380820D;
	Fri, 18 Sep 2026 01:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] octeontx2-af: use seq_file for rsrc_alloc debugfs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178969320913.204321.4436808326639045243.git-patchwork-notify@kernel.org>
Date: Fri, 18 Sep 2026 01:00:09 +0000
References: <20260914020521.146-1-thy15333007817@163.com>
In-Reply-To: <20260914020521.146-1-thy15333007817@163.com>
To: Heyang Tan <thy15333007817@163.com>
Cc: netdev@vger.kernel.org, sgoutham@marvell.com, rkannoth@marvell.com,
 gakula@marvell.com, sbhatta@marvell.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 14 Sep 2026 10:05:21 +0800 you wrote:
> The rsrc_alloc debugfs reader writes rows directly to userspace without
> respecting the caller's read count. It also uses the current row length as
> the userspace stride, which can corrupt output when rows have different
> widths.
> 
> Use seq_file to handle userspace buffer sizes, offsets, and partial reads,
> and write output columns directly to the seq_file buffer.
> 
> [...]

Here is the summary with links:
  - [v4] octeontx2-af: use seq_file for rsrc_alloc debugfs
    https://git.kernel.org/netdev/net/c/39c6580765da

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


