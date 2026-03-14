Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70551CF7D5
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 17:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773510638; cv=none; b=oaT0nJ6LSWGGq+oYWPX3CkFQp424W1xfwW93ZpQLV7x34I8aqd9a7AKwrrl0f8NKqerinw1PlCXNxF6MKRb3yPkZFs8cTdlMBFg1YBpJJbCdzWCk+zHYQTwP8nUQ2uAP4zRgHC5bKDiS0drEXYCu3TGRuhzUZprp8gw+Xpa+A4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773510638; c=relaxed/simple;
	bh=PEZkHJ9wlidfxLVRAwn74I0iG8Zg+E3hE1BNzifW+dI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uU3CkL7yX1tg9/VZMAFIeVADQiJCEoY+D11WbXfCKoAeir2jza/3FyGv/zyrN44hG0LZzwvWwtHZaoJY0QoVK0FwYwBcyR4tRQWEQAeEe6dzB4Ka9BpYTk2Y/nEj1L/QHjx32qvYsMRfKXpEhT6HCV38FNPhBlQWJRATDzXFBFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U3+eoAop; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U3+eoAop"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30714C116C6;
	Sat, 14 Mar 2026 17:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773510637;
	bh=PEZkHJ9wlidfxLVRAwn74I0iG8Zg+E3hE1BNzifW+dI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=U3+eoAopyMLGVMAwZPx5s1nDSyb36FHVeVRb+jMAk20NUVXc30tOgwXQTC2qNLDN0
	 EY7miuDDFb+QZjSmzzdrl/HiB/kpDxkHDDnpML/5MVg3bdlvqz2F7NR6rqEVrP4Naa
	 z/esmc4+SDZQrI9dPeMLYYvf2TqMvM2U8kKrmzR+QMsH/bLpxB+kBajA75uOmzFF97
	 Ut4F2qAj48vULWOc+RWRuD40DwBM9S4NvLnwl1z+VqC6q61JRuTudMKU8AHh8qi1O8
	 eRtzeta9NBr1YiKhvFJsxjaMdWUT+Szy4w7USEjxfXBx7V07vJiVdZf38dnlQXzXz1
	 H2aUAPxZgpcCw==
Date: Sat, 14 Mar 2026 10:50:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, Jiayuan Chen
 <jiayuan.chen@shopee.com>, Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>
Subject: Re: [PATCH net] bonding: prevent potential infinite loop in
 bond_header_parse()
Message-ID: <20260314105036.4d8bacd9@kernel.org>
In-Reply-To: <20260314115650.3646361-1-edumazet@google.com>
References: <20260314115650.3646361-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 14 Mar 2026 11:56:49 +0000 Eric Dumazet wrote:
> --- a/net/ethernet/eth.c
> +++ b/net/ethernet/eth.c
> @@ -198,7 +198,8 @@ EXPORT_SYMBOL(eth_type_trans);
>   * @skb: packet to extract header from
>   * @haddr: destination buffer
>   */
> -int eth_header_parse(const struct sk_buff *skb, unsigned char *haddr)
> +int eth_header_parse(const struct sk_buff *skb, const struct net_device *dev,
> +		     unsigned char *haddr)
>  {

This function has an (entirely pointless?) kdoc
You'll have to update or delete it
-- 
pw-bot: cr
