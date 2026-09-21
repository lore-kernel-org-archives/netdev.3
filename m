Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43E647A898;
	Mon, 21 Sep 2026 23:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790033353; cv=none; b=Vf+QW/cGpg2hIjhdsjHHLeAzWSRpR3zvVUoB+TIIFQtzX42tSHUuUh/mEC17RI7yUg4A0ezc8zVc1nYEx0JESvjY69F+ouV/tjwBYBe1TchpOXcOU9novt4k/daQRNpfexELHqDWaapTJvMd+uuCeoCKaTe2HsfOWhnrrKu9II4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790033353; c=relaxed/simple;
	bh=lFsc1GojGmU3K5BpyRT66DQ0L55nkb7Z08ORNGTHHeU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g3mF6Rd5kdaNcb4aw4d+hdpwIE7NMd6xi5fot2tU5mkhO4K72nYPfHyavkvRxK/k8NX4+PUL+hxVzY5F7eh1920r4gssT0fLRplQ/7EqN6dqQoUab2xDFWG1Ysc3WfKXvKrZ7EehxxR7EMqvKYkN5ceH3GRyqgvm1gB7YlyzT38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d4kWmp9o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d4kWmp9o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 878951F000FF;
	Mon, 21 Sep 2026 23:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790033346;
	bh=3rdTZZ6oKBMbejVEbYel2wDyhsKjwmIkaR2bmVVCYog=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=d4kWmp9oAfCVa6isFY4AxMe6iGhxntTMfvA+hZKnMmjmYhNgz8JHyRr+WK4ttMtUb
	 7uqRWnH7teYCec/1iQCQSiGmA2dkT6fcswYoJjSXNjvaSgvsWlUX4S+Em7fDibGMB7
	 v6wdORpZ2LhzmEDMWcCos8YCszMrsrxRiFPmCYK0qqt5QZpsdh4HZLL2L+gyad5G4y
	 JwGMnbT8XRv3iCMy2XPXbvKJm2P6PzK6Kec2M0CobyKpk7M2wyermQnflGmIrwqkz/
	 AU7p5gaLT0T6CTP30sEqW+dmvG/pl0AHps+ptdhva3C0u1RJw55VvMBtDuvMf0CuAT
	 2n6+CBBHFXIQA==
Date: Mon, 21 Sep 2026 16:29:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, sdf@fomichev.me,
 bobbyeshleman@meta.com, almasrymina@google.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/3] net: devmem: replace gen_pool with
 freelist
Message-ID: <20260921162905.48e76338@kernel.org>
In-Reply-To: <20260917181116.3319017-2-sdf@fomichev.me>
References: <20260917181116.3319017-1-sdf@fomichev.me>
	<20260917181116.3319017-2-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Sep 2026 11:11:14 -0700 Stanislav Fomichev wrote:
>  struct netlink_ext_ack;
> +struct dmabuf_genpool_chunk_owner;

watch out for unnecessary forward decl
(next patch deletes this one so doesn't matter)

>  struct net_devmem_dmabuf_binding {
>  	struct dma_buf *dmabuf;
> @@ -26,7 +27,7 @@ struct net_devmem_dmabuf_binding {
>  	 * dereferenced.
>  	 */
>  	void *vdev;
> -	struct gen_pool *chunk_pool;
> +	struct dmabuf_genpool_chunk_owner *chunk_owner;
>  	/* Protect dev */
>  	struct mutex lock;
