Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14E331690E;
	Sun, 16 Aug 2026 17:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786900439; cv=none; b=GzOskfJE3RD+MsknVDK0yM8pzAdkhJYZ8020iB+dUvWnPPwpx0JFXDWnznUn3zmOsZ/LffTbdBoPlPf+owR9Zq6XEqxG8jv6kLXvu5zdZSZcNr69jwmoVsf3VH+Ksiu06WUvZJlxWP6g1uE9DBkQFNRwaKspDHHhTLcuIo10BQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786900439; c=relaxed/simple;
	bh=VRreQ4/1At4Fq2REWn9VCHpMBL+8+MuW7gyf/Czsa7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t/+Y/xK7IvsaiYJbZnVUbIREJXJACzLeVtfjSjeQUv8PdJP/lmU8BFj9AsomXmzwz59RU8RxZwZHOeI2IDr6OBlVFpCUXc444kyQy+w/0HxO6IC0H8gM10ffQAXvKPK6koGFy4JKonXkeIWAFEynAPWtxANT8bSuA1hSdCoB/nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=k25GOjtP; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k25GOjtP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=1djf4WsQkmVu30eP3Ssq7ZvHcwQP2tg5K/g2i4Xf/y0=; b=k25GOjtPvOwOOukorgwzBRan7E
	O8h02Y5575sZGJTjvo10ZDNppbxCAgqR6nVQbgQtUPK+yQOd1VI93gl/iLMz9xib5UW3CO+EV36JW
	xcEUsYE1yrIl/Mq5p3HtZN8ywHydM+bjU82JsNq3wgQH671p2oIRU5porwc4ErUFoA86nCnM1nx2H
	/TTvOaS6rhEx1L7z9vU8z+qeNL5lRu2+YBpvy46ZA1ypanG9/ouZO4CB1zrXeCN7omnORQ8RGBKfq
	UHAJKm7JaujBmRDb5jMNEXj+x838i0zpId0bB11UTGX96HSe9XkyDqFi9KnCP46YPRHhirEBmoH3K
	LLE7GpYA==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wveQh-00000004uw7-3MTp;
	Sun, 16 Aug 2026 17:13:51 +0000
Message-ID: <3e782d86-6099-4c90-9e37-801bdf6d91f1@infradead.org>
Date: Sun, 16 Aug 2026 10:13:51 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/2] net_shaper: fix kernel-doc list
 indentation
To: Karl Mehltretter <kmehltretter@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: Shuah Khan <skhan@linuxfoundation.org>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1786751700.git.kmehltretter@gmail.com>
 <64f428350ec1450adcd0607f54f30d27a42f129c.1786751700.git.kmehltretter@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <64f428350ec1450adcd0607f54f30d27a42f129c.1786751700.git.kmehltretter@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/14/26 6:32 PM, Karl Mehltretter wrote:
> Docutils 0.22.4 reports:
> 
>   Documentation/networking/kapi:107:
>   ../include/net/net_shaper.h:82:
>   ERROR: Unexpected indentation.
> 
> Add the required blank line and correct the list indentation.
> 
> Assisted-by: Codex:gpt-5.6-sol
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  include/net/net_shaper.h | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/include/net/net_shaper.h b/include/net/net_shaper.h
> index 05cb625b0fe54..330517a1cb5c2 100644
> --- a/include/net/net_shaper.h
> +++ b/include/net/net_shaper.h
> @@ -80,10 +80,11 @@ struct net_shaper {
>   * disallowed at the uAPI level will never be made at the driver level.
>   * The shaper core performs automatic reparenting and cleanup, generating
>   * additional calls. Notably:
> - *  - @group calls in the driver facing API may have nodes as leaves (user is
> - *    only allowed to construct groups with queues as leaves)
> - *  - @group calls may update leaf's parent if the parent is about
> - *    to be removed (re-parenting nodes explicitly is not supported in the uAPI)
> + *
> + * - @group calls in the driver facing API may have nodes as leaves (user is
> + *   only allowed to construct groups with queues as leaves)
> + * - @group calls may update leaf's parent if the parent is about
> + *   to be removed (re-parenting nodes explicitly is not supported in the uAPI)
>   *
>   * Implicit creation
>   * -----------------

-- 
~Randy
