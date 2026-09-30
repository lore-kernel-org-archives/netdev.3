Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA6B451980;
	Wed, 30 Sep 2026 07:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790751844; cv=none; b=fmy964LSo7gZkNdmhkAwRx/+2C7k289P9L3xL4IXHFJoc68xp3NdO/catwK9yWuA3OMZH8vruWE4uBMRawaG1ZWuJW8VUaCU5NP7Ebc4EFVocTaoNMdHttyqiHImdTP7emW4NHQQcmaLla3rsO7FjWl2g6zL6O5W23HBBZDsHLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790751844; c=relaxed/simple;
	bh=DxOA3K04TdGKgV9RBzwq7NMB042SfZvdvrNpiga7nYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r0hbSNBoOBLpYo/8ve+3FiqYwxSA7TRAYduW0464T96R7MaCbXtVerKSBnE+yOlAeCI11AOxGjGbRPfpKDY14JA0Zuw3UIbiempWJfEpDRGyFMbiPwlyzbLzzrTGu4Lv6lY09axI2kVkRz1w5UPjDFfIqDppFU2mfZir+VISNI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ESuU3Kha; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ESuU3Kha"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C4801F000FF;
	Wed, 30 Sep 2026 07:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790751830;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ESuU3Kha9CwkCEgTOA/6gCYu+o1mhp0SJw0SK+wDues2zrZhw97CFFM+k7/kkNQIZ
	 peta3pNuoDqhGn6s/G/askT2Y/rp+LCah0NOXwW/T0gkGL8dcQ0a33tPmS+6XjnzRx
	 BUqPGm08DRGKnYtImlaZ3fSVneo21F8iP2Q/d9Y+tcbm3vUfUgyaX8ua6rzL0yLGn/
	 8blPL9Hdt1N8u4JzzoVdQBM2/HYy6tGwg8cfS1uSSVm0nSmGxlcJdslhO7nUeuHwYR
	 eXM4V/y90VNCzpjDxgy1Zlhm31xEHHU117Vr04p80N/E5Wex0o632ybd2lvG6apuPV
	 MjuwSkRLeMtiA==
From: netdev-bot+sinfo@kernel.org
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Leto Liu =?utf-8?b?KOWImOa2myk=?= <Leto.Liu@airoha.com>
Subject: Re: [PATCH net v6] net: airoha: Add retry mechanism to
 airoha_qdma_set_trtcm_param()
Date: Wed, 30 Sep 2026 07:03:49 +0000
Message-ID: <179075182973.31693.9923122035627324820@kernel.org>
In-Reply-To: <20260930065855.46171-1-ansuelsmth@gmail.com>
References: <20260930065855.46171-1-ansuelsmth@gmail.com>
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
