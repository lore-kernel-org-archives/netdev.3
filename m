Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.96.220.36
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793704515;
	b=PYv+aEMwYoAT1Xh7wZUAPX4I0uulhmifv+bkSKM+F794/EK1peZ2X8Nf4cRzYZXhvWhx
	 7ZeVtlQW6gx0tYkC5S3QJj1ofPYX8ff6NpY86GJ0rY0KAHhCcsMLFZlOZNQq9guBNr4od
	 eaE0jnC/YM57oI0+FcZ4JABcLmx4jPM9OTO+6cZR9lWfwfdvcUKWT/Yw2RYCTHKWT0RjC
	 JJXoKQO+insymb1OxEdsdHExa+hoNdGbnZ+RDsgE8AbRpcPdARPfyN6H4PFa41bgnOXfO
	 ovM7Lz2pUyWaK8CFImyNrPBlXq4JOtK1MC7+v/dg5vnpdtAxon4QBBtyxHP7bdofWTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793704515;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:Received:DKIM-Filter:
	 DKIM-Signature:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy;
	bh=P9cSdm4KiqrHWovAtRq/ysC8FRxxwyP/Uy0EhN3ua/I=;
	b=C3RiSMKn1qQhOjFcSdf1ScV31l6jDtRyDmuwZWs6WfSMmKJWGMcYMc65FBy5/xf1I7Me
	 V8TwQHV//taidoPBHQnx9R5af8pnbgdhjJ4aFJUuPYfwVvKwG8xpSyadoTxjPru7opwFH
	 lqYV86doodlL5WwHjByNqSPNFwcj2NSOKm/Bk4Jllz+A6tLUlJi5ud5aP4fbv+sXTSkZ+
	 V/Lhww4Qoj6Lf1HdtYkkgWy7vYrOK1FF0/0zIVaVJwqRNU2/YZsb6pdY6d3uZx6wKTPBd
	 GU/ZOxJc2uTWa7BuCpTelryO40mFAu+kT822SIR0wOzuU6HdB7szGtFFP5XC9oUSZog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=secunet.com;
	spf=pass smtp.mailfrom=secunet.com;
	dkim=pass header.d=secunet.com header.i=@secunet.com header.a=rsa-sha256 header.s=202301 header.b=htcVmKyV;
	arc=none smtp.remote-ip=62.96.220.36
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E8C606B102
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 11:15:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27E8C606B102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=secunet.com header.i=@secunet.com header.a=rsa-sha256 header.s=202301 header.b=htcVmKyV
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 352A42050A;
	Tue,  3 Nov 2026 12:15:12 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id n-TVspRdz30V; Tue,  3 Nov 2026 12:15:11 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id AEC5E201AA;
	Tue,  3 Nov 2026 12:15:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com AEC5E201AA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1793704511;
	bh=P9cSdm4KiqrHWovAtRq/ysC8FRxxwyP/Uy0EhN3ua/I=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=htcVmKyV1gPsdenlUcZ4mSb9J7qbf8GpaiM11ZjTQNn8TEzF6vA4A/SBQyQUoCWjQ
	 j69I8jAsBntI0OQ4MhLON+SDxQnNJY6UtZY/u5rap3sw7pT+t656UXzsi5F4GaqZOL
	 PbtnjvHb0oC4KT0Y38LHF+7awdYMQMsp+0KC3dI+fgDzorGKJYLiREVmldiKZRh5mj
	 zLf0zvVX1b6bZzCJU91LGb+s4ghAET9ZjQW2RKwaHpByv53wvJ88D1ZAFG1kRBeJRd
	 PEr4La70+1JJyqLEYOmBwgkp70mRXSvhbh5n6gPIrEnW8rU6DVt1794hgO3Fti98Ao
	 jtKdsev/jf3BQ==
Received: from gauss4 (10.182.7.102) by EXCH-01.secunet.de (10.32.0.171) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 3 Nov
 2026 12:15:10 +0100
Received: (nullmailer pid 3815029 invoked by uid 1000);
	Tue, 03 Nov 2026 11:15:09 -0000
Date: Tue, 3 Nov 2026 12:15:09 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Paolo Abeni <pabeni@redhat.com>
CC: Eric Dumazet <edumazet@kernel.org>, Herbert Xu
	<herbert@gondor.apana.org.au>, Simon Horman <horms@kernel.org>,
	<netdev@vger.kernel.org>,
	<syzbot+a3f21220cbbb6e14ee2e@syzkaller.appspotmail.com>, "David S . Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net] xfrm: iptfs: fix skb leak on error in
 __input_process_payload()
Message-ID: <aunCPZ7zU4gPBVvo@gauss4>
References: <20261030083358.2653599-1-edumazet@kernel.org>
 <a555f856-0e74-4579-b35f-9e9c3ed5e8eb@redhat.com>
 <aum8sFQdO_kGUWxX@gauss4>
 <585c717f-01fc-445e-802c-15b44b150ffc@redhat.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <585c717f-01fc-445e-802c-15b44b150ffc@redhat.com>
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-01.secunet.de
 (10.32.0.171)

On Tue, Nov 03, 2026 at 10:59:12AM +0100, Paolo Abeni wrote:
> re-sending to the ML, I unintentionally stripped all the CC with my previous reply
> @Steffen, I'm sorry for the duplicate.
> 
> On 11/3/26 11:51, Steffen Klassert wrote:
> > On Tue, Nov 03, 2026 at 09:45:28AM +0100, Paolo Abeni wrote:
> > > @Steffen, do you prefer to take this one via your tree? Otherwise, would you mind
> > > acking it?
> > 
> > I have a pending pull request for the ipsec tree, my plan
> > was to apply it once the PR is merged. But since the
> > ipsec tree is empty after the PR is merge, I could
> > also ack it if you prefer that.
> The latter option is more straight-forward, I think, thanks!

Ok, in that case:

Acked-by: Steffen Klassert <steffen.klassert@secunet.com>
