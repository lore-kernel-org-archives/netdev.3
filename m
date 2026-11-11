Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794370948;
	b=V4frTW41PzT7QxpxDCz4CLVY4t4F8lHL2I0TV6xdqANtV3nWu1v/+e4tuoUg/+wfcaBB
	 Kr89PGS6VqwYTGYB6MNzAQfRubEK48BZo96xGe234URml2uMc6FiHi6MtcP5POAeT5Rtv
	 bcYyVe8uT0uFlosiX58GjXRaJ0eDlmOurGpggm0u7I5mw4t3wdF1K6klkvks/cmRDqISX
	 rzlJRZQqsGULQaT7S7VCLP0xSvJxwpelHJsoiPX84dbNH2xICyRF0XhXFvwTxS3pHtbpC
	 zeknwUUhHa8WnHNf1jVbD3StnDkl6Ag4S1O0q5VcjaDEvtnJS/5zLubV2hi9gMxFyTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794370948;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=oVTc5I6nKpBiLsItkBZmeShBR8ASpkDeEBpnWBZ++aw=;
	b=hr+aXXNKwy17HMFz/OmaHl811jCgPrEVkJezWiuhA2uDKSxb0UQAG8YxYfu9g6hGv+Mz
	 YwtDS+vttN8H/nLDhKu8Hy4FdSje0KHppvK5UzB4PlmyUnxPelAEeRBlKvwS9OJZjAQqP
	 VBztUJfxr8d8nkNQdcyI/m3eXtwUVfOfO/QKcDyaxlRYHRlFelAyrVUS8zqqC7Cf8v9XJ
	 yvAjlBqoy7dUnCORpUqB8NrJDxuD9y8yGKhZ577FXrt+vdk1/FDixCcXIhNcMCOPwXcKk
	 HCGiJ2K1HNdGt73hX+BaBgsihbEJD+PkA1SKoTWczp8gk7jE+8w/LG7J8NYkLrYOxQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Au8YfN1F;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2742606A320;
	Wed, 11 Nov 2026 04:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Au8YfN1F
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19D151F0089F;
	Wed, 11 Nov 2026 04:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794370948;
	bh=oVTc5I6nKpBiLsItkBZmeShBR8ASpkDeEBpnWBZ++aw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Au8YfN1F+m7RyDz6DM00LTgAtvTiUnE4JrxDqxcVumVVmOgYnKbQXsSklLXcazGNh
	 TEjajKHHx2XBpuDrHtEgP+lo0KvT2JcDktWk3SkB16Av3wyMBr8BX6k9U9+Hbo9IcZ
	 N7P+HIF7I1ZVisHfpR2sE98Ix3P6ilte+6PIk9V4CjoN+rJmI55UumBT3Hsi5e6vc3
	 S7q4mUVAvOB+E2Vt3W/dZLSnAR2ZObWfHkWKHyVinu6i5o4Tx6VURPZT9zHUTI1ED4
	 Zvs/gU+CpDfIhfRRT15H6TGlsRavarYXBDrL3Ypt0Hc2FyvZorStabeK9AFwa1Drub
	 7v0mnsur/jfFg==
From: netdev-bot+sinfo@kernel.org
To: Fan Gong <gongfan1@huawei.com>
Cc: Wu Di <wudi234@huawei.com>, Teng Peisen <tengpeisen@huawei.com>,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Ioana Ciornei <ioana.ciornei@nxp.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Mohsin Bashir <mohsin.bashr@gmail.com>,
 Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Larysa Zaremba <larysa.zaremba@intel.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Zhou Shuai <zhoushuai28@huawei.com>,
 Wu Like <wulike1@huawei.com>
Subject: Re: [PATCH net-next v02 0/5] net: hinic3: Bugfix for later patch-set.
Date: Wed, 11 Nov 2026 04:22:26 +0000
Message-ID: <179437094656.2168702.7238120951030130700@kernel.org>
In-Reply-To: <cover.1794371175.git.gongfan1@huawei.com>
References: <cover.1794371175.git.gongfan1@huawei.com>
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
   (e.g. found by LLM and not proven at runtime). If it was triggered
   please include the symptoms, like the stack trace or kernel messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
