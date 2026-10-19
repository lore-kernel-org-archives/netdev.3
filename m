Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792423984;
	b=itE6bVDzEcnienFUfRMudXJj6lgk3HKsglx+XPVRv5RKULnGpWuVcMMLEeSaKCDAmJwO
	 8slykiGEo2LfZX/kRg80twyj7sDI8BVBnSXzAwSsTECA2f7oW1uqoPjErrC2GGjBGBvcO
	 0T+yBMtfjMdZiZ34hRBx0VaIi19hkbM/ILGv/c2Ky+dbKN42dbPiKI0kDodQXRWhtkwrj
	 IELdmP+EzxdKjnKfvV45g+kABGfvDS0iYkB3jTC5DqvIQu7uAgr18YPBvZBl56xPLJfd+
	 IwlszKYDT9CpVv0qCFd2etWxqYx+7xGiiEamxfa+yNrKeN+WHN+GJHDJ4Vi3Dx1nnkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792423984;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=RTU0GqXO0v09/wvq3q/okf4+AOCgqZ21ovd0A51lLqA=;
	b=KtdRsQct0OQUJPabJdQDyBJERcEHrjzuMA1C0jgDKEzgG4ansLiHEDYYHHXFSFVp5jtw
	 bDOw2bqJOSauO+/UArG9ZvBnFUwdunJyw09IiC5YKT8vv2plDUrr1d5SDvgvDsdhWy9RJ
	 EXpJqBN4ZLpdFlPaXmlgRPnfeKY7uAwAak/t6cD0dCHkuuDVvwC/rvoTkYQ2mjqEhJsoP
	 n0YRosFj9cU4pCLeuNbie8Ga9DlLuVEmtne6xKQz0Y1fT7ow/0IEyXaFHfYjpLrqzvUsO
	 0WCYQX0WL7sjE58kals9QEy3P2fB2QZN5DqpuPIRc+U5jXUTFkk/+0SCyJZMM70E7+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rKiBaLiH;
	arc=none smtp.remote-ip=209.85.215.182
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A978606AAD2
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 15:33:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A978606AAD2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rKiBaLiH
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cd6324caa0dso121094a12.3
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 08:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792423984; x=1793028784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RTU0GqXO0v09/wvq3q/okf4+AOCgqZ21ovd0A51lLqA=;
        b=rKiBaLiHA+wAj+IDHNi51Xs9grM09WoPm+Jryti86x78iXrYmwZHGurSps/Ezf9PLa
         rht/nC+yCW9W4lyFiHWeRTlkKkmTbEytKscB+/TT/XVoIyJVP658YmxRhCdlGHIIMKe8
         gJBSi2JDs+cDjFlbwf8anbdTuSxgxZZWQAnXlqZAbvkoIdpzNQQwAMXmCHVgRhl9NPTk
         KrKIwz9JwKqlbhcb2Fmh+ocA/wFBsTpjtOtiZjocNGt1ME6zY1TMBSUJFOLtWFEFCBGT
         +N8FGdT0XhQVHUoVOMVS021IZ3RNDbI4iHuxC+XuSmLo5OhIklT+2w4pb64aO6SvsdnL
         OoyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792423984; x=1793028784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RTU0GqXO0v09/wvq3q/okf4+AOCgqZ21ovd0A51lLqA=;
        b=qi6qLWJHYZzIw4RHBO8dono5L6TMfq+C/nP8LwqyUoyJstvhwJe82H3f0eabQW0G+G
         +xLlPNM1jAM4iiznalmINJRlo+Cht9KcsUwDezF+HH9Q3ApFNlIysQAVosulLNyO7RUs
         r+YvAFwQJE3UpMWhB7vYkv2q2no9kMHBZlNADeci2xdtS3rKbAFYeOtuw/X5G1bxFDYm
         nDJr1OMME3CAYEQiZiYi1pMXX+TO/r4TQRSEe+btDe1wFlGYrzIJtHB7HIgq/ltXzoyp
         fYy9dndswuYaFyRvOmMho+MU9KwKWHmu+DBNzJivl1jTTSUM5M7mhtIJ+4FfhLK+4598
         p44w==
X-Gm-Message-State: AFq9FYI6I5KT3ul9+XV1x3AqQ660cVhU0WUWXhAP4O2GmK07A24TaQ9t
	1j+YvNflb+y0mYcnQT09IOuMNs+wjRx2qZeZng0/49Np0U/w31M9sLWXQLTTmxZP
X-Gm-Gg: AYBFou0I10ESVQuHgLZUTFNNkMWYP3O25w1lw3zVQHV4EcpGOE3l6TMfqADgx/sYuiG
	u0kfbdw24l62YOUiXcFicHbspkAxwXaV+KOFHnkl03culKQX8k6KfKenCy3QkOC1GzewwGJcp3q
	i3mbcSYxnYY42JiK/uJnlpP4fTPrkFLlL85H3Vs2yjtHb+bxnKrE3RGAhv9fd7XwdBzCCgllFAq
	bmwytFpOSa9lyUSR3rADbZzKSZ2pNsab8wc6JQW0enRBWDiiNFRV/EArKP2LqcFLtm9lVfKfaUO
	92MIx8yDlL2cncRGzoW+CiAg+UfHsC2D7+ZPETCKPx4FAqFPqlayMPd7gksEkDZVYwImswX42Cf
	txQjJZXg2XIEVFfLCrfRfpQwjeZct6xYJv+1I3GgbV0lvJWX9oycGufIEJCn4Q/UVDmGMIRjdqK
	LdcsZVicPUFV47mNdZip6KnQgMczUDSQlRD26UvJ7Jfa8ThWOohPP0g/f3BbrzNyaSRmds2OjL5
	fuOArtITpELiyu4cwB+VE3ZDEMqJoBF9tYLnm5oSl4ojTj48TRZ8ajrH1VqjgsFgbcdFaCaUae+
	fg==
X-Received: by 2002:a05:6a00:4786:b0:8a0:1269:651e with SMTP id d2e1a72fcca58-8a04be68eeamr6694821b3a.3.1792423983578;
        Mon, 19 Oct 2026 08:33:03 -0700 (PDT)
Received: from localhost.localdomain ([183.42.136.236])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89f57452b16sm4017801b3a.29.2026.10.19.08.32.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 19 Oct 2026 08:33:03 -0700 (PDT)
From: Qihang <q.h.hack.winter@gmail.com>
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com,
	chopps@labn.net,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	dsahern@kernel.org,
	idosch@nvidia.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v5 1/3] xfrm: run the receive callback before dropping the skb->dev reference
Date: Mon, 19 Oct 2026 23:32:45 +0800
Message-ID: <20261019153247.89957-2-q.h.hack.winter@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261019153247.89957-1-q.h.hack.winter@gmail.com>
References: <20261019153247.89957-1-q.h.hack.winter@gmail.com>
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

The drop path in xfrm_input() releases the skb->dev reference that is
held across an async resumption before it runs the receive callbacks.
The callbacks may still dereference skb->dev, xfrmi_rcv_cb() reads
skb->dev->ifindex, so they can race a concurrent teardown of the
device.  Run the callbacks first and drop the reference afterwards,
like the success path does.

The early drop for a state that is no longer valid releases the
reference on its own; let the drop label handle that reference too.

Fixes: 1c428b038400 ("xfrm: hold dev ref until after transport_finish NF_HOOK")
Cc: stable@vger.kernel.org
Signed-off-by: Qihang <q.h.hack.winter@gmail.com>
---
 net/xfrm/xfrm_input.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index 5ed87d51392a..94de4f698c33 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -496,7 +496,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 					       LINUX_MIB_XFRMINSTATEINVALID);
 
 			if (encap_type == -1)
-				dev_put(dev);
+				async = 1;
 			goto drop;
 		}
 
@@ -779,9 +779,9 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 drop_unlock:
 	spin_unlock(&x->lock);
 drop:
+	xfrm_rcv_cb(skb, family, xfrm_proto, -1);
 	if (async)
 		dev_put(dev);
-	xfrm_rcv_cb(skb, family, xfrm_proto, -1);
 	kfree_skb(skb);
 	return 0;
 }
-- 
2.54.0 (Apple Git-157)

