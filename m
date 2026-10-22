Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792682658;
	b=IDjPLdUOmoC4uDQnifpFWEgevv4wAbDlCTaqLUvLy5zsoU90cLlFB2JqL0hVgpa28T9H
	 U/NgPIurfEC6Njq6xfCgzo/2gF/SDL9exZmKaJdl0DThVv3Olv68avu4ea89KM+Eam/SA
	 r3zVc9NeyxL3Ckara+fZoTDY1J+MAq6OT8T84/dmlSZyWl21haneTTeZ9E946i9xQ356o
	 zSyjGWHmmaq/kyUrORXrkB08ogA9kVXHaerTmxII5+Zowx0eebaipF+uabUu5/EuLi3B/
	 KnN0XfMpSyGVis8X6PdBCrH7arGr9rVmv1bpV4WKxJZg7wb1IatANguNjRHpM8yUWrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792682658;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=dFvDESgUnUZGXYa5MrlgOZOa2bvfpkpdDye2dUm6l2U=;
	b=oM81fVhRFYsMqMyvM4Ie7aY3V4P5R3Dt3Gwuq4oNQeETmm6b4xd0KNhjfxh7HXY5OMCv
	 KJxY1BS1XQDBMAPDOpHcJpVus0WT389BZMRzWroqcp/FUWEBJqUUY83jYNrphvB2i343n
	 Zu9An89ne2XbgKdSMWuQWsbjj/yyweV12ipAjAmvshf4Tz6aQQie7Pho1g70H23wte1bK
	 wrF8q1a+4HH+gdpKnz0tq6LfjgGMTqxFckwvD4QFX1rpy566DRJwMPXN1Wu/ztAFG9kLQ
	 4UtIsL82q7Xc8YfE4U1ijehxP5+84LW0i3cKB42WfxY4fsvomKJFX4uNaG/mouXuwsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=byX6AK+C;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA50606A33E;
	Thu, 22 Oct 2026 15:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=byX6AK+C
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 047611F01825;
	Thu, 22 Oct 2026 15:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792682657;
	bh=dFvDESgUnUZGXYa5MrlgOZOa2bvfpkpdDye2dUm6l2U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=byX6AK+Ct3sYTEA1YOuiH+8rOA5U738BZz/m7Fa0HZwrJGjgEaYS9QoPDM7nYH1ve
	 GrOS5BUst05Wey2CSXKLQV+71Rt+DdRLa580en6gjrwfTrSzJWSGtk185nAvzecREe
	 N79L3VyKjRbCxOv/keA/CHf/lBatVYDsw8I/om3xPlTTQaJxPQYrGV0miAO1xR7z/T
	 yz8bTJ9soCMwhDD58RFru5OYqF1KYoL0vgu0/25URvG15QM9EmZE+PZcLDc+auNoV6
	 I5zX4YNjkpQcs26Pq7RRJeWKXA9lizvFrofZ+LKGsrHfloGykMKp7HELT0/xuvOcNJ
	 TwSNBc7nSQdGA==
Date: Thu, 22 Oct 2026 08:24:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Fan Gong <gongfan1@huawei.com>
Cc: Wu Di <wudi234@huawei.com>, Teng Peisen <tengpeisen@huawei.com>,
 <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Ioana
 Ciornei <ioana.ciornei@nxp.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Mohsin Bashir <mohsin.bashr@gmail.com>,
 Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>, Harshitha Ramamurthy
 <hramamurthy@google.com>, Larysa Zaremba <larysa.zaremba@intel.com>, Vadim
 Fedorenko <vadim.fedorenko@linux.dev>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, Zhou Shuai <zhoushuai28@huawei.com>, Wu Like
 <wulike1@huawei.com>
Subject: Re: [PATCH net-next v18 0/4] net: hinic3: Support ethtool ops
Message-ID: <20261022082416.2653fa27@kernel.org>
In-Reply-To: <cover.1792671176.git.gongfan1@huawei.com>
References: <cover.1792671176.git.gongfan1@huawei.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Oct 2026 20:25:14 +0800 Fan Gong wrote:
> This is [3/3] part of hinic3 Ethernet driver second submission.
> With this patch hinic3 becomes a complete Ethernet driver.

## Form letter - net-next-closed

The merge window for Linux v7.4 has begun, and the net-next
tree is now closed for new drivers, features, code refactoring
and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens. There is some uncertainty
about how long this merge window will last, so please check
https://netdev.bots.linux.dev/net-next.html
before reposting. net-next _may_ reopen on Nov 2nd.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer
pv-bot: closed

