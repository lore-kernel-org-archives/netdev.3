Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C80354788;
	Wed, 23 Sep 2026 00:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790123894; cv=none; b=enTNH2oQ8wkFh+KG/9uKnoV0KfSTs/8S8CTYu30tH7fL48xG4S/1FURhegVCWivULf0pP6KaVIYzSGmFW68lksWSJRtKh0XaCZ40ui2CpqpBvO4dMavi1k77oyYrj5hpqR+424ecYWs+vUsvjlZk/nFeHOrTnlq3YLxh4bfwj2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790123894; c=relaxed/simple;
	bh=INodYnnPvXxri6ZN6tPfAJkfZPOwWK9deoE5Q48J5WE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HvzZKQuJdQ/gZBXjT+2RggyFlm1X1nky/t7Yw+VPJaScTqarYhR3tWm4AgwEB8evMJv/qx46EwzJ3YLL063l+h0c2poII04EGQn33CCin4eDdRlshsWWmEV24DR7u27YLcxgI67Pq5hELrQxXKd52rays4bTsV2iklfMkzhwN1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fFYwxE8/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fFYwxE8/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FFA91F000FF;
	Wed, 23 Sep 2026 00:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790123892;
	bh=YP/I4S28TVTqUglK/IadqaM72viGX8Ih6JU5IQO5kJI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fFYwxE8/zFGLfGZCfdzcXvLQOdzxVkJ9cHZ0Aewi1If1FMmLtV7WDiKnG8g7cXJEq
	 WH1FzGgY4Nu5HjlMfJhT0DJqISENkZg7H9O6mCxiSavYEZq/YoOTzh9ObF3pGAeQe6
	 f1TJCyVn0VLCc441HnoqRpJpPNP1Mzpy4XSLPNd9CpRYVGoxXcYDuVsSB5b0aTKp3t
	 /k6cWKEEXidMG8XOfgg7A6o+4mqkWbkypF1MpxssZwaQixLPmxIOWG0E2tnUk3kBPx
	 dh0SSDRG2q2NAlMf6ETTnCBcKxed3mrJZPGpwzGq4trYn4VgItBqsa0hC+XMRTmmzd
	 ZjjiK77LUahFQ==
Subject: Re: [PATCH net-next v4 1/7] net: dsa: motorcomm: Hoist port_to_priv
 helper into chip.h
From: netdev-bot+sashiko@kernel.org
To: mmyangfl@gmail.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, linux-kernel@vger.kernel.org
Date: Wed, 23 Sep 2026 00:38:11 +0000
Message-ID: <179012389159.2160803.2607059745097443469@kernel.org>
In-Reply-To: <20260921203040.1203911-2-mmyangfl@gmail.com>
References: <20260921203040.1203911-2-mmyangfl@gmail.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The helper promoted into the driver-wide header,
  `yt921x_port_to_priv(pp)` in drivers/net/dsa/motorcomm/chip.h:992-993,…

--

net: dsa: motorcomm: Hoist port_to_priv helper into chip.h

The duplicated container_of_const() expression used to get from a
struct yt921x_port back to the enclosing struct yt921x_priv is moved out
of leds.c into chip.h as yt921x_port_to_priv(), and yt921x_poll_mib() in
chip.c is converted to use it instead of its open-coded pointer
arithmetic.

> diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
> index 8b0ac5fc8c8b6..38e7879a9f1ae 100644
> --- a/drivers/net/dsa/motorcomm/chip.c
> +++ b/drivers/net/dsa/motorcomm/chip.c
> @@ -608,9 +608,8 @@ static void yt921x_poll_mib(struct work_struct *work)
>  {
>  	struct yt921x_port *pp = container_of_const(work, struct yt921x_port,
>  						    mib_read.work);
> -	struct yt921x_priv *priv = (void *)(pp - pp->index) -
> -				   offsetof(struct yt921x_priv, ports);
>  	unsigned long delay = YT921X_STATS_INTERVAL_JIFFIES;
> +	struct yt921x_priv *priv = yt921x_port_to_priv(pp);
>  	int port = pp->index;
>  	int res;
>  
> diff --git a/drivers/net/dsa/motorcomm/chip.h b/drivers/net/dsa/motorcomm/chip.h
> index 83cd454955ddb..9cd1010eb9700 100644
> --- a/drivers/net/dsa/motorcomm/chip.h
> +++ b/drivers/net/dsa/motorcomm/chip.h
> @@ -989,4 +989,7 @@ struct yt921x_priv {
>  	struct yt921x_acl_blk *acl_blks[YT921X_ACL_BLK_NUM];
>  };
>  
> +#define yt921x_port_to_priv(pp) \
> +	container_of_const((pp), struct yt921x_priv, ports[(pp)->index])
> +

[Severity: Low]
This isn't a bug today, but now that this helper lives in chip.h and is
visible to every file that includes it, is the double expansion of the
macro argument worth avoiding?

The argument pp appears twice: once as the container_of_const() base
pointer, and again inside the offsetof() member designator:

  container_of_const((pp), struct yt921x_priv, ports[(pp)->index])

container_of_const() only caches the first occurrence in its internal
__mptr, so the second (pp)->index is a separate textual evaluation of the
caller's expression. A caller passing something with side effects or a
function call, say:

  priv = yt921x_port_to_priv(&other->ports[i++]);
  priv = yt921x_port_to_priv(get_port(ds, i));

would compile cleanly but compute the container address from a different
port than the base pointer.

Would a static inline be preferable here?

  static inline struct yt921x_priv *yt921x_port_to_priv(struct yt921x_port *pp)

That gets single evaluation and type checking. All six users
(yt921x_poll_mib() in chip.c, and yt921x_cled_brightness_set_blocking(),
yt921x_cled_blink_set(), yt921x_cled_hw_control_get_device(),
yt921x_cled_hw_control_is_supported(), yt921x_cled_hw_control_get() and
yt921x_cled_hw_control_set() in leds.c) assign the result to a plain
struct yt921x_priv *, so the const-preserving behaviour of
container_of_const() does not appear to be needed.

Failing that, could a short comment be added stating that the argument
must be free of side effects?

>  #endif

[ ... ]

The macro is still present verbatim at the end of the series, so nothing
later in the series changes this.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260921203040.1203911-1-mmyangfl%40gmail.com
