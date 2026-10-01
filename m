Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3C2388397;
	Thu,  1 Oct 2026 03:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790827143; cv=none; b=ryvpaITxST3tpipzKbpuUPgAnhg/+RcZL7pdT2QFUBpLDed705+6kYVbiTDHykfDOy/eDfMLC0rTy4d9fJSQFMAagA4fCqunS5fKZZFFW2RMgF2Shj82xyTCZPw2vzjMQk9zmPjvEp3T2D8s6kES4SzkhcPEKP3q9EfjpdpmEyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790827143; c=relaxed/simple;
	bh=DxOA3K04TdGKgV9RBzwq7NMB042SfZvdvrNpiga7nYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OGirsG6Ck+78JBGCHTG0IG9heddJi9+ZZhHFOqckb4DW7VWjp6TReVYtBHpEEYjrYJ+4bRU9cSxfXSjqPyK6l1d8jvLFXc9CTL6lJkaBw9gbwQ/K3C7ECYiGu+cfm+DS2CJXmwEHMz31S+s2HmJ/uKNsrGJoB5xnfiJdfZHbuQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cEmyU4rL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cEmyU4rL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DFD81F000FF;
	Thu,  1 Oct 2026 03:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790827141;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cEmyU4rLlPgOu/LOv7ht4kyOmHnj6koNHbvUWlIJa8gxQQmJggP/S76XXDUYm4Rqo
	 YwEb7oHYl9Lwr54SZfFsJpMdpbKZXulf34zzM10KGLJxYsjJqQ5O6aAg9BcP0CqXoD
	 R98Poq2GJcB+1QzpKJ5pGqPH5ZtohGLdJ4GE/3mZ7Zh9gVd1PfFH6Gb7sdrVan6Qid
	 ckDa33hj+IINCyIdvthEaegaXsq0bGaHaKmksjNm8yJbcIprZWrMLjirFxcvtgVFwp
	 53UnjLW1e/h87lUhzFHuOVvLIVWpGTLkzOFPj2e77Asf2kjsbonOiJKnixw9y00erP
	 fRvs8mA3GeaCw==
From: netdev-bot+sinfo@kernel.org
To: Ding Hui <dinghui1111@163.com>
Cc: netdev-bot+sashiko@kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 dinghui@lixiang.com, xiasanbo@lixiang.com, yangchen11@lixiang.com,
 liuxuanjun@lixiang.com
Subject: Re: [PATCH net v4] net: stmmac: fix error path cleanup in DMA
 descriptor ring allocation
Date: Thu, 01 Oct 2026 03:58:59 +0000
Message-ID: <179082713968.31693.13138874201716710221@kernel.org>
In-Reply-To: <20261001035045.3305816-1-dinghui1111@163.com>
References: <20261001035045.3305816-1-dinghui1111@163.com>
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

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

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
