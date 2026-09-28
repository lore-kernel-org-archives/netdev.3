Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F1C3822AB
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 18:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790619365; cv=none; b=ADem7q0uOrz+b6ESK7giw6s5xa1GAWM0P8xEU2NdkXQ6bLtk89R8nLSXJIANLm+xd0IDCzTqBVperZl7g78pnWhm2ucjn5zCoN2GigU+xwmGDeLtJIR379pFrWY1YoPhoesyZmGaOYbuDyTYcx9Dhn/ixk1v6L15WzNdIY+Hp6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790619365; c=relaxed/simple;
	bh=OoSLjIva31NX2G7dqpTDp24Gpk518IUIwBGucUuDf4E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ap94BafOogHSDQQjh36OZNetrarFlGZ5ZsRzQv+3wxDEER5qblChKr/RkyaByD7ffECyWHoTQI/yQPJuIzRbwql9KSe9BSVaWtHuDSlNChM3+NhqZYo0dMnrpR1t7jTM/haYLb/nLNMrgiFivg36rb63kIuNhoXM/tnESjNwx/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net; spf=pass smtp.mailfrom=blockcast.net; dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b=jBfgUjqy; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b="jBfgUjqy"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843c3ea1f6so1843622f8f.0
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 11:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1790619362; x=1791224162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=m+lSEVdBGkYWRtyYIkwFn7lSO45jTQISO9qTUdyMxqA=;
        b=jBfgUjqyW+oeyOu4WrKGM+9lXUADuzsKoL9UZdHFA0QaA3DXzswWmS1nVhqteV2dDC
         yWCO/arjQaIFg8JVYD/GXM7WpEeNLmNK0utMnuCz4kvQqftrltq1DYZ97AlD0Qp4A44o
         3gMnOwrtU11GV+sniOZcEZrw0T05qCMfXP13AqcUe44k8sAd++DnZNhGqwpeZ9Ux72YK
         bU8r/SHOquD3VM4r858q6wWeZJxccJiB728cdN8VLdAwhFMDeP0wVbv6NBHWjEnZV/7q
         /OFhsOtFD/tA4IxGihHuiSiqyYcN7vRaLaKYdKj3NTCOF8xszzQ0HhzIDxm24/PjtYx7
         uGNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790619362; x=1791224162;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m+lSEVdBGkYWRtyYIkwFn7lSO45jTQISO9qTUdyMxqA=;
        b=2V+A8t5LhJCs7L/GYWvI9h66VhjU7V7I7wEy74aZoPTuH8K60WBVsyaJPV81zIDAzo
         Xe1wwbd7Lo7I9qlyBaCHWsoYpXUE0WoWSHdta7u5rJJG44RSYHBD5oIm1CfX/IIkm+bI
         2J/Lwm/kaTpSdZrR0t2wI2W8HjOR23Aelf1nCHBi2kq9gJ8cO5yMNx7yAw4fQ8schlZA
         h7kW/7mhbz5T5I/++qI4s2YM6rQnWcBK9nxl97G4EGLoi9of0rp5auwlc+Po/34lPk/U
         hnZ1wq/L5qUvRKsihzYoxIGK/Xy8V57yBQn3hyZJyaXARtNVkt/W6F/7I3gmNJqUkbCF
         NfVw==
X-Forwarded-Encrypted: i=1; AKwUvBzvpiUW4bwEco5icmfCH122NIhB41ikcw7tD6KzwqfBKlSEmQE1uvnTWwjWyA6FPApqpe3oCpI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKuDplyAfCH3hm/LV1+jHeSyfjFh7Yw5dA/bNKWjSkukZYnV5OU
	v8wfhxmNK/ujpoWQ5JTS9U6ibBd66khWAnnNIQiu2fAZfFxu1adxSoiZ9pkbeUCJtdM=
X-Gm-Gg: AYBFou2SUMAqW2gvhZsIEaT1HPlt/lCZncPhcpWKk55QTN8wC7jzD+HWNoLGor7x7qs
	0EUSiR/z5WJnIz+SYe7jdgKy22j6MnStaQEHp5JPHiMEP5kmnnCyDt2t+k2sJQDryOhp6l5X0xy
	sNZBh8jtJHhIkSxDIC8Z6tr5FS4UsqWpsbjpNlJG0kuUSnA14gmd7wOtWIjJn/b7UG8EZQDvQsu
	3ZBPBJ/UhLg3peASTlUkzG8bGnOYP76ilPO+JZg6otmpMepbVZLCafyljuLAZpIXJ3PUTRDwIrX
	oHUF0xFgAJfRp7hONzTrw38gcrbUm6tdoXZC51yoQ4FL4ND7Z5AJldrBttT79GbwnAi1zqB44GU
	VmhpY4TJQdnfds7OgQ9HrLVhEum2w8Ok5kCalPlazmiCgY4VLrWZo80PplJx4mCWQ4jNEhRQRJe
	z1xO8VQDwtc6tCrolnPU+R3b1cS/HhOEbF2dN3HbJRHds/Qw79Z01DJaOVVl4OhNv8yWezS7a+q
	IQCt/anBsKb0n7mP6qXeEXnLaG/BO1EgXRK+EdFnjSZaQuYGqC4hwBcW6BRb3blFkmjh4YJhP/J
	xg==
X-Received: by 2002:a5d:5c05:0:b0:488:8850:50ec with SMTP id ffacd0b85a97d-48888505290mr13055999f8f.46.1790619361500;
        Mon, 28 Sep 2026 11:16:01 -0700 (PDT)
Received: from localhost.localdomain ([197.51.38.79])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a84205esm28650047f8f.37.2026.09.28.11.15.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 28 Sep 2026 11:16:00 -0700 (PDT)
From: Omar Ramadan <omar@blockcast.net>
To: Taehee Yoo <ap420073@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] amt: pull the AMT header behind the transport header in amt_parse_type()
Date: Mon, 28 Sep 2026 21:15:57 +0300
Message-ID: <20260928181557.85796-1-omar@blockcast.net>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A gateway's encap socket passes ICMP errors to amt_err_lookup(), which
calls amt_parse_type() on the quoted datagram to see which AMT message
failed. On that path skb->data points at the quoted IP header and the
transport header at the quoted UDP header, and icmp_socket_deliver()
only guarantees the quoted IP header plus 8 bytes, that is, up to the
end of the UDP header.

amt_parse_type() pulls sizeof(struct udphdr) + sizeof(struct amt_header)
bytes from skb->data, which on this path stays inside the quoted IP
header, and then reads the AMT header behind udp_hdr(skb). An ICMP error
that quotes only the IP and UDP headers of a Request, the minimum RFC 792
asks for, therefore makes it read past the pulled data, and past the end
of the packet when nothing follows.

Pull up to the transport header plus the UDP and AMT headers, as
vxlan_err_lookup() does. amt_rcv() is called with the transport header
at skb->data, so the pull on the receive path does not change.

Fixes: cbc21dc1cfe9 ("amt: add data plane of amt interface")
Signed-off-by: Omar Ramadan <omar@blockcast.net>
---
 drivers/net/amt.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index bddc24e18..0277e4cac 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -1310,8 +1310,12 @@ static int amt_parse_type(struct sk_buff *skb)
 {
 	struct amt_header *amth;
 
-	if (!pskb_may_pull(skb, sizeof(struct udphdr) +
-			   sizeof(struct amt_header)))
+	/* skb->data is the UDP header on receive, but the quoted IP header
+	 * when amt_err_lookup() parses an ICMP error, so pull up to the
+	 * transport header rather than from skb->data.
+	 */
+	if (!pskb_may_pull(skb, skb_transport_offset(skb) +
+			   sizeof(struct udphdr) + sizeof(struct amt_header)))
 		return -1;
 
 	amth = (struct amt_header *)(udp_hdr(skb) + 1);

base-commit: a7bfaba4823e3c165bb2004c74eff7c096672bc7
-- 
2.47.3

