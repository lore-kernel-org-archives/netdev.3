Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A0849BB65;
	Mon, 19 Oct 2026 11:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792407798; cv=none; b=YLlezMi29qCJxAURsxsqktY/ogQs7wl8L7bIC7HiK5xPmblAwVjR6iiTPj3QTv/gd9nCGu8lr7MxIviPz1ewQyXpgo9zJ9UoaTLFKqRe1DcavOdMuegh1I4klVPYDDgi56QT3WqZpsbgeSdy6vZCb05K1hLKyD7++H0wZcEkq/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792407798; c=relaxed/simple;
	bh=zvpmhm+BAUlfIVJ/6Kp9ShG7pA3G2q65FWBMzuTisWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lOBrmNhd4V3OunU6COz8P75NKWmr4MPUw9aMrCdVy8LZYzOlW3CWlnuzHNPBLCbWu8YI1XVRwHjezW6fI7S5GZz2iBmVGTuLPgsdnnqnYHz3363zO67K6e8bkWUtS3srj0WHyQ4HSf5TxB/J5t4PeZSw60n3IiPErsOGGUFHKoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FQGin7bl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQGin7bl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CA921F000C4;
	Mon, 19 Oct 2026 11:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792407797;
	bh=R4WIaVmgxMJzlsaERAlBqwLuDwVcuzfSzsQMDWtKV3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FQGin7blESRDhwfVELlqPQil0SWaX7mX4hN6gggi0HasJJYjW/FnmXKvLjc0u4aTw
	 +WNIKP8U9e4nsdO9PSuva+RZ7qkLjRHhqLM9J+G2LrGaNa86Po3CxsyRLiS1frDH/Y
	 lP8eStPk2Omn0SAgz3FxX9b8iLM6nZvm3I7mDE6z70HWWz8R0b0ZsJr299RWPtNZlE
	 G2gFmRGIcWw2MT6a8heq7aJvfX1hhCJiUJrbMVg8w8phLO0JO855wdtDCrWlyCOehm
	 gRbAPS48tdhwR3kMlEwAe332xrAOPfvcL6D3ezu4WvMaOqW/jVWbojTOkM0p5xOPyG
	 uy5F+CIxlLLtA==
From: netdev-bot+sinfo@kernel.org
To: Til Kaiser <mail@tk154.de>
Cc: netdev@vger.kernel.org, jie.luo@oss.qualcomm.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 1/1] net: ethernet: qualcomm: ppe: Fix multicast
 queue admission control access
Date: Mon, 19 Oct 2026 11:03:16 +0000
Message-ID: <179240779673.3290.13278804001688031839@kernel.org>
In-Reply-To: <20261019105950.3977665-2-mail@tk154.de>
References: <20261019105950.3977665-1-mail@tk154.de>
 <20261019105950.3977665-2-mail@tk154.de>
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

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

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
