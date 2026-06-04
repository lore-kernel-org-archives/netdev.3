Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B7E355F49
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 02:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780539975; cv=none; b=QfWt+X7BisS9aVSPbOBLTf4oThrjd3ZvOrXSUwT3KI4H/XhHQuDjvE3+h3hhMt02u92hL4Sga/Cr+p5XftjlTswQJDRx2e//IR3R6zlqpn8mGRmdFEWN/vMHIo9SP+GO51na3mmapEwwRw7mc/ET10DhgLxlL+CvRaGTpoF2ang=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780539975; c=relaxed/simple;
	bh=vo5d2Rz+OMJtdC8E2fXPcPkOIaK+UTosLWwyDrbRv2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aVb/k85kmgji9uTi8ZPCq1bM+gxnNTgbx/RjG2crnzI3lRrv0O5spDeKMGQnthtc20qEE23zwSFJRn/hh53QjO7SjcHn/RkdGj2bwIxSGLZSYWMnGR7hRt3zBiafXpPnzmG3TpOA/hitF1zHC/cu1YNzdSLYj8313jXVOnQ90Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=KrWP+IIM; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="KrWP+IIM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=q7dfpRGkIM0vHE+fWfYvavOJ8hSy9IKDXn738A5Uv4g=; 
	b=KrWP+IIMFS9xQZDpAUEWfav/uYPbAGrdVWhZJ49/49/G9CGTgrE/cPltshS/HuEIt3Npn6UnTLd
	B1Sf+/64/HeKea52YHJEYeH7pS/NnPSW0NFwjyDE8HEKNGOxQX5GBPTHb4KKJKcRIK3+aXT6rzMIN
	1ta1WwmR5SwMQwyo/pNwbY6CI28wHolV8d6Kooe3nWZIlynjImqTjX+zU1rTmFktagf0UHOw5WPnG
	yvkcy9aXZKjrmF4Su3nr3Kp8KFm+WdCS6c3VAhI5JZ4T5/t4cmZ4udsyR1VklfQfLmNgHpH+6YxmE
	YX0H5LYZ5cJVNo7w+ausQhg/BO2tdp0APUFw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wUxmO-002Dgn-1l;
	Thu, 04 Jun 2026 10:25:57 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 04 Jun 2026 10:25:56 +0800
Date: Thu, 4 Jun 2026 10:25:56 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: David Ahern <dsahern@kernel.org>, idosch@nvidia.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, steffen.klassert@secunet.com,
	andrew+netdev@lunn.ch, kuniyu@google.com, jlayton@kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net v2] net: protect egress device access in the output
 path with rcu_read_lock
Message-ID: <aiDiNDlUaRSHWURI@gondor.apana.org.au>
References: <ahveCu-zzFlpeVut@v4bel>
 <20260602154523.GA537996@shredder>
 <ad40bbe0-f79c-4fd9-9670-5dab01a8e57f@kernel.org>
 <aiAk2Q-yNs6It6g4@v4bel>
 <aiDUqIC7N1GXtICR@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiDUqIC7N1GXtICR@gondor.apana.org.au>

On Thu, Jun 04, 2026 at 09:28:08AM +0800, Herbert Xu wrote:
.
> xfrm_output_resume is supposed to run with BH off so there is
> no need to acquire the RCU lock.

OK only the ones that actually come from crypto offload run with
BH off.  So perhaps add the RCU lock to the other callers of
xfrm_output_resume (ones which are not really resumptions) instead.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
