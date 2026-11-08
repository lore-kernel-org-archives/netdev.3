Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794132624;
	b=YIvixojc9902cZ5oerCWzFQJdtSajR7xe+Rxtqv7D8iyBLHhewWTFj16L7AN+cbREL2i
	 yQbjw26r6i7p1EtF6F2hYcqARqZ+pVRHQW1H3IhYmMPZ4++awE7844PEqPxnGaRGKdeAF
	 0L/VfgO2NxquflKNXO6QNmFu+qNrpmM3fbTW1LQENTh7GLW4q4hrv6S1nKLVdWQo9rTRA
	 Ld3Pi+YxRQrJFjk9H7GVkfNmqfmGrv2dUzCHUFwpwq3G6RQ4O6Cb19uz31cLUVDKMJtGX
	 xT3IffKCi13cmz3uMsqVibDEtd+DH19HLuvTpvjnwwjakbfz1P4Y0tQv6mAo0HzJVhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794132624;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=DQncBadONHRj2q+zZnkg8jvkUCgEUHfc66wdEXV5FgQ=;
	b=qDxfcwTN3yiyaErwXzHY8j4Aw+gG3bgYerGtoj2P0uIpPQz1Tav4QYn6i/Zoc9to8I3N
	 CRVHbdCa3S0Vd5f8BVtZODo+bDUYLmc0Hxru86J3GGbcsOapUStvqRxaEam0Dg/OVm6xQ
	 j+3Xp31eNA7jtw9yg8jRh97/a+vzg2ffuxFB+be1hs1fUc+pnzX5xhE8b2P6cNU24F0nu
	 +tXBBFjOJnSBBhikA9V8uCwAeS46Ubt+SUieFKH/eg+FeH8Ohv3tMtrYn0GxYxjltOKT0
	 X2ulCWHbcb/8XVLhZQ1MUqiBpVVmxHt6L94xz9eDXLRLDnMG6JVMzMZCcR1csDtjhdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=a3hZCX5r;
	arc=none smtp.remote-ip=111.22.67.135
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38BD0606A31C;
	Sun,  8 Nov 2026 10:10:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38BD0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=a3hZCX5r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=a3hZCX5rmUh8bxvM7pAyA66UB0eCn0CKw6YP219RkxyJ2IElibeoNNOY1XmljQWMNiNtDTDIX48v9
	 zYWu8TxfemsPIsCT9KCP1AsY/IE1jsNAg3vHGA1gbkeLq0eYwdP9wj9LQoC6v8EqNAcvlM9grXOy9R
	 HkzmHsfBPh5Ckjyc=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee36af04a84cfc-872f5;
	Sun, 08 Nov 2026 18:10:14 +0800 (CST)
X-RM-TRANSID:2ee36af04a84cfc-872f5
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from openEuler-24.03.03 (unknown[74.82.203.40])
	by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea6af04a79f5c-64787;
	Sun, 08 Nov 2026 18:10:14 +0800 (CST)
X-RM-TRANSID:2eea6af04a79f5c-64787
From: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
To: Narcisa Vasile <narcisav.kernel@gmail.com>
Cc: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	willemb@google.com,
	mst@redhat.com,
	jasowangio@gmail.com,
	eperezma@redhat.com,
	willemdebruijn.kernel@gmail.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/2] net: do not run out of frags in alloc_skb_with_frags()
Date: Mon,  9 Nov 2026 03:09:44 +0900
Message-ID: <20261108180953.67715-1-yanhaishuang@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <avAwu/1w6+2TJoE6@gmail.com>
References: <20261108100617.23840-1-yanhaishuang@cmss.chinamobile.com> <20261108100617.23840-2-yanhaishuang@cmss.chinamobile.com> <avAwu/1w6+2TJoE6@gmail.com>
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

On Sun, Nov 08, 2026 at 12:20:11AM -0800, Narcisa Vasile wrote:
> I think we should decouple the two parts you've pointed out:
[...]
> Should we also return -EMSGSIZE when header_len
> is above the kmalloc limit, like it already does for an oversized
> data_len? I'm not sure whether the errno change is acceptable?.

Thanks for the review.

Agreed, these are two separate problems. I'll keep this patch to the
frag accounting, and reword the changelog in v2 so it doesn't suggest
that it fixes the vhost spin in general.

Right, for larger frames tun_alloc_skb() moves everything above
MAX_SKB_FRAGS << PAGE_ALLOC_COSTLY_ORDER into the linear part, so once
that is above the kmalloc limit alloc_skb() can never succeed. I'll
look at that one separately in tun.

> nit, feel free to ignore, this might read more simply as:
>
>  /* If splitting the rest into smaller pages would need
>   * more frags than we have left, use one larger page.
>   */

Will take it in v2, thanks.


