Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CD33EB7FD;
	Wed,  8 Jul 2026 18:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783535872; cv=none; b=Lze6/xBPleIlrLHHjZmYX9gOmqSjlqFNJV8pfs16J7dl+EB+jrzABt2FMAwV++lckBUYCAEq0ZRM27zccSwjq5BwZLZ+o0vBxq/MOFUjIPNc1/ZQKJx+YE2nU+p63btZw9NNrURNZhRsy191Pn3+nyNx0YYfDmH4D/vOZ97eiTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783535872; c=relaxed/simple;
	bh=IgXJAq9SYCHbCWqof8xOyQ6qnglHx0GjGd1Ey2P1qcg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h6gnyTZXJe5nXFZc2UbfUCw4nuRj/kTCls5/1fHfkSIti+ImG1TDS50GAqA2VA3G/miCzBJDpAVmsRX/pHLr4hvT0vbDZM6TG7o3H0KpK357BtJirACVTEtWeUNam3MmdhR8Xew80i1/9idnmkw/FXhtnb3YhHdw1Ah60/PqkWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=x0BNaDdM; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=XTGNHbM7; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="x0BNaDdM";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="XTGNHbM7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1783535869;
	bh=IgXJAq9SYCHbCWqof8xOyQ6qnglHx0GjGd1Ey2P1qcg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=x0BNaDdMW/npC6xPihbAjLFu19jm9ECMSGcBHL8NRr25qhGESo6g2D2Zmyp61hE9a
	 0rIcB5slMBdbcUz9kK46mvGBbfoMszM6ODb1krICJxgnPBlChqO+roy7uRDfLBTYzP
	 jsMi7V08T9+QTMcZqIclwuFFC2reEnzCSMMZk94hJFMhNyqvh7/xhzSEtoDuwX9UEP
	 i6W4Sy5dF4EvqU5RRnZBYyNcF8O60G8X6mBJRLANXT7rQaRG81q6zwj9oElqWdNdCD
	 VLJ1Gdm9A7FfwS+LpNDXQCtwiMBlL2k+qmIAH6s+ezL88QMWwvuCE0iRoqnEwMfqPg
	 nBO1NlNIDv5gA==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id E3AFD4943A; Wed,  8 Jul 2026 18:37:49 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1783535867;
	bh=IgXJAq9SYCHbCWqof8xOyQ6qnglHx0GjGd1Ey2P1qcg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XTGNHbM7hjYV3OACi0teXx/8y7p0GbWw54TiIkeO4DwZQxYywNOAL0hitGC7pwWAz
	 3jhSYjNSkkccYUQIG+bxSnp8j3BQBGJWtHyaqVb8hcAatnBNv4oBIJNc/eDWW59ua4
	 RuqGAywhETjHPN7X2gGpm1sk3+DwgI8zShvHE3h9xBY/z9chWSiw4OFiNWO9hKHv8K
	 u6qRC/JMv0IJU8f0vSrjIdaGABjMvMQcmxp0+kYO27lbs6KoUiqLIj3nRkOwZfZPaF
	 RG4EUUrsmfIY4KN+Q4DIzi1vyDjugSbU5vR8HN29UU5StqtUWgOtwy/BQ1pIXdsoCr
	 m3IUb+cMvVOLA==
Received: from [IPV6:2003:c6:9f1c:3c00:b761:2fd3:8ae8:9dbd] (p200300c69f1c3c00b7612fd38ae89dbd.dip0.t-ipconnect.de [IPv6:2003:c6:9f1c:3c00:b761:2fd3:8ae8:9dbd])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 9CA3B493DD;
	Wed,  8 Jul 2026 18:37:47 +0000 (UTC)
Message-ID: <b6f8cb08-7f06-4a08-af79-fa2a31556acb@birger-koblitz.de>
Date: Wed, 8 Jul 2026 20:37:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] ax88179_178a: Add HW support for AX179A-based chips
To: Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260701-ax88179a-v1-0-13685df67515@birger-koblitz.de>
 <20260701-ax88179a-v1-2-13685df67515@birger-koblitz.de>
 <0b75cedb-691f-44ca-891c-d42d5cd24fd2@redhat.com>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <0b75cedb-691f-44ca-891c-d42d5cd24fd2@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Thanks for reviewing the patch-series, Paolo!

> 
> Does not build successfully:
> 
> ../drivers/net/usb/ax88179_178a.c: In function ‘ax88179_reset’:
> ../drivers/net/usb/ax88179_178a.c:2376:33: error: ‘AX_VLAN_CONTROL_VFE’
> undeclared (first use in this function)
>   2376 |                         *tmp |= AX_VLAN_CONTROL_VFE;
> 
> Full log here:
> 
> https://netdev-ctrl.bots.linux.dev/logs/build/1119419/14655119/build_32bit/stderr
Fixed in v2.

> 
> Side process note: the patch series shoudl include the target tree
> ('net-next' in this case).

Sorry about that. v2 will be sent out with correct prefix.

Birger
