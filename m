Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09906470453;
	Wed, 22 Jul 2026 09:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784711238; cv=none; b=fVrKRcwjKNF5WwX65BrrHXUydC2HSWyzSYb0DaLiZDAWr8QJL0VEjz57OqCPmqk6RKVO6JKbrNb/y+qN3Ny9aklalBi7bScSVH+h0NcoeACMdRll1j1ZHqc1l3QSC82up/i4H01gpv0EgDFrtdrmKXthX0siUxkLJ265o1yKG0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784711238; c=relaxed/simple;
	bh=y33ysv9A40HC6+7o66iqdcQ7JSza7spehCpdmR946f0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p7eDJsc91E7vFDsrAXgtfFy5UdGHwtUJjonfxtKDWzJJQCKpi2iUipHwj5oy7a6NR5ymUOMPoU+caYGjlxbPfMu2/ch7Fy6YH55DqNvU8BJxFDAFUOzF4PcIjVw80gKphnabsA5YfrUR4Dqfh34w5hVf2Zprp7nAwNGyOwBqsm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KwTw73LZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KwTw73LZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80DE01F000E9;
	Wed, 22 Jul 2026 09:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784711236;
	bh=2Uy+NcHe4OTWSAQUMgBXEWSz8caAu/VLwGHOTz6jiYE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KwTw73LZsGHUW7GYLO/zTJHU0upUJtFtfGr7243N5yjtc6q6SM+Z2aFMPY3G4gBLH
	 2dsQdDoeHJ/bG2/KV+h4sX755+8Js+uknc5tR5+Du2w2Og05J//ujFepuqv+u6sklh
	 cyrl1XuoTA2yPr3r4aUGDNBSGQ/1OSLnVAjXhovgOGIIhlSvymU6xhcZaseBQpMWr6
	 ffwohOTp2kQvr7zapEYDkf1AfFQP0TcToyQP8vf76CQNUf8BsNHuBEc/O04DNx4h75
	 GZZzcB3tKT3k9QETNKaMBHPVI1EqUtyd5E/eERyQ+03M43gMnxfDMjFOUM+qfWSzOp
	 qgW7BCPV5fpYQ==
Date: Wed, 22 Jul 2026 10:07:12 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Adam Young <admiyo@os.amperecomputing.com>
Cc: Jassi Brar <jassisinghbrar@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: Re: [PATCH v45 3/7] mailbox/pcc.c: report errors for PCC clients
Message-ID: <20260722-quantum-efficient-loris-adb10e@sudeepholla>
References: <20260721175258.87600-1-admiyo@os.amperecomputing.com>
 <20260721175258.87600-4-admiyo@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721175258.87600-4-admiyo@os.amperecomputing.com>

On Tue, Jul 21, 2026 at 01:52:52PM -0400, Adam Young wrote:
> The tx_done callback function has a return code (rc) parameter
> that the tx_done callback can use to determine how to handle an error.
> However the IRQ handler was not setting that value if there is an error.
> 
> The following clients are affected:
> 
> drivers/acpi/cppc_acpi.c
> drivers/i2c/busses/i2c-xgene-slimpro.c
> drivers/hwmon/xgene-hwmon.c
> drivers/soc/hisilicon/kunpeng_hccs.c
> drivers/devfreq/hisi_uncore_freq.c
> 
> All of these only use the error code to report, so they
> are expecting an error code to come thorugh, but they
> do not modify behavior based on this code.
> 
> In the case of an error code in the IRQ, the handler was returning
> IRQ_NONE which is not correct:  the IRQ handler was matched
> to the IRQ.  This mean that multiple error codes returned from
> a PCC triggered interrupt would end up disabling the device.
> 
> In addition, if the error code IRQ was coming from a Type4 Device that was
> expecting an IRQ response, that device would then be hung.
> 

I recall reviewing something similar and may have had comments, although I
cannot locate them at the moment, thanks to your random patch inclusion
exclusion scheme in this MCTP over PCC.

Could you please avoid continuing the MCTP-over-PCC series in its current
form? In the previous v44 revisions, PCC changes appeared to be removed in
some versions and replaced with unrelated changes in others, which has made
the series difficult to follow and review.

Please post PCC changes that are independent of MCTP as a separate series.
Where the MCTP implementation depends directly on those PCC changes, they may
be posted together. However, the current series appears to include several
unrelated cleanups described as part of the MCTP-over-PCC work.

To keep the review manageable, please separate those changes going forward. I
may need to NACK future revisions if unrelated PCC cleanups continue to be
bundled into this series. I will be away and would like to review any PCC
code, so your patience will be much appreciated.

-- 
Regards,
Sudeep
