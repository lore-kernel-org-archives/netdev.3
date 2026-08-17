Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EC23BD241
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 08:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786954849; cv=none; b=n6KI6vbhlJQvRmsiELATpTVVJVYzB70KGmTMgcUYJ2OLCLywJHRydSqpMXzaYbfuWRgdyMAyl5GOCna8UhgmbczNfHzvqIsUvwpRIQuEqeJn29d70Di+k01qIPRYvgRImUlJ/DkLG8jufqMSBbCRcKWu5w6UfP5JCJHFkZ33aVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786954849; c=relaxed/simple;
	bh=zh5vKJ2IQLohBIoyZNpW1zKgu3wed/wXZRxctuZthaw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GDuPuhs9HimSr7hm/2xdQrVY+UiSETiNRQo1gDmRkCBi/jFFW/hMj9bSkfTqfwrLhbZFiPqa+D7oaH8d4FnaauItF43D9UYjK/FDm1+JEUIMNOdFeeMSRV1R8o9KVyysYQmVLqta+fIiATVGmagSgB6RU6jWTQNds9j5Nk6Di7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=R45KSoHe; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="R45KSoHe"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 02142207B0;
	Mon, 17 Aug 2026 10:20:45 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WD9FLh2wR1n2; Mon, 17 Aug 2026 10:20:44 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 86D5F207AC;
	Mon, 17 Aug 2026 10:20:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 86D5F207AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1786954844;
	bh=7C2rmE37SU8Jh8iAgqS+zy1qECGAHlEkVVs1st2Wx6k=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=R45KSoHeJD7E9NkWVZHbYPS1n7zFWPZ+O/wLV8knSDP9He/YyzjDnUT4mum1uwsuT
	 ij1UpvNUMPYHQjez53e7xpxtc3MEMrT9R8mN5eIAC56cIb6phR6mDS1/M8vH770Zd2
	 BoSFYM6ujYtfTboduyw0bbtbJkMF9RHNLGqKRhqC0LtILOR/fFyWtkyO5kx1Nd6b4G
	 rimuj8n8cFxo/ZnM7rJxEON+kM0KIggUbhrdywoRbMJrRo9in65hxfz4N3LQpAPCCV
	 fPFfSX8D6dw3PSOAcOiuA6+v198oQlTHdNYCd+Z5S7rM7UD21cMShwDT3VfSd3u4JM
	 NAXBrP9ZE+JSw==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 17 Aug
 2026 10:20:44 +0200
Received: (nullmailer pid 2438662 invoked by uid 1000);
	Mon, 17 Aug 2026 08:20:43 -0000
Date: Mon, 17 Aug 2026 10:20:43 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Eric Dumazet <edumazet@google.com>
CC: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, <netdev@vger.kernel.org>, <eric.dumazet@gmail.com>,
	syzbot <syzkaller@googlegroups.com>, Liu Jian <liujian56@huawei.com>
Subject: Re: [PATCH net] xfrm: add missing rcu_read_lock(), skb_dst_force()
 and dev_hold() for xfrm_trans_reinject()
Message-ID: <aoLEWzfSZLHHMSgH@secunet.com>
References: <20260807171533.1904697-1-edumazet@google.com>
 <CANn89iJDW7P5cagO3EZk7xKZ-yn=BBsyOszvbi48O5OkD3tLXA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iJDW7P5cagO3EZk7xKZ-yn=BBsyOszvbi48O5OkD3tLXA@mail.gmail.com>
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-01.secunet.de
 (10.32.0.171)

On Mon, Aug 17, 2026 at 10:16:35AM +0200, Eric Dumazet wrote:
> On Fri, Aug 7, 2026 at 7:15 PM Eric Dumazet <edumazet@google.com> wrote:
> 
> Gentle ping, thanks !

Will look at it today, thanks!
