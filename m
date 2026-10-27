Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793093476;
	b=5tHTuXr9ydS8VxVIiTg6NXK/whX66I7ba7eKfEvvtyePGXfroIhCNHwg/OOhu07MYkNV
	 JeTQ47cqeQ4bAZ5Ii6CJAwLwDWssFnGaZRSx/9FGV0Q/RsJgIBwQG3d6jBqeEcmAD8QeC
	 pOScfIvefEx3tnXD4Snlj8FbipbQpr2ACGbRbDby1GlfOyEorkSlJZKsWEQd/Dmij+37v
	 HqlSK+whLYfXfAyR9m9Qo5C8PormxEdTV4ap3+ngJWt72KvqXuuQd1e8z2pfGsG+I9J00
	 17TndJ9r4+xraqJl5jzRUcHAarbAw+x4dixU7IL58XAIGLvKSj8tZ0qNOtq4x2zeoQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793093476;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=kIXCKvOTKtSXTnAmt+w2O5J3oCLsmilmPqyShsZT8Vs=;
	b=mGvh0DHuf5Tjs5OFr0ihWs+aUW6fcMLJOACRtkdb0+IgPToZPoD80XyXSTCVcNvgpjOp
	 3B62yxLeht1GB6NURZXsMx67vueu4/xuhh2/MllDVT9mMtYoiIWYXg6AQnt9ivxwiRqKo
	 0IL7dNSM/+EfKAZHPfA2ZNMtVu85hEXggPUxaIjub69yF2HJ+qR5WdXnlSYOoQqHaPnxq
	 T58a8JxWL/oyaHRfFccHVcqSb1Rv6d7E+si5tTtIiQY24NY5FNVt15eDze5jBewRsYvAh
	 JF4ZnEWGIZTXjXx/JDLp7035IaHZNppROmW7a5H0z1V5J3fey3Zz61A/HfPsipc/L6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=TOPyQ1WI;
	arc=none smtp.remote-ip=95.215.58.108
Received: from mta1.migadu.com (out-108.mta1.migadu.com [95.215.58.108])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203CA606A31A
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 09:31:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 203CA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=TOPyQ1WI
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=SiCopvP+yMT0xlwZ2moQJ9M5qKmGAl7iAC0O0RjC/0M=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793093473; v=1; x=1793698273;
 b=TOPyQ1WIMjqfIiE1Hic3NjFMjMCQncNZBcwpogDTnEhep6VLeb0QhbW6akilADh+9Hwf6HQy
 USb90LqBiZBbaVoeqg2aUwyqocWBGuHP+rtbFUWbe9FTA5/tsmI5iJKSI9EcsQ/AHOh/WXOekq5
 8qHBk0rQ9XiCFL2rL8xTyDUc=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 217aa2d2c16b77b4;
	Tue, 27 Oct 2026 09:31:13 +0000
X-Mizu-Trace-ID: 217aa2d2c16b77b4
X-Migadu-Flow: FLOW_OUT
Date: Tue, 27 Oct 2026 17:31:47 +0800
From: Chenguang Zhao <chenguang.zhao@linux.dev>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, Jonas Gorski <jonas.gorski@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 0/6 RESEND] net: dsa: b53: PCS fixes
Message-ID: <20261027093147.GA1548768@pc>
References: <20261022225656.1387306-1-florian.fainelli@broadcom.com>
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
In-Reply-To: <20261022225656.1387306-1-florian.fainelli@broadcom.com>

On Thu, Oct 22, 2026 at 03:56:50PM -0700, Florian Fainelli wrote:
> This patch series fixes a number of issues found with a LLM and while
> testing on a Broadcom Northstar Plus reference board (BCM958625HR) using
> a SFP connected to a fiber converter:
> 
> - there was no serialization of the registers across multiple lanes
> - the SerDes powering down was incorrectly managed and should have used
>   .pcs_{enable,disable}
> - the interfaces advertisement should have been confined to successfully
>   initialized PCSes
> - the negotation and forced link parameters were incorrectly supported
>   and should have used pcs_link_up and pcs_inband_caps
> - link state should have been reported through the PCS
> 
> With these patches disconnecting the fiber cables triggers a link down,
> as does disconnecting the fiber converter from its cable or powering it
> down, ip link up/down also work properly as a result as well.
> 
> Florian Fainelli (6):
>   net: dsa: b53: serialize SerDes register transactions
>   net: dsa: b53: manage SerDes power through the PCS callbacks
>   net: dsa: b53: constrain SerDes interfaces to initialized PCSes
>   net: dsa: b53: configure PCS negotiation and forced link parameters
>   net: dsa: b53: report link state through the PCS
>   net: dsa: b53: apply resolved link settings to serial port MACs
> 
>  drivers/net/dsa/b53/b53_common.c |  69 ++----
>  drivers/net/dsa/b53/b53_priv.h   |   4 -
>  drivers/net/dsa/b53/b53_serdes.c | 407 +++++++++++++++++++++++--------
>  drivers/net/dsa/b53/b53_serdes.h |  13 +-
>  drivers/net/dsa/b53/b53_srab.c   |  12 +-
>  5 files changed, 345 insertions(+), 160 deletions(-)
> 
> -- 
> 2.53.0
> 

Hi Florian,

Please take a look at the issues Sashiko reported.

Thanks,
Chenguang
