Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F76581247
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 22:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790203003; cv=none; b=AA3Ibs4GvE8khOjALE9GhIG50LhySwgDu749oM80f4dS07BJmOpweOwf8eHJ+TnghMfR+4OdMifwf+sitI7aE1N6I3Kz8VRihFL1pTvGsgm7zW6kI8iz0xPa4CiW+/SxlwBrf+VbRcbj0kUn8VNRKZUlqY0BBzm8KBWgakBlo3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790203003; c=relaxed/simple;
	bh=m5ZUTmnb23Lh1gQ7pr3/uq+cYwMYAelS+fZJpjVcGyE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gz7fG1JuIy+T01pP5koHlte/u+sscRwTFt3x3hMECVf5Dw2elTRmKUO2Ey4UR8ewNNy8g1NCbRkYX0W1gIG2Vz1usOscO7Q0+z5wT1RM6jCu3gSeJDhQNlCwIlWeom0gRH8lI+rJQTkGyj85/ooZyTxr9kRstmUrPdf0rF6W7ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ExsQLaJi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ExsQLaJi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3F831F000FF;
	Wed, 23 Sep 2026 22:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790203002;
	bh=pfN3+hZU5OEoeAfJ/T7kUfoIo65hKcuGkurf2/+pRnU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ExsQLaJieJKj4aUvOJGn6dlLydRKzeLIwV8DIORCVVm/lzhKYRkbc7472y+gcH+PZ
	 WYP4mTJKeYn7Kq40tJwy1XFI+H3gosd3b2g5BGeprYglEQZAfjY0rLvxiq4lRdXc3I
	 NxNclfXElFLKCZ65K8zOQ2A3EVtRcew9bkgUD/ejJTD17iEIP+hQA6f/SVInSFkLHI
	 a7KThPXbFoPagFFhQTqoyDeZT7/KCb7MLR4f0trXb6z4wVQg1NNulYi+AUvnH8V4Hg
	 K1/wi7RH/Bry9Uy3VmG6yzasnGxo60KiGuY8Ppp+Pr7wDnltBOLWr6F1Q1Tb4QHY+M
	 D+0Kx65Kbozaw==
Subject: Re: [PATCH v2 net-next 1/4] net: synchronize proc_do_rss_key() with
 netdev_rss_key_fill()
From: netdev-bot+sashiko@kernel.org
To: edumazet@google.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 willemb@google.com, horms@kernel.org, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
Date: Wed, 23 Sep 2026 22:36:41 +0000
Message-ID: <179020300124.2160803.13045079527377817@kernel.org>
In-Reply-To: <20260922163458.3900996-2-edumazet@google.com>
References: <20260922163458.3900996-2-edumazet@google.com>
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

- [Low] The new `extern bool netdev_rss_key_initialized;` is added to the
  extern block in net/core/dev.h that is introduced by the comment `/*…

--

net: synchronize proc_do_rss_key() with netdev_rss_key_fill()

This adds a netdev_rss_key_initialized boolean that netdev_rss_key_fill()
publishes with an smp_wmb() once netdev_rss_key[] has been populated, and
pairs it with an smp_rmb() in proc_do_rss_key(), which now prints zero
bytes until the flag is set.

> diff --git a/net/core/dev.h b/net/core/dev.h
> index b757faead4d1a..0127b4d03e525 100644
> --- a/net/core/dev.h
> +++ b/net/core/dev.h
> @@ -95,6 +95,7 @@ extern int		netdev_unregister_timeout_secs;
>  extern int		weight_p;
>  extern int		dev_weight_rx_bias;
>  extern int		dev_weight_tx_bias;
> +extern bool		netdev_rss_key_initialized;

[Severity: Low]
This isn't a bug, but is this the right block for the new extern?  The
block is introduced by this comment in net/core/dev.h:

	/* sysctls not referred to from outside net/core/ */
	extern int		netdev_unregister_timeout_secs;
	extern int		weight_p;
	extern int		dev_weight_rx_bias;
	extern int		dev_weight_tx_bias;
	extern bool		netdev_rss_key_initialized;

netdev_rss_key_initialized is not backed by a sysctl entry in
net/core/sysctl_net_core.c, and it is defined and written outside
net/core/, in netdev_rss_key_fill() in net/ethtool/ioctl.c, which is why
this patch also needs to add #include "../core/dev.h" there.

Also, netdev_rss_key[] and netdev_rss_key_fill() are declared in
include/linux/netdevice.h, so the flag that says whether the key is valid
is not visible at the declaration site of the key it describes.  Would
declaring it next to netdev_rss_key in include/linux/netdevice.h, or
adjusting the comment, be clearer?

[ ... ]

> diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
> index 4b0bc503f9307..b2820f02ca279 100644
> --- a/net/ethtool/ioctl.c
> +++ b/net/ethtool/ioctl.c
> @@ -34,6 +34,7 @@
>  #include <net/netdev_lock.h>
>  #include <net/netdev_queues.h>
>  
> +#include "../core/dev.h"
>  #include "common.h"
>  
>  /* State held across locks and calls for commands which have devlink fallback */
> @@ -1302,11 +1303,17 @@ static int ethtool_copy_validate_indir(u32 *indir, void __user *useraddr,
>  }
>  
>  u8 netdev_rss_key[NETDEV_RSS_KEY_LEN] __read_mostly;
> +bool netdev_rss_key_initialized __read_mostly;
>  
>  void netdev_rss_key_fill(void *buffer, size_t len)
>  {
>  	BUG_ON(len > sizeof(netdev_rss_key));
>  	net_get_random_once(netdev_rss_key, sizeof(netdev_rss_key));
> +	if (unlikely(!READ_ONCE(netdev_rss_key_initialized))) {
> +		/* Pair with smp_rmb() in proc_do_rss_key(). */
> +		smp_wmb();
> +		WRITE_ONCE(netdev_rss_key_initialized, true);
> +	}
>  	memcpy(buffer, netdev_rss_key, len);
>  }
>  EXPORT_SYMBOL(netdev_rss_key_fill);

The same placement mismatch appears to persist later in the series: in
"net: ethtool: generate RSS keys that spread flows over all queues" both
netdev_rss_key and netdev_rss_key_initialized are declared in that same
net/core/dev.h block while being defined in net/ethtool/common.c.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922163458.3900996-1-edumazet%40google.com
