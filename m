Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E532F60CC
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 07:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781767553; cv=none; b=OYHecD3pP8CHU1Qe2m3d9clDUAUKD5XnSbHoH1cdiwePUCoH36Pw07HIMurHFlRCIBFg1cfwB3V4qHuvbrzyPhqEdG96HOjgOLoF0s+hcsSmXo+blhTxwuq2J/fCSpfkM4MhXvl/2XDJ0i2TZgdOuSdBzGaBKsseyWJ+0Jqdf9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781767553; c=relaxed/simple;
	bh=6HqH1fc6zpY8hjY5Pb3t/7XQxyeoJiTv40MBhN4B+Mw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UoajCRE7zBkoCGvsbzJcqr7d1c87qu+sDY5jnitTj/IQhmDN7BoiKoLNC1hwhP1h67daKOjuD9WTKU4656J8SP2H2ewNCJQsRYZ0j3BerQAmdFdgl+dwVGPPcb9SrJQNfb7ffj7H7GoyPzeD2kj7+NLk0pZMFknsPqEmIuBfxeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=AfqL+CnV; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="AfqL+CnV"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id A0A4E207BE;
	Thu, 18 Jun 2026 09:25:50 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tj03Nkc_oNvJ; Thu, 18 Jun 2026 09:25:49 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id D089F206E9;
	Thu, 18 Jun 2026 09:25:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com D089F206E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1781767549;
	bh=5B8UWRf+QPypKOuQk+WL0ueRgNpNsDFKOhc/Cy80jkA=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=AfqL+CnVuYLcymo3bpEKSWs70kVPDZf8TEfLI65+J6a+Py7YWk7hU/4VZfl7LfAU3
	 heuce5K77IqixMT9Yq754cHgdGX7EdpeyZPQv+hcrJbRxa8g7p+L0UW4tZwbBip61C
	 1iK6Ajvh4AGrRMUWsmslJb4Ew1rr4eQzUogKbqPvA1F1ty65zauecXw6HxJlqDqgGT
	 WaNYYyvoKAj7F7T+UQRdcswuBh0v8TjGdSF6m7CsUsazIJivJsthz2UVmZQ9qnqKfs
	 maGoyOReWntaPNah+FisU0mBSRqxrVhYaLgCQQjKOrpAuwsJ99pOR11Xu7h6hd7SMS
	 4mHUhv09LDmqQ==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 18 Jun
 2026 09:25:49 +0200
Received: (nullmailer pid 3964027 invoked by uid 1000);
	Thu, 18 Jun 2026 07:25:48 -0000
Date: Thu, 18 Jun 2026 09:25:48 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Eric Dumazet <edumazet@google.com>
CC: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, <netdev@vger.kernel.org>, <eric.dumazet@gmail.com>,
	<syzbot+9383b1ff0df4b29ca5e6@syzkaller.appspotmail.com>, Sabrina Dubroca
	<sd@queasysnail.net>
Subject: Re: [PATCH net] xfrm: validate selector family and prefixlen during
 match
Message-ID: <ajOdfIzXW5KGzzXf@secunet.com>
References: <20260615090237.2689082-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260615090237.2689082-1-edumazet@google.com>
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-01.secunet.de
 (10.32.0.171)

On Mon, Jun 15, 2026 at 09:02:37AM +0000, Eric Dumazet wrote:
> syzbot reported a shift-out-of-bounds in xfrm_selector_match()
> due to AF_UNSPEC selector with large prefixlen (e.g. 128) matched
> against IPv4 flow (when XFRM_STATE_AF_UNSPEC is set).
> 
> Fix this by:
> 
> - Rejecting mismatched families in xfrm_selector_match.
> - Returning false in addr4_match if prefixlen > 32.
> - Returning false in addr_match if prefixlen > 128 (prevents overflow).
> 
> Fixes: 3f0ab59e6537 ("xfrm: validate new SA's prefixlen using SA family when sel.family is unset")
> Reported-by: syzbot+9383b1ff0df4b29ca5e6@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/6a2fbe35.be3f099c.2836ae.0018.GAE@google.com/T/#u
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Also applied, thanks a lot!
