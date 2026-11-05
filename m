Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793863321;
	b=ffYIojGNS7wK76D7yJHWaZ8+e8yXLYnofs2d43SfoNWYq/zOlEGZAPPXFNV35xBLvhLr
	 I5JdMT6CXsaPoMowi2WpsEd4FlANRMBJOv8+VcNzDOzY1zobuC6gdyFAEIb+AG6Iq3t2h
	 fwS5NkA+mYl6b110MVkO2AQK93WIKfsxEVCcJnhjrCiAlPcXdGP9hke9vv0dNJDEu+2pL
	 BLx7LYwj+u8mkY3fsnoBnk5ugA+MoW/pwpQzqOWXHmCjosiOq4wy+bpL9mYvHkUJ6TT6C
	 IEJRVuytwQbV3dkuA0a8asmtrpNVWqcP28bT7hcPC6e8ZM6gRE6Kuz7+BVPH84haf9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793863321;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=aJ5I5AUHhQWGOUxWok4J7X89R2Xim4PY5qy71x7qT8Q=;
	b=iGe2l3ClIIMfF3NqS8As3WIw4PHvNijhfytrxeQvUnWFAUKxg91Rkgfa0l8pAQejK5ZA
	 rHwnsITsmO8gsXRH+Y4eeBy4q+E3s66ORj24ZInDDFuohODOMndNfByN5enL6AMvtbuRh
	 p5iPf6VBC/fXwhcb2ycjvoCV8xMW2yIVf30erGN4dpZNfEJlSLu1RXLd6T+Ju8s7CboiA
	 xFTeA0HFXf1IWdxfSyQsyRqvfRxEtCPF+U6LkY5nMuzWviy7cq5ZYWj2cLQjNOOeVyJi/
	 npc+Sp8zu2FTynLrJWLItHATKXicm3Y0xHLXBeVMj8GYLKfwGKo52AA+JuQZZ/KxCwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=LbrMmMmn;
	arc=none smtp.remote-ip=115.124.28.3
Received: from out28-3.mail.aliyun.com (out28-3.mail.aliyun.com [115.124.28.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF04606A31B;
	Thu,  5 Nov 2026 07:21:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BEF04606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=LbrMmMmn
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1793863307; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=aJ5I5AUHhQWGOUxWok4J7X89R2Xim4PY5qy71x7qT8Q=;
	b=LbrMmMmnJ7BKNfeHTM0T9FVqBaAWuH54zoTxWmc0fq06O+cdn+2Yrh5Jf5ytR98c7086D5CoL5JwEWnO6EJidTmPztT3AwVi6ZJQTdewhB2H3v605hNHeiv19Tv+0nXDjirnLqO23CmyfkRiRBUzt+o35jc6TxaL8xUXara2txg=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07474411|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0366172-0.00105535-0.962327;FP=14550380669610302480|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033040092104;MF=liuc63@xiaopeng.com;NM=1;PH=DS;RN=15;RT=15;SR=0;TI=SMTPD_---.jxQjWyO_1793863304;
Received: from localhost(mailfrom:liuc63@xiaopeng.com fp:SMTPD_---.jxQjWyO_1793863304 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 05 Nov 2026 15:21:45 +0800
From: Liu Chao <liuc63@xiaopeng.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	khtsai@google.com,
	fangxy@xiaopeng.com,
	Randy Dunlap <rdunlap@infradead.org>,
	dbrownell@users.sourceforge.net,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v2 2/2] usb: gadget: u_ether: fix out-of-bounds read in get_ether_addr
Date: Thu,  5 Nov 2026 15:21:44 +0800
Message-ID: <20261105072144.3382964-1-liuc63@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <ausGsH4Q6IDMMtin@ashevche-desk.local>
References: <20261104025058.2650911-1-liuc63@xiaopeng.com> <20261104025058.2650911-3-liuc63@xiaopeng.com> <ausGsH4Q6IDMMtin@ashevche-desk.local>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Andy,

On Wed, Nov 04, 2026 at 12:19:28PM +0200, Andy Shevchenko wrote:
> Hmm... indeed. Perhaps we want to continue supporting those.

Agreed for the raw notation. v3 restores it with a hex2bin() fallback.

>   bool valid;
>
>   /* Try standard format of MAC address */
>   valid = parse_mac_pton(str, dev_addr, ".:");
>   if (valid && is_valid_ether_addr(dev_addr))
>                         return 0;
>
>   /* Fallback to raw format */
>  // check, if it correctly handles the case you want to fix here
>  // I believe it does handle it correctly
>   if (bin2hex(...) && is_valid_ether_addr(dev_addr))
>                         return 0;

It does handle it correctly, and I checked why rather than assuming it:
hex2bin() validates every character and returns as soon as it sees one
that is not a hex digit, and the NUL terminator is not a hex digit, so it
cannot read past the end of the string. If it does manage to read
2 * ETH_ALEN characters then the buffer holds at least that many. So no
strnlen() guard is needed in front of it.

Confirmed on a KASAN build of exactly what v3 contains: dev_addr=ab,
dev_addr=aazz:cc:dd:ee:ff and dev_addr=aabb.ccdd.eeff all come through
with no report and fall back to a random address, dev_addr=aabbccddeeff
now gives aa:bb:cc:dd:ee:ff, and dev_addr=aa:bb:cc:dd:ee:ff still gives
aa:bb:cc:dd:ee:ff.

Two details about the helper itself. The direction we need is hex2bin(),
not bin2hex(), which turns binary into hex text. And hex2bin() returns 0
on success and -EINVAL on the first character that is not a hex digit,
whereas bin2hex() returns a char * that is never NULL. v3 therefore uses

	valid = hex2bin(dev_addr, str, ETH_ALEN) == 0;

> The function itself was introduced in 331a2d82bcaf ("[PATCH] USB:
> ethernet/rndis gadget address params"), and not in the USB network
> core split as your Fixes points to.

You are right that commit 2b3d942c4878 ("usb ethernet gadget: split out
network core") does not introduce it; it copies get_ether_addr() into the
new u_ether.c, and the function is already at
drivers/usb/gadget/ether.c:2240 in its parent.

331a2d82bcaf does not resolve for me, though. It is not among the 104530
ancestors of 2b3d942c4878, and that range reaches all the way down to
the git root, and cgit returns 404 for it. The loop is already present
verbatim at drivers/usb/gadget/ether.c:2236 in commit 1da177e4c3f4
("Linux-2.6.12-rc2"), so it looks pre-git to me, presumably a BitKeeper
sha.

Nothing in mainline history uses 1da177e4c3f4 as a Fixes target, so v3
drops the tag and records the provenance in the log instead. Say the
word if you know a tree where 331a2d82bcaf resolves and I will put it
back.

On the Cisco notation, agreed: keeping "aabb.ccdd.eeff" would need a
parser of its own for a grouping that nothing else in the kernel uses.
v3 spells out in the log that it and irregular groupings such as
"123456:789abc" stop being accepted, so the narrowing is on the record
rather than implicit.

1/2 is unchanged apart from picking up your Reviewed-by. Thanks for that
and for the review.

Liu Chao
