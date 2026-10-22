Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792693810;
	b=Rhx1ZSm+kEXNv2PZlqcWDyZzk4ZGWUrot43ItQzlcLcKgh/a+fGr1HF4HyMIorTB73UC
	 rBBI1PTFuxB+schq3ybEC7xleOYoalrGMYQqYIIlOLGEZ6uMic39CQHVdh9xHfLZo1X7Y
	 5BScoxTaRkuOMkjh9MkjfjeOxP35PkC2dJy/DKJ60DPqlkNGiApMbzndPeC5smeO6JKQ2
	 CyA2+r6J/X54AY7Egste84z9nsjF5zXXxIwnEwhy6jLikYbo3Hc4D2FCBzADhQM3vm3hQ
	 zy5uHZqcjoz8EtgdL4SFu/2Du2HE/tchVKc6G9inQ+sd8G2et1cMbTdltV0odgcHkkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792693810;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Igj4RljkuGt5MegK250la5QtCzyu6KHqltJiHXAXduU=;
	b=Ilv5tmUCxUwP5Z/T2nzcre6NB3+brwFmK3jQG/4EVImUuZryyD8Mi3fH5on3K7+eLIKH
	 qbFJi9nG8nM0AIyHLbCHv/0D6bVlPjmoFwcJoC8RqjZCs1XkPBkXMgknlaxamxBVtJDL4
	 IVRMU1EUuyRnjT06uuBTtNseUq4mDCS0GeqFRha7T4Xm+Pz0lJUNyQJ2TkY7RAxA3CAAp
	 XMHGfN0YE9TKHQCwWA8Dswi7Jvej4chWlfIzYNLSPmu3wrrY/RWkgwf4BpYnO6xcldm2O
	 O+IksYIOdclN3eTQGYCYnvc+H1YnWYZwIo48qnKTEopIY/px3U2kmABxE/U52KnXd/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nebusec.ai;
	spf=pass smtp.mailfrom=nebusec.ai;
	dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=JDeK0DQ6;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A84606A320
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 18:30:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71A84606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=JDeK0DQ6
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38d489b6b71so88590a91.0
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 11:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1792693810; x=1793298610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Igj4RljkuGt5MegK250la5QtCzyu6KHqltJiHXAXduU=;
        b=JDeK0DQ6W/dHWvPMw5JldvGXlvwaShlIMgNnDo03boDWtx23TUbzvfqP70YvlcYObw
         QmvT+mZ0Z3dihzPLKzgQ0CHPesxLuEHR/biGKUF2Dm/zFthTuI1Fx0TVsjH4P8qpgncP
         hxCfhub7hc91HDaagiIUQ6rB8jKQZMBnACKU5P2BXFwVh8oriRoypk2Lgw6uZWp78UHo
         iBwd+SRE0SYhcA/zF2Vdx1EbCIp6shz0YZpjali1Ge8u/pVVI4tHq9NGI14XbSaMwvPr
         ckTG6UG6Jfm+mAUFFuKn6jqWc9KBPhIUUruF0aqBvvTEDCdouRL0/DKPfio/hI/LtSqK
         ZT9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792693810; x=1793298610;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Igj4RljkuGt5MegK250la5QtCzyu6KHqltJiHXAXduU=;
        b=2m/38cODdFhHd8jaq3mlsVFqSi2nalq0HIdXol14oFuC7jW8Nn9HuaXR5PljsjVfdJ
         WpauvdPPti4gqGd37PocUDVF6tnY4PARN0O9xshAnAN6qr/ipWOzxlTjum6mkxuSiM1s
         5QslfNYmbEcDh5p9BACyxkjg93RQXDANGXH3aKoq6ZrusDJ266hawfHjpFyOTo9zjXdW
         6LSizHkiImW1Ix1qAyDhRWfSYzX+9GPv16jSB38BSuEyz4rjmW1NmQdqCR5wQb4JolRG
         BDswDcCbO8X/i6m8FF6JnYbXzHkmQKvRbcJ/hUKONSpr7RzjgWXjPqd9fvTpYbpcbj0r
         QXsA==
X-Forwarded-Encrypted: i=1; AKwUvBw1Ah6++Uv9o9yvoZc6FZawShwZxRGoNo8asFmBFmCOFiqqIcHmlAqKRoaXYH3QmNILmDisGdg=@vger.kernel.org
X-Gm-Message-State: AFq9FYI3RUpOCSrmH7HLohoUXto32UpzU+uSJX5bn+jGFh+Lta+y9QjO
	luMCcL3/B8wcVS0WkVKK59dP0Eg5AiJS+iNO/K1BI6q/nUlkMFP4k+rXA/PUZLSkvazCj3tvXEs
	M/jczgGyWDlg=
X-Gm-Gg: AYBFou2GRN/p1Yd9ZWgVk6tpi8HdrEzb0EHjso4QndEdA9ROe3kT4NZHejenBFTCWbN
	pRxVUvC/6JMg4YOV2byKwY4dZYwGnUIDfmqtlSAKg124vxC6FAFQGfCJ2tdlTkb+SKq2pjihDGt
	M9RBsXaQ68HyH/cLHbMh2gDD69HzsPV26efPv+63ozxieG9WE7BaGH5fuPg7RhJMqgDWoAoJSRk
	6WZZ3o8Nj15J+cnUHmIt1/hwp50qwdwinKst8UfMoGBbAj0IJ7bG8CJ38wv8hKm2qLLhEn5jPWp
	Y2ibyVPxZ2aKTJp8jdgqlsIyAzP/5CBNFELa9gmNVYkyg0VClrgdgDmTsp/pEvaGJbKj/NQkPAn
	sfkDznQqc9ulUGmPC6eQ63/odQMOjvAAzj8L7pNhFP5DDvYL/Yoz0NjVyxVMAeZlyx6Sr2ctJt9
	NQ4ZWchhbNrM0Fe0TmneSsmCMSwY8YnxfyT4hucRXl7Bs9PPYqjORPlJuFIljCK0twebzxkBFGw
	sqXaQNO5C9jsl6g9c7KSPHCj3d31HrINj/DwbiGhGo0wjIoQIJh1l+xH54L1PZ2fdR2
X-Received: by 2002:a17:90a:e7c2:b0:3ac:8897:7b9f with SMTP id 98e67ed59e1d1-3ad86d57f2cmr4742580a91.43.1792693809696;
        Thu, 22 Oct 2026 11:30:09 -0700 (PDT)
Received: from Roxy.sysu.edu.cn ([2001:49f0:d0db:ffab:2834:5ac2:f726:a005])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adcb1d8b55sm22447a91.14.2026.10.22.11.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 11:30:09 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: linux-afs@lists.infradead.org,
	netdev@vger.kernel.org
Cc: dhowells@redhat.com,
	marc.dionne@auristor.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH net 1/1] rxrpc: release IPv6 dst on route error
Date: Fri, 23 Oct 2026 02:29:51 +0800
Message-ID: <986463c1c2a790897e0b7c58fc80532dbffc55f8.1792693634.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1792693634.git.zhilinz@nebusec.ai>
References: <cover.1792693634.git.zhilinz@nebusec.ai>
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

rxrpc_assess_MTU_size() returns early when IPv6 route lookup fails, but
ip6_route_output() returns a referenced dst even for an error route.
Release the dst before returning to avoid leaking a reference for each
new peer created against an unreachable IPv6 destination.

Fixes: 07096f612fdf ("rxrpc: Fix checking of error from ip6_route_output()")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
---
 net/rxrpc/peer_object.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/rxrpc/peer_object.c b/net/rxrpc/peer_object.c
index fa9a406e11683..984ab8380e925 100644
--- a/net/rxrpc/peer_object.c
+++ b/net/rxrpc/peer_object.c
@@ -193,6 +193,7 @@ void rxrpc_assess_MTU_size(struct rxrpc_local *local, struct rxrpc_peer *peer)
 		dst = ip6_route_output(net, NULL, fl6);
 		if (dst->error) {
 			_leave(" [route err %d]", dst->error);
+			dst_release(dst);
 			return;
 		}
 		break;
-- 
2.55.0

