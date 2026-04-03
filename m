Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C7017736;
	Fri,  3 Apr 2026 00:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775175144; cv=none; b=sTvOj/MZcA9FHGb2knz5pC4fNqfXobwO66y8jREMCA1/Dc0DJ+opQDmeUA2CX9sRQ44x+QUtWCtOHUN5WRdya1BNJKs2gAEWlU5pS+xnBbRAsSJ8q8LkZab4w0zRegBoQc9zHsOG995C27aIFLqdViLVOW6rq2WCx4SokcrPCow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775175144; c=relaxed/simple;
	bh=i+/ISfSYfqCyn+anWtiB+b2Rtwf+dbgjmgQGI7nKVeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rQl3nDeqppjWsZJqY/iA/lqctdUBzbtBTx8vC2tPewjQzQwh8hfcKGkR1IzIVc3LH+CYz+fZqAMVIkwP1guTfbGiQTGPu4RgmYPRCEeufQkE1a+kb5dyi4ZQoCQAxtdTW7Y4Gn1tu+rtwViyeA2E3RDFHDvJDb0lFWybJ/1R/zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=m005PCei; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="m005PCei"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2EN6iux/VoOfaEaMLnny/ntmP2/5SvczvmRSZemIB6A=; b=m005PCei93Y8p9Pxm/cFlOr7NI
	06E+KZBbboW+v0MJRREvNOXbMQyXWSa//NpQJzypYoaO0KGegNFuxVNzDP++s+HZ+n28FK382zqLk
	0XrUq7Rff1l2gFvkNvmUTuiFoCU8PZqh7AzwvkQJqHYsmKLIhtUoFSXzrGhtJ5gdxAX0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w8S8v-00Eaap-DP; Fri, 03 Apr 2026 02:12:09 +0200
Date: Fri, 3 Apr 2026 02:12:09 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <vladimir.oltean@nxp.com>,
	UNGLinuxDriver@microchip.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	Vladimir Oltean <olteanv@gmail.com>
Subject: Re: [PATCH net-next v2 1/4] net: dsa: pass extack to user tc policers
Message-ID: <eb280854-6bbc-421c-9aec-a813fff989a6@lunn.ch>
References: <20260402223437.109097-1-mmyangfl@gmail.com>
 <20260402223437.109097-2-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402223437.109097-2-mmyangfl@gmail.com>

On Fri, Apr 03, 2026 at 06:34:29AM +0800, David Yang wrote:
> Users may use extack for a friendly error message instead of dumping
> everything into dmesg.
> 
> Make the according transformations to the two users (sja1105 and
> felix).
> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
