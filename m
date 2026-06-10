Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C2516132A
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 01:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781056645; cv=none; b=o8Gx2fEhvRg7dVCHhZ7AjccpO3TREtip2lJG540+xp2h7orp+iBZXjiuNekuquzi1sEm5GzNQtidazfmM2HkN+9XwBo4rXpu9+JeIblu8ewkqYvHa5tOMLwquEskT48ZLRujT++yEt8gqUQ3pqCp1YfE/4UMDI8+LGY/Ga83Dgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781056645; c=relaxed/simple;
	bh=MaTkXT++CTdnHudW5OCYihbDjsp6eGjrtgf1c9O6Mvc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vwx+5D2BDwNYjH3MaGGrn7bTPuRskmJNVvjia4ayb2wGQlBxzmEOKMI6zBnts3/pWW5Xd9PyjKtNPq1tZdobUvlssZ5HASS0EWrBINGwHlmJbRxel4Oi8S6PWyhvzh2XsaAdkGOQsLM7niyRkkoQmZT/Zi/Zesq1KfbnmLqtt4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AtRyIJlK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AtRyIJlK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 099151F00893;
	Wed, 10 Jun 2026 01:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781056644;
	bh=9s/N5chzqR2WXetjj60ZVAYsngfF9X4zNDL5a12gh1k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=AtRyIJlKsJhMNaF7kkkkdudCDRibtarrW2Yqc9Gr9VoCNDzYiSypEIHmaaDNy/uUl
	 U0dtxR7aXC0jeXrIbcNVTYZ3iIczIP8G5t66qJADIHJZxhdGlWKRewPqiblu0fM/94
	 Ezc+S09JLpU21G6mXb+k/O7fuAwVAKK31a9WZorEphtU81Ksp1Kbzf/nNxLBYhHy1T
	 MxWCr1tnp0KAs8skDEw6LOq7sDsH7qnyJm/UwKitCCOE6/zACRxvDgNhesGyNffx1O
	 xHdyL+/19MbdI3zBm0r47DFRxyDrMgXAuiMm1GXblJKbymOfEp7kzPyqHiTT2m9aO4
	 79dGvKEgEK3Ig==
Date: Tue, 9 Jun 2026 18:57:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, Jay Vosburgh
 <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>
Subject: Re: [PATCH v2 net] bonding: no longer rely on RTNL in
 bond_fill_info()
Message-ID: <20260609185723.6c5352ac@kernel.org>
In-Reply-To: <20260608135051.637439-1-edumazet@google.com>
References: <20260608135051.637439-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  8 Jun 2026 13:50:51 +0000 Eric Dumazet wrote:
> Subject: [PATCH v2 net] bonding: no longer rely on RTNL in bond_fill_info()

This one does not apply
-- 
pw-bot: cr
