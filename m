Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.96.220.36
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793863310;
	b=B3oIKEy/MrENmAtIikm2ETpPNZctCbsWExEOfq+XHJxfv/J6885CyJ+tc4aL7fWxA/R+
	 cwpH437oqWzlfwxTY2E96jj/+LmzDs35e4RbgEc8u4rwrZyX84uTb5NuWZDUWsMgH11Nk
	 xWOwKu/IBvk4/PBUZfJssg34bdlp8bhHmao59Pc4xJgmqZb1Jm8sW0uZz7CyQq4Ik6oKI
	 f00XVym91UsEX70wmEv+7NXdejYedu3b6Ki9yMtApyBIlcbybVpWY7e1bnBJbWc5/ukuB
	 wwxRpW6pWMhyUnG45gX0RzGltMGfCjIEnxUBkZgfG2Ak5FE92t1QY0FQpW/FLa0iKNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793863310;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:Received:DKIM-Filter:
	 DKIM-Signature:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-ClientProxiedBy;
	bh=A7xCBWYxNpkJA+HXFAzZk+jbkrVgYp/LXNr4Qp/2hI4=;
	b=x0Fh03EjlpE0e4yE9bSe/1+4+Sm9SEK4qUmPeCIo8mDRj0uzFI8bbZA+QOlNs84II9YN
	 P+NEJVCG4NBQuYv50lEpdhSdrXBYubfqZw8O19wHF6A6w0RkFPCW1Fv6cSATPtxfzXs4e
	 LHrxB182Ee+2jmmBk7jhPKhGRV+dB701qDkS0mrriJN/anAzD96v4rp0m14sHUbu7iS1Q
	 VX7Cj3L2jsij402JDJGGcf0llvEWAq2Vjbu/uKu9ugxOUWlkbjb03A/D9NVj7adbwjAKt
	 1LfBQEfbOMLeQjTriFx9Qipe1JENEe0HMaZgeDnfixUerh0h53/SnjlIu0AXZpl6LEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=secunet.com;
	spf=pass smtp.mailfrom=secunet.com;
	dkim=pass header.d=secunet.com header.i=@secunet.com header.a=rsa-sha256 header.s=202301 header.b=AmxHA8Ve;
	arc=none smtp.remote-ip=62.96.220.36
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5792C606A31B
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 07:21:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5792C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=secunet.com header.i=@secunet.com header.a=rsa-sha256 header.s=202301 header.b=AmxHA8Ve
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id A824720849;
	Thu,  5 Nov 2026 08:21:40 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3SGRWzQJ6JcK; Thu,  5 Nov 2026 08:21:39 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id D71E0207D1;
	Thu,  5 Nov 2026 08:21:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com D71E0207D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1793863299;
	bh=A7xCBWYxNpkJA+HXFAzZk+jbkrVgYp/LXNr4Qp/2hI4=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=AmxHA8VeyP4PET+GkRC8dQ094TFlKqYtBxMXuoPcshNBTMS7tkGuWvJu+Y3U87mkh
	 FB4hpiKNQlXeIPizHFjyFECjp4DH/2VYcYZDmidK8yl+p9NTrZuR66xfCgIjXqgK13
	 Gqk0Z+4E/EJqHnpcIBAICYpbWs9E+KVDOJYKeCS2WX8hiC/IRsi9Rps3VbbtjtBMDh
	 6wLXVhvwmL4cJrbkL7H5i68SvpwYos5wKAUPBt+OMOfiKLroKm1PzNld0MZ2qy3GPq
	 kihQUSyU6BF/I9aA4w3k6P5AUb8SSvIawtz/7w98jGRp6JutqOjESjQsUpUkgsB2ZA
	 +6XthKwcxoGfA==
Received: from gauss4 (10.182.7.102) by EXCH-01.secunet.de (10.32.0.171) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 5 Nov
 2026 08:21:39 +0100
Received: (nullmailer pid 1823182 invoked by uid 1000);
	Thu, 05 Nov 2026 07:21:38 -0000
Date: Thu, 5 Nov 2026 08:21:38 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: =?iso-8859-1?B?Suly6W15?= Jean <Jeremy.Jean@oss.cyber.gouv.fr>
CC: Herbert Xu <herbert@gondor.apana.org.au>, "David S . Miller"
	<davem@davemloft.net>, Sabrina Dubroca <sd@queasysnail.net>, Saeed Mahameed
	<saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Boris Pismenny
	<borisp@nvidia.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH ipsec 0/7] xfrm: fix ESP IV generation and ESN
 authentication
Message-ID: <auwuggdz_TCwtlqN@gauss4>
References: <20260930144523.435271-2-Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260930144523.435271-2-Jeremy.Jean@oss.cyber.gouv.fr>
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-01.secunet.de
 (10.32.0.171)

On Wed, Sep 30, 2026 at 02:45:17PM +0000, Jérémy Jean wrote:
> Hello,
> 
> This series fixes nonce reuse in AES-GCM and ESN authentication errors
> in the IPv4 and IPv6 ESP offload paths:
> * 1/7 and 2/7: Save the current sequence number before incrementing it,
>                so that GCM IV construction prevents nonce reuse,
> * 3/7: Use the current sequence for software AAD and hardware offload,
> * 4/7: Give each early GSO segment a private secpath,
> * 5/7: Use the packet sequence directly for mlx5 IV generation,
> * 6/7: Segment untrusted GSO packets before allocating sequence numbers,
> * 7/7: Keep the sequence counter unchanged after full ESN overflow.
> 
> Note that triggering the bug fixed by 7/7 is impractical: it requires
> processing about 2^64 packets under a single key. Yet, I still believe
> it's cleaner to fix it.
> 
> On the crypto side, as a reminder, reusing a nonce under the same GCM
> key is catastrophic for security: it exposes the XOR of the plaintexts
> and can reveal GCM authentication key, which opens the possibilty for
> an adversary to forge ciphertexts without recovering the AES key.
> 
> This series combines and extends these two individual reports:
> * https://lore.kernel.org/all/20260925095105.446269-2-Jeremy.Jean@oss.cyber.gouv.fr/
> * https://lore.kernel.org/all/20260925095128.446450-2-Jeremy.Jean@oss.cyber.gouv.fr/
> 
> Recent discussion with Sabrina Dubroca may also be of interest:
> https://lore.kernel.org/all/c443bad568f4e03d05b848b1b245707d@oss.cyber.gouv.fr/T/#u
> 
> Regards,
> Jérémy
> 
> ---
> 
> Jérémy Jean (7):
>   xfrm: esp6: use the current sequence number for the IV
>   xfrm: esp4: use the current sequence number for the IV
>   xfrm: esp: use the current sequence number for AAD and offload
>   xfrm: prevent AES-GCM nonce reuse after early GSO
>   net/mlx5e: Use the packet sequence number for the IPsec IV
>   xfrm: segment untrusted GSO packets before sequence allocation
>   xfrm: leave the sequence counter unchanged on ESN overflow

Please rebase your patchset along with the proposed changes to
the current ipsec tree so it can get applied eventually.

Thanks!
