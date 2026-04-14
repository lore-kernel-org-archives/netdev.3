Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146771C01;
	Tue, 14 Apr 2026 19:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776193235; cv=none; b=S7V4mQZ2bvz+oaCD/Eqg5jDFlp34ki0pswJnUFAXBtZDm3C8bnp6tJ7dMG3zJcdfFvadtAE25HUtLOtJen4gP+rm3xIC87K36J4ZA210rTUNhA8fTrot4abxfaLL9Dt0inkCkB8T+aDyzrMAT7L7KXSSIJPK66BpFxNqLAtToEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776193235; c=relaxed/simple;
	bh=Mykm9hRueAPJfr/VtpfghEozZR53LF/nt5+TltxdRgE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kxa+m5K2S+aApBM2AT7Piw/raJSUXN/SoqtlpeOeZkACwwdMmGeXR8KOMtuJWQD8HvdU8wf6AAO54NWF3AQWt9nOj/7zvhlQssAxSRGg4mtNKm4Pb7iw5VZcG1IWvWD41ZQ+t3y1848KoZwDOLOYc97Lp4XVIfBDPGK+ubc988Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gzr0VTzr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gzr0VTzr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EE46C2BCB5;
	Tue, 14 Apr 2026 19:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776193234;
	bh=Mykm9hRueAPJfr/VtpfghEozZR53LF/nt5+TltxdRgE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Gzr0VTzrFIKfsD8q6rp//bbEEXh671jeLHbIaR/gnn2YYq3wmwJUW+Ba21cAzXVE+
	 Vi1f4BO4ej1sY29Z6AhBdDVzr8s87cTk3P/eMDhnrpgYWwxH8HOHWo536gtJ23n+6b
	 9g6817G/Sj4X67SDc1QsypbCkIAmN5EHhIGvUpfcckh2SqBNRHoi3Dt08bUj9xt6WH
	 s34is0UrKsZz24EyQo4B7+0Nn7dVei0If4WjqcJ/U2QSBkyi9eLUrUmFKa4JRI+yab
	 MDP6CNwybvHtXJYScUiu2LkAUNMOAS9lsSUCVkaohKkbJd4a3GVjRet8f6sLNRVytg
	 KvAcrWK1GhEQQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4026C3809A0A;
	Tue, 14 Apr 2026 19:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: pse-pd: fix kernel-doc function name for
 pse_control_find_by_id()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177619320505.1427904.14006521896472811073.git-patchwork-notify@kernel.org>
Date: Tue, 14 Apr 2026 19:00:05 +0000
References: <20260414150948.744618-1-kory.maincent@bootlin.com>
In-Reply-To: <20260414150948.744618-1-kory.maincent@bootlin.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: kuba@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, o.rempel@pengutronix.de, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 14 Apr 2026 17:09:47 +0200 you wrote:
> The kernel-doc comment header incorrectly referenced the function
> name pse_control_find_net_by_id() instead of the actual function name
> pse_control_find_by_id(). Correct the function name in the documentation
> to match the implementation.
> 
> Fixes: fc0e6db30941a ("net: pse-pd: Add support for reporting events")
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> 
> [...]

Here is the summary with links:
  - [net] net: pse-pd: fix kernel-doc function name for pse_control_find_by_id()
    https://git.kernel.org/netdev/net-next/c/6bb6bafa88b4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


