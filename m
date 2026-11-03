Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793707771;
	b=sP3ANg1/TMn3cjK0VgxGwtpID/6UUds21zoqxlcuz46oxnDjMLYUmJUWXUj1F7eUCxpi
	 1j7MAGesrFcHHDaa+D2rWXzfq75G3TQ2LgFPgvqyIMxU8fx3RRj9RcXljLxfLDKc38cWw
	 0egSbwHNgZVDFXYarPoJk+n8kFM1lZqslMu4V0+fN7zs3hXDtQmBSNqfw5swpb4aV6Oyy
	 dxMnpUjSMQyVFB/2j4snwownaXr+o4ZhHDwhPd0yYw6tZEqHGhI19doTWOeW30oQuI+VV
	 7PVJINsCPTkAg/k4MVaeqoQ8CJJwuQihZLeLOFbiTKr5gzWtuUf1OqIRheRvnPa755A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793707771;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Debian-User;
	bh=sV+R1FT/pn2Zt/OXRGgG36sgbz06VwTueul13RNvQCk=;
	b=0VuU8mrSyX3qX78Cmzuqlw+ZJ2jvkU6OFOAEaq0rKNVFy/LG1mgD5YWjw2oxV/agRKP4
	 VXsHM9DdzK8omsXVnKG+7LHnXWCDr3nE22k1tU2RTRi2faOiKBHu/nlqyspn2mMQaFK+h
	 mZrDdT7bGpEU3tAtc5qayg4rUBU/yEXTT2gTteAIVVQxodR+0W4AfS8bQt99Of7nvNIes
	 AvqLyU9QbvzwnQzPrT6MZhDwC5BEjCRysvaO2AxE7cY+PRDYCuLPE3x7KukgqQBwcG6I9
	 7VaTkUURSMQ94TTq2GZ7pwyvcrZgFukb265+UF2PWYSmzvXtDmzhYMLzrVe2C5H3tog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=jcz6+OJ+;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CECD606A329;
	Tue,  3 Nov 2026 12:09:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6CECD606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=jcz6+OJ+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sV+R1FT/pn2Zt/OXRGgG36sgbz06VwTueul13RNvQCk=; b=jcz6+OJ+2zTZ+Rm0G9VcvXhKJl
	J8aoxQzFiPl+WY56Au9tgtShkQL11ctyM6ACag7SmXengwlTfeL3yNtS7iniSp9v3agMqPDB+CZH/
	DBcYuLxko3/+IJOHDwSx4P5yNa/KmZvCOiOHmDAVjYUAoYHNpmAgNeIPUAxAt3WUvx3urmLhNmv5Y
	LVL2pYank1CxMyhZ0WHy6Coh9RrdoDmDufWNnhp30nGpqcMCrEV9FvTkz0Bm6NqcOCfhDUoDVWtvP
	umFkZKaOsgIGidpTQZbSbpWGNCcujn/voMXQeyRDFxGpqQ9VsoPoEToKEtpL9NYLQC45aK7P2OdMC
	BY3q7vTw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xODKP-006vIm-10;
	Tue, 03 Nov 2026 12:09:26 +0000
Date: Tue, 3 Nov 2026 04:09:21 -0800
From: Breno Leitao <leitao@debian.org>
To: Gustavo Luiz Duarte <gustavold@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v5 3/4] netconsole: recheck device registration after
 waiting for carrier
Message-ID: <aunO6ayPWIou9euS@gmail.com>
References: <20261102-netcons-fixes-v5-0-bdada2f03563@gmail.com>
 <20261102-netcons-fixes-v5-3-bdada2f03563@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102-netcons-fixes-v5-3-bdada2f03563@gmail.com>
X-Debian-User: leitao

On Mon, Nov 02, 2026 at 07:54:51PM +0000, Gustavo Luiz Duarte wrote:
> netcons_netpoll_setup() drops RTNL while it waits for carrier when the
> device is not yet up. If the device is unregistered in that window, the
> NETDEV_UNREGISTER notifier runs before np->dev is set and has nothing
> to match.
> 
> We might then end up setting up netpoll on a device that is being
> unregistered while holding a reference to it, stalling
> unregister_netdevice() in netdev_wait_allrefs_any().
> 
> Add a check to confirm the device is still registered once we retake
> RTNL. Release the device reference and return -ENODEV otherwise.
> 
> Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261012-netcons-fixes-v3-1-1aac85ed7665@gmail.com
> Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>

Reviewed-by: Breno Leitao <leitao@debian.org>
