Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792614827;
	b=hqcofNyWN1uYpT8Gr/ZhuBD0MsYGx+gA0Z0bIGaMuXdZqZ5MtM7rwk9/UtRAxZzslRwz
	 BGddB2Yn997Zuttge5UNFrNA1CyK8bdl5hmcHu3c5oe9XyhLfSbTSxrJjdoCDgxEhK6Br
	 SQVRjv3JhLYYzTjzKDhoaQJOLDXeYwBy6bcxFyydSIoWiF8eHON2O+epNVLadlaAoNqWI
	 qTp0bMI4xfSbqi+E6JDTpo1XCOeB+E5c5dlWMrGh+b4qWBdOL1tfDX5o/5KugzuEEd+TZ
	 gbdmnCuxRHL7cJq2gy5jIzGfh6KUqH54ejvf45a2Ltq4/bGA4HMK1f36mx6DLdtty8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792614827;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=DluZQQKZu2NAKH4Hu7D74hf+x8OtGDSfG/3odA2ccQQ=;
	b=JyY3EbNFVBl903l6rx1F4xby1iY6D5c9Dxt7daZW7YVJTSMekJOMtLdHi9leowGagS7H
	 eZUb3LYpe+P/k/096tFyX3e/qz+XfRox6gPIA8iN/22G7db9agzihVEpLkE+FJgJSzr2d
	 PIwRRli0LWqkYmOBpy6Wg1eFhTe1G2+wSgWD8Bpyj4sPmzbqdZcQK9pgJCD33oACRtUfu
	 lGJBNnfs7yOndih9iN35ojhAB9LonDRZoMwdMYTCkzXC8vlo+EvdvZaF8fqq8RX3vwXPd
	 wqhLBSJrR3GLuiUxDswcI3EdFMlT12CHrytNPnXSsH7peHKXCBO9Bl1NFwV5ebZlEzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DlDZYiAG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C3C606A31A;
	Wed, 21 Oct 2026 20:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DlDZYiAG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E5121F000C1;
	Wed, 21 Oct 2026 20:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792614826;
	bh=DluZQQKZu2NAKH4Hu7D74hf+x8OtGDSfG/3odA2ccQQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DlDZYiAGFngETCjv71rJv+w03lnhQa6yO0w43vIp0K/MhLSZPpLUw59uQpTBLl0VP
	 +tfx9lZetH67RAl7NVZcFWFz3WbRsGQSHpGZj0sMgOn+KQQFwoJCHhyQ5fNjpdlePq
	 74X2EukRAU63iGkU6Gc17totcU7zG8TTE/oTSkJb0VEkKTcpG7BcSL45LETsxPC+GN
	 UDyV6ddXrojPkYjT93oPBe36Vdj111ivTFncvgotTy4btsa2eeoJqFNjwDO60NKGdR
	 bIMGkPCKawzZpxD2OoUcPxTl+F0RiPeAdLDUOvcCwUwpj5t2SHeR2DA4axSDQL2y5S
	 nAbrVm44mc0Jg==
Date: Wed, 21 Oct 2026 13:33:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Qiliang Yuan <odys.yuan@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] veth: set the real number of queues before
 registering the devices
Message-ID: <20261021133345.3e9e72d7@kernel.org>
In-Reply-To: <20261016-bug-veth-init-queues-before-register-v1-1-f48eb2bb25a0@gmail.com>
References: <20261016-bug-veth-init-queues-before-register-v1-1-f48eb2bb25a0@gmail.com>
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

On Fri, 16 Oct 2026 14:51:05 +0800 Qiliang Yuan wrote:
> Since commit 9d3684c24a52 ("veth: create by default nr_possible_cpus
> queues"), each veth device is allocated with one rx and one tx queue
> per possible CPU, and veth_newlink() reduces the real number of queues
> to one unless the user asked for a number.

Please repost this after the merge window
