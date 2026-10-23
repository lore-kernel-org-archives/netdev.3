Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.90
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792742195;
	b=c/6G7RiLyz+ZugDLQWW93jeS2wnIr7Cb5Q612/3B7UhcTRX2ZH7REi44tBIaDM9d2pkj
	 0cP0uCcKW4xdRjLGVbfauERuN1w1lhdo3YXvkQ9tI0NQGNa6yPTc66+dpwB4dsQLFzuLJ
	 NLlID5Wrc7dHAbZxvKx+GmfkkXIUdkJWVz+Xnf4Vk5iVw/yRRtLcg/HaYdxbQeKc1+T8E
	 6K0CVkeN1MBB/61fr46p/tqgYlyn2IPzjeADXlw7RUfOk7uwpgRXNZx3ZxIl5AjN9ftKo
	 mKDhWsJOLNTNOTVN35EYUM1lmgaaPvckXcuLQt8whcweFpHSYqvuzno3YTsmqc0Uspg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792742195;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=a1fLNTNQuElQrkhiWKcrIu52BrjXQYMDASDkpVEAwms=;
	b=Qf35Q29Ms0bNTWxJPaFxUBgwnRpfQNuweEqjqnlji2fFebqIEQ/BYm0AM3Fq9pzJiUw/
	 Iz9zRJUGCKQFuygn4ndVC1lYn61B0SCj3WXouOgzGYXQdZnb+h6N/1IvE++/2mU1Criao
	 LXbasy4Y3tnPVnkpcd55P2oQ4yOeB9u9ebP9Ec8nEj1RuocyQZs8kGvKp9nl4gOwONlRE
	 B6/a0ZMc+C7EPndmtSKneEwVqyY6YBvvETCoYb+IHxn6atJti+NSIp473MmOVA9KInh+k
	 7upnUsaY9H0BYHj7n+EjCt82Y/OOL94lBrBpsjrO+gm2rmUw/j1xwew1Gg1Z+5O8OOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=wW2D8xx+;
	arc=none smtp.remote-ip=95.215.58.90
Received: from mta1.migadu.com (out-90.mta1.migadu.com [95.215.58.90])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D3A606A31A
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 07:56:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07D3A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=wW2D8xx+
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=AxDTtbQpe1Pw1Gld4FexP/rem2OpjOhFrzr3t8rvVIc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792742191; v=1; x=1793346991;
 b=wW2D8xx+DdbRIC4AHcSsoWygNrMVamSR+kr6fATyTg+RyS24w+tgSGJSJea4RaHGc1sJGUTR
 uzy2bS5hJ0SH08Tstg8AwLygSAn1nXcr4+uSM40DDuBP9W6GwrgQjgb2jM1Wt50KldLURcH1v9y
 xNof3we7jE5136Rq/sttJ0m0=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 4835e8e05efbd0ae;
	Fri, 23 Oct 2026 07:56:30 +0000
X-Mizu-Trace-ID: 4835e8e05efbd0ae
X-Migadu-Flow: FLOW_OUT
Date: Fri, 23 Oct 2026 15:56:18 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Xia Yan <yanxia@cmss.chinamobile.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
	horms@kernel.org, john.fastabend@gmail.com, kuba@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, stable@vger.kernel.org, yana06070@163.com
Subject: Re: [PATCH net] macvlan: fix passthru promiscuity accounting while
 down
Message-ID: <atsTIt31dw6DPENI@fedora>
References: <20261022090809.12019-1-yanxia@cmss.chinamobile.com>
 <atrKdb1atGzCYka4@fedora>
 <20261023061630.350083-1-yanxia@cmss.chinamobile.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261023061630.350083-1-yanxia@cmss.chinamobile.com>

On Fri, Oct 23, 2026 at 02:16:30PM +0800, Xia Yan wrote:
> Hi Hangbin,
> 
> > If we discard the MACVLAN_FLAG_NOPROMISC change, should we remove the bit
> > before calling WRITE_ONCE(vlan->flags, flags)?
> 
> WRITE_ONCE() still saves the new flags. The patch only skips the
> lower device's promiscuity count update while the macvlan is down.
> 
> If NOPROMISC is cleared while down, macvlan_open() takes the
> reference on the next open and macvlan_stop() releases it. If it is
> set while down, the next open leaves the lower device's count alone.
> 
> I'd keep saving the requested flags. Clearing the bit would lose
> the user's setting. Rejecting the update would require bringing the
> interface up before changing this option.

Ah, I see. Thanks.

Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
