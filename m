Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.244
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794561720;
	b=GUWGFoeXho3DSTvUVA/Rhho7FaU6fJvCSZ+kIvhM0X7vWM4X2EhfkOdw8Aw4i7UjLmK8
	 EGWwAo6WT8BGRjPlbjXwkXgmgYuXK4aAss8NOuiw8KcRLUzguCFArfbGaItry/kioLkIG
	 ZJfkkso1qv+0dHSD4Q2PTp5cgEMYtyM9pIz/XJynBAEI3wWgcq97pqTPlRIjZ+QYo9IrN
	 zTwk9yOPBL/SFRu5FiZ/FayZ9X9jKQWpeOp2DOsVrf4s0ofufnPlNHFcFrYYH5p5Csack
	 avgADAnnStvD/+WObChg1O1tvQb/2iKRKPCg+6TcqG0Q58Nj4goqI+QL6KhKPTu/ghg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794561720;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=3xBS2vOD4gp9DoV7YzGTJwrouLStRAR4Z41uwZRvb1k=;
	b=pOXbMuIhajANG2n+SgzQq0ezt6iPHBeThfVcM85c8l6xr5vvGDhokuSFWI1xcUy9bGhX
	 HCj/iIxTj7U/7AwHey9lt/IwJW8vQ7wy8yEtOUoQLRXCxfwh9BOJNaRA6FtUXSZnYzU7u
	 UnVHr4C3djnheZ5iVjAvhoxw/M8E8pLvv1uVtlStIoc3kwxiaNfqDhM/D2FpRSLv/nv79
	 Ru5uB9S4FG6aNeYiKJNTiUspKgM3MDC8UPrgnEL9Q+ZJgS0KuESSl+gbV3wiKUHejp+zc
	 Hh0P/uedD0gg9NlcjdKq+mMoGfnXZEZ4Ue9sorCsec75bkxg2k+zV6htXcm9n4dJd3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=bNWZrnH3;
	arc=none smtp.remote-ip=95.215.58.244
Received: from mta1.migadu.com (out-244.mta1.migadu.com [95.215.58.244])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B643606A895
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 09:21:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B643606A895
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=bNWZrnH3
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=IsYtG1/KBh5pB9vnEFNrUE9kHVW7bK24q9FdfZElpWs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794561717; v=1; x=1795166517;
 b=bNWZrnH373Y5bt6TLsEib0MiOk4h19S3GRMVglIjOQ6WsnbGP4mDNEEOOfZIU09W7abp/YyC
 SouujFkDc4DvYRuzqgbfkWlMmef2OqAQ7sZB3DI2oXXVG35PRgxFk1SR5qfsxvhuNCN5ipbsZDs
 f+Jbqr9LWoOQZBR0kAvmyCWI=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id a786fcb1272cf710;
	Fri, 13 Nov 2026 09:21:57 +0000
X-Mizu-Trace-ID: a786fcb1272cf710
X-Migadu-Flow: FLOW_OUT
Date: Fri, 13 Nov 2026 17:21:41 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Ido Schimmel <idosch@idosch.org>
Cc: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@kernel.org, jv@jvosburgh.net, andrew+netdev@lunn.ch,
	razor@blackwall.org, aahila@google.com
Subject: Re: [PATCH net-next 2/2] selftests: bonding: Add a test for 802.3ad
 with coupled control disabled
Message-ID: <avbWpbswPYRV-s7H@fedora>
References: <20261111171947.2816258-1-idosch@nvidia.com>
 <20261111171947.2816258-2-idosch@nvidia.com>
 <avZ07oXIXo7xZyCC@fedora>
 <20261113070732.GC3517282@shredder>
 <avbAFdyJowX8CvOB@fedora>
 <20261113084240.GA3595966@shredder>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261113084240.GA3595966@shredder>

On Fri, Nov 13, 2026 at 10:42:40AM +0200, Ido Schimmel wrote:
> On Fri, Nov 13, 2026 at 03:45:25PM +0800, Hangbin Liu wrote:
> > For a pair of physically connected ports, do you mean two ports connected
> > back-to-back on the *same* host? Otherwise I’m not sure how to run the test
> > using two physical ports across two different hosts.
> 
> Yes, on the same host. That way we can test both the hardware data path
> and the software data path (with veth pairs). See
> tools/testing/selftests/net/forwarding/README 

Got it, thanks for this info.

Regards
Hangbin
