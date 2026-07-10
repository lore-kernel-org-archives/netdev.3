Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFD737B409;
	Fri, 10 Jul 2026 19:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783710154; cv=none; b=O6XsbA0sw/HAkhsqfgsbPix7NJHPIe0hpOEU5/yEY64WY5619WHkhuEhTPx4FJRXK2d6sMpAPtrgE74i81aLlmBGoLRoQksqpS0n4bUoa3g9P56Y1diKZfP5gS2gvOgg6YpInYyplm/sZbb21cHBT9R9mNIYysc9rAr+5HUdNrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783710154; c=relaxed/simple;
	bh=wUrOSu7yd2eNPF0tpr5FOe/BFu6WkwYAQPf2HMiCCqY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UUKXkLz0ZfTqKAQj1rHLmBGM0F25pKWabdMAqVX7UedNWcd7D2XJmSKjxMiZuofjgwtsKCAOiMPpFYA2Zap9yQzZJcQKmD8sUfArnkp2GlpSGD3XYWZyNk7DLcPggdsUpdrzl5pp/xJAImJq6BBM3i/WyHm2zPiFoFXwBI+7FbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=Yk7SlW8D; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Yk7SlW8D"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 54D00415B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1783710151; bh=PfSfBele8bfQww3k6pOBLw2dDivMcZ32ODcitgLhnGs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Yk7SlW8DKbXE34xSMjb2usELCDIrN/OixmGKaOsAX8cb4Zq1J2yf+DQTKQnBoqfWO
	 C/ZACU3xuUhi/AYLLXDoCEAFufEAy9k/ERDp8cRZXYxmsW+ns975hHqznM1f3LMC/l
	 DsVJxrhbEwpBPl2qxaNkis5iyMvJAJHHgx1sSDpaK0xzuhxkoO5eLQMtzz9adJLvN+
	 Yw1Z6EPuyeMKU6/mY/PRzSPoW8lqI4sqcjwvqyLZ/0gtWKwGXnJU7wntMFuFstOzJV
	 OBscI4LHTcM8FCG6VP+5iTKcyLj6bZPkfzgQfQd/qrH5IwtXdaE5koV7cSM1OXOhpD
	 V7ohl4a5gVpDw==
Received: from localhost (unknown [IPv6:2601:280:4600:27b::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 54D00415B3;
	Fri, 10 Jul 2026 19:02:31 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Manuel Ebner <manuelebner@mailbox.org>, Vladimir Oltean
 <olteanv@gmail.com>, Shuah Khan <skhan@linuxfoundation.org>, Jakub
 Kicinski <kuba@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>
Cc: Manuel Ebner <manuelebner@mailbox.org>, Andrew Lunn <andrew@lunn.ch>,
 Randy Dunlap <rdunlap@infradead.org>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] docs: packing: fix brackets
In-Reply-To: <20260710060346.417669-2-manuelebner@mailbox.org>
References: <20260710060346.417669-2-manuelebner@mailbox.org>
Date: Fri, 10 Jul 2026 13:02:30 -0600
Message-ID: <8733xqmzw9.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Manuel Ebner <manuelebner@mailbox.org> writes:

> Add two ')' to nested functions in code block.
>
> Fixes: a9ad2a8dfb43 ("lib: packing: document recently added APIs")
> Signed-off-by: Manuel Ebner <manuelebner@mailbox.org>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> [v3]
>  fix subject
>  add Acked-by
> [v2]
>  add Fixes tag.
>  add Reviewed-by.
> [v1]
>  https://lore.kernel.org/all/20260709121427.391749-2-manuelebner@mailbox.org/
> ---
>  Documentation/core-api/packing.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/core-api/packing.rst b/Documentation/core-api/packing.rst
> index f68f1e08fef9..cff1a262efce 100644
> --- a/Documentation/core-api/packing.rst
> +++ b/Documentation/core-api/packing.rst
> @@ -330,7 +330,7 @@ Here is an example of how to use the fields APIs:
>  
>     void unpack_your_data(const packed_buf_t *buf, struct data *unpacked)
>     {
> -           BUILD_BUG_ON(sizeof(*buf) != SIZE;
> +           BUILD_BUG_ON(sizeof(*buf) != SIZE);
>  
>             unpack_fields(buf, sizeof(*buf), unpacked, fields,
>                           QUIRK_LITTLE_ENDIAN);
> @@ -338,7 +338,7 @@ Here is an example of how to use the fields APIs:
>  
>     void pack_your_data(const struct data *unpacked, packed_buf_t *buf)
>     {
> -           BUILD_BUG_ON(sizeof(*buf) != SIZE;
> +           BUILD_BUG_ON(sizeof(*buf) != SIZE);
>  

Applied, thanks.

jon
