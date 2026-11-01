Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793562616;
	b=ySLpIskojzKlmFvXCq3OCVrWeqxOKJLiODUmv0lHkBnYNj+HUVa1h2EIcqOLTcMLY3RT
	 7/1eWyZTebFhtgVZxJ9JCztebS73ZLHY7Zbh23xDdCE4/g6OWzOX8Pn5+6OuEPeUV6vkX
	 K57phu5PFzzEm0g//8xWvcJUwz4wyxnMz/RTzStX6AHxVxhAWdBkcohwgnYAGrrBbG1gR
	 1NTZmzomkmR33G0IR2uXk8bii4ZRKNnoKRuhnrdQ1o1bLno15f6kGXkOnouuWOlYInE+J
	 zs7OGYk1B06aJBVGTAOvO1sJVP/DSe6+ERYzPFw0T5wNlo8/HcmndYAUw0BovTJgZag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793562616;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=yH5xbsjFG2Q93/74WpO9a6oG0kfWVF9R1es3wue38pQ=;
	b=Tgvh2PLGEhg9IGvSVZvNhdwt8cp1oLsnq5mR+4fKlbAwAchJ/zffE0O6RjXAfMQKDCIp
	 j8rjQgOnU1Dek2uU7x5s5bIIN2sf5tLII8ocTd4gP08fVmsE2CdDjpCZbFTjWzxzGKx0s
	 xrUHwHdqcW4dkOFwYYwZF9K/F5nxi9Ghn7jpXGNAebstpPmoeB0QALfyZU7hd9HYALSqF
	 NYMeDFfVHjG60vBPcaDC7mjh8Y+CY6s5XbVclqn6kPS4ctYK2RmlxusBChjBuPG/ZZD1H
	 3WIOFL7xFHDbqFSdRsjWyHurwgp1yZW0s9Qa7J3HZZSsvrDSzbRUWMV3MtppwO7e2OA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=gHrJNT6p;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160D360A2600
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 19:50:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 160D360A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=gHrJNT6p
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=yH5xbsjFG2Q93/74WpO9a6oG0kfWVF9R1es3wue38pQ=; b=gHrJNT6pSykIjEVfH75dhX2Wxi
	uSrCoqgNq209i6M5Xbrxt+X18Y6TpA9tbImGJgDfKIquWUbzEClA2iaKW+QUp9ysJL4d71V3uzg04
	O7EQ85GzKjoj+a5KwWIEIwZQYXIjpX++Ajmd+FcTZpxdGCrWWCCLGZkjQn4gvFZhgC54=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xNbZF-00DfWP-BV; Sun, 01 Nov 2026 20:50:13 +0100
Date: Sun, 1 Nov 2026 20:50:13 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Avi Weiss <thnkslprpt@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, toke@toke.dk
Subject: Re: [PATCH net v2] net: parse the eighth nested VLAN tag
Message-ID: <eb689b84-eab8-4289-a48d-64f13853028e@lunn.ch>
References: <20261101145841.687905-2-thnkslprpt@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261101145841.687905-2-thnkslprpt@gmail.com>

On Sun, Nov 01, 2026 at 04:58:42PM +0200, Avi Weiss wrote:
> __vlan_get_protocol_offset() starts with VLAN_MAX_DEPTH (8) but
> pre-decrements parse_depth before checking it. This rejects the eighth
> VLAN header and returns protocol 0 instead of the encapsulated EtherType.
> 
> When skb->mac_len is ETH_HLEN, the first iteration rereads the outer
> EtherType, so eight VLAN tags require nine iterations. Check the counter
> before decrementing it and allow one extra iteration in this case.
> 
> Fixes: 469aceddfa3e ("vlan: consolidate VLAN parsing code and limit max parsing depth")

Do you have a use case for 8 nested VLANs?

Have you seen people reporting issues? Does this bother anybody?

If not, i suggest you drop the Fixes: tag and post to net-next.

   Andrew
