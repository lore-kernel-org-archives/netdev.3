Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793351029;
	b=DVzRpU2huWOGCexFu8CB+SrqpHnOiYZYIgeWgLObBifKf1GIWenEKaY7KF2tK5K9fZ1/
	 7Tf3k97kuC1Lhafs42TA/mS/b/2WUJ5N/kUkzWWw7puZGL7fhgWvLn8ElT2YhgBHXKIvW
	 QZ1ZqxEJvLnpEQP8N9BWomCamG42Pl2diTfNkZ1XhZqFwX/A+9TIcIgHGlruUyygksK/h
	 Fq+I6CwE4WSi4UP36gSoBWpGElTkxqZPvJJI77ttDj6G/SGJio9kCsm/FQsOc9ju9wTNH
	 XCmIrMX4TsdUZkaHPH2do3cPXXC27LtPy+HLQKjv9z1iI/6PKGqFfSJw1mywA3hWNIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793351029;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	b=I4zlSK1ZsRGvFuZUqF3mxItCaMUjOOUxSvqtwICL8IiWaiFxw60NSHPjmr+20xrbJ88P
	 q1tMEmtT0uezvMhcJxt9PfMAzIpUUGicagvHAy2AcWsWVPmg9rm9jzv5q0bQrdabnzlAJ
	 mUSjsdYxM7ZccyrlBnfVf+stlcDMhM9V+mn/w0q1BXB3ArBqJIuB93SKisd9yn6ESIF+s
	 4cIr9n3O/IidZLQzUMA9B+s4rY52+H9jNSGg70arEbrJclapTlIyHRId/8miS06XtDjOY
	 h6sYfE8/ddej8E1cbWEhvCq3h1+v+urhN0eplKy/tv3d8HTaQBOXf6WXQZ3XhJaP4ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jba3VDhQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9200F606A31A;
	Fri, 30 Oct 2026 09:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jba3VDhQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78CEE1F00A18;
	Fri, 30 Oct 2026 09:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793351029;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Jba3VDhQK8Azg35IwM/K/ULHd5IY8xLxA431JYRkLzJjnS4uz+dMmK3rKGjcZZbZT
	 0ehkyIq0I1C9FP0r2x8u4lZwvNfaaqpGCfTP9veWoe3mZKEhEBwgSFhqtCQYHnu/aQ
	 pOoVuiTf5uzi8GSmWG9cmL1jIhW9YIjdSHLqrS9Mj8gplaH0qanyfIKUmr6xu7wS2l
	 CmBm70OOrxaXnX55iDA462Q6lECOhMfjNISDwr6e53/GVul+XtCynCYc/V4vWRWlbE
	 30KFrU1Ci8iI4lDkngA0JixlAObuXQRyE603mr5eJchScKn3FRxDEy3WZSW8VraiDL
	 effH+ecMfM9uw==
From: netdev-bot+sinfo@kernel.org
To: laixiangwu <laixiangwu@cmss.chinamobile.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 MD Danish Anwar <danishanwar@ti.com>, Roger Quadros <rogerq@kernel.org>,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ti: icssg-prueth-sr1: Fix device_node refcount leak
 in prueth_probe()
Date: Fri, 30 Oct 2026 09:03:47 +0000
Message-ID: <179335102798.3327.13730382084781364050@kernel.org>
In-Reply-To: <20261030085851.2019-1-laixiangwu@cmss.chinamobile.com>
References: <20261030085851.2019-1-laixiangwu@cmss.chinamobile.com>
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
