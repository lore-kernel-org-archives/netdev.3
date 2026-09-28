Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110594A8A16;
	Mon, 28 Sep 2026 11:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790595201; cv=none; b=GUyK5bkJt2p9cwI+nOnLHZLrk5QrmKLf16HsnTUsXgqXyo4cZW3i0zzTXwGg+dNT1XgDQ2SMmVJLhWtaAlOMTtVOQypAY0aGu2ZrTOqHF5biWBdBRE1t8LbZG7d24hqf2XylqlI8P/7LdytIBYH7eEzx5Uv8LzMI34vsbBczfDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790595201; c=relaxed/simple;
	bh=d6u7qpkzmGSp38SZaYn+ONC2V9vsQtbqwn0wMcVb0cI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tpN62sgMt4jtyAAQlSE0U16fO1zdkJfAQz7NzRCwSZ49uT+kbLLbzwmso81f2DvlFLNySoyhwk60X2ikvs2uKGhHPvNF3+UQIEF7OOCZfQcjvlrwobJ1jdDXGL5cTP+VxxaOVPU253lxuTrQnorQ45gIKdLTXzV7fscunp8n+eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=TjstszXO; arc=none smtp.client-ip=212.27.42.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="TjstszXO"
Received: from L30177.local (unknown [78.240.193.235])
	(Authenticated sender: vjardin@free.fr)
	by smtp4-g21.free.fr (Postfix) with ESMTPSA id 54C2019F72F;
	Mon, 28 Sep 2026 13:33:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1790595198;
	bh=d6u7qpkzmGSp38SZaYn+ONC2V9vsQtbqwn0wMcVb0cI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TjstszXO1KLJWGNq9m1cYa1NLRv/qIYigXS6/VSVbrLargGULeVI0YuLLpiveZR0H
	 D5sbn5+TOV9ED+daNxzLaDcS+TSobqg5zIdsNEeU63FRgJSQLmxjtv2HJqFO4Spe16
	 wf7eY906hfqs+1OtegGbr371c2mLeTNWx1pbrHT5PMf8oeb15jzhUre/K3+nDN5fB9
	 bKcfyeqNpTZn/Em8HZiTI83iNyWqZf6t2M5eaqROgQRtjY41iAh4MAP7WRWAb1NOI+
	 5aBQz6xtmeMMhprPZ8bZnpgJSip7SriMkyh9Js4rkOA/Od1feSCyK3eWwwOIuIPqD4
	 MhWIyBFUvF+Ag==
Date: Mon, 28 Sep 2026 13:33:05 +0200
From: Vincent Jardin <vjardin@free.fr>
To: netdev-bot+sashiko@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, ioana.ciornei@nxp.com,
	vladimir.oltean@nxp.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] dpaa2-eth: DPNIs without a DPMAC should be
 virtual devlink ports
Message-ID: <arpQcc3pSDwiYKwE@L30177.local>
References: <20260923-for-upstream-dpaa2_ports-v1-2-b59c865edd00@free.fr>
 <179051507094.2160803.2316498936147241429@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179051507094.2160803.2316498936147241429@kernel.org>

Hi Mr Bot,

> [Severity: Medium]
> Can this race with the endpoint changed IRQ thread during probe?

Yes, see v2, patch 1/2.

> [Severity: Low]
> Is this still true when the topology changes after probe?

No, let's focus on the DPNIs for DPMAC.

> [Severity: Low]
> Is the warning that follows still accurate for a virtual port?

Yes, but with an edit based on Ioana's reviews.

pw-bot: cr

best regards,
  Vincent
