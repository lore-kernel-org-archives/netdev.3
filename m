Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794343241;
	b=QV6Ei3wKM2O5u8AALnpzWYCskPeyEwqJeJ0ki68XaelqMcFdT7YXN5Qo66bKkgHpwXV9
	 afCBfj5jqyYHFzIOCwRTNbiy3y9ySRs6WwY0Vjvre6ZmQgpM/fTobFhRjCiF3nEi6VAsK
	 Yn/GQpif0Sy18GBe/I4iuX5TauJb1lwoHMJb2J63w6nvs8O8qRBULhVfnCSg7aiFxhn3d
	 XUMGI8l93S9s6TGlPYcABM8b52lW28p4xVkaDQgBhX1Y3C01ZaOa/utEvPS52IzTASmAA
	 654EScBujBCt8a9CRhl/B/rW2cmKsVHKZHs3dmnBmLZEdl+a0Mx73QmSB3rdf1LsCpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794343241;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=K89r/EqgxbIJB4IakU4wt5769iMdNHy5eBMzP7CcDRM=;
	b=L1MSJeKYAPpnzuf7blx/2Oz+R8C2PCeYUqQ2fOkxUeo4BnVn0MCAYshGKGEgOWHhDGmV
	 nLauxGYGEOtP7TSH3TP9E+GVC3GaO/WiF2iOq5NccpZZ7ojz/LbkU/fdaMiIJmG5tOhuc
	 Fc0WPxGQC95s8cDkFF+WhKL2aLBgjj0eb80h1I4XtUpRLyRLfdupY1nFE+0o5dEo3SjcZ
	 WvjJPAVAI4ioJY0TRymmWJfkuA+WznVsbWCGwfxJwK1cAFaXmbayieJaeM71yzboj3axg
	 IhN14mcsTnJoki6wnFLkoFY0AVVfae/ZnBxY7MHck4iSgOIsnZ4nb/jt+73/SCoYuCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JuktnnDy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1364E606A320
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 20:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JuktnnDy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DA121F0089F;
	Tue, 10 Nov 2026 20:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794343240;
	bh=K89r/EqgxbIJB4IakU4wt5769iMdNHy5eBMzP7CcDRM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JuktnnDyV/EI5Q+B7KX9TBKvYaMvDJjkTeT0lXthPYj47oy6pvcazlizl2eQDCUlP
	 Ox3rsNAIbwhkz9Beq/K9n9wtm4cDBurbg9gVmYtS28mR81mIxW4XV5+J0BFSywvf9I
	 p3z8sxEWTjgrAeE1oozBDvaOBLlkSY7246yG7CspjvqO1GYlYEEP20Fo/jqxmwKWzS
	 +15165nvE5inbrC2B+/z2FlzTqK2mgWtYWfYycHG/c5V9ypEVo5rvrGzGeTghg3BXk
	 +xzwjgNRx+GivJj5zmqTysaG159E5LihpNGNVl85XmM9CJVOTMD/QD8fv0nRJ4NaF9
	 utdAXjBfVsANA==
Date: Tue, 10 Nov 2026 12:40:40 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, kernel-team@meta.com,
 pabeni@redhat.com, tactii@gmail.com
Subject: Re: [net PATCH] net: Segment CHECKSUM_UNNECESSARY GSO skbs other
 than fraglist
Message-ID: <20261110124040.2c70b43a@kernel.org>
In-Reply-To: <179372577673.49909.11253315483074546903.stgit@ahduyck-xeon-server.home.arpa>
References: <179372577673.49909.11253315483074546903.stgit@ahduyck-xeon-server.home.arpa>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 03 Nov 2026 09:09:36 -0800 Alexander Duyck wrote:
> Have the validate_xmit_skb function mark any CHECKSUM_UNNECESSARY GSO
> skb other than fraglist as CHECKSUM_NONE, which means the same on
> transmit. The netif_needs_gso function then segments it in software,
> and the __skb_gso_segment function unshares the header before the
> protocol code rewrites the L4 checksum field. The callers of the
> netif_needs_gso function that decide on segmentation for themselves,
> such as tap, are left as they are.

Applied with some massaging of the commit msg and the comment.
Thanks!
