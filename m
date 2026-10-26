Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793018515;
	b=dZyjEjYZPuhh5e+PtPYIKlv/PjrhVEhq4EKOeXsUzsKS/5UUlXEOsmyhBSIBDA7chhEG
	 YglAIMUYnBuJRSPh4thrJA2RhNRWe0kgGVfOrbTeSRi1QfmV+48EwqUJlfEsoafKlomOF
	 b1UMsKZbnBIkyLuUSBn1RDQpPGM2O3CnAtclEfjvWIFvTfqRnvgnKHj6+Z6P5zviDR63o
	 uXAA1Z5b7i7C5kFkUzjyE7x7S5/nGI47sJnpE2GBlpUlfZINYvWlX/pYPsyN+CXrf7v8w
	 5273WZrBTEIexOgCBtsPUWHnQZNt4En3qJw5qvSqbg9H+PF+NahbICPvReMUu7Ni3Mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793018515;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=KO7AYtEHal7/gxD3bZY/yRpvMfzoftniypepjR/yBzQ=;
	b=G0Gfe9kFgzD1iklOwhdOCzbWLgVTI+lN4nn7k/18TezS3phrIjGxr+l7sqO3jaUT1+ki
	 9KUjTUv6v+9IUHIihQA5zATMN50YLLzodq65hKjwb6ef19/SWXgePBXrxdGKBSScnaLIv
	 o1ZByr0d1fS5nW0RkbHhjYwKPXVv+BOyK20gany2E0d9SMn1aMOiNjKrGPKd2p9hDXfMS
	 ++Q+Mra0eagdnUYqStZeYchbaQFoMwRuvflV1MM5OchC31RJ+UiD+sLoY6wLr20KT9uUX
	 /XX01CFNHzraKkRGjKGmiNtJJB3jnWfDW1xY3VI3ZAG5UawYjVFnM91i+lcWd2UQCNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=r6x+pAn3;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AAE606A31B;
	Mon, 26 Oct 2026 12:41:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38AAE606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=r6x+pAn3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=KO7AYtEHal7/gxD3bZY/yRpvMfzoftniypepjR/yBzQ=; b=r6x+pAn3/3SnE4lLsyaHXEwvxg
	/d+P3KMrgPP0jUVmei8RNTPdbQ0cOBhVfKbtikmsd+RhqX8aOD1SmkrefuiLVhhvWc/nFDL5ViXA+
	tOvuXuAPDoighu2Ox0apsNs3b3BbsVEJzltMqtkdySK1svrEhKErqzlM0fP3XgPL00Dc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xLK1L-00CnVL-Ae; Mon, 26 Oct 2026 13:41:47 +0100
Date: Mon, 26 Oct 2026 13:41:47 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: motorcomm: Fix function parameter types
Message-ID: <46921fb6-e89a-49c8-b15d-eba8d3eb3f8e@lunn.ch>
References: <20261026083252.12684-1-mmyangfl@gmail.com>
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
In-Reply-To: <20261026083252.12684-1-mmyangfl@gmail.com>

On Mon, Oct 26, 2026 at 04:32:48PM +0800, David Yang wrote:
> yt921x_fdb_add_index_in12() mistakenly takes the two register images
> as u16, while all registers are 32-bit wide, silently losing the upper
> half. Widen the parameters to u32.

I'm surprised the compiler is not warning about this. Have you tried
building with W=1? or W=2 ?

> Fixes: 186623f4aa72 ("net: dsa: yt921x: Add support for Motorcomm YT921x")
> Signed-off-by: David Yang <mmyangfl@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
