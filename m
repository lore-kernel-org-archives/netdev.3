Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF128406833
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 19:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781204404; cv=none; b=YVbBMXtWA8PjT9eSlnggIPC2l5pcitptRIoPCzZWmw91dsqn+W1dpnw9AP1WHUAmghiwcmY7sQypyoKjEoKEml+YhyUt6SgF5D/ffvi6REIZDAetpEQUK8FzhN63evN2oeN2NAQCnlJobnKbmoS2BeChQl/WRO2zfIFBzLUB4JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781204404; c=relaxed/simple;
	bh=0Nb7lqhe86n7CWOSC1kVNN4fJI7qnBO62vYDzQyE8Ss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mEXGvTPF5v5XpV/9E961zfslvljUbUZm2FgyAbbbVNp4vPGr1e1ju3jX5grOL1p13HVMbVP+kZBE78KgMkm96ZK32ieYH7cEgTsBH5nGOtY+su449EdELJOdS7QU9kYv6Kr3sGkEQ/B6Dy8+kCDsnOiLJJAxRPDIyRVHqSeDhyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lGjbjJsj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lGjbjJsj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 262D41F000E9;
	Thu, 11 Jun 2026 19:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781204403;
	bh=utL9w5Cx0O+bVWPGxsCTGtBXWQHpYf7WOBMZmPhOvCk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=lGjbjJsjeoG61SPQ5ToveOK94VYmGqQQ40ijNVYFhvS2i9XPGLNGuM8Dj5FbXe2VD
	 zukQQg/pAR8n2VKOKXeYyhMP9bzPk9ZixmVL4gvvV5YbmyeSNmfyhg6iycIKCIKwmB
	 DIxC+mtAzx9M/9dSVuvJ2FQRNYCOfprFGumdqzgLTpexle09fnlq8O6efI9iDdlJH6
	 z+7ZO0U3OmwDiq2ueYCJQghJCWJR/PeBZL1mgo8xfaCMFqyCyJ8zFWqRJ+XlLngeXu
	 ePjIdpv2b1Pk9279EOwzf8xmCOKriH/ZCnq0P9/e0FWpmSVJ5n7Xw9o1CjeKQGS2Ar
	 9zZaawcWPaQVA==
Message-ID: <c5771517-fc06-422d-93dd-d2059d89e0a4@kernel.org>
Date: Thu, 11 Jun 2026 13:00:02 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 iproute2-next] iplink_geneve: Support IFLA_GENEVE_LOCAL
 and IFLA_GENEVE_LOCAL6.
Content-Language: en-US
To: Kuniyuki Iwashima <kuniyu@google.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org
References: <20260608031701.3485103-1-kuniyu@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260608031701.3485103-1-kuniyu@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/7/26 9:16 PM, Kuniyuki Iwashima wrote:
> @@ -285,6 +303,27 @@ static void geneve_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
>  		}
>  	}
>  
> +	if (tb[IFLA_GENEVE_LOCAL]) {
> +		__be32 addr = rta_getattr_u32(tb[IFLA_GENEVE_LOCAL]);
> +
> +		print_color_string(PRINT_ANY, COLOR_INET,
> +				   "local",
> +				   "local %s ",
> +				   format_host(AF_INET, 4, &addr));
> +	} else if (tb[IFLA_GENEVE_LOCAL6]) {
> +		struct in6_addr addr;
> +
> +		memcpy(&addr, RTA_DATA(tb[IFLA_GENEVE_LOCAL6]), sizeof(struct in6_addr));

wrapped this line and pushed to iproute2-next



