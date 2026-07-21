Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C07937756C;
	Tue, 21 Jul 2026 01:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784596705; cv=none; b=Vnpgl0BDklqo+VlRULTCBSvGYscx2gskXUynlk5qpJJupDEdBaFRr/Z+wMOEfA6uaQ8uvBE63y3ukePleeRzNd591uWhsLNC0BLEZCTKRdIMtCRpDywqxay3CPQ29QUoliqqCvEOrlbB3ATXH7r+Sf4NY0VeGMXU9ZywFbT/CAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784596705; c=relaxed/simple;
	bh=c14T6QGvdi7yMWyZo64Srr+moyuzmONsZrib92hryTs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nbxk2xCAWnDsP6lcesNjWkfia4BrAVm9BAmEonJCnp0e4hlfi4UHlOL2iQuHB5vvtTKrCEFSdPMMzKVQ4rWmlXsuTCKzt2NISiitAlImW1eRrCWboxWqK1S/SaQmQv941I8DWyDDq0q7hIhUq11+pGXe+/s4IxFyzurY1ZDu8rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zbsi1y/6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zbsi1y/6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68D3B1F000E9;
	Tue, 21 Jul 2026 01:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784596703;
	bh=vAmfUNansB+D+6dNzfM7lM4oL9aUpkHY2hK7MJtk6oU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Zbsi1y/6GUgZVPc7N/P2bvBP3hNmSTTpvqOoMnvIzg6OztG50MTupcxhnpUAlfVeq
	 RQA/7TZivuV49wapF4k92NFQ2lUtvT/+SM4uiAUd+n5+J9uyb6Vu9T4gr6VsjP0pKw
	 GXAFQa5Jv3dalka5YiknPW9wowkD2D+uCz2yW0wqu9VWvXjsO39S/ajj8tbByJBtwG
	 xPYuhgQFUz8HNu76EzCuN3uyZUOvBnE+mlCWhQpkyne+MtKbSdaSCirX92wLVKt7nh
	 bnSO/lV385J5SgVOFfnurmWO3qfsKjehzibUP1Jn1Sb/ajfrK/wF6QeRK9/YF8pJIl
	 k86q4Tb2mjKtw==
Date: Mon, 20 Jul 2026 18:18:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: zhangzl2013@126.com
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Hangbin Liu
 <liuhangbin@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Qianheng Peng <pengqh1@chinatelecom.cn>,
 Zhaolong Zhang <zhangzl68@chinatelecom.cn>
Subject: Re: [PATCH net] bonding: fix devconf_all NULL dereference when IPv6
 is disabled
Message-ID: <20260720181822.20b0456b@kernel.org>
In-Reply-To: <20260707010622.487333-1-zhangzl2013@126.com>
References: <20260707010622.487333-1-zhangzl2013@126.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  7 Jul 2026 09:06:22 +0800 zhangzl2013@126.com wrote:
> When booting with the 'ipv6.disable=1' parameter, the devconf_all is
> never initialized because inet6_init() exits before addrconf_init() is
> called which initializes it. bond_send_validate(), however, will still
> call bond_ns_send_all() even ipv6 is indeed disabled. It will lead to
> NULL derefence of net->ipv6.devconf_all in ip6_pol_route().

Applied, thanks.
