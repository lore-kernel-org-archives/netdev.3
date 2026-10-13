Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05692381EBD;
	Tue, 13 Oct 2026 02:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791859764; cv=none; b=Xk4LRCExEcmehMnOqn/VGGrZtxCpNFbDRXpezXGw95Uss1oXXomKkby693aI0N1/z5TIx5PRaOk4XCjojoCaFscaTWh7AYddNTvG6zjL3AqZL6z10tBIzXMCgjEsWYQPNT6g9S5py4enoTKcQHhHSkJx1ZTWY7QaeX7/xUqVco0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791859764; c=relaxed/simple;
	bh=Frc+ADQTxRwKDWaoqMQMlUJQ/gCXB8qyIs31/48aD70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XfRIjJAoNa0qPN4sPfjrOdklVSbV2KJrCogVKnBaFY+JxkR+QMVoaIz/RwXgbIB50SZw6ONnrWEDsw34Iz6fSe0pABwD/mIMvLVOHCVdHtkuJpuB16NPvgfPegNSpv8kCDHpiRusjlfJYkRPD1RR+WK8Y0POMsiM1dE1e4GgM7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nXw+TUHw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nXw+TUHw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 154AB1F000FF;
	Tue, 13 Oct 2026 02:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791859763;
	bh=80POjU5WP6ctS0DqN7hA/63JAQ8Agh1hTny2C1kJcvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nXw+TUHwG739qIo/HNw5/zeI5VPnReQZ4zkJew9KLyKnnb13CBnixf2XrC/WPSJda
	 N31dPAEpX4EYnkoen4dLZP2ctuZc6TVCwAb+teQxXPkrNR8SYA6afdBppg9eQPTm7s
	 YFH84K2n/vafR8sUPQhuOdSle3Sxc27oPkZgxOeqzJDbY82r2ibzs5pihnf1+nHn5x
	 q8XRhxQqalu+VPejVdkf6flRxaVvP1sP762ONLch1wTDi0DPXDlFRBsTdE93bfUpIE
	 bFQKKI/JRvlKwsTuaL/LgiXXrFKl75vXKZoYqn7wHcEkAtSnxMuOT3I1M4bIbpYQar
	 +cI5L3UCVBLTg==
From: netdev-bot+sinfo@kernel.org
To: Pengfei Zhang <zhangfeionline@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, EricChan <chenchuangyu@xiaomi.com>,
 Simon Horman <horms@kernel.org>, zhangpengfei16@xiaomi.com,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: stmmac: xgmac: do not treat TBU as a TX event
Date: Tue, 13 Oct 2026 02:49:22 +0000
Message-ID: <179185976266.2527009.17600570633406382637@kernel.org>
In-Reply-To: <20261013024747.2688984-1-zhangfeionline@gmail.com>
References: <20261013024747.2688984-1-zhangfeionline@gmail.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - What hardware the change was tested on. For driver fixes please
   mention the device (and if relevant firmware version) used for
   testing, or say that the change was not tested on real hardware.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
