Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FB0424D70;
	Tue, 11 Aug 2026 09:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786441296; cv=none; b=oyOIjCNLKtEbqZjN6E01HuBblvsQJoSLQew+Lyv8HrRi2FcWR04k7ODsRmVWWQh8+7+2jI5Tdomy89fac/44gxpmz+UHIQZYxBrvzfu4X15ZaLNO4EeQKIAkPd2pW29UFCQqzR5PZqcAbyEayUcacwWq6/ixJ3u7NQr9Jd5rAAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786441296; c=relaxed/simple;
	bh=Nj5KpPQH7NBYJ8Dh6iUkF5S0m0GsMognXPcuDCVqJJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pfaQ4vqNtjRGIzIATcb6xjJOtBOL+T+j7iaTkJaWuR/M1cE0mD/o36TasYBOzBqXqAhESTlTEMAvtW5SLhZoZdmmp2N7JjvrTAN1loY0RTPfhyAIG7h6O2jwDJ8mOX73/qkvHMIXVJpb0qGkWPGMO+PUB75pgtzArcD028YBjVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=D/nYuJ3H; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="D/nYuJ3H"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=x0LXuradjaBDUdpGwitgnO9x+jEP9InHi11OJSjcI94=; b=D/nYuJ3Hcz5TRtVovyUaHZmT7U
	8rln9h6E5TVT+7/uIDI0cMfME2QHSshc7n6rs7qUxWhaeDR+QbbjjbL8b0qltJ9bokepkXWK6IPv+
	HEU5Hm5FKziYHbIxhsfkM9lauO+H4y23vEQR9Nak5eSqVMIa1OjHIEz0pjJr5CwkIJ6FMQS6h9iLw
	/AdqEBLHXiIYobSjxV/J8D7vOPsr2G5h3k92oJK6/eTHUxPgzRkKunKHSap6W+yRfSXfp5xA71CKi
	t3DcsvQrEDliCp0FfoM0+ha5j5wn5J0WPNJ9vw/xDAUKIoFsBW1xCRnp9doqLZjCO8LRr/R+gdjk7
	1owHtKeA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wtiz4-003TEq-0q;
	Tue, 11 Aug 2026 09:41:22 +0000
Date: Tue, 11 Aug 2026 02:41:17 -0700
From: Breno Leitao <leitao@debian.org>
To: Qingfang Deng <qingfang.deng@linux.dev>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Norbert Szetei <norbert@doyensec.com>, Taegu Ha <hataegu0826@gmail.com>, linux-ppp@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] ppp: annotate lockless queue empty check
Message-ID: <anrt_vOzR6rNQdXp@gmail.com>
References: <20260811060236.322284-1-qingfang.deng@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811060236.322284-1-qingfang.deng@linux.dev>
X-Debian-User: leitao

On Tue, Aug 11, 2026 at 02:02:29PM +0800, Qingfang Deng wrote:
> ppp_poll() checks whether pf->rq contains a packet without holding the
> queue lock. skb_peek() requires appropriate locking or a private queue,
> neither of which applies because ppp_input() can enqueue concurrently.
> 
> Only queue emptiness is needed, so use skb_queue_empty_lockless()
> instead.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>

Reviewed-by: Breno Leitao <leitao@debian.org.
