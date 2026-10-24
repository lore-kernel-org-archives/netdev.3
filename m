Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792817726;
	b=09pPNCWc5isU5coHhkVNyjFjOmcEPNzIA2G48t2BwkpPjNr0UzsfFgEa4wTQCSghT5hT
	 y+DnFsEYd5cpJP4OV4FAXvyOW6u1rvE7yBbKQaCsWafhscqgZbkZVF1Pmvfv68JkXyyCm
	 QFS1Ae9JiHS4szRZ3O6k+CUvmWSoXYSTzQyli6qC5QEI1fSzIPOsJ5HhYiWXXH+eUPat5
	 rXBuNeya3O3eQ+GcQJweSUkDJmBt5Ok+6rk8p0c4FgIthPzSPLpgNSPImFXerd+8yGALb
	 HG7C3jWO+H364pdXS8xEDRDwbSeXwGIC9plbRjq/cmNkc5OFM4se1QXBAf6bbE2+SoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792817726;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=80POjU5WP6ctS0DqN7hA/63JAQ8Agh1hTny2C1kJcvk=;
	b=DcoGrtACz1KdpkGcYND6tAL0wADM/stTCKSQydwZGYE+pYYTHTJ91ZKQ2deTytz/I9yg
	 X00z5sVc/UXUtDT9CoTm9Lkl9kv8z9QJndb1jzvU5LkqqFg6JdV1itSyPhKcVNq8J2xX9
	 hRYKE1qpHVBOMN6cbWoePB5DfxZQRgC180j530+qwPwIXht/ILbtfypYS1s4Sv2K0p616
	 Mqp4/9zITqETBC7exZx5xZEQQolB3i2Dm2ohdViUP/fk4geuMYhTbkLswuv0CYmdvDGXY
	 fqNDLvetD2Z21Ox9jRRWElh0y6pU7rBuU6jb/DwlxkeA4glEZuebIBy6Uu5z9jiL2YA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=akmE+PGP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868F0606A31A;
	Sat, 24 Oct 2026 04:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=akmE+PGP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6526F1F01825;
	Sat, 24 Oct 2026 04:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792817726;
	bh=80POjU5WP6ctS0DqN7hA/63JAQ8Agh1hTny2C1kJcvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=akmE+PGPRINDTfxV5aZ+EK1e1Xl07gCkhpsyXUuIvYqGrtzwrbJVaHM77SJS5eTZX
	 96ACVBAz6r03FnsT7wdekplR+MuYpd88NLZuY1Rdz7bHaCS3+EUXPrFaEMTn8zDpiU
	 6+QxJikmjAURwPS+LD9Q43mJ0Ak60WQeJm3Qs2wgepWvfjYAlAMa0cEt0jx4nm/cPH
	 al+qZcb8kisJOksMscEsdCoQvEeUF78JXlIvsOpQtHo7vXe2tnyi6c3XbAuqFaA7Ap
	 89Ux7+PrhcS0QGZQWRyS0yWlmj0k3CHCNJA/3xalHLkY3ImgUWM93I+Cf0oWB59Fey
	 GEeuJQAcr28tw==
From: netdev-bot+sinfo@kernel.org
To: Sicong Huang <congei42@163.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Louis Peens <louis.peens@corigine.com>,
 Hui Zhou <hui.zhou@corigine.com>, oss-drivers@corigine.com,
 linux-kernel@vger.kernel.org
Subject: 
 Re: [PATCH net] nfp: flower: fix use-after-free in neighbour update work
Date: Sat, 24 Oct 2026 04:55:24 +0000
Message-ID: <179281772489.3327.7012763017353507728@kernel.org>
In-Reply-To: <20261024044903.1130380-1-congei42@163.com>
References: <20261024044903.1130380-1-congei42@163.com>
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
