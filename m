Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6527348C64
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 20:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781208322; cv=none; b=N9SAuTBXrv02Wz2RKREVQcpK6WHHt7E2+6qLvCHzDFPrklhK0NUmOfgwMp4O8372lOBn5vZULHRwz+nyXHy4OX0NA/UF/+U92KnF3EuxH5m9zKsj8D+FZeuMxjBGQOsYQ8LGDtKRBmknubh1nPyLxQHp/3W0K9LD9EabovtjndA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781208322; c=relaxed/simple;
	bh=u59emK5peWqurWifgkSw8mku6RcAHzf86cC7KxA8YUg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ss/gO8MHEjsrGNfO7N4sojEiPlwTCrNG+PnjxQHeaPlh/8oPcO7rRAn0bS/rVfBHwBv+L2aYcn+M+rKXQI1qxszm+vXD3YXOYSFx+45KaT4QZYkK5SIVQmtcZw1ABgc1KSIhKsCd9eQPSQdrBygXCtPrp8hMX6KeAMhuLnP9KlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KLovtA+i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KLovtA+i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6F961F000E9;
	Thu, 11 Jun 2026 20:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781208321;
	bh=u59emK5peWqurWifgkSw8mku6RcAHzf86cC7KxA8YUg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=KLovtA+iN7gzjkouiIhSZLGoTl0QnjNekj/76FyyEjzUpiMduOksqv4FL+F2skJ5v
	 xBPl/uGzWVRu7DASfHU1UV+AA82CECJ7RS1bKK1hRpI+AmlUwVgN9dFvoqYyikItz2
	 iblAUcw6QQslIixm6daUGqXRyQvyJRGa+UngRyHNN9o7MQjR427aMLsXfihZXlraFH
	 yUU7XDG31KAGN6fGvbEhpRS7+fvMKh3lR0yaAATYEcXkaV7flie5FnXJa1i/kVD21E
	 bUDNwnZkRpTNcHWcjVvKSANXmWazESxLvY9ESEKdwprkPbYUtCrwsTLO+ogeF+QBMq
	 VDKjTHaPdEXgw==
Date: Thu, 11 Jun 2026 13:05:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, andrew@lunn.ch, gal@nvidia.com,
 jacob.e.keller@intel.com, sdf@fomichev.me, kory.maincent@bootlin.com
Subject: Re: [PATCH net-next] ethtool: tsconfig: always take rtnl_lock
Message-ID: <20260611130520.350410ab@kernel.org>
In-Reply-To: <20260611200355.2020663-1-kuba@kernel.org>
References: <20260611200355.2020663-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Jun 2026 13:03:55 -0700 Jakub Kicinski wrote:
> Fixes: 6e9e2eed4f39 ("net: ethtool: Add support for tsconfig command to get/set hwtstamp config")

Ugh, wrong fixes tag of course, should be:

Fixes: f9a3e05114b8 ("net: ethtool: optionally skip rtnl_lock on Netlink path for SET ops")

I guess the GET side was also wrong but its harmless.
