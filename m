Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369E14D2ED9
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 14:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790779710; cv=none; b=Vo3j6PjupCdosrvtVrSPMmLD9+JJ7dW5UaleVF1SzzI/9Asoa3Tx+4In9tO7Euqh6Wfspp0Nd0ZS8yLSSx8lFVuSgRRe4MP6z9rkrc5XoH87MkkWnbJMo03CM2GhtkMeRuZmFkcxW4VtT60QbSsGjSasDE+Qt+ACruWHGc6z3Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790779710; c=relaxed/simple;
	bh=zvpmhm+BAUlfIVJ/6Kp9ShG7pA3G2q65FWBMzuTisWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cZNOOMPnJY/pKtmAPC9Uxc0zr8znBFTSv7uz2xrHKO1wgXdDIDKwUQexW+GzeLsMnR2FDcQxgVD7/RGhyf8VEtSbNDzyZ3ziHJ2KUWpkh+JWpKclsrPGES9Ah1t4mLU6i7YSg9ZuZEBmHpo+Avx6Xbdut6xCwruamVCVbDK1UQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iL9k4fQO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iL9k4fQO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75EB71F000FF;
	Wed, 30 Sep 2026 14:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790779699;
	bh=R4WIaVmgxMJzlsaERAlBqwLuDwVcuzfSzsQMDWtKV3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iL9k4fQOhfmKljn4f0z6liXv+moAfMR9dqTHIlMd3nUTlLNAvPE43R9N29l/s+jUk
	 h9NswOlsVEZfkEjTq5mz7cdTM1vf+T5PGko1rkUZ4nwFWvisAZzmvP0JnWq8V5GL71
	 l+vH8XWTTn2Jp55ygidsOpdjRSF09OKSKnLXod8Ge6Zp7WZovxZLxJgQBpLlArAuuc
	 Oh4YrOBRKlDP+fRLBjYcN0XJmKtthMsCLF0sBZTXIGs7pakYftrovJIdEn5rRWM5lk
	 2AgmxkBwBySvkJaxSwtMH92yrzahmJCp4G4i5/QYBkI5mN9McgDUXCxbZ0KA4rLW7Z
	 tkcO75uHlOTwg==
From: netdev-bot+sinfo@kernel.org
To: =?utf-8?q?J=C3=A9r=C3=A9my?= Jean <Jeremy.Jean@oss.cyber.gouv.fr>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>,
 Sabrina Dubroca <sd@queasysnail.net>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Boris Pismenny <borisp@nvidia.com>,
 netdev@vger.kernel.org
Subject: 
 Re: [PATCH ipsec 0/7] xfrm: fix ESP IV generation and ESN authentication
Date: Wed, 30 Sep 2026 14:48:18 +0000
Message-ID: <179077969803.31693.2040549647961576775@kernel.org>
In-Reply-To: <20260930144523.435271-2-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20260930144523.435271-2-Jeremy.Jean@oss.cyber.gouv.fr>
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
