Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794487708;
	b=VDo/BFSffETgnheP44DGsTPU8JD4LEJfDHs/h6+JGqp0Q/SXKVjmKF3J1xz3AxRBYGcd
	 5n+bmMB9UXuxKQPVbfUX6WH40GydYtmuJ46Q5U0PxgAq1e9BGoUPtEjCDvO/AHaSftm95
	 iy556ZQ3wlVNfBnL8fuPKEZZSBmzLRiaXVUWJY4oK5BVShMRpEgLMKOsmkSSze+IZY3nD
	 e+aWT3J0e0Ng1bIxKaHsTRBZuWqh8k9cbARix/6/cCRT1Pt73j8T8qGGkDZiV+lmuJ0nn
	 QviisvKmWpT63dQ9PCDAbhxqqBjNmOeMFrCSQRMao3fGDOsd4YNECVVFgglpx4areDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794487708;
	h=DMARC-Filter:Received:DKIM-Signature:MIME-Version:Date:From:To:Cc:
	 Subject:In-Reply-To:References:Message-ID:X-Sender:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=2ydDXOxFBj0SVycf8TwirFfYbpVr31/wQtaeKtsEhMo=;
	b=tiNic/c4Sfa+f+bfquFWtScp9N/jsD/B7T5J8IxXlirAjPvqhbDFFKeJihhUN+nlllfn
	 VJEf5hnARtHBWUocJKZTAum4UzQcL7RCXthucG6x9P26GSwi7rnjwKwfIqKqNcE65H31O
	 TWBYIdZH3mJUdpS2zuwsEn2Re9cL89pFfsLj8K0VBgRhi9Jd3icExHZys/uzkL0js46XP
	 tvTNl/F50sBCWL7NghCPhYxHTgbq+9ZePXVJrTQTS19vBm2s/pEg6Q3wypm+PoQF8RH6b
	 PODpK4a35MrNsKuK+YsmhbGeoacFY8W0MYUl69RWWX8uPd4YN4hJOfc2IEtsMI/b9dQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=D7HcLpg6;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB06606A32A;
	Thu, 12 Nov 2026 12:48:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3AB06606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=D7HcLpg6
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 49B8BA1563;
	Thu, 12 Nov 2026 13:48:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1794487705; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=2ydDXOxFBj0SVycf8TwirFfYbpVr31/wQtaeKtsEhMo=;
	b=D7HcLpg63LrjbttMO0pxYYrV4lPsjGVL0AmomQUy6vklnuvaQd47hBSSw4M9yWYO0IvDS7
	EVJQkjzDstRV1nWS5gxD9evSHMU00LKFV2Uzinb5em+0lDA7Pv3vUfuE1n02P9x7z2s8AL
	udl0MFHopqM+m2nkP2W7T3sJtdIog6KxIRdIsNS1gCUOPuQXJhis4QC2AkFRo6aQKBUfGc
	kC50mM3sfe5RaXlFC85b7EaySfN3e/FHI1IoNH9JX1HzYioAuS/YdW44UO6AA3UPtA++Jk
	qFmO1Wp7Uy3WXtCFl4AojrHhJbA82rGMQDAnvR5sBbBMlpea4W8bxk5/tz98vg==
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Thu, 12 Nov 2026 13:48:24 +0100
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>, Scott
 Branden <sbranden@broadcom.com>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Andrew
 Lunn <andrew@lunn.ch>, Stefan Wahren <wahrenst@gmx.net>, Phil Elwell
 <phil@raspberrypi.com>, netdev@vger.kernel.org, James Clark <jjc@jclark.com>
Subject: Re: [PATCH 3/3] ARM: dts: bcm2711: give the GENET MDIO controller its
 clock
In-Reply-To: <6125aa53-4fad-46ed-b627-e0fce7df7b84@broadcom.com>
References: <20261020-devel-bcm2711-gisb-clk-v1-0-a1728724d0f8@tipi-net.de>
 <20261020-devel-bcm2711-gisb-clk-v1-3-a1728724d0f8@tipi-net.de>
 <6125aa53-4fad-46ed-b627-e0fce7df7b84@broadcom.com>
Message-ID: <c00ede37512d46c8155647eed7e39450@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Florian

On 20.10.2026 17:40, Florian Fainelli wrote:
> On 10/20/26 07:58, Nicolai Buchwitz wrote:
>> The MDC of the GENET MDIO controller comes from the GISB clock.
>> Describe it, so mdio-bcm-unimac can get the real 200 MHz from
>> clk_get_rate() instead of assuming the 250 MHz of the STB chips, and
>> can put bounds on when an MDIO write completes for PTP.
>> 
>> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
> 
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>

sorry for ignorance, but I'm not familiar with how the ordering between
these trees is usually handled. Patches 1+1 are in clk-next now 
(af7994af5228,
ab94dbf30233), and the last one for your dt tree needs the define from 
the first patch

Do you take the dt patch for devicetree/next, or should I wait until the 
rest lands
in mainline? Thanks!

Nicolai
