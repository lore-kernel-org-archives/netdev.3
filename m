Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794206470;
	b=y95wsBEn8Ew9ADFo/UNQ0Wjve6K1Y/nXlyr15UB7If1Yuj8hEeKjgia3zNG3jyRwmDcR
	 aRRdum8oLdGrNn94hwsxhqd/hLHwwZLtp21ZMnmLJHAo/eOUWe1UIhIMI8WXA4ya7fM/q
	 wRdNtmVCc8uTZkdbXOxspC9Ex3fqZ3tv8McsGBKa/OjqGTjfyiv23Kh2nzvAB53QbLYQK
	 SliH4hg42EVFgUv8vVg5olRXqU4C6uUKBROm/yqBWCp9cUVH2JVno8AbtAXgNaGN3JDlR
	 mWGxIrpEIDlhw3z9XiRCKRfQflTU4sF9JLpC+inYg6srWpc2gzRQO3bFyKRJ6mLD9eQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794206470;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=soqt50K3rw3+soUYivhJF2vTy49ZFgNuuvn5H0S2lRo=;
	b=Gc1GXi/KsH7tEwBJvb4AUmUNT6KcPl69rmpXKkmwBaOIKTuw50ME7z4g1WUgg3QnEUMg
	 NCmFCIpGXVyOLnrFt4tAXow0Xg3WMhsOA+fubDc7MVbCPCfEXLLb4N3LnxyX6Pz6CTzJO
	 0muoZDt0tx0x7ZyHr5CuCWTXV/KDYmtq8fO4lP3X+iLoMHMAqRVeLPcBvXQlVnUBrZPet
	 3w4yV0LDVI6hn/3EcXgAlSr6wydbh/MFjjXakLxk4Ot5Qy5cpSmHwL9/yQQWPO2tDE+dh
	 YVQcovJN37vFUvdayFjvid/yKD0pXH2okEh5fKW5ssSgozzBvyBIkZDjmUMYiHgw1Uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=JQunonNj;
	arc=none smtp.remote-ip=111.22.67.137
Received: from cmccmta4.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7C1606A31C;
	Mon,  9 Nov 2026 06:41:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E7C1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=JQunonNj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=JQunonNjB0FhU+PTB8co+UPpaRFyfokDEv8w2n0asMuhORSW5JOpbW9aUTZaLWfe+Hk9fHOt2RQSA
	 QGQzgw9poK+dIlDC3WtT0qZs2lR8TJ4YtJUs6IvHLNLeHNCjTJf9esfVKP2yF4X3GX34mDwotserYc
	 +tKl1yrprNvSZhgA=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee46af16b00901-616b3;
	Mon, 09 Nov 2026 14:41:06 +0800 (CST)
X-RM-TRANSID:2ee46af16b00901-616b3
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from openEuler-24.03.03 (unknown[74.82.203.40])
	by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee86af16ae9d21-84788;
	Mon, 09 Nov 2026 14:41:06 +0800 (CST)
X-RM-TRANSID:2ee86af16ae9d21-84788
From: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
To: netdev@vger.kernel.org
Cc: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>,
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
	narcisav.kernel@gmail.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/2] net: do not run out of frags in alloc_skb_with_frags()
Date: Mon,  9 Nov 2026 23:40:36 +0900
Message-ID: <20261109144038.36055-1-yanhaishuang@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179419003251.994134.13120616805502524032@kernel.org>
References: <20261108100617.23840-2-yanhaishuang@cmss.chinamobile.com> <179419003251.994134.13120616805502524032@kernel.org>
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

On Mon, Nov 09, 2026 at 02:07:12AM +0000, netdev-bot+sashiko@kernel.org wrote:
> Can alloc_skb_with_frags() still run out of frags when a high-order
> allocation fails? The fallback just below this hunk has not changed:
[...]
> Would it work to treat the frag budget as a hard limit on every order
> reduction? For example, lower the order only when this still covers
> data_len:
>
> 	(MAX_SKB_FRAGS - nr_frags) * (PAGE_SIZE << (order - 1))

Yes, this is a real problem, and it comes from the same commit: before
09c2c90705bb the limit was MAX_SKB_FRAGS pages, so lowering the order
could never run out of frags.

v2 will only lower the order while the frags left can still hold the
rest. If they can't, it tries the same order once more with the
caller's direct reclaim (with __GFP_NORETRY), and fails only if that
fails too.

pw-bot: cr


