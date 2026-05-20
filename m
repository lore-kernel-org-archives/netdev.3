Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBD72E6CAB
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 03:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779246495; cv=none; b=KQXWvRM4yPVXHPClAOxzOMedrpzJc6Iq+CrZ74sqjcFALllVd8bHuBQR+bDRWkYU2szTJyPgycdNb6cPtJeE+0YqxbPx1O916wOx4Koflp4QqHxRAQrw2j61OereaTJ37WuhbDYWyF+APeBZU7nylD00AJociGRAHStvwIcoHv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779246495; c=relaxed/simple;
	bh=FEhYK3N/5VhUuW+gxM9VFVb1s6sxjL4NL6IH5cmj/c0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UQo1jnlyyrCGiwRZLcWlD6wfiGmX2+f8Ba/yuNUWIPw8vshC6tVRk1VgSl+aukhysI++Z1OeS5qcU41OxsR0lzf3m5zAjU/i3FwxIndzUpf6SE96J51JEJolbJMgY4c+4k3R1pH0ItWN/boylhEv3VMO8cWBT3AFHi5sh5H6hyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=A00JcSll; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="A00JcSll"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779246490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dnYXUAS8Ebf89cJtuDcLhSD3SI4tIssoHCODhCjsZGU=;
	b=A00JcSllySw7Hs/SadQMTjw/mRftQ2Uwm8E46CqUpdMSjGWeUr7uKmKNDFBWO51gV0/z/i
	Yh9G8rY+dpJre1F/oHKCLLtXhvn6K4qhITil7lpQjPr2pekUBWzE/nd5QXaw8co1QQbXF0
	V2+7AuMH9mfaApOQ2VY2TcvAUehxLfA=
From: Qingfang Deng <qingfang.deng@linux.dev>
To: David Yang <mmyangfl@gmail.com>
Cc: hong son Nguyen <hongson.hn@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: dsa: yt921x: Add ACL support
Date: Wed, 20 May 2026 11:08:02 +0800
Message-ID: <20260520030803.1615-1-qingfang.deng@linux.dev>
In-Reply-To: <20260520022242.120640-1-mmyangfl@gmail.com>
References: <20260520022242.120640-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Wed, 20 May 2026 at 10:22:36 +0800, David Yang wrote:
> Enable filtering of incoming traffics. Note that custom filters are yet
> to be utilized, and thus not all flow dissectors are implemented.
> 
> Tested-by: hong son Nguyen <hongson.hn@gmail.com>
> Signed-off-by: David Yang <mmyangfl@gmail.com>
> ---
> v1: https://lore.kernel.org/r/20260514192140.3468543-1-mmyangfl@gmail.com
>   - fix issue reported by test robot

The always-false comparison is still there:

> +		if (match.mask->ip_proto) {
> +			enum yt921x_l4_type type = YT921X_L4_TYPE_OTHER;
> +
> +			if (match.mask->ip_proto == ~0)

../drivers/net/dsa/yt921x.c:1821:29: warning: result of comparison of constant -1 with expression of type 'u8' (aka 'unsigned char') is always false [-Wtautological-constant-out-of-range-compare]
 1821 |                         if (match.mask->ip_proto == ~0)
      |                             ~~~~~~~~~~~~~~~~~~~~ ^  ~~
1 warning generated.

> +				switch (match.key->ip_proto) {
> +				case IPPROTO_TCP:
> +					type = YT921X_L4_TYPE_TCP;
