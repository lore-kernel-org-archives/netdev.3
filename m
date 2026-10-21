Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792577938;
	b=II3B07SA8f4Udm6v1D57kjWJOgfwJlDQJiA4i5hI2kmymwgnj/Asdj86Sjv9fHI8bg3y
	 zir+cC7D8e11RmlOIuqZxtYjDXcNgukY1ZULNB3JeTP25hparRWPi9SN1rsEwB5hPq4oe
	 046SrhIFz+5YOjdJwyYCwmfJuXBZHw6rS4r8RtR9YjM+YWdTvhGwpjwqDmEuoU201KQNs
	 KOHxhvRP/2Tr7Q1euxhwK93C32vXW8fLQ4xA+VZwz8qY2J587j4D5W2ojUyrlRh8L44hZ
	 zspOVwsRwQZjaveygmBkF5xG3GSboFELjaY4zkUFypCkjEJZhI/ulcDtnEf/YSf4R/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792577938;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=i8Rp8y151YKhC3Th2dmfVvjGR6W65rHia14bPEdg4iA=;
	b=1biImizcB4EGMrj46tw9ER5zoqBISCiRm8XUPz0rxaTyHvYc3CP00nEQukbJkyw8bh9b
	 e/KsFtW/FlKkayhmQgdH3UWHOq5woDklvc838GpVaWmNxpVGVHOUnXhnS3zhROtaXGINv
	 dGrRtXQ0DrJCK92VE1k88KPpK0ad4dZpmSxeOa2ER4UmFiK8uMgIpA1XQr+UOa9Rvbomf
	 Y/o4nrCXYRGPH+czuyJxbDKodeJS4xE26KNPPJ3TXmJaAx5hen536vFePOwhGAlsfITr+
	 Vrt6HCaqvPYgDSOPaDT5Kw+8f/P1dVHrLtyVmHC+unE/10SkfetnHAZ43ldj9QdPtwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=B8kEaLiU;
	arc=none smtp.remote-ip=209.85.210.179
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395DE606A319
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 10:18:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 395DE606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=B8kEaLiU
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-89d6bd67045so265451b3a.0
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 03:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792577938; x=1793182738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=i8Rp8y151YKhC3Th2dmfVvjGR6W65rHia14bPEdg4iA=;
        b=B8kEaLiUxkpxiMfQSnOfY+QhJSPcwtTpmbu/SjZuk0nFfFUvBk+tMS5qjp+M52ZJgm
         lq3sAYheGMYLBGVbGJqMbo4NMzv2poTwpjvV47l/DF5YHfW68gR6dD3bL9gKXrTsUoVG
         z5pWCcK9EiMvTbu5Nb5ajTTMkCVWi9L+K1GMZkYNdQISskOcpZTMvGw1EK2/9Q9gCbXn
         7iaCiKYZa0T83YtCyJ7wyKr4r7S4CrXjRq1N6KiKKOJwEYK/npgvHYcMWIQHBtCU7BNe
         6SqVBZKoBVJllfuYaMFeni6L/si4kuREeLXOA9SXBTPFjVIo/8N6imeMn9GPX5ZWumUn
         XXzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792577938; x=1793182738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i8Rp8y151YKhC3Th2dmfVvjGR6W65rHia14bPEdg4iA=;
        b=xxnEqBpo5Ph4Y3uRc6MAS34UcBmz4rCeuxXqVFaEc4EAVJwEmFrkpvcFlPMTjm1lBX
         sNevbxqMTr8ycILGogWWy7XrZFnsute4qL6OvrAGZXYahFbhpEOsQ0V1FkjLnPH0P87P
         l6Y62jJhOg8jIJgEIsYxwsxc4f5AGMzRxMld0oGhShdhgNLbKz3j9RGuWlDmDqI7i8h1
         aKGXFe02zUwYhHXPTpSJRJ53bwY4yjp6/+olvX03SvU62/hUAgu4ItOopjaz7w5RPIyg
         v/RUjPunyYp19lRgt4EdsGHM8/Nk7AJlVjC7mu9f5h5DODtMvxBvZ5MBE9BluC7ZlP5k
         wbsg==
X-Forwarded-Encrypted: i=1; AKwUvBzn2uJ5wM/b/02MqirBxNEnsaP93Pzvt3rnBpzhwzcZliQzq9jYaXTRIBU3ujryQfZbqK/uCWs=@vger.kernel.org
X-Gm-Message-State: AFq9FYJnfNCl1fHvFBgei33RrvgFWx85m5P60GDJTMa2euvyaFpr4qXf
	ruiJbDbRolmbpW8O0Njb4aMKvnT1ocTt2ypHXWCFUbowOoqpVsmtY4Zp
X-Gm-Gg: AYBFou22iYaM7VZppoPGu8lXMiNju8HBaS4U57f6zMJ7Z6NuLN8lv5++Jb7RGXgeQIq
	C1PRxT1aFBuoRICRArcHQ17dxid6q6VGR6vdIgHYiKl3H0CxJ70YMVLVX+hTaveNT3EtojA+kSR
	Xg2/Wn/CvPa4LcCjwxRMYm6jMagRGGYIv99lDTm2SrEgZaaQAF+L2usfeChqstwdixH3pdYQ7JO
	8ZWujae23pA6I5MucohZJa1yNIoEkFlOiJWI0rsnTBK6FM+TgOLlzzDETXRUN8RKKE1eJDz5HVT
	sUphnasK+3xqvrwlKKSquc4yXXDMGJTy1w2ndCWohHZLtNEbBb7xU4XEhLADzbSQLjZXkSkLjWC
	7bUl3u3dfEUeg2TEIGWZz3X2m3aNINcY627tfhg7oplrEwzKpXPuFrJnUB1RAYcCwMKrYLgZabk
	PXCpHOqNEGDESKdgZwTH98M3fcc2cnOHWDJT936ObYcLsPwYCAYk7JJvY2QbA4M26dpyH1FWdN/
	PH8lgqFvN4GrILMBRYl64B93PvXq7EkxBcQhUTQcJmEx0aAGXk17989m5yhWHeFGYMgnus=
X-Received: by 2002:a05:6a00:3313:b0:8a0:76ea:36d5 with SMTP id d2e1a72fcca58-8a089d26b1amr947051b3a.0.1792577937590;
        Wed, 21 Oct 2026 03:18:57 -0700 (PDT)
Received: from TENCENT64.site ([103.7.29.106])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a08960fa88sm693011b3a.53.2026.10.21.03.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 03:18:57 -0700 (PDT)
From: Fourie Zhang <littleddfu@gmail.com>
X-Google-Original-From: Fourie Zhang <fouriezhang@tencent.com>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Zhiling Zou <zhilinz@nebusec.ai>,
	netdev@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH ipsec] xfrm4: use a full socket for local errors
Date: Wed, 21 Oct 2026 18:18:37 +0800
Message-ID: <20261021101839.3797779-1-fouriezhang@tencent.com>
X-Mailer: git-send-email 2.43.7
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

xfrm4_local_error() passes skb->sk to inet_sk() and ip_local_error()
without ensuring it points to a full socket. TCP SYN-ACK skbs can be owned
by TCP_NEW_SYN_RECV request sockets.

When IP-TFS rejects such an skb because it exceeds its payload MTU, the
local error path treats the request socket as a struct inet_sock. KASAN
reports a slab-out-of-bounds read in ip_local_error() beyond the
request_sock_TCP allocation.

Resolve the skb owner with skb_to_full_sk() before accessing inet_sock
state or reporting the error. This maps a request socket to its listener
and rejects sockets that cannot be used as full sockets, matching what
commit 6973a21ee73c ("ipv6: xfrm: use full sockets in local error paths")
did for xfrm6_local_error().

Fixes: b00897b881f7 ("xfrm4: Don't call icmp_send on local error")
Cc: stable@vger.kernel.org
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Link: https://lore.kernel.org/netdev/20260908224856.1591189-1-kuba@kernel.org/
Assisted-by: tencentos-corvus-ai:hy4-preview
Signed-off-by: Fourie Zhang <fouriezhang@tencent.com>
---
A KASAN reproducer for this issue is available if requested.

 net/ipv4/xfrm4_output.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/xfrm4_output.c b/net/ipv4/xfrm4_output.c
index 0ae67d537499..cf6be50485d1 100644
--- a/net/ipv4/xfrm4_output.c
+++ b/net/ipv4/xfrm4_output.c
@@ -39,8 +39,11 @@ int xfrm4_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 void xfrm4_local_error(struct sk_buff *skb, u32 mtu)
 {
 	struct iphdr *hdr;
+	struct sock *sk = skb_to_full_sk(skb);
+
+	if (!sk)
+		return;
 
 	hdr = skb->encapsulation ? inner_ip_hdr(skb) : ip_hdr(skb);
-	ip_local_error(skb->sk, EMSGSIZE, hdr->daddr,
-		       inet_sk(skb->sk)->inet_dport, mtu);
+	ip_local_error(sk, EMSGSIZE, hdr->daddr, inet_sk(sk)->inet_dport, mtu);
 }
-- 
2.43.7

