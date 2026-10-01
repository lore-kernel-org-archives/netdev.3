Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D303E168C;
	Thu,  1 Oct 2026 04:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790829782; cv=none; b=GkbRBLC0qw19HwKqLyTXbleqVpjehyIkLJWvrMo1jZN/9ve5JtPJV1dkii56QPcL8yW6EtfEHnSne4Sb3ujhxk+GqXMSPVXxHvVVAmxKk/aLbUkk6K/nghOTq353tVgN2qpJsfTmSCV0qTmSInbhPmk3dT940HeevdMWnf1l8+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790829782; c=relaxed/simple;
	bh=DxOA3K04TdGKgV9RBzwq7NMB042SfZvdvrNpiga7nYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OoVwcJqk9tTXICMUMSlpgLtQUz4K85a5EGTLMYmgqp9/+o1Q1H3aQzh6wRHeNoAPP62xIxvDfyjjh5k7zHUwyvC2h4DvEmNnaPRRbcuF4rVGpLbeba1YddRW/E53ucXLTf2bCEt5ghYCtUCD3bllqPUvBYJvRU4V1G9Yvxlj4dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m6CibyAp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m6CibyAp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB9D71F000FF;
	Thu,  1 Oct 2026 04:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790829780;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m6CibyApBhAxklukMkRmJRcb+rDQ5COKx2k0QaLVZFuQ6FxrZch/teyQgqBUHZwQM
	 yqfQRxqNjCxW+bsi7WBfamGrQ3jJrKv04U7ul5ODigb3btbGf9cU7RfnEyVwDBXzVc
	 6PTaiexJQpUFpRROVnayfxo7zsI6xFlghfW/t6KtMQ+mwB2lRh7BrRCEWlNexNCng7
	 YPsUUQxeBOIjKSYkVqxFXl5svGqgVNHGtShcu0ATTvh/u6M2EXKBBc2t0QDGoeYaQT
	 k4hYx9PUatnkNsYstjzuynltt2rf7N1eInBa48CAFhbNjVLfgvB5y9r8dM+AGTCZ9v
	 91Ol//i0HTV+g==
From: netdev-bot+sinfo@kernel.org
To: James Hilliard <james.hilliard1@gmail.com>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 "David S. Miller" <davem@davemloft.net>,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: stmmac: leave the datapath running for
 normal-size MTU changes
Date: Thu, 01 Oct 2026 04:42:59 +0000
Message-ID: <179082977927.31693.14994198839172125816@kernel.org>
In-Reply-To: <20260930-stmmac-mtu-fastpath-v1-1-fd73f378c071@gmail.com>
References: <20260930-stmmac-mtu-fastpath-v1-1-fd73f378c071@gmail.com>
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
