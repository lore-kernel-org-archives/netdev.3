Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794449813;
	b=G9gNrymSi3pA9Ht/GDFJhRC/8idzAgOmuory/NZHI9Kt8gHlhiAbEnkquK7VjhRkOphD
	 JxecsKSjait2g1gX6TMixtRKmzOjBf8MBfbLVQ7UPiQNz6d29XdqwY9Ve9XJzwlSrxxmT
	 GI/E9r76MJ923Yf03EMW+k4+2MtM6DpKj1eXafNi92sVmI6YaG7PGiJsD9zUVQTbQRLuB
	 Dds6/sx6I7pvv+z9JcaSPieSgO2CLPjAgUmO2OVzkaOwPyMCKnZXP9ILsLsveOIZDqYcD
	 aF/C4YLKx4kDA3hf3QkGORyATJTsQHy4Ylvota5wbc5WEHNiAdjuasZJ4M9n3ZUK1IA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794449813;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:References:Content-Language:Cc:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=qmgUyfk8WV4aWH8UenZtW/YyeUIA1n0+cWDnJ+tIrdc=;
	b=1aZRDq7DinSIqjVWPcbPjzLXzgRfUXisUXtgmm+8YI92GU5WWSnJuNz80dhJLmED8S0d
	 unUHr4oOZMb8wQphtrSok2mN5qEPQACffEmpMLACfffj4gGhKbgfAh7f+sBmfSp8nCvqT
	 xxhu2J1aQ1ViB6tx1d8zzszkEq9jCsECxqA6STVH6yaLPAPwIxGMfxkqA4pnEaW6v/DbR
	 MVLYy/GhnMKVZDHHneCYmD33KJscTFI4zrZArA10qSWn25hzp83f9kSFsh+GACXNsAokJ
	 4rGNfkNlM4ypUnjdnpihb1V3LCuI9S6choce0Mk7ZQB0vvUS1ZrZ4ZDQDyCRHihBCGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=4X38J56L;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B461606A31C;
	Thu, 12 Nov 2026 02:16:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B461606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=4X38J56L
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:Cc:References:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=qmgUyfk8WV4aWH8UenZtW/YyeUIA1n0+cWDnJ+tIrdc=; b=4X38J56LnvOgYr6B1uVqluZteJ
	hELccqpHkHCpTUjRZwXGISGWno5amd75kaD1jAX/r3v0m1TkLtvinRISxOlFlFiOVlWopISQaNwcS
	s4ZQGxroQS0VKjZkgK+BBxvyUimHE4SMakXpMkSbSWwLhoZSFdWjKVXYWXZd/qGbAEBKOcMwPdaN1
	8Jz2k/iqW5xuEfo7fplG2tUDLhdFSp4p6Y8wPkRcAyuTupuWiPkgwqALRo8bV7I0sX3w7ZMj/KJhN
	+d6AwbYc7882QP/e9Nek3MvWf/S6PITY+ujXW/d0a5CjKLF4sxoPXVroxBxhdk64p+oSydgxKieV2
	eGZAEGgA==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRKMt-00000008UXt-3TVY;
	Thu, 12 Nov 2026 02:16:51 +0000
Message-ID: <cff30946-5984-4d69-a590-3c7291d8f32c@infradead.org>
Date: Wed, 11 Nov 2026 18:16:51 -0800
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Documentation suggestion on Netlink specs: missing fixed-header
 info
To: Wessel Jacobi <wessel@jacobi.pw>, linux-doc@vger.kernel.org
References: <8610ee11-e1dc-481a-9654-11188a06786a@jacobi.pw>
Content-Language: en-US
Cc: Hangbin Liu <liuhangbin@kylinos.cn>, Jakub Kicinski <kuba@kernel.org>,
 Linux Networking <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Yuyang Huang <sigefriedhyy@gmail.com>,
 Donald Hunter <donald.hunter@gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <8610ee11-e1dc-481a-9654-11188a06786a@jacobi.pw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi netdev:

Does anyone know what this means and what to do about it?
Thanks.

On 11/5/26 2:48 AM, Wessel Jacobi wrote:
> Hello,
> 
> The "fixed-header" information is missing for the Netlink rt-route specification docs.
> This is pretty essential information for working with Netlink, and I was tearing my hair out on why I couldn't find it.
> 
> Compare the (visible) `fixed-header` at [1] with the (absent) `fixed-header` information on [2]. The `fixed-header` key *is* present in the source yaml `Documentation/netlink/specs/rt-route.yaml` [3], but it seems it doesn't get reflected in the generated HTML version.
> 
> The HTML documentation would be more pleasant and useful if it had all the relevant information.
> 
> Thank you
> 
> [1]: https://www.kernel.org/doc/html/v7.4-rc1/netlink/specs/rt-link.html#operations
> [2]: https://www.kernel.org/doc/html/v7.4-rc1/netlink/specs/rt-route.html#operations
> [3]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/netlink/specs/rt-route.yaml?h=v7.4-rc1#n709
> 

-- 
~Randy

