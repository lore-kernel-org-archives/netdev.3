Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F1F3A1C9
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 00:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785889937; cv=none; b=sCGZ5f7RHK86Kf+N9cVFD1RItqHZngopldV8HAuVc6GbrizpQtRlxletiB4UBfoz74uDKPk44H4UGNoaP3S6VQt9+uX73/ojRECaw8dTYP2PVTGI5TufacLb96myCl/zleOr3uXOgJEMHSPYNzj4R4BDXgqsw0fc6LXnMdyLwjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785889937; c=relaxed/simple;
	bh=+LuXU7sBCapnDAIiTfpTwwyDLFd6UJaLz8ZT1+JQKsE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PHhR7otaS1CxeLwCKaApZXwGTsUXJTI4A+Yz68fpKGEvPB8uJUkBI8qCUOF+JC2z55/ylDxq5qC0sEgTw1RE+7aOWhVBZ1UYRFtDYnd9oC4PNIFP+gPAGaZVYYcDn5MvLseDiA6FB5QhumI93spN2vUWZPeev8nuS4rmq7xba1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YdmP+0LD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YdmP+0LD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F5101F000E9;
	Wed,  5 Aug 2026 00:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785889936;
	bh=Dd9j6OgzQVRVSrLxe6ZgwvNmFVi1Iz5ecVLz+gQ4Sec=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YdmP+0LDTzV9+QnzHm3Uaz/gW8qgUoU/7xXkxWwrOjbQDwpRMKxJqc1xFhYkG/IPV
	 XiVrhw47XBf+2EbUJQ2kyQcm4smuDE0Ym867p54jQEkiuOI5NhTg6aMyceXj9eH1t5
	 JZ9Qq4cjwMJ4/kYnca5v7xLsMYaZeA+Ba6pRZJO6KNmiMkEGmAc48Vl4WMVkfnFBZ0
	 ZD40YLuITzWKt963POEIxbpQYhCjFp2ah2RBzi4DagVwSCnO4V5qvU5TWRns7Ju2KE
	 ldeT3WuuUvFwfXPBob2mnXvL03nhbfEwUBMgze+P/bAPYNbR/akI8ujS7+GnunDAlV
	 r9wIKfpna4MgA==
Date: Tue, 4 Aug 2026 17:32:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Sabrina Dubroca <sd@queasysnail.net>, Ralf Lici
 <ralf@mandelbit.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>
Subject: Re: [PATCH net 00/10] pull request: fixes for ovpn 2026-07-30
Message-ID: <20260804173215.3434f385@kernel.org>
In-Reply-To: <20260730094624.4102963-1-antonio@openvpn.net>
References: <20260730094624.4102963-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Jul 2026 11:46:11 +0200 Antonio Quartulli wrote:
> There are still larger fixes in our queue, so please ignore any
> "previous issue" Sashiko may report on these.

FWIW we're getting close to the final rc so please be judicious going
forward and try to queue "never worked, not a security issue, 
doesn't crash" to net-next without fixes tag if such bugs come up.
