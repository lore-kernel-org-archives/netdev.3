Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC134A261D;
	Wed, 16 Sep 2026 09:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789550235; cv=pass; b=REk79QLwME3+JivYf0KxqCvqQA2ZxKpo4sa9AhCCMIsXxygvTz8YgUMxZYeWCHENitOcmojEheDpA/VMxvVL0yl9rWUCPaZtoZhlHtR1dI5iX7knokXEU3T79qIJJZQuqjBZ45si7K2/cLQBbcq10e4101iqbPMFFQyVhJ46SLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789550235; c=relaxed/simple;
	bh=9apGcAGF+qN+WdJNOYa47ONmDgzcaDL77nJ6s3G6f94=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Cvs5kedTUs6rULUkrtRkt3UqF3IFA9l9+9GpG8DNCZQq0kCygNTlcj3Si8V7vKSNISdCWm+i5vzsNpJlr8Z9NiJY0QVnsstGq4M6KjbUC1SbWmQA3IhmUyJNj7ePfs65fAroC1IAKRW2A04C3IaPAYU+OHJXdioohniBZlsARRI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=mhYIpLkX; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="mhYIpLkX"
Received: from fauth-c2-smtp.messagingengine.com (fauth-c2-smtp.messagingengine.com [204.75.18.201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jmtilli)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hlCvL6VJnzyc9;
	Wed, 16 Sep 2026 12:17:02 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1789550224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9ZXpwDz6DoWWBmQ6vDNVRxdpcZSSALaEWv74i0upVdU=;
	b=mhYIpLkXxu0kwdpsCyg2ptsZ2zZmoKRTRe2nyzAjgJKINlpeMy/1QVvKiVordwsgA06nRw
	WWwbwPc1mUFBBvlIjGr3S4+DCMYzBMPt3h7mJxYJvQ69SrFrSsj6NevJHmcAWOSJnqNtty
	+GWRWvZbZiFoX/EOOehbP2rO5z7uZik=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1789550224;
	b=c3hdnopAbUhZtfMwnqrW20N6KERXTE8cTeGgfkOcWFggZpG009s2rf5y0k7F9mZ5UZ+iRC
	CcEo/8xHsBN1VKvYwb95jsx/ih6TEPwPQF6On/BFGIurtqqqzJwUv5EoUJ4NflC2LeZG8J
	sYX3kxZpSkRwAM4BMH8fooNpmKjCSSQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1789550224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9ZXpwDz6DoWWBmQ6vDNVRxdpcZSSALaEWv74i0upVdU=;
	b=yCPVrohdICQmaggcHXB7UmJuA7G6Jq+PRk0WZ46pqYvIRSd9C6W+yrkVTuDmc9jKABfzF6
	qkguW28IY2MUlnpqy2WsCpB8SWIdTlm9WCu17qKtiN1vHsFT0boF1XTC/GRVr6H+C93uFH
	dE59THSTrlY0/wlrjn0HadMW4rhXPdg=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=jmtilli smtp.mailfrom=juha-matti.tilli@iki.fi
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfauth.ams.internal (Postfix) with ESMTP id 8E28B198003A;
	Wed, 16 Sep 2026 05:17:01 -0400 (EDT)
Received: from ams-imap-13 ([10.64.2.33])
  by ams-compute-02.internal (MEProxy); Wed, 16 Sep 2026 05:17:01 -0400
X-ME-Sender: <xms:iV6qag3fwJZVElS11KOnACeO3JGDmX_uwUJvl8TgfoB81E3A3vBJTg>
    <xme:iV6qal56Dzqp_NRsS9Es8Vuey_S8mDBuDqKiHnugv7udTKHByS_h2x7KhaWC9KEU3
    ZFj6u_mUwXrGGZgRvLUvPqFAckzru_7RfuhLscUhqlA1JtFSH91NSE>
X-ME-Proxy-Cause: dmFkZTGNFtvyF6MZNYMeLjLWJ41+we1JJ2Ix4Ro8hXfbflboz9ZBw6ovM/eey9Gijq0/Iq
    aPwhDw8Qs0gEeTKSlITUHQSLt0dbFE5HrptM2obUWfKKcjNRHWOJjELo9P5f3QEsYpsE6d
    hrW5Y+e/1UX012oUQk2r8ajWj1yE2k4hnhEzGiUXQ2NZpcbroifSXrsO8hYkY4GZvOPXW5
    babRbJSvfgsF0DJ+bk/amnon7PS+3s261lu//dm2pq9kX+yE0j/XwQTCgkJ5QWBcdzXRyp
    IvmjBKmjAjCc36wGn77wxm/mB3uS0XnN641PdGPuNW6NRJnwXoV5AaGiTKSGXWUb2sv2kW
    srTKTE258K+d/Dwk2y/m0SKBTkVT7iUPkU1kdUtkFDK9au+RML61NpjAQSvMuS2QklOCAT
    UAE0Hclbs+lQFAMq3R/mv2I+geAjMoF/L4gApGDO6Ok4deMGQcUNbcrZ2rTidFmHrHZzx/
    gQMgSOeBNDvD9iy9e0dl1J5ZBX04VAXhXHLTuesqaH0VHp1GqpyU+6RzZ9I6Vnu/y6GVaA
    BUHGfOrmUhAdNu0TKM/MpcKO7bndP+Kp/1Gmkn31I3yzIkbIc5y04Ohkm3zMV2cLZp4SOD
    mE6ShLsWg4EeG8xoB2+/E/2wMsc/KbkcfJAiIpiyOo86TfLmsaLXCTMeEgZg
X-ME-Proxy: <xmx:jV6qag_xAfBF4b7JfLUzVt_CTM_U8mWr7A_Fmw2jJJINzbR-C7OltQ>
    <xmx:jV6qakIvhColpei7gd9PzH58eLkXDhYxtHsZOf4mSPorf1AdaldRnA>
    <xmx:jV6qakuRhvl58_-z8GXRpFgARl3MkEUjJMCJkpvj-5fzdjVRb-5nDw>
    <xmx:jV6qatltm3i7OvXc1xh20Y-yn0KjYy3bt86NYaMQOUa0ni1awM2SLg>
    <xmx:jV6qarkHNZlZSzvbVHQJBCQkSeFEKTwE3m9W_toSFDjvBi2RYo-4MH1r>
Feedback-ID: i02414972:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id C76DFF80089; Wed, 16 Sep 2026 05:16:57 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AaJBIn-uFwMB
Date: Wed, 16 Sep 2026 12:16:37 +0300
From: "Juha-Matti Tilli" <juha-matti.tilli@iki.fi>
To: "Manivannan Sadhasivam" <mani@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, "Jeff Hugo" <jeff.hugo@oss.qualcomm.com>,
 "Jeff Johnson" <jjohnson@kernel.org>,
 "Bjorn Andersson" <andersson@kernel.org>,
 "Konrad Dybcio" <konradybcio@kernel.org>,
 "Eric Dumazet" <edumazet@google.com>,
 "Kuniyuki Iwashima" <kuniyu@google.com>, "Paolo Abeni" <pabeni@redhat.com>,
 "Willem de Bruijn" <willemb@google.com>,
 "David S . Miller" <davem@davemloft.net>, "Jakub Kicinski" <kuba@kernel.org>,
 "Simon Horman" <horms@kernel.org>, "Mihai Moldovan" <ionic@ionic.de>,
 "Denis Kenzior" <denkenz@gmail.com>, "Marcel Holtmann" <marcel@holtmann.org>,
 "Andy Gross" <agross@kernel.org>, linux-kernel@vger.kernel.org,
 mhi@lists.linux.dev, linux-wireless@vger.kernel.org,
 ath11k@lists.infradead.org, ath12k@lists.infradead.org,
 netdev@vger.kernel.org
Message-Id: <9ffaeae1-3768-408b-8434-9f1704412fbe@app.fastmail.com>
In-Reply-To: 
 <bjfwy4usrfbrabmcp4xsr65nqwdpuryvmrb6tzp6k2ckmdx27h@kvf7idvsugsm>
References: <20260915054207.2513877-1-juha-matti.tilli@iki.fi>
 <20260915054207.2513877-4-juha-matti.tilli@iki.fi>
 <bjfwy4usrfbrabmcp4xsr65nqwdpuryvmrb6tzp6k2ckmdx27h@kvf7idvsugsm>
Subject: Re: [PATCH v7 03/15] net: qrtr: fit node ID + port number combination into
 unsigned long
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Sep 16, 2026, at 10:01, Manivannan Sadhasivam wrote:
> On Tue, Sep 15, 2026 at 08:41:55AM +0300, Juha-Matti Tilli wrote:
> > From: Mihai Moldovan <ionic@ionic.de>
> > 
> > The flow control implementation uses a radix tree to store node ID and
> > port number combinations and the key length is hardcoded to unsigned
> > long.
> > 
> > The original implementation shifted the node ID up by 32 bits and added
> > the port number to the lower 32 bits of the unsigned long value to
> > create a key.
> > 
> > Unfortunately, since both node IDs and port numbers are defined as u32,
> > this will overflow on platforms where sizeof(unsigned long) < 8 (which
> > are most 32 bit platforms) and essentially just drop the node ID part.
> > 
> > To fix this, build the key in a generic way, using half of the unsigned
> > long space for the node ID and the other half for the port number.
> > 
> > This will be transparent to platforms where sizeof(unsigned long) >= 8
> > and fix overflow issues otherwise.
> > 
> > The caveat, of course, is that, for platforms where
> > sizeof(unsigned long) < 8, the supported amount of node IDs and port
> > numbers will be severely limited - to half of sizeof(unsigned long),
> > which typically will be 16 bits. Needless to say, we have to check if
> > both values fit into this limit.
> > 
> > This limitation is probably not going to be an issue in real-world
> > scenarios, but if it turns out to be one after all, we could switch from
> > a radix tree implementation to an XArray implementation.
> > 
> 
> Documentation/core-api/xarray.rst says:
> 
> "If your index can be larger than ``ULONG_MAX`` then the XArray is not the data
> type for you."
> 
> So the fix is to not make XArray work, but switch over to some other storage
> mechanism instead of XArray, like hashtable.

I think I will drop this along with patch 04/15 from the next series,
as it fixes one bug but introduces another, and those bugs should
probably be irrelevant for this patch series.

Indeed, that commit message by Mihai wasn't entirely correct: XArray
will not work here.

BR, Juha-Matti
