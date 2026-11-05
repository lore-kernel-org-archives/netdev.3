Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793917283;
	b=js1yO+Cv8nuqqBH4Qrt0RQ7W4Uh+LNoRS/iJORxNZl4CJqSp6lrAfjev7sq4HAR6Uvdg
	 3b+5Act4zHGJ4P9veeuL3iE5HRJhGD/2wzmFng1x47um1bJsNslku9BEAbYSfPfCdaJmf
	 d08kBpnCsr7ihhRRx5b+MN5/oDsNE0uqWFh/2FjFVYfn3CJSBGaSolX34vOjAt20wzYKn
	 lWEjUcldT2ZPqKlvp0wZCGle2XyL6G9ExLMugSlYOvaaeVY0NW5wcdjYSbKRdyH5rMc2P
	 gwQigjPFipNfhHwIAKdfacOJPABYFiCdIejMG2qAqFsi3JbkvTXyYK76vhl3a79gz/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793917283;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Ppas129PwuUiw2Xw8Lcjz7A3XE0ezJjL976wMeb8fos=;
	b=HpPIji+zs5p3//BO/BwbGnSDjRdXIS5ISq+zmjzYWst4P5v1Xag0nca4UV01dQuKbkbN
	 veraKV5DKf2UsCI2hPjgj+1KUkXeJ6cinxBszGhb3EbvTJdU83whlOo68KEUM5tcfVB5V
	 JoHmflu4U9dSFfLKFfC7lteYPRNtVTgaailoKeMTAp4mnZMaMunDUlVxgMvVEBoYRzbNh
	 LJfq/ZofI4Tf17F2NUGtWH3eK/DQ/jUkBEKeVXuabYKpMvn2oW7aUcEDd8bcd6Exbatho
	 J+GYBrABdBorEnt6LXevG9EMeNFn+lwH+n0lL9h9FijpgfRIxVY3fbmWI16yGGjwdAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ei07+fDw;
	arc=none smtp.remote-ip=74.125.229.8
Received: from mail-dy2-f8.google.com (mail-dy2-f8.google.com [74.125.229.8])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E204606A328
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 22:21:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E204606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ei07+fDw
Received: by mail-dy2-f8.google.com with SMTP id 5a478bee46e88-36a6ce64b95so614eec.1
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 14:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793917262; x=1794522062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ppas129PwuUiw2Xw8Lcjz7A3XE0ezJjL976wMeb8fos=;
        b=ei07+fDwVksjzCrwDH10oAlXvu/ahqITqWe8qoe1bC7FXoipcduGF83vODfy+8RG4b
         DbJWVQXwdB8brnziFnLnjzrcg9QWK4kPPYyKAZ55quymum6L0ksay1Ps7FWvjzzcqX6y
         iPpt9MF0fN3iMWibQtwcW8leLr/v9+sxjVep6so4TwLRDz/waR4liSB62fLaVAULBsxB
         vBS2pJJ88SsioL4u5X+jvRzJJaX6RUJXayEyJt6FRrYKh+tUjeZ/AoxNcxveEWC7KdWS
         xoK/Oz1eVOUEi5dzMcZ/k51F48eIQEgec2XnG++AmLK0zNN6LcPEuHcRO877EwUyaikp
         Z71g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793917262; x=1794522062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ppas129PwuUiw2Xw8Lcjz7A3XE0ezJjL976wMeb8fos=;
        b=DAo+NsQ8FKfSlTqFFeWOyVMVOTEzQh/d5uWE5yUZRP6OajS1RRCGOqhByEu3pn2bVN
         gUrU6tQ6mVovSql4c0b1E9fhxCeDjgUOVmQ7gl9lNtWxxRJAW33+CiFmCSxFK3rXd8G3
         jq1yfzP1fPg9JwTIU4YXjg/IJoddd54sVNohYkewMuqoSZ8Zk6cm3Mk+7TS2NGD+2BYx
         +nLqNaly88H1UVTImT3MK1h7McluYVfw6+c/1iGFKxaogEZqQYcnUxHFg96sfgNbwtap
         XI3lT/6daUfrPIetkdjvhXHCkrtoihl385eonoMIJFX7eXPg2hQPIMd+9u9pWDReMjMt
         7Fxw==
X-Gm-Message-State: APuU4Z9FjpS3KflZogGVutTuN++q0YryijybeC3ottFxhvmL+FxNT98n
	+wHLNql2lJsbEtdX4aOVY8+uevxyQNxFTUyvsAEhs7xy6MrlOdx6wcesI6+FLq4uzoE=
X-Gm-Gg: AYBFou1UENHnO1Zsuri+X0BMdwICN103Pa3qeuKvkH2iqcbO1/TltmhngHwv6NLRZa1
	fEaGrl1v+QBHdyeQ27pmZD5BACKI7yTSFbQdDnleOeOC4cNVRiQvFJXPuE2F7o7qAo7vj5bfixz
	E+DUbeXSI8cRWNxVq6rJV/pOkxlQLJquuO0T3SglT/O1MFiW8XNGDfTfD+XE/9PeSbEQgY402J4
	K/8Nb5f0d8UEz2B7wWUM11ixfIZkyr1HcgmV2GqQZK7qyKkGaGhxeuDFf76GeyqR2lTteaNamWX
	bv7uA4PFWGpOlaR5jjoaPRlqV2efaFv/irO2vJObQNK3zXJm+MKnC19bHqIILN7gXVeWxn4ltk+
	ZLhRemEzqLWO6VVKYfP0ruBGgllQpYFWN4SmSKnRnDLhhSZpTqnUiQe9PrUv6Q9Efoq+wulr+2C
	TB3qN83JOHxF/Rc2cFvntj/154V9qcRYcPFZnwpc0Thia29ANPxr72Fpz/Ir4R+NK46f540WHX1
	ycSijCBKWhgMTYboSI+7Mg6+5n7OSrggfwXKXRE7/xUxSyck6/vsZVjf4u/j4xqm2yXKFpCNamL
	7nu/dxAFxHscZaoYGNs9x+DHGUDO+x+2pruPVEsjTJ+k
X-Received: by 2002:a05:7301:1808:b0:36e:f2f2:37fa with SMTP id 5a478bee46e88-36f75443f3emr684024eec.8.1793917262361;
        Thu, 05 Nov 2026 14:21:02 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:61::])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa8e3a718sm39021eec.4.2026.11.05.14.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 14:21:01 -0800 (PST)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	edumazet@kernel.org,
	horms@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	alexanderduyck@fb.com,
	kernel-team@meta.com,
	sdf@fomichev.me,
	dimitri.daskalakis1@gmail.com,
	almasrymina@google.com,
	dtatulea@nvidia.com,
	bobbyeshleman@meta.com,
	asml.silence@gmail.com,
	daniel@iogearbox.net,
	razor@blackwall.org,
	leitao@debian.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	leon@kernel.org
Subject: [PATCH net-next v3 2/9] net: devmem: charge the frag length to TX skb truesize
Date: Thu,  5 Nov 2026 14:20:51 -0800
Message-ID: <20261105222058.944293-3-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261105222058.944293-1-sdf@fomichev.me>
References: <20261105222058.944293-1-sdf@fomichev.me>
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

Devmem TX charges each frag the net_iov size, PAGE_SIZE today:
zerocopy_fill_skb_from_devmem() adds PAGE_SIZE to skb->truesize per
frag and __zerocopy_sg_from_iter() charges it to sk_wmem_queued. TCP
uncharges in bytes as acked data is trimmed from the skb
(tcp_trim_head()) and uncharges the rest when the skb is freed. A frag
shorter than a page leaves the difference charged until then, which is
small with PAGE_SIZE net_iovs.

TX net_iovs are about to grow up to 2MB, while frags stay bounded by
the skb and many frags share a net_iov. Charging the net_iov size would
charge up to 2MB per frag: a 64KB skb with two frags would charge 4MB
and fill the default 4MB send buffer on its own.

Charge the frag length instead, which also matches what TCP uncharges.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
Reviewed-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 net/core/datagram.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/datagram.c b/net/core/datagram.c
index ecc30a6f8302..489d92fe6dae 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -737,7 +737,7 @@ zerocopy_fill_skb_from_devmem(struct sk_buff *skb, struct iov_iter *from,
 
 		netmem_inc_ref(net_iov_to_netmem(niov));
 		skb_add_rx_frag_netmem(skb, i, net_iov_to_netmem(niov), off,
-				       size, PAGE_SIZE);
+				       size, size);
 		iov_iter_advance(from, size);
 		length -= size;
 		i++;
-- 
2.53.0-Meta

