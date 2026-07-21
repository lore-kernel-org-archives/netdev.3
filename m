Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A20F363081;
	Tue, 21 Jul 2026 17:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784655151; cv=none; b=hsgQFWZZ6TyUIf6IeKMsLNNDffxowbh5BjHDFCaa5oV42jc0pJm4eYHSp9DcCTxjDNlbfGDx9FyclrUY8MCFCVRb7LYZnudLXVO7omw7rYgziO5MYwPjL7iv2B/ZEeLo+S8a4jGtaiklaP7yjAr4Uwx3OeUluGvYoSZJUemBuTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784655151; c=relaxed/simple;
	bh=W3UELpfhPnmnyoTTOwBsXOEGdfochFP8bXrgAAVw00o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IO+136cmKlzoGeKIa9yvJmeC+oql4YBUV5PQ/GXu8O0aQhxwsR0VCbA4O7hFJcKLn1nrqYREthl8Y2dzLrPZlRCQlBP+Wuw9CZLZEre1Hx2PyDa5XrjrolmPcsOhlpHZpENcHM/vIEubz9p93LCJ40+6ZOq2vM9FOkBesKF762E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ye8oFeUH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ye8oFeUH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2BAD1F00A3A;
	Tue, 21 Jul 2026 17:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784655150;
	bh=5QKYtP6PPwsPDNf5L+/cSkellaAe0zQs79cLeEUvhVY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Ye8oFeUH+KufmIwp9/6eNT4dW3Ncakt7gER6uRK83qIlBXJlh7SxNy67sMZTRtX9W
	 sYtbK5TSAQ7raCdv66xR2dHds4q4TK6teioQ09pmafadkKxJgzQoTbePcC09VEtLCK
	 l71hlKgzVcuQi+Xz1z+hzmWxUCAFjIne5MOSd9zucVJwK0PDrPowlVnEObOv2z/hpt
	 A6c40q25TZJ9eaVbAuLlwpEbpbrzPPfW2J5OFWvUGMEIvkNLaEctpPZNYlT8EzOZqq
	 g1VdZXf650hPrVfUk3H+wBgfQeXz4faeIjfMinSv3zXxZjS5Xs6tvsUTpobtncgHo/
	 FoXQhIMskjWQA==
Date: Tue, 21 Jul 2026 10:32:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 3/3] net: dsa: motorcomm: Add LED support
Message-ID: <20260721103228.0a90ace6@kernel.org>
In-Reply-To: <20260709014812.1158178-4-mmyangfl@gmail.com>
References: <20260709014812.1158178-1-mmyangfl@gmail.com>
	<20260709014812.1158178-4-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  9 Jul 2026 09:47:47 +0800 David Yang wrote:
> LEDs can be described in the device tree using the same format as qca8k.
> Each port can configure up to 3 LEDs.
> 
> Currently, only parallel mode and strict 1:1 mapping are supported.

> +config NET_DSA_YT921X_LEDS
> +	bool "LED support for Motorcomm YT9215"
> +	default y
> +	depends on NET_DSA_YT921X
> +	depends on LEDS_CLASS=y || LEDS_CLASS=NET_DSA_YT921X

is it really useful to prompt the user with this option?
Shouldn't this be a hidden option which gets auto-enabled
when dependencies are met?

> +static bool
> +yt921x_led_trigger_is_supported(const struct yt921x_priv *priv, int port,
> +				int group, unsigned long flags)
> +{
> +	if (!flags)
> +		return true;
> +
> +	for (unsigned int i = 0; i < ARRAY_SIZE(yt921x_led_trigger_maps); i++) {
> +		const struct yt921x_led_trigger_map *map = &yt921x_led_trigger_maps[i];
> +
> +		if ((flags & map->flags) == map->flags) {
> +			flags &= ~map->flags;
> +			if (!flags)
> +				return true;
> +		}

Isn't this conditions simply:

		if (flags == map->flags)
			return true;

?

> +	}
> +
> +	return false;


> +#if IS_ENABLED(CONFIG_NET_DSA_YT921X_LEDS)
> +
> +void yt921x_leds_remove(struct yt921x_priv *priv);
> +int yt921x_leds_setup(struct yt921x_priv *priv);
> +
> +#else
> +
> +static inline void yt921x_leds_remove(struct yt921x_priv *priv) {}
> +
> +static inline int yt921x_leds_setup(struct yt921x_priv *priv)
> +{
> +	return 0;
> +}

There are static inlines but I think you still protect the calls to
these functions with itdef?

+#if IS_ENABLED(CONFIG_NET_DSA_YT921X_LEDS)
+	res = yt921x_leds_setup(priv);
+	if (res)
+		dev_warn(dev, "Failed to setup LEDs: %d\n", res);
+#endif

> +#endif
> +
> +#endif

