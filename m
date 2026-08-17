Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EAF3BA235;
	Mon, 17 Aug 2026 08:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786956626; cv=none; b=oloyqy6JHIpZ1LPEaCVVrlPnK/TXAYG4U6SeS43QnAKl5FRhVYfa5JwnfKPTt366y8yDzLYJlBkoSdpk93dbuPUzq4RfQIvMe5D1u2QNv7lVGxgyZfw+s2M9bEkkmJvkV+bjoRJUL5I2BcfgHXPFSwLssti6NgQDhGlLWDl+iTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786956626; c=relaxed/simple;
	bh=wAVEjEINKBKb0G4qGhjFZHDGJsArrltDbB57M73vEe8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UmfNdYCsYTUv/G3Vbp/BvgpCQOumQ+qQhXBIfqlRgH71EjgKNNfSQCZ2oNviFVmv1ZEccMcS9JpS5WWKfcjJCkPf2fnxjNi645aEc39ZrhUtrIkY0gGhytAr2IPZOCLMLNlaSgHoKPUXhRV3bF2Iph10A7OsGQcnUOqZ3Cum7nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=rahXes6g; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="rahXes6g"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 6865120684;
	Mon, 17 Aug 2026 10:50:21 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iOzVyp-9Cz7y; Mon, 17 Aug 2026 10:50:20 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 92F4F20185;
	Mon, 17 Aug 2026 10:50:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 92F4F20185
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1786956620;
	bh=0PCW2hWoR4OS+gPfuutTRrIUtGagjdqgYSHA68PxZ1Y=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=rahXes6gKxrh7eN/Kca/wBQOodgSMNsGEJ9koqDJ7kjyvmnshv1eop8znqxh09Nvn
	 SavdbA/RjHm4+sirnqXElrQq7tazXNxkmRfEJLPVzJpBa80eBClk1C52XYN8r/di9E
	 SZOkkfimGtyu3OrEEBm0u8COkLPSuHzBTNhITk01chZ2ztycJCqTuBRB10JSxpS3Sg
	 tU4X90d2H4J3SlVyoxEJAHzoVbwui12IazsBT3g7QKjdpEBXBfl73EirPAtny1a9+1
	 IXIJjZHkNR7leD/NrunxQdmCxoiHWOUQ0E+1oBkx+LqPeYxvQejMi9+ovutVDXGTfE
	 Da3CC0w5pib9g==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 17 Aug
 2026 10:50:19 +0200
Received: (nullmailer pid 2459302 invoked by uid 1000);
	Mon, 17 Aug 2026 08:50:18 -0000
Date: Mon, 17 Aug 2026 10:50:18 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: =?iso-8859-1?Q?=D6mer?= Mete Kaya <omermetekaya0@gmail.com>
CC: Herbert Xu <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<syzbot+d3bc2f2eb498a0175940@syzkaller.appspotmail.com>
Subject: Re: [PATCH] xfrm: fix suspicious RCU usage in xfrm_nlmsg_multicast
Message-ID: <aoLLSiD7yjcaH_BI@secunet.com>
References: <20260803170525.1767734-1-omermetekaya0@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260803170525.1767734-1-omermetekaya0@gmail.com>
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-01.secunet.de
 (10.32.0.171)

On Mon, Aug 03, 2026 at 08:05:25PM +0300, Ömer Mete Kaya wrote:
> xfrm_nlmsg_multicast() dereferences net->xfrm.nlsk via
> rcu_dereference() and is documented as requiring the RCU read
> lock, but 11 of its 12 call sites in this file do not hold it.
> 
> Move the RCU read-side critical section inside
> xfrm_nlmsg_multicast() itself instead of adding it to each call
> site individually. This is safe: xfrm_get_translator() takes its
> own nested RCU read lock internally, and nlmsg_multicast() is
> called with GFP_ATOMIC, whose only conditional yield() in
> netlink_broadcast_filtered() is gated on blocking being allowed,
> which GFP_ATOMIC never permits.
> 
> The redundant rcu_read_lock()/rcu_read_unlock() pair in
> xfrm_notify_userpolicy(), the one caller that already took the
> lock, is removed accordingly.
> 
> Reported-by: syzbot+d3bc2f2eb498a0175940@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=d3bc2f2eb498a0175940
> Signed-off-by: Ömer Mete Kaya <omermetekaya0@gmail.com>

Can you please add a 'Fixes:' tag to the commit message?

Thanks!
