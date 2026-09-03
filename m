Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6720E46982C;
	Thu,  3 Sep 2026 08:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788425855; cv=none; b=m1j2CHbE2i9tFTm2IC5dlI8pATHt1tZkzQXgZ3S3KQrcS5JKCbdqxp3r3TX6P7aSgDxtdj/tFo3jtqfjxnS9VabETDvXwusjqm33AdHFvSrlw16t/DmUeFZ9RkXphhD79jMEe4q4CnJFjaqE5l2NfKF/KVKpprqg+kmhAJ47xZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788425855; c=relaxed/simple;
	bh=0T8IeZCtcWjNRqlZN3GK3YV5k17OZMQSFmZbqhn1WZc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HXh60BPoeSnPe9RsxglTOd/Rmu6/nz2yWgU9JwW0cb1ADmTCHKJfLEW9lq20jTpTQ4YnqAJhB/RruHUPGHa/NQGL1bN3Fnl0xTXZhNiZyP4n7hq+mIJnZkFhZ0JgqNGLD4GlTe8e0idyaVLGrRlljUrh/MMVRbmi+PXdFMRzm78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=FzKql4yM; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="FzKql4yM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1788425850;
	bh=0T8IeZCtcWjNRqlZN3GK3YV5k17OZMQSFmZbqhn1WZc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FzKql4yM/mMN9mg7iOGfq96pzbSNIJXV1Oy6EMiFYBCXT2FzzNQhtC1Ov6soVPeCT
	 6N/YY1E72YYp5M5XwQA413cNneo41eE/nJXyZ9YUnStZLVvgeb3h1bkyuPBlmQ999x
	 pA7kdX6f8+xCFzwgTdYYBLtPN/sT1BqJ2wczGnLRr85CrEB/9WrnSXOT4MAjH/FBD7
	 7yKWsjJBEgofeuMlYmUW8lAtoPjrYlM548B99E477+eqGQ+dCm6t79geNYmuNByRDM
	 nAaCy3n6aIpOYKiC1/VSeSf/T3nz56dsmTRwc7ba3TK/6KLMewaIFOCTeZ3sQYdi5D
	 a0eodseriGX9A==
Received: from [192.168.12.105] (unknown [144.6.157.237])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id BCAB967A89;
	Thu,  3 Sep 2026 16:57:30 +0800 (AWST)
Message-ID: <88ffb5b9237e6551818a1188ace5d394322f0a13.camel@codeconstruct.com.au>
Subject: Re: [PATCH net] net: mctp: i3c: serialize probe with bus removal
From: Matt Johnston <matt@codeconstruct.com.au>
To: XingWang Xiang <v3rdant.xiang@gmail.com>, jk@codeconstruct.com.au, 
	netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org
Date: Thu, 03 Sep 2026 16:57:30 +0800
In-Reply-To: <20260902060118.4025762-1-v3rdant.xiang@gmail.com>
References: <20260902060118.4025762-1-v3rdant.xiang@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-09-02 at 15:01 +0900, XingWang Xiang wrote:
> mctp_i3c_probe() drops busdevs_lock after finding the matching bus. A
> concurrent I3C_NOTIFY_BUS_REMOVE can then unregister and free the bus
> netdev before probe passes its private data to mctp_i3c_add_device().
> The latter consequently adds a list node through a freed mbus pointer.
>=20
> Keep busdevs_lock held until the device has been added. This also
> satisfies the __must_hold annotation on mctp_i3c_add_device().

Thanks, this looks right. Building with CONTEXT_ANALYSIS caught this as wel=
l
as some other problems,=20
I'll send patches separately.=20

For this patch Sashiko reports some other existing problems in mctp-i3c, I'=
ll
check those.

Acked-by: Matt Johnston <matt@codeconstruct.com.au>

Cheers,
Matt
