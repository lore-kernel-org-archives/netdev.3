Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=50.112.246.219
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794605705;
	b=OZbnDXiBv7hz3KONmKs2ODwAZtgHJGvOIc1A1GL2lT3ZGTYCGfWU8qxEd62Kt/+CsqYK
	 oqGNeQP/1grGzTC597Hr4peJops79hbmUdfp1BrZeo8A6rYAqkbwxqnV4mVAzw5frJAJ3
	 b0Atl7OzAZEUB06+6IfiRwdJ1V7zt1fImemWFX+R105l2mIoUQODSshAxEM5QIX83czHR
	 IX7pyfyeaNBHJnIyCRiwBeguGE29nvq7+yMRFmYKHW8tEQeFgYUVT17ZPiz1AIE2e61vK
	 modlKhgGfOGLbiiygAMOfzbi8DKRceFmfAxddWiWOUwk2E5fkQq9HGiODfpgAy0yZNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794605705;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 CC:In-Reply-To:References:Date:Message-ID:X-Mailer:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=vUUHf+0GtGXfhxGVNNe2uvulZqXDlClhUKfS9oBPKsY=;
	b=hTXib14XC/GFRjeH90aqz4a1xi609DaCWU9wKJYc8Kejl24ctUh+uXLAw98GgWFIyE25
	 4YwZL9VlXtMn6zhfGBP3W7mmozbeOqvEw5rtu4fa0t3Lo5fDdG7xZ+XgeUjTKYjgwqd1s
	 56XH4140hYSPyqDKhr96qBVF4ijEwTpatTVczgP8UzIzunqFlLyaBRUHKwiOoaMdB9m4+
	 ozoBXf6jMKkyp2/iNtD1ZIDojViHdLigiJibtWZkWKSPy2GxeEeo5WYVkqhrjcXWq1oRj
	 SGembgi7P9d7n0skY780roUR3UpI2LiC/G0jJriPt0NaOrx/ugQpjFtvoqCuofnPJ6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=MSxy1DAZ;
	arc=none smtp.remote-ip=50.112.246.219
Received: from pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com [50.112.246.219])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171A3606A32E;
	Fri, 13 Nov 2026 21:35:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 171A3606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=MSxy1DAZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1794605705; x=1826141705;
  h=mime-version:content-transfer-encoding:subject:from:to:
   cc:in-reply-to:references:date:message-id;
  bh=vUUHf+0GtGXfhxGVNNe2uvulZqXDlClhUKfS9oBPKsY=;
  b=MSxy1DAZjovRUyE67HpDZaT6dn/u2plprPzLLLTWYYisd+kcA0wSLqik
   1b8o9cxMOgLdDmjUSEb8YIazIh5h3ZnvuUye0kXMECPMIucvbjL2CO/Pe
   pjXbzEtN0yDffZo5xza2pR7S3eYFRsqQ9hRboN/zYHxq5UE6TAimtI4rY
   gkwe9Ze7hbYCf1bameXAwnl/DJphmHN8H8i7KXqI0OawWgBXkT3TBH7Gt
   C21zEyZaChLrG4VJG6jxukOpDS0DKrd517os+dXCuqGEhG/KdBO1BM9jB
   hYL4AOWWsOXtGX/vMbUyhrGgOTPw8+h9dvkTOEjAg6vdpRtubH8JzoNnm
   A==;
X-CSE-ConnectionGUID: 5f/UAGLvRIiMJrsrctevTA==
X-CSE-MsgGUID: amrnvTLJRhyicXNpPJQREg==
X-IronPort-AV: E=Sophos;i="6.27,212,1787011200"; 
   d="scan'208";a="33734704"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 21:35:02 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:22766]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.46.128:2525] with esmtp (Farcaster)
 id 3dc962cb-f3af-4bc3-878d-33e7a3ebc71a; Fri, 13 Nov 2026 21:35:02 +0000 (UTC)
X-Farcaster-Flow-ID: 3dc962cb-f3af-4bc3-878d-33e7a3ebc71a
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Fri, 13 Nov 2026 21:03:03 +0000
Received: from dev-dsk-akiyano-1c-2138b29d.eu-west-1.amazon.com (172.19.83.6)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Fri, 13 Nov 2026 21:03:01 +0000
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: ena: reuse the whole RX page on 64kB
 page kernels
From: Arthur Kiyanovski <akiyano@amazon.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "Harry Yoo (Meta)" <harry@kernel.org>, Arthur Kiyanovski
	<akiyano@amazon.com>, David Arinzon <darinzon@amazon.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Breno Leitao
	<leitao@debian.org>, <kernel-team@meta.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
In-Reply-To: <20261111164751.5ac643fa@kernel.org>
References: <20261106-ena-rx-reuse-64k-page-v1-1-ac75b20c5de8@kernel.org>
 <20261111164751.5ac643fa@kernel.org>
Date: Fri, 13 Nov 2026 21:02:56 +0000
Message-ID: <179460377625.24249.14913382632287673336.b4-reply@b4>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: EX19D031UWC001.ant.amazon.com (10.13.139.241) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On 2026-11-11 16:47:51-08:00, Jakub Kicinski wrote:
> On Fri, 06 Nov 2026 03:17:11 +0000 Harry Yoo (Meta) wrote:
> 
> > This shows up when RX data stays in socket receive queues, as each
> > queued skb keeps the whole 64kB page alive while at most 16kB of it
> > holds data. On an EC2 t4g.large instance (64kB pages, 8GB memory) with
> > 519MB left unread across 64 TCP sockets, RX pages pinned 2869MB of
> > memory while the socket layer accounted only 687MB.
> 
> I'm not sure you're actually fixing the problem you're describing?
> You optimize the memory use but the (unused) tail of the buffer is
> still not charged to any skb, is it? Or does it now fit perfectly?
> 
> Normally when the page can no longer be chunked up we should charge
> the tail to whoever happened to use it last (see the page pool code
> which does that).
> 
> Either way, you have to respin this on top of Breno's fix which
> was applied earlier today.

Jakub,

If I understand correctly what you are saying, you are correct.
skb->truesize is still not reported correctly.

The focus in this patch is different. It is about using the whole
64KB page instead of only the first 16KB.

Harry's own figures show most of it is recovered — 497MB pinned for
519MB unread, against 2869MB before — so the remaining gap is the
final tail of each page, not the 48kB.

So I agree the commit message needs to be more precise.

The skb->truesize fix can come as a separate fix after this one.

Thanks,
Arthur

