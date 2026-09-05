Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0F02E7162;
	Sat,  5 Sep 2026 01:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788572163; cv=none; b=f9hbIcfyjOaTiVYxYAyQnGxzCFKtwd5+0/jkPw4n4mrUjOmWxO1oQLJVFRg673xpC9GliIpjqvbxBMtN7h8fnFJIj8LEPcD3D7LbdhkuWpvJbMopg4y+wbiw8ZDyZ9ER/ZX0wXnTxa41hYn+/g9PVB2Bb+amysA9HrxW5O0t4hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788572163; c=relaxed/simple;
	bh=j+PyqXhNkSCmcQQ455Q+yPTgSPhumscrgrUjjUeOjVY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sKq2HnfolaBggl82sUj2BhKxMq3iANZ762o1ZZ9K6fQQfNm6sUFyX59gGT8ZBB1Tx4pZSsr8+YIsofepViyMsCg3u+52tAanXh+inhGH+q2THnr5jdCGC50lYo/CpNl2j88zCmqo7qbQls2EUVJcHF/2iNKDe+z6uvxhztuGjPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KKIpjJAj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KKIpjJAj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBB4B1F00A3D;
	Sat,  5 Sep 2026 01:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788572162;
	bh=4+Pq8DLHirg14affLX5jQJ7jMJXJhM+QJr9nUoCHWGo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=KKIpjJAj6iSbzCXb37eUoZ8AMu+vsnstHeVqAlNYr+SvVB/iqAAFjbj2VVh+pA5NT
	 LBment4+a/4S9mZB2iB8vvIE0LbfBgrWKZmy3ESKfW35ZLf/GaDy0CJT0qaa56QegC
	 8hqOErAet2XrHcscyCuTEECrIRH0wBQZLEe/JPZlI0tkiCqOwIhZoCBHqDdA9qFx/Z
	 tTAv/6xGCpA8gaCHORBoomOnDOamPuowRt2T7fnMf8Js107CJ9BOXUUDCNwFyHioir
	 JJMedkgNXUfIFQJ88nc+ep6aXIBaWfuRPFghz9iyWW7GcqCK1r0wOtciAtDb+MHy17
	 +mCtbbZqJTDAA==
Date: Fri, 4 Sep 2026 18:36:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <sgoutham@marvell.com>, Suman Ghosh
 <sumang@marvell.com>, Geetha sowjanya <gakula@marvell.com>
Subject: Re: [PATCH v4 net-next] octeontx2-af: add NPC TEID matching for
 GTP-U and GTP-C flows
Message-ID: <20260904183601.7b064314@kernel.org>
In-Reply-To: <20260901043027.2765502-1-rkannoth@marvell.com>
References: <20260901043027.2765502-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 1 Sep 2026 10:00:27 +0530 Ratheesh Kannoth wrote:
> Subject: [PATCH v4 net-next] octeontx2-af: add NPC TEID matching for GTP-U and GTP-C flows

I don't think we should be adding GTP steering support thru a user
flexible option. I think Intel added GTP support to flower, that's
a better direction.
-- 
pw-bot: cr
