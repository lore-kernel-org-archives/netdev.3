Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694943E3160;
	Mon,  5 Oct 2026 21:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791234989; cv=none; b=IZ1YeoaLSLfBvgJvYXQP96qfCw8RQvIty1isDu4aCjik1GQRTkyTwcfV85t3NUOPH/RF40+BW9oQlH8wctcNdDnnBFW0gmlNMuUpn5p1oTRolrRCo/0csAoO1ASMMlBKKZkZ2G4vzWd5iR0UXnHxoK/RChq9tzr30g1jq0kJn2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791234989; c=relaxed/simple;
	bh=3AUvzXDQL4kuSbQFhArkXddzAXsMmjRZtgwD212he/k=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sqpKnCwQ1vKE7L4vOBi/Fy4X1ASitI/QVqXKi3OniA8p8jZo/jiuz5Em8VLkMOCEo9d+nHl49YUZQ0TLwUq/HD/G5PdwWWe3CjOt/7i3O8979L9b5UZzlbWWYSjEA1Bq+GCbowGQRNZVSVz9OFk4BR+cqcWqSfQFYbgGy2swleM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UZpHJZ3H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UZpHJZ3H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58D021F00893;
	Mon,  5 Oct 2026 21:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791234984;
	bh=JUuzn4BozKLyD2U5Ray7RjZjsj0+RJHYfNsNSjzHUEs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UZpHJZ3HNCgYAvGjg3sfumYuwKuhidRMzRghCfSmUorILlvOZm517ldoYPlpuIJis
	 wdcbqKkVSIi3/871dEBXwjItIPNJNbHOWiidbPLbRlh56+Yrdy8mnKETzoYY4g3PXw
	 JVfu+4rY5E1z7t2PwI/KzSObJsPMcinrZdZyhorzd6+YnlCGKJUpQh3upELQrBduSk
	 vXgXGvYYcaCEa7vcvvlxX7uoL5WEALWUIK9bzJzIwSPPhr/3V0uCPRC8JscXzrnsfS
	 97OKyo5aSUYukZAXrtVjei2O/X5HszMzlXGraQz0dcUycl+iCtKoPh3goXkVSVJP77
	 LQ8c4BIdKErvA==
Subject: Re: [PATCH net-next v2 5/5] net: dsa: motorcomm: Add TC prio support
From: netdev-bot+sashiko@kernel.org
To: mmyangfl@gmail.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, linux-kernel@vger.kernel.org
Date: Mon, 05 Oct 2026 21:16:23 +0000
Message-ID: <179123498388.434549.1033733684417706688@kernel.org>
In-Reply-To: <20261001204851.2576101-6-mmyangfl@gmail.com>
References: <20261001204851.2576101-6-mmyangfl@gmail.com>
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

- [Low] The new comment in yt921x_acl_rule_ext_parse_flow()
  (drivers/net/dsa/motorcomm/tc.c) says "map 1...U16_MAX to (ACL_ORD_NUM…

--

net: dsa: motorcomm: Add TC prio support

This commit maps TC flower priorities onto the hardware ACL order field.
TC priorities that are multiples of (U16_MAX + 1) / YT921X_ACL_ORD_NUM are
scaled down. 65535 maps to order 0, and every other value is rejected.

> diff --git a/drivers/net/dsa/motorcomm/tc.c b/drivers/net/dsa/motorcomm/tc.c
> index 95ed0f245b1fa..c5581e85208f3 100644
> --- a/drivers/net/dsa/motorcomm/tc.c
> +++ b/drivers/net/dsa/motorcomm/tc.c

[ ... ]

> @@ -1042,6 +1045,20 @@ yt921x_acl_rule_ext_parse_flow(struct yt921x_acl_rule_ext *ruleext, int port,
>  		return -EOPNOTSUPP;
>  	}
>  
> +	/* TC prio can't be 0 & TC lowest first -> HW highest first
> +	 * map 1...U16_MAX to (ACL_ORD_NUM - 1)...0
> +	 */

[Severity: Low]
This isn't a bug, but the comment doesn't match what the code below
does.

With scale = 65536 / 512 = 128, the only values accepted are:

  prio == k * 128 (k = 1..511)  ->  ord = 512 - k
  prio == 65535                 ->  ord = 0

The other values in 1...U16_MAX are rejected with -EOPNOTSUPP. That
includes prio 1, which is where the comment says the range starts.
Ord 511 comes from prio 128, not prio 1.

Could the comment describe the discrete mapping instead, in line with
the extack message "must be a multiple of %u or 65535"?

> +	if (prio == U16_MAX) {
> +		ord = 0;
> +	} else if (!(prio % scale)) {
> +		ord = YT921X_ACL_ORD_NUM - prio / scale;
> +	} else {
> +		NL_SET_ERR_MSG_FMT_MOD(extack,
> +				       "Invalid priority %u, must be a multiple of %u or 65535",
> +				       prio, scale);
> +		return -EOPNOTSUPP;
> +	}
> +

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261001204851.2576101-1-mmyangfl%40gmail.com
