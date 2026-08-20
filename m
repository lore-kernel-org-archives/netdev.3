Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5DC175A74;
	Thu, 20 Aug 2026 10:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787221297; cv=none; b=a4kjNfh+PM1tvq19f2E1oqZTBQotWnd2GeZ/N/mje2QWsN5hIx2g7Pz2qedPiFxxzwR0WOUvTNyyA5Gncn5DCQkUeBlIhcxiPfYGPrN2g2VWc3pDZHPRx1GJmfknyv7PFMXzQiMORbKhUFjorXxLjaCiT90MAkSDIauZl/Eg/n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787221297; c=relaxed/simple;
	bh=3T6znomkLYqoOe9k6+WcffgoeKwog743lLiWnBoQwTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dYnZ+/7PRQEhCP6BXMrQWXlEYzDRmG/WARAbn7EkERzmT4TO1xZywp/yWagXbFqsUTx/o5tHdXmJOnvyoz3wxYvweFK6BncdKheNbtcOrq1M0/ucyVxbp68i7dJrorNMcLEinRXWSl23Ll+7Qof/9uZmO3C3cvqkfsktuGkDkdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=Fk3yAN+y; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="Fk3yAN+y"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=t7XbsiTYNYxsEu1t40STKXCrn+zfhqzY/FbWrXQfUaw=; b=Fk3yAN+y8Igb5qZKBlppbi6+RU
	366k7h5ccYkrYeu1y7wevjWSazaY69lZ+7Y+OUzeWFEhPTvPz/qxWUFCSlTL4yRef/EBX6ZFlKHHB
	QgUpS6Y76DWtnGTSfFOSIOIhKDZ/4sGdTIga+y34HEyQnbWKjF8u4JIoAaYEtFJyjkJ+LGgbA294/
	07kMYKL2E/l7K8p4iFofRIAt7HIsOb2JRLU7TvgOP2uShtSCNAiqL5tXyCmjzvhLI8xGOPxRHFWvc
	byD5xjouv59SOKsWjIWFZNYhC3vxp8aplng7yqpPx9/pbG4Qf9Ggx6MLSDo6CRhhW11E595/90uEL
	mYEG9i1A==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wwzPG-00ATdQ-0l;
	Thu, 20 Aug 2026 09:49:54 +0000
Date: Thu, 20 Aug 2026 02:49:48 -0700
From: Breno Leitao <leitao@debian.org>
To: Jaeyoung Chung <jjy600901@snu.ac.kr>
Cc: davem@davemloft.net, edumazet@google.com, herbert@gondor.apana.org.au, 
	kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	steffen.klassert@secunet.com, horms@kernel.org, linux-kernel@vger.kernel.org, 
	eulgyukim@snu.ac.kr
Subject: Re: [BUG] general protection fault in espintcp_sendmsg
Message-ID: <aobNl-rf638H__xI@gmail.com>
References: <20260819155349.3555804-1-jjy600901@snu.ac.kr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260819155349.3555804-1-jjy600901@snu.ac.kr>
X-Debian-User: leitao

On Thu, Aug 20, 2026 at 12:53:47AM +0900, Jaeyoung Chung wrote:
> Hello,
> 
> We found a "general protection fault in espintcp_sendmsg" on Linux v7.2.
> The issue was found by our own race fuzzer. We have not analyzed the root
> cause, so we do not have a proposed fix to offer.
> 
> To reproduce the race reliably, we applied the delay patch below to the
> kernel and ran the C reproducer as root inside an x86_64 QEMU guest. The
> crash log we observed, the delay patch and the reproducer are all included
> below.
> 
> The following kernel config options are required to reproduce the issue:
> 	CONFIG_XFRM=y
> 	CONFIG_XFRM_USER=y
> 	CONFIG_INET_ESP=y
> 	CONFIG_INET_ESPINTCP=y
> 	CONFIG_KASAN=y
> 
> We hope this report is useful. Please let us know if any further
> information would help.

this seems to be a real issue.

espintcp_init_sk() installs the espintcp proto and proto_ops before it
publishes the socket's espintcp context:

	sk->sk_prot = &espintcp_prot;
	sk->sk_socket->ops = &espintcp_ops;
	...
	rcu_assign_pointer(icsk->icsk_ulp_data, ctx);

setsockopt(TCP_ULP) holds the socket lock, but the readers pick up the
new handlers without it: inet_sendmsg() and inet_recvmsg() dispatch on
READ_ONCE(sk->sk_prot), sock_poll() on READ_ONCE(sock->ops).

A concurrent write(), read() or poll() then enters espintcp_sendmsg(),
espintcp_recvmsg() or espintcp_poll() with icsk_ulp_data still NULL, and
dereferences it.
