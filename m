Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250AD37FF7F;
	Wed, 30 Sep 2026 09:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790761672; cv=none; b=ivfWhPQ8Op5MwpCIb5KUtRm9CR4rTx20XMkohi9uqFABADDKCB8QxQz6TYvaGhKK3F/JIAwuQilUhlwwfcAlg4qCkYqRDtS/nDGb7b/baKnLuYwm7+HEuZqyZFdSQKRfMtV4ktnPKujy8JB+ZvCeuTe5RSbYeHXgNEOKZGRDvfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790761672; c=relaxed/simple;
	bh=KHZo90IPU0FsiL8AARSQ0vX3VkeVlMDaXI/E06p+b7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DkDQxAM2/A4A9lRPga36upcPjbld1AXvSwO1g0OG/IA/VPJu7Z10e8K3qNx/7+qjn/vBfGnih2RJfKrqnbp+z9+MhysFLNH7jf+vj/gJA9LfVe6i6g+cKMTCOY/gm69DWMaEyCnL80gl1ciHXFm8Q7ROu5+dCYBqoGfz8ap0RV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=g6LzQakh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GYPxSAY0; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="g6LzQakh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GYPxSAY0"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id BD5D51D00722;
	Wed, 30 Sep 2026 05:47:48 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 30 Sep 2026 05:47:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1790761668; x=
	1790848068; bh=74HIZbLLKuHgdGt8I2guVI931y4BufE4gPjSle/vjtg=; b=g
	6LzQakhmZE9s5z1Cr3vmE4NjDEitFiVMrgcyqsnwmJgo2Bd/G37Wn9nrsXKkdns4
	YyaGyI/iZCQfQdrXencVFqaq0oAz2e0ls8B7sKghsaDKSnC++SsWjIxjc8/SctIO
	voNl9f7gLUWvvlPR5Pn9inALu8nWLwvsktQ8fhYWvAKCT1Q6lg2NUQQmRa4fokjU
	XAxJ8bcRnuf/g5tebptNSqJ8hS6Z4fm0gllhKVV5wESwFGI7IHFeBSu3VFif3hu3
	53Y42SMsj/TtEx+bLrPEwwKkitDfiKnaliEIyzfUHJRMxil7ty9R3y574Pt9K9bN
	lCNgUOJfBbR8DS7Uj1vig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790761668; x=1790848068; bh=74HIZbLLKuHgdGt8I2guVI931y4BufE4gPj
	Sle/vjtg=; b=GYPxSAY0sXtLitwgg/QvpYYhkPnzq0IrfZWVCX7If/FRombrthd
	rkSq7xfSqQCF4jbh9MWdWAYShQk4ah27TfAPXS8l+/kvUkcPvvn+lj6x4iCD/xkd
	z1XIx6o+5Igf3n6yXy4sx1Pr5qb6ApBh1LNDWAbaec+ftW4cRgoY91L+saBFz1b6
	Pwpil/EMSNmBDNFp8WzpFKP1qclDsMPxLo1XMHl2ttBmGG4YhJonrVQk5KvYA2G2
	omm1Ms0cEVFhfYhTtHXhi+WJTLp1QzJOnXGQWXDxtLlPqimyyLIXGnvKDCxpPWQ+
	/SN+/PajxumSkOAUfhhLdjrVkkqlDXF5zyA==
X-ME-Sender: <xms:xNq8alp2MJNNLQ9GCsFapMeoPru8txaw6xXlmJR2F0bTBs_706JTEg>
    <xme:xNq8al7GZ7_SkxUPJqZv1L9ZxTK3hjL7I4fnMzVsMzYwIt8Jki2MZfO7fv69ShK_N
    HS3bOigVoRCHZsNEs1fXeLpyR1Q4FmV4VNTmtV_egykhwCyNcIU6Qw>
X-ME-Received: <xmr:xNq8argtXhXNCypJuMA_OWf09B8itdiFsNc6TeWYbZVbhd3CwufQKBty4MDh>
X-ME-Proxy-Cause: dmFkZTEzhxKWkqlGTUncuCmm+isrwbVU97iQsL3Q/y3wJHglNS5ymIL55/xjy++3OP7jdI
    3lkOwJ5lWpFHzfvsXiysVzTZUDI4UAz+WADSxIy4Uu201vtKvTMeKGiw8nYnrh1gtrdQ9Y
    /0xLVVvrNE7hV3YYinx0o49P+nrNHOyd3vwTEedn3mxYwTOhmQI9Qi/HOImlS1AVeVso5Z
    f6X3XQ1qq1x1p6M2GOb0MuuU5XdBcACLDyPI5PYZwaJtAnichBMKuejFFAZr/oKbvPf24X
    NB8xh7bq7YDilu9YYxaz9BYDpaXYUUpmGZ1iWkRf/v6U6YMWL7L4z8PZqJR5qBhJXLTEiT
    pM2PvbbQCr6/7xuQKeDbuaAU0kWpPNz7wrJRaY6eKG1e+XQUbwJr2ASDSElJhZQ8Gz4Kyw
    DdepKS9ehbA4a+L8jdcLAW4TSBaAtGJGg1r2x2+8kWkymhT+ULrH7D82FccyIYJt2ZRR5C
    KklPbKtnmGtCOEUUcl1RR/nzDJnhlB+1ZVroD6HY5Z+a7rU9LvLHiD6KtRISDSZRWQskw+
    vTG8elofy1/j9qTvu/T4XaT3EeQG3QHe64nQbmgD1IUI0bCyglk5m8ArbdSOdiDYFJLTmw
    otW1IqzCr+i9oCn/PXtB+i5lKw5U+LoVnzRJvehPzJRS5GL6CqbNhp3D5Nzg
X-ME-Proxy: <xmx:xNq8aj6asWIFuR1aPqBpJYpPUTRZPOpVQP6RnG4KLgxvJ1sCgID1hQ>
    <xmx:xNq8aoF7JVvICKs7SRLz4q9DbgQiGOR-TV67lYAtcozzJe_4gJR4Ig>
    <xmx:xNq8atLmCPJanvjl8HBI1XlYGJnRqzfKHJc1_MCbFXrwP3GSXa-rUQ>
    <xmx:xNq8atgsFLv9JlnE9MQizQkCnXwETqvO0ApzZh6HcUz5Ja0SNRrd7Q>
    <xmx:xNq8aj5nbj51KmE-AJVRc7rx7bTa70x6MI68zYyorc9yXCU7jQousacv>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Sep 2026 05:47:47 -0400 (EDT)
Date: Wed, 30 Sep 2026 11:47:46 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Qingfang Deng <qingfang.deng@linux.dev>
Cc: Chuck Lever <cel@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Dave Watson <davejwatson@fb.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] tls: skip empty data records in tls_sw_splice_read()
Message-ID: <arzawlad0OQ9pnBQ@krikkit>
References: <20260930052636.166007-1-qingfang.deng@linux.dev>
 <arzStIrdizPp_vbI@krikkit>
 <465aa0d9-b1b2-4c85-9cbf-e6ed296b7b12@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <465aa0d9-b1b2-4c85-9cbf-e6ed296b7b12@linux.dev>

2026-09-30, 17:24:18 +0800, Qingfang Deng wrote:
> On 2026/9/30 17:13, Sabrina Dubroca wrote:
> > 2026-09-30, 13:26:36 +0800, Qingfang Deng wrote:
> > > tls_sw_splice_read() returns 0 after receiving an empty application
> > > record. This looks like EOF for splice(), even though the connection
> > > remains open and more data may be available.
> > > 
> > > Consume empty application records and retry the receive path instead,
> > > following the approach used in tls_sw_read_sock() since commit
> > > 3be28e2c9cd0 ("net/tls: Consume empty data records in tls_sw_read_sock()").
> > This is similar to what Chuck proposed in July:
> > https://lore.kernel.org/all/20260726-tls-follow-on-v1-2-99bf4cc1c729@kernel.org
> > 
> > but Chuck's patch had some extra bits (handling of the "released" flag
> > and of signal_pending).
> > 
> > His series also had a selftest which should be included too
> > https://lore.kernel.org/all/20260726-tls-follow-on-v1-6-99bf4cc1c729@kernel.org/
> 
> Thanks for the information. I prefer his series.

Let's see if he has the time/interest to continue work on this (since
he didn't send a v2, I'm guessing not).

Chuck, do you want to pick up that TLS fixes series again, or would
you rather let Qingfang finish off the "splice vs empty record"
patch+selftest based on what you had sent?

-- 
Sabrina
