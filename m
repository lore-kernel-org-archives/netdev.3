Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2230AE573;
	Wed, 20 May 2026 00:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779238196; cv=none; b=Famoq5ym7dn2ACWPFNlVTY+BdzYRlrc2WdvSD3MtdjbbSE/j4lRhJi0Ee2ow3/O003ktn+gkzvJrQHuDpnxSb9H8hAmKfp17SHkzaanFv/YlcF5P9hfBAV89XdTMqLk9y9bkKSUx51cub4zxUsNHm9AWwFXlIVhqZU03WGxjBLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779238196; c=relaxed/simple;
	bh=lBfm9tSSe0sbgpengcGxja9yeUM22QBkM9dkNrYcNjc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SMc33yQqdt+TsXRFtg77Qf6fg69HeD0+plFtPec8gx1BxFHrRNrQuXbNKd/DxPS93BR91vZpmDVtlVfwlSa1bi5thfJ+7ld6A+LR7xKSSqKmlQ4stg+OPvxXpaQrjjAl640kmU2bn15eb0At8dTHqy5csEtdJQNwa2aH1fDmoEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fN4OIBan; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fN4OIBan"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCC9A1F000E9;
	Wed, 20 May 2026 00:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779238194;
	bh=0mq7kib0N1oJE7BLzLydBG9O6cvohSd5MZVgGw55/X8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=fN4OIBantfenbOAJ1Mt3Qe3d8rUabM/SQo2v5hx7QprQVpcqFJpq/Hn3WPPysIcH7
	 SKz25/9L4pcIjLavZv51ADJn6RNrAZIx1C+4eNageGJuSBz4wEXtXszPc6rpoDkwVF
	 jxec6E0IpG5Ug/BWrKL4C8eAObCpjbFT6t1roOuTPnm9rZbAJhLCFQ/wLABKutCb26
	 VewtahUhony2/EPQzeUeJDeh2rgJynEkH9Idbah1WZy2umWTf9iWcoQuf6vNDyB9ag
	 ymNSOPl0f+e9kxm4axKvWo449yiaDfwYqEOExQjRJcn1yFswaqu7KbFR3q59JnPGm5
	 4kx9twgXM+ANA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0B04383BF53;
	Wed, 20 May 2026 00:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: pse-pd: fix sign on -ENOENT check in
 of_load_pse_pis()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177923820539.2936298.11897991390696602983.git-patchwork-notify@kernel.org>
Date: Wed, 20 May 2026 00:50:05 +0000
References: <20260515143103.1721888-1-jelonek.jonas@gmail.com>
In-Reply-To: <20260515143103.1721888-1-jelonek.jonas@gmail.com>
To: Jonas Jelonek <jelonek.jonas@gmail.com>
Cc: o.rempel@pengutronix.de, kory.maincent@bootlin.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 15 May 2026 14:31:03 +0000 you wrote:
> of_count_phandle_with_args() returns the count on success and a negative
> errno on failure, including -ENOENT when the "pairsets" property is
> absent. The existing comparison in of_load_pse_pis() checks against
> ENOENT (positive 2) instead of -ENOENT, so the branch is taken for any
> error return: legitimate DTs that omit "pairsets" trigger a spurious
> "wrong number of pairsets" error and probe fails with -EINVAL.
> 
> [...]

Here is the summary with links:
  - [net] net: pse-pd: fix sign on -ENOENT check in of_load_pse_pis()
    https://git.kernel.org/netdev/net/c/33d35975cbea

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


