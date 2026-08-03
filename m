Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D29840F732
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 20:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785790758; cv=none; b=If4Xbq5HWVLntNP6wxyf2cqhLGcgBUmsMtyD2HyJCEhBCPc9jRl8EvBOIdLT4vk/8ChQPWhI97l7yj0SXub2f87dvGoUCVpI39pKD0/7noXxjoW9thhYtS/Uqi2CSWhlyDsrfMmNqchwCVSvdtb1l69ry6d8GDLqW0aSbXKYl1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785790758; c=relaxed/simple;
	bh=V4CJ75gLECEUxsHVcgNDwcdOIKHfsSdh9LT8SED46yg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RY2YflZ14vYnPivIrQQySgwoxWz02X/WBa8NWvj28zro5SuEqf2cWh1TLrJCcfpe+hRY3PvVcPrIf0DjVw2dEX3ixd8Ihcsj8eDDjIu/Mafc1LtTVB+KcP4OXTxF7XSfXVpg45BO3R/7JVNGLl3jX7wERIoxIwmaSJRCnNSwaQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oxmpSYxY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxmpSYxY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61F481F000E9;
	Mon,  3 Aug 2026 20:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785790756;
	bh=ClcSgrJjW/ijHyyDod/jKCtnBovvJQCwou2RZ32ZpXY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=oxmpSYxYqux/AcT28QILUXTcV9zWDPcQSYG5LFHC/76LyDfBKHOKainFh+rZrt0Lz
	 N9mK8ZIY8OIm8KUA4GfnB2oqCLNXqa+LDJ3sRyVQmlGiL+eMxat7Mu6YIxJciq7G7L
	 QQXkrRGuNdzX5ERKtEo9NyPFUhi+cLmPi/zFMyfD+j4kriMibK8sAEbembN3MBSh/u
	 PmBIwrKYTryYxQRWjy7P1B7KdKyOyaoPqNVxMxgY2GbT6tzE/DeQAhOfj1OeY6AsE1
	 fa5gJNGSXMIZ5X08b81KqS3PdVPLt5IJkbpZHoA73uSJEwgD/7sFDYy3OC5DDBQsXV
	 3CQdiln0eh8aQ==
Date: Mon, 3 Aug 2026 13:59:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org, jiawenwu@trustnetic.com,
 duanqiangwen@net-swift.com, linglingzhang@net-swift.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com
Subject: Re: [PATCH net-next 0/5] net: wangxun: improve statistics support
Message-ID: <20260803135915.1fd95602@kernel.org>
In-Reply-To: <5FB351D7-A14F-4B30-A172-6D81417E4E69@net-swift.com>
References: <20260731074958.19333-1-mengyuanlou@net-swift.com>
	<20260731164407.4ca13f14@kernel.org>
	<5FB351D7-A14F-4B30-A172-6D81417E4E69@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 3 Aug 2026 16:00:15 +0800 mengyuanlou@net-swift.com wrote:
> root @roy-System-Product-Name =E2=9E=9C =E2=80=A6/mirror-net-next/tools/t=
esting/selftests =EF=87=91 =EE=9C=82  =EE=82=B6=EF=90=98 main=EE=82=B4 ?3  =
=EF=90=BA 15:54:46=20
> =E2=9C=98  python3 ./drivers/net/stats.py
> TAP version 13
> 1..8
> ok 1 stats.check_pause
> ok 2 stats.check_fec
> ok 3 stats.check_fec_hist
> ok 4 stats.pkt_byte_sum
> ok 5 stats.qstat_by_ifindex
> ok 6 stats.check_down
> ok 7 stats.procfs_hammer
> # completed up/down cycles: 76
> ok 8 stats.procfs_downup_hammer
> # Totals: pass:8 fail:0 xfail:0 xpass:0 skip:0 error:0

Thanks, did you set up the env variables like NETIF?
The context you shared does not specify how you set things up..
