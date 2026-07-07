Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5080425CC6
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 14:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783434769; cv=none; b=tuY71WW8iJzNEBGEg+tFD8oE6G1RbEbZeB6N8BsxVtNWYX9js4Fq7MnUOkvwFPetxdhHGe8wzcHglHNDZ3rDWtDYVxVNbBl5qbwWm3GbxWik315QvbS7Ipy6R4AxNnBaSYn1QODU6/hANfS2F2fgEdVVqOKXQrlD2hyViA+N7WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783434769; c=relaxed/simple;
	bh=R+h+d1pBH7j+suspTHLN7nSmJ1rrO7a8PG4g0rBbZN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C8ajO45/sSLfnQRoxz4KfqQs9KFnnfQrnksONah2C2m90uV3BIMVHEM1+YaNhWmnwtYFF3Br6mT4WRzxkYEq+LYM/lVOHYZvD7qP14nMVeIHoj2ORSFbw+LPBu5jG3Z7DFcjum46NbyaQUvInMChd+vZlN7XJv/TRS8cJ2p8p0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=f1yfOviH; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="f1yfOviH"
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id 399A760194;
	Tue,  7 Jul 2026 16:32:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1783434765;
	bh=1jdaldTNEf92jtFvTk6vxq/9JGpSlITwrFemYyFuldE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f1yfOviHmXbFuKPOQPXZaIzLWnHoZMDD9HJm0fDUSyvyZE4F9UxSgaPhD47dKXhah
	 ws7auEx2rQau+ZJHDMYqdTyDnaG3X8KwvpJzmL23VLcmq5O2UAxlwV6tEcKGcPUdPJ
	 3SdC+B4ZlHxmE4RUxTrwvzfJ1LwsjcErOQAS0bQ5T9R0dUCocvnuaRtLoHmuykMa1A
	 KPBSmtfVWKFsKroPXUZsfuOmjB59S3zH1LM4CGZzA00/S2lrk2op0+7/2yczcXaDrK
	 gfYw7M5JrZo+jHSVjjyGsWdutfXEeaVfpTAtoHlsRPafj1q+6KoMto6Jb+Hhjdl/g4
	 H7WIOvXptrOHA==
Date: Tue, 7 Jul 2026 16:32:42 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Zhixing Chen <running910@gmail.com>
Cc: Harald Welte <laforge@gnumonks.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	osmocom-net-gprs@lists.osmocom.org, netdev@vger.kernel.org
Subject: Re: [PATCH net v2] gtp: parse extension headers before reading inner
 protocol
Message-ID: <ak0OCusCIcf0DH7y@chamomile>
References: <20260703093708.18141-1-running910@gmail.com>
 <akefPJ5cCrsZcpRw@chamomile>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <akefPJ5cCrsZcpRw@chamomile>

On Fri, Jul 03, 2026 at 01:38:39PM +0200, Pablo Neira Ayuso wrote:
> On Fri, Jul 03, 2026 at 05:37:08PM +0800, Zhixing Chen wrote:
> > GTPv1-U packets may carry a chain of extension headers before the inner
> > IP packet. The receive path already parses and skips these extension
> > headers, but it currently reads the inner protocol before doing so.
> > 
> > As a result, the first extension header byte is interpreted as the inner
> > IP version. Packets with extension headers are then dropped before PDP
> > lookup.
> > 
> > Parse the extension header chain before calling gtp_inner_proto(), so the
> > inner protocol is read from the actual inner IP header.
> > 
> > Fixes: c75fc0b9e5be ("gtp: identify tunnel via GTP device + GTP version + TEID + family")
> > Signed-off-by: Zhixing Chen <running910@gmail.com>
> 
> Reviewed-by: Pablo Neira Ayuso <pablo@netfilter.org>

Patch is not good, it needs to refetch gtp header after
pskb_may_pull().
