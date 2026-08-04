Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89372F8EAC
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 10:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785839276; cv=none; b=PkPpOLWFSYFEs9hpKT2fQAEuEM2uuNQ7VRp7AfZaYFTscr9nq9COdKEXpSSDN4KQA5PAtEa3m1kT9zSxUSFEpHSjOMIJlAT4dMFTVREx36CVEEOStL3dDWWIHPyg7HFB1zLNhE522GZqL0CcsLp0z57ic9H4jvM60OIb+sSKClo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785839276; c=relaxed/simple;
	bh=j7J/rvhqgXIfgJqQL25T8APMyJ2n/uxA+IEDP5irzIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sbr2r1D9KZbpWlzeOJ0FXbNjjZAdCCdEgxo6XkC9JIhjf73sJ2Z9W8/VSNi7wcuxSTL9t3vQdGMdQoSXgffEjRX5/4Bjw9ibpokGaebMumvAhnhfRyCwweAUUlr5t7qE5Vtvov8I8VXG8afmeHYFS6aY8Y67h3f6IFTLgZI9a/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YgHayKY0; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YgHayKY0"
Message-ID: <95d9b473-71ea-4324-b673-db68140782fa@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785839272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j7J/rvhqgXIfgJqQL25T8APMyJ2n/uxA+IEDP5irzIE=;
	b=YgHayKY0059ev8CZtuXIB9jrkfPrQF35OvCEdqS2ioBoA7F2P+9LS8Abw67IkRb0B7GZdj
	OQqxsj7rS57i6n5h5nTnwsNcOIKJBmWHkcr116lzmnN5nBb2z34CBuKabY4TvGTt/liPak
	XMIgwqnEog0k9xFZpv69mN8RUewAMLY=
Date: Tue, 4 Aug 2026 11:27:43 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] ionic: Add .get_fec_stats ethtool handler
To: Eric Joyner <eric.joyner@amd.com>, netdev@vger.kernel.org
Cc: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "Nikhil P . Rao" <nikhil.rao@amd.com>
References: <20260731214021.15279-1-eric.joyner@amd.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260731214021.15279-1-eric.joyner@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 31/07/2026 22:40, Eric Joyner wrote:
> Reports FEC statistics totals and an 802.3ck FEC histogram. Per-lane counts
> currently aren't supported, and the only expected histogram format from
> firmware is the one with 16 bins from RS(544,514) FEC.

does it mean the FW will return IONIC_STAT_INVALID for 100G CWDM4 mode
on newest devices?


