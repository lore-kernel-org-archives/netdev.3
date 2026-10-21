Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792543875;
	b=y/eCju1wZ+QAoG6w3biJTjnX81TlVH7WTnnJZFOOaIABExWymJf8MKEfqbIcDiBaoUvW
	 YOxJe0Z3B1kvBp1vaB7AIKdUALaeFyklAJGSJTb59EuwP+gyAbxIO8f2QMAyTbyNiV1ed
	 D7/hsBuSnjkIfRH/d8nEtRIjpOS+w+SZeiBvsahzWSbktlVUbwHBnN3ihqkb/3uxkgCQj
	 sMB2KEqdISwnorlQXAZ21WnfNuo7en1uEVe+sLxHPZQcBuHZ5CHorGCOeKfkdQ6wYl+MA
	 eMaIhSsn6Gys9Wxgo2k3GBTme6e3oWrv3AqUitxCKTBwiqsjGIqdOVK6X6h9iSwofIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792543875;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=BnbQRXf/yuRTZ/Xyc2wpVRtZXvrt7uElwpDWRhPjGpA=;
	b=5TUeOQaKsEqnyQBpw8HU2MHAq4q28j5up7MpdUHrO3VFvLBHJEWeuj0wp9S60DgqABek
	 IiSC5eoY/aDbTUxV3CqpjH2MpPDpWMK6F3sG3oGxfn7RBT+kOQHlCDcCM0nmJJ/LYd81h
	 GAX8MR9Mz/0Sxf87W9Ql5ieG1Rvd/c90VTURu9qBNppCYE40bCcGl7UlYo4uB9va8o5wP
	 /mwamVACRW46cKrKpgdrJ0+8SLSRZ2AIruRuR5yOwR1tzmyiCtXHlK7OEkb4ZaMadBxx1
	 ezL4e9TUiUW35tVkWp/39k+8rw6XFbEEaVnStK/O8RUCpP45Vl6NtApnJntySXhgVHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G+IoWrCI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBE0606A319;
	Wed, 21 Oct 2026 00:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G+IoWrCI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9DA21F000C9;
	Wed, 21 Oct 2026 00:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792543874;
	bh=BnbQRXf/yuRTZ/Xyc2wpVRtZXvrt7uElwpDWRhPjGpA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=G+IoWrCId6I3cul8W/1ldsyCmrZ2roZxDp56BPtb3ROqCCW6bpiTaipOobCAEKwXA
	 tFNk3u1uFpHC+mg2190fV+HImAh2cPZrMF5oS92H64CPEDH+KOzIAFcHKmYFOQUk0m
	 1edn7XoWBLWtonGw/njuebCtuxpKBOmkUm3auMno227Xnu+k11wghe++LCq/CtZpW4
	 YXacW/2qZMgf9/TChjjRvDJDEX4G3R9ip9umhwFCWb3TCPOim1pSEzzNql9iigaONv
	 zShzLh7qtatdfXL25GbihVjvU01i+ODjz6P9AxkxywIu6q+oN9xXkula0VgPCbgNy7
	 fLsz2rkifxbyQ==
Date: Tue, 20 Oct 2026 17:51:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Fan Gong <gongfan1@huawei.com>
Cc: Wu Di <wudi234@huawei.com>, Teng Peisen <tengpeisen@huawei.com>,
 <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Ioana
 Ciornei <ioana.ciornei@nxp.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Mohsin Bashir <mohsin.bashr@gmail.com>,
 Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>, Harshitha Ramamurthy
 <hramamurthy@google.com>, Larysa Zaremba <larysa.zaremba@intel.com>, Vadim
 Fedorenko <vadim.fedorenko@linux.dev>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, Zhou Shuai <zhoushuai28@huawei.com>, Wu Like
 <wulike1@huawei.com>
Subject: Re: [PATCH net-next v17 1/2] hinic3: Add ethtool statistic ops
 part1
Message-ID: <20261020175113.182b3b92@kernel.org>
In-Reply-To: <0d19828afdc0cec629c8b342cc3f7a0c11ecb1f3.1792378301.git.gongfan1@huawei.com>
References: <cover.1792378301.git.gongfan1@huawei.com>
	<0d19828afdc0cec629c8b342cc3f7a0c11ecb1f3.1792378301.git.gongfan1@huawei.com>
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

On Mon, 19 Oct 2026 11:45:37 +0800 Fan Gong wrote:
> This commit adds per-queue TX/RX software counters and firmware-backed
> vport and physical port statistics to the hinic3 driver. It implements
> the .get_strings, .get_sset_count and .get_ethtool_stats callbacks so
> these can be read with ethtool -S, and adds packet/byte accounting to
> the RX and TX hot paths.

Sorry I replied to v15, but I think my comments stand.
