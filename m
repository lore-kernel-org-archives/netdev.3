Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793607822;
	b=freBl5NaKGXTfR2zYHXOYH4zkdRwH29eonrbsyEoV9ewM/yQ/BcRtqOheZUaXix0YYTP
	 A1xH65vUbuZk/r3dHpm1oVqRJ55lP/kSJLllf48CMbzHYj5q4PKvhR2mGctihn4V7E9BI
	 ndCQ7/OySqxzt9YqrUCkYJZ2n7XGDHeJp6PEeMn4y+ShiqyBdzHL6wAEcf3ybFURvswC1
	 smUTWwU5OMVYHEFgIykoo+y5otxjihwblznC/aYuRbWwmSpm3bb4q6hXci/0lXdLwMCZc
	 gODEsWnovFkTIVJZk5VIzfh3SHB7oC6qYtmN/VdGI5B4Yo4SHWl3wniZk5iSG7jENbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793607822;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=qKWXq/M9hZEDrg+TO7bGJAIITfS14azYI9AKfvT+bTff8aA28uLmH5YlBeDHW4cyik1R
	 F2nMo9QLKDeQeIkKGVksTlbcjUMXi4uzsumV29q/nya8RWv+sHohBr7LEvkyzQctMVwD/
	 sidV4MaNWPVEfLZCfGzRojVskoP5PWIZRBLid+HOSIv6drKI3W7Z2CrR7gEsv7NGpioWC
	 6IyEjDEZGILpHb5wugBZyEHI9D+3jzGkYT7/hg+4MFPKsZ98qjXCjHxUm1RWQUGRl/YDy
	 F5d4Ng6YtrDlgwkhHgiqDf1uBusbq2rmNSyei0HL9DgBwKtT8Chog2SJMqDAQ8UqQhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eJ0zX2al;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44AA606A326;
	Mon,  2 Nov 2026 08:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eJ0zX2al
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB9261F000C1;
	Mon,  2 Nov 2026 08:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793607821;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eJ0zX2al+x9C+KrP4kjvSIctTSvCUav7xeEgmY6PfNRyA0L4WFsyReRcYlY/igLkO
	 4V6NlHbpieQFMWX2R9ExJ8ASXCfxIAuxvNa9rmi2Im9zPv7viX/TJrNWdbEwsy8t1I
	 SSsTVcA330nn0IbtJcGAFzp0LLEbjtudloCCKFd/ri2TSdan41zOjtL8egyt+nYgvy
	 zwLnnwDELhAfCOe4hVRt4bWohKZ3mqHNF5ZcUcfqlcNLIR1zcmqbIGJvQVmAVt07n1
	 Pui5uHK6IUJ9aIJ33FsF1cizGq2JL1d1nhuXAVn+9Zc96426Upu3ku2NE23itJvauj
	 liKbvgR9G2GaQ==
From: netdev-bot+sinfo@kernel.org
To: Fang Xieyan <fangxy@xiaopeng.com>
Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Johannes Berg <johannes@sipsolutions.net>,
 M Chetan Kumar <m.chetan.kumar@intel.com>, Guanglei Zhu <zhugl3@xiaopeng.com>
Subject: Re: [PATCH] net: wwan: iosm: fix potential skb leak in MUX DL decode
Date: Mon, 02 Nov 2026 08:23:40 +0000
Message-ID: <179360782049.3286.4996674092910894585@kernel.org>
In-Reply-To: <20261102081920.50288-1-fangxy@xiaopeng.com>
References: <20261102081920.50288-1-fangxy@xiaopeng.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
