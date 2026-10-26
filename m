Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792975837;
	b=qF99QQo3Qw8Q2HMsHPtavrKx+P6N2m6deoq0nS8c8ZallgXv7dHc5w8kiCIllh4QN2vm
	 QEbdRaplCn0s3XLxcefBFA/etF9c1gOYEze4zoZ6tdtKRGwxnVtLbPTw4O1fkcy2abelI
	 mTaqcmFexOxqg59CTexXS5fVdJKaWre5HXEUUa9rpdUtog5daumOLZggPlUlAoTlOBbye
	 JNzj6nq8T3fhddBE1zo/devhJGYkEUHFSXyHm/GgC/PbAI+uITHU1B6fIUqb4C4p4ceJs
	 ZbQ4rbq+u4fTFZLVxwpe4unRj9zuT1BvT8MloJwFnVDMoMZ62k3zZYzi2WiG3f40aGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792975837;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=hKJItMY3kaYlNl5o01G2gU4B2dpN9KdP/5hai7PL+/Y=;
	b=CjDuYB2pfUHKWqJWGv0ZDIkCjDwfyc/jmhHiRg2TySfw/HwUanJhHPU6uUWYtD/mPEQ1
	 cl2ga41ey7WI1w05ft4wkvEARmV0tk1hjXqS39Tv03rDBBJhjIoZ5ee9qMjeyaFHCpchE
	 ar3+IS+NZ/RVXsVUwNIOOPftAXOHoNvbkMy/3JN2RCoLfKTxfWPRIigaISo6O+hYYIDnM
	 8Q03D8cHO1at9id9Ck5N43Q8fkQZC2joAHPAtS4Q1avYDlopD5RQ/ZWe3DygGczedh6QD
	 zYswjTthpnHPddBC2w660e9m6/3gXbsLTgAiEOp01Zv8YeiJBu5ZMMsxB210YAXI6/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=KP70H40N;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3B1606A31A;
	Mon, 26 Oct 2026 00:50:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A3B1606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=KP70H40N
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=hKJItMY3kaYlNl5o01G2gU4B2dpN9KdP/5hai7PL+/Y=; b=KP70H40NKyO7perI+wo3rpfXsq
	9aQuaS0a8CARTRJs+sigOQTxOxlXL0HDfNtHQhcIkK1zycwC6aLC8pqO0LIjd6R12t9v54cmdpOiT
	yFyQIIxAeMM5ClRHOz3xD52x5rvj2nXS+jPO//u2mJNHYuWd+pGXP2QFAJRpyOwraRWo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xL8v0-00CjTU-V4; Mon, 26 Oct 2026 01:50:30 +0100
Date: Mon, 26 Oct 2026 01:50:30 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: dsa: motorcomm: Isolate all ports during
 chip setup
Message-ID: <0fe75791-3a1d-4a33-968d-c5c5fb28f86b@lunn.ch>
References: <20261025144834.2810828-1-mmyangfl@gmail.com>
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
In-Reply-To: <20261025144834.2810828-1-mmyangfl@gmail.com>

On Sun, Oct 25, 2026 at 10:48:31PM +0800, David Yang wrote:
> The chip setup only blocked unknown unicast and unknown multicast
> frames, known multicast and broadcast were left open (though the former
> cannot appear while the FDB is still empty). Before port_setup() runs,
> broadcast frames received on a port flood out of the other ports.
> 
> Close the window by fully isolating every port right after the hardware
> reset.
> 
> Fixes: 186623f4aa72 ("net: dsa: yt921x: Add support for Motorcomm YT921x")
> Signed-off-by: David Yang <mmyangfl@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
