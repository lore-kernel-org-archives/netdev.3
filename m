Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.246.68.102
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794605727;
	b=VfEhSxxmAW19ZT7kaj+POmw7GvhISWQnFmU3eVGXwHDjDWGbkX2NC6QeTuhTQZIjR4xm
	 Cxi+GPrz/jS1svgTRXgs6dtv28ABnPRGoxo2Q9wmQq3Q/HxohJ10JXGL0Co6CElzHli7+
	 H/tJl8UHEWQA4YAm+quEZezNua4Is3G+nZyM6OGQGnMPCmMcI/41ahZmEEIokasKrNBhy
	 MWeowtjiIb5bDKx9/OlYgxYdFKYLCttJQTo/b7oZUrFk6VDvy400ZdyrJBZ+jmlM23Rjn
	 AXTeexeVn59DPOL8sA7V1rxnDEAYImFkB84AD+4gSZE2jDBl/pxHEMQ2o9pz+v+zc9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794605727;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 CC:In-Reply-To:References:Date:Message-ID:X-Mailer:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=iRIJ9O1v6GQmi9gOAFJukz4g/NK/Vku3u3+nsxtB+GA=;
	b=f60dVBXchYkusB5qwjiR79cVZZxcDkWWWrSFJ+Xe6TYrkYjsKW1Xjc99MVKqctjRr/8c
	 HEu/xrnJf58iBwmScUl1nGOcYbSxm+n/BVCx2U+F+pbWfg8lw4i4c2xT49Dc+np/pBgRm
	 HnQpkwLS+0MA2mOiv40PAsVBbYW+K+RSD5iD0xCBIwEn1YxzB0VJ6YUW3cRx7C0J2GXZ0
	 AmDy+f23RRfTcZGn3hpuRnOtcmORgwq+zh+p5T5pUPKPiSBK2ndCG3QLQBs5fnMg8um1t
	 ikxAAYeFc+P2Od+M0LwO/g0yfoYXSrtjteMRHEtZoWAQjX6z+vTV+myTbWB6biAPWjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=Dnf9D5rQ;
	arc=none smtp.remote-ip=44.246.68.102
Received: from pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.68.102])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9F8606A32E;
	Fri, 13 Nov 2026 21:35:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B9F8606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=Dnf9D5rQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1794605727; x=1826141727;
  h=mime-version:content-transfer-encoding:subject:from:to:
   cc:in-reply-to:references:date:message-id;
  bh=iRIJ9O1v6GQmi9gOAFJukz4g/NK/Vku3u3+nsxtB+GA=;
  b=Dnf9D5rQ+LGtlAda4ir9eO5wTRomXOsR7V3CRF5AuNeREP5ICKqocwM0
   jLypmiqzJdT2McXxxExECevLGOMa8TGqKPFHcJFFI+1v+COPokQLc0q2j
   aygs402TZ2ARepVSztqv159xQXmnKbsbs5Vm5gqxnzqmHd+lY6rT7Jglk
   mqns2lOKXlihFjyNIAOy5mN8VyYU6ZkFDgVQbv4TfX5mNjOkbdWUpbceW
   I57wFKV+Ze6owc/l1agWop7PovsHPMnrJyvrcXDheokhvfVr55nEh5mUq
   Dp9D9+tatCaP4Cfd0708Jvxy9S2HTjqXRUGxsEiM/taneO7QpAty46APv
   Q==;
X-CSE-ConnectionGUID: EiwHto+kRTGEqr/CyKlnzw==
X-CSE-MsgGUID: K8XQ4+3aTquqSBd3Z1YtSw==
X-IronPort-AV: E=Sophos;i="6.27,212,1787011200"; 
   d="scan'208";a="33873866"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 21:35:25 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:24242]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.55.227:2525] with esmtp (Farcaster)
 id 7d61ec3c-5559-4466-90a8-c6e606d7eb7b; Fri, 13 Nov 2026 21:35:24 +0000 (UTC)
X-Farcaster-Flow-ID: 7d61ec3c-5559-4466-90a8-c6e606d7eb7b
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Fri, 13 Nov 2026 21:35:20 +0000
Received: from dev-dsk-akiyano-1c-2138b29d.eu-west-1.amazon.com (172.19.83.6)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Fri, 13 Nov 2026 21:35:19 +0000
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
Date: Fri, 13 Nov 2026 21:35:17 +0000
Message-ID: <179460571746.22458.2892088316099736810.b4-reply@b4>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: EX19D031UWA001.ant.amazon.com (10.13.139.88) To
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

