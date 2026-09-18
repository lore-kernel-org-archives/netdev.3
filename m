Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262A65208C4
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 18:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789757618; cv=none; b=jBOH4GDkqvZ61diJn7waXiVv9GlRHVjDyJC6lLc5Nc2uVMZHxP2GtifjZjbMi7oqwv6ugHiMQxmORROeSd7Go2MWv4q/7iPyltVUmkv2XJ3RZjJBTvdNHAdiJBhWIRV41HhepHRKpCsUloKnn99iJkUKVTZ0LbwKsZxlO31XMR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789757618; c=relaxed/simple;
	bh=jQaMU06VspJAmWzhu+0n1ZeHtIj8BJ5spyPqzqqy1RQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qE6NoMY2zUBePPiBGOUYxVJGoROoYtwFcnkvoI/xLZibNCLtOlq2gVYlc7vtVtapEd4P/fXoSoE1N0+oJfr7tHUhM0umaKKDQYCTDTa2AEnRlN6VyZjLjzTB3EazXDgI0mSJWEphXpsXoGEEevK/0YOQlfVaofG3oSclK6+tmSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kETSpSUT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kETSpSUT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30C191F000FF;
	Fri, 18 Sep 2026 18:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789757610;
	bh=nHX46zLjoLnTDnMjR2qm7PXLhLMFm3oiqLcBz+hBxbw=;
	h=From:To:Cc:Subject:Date;
	b=kETSpSUTWK9a2+JV4Lz0dTlyDo9OzY8qRCoN9DcNOxwqp2n4xfWMn4YB+KSnQRys+
	 bP+at/wV/ATB5T7znKwptT5MlIK8eEOolIArPKeEuOMUOgzcuSQ/kuJUeA6miQcgf/
	 o0PbY+yHLJlzRFehLtgV1vQXLXj/K42Erl/n7hblnoRMMyCgalH5q2JexylA20RpvN
	 LM3Y4ms7+jNHwLlZ7dpnUaub/Wwgb4Ek+DD2uG3bdZjQK+MZSKNChtQMPz0bzSe1VB
	 MRAhVXaQ9A6B+8fSy2IG1L+IUoOiP6pj0U9GzHVomyIMfrFd1+Pt59GBSdEWduDrsp
	 avZfuUXeb6vxQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	olteanv@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/2] net: dsa: mv88e6xxx: ethtool n-tuple follow ups
Date: Fri, 18 Sep 2026 11:53:24 -0700
Message-ID: <20260918185326.3940857-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here are two small tweaks to the mv88e6xxx n-tuple filter handling
suggested by Sashiko when reviewing commit b1fffc273112 ("net: dsa:
mv88e6xxx: bound the policy rule dump by the caller's buffer size")

At the high level the problem is that the driver has shared rule
table but for some ops it doesn't check whether the rule operated
on belongs to the port on which the ethtool request was sent.

I initially thought that this could be intentional, but on closer
look I don't think it really works..

Sending for net-next, because this is AI-induced, build-tested-only
slop-code. The outcome is unlikely and results in mis-configuration,
no crashes.

Jakub Kicinski (2):
  net: dsa: mv88e6xxx: check the port when reading back a policy rule
  net: dsa: mv88e6xxx: check the port when deleting a policy rule

 drivers/net/dsa/mv88e6xxx/chip.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

-- 
2.55.0

