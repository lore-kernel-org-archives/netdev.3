Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1D5231842;
	Sat, 26 Sep 2026 18:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790446296; cv=none; b=bCZ81V5J3WTHVjji6+oRXbzMeRHc04anCHtSwQE44WmsJQak7qdQp31vRsNolBb6pyrmpsW44b03XAYNpW0Ze6m0rlvw8BmDETDzr1lBfXtpgToQf6Ye/H09Z5DeLuWi3NuW8Vum+JCbdxINMUid2uTIBVwvbIZZ8466oAM3gqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790446296; c=relaxed/simple;
	bh=8uP7rAb8l2Ao2RQf4BtNeyvxC7ZjUAcA4X1oMQV+DBI=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=ZVG+WMcj6PkT1hKFaxrHJMJx58kAJmwRMEgra993ru7z9iIKecGotRDTBQJaCchjhlAVzgZ3qy2DRtM4BNyywiejUUBRqLQOPeurWIhbtTfGL3ZzC9tyb8aCQbZVIm65NblFvwd0oOzgoRXIa71QRnUUkTKItgff32X9+pq15pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=I+MDfu6s; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="I+MDfu6s"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 453A2A4A3F;
	Sat, 26 Sep 2026 20:11:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1790446291; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=jP7JBnt23+MR4NcbeFytdTegi/bUoZezmjWWIJxkP+U=;
	b=I+MDfu6sJ01d9E+PC19KxTx2t9FG0vp6PJcm8ffbGcOpqkTMPGTOoIt5DweotudHUe4DBs
	B3Pw8Qae+RegbQhp9IjRrK/YL78iKoD82jYvrGcoHYY5PDmkv+mN2qBCq+C9y9Dn0t5fcA
	8cco2LyFRu4UtKMVVqs4xlMR+K2qfDpB8xapghSaXV8dVuW8wUaEtv/aZVeq3C6fHzIFQ4
	J1uQ2EAuqgaKhzHpNiL2wHXIMQPHpuZE5fkUsqQ7RxCOf45YObxLyXffb5+3zLvab4Jr5W
	aQdDUI10UmPGjhCBxrW4tIq3z/cpBlmD7WUCyy1vHnsLTW9HXm1+q/kihcNUDA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 26 Sep 2026 20:11:30 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: netdev-bot+sashiko@kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, andrew@lunn.ch,
 kory.maincent@bootlin.com, vadim.fedorenko@linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 2/2] net: ethtool: let tsconfig reach a PHY-only
 timestamp provider
In-Reply-To: <8100d62f-7615-4129-a633-7f4c7404a0e2@bootlin.com>
References: <20260925135237.3432266-3-nb@tipi-net.de>
 <179043085090.2160803.7251184093173489740@kernel.org>
 <5ee2fdb9e5303f23b2d61c06479df489@tipi-net.de>
 <8100d62f-7615-4129-a633-7f4c7404a0e2@bootlin.com>
Message-ID: <2a1feb85b469c58918507e3d73b99305@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Maxime

On 26.9.2026 20:03, Maxime Chevallier wrote:

> [...]

>>> [Severity: Medium]
>>> 
>>> The removed ethnl_set_tsconfig_validate() required both 
>>> ndo_hwtstamp_set
>>> and ndo_hwtstamp_get. This new check in ethnl_set_tsconfig() only 
>>> tests
>>> ndo_hwtstamp_set. The matching check in tsconfig_prepare_data() only
>>> tests ndo_hwtstamp_get.
>>> 
>>> What happens on a netdev that has ndo_hwtstamp_set but no
>>> ndo_hwtstamp_get, and has neither a default timestamping PHY nor a
>>> hwprov?
>> 
>> There is no in-tree driver with ndo_hwtstamp_set but not _get. All 73 
>> files
>> have them in pairs...
>> 
>> Even further, the asymmetry is on purpose. The get side tests 
>> ndo_hwtstamp_get
>> and the set side tests ndo_hwtstamp_set, each gate testing what its 
>> own operation
>> needs.
>> 
>> If anyone insists on the symmetry, a v4 could add || 
>> !ndo_hwtstamp_get. But before
>> I respin again, let's hear if this is really needed.
> 
> The current way LGTM :)

Thanks!

> 
> BTW, I raised that point a while ago [1] but now that you're properly 
> handling
> the "MAC can't TS, but PHY can" case, we may be able to get rid of the
> SIOCSHWTSTAMP code in phy_mii_ioctl() ? as a followup of course :)

The code seems dead indeed. I will have a look and send a follow up then 
next days...

> [...]

Regards
Nicolai
