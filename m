Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B265345EAB;
	Thu, 24 Sep 2026 02:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790218291; cv=none; b=hKX2M1GBtmXMHUCgc3QWCztKqHDOJya2RWoibmyGajKYeSkGNj0LGVgSJj4cQWOWS6B7ET2fNz2Tg6xU7idnn3ebVaCJS7Vd/A5WL/0mev2L1QG6Skk9Ka1DT7cQLdiWhpPx1vfPKSdj/4YEZ2+U2beuJhdulBgPlVuSdtC7G/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790218291; c=relaxed/simple;
	bh=aRTewQAuqqf+NpWK+iA3dfbOa+iCDf9kz8F+YlIiAB4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=O+3xvTc9fBdpvo4ChpoDdLRKOpKPE5BPoCmMsiSt1KFdSrxQk854r7JIq99W/VdFVKQorw3S4hZFDV6e7KUe7k4B0XubbrIBQRGCpzHaNozaakLAWKWAXcCOD2R/s7ektGTwy9qQNttpxP8Hn6NAZlvdhwIV15KybS3BiTsXH1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g1o71yad; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g1o71yad"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBFFF1F000FF;
	Thu, 24 Sep 2026 02:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790218289;
	bh=V+DyMxCm79QXhTSU+/xCePUBWj1G5fa7f8qubpZI7rs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=g1o71yad5x/KpsPBkc0/8NcdWYfEiQdRIzHmUPWpE9QeYAOlqd7CAG7ZD9rH5jBGM
	 1e6vrm41ZU2OCIv+YsJPHNUmYqtn6CQvz8XSfT55/bwyEJDxn2RnFevh2lUuOmC8XP
	 RHejnfYYf2lTJYe/wcxbH3uGVcNbmUN1UluxxvZyWO6KFsZRlKi48Adigdly3bKrsx
	 vdY6ajgmqeXoyfLiW1Qg8pdMtgdTjMgJlxLv7Jy6nkTHxhEQzs2sQO1lKBfbtFUQlI
	 +FaQsKussUDrTXI6bDP/GaBS/xUjtkbd6FPE6IykdLshsXZxLLF+a5lMKrY/EUEkUM
	 zpw/cI/gSkNYQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93C9B39E9611;
	Thu, 24 Sep 2026 02:50:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: xps: reject an out of range traffic class
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179021821927.1291983.14069798990944250332.git-patchwork-notify@kernel.org>
Date: Thu, 24 Sep 2026 02:50:19 +0000
References: <162DD16F-54C6-444A-9E09-0B8CB3D591F2@doyensec.com>
In-Reply-To: <162DD16F-54C6-444A-9E09-0B8CB3D591F2@doyensec.com>
To: Norbert Szetei <norbert@doyensec.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, kees@kernel.org,
 kuniyu@google.com, alexander.duyck@gmail.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 21 Sep 2026 17:03:57 +0200 you wrote:
> Only the entries below dev->num_tc are valid in dev->tc_to_txq[], and
> dev->prio_tc_map[] may only name classes below it. netdev_set_num_tc()
> lowers dev->num_tc without touching either array.
> 
> netdev_txq_to_tc() walks all TC_MAX_QUEUE slots and
> netdev_get_prio_tc_map() returns the entry as it stands, so a leftover
> entry is handed out as a traffic class >= dev->num_tc. Taking that
> class from netdev_txq_to_tc(), __netif_set_xps_queue() rejects only a
> negative one and indexes an XPS map sized for dev->num_tc classes:
> 
> [...]

Here is the summary with links:
  - [net,v3] net: xps: reject an out of range traffic class
    https://git.kernel.org/netdev/net/c/4da3b7b8b50f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


