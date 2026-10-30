Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.205.69.214
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793371629;
	b=W/qKUdrW2iqEXJ9uab0tuNiVwEm4PKwtYdmKFf+QymM0XhGl24Xdi8lNAEp8sMNZN8ho
	 spkWlp6CgFb1IJUfumc9Pc7JO17A2x2LWpB8ikaMFy5cAPdsXXr9B/qjPu5NiDJcP4Yjq
	 b/RAcqQiyKyt/HDNKzcuvnl8BQ2scSXQkAOAohPZ6e07GUKxKmtshG163fYjUVpYl53Yk
	 8cMK+uvmn+DTU67hyb1Ftn/UniJeABSBQ0Gf5LIAPm9LHEbLCYiEemnl8gUHRFtthgwJN
	 zFp9JIBYPbTjUKRlpQs3/6nZfbahbbzSNaXA4mdaO9YK+QAN8NwvqX6+urpd8uTtXTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793371629;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Message-ID:
	 In-Reply-To:References:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Feedback-ID;
	bh=F9ZBxaI/Z47jKetNWEIW1OlS9G1OaRvxx4Do7WR7EVY=;
	b=PUbnp50tvskCpomPH9Z4ywc0zSU3/OLPGO7zAvu2CHCJ3NVh4EEc32LFWyP9NTz+u6XW
	 wO0poKhBTXIAxtcz92pSjBDBt36F5qEEDV6xQ18YPAic3zh2bY8/nRDjeoVq3E1W4sIiT
	 +p+d4HXeEs5cztB3AReeD366fODpAueE1l6OA71AKBD0CLC5dHKa1EEBwt95U41n92cyx
	 Xm1KhGyoWtcfVPmLvCwwi88GFadinwa/xpM+vZku8NQW0OnxtzD39D7SlWcSqritpmCqz
	 kYvegHvDJXYtqtzmlH2em6XhyrLO+AkykOoiKXlawpSxhqm/L58QtbVe7kSaHF/v9LQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=well-founded.dev;
	spf=pass smtp.mailfrom=well-founded.dev;
	dkim=pass header.d=well-founded.dev header.i=@well-founded.dev header.a=rsa-sha256 header.s=s1 header.b=eoeA92vo;
	arc=none smtp.remote-ip=185.205.69.214
Received: from mail.w14.tutanota.de (mail.w14.tutanota.de [185.205.69.214])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376FF606A31F
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 14:47:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 376FF606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=well-founded.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=well-founded.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=well-founded.dev header.i=@well-founded.dev header.a=rsa-sha256 header.s=s1 header.b=eoeA92vo
Received: from tutadb.w10.tutanota.de (w10.api.tuta.com [IPv6:fd:ac::d:10])
	by mail.w14.tutanota.de (Postfix) with ESMTP id 82BFB19F60E3E
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 15:47:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1793371627;
	s=s1; d=well-founded.dev;
	h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Cc:Date:Date:In-Reply-To:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:References:Sender;
	bh=F9ZBxaI/Z47jKetNWEIW1OlS9G1OaRvxx4Do7WR7EVY=;
	b=eoeA92vogltrWNHgrIR++U+3YBtIicMPZW8ZfJse1BrCRnCSPQ+o5p8uPU/yYU5i
	yuF3QkdWvHtz9uMzDvr2hLpQarand0IKz6QjsxLFqAnZzMGjVFUvd/w+/oSHqNpVNFn
	ITuJw5jVKLilYtRDDoNqUxGsVNDONYDd8tdxPeQIe1n1Tv1I+F7t3jgnk3B7tfRRvjB
	t17BqIWBoDqYvij7nR1MmgBlubwK+PaLK96zmX8JpOmkzKqtOia+Eqg3gcGt+fOKSN+
	0dNc5R7rLRD3vbLnlRfoUkg47HZKMsFofpWUtOXPuuOflYlDmefA2loO8oA7mzWlONf
	t4rxkx6VKQ==
Date: Fri, 30 Oct 2026 15:47:07 +0100 (CET)
From: Ramses <ramses@well-founded.dev>
To: Netdev Bot+sashiko <netdev-bot+sashiko@kernel.org>
Cc: Jv <jv@jvosburgh.net>, Andrew+netdev <andrew+netdev@lunn.ch>,
	Davem <davem@davemloft.net>, Kuba <kuba@kernel.org>,
	Pabeni <pabeni@redhat.com>, Jbohac <jbohac@suse.cz>,
	Edumazet <edumazet@kernel.org>, Netdev <netdev@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Razor <razor@blackwall.org>, Hangbin Liu <hangbin.liu@linux.dev>
Message-ID: <P5CGmHQ--F-9@well-founded.dev>
In-Reply-To: <179336101737.3134.5509394527190638689@kernel.org>
References: <20261028-bonding-last-rx-v4-0-4d8e4cd47467@well-founded.dev> <20261028-bonding-last-rx-v4-2-4d8e4cd47467@well-founded.dev> <179336101737.3134.5509394527190638689@kernel.org>
Subject: Re: [PATCH net v4 2/2] bonding: give a slave that starts UP a
 full
 arp_missed_max window
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: 0163e381fa67fa966160938ffa017803050e57578bb1735d37cd25d20463a96a9bb3a550250bbc5eaa94bfdfd8cf3defcf1aa43859ae980630826bb8230f264e7f:TurnOnPrivacy!:tutamail

> [Severity: High]
> Does this fix still miss the case where the ARP monitor starts some time
> after enslavement?

Yes. As the review notes, the old seed behaved the same way there, so
this is not a regression. v5 narrows the commit message to a slave
enslaved while the ARP monitor is running. Reseeding when the monitor
starts later will be a separate follow-up, see my reply on patch 1.

