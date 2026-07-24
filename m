Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B5E19C54E
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 05:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784869966; cv=none; b=EFtt5BGZt0sAxhkleGOXakYtv1lr0NpyYrjUwBIIaa7gqHXv5X+qmA5+ILEDKW36/+aqSyCeNvYGXccdzNMmPXrfYZz2K8x2lKAAa+O/GvEaB8R3eHQJdgrUcLlGGGgwom0MBhSeA1HmRYd+kVhrR9nTeC1deo0kkIIv3vS+5Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784869966; c=relaxed/simple;
	bh=BXw66hXGuImIJwHVpe0J6OOzDDbA3l/0X6t5liDFZG4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WB07ugyeN4ClgdVQ0oQ/2yx5yd5qD0j38ZItj6HQkTvUHY6U0TsCivB3Q0uEJUTAQ1U9Pv+7eJPn13M9LOSMedo17AVKP32euoAsyGb9FxK3yx6mWbbAGXkkOG4nBdKqHptrvd3XmphsPZomFmqKU25ZPO28KXb/nJ2FpRt6+N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corvaglia.dev; spf=pass smtp.mailfrom=corvaglia.dev; dkim=pass (2048-bit key) header.d=corvaglia.dev header.i=@corvaglia.dev header.b=JBFy6txe; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corvaglia.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corvaglia.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=corvaglia.dev header.i=@corvaglia.dev header.b="JBFy6txe"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6a168dc590cso857831eaf.0
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 22:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=corvaglia.dev; s=google; t=1784869964; x=1785474764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rN9GaeCC8AYVH1+QdHf7ZR+ma81Q9VJG0dObH93Dktw=;
        b=JBFy6txeLtva6/4v1Eo92uMKZwYQX+BWD/jqIcDSffJi2hAjp7dsqfKRwB8f5BLeuh
         li0N0PPbeNt2Thev4Xx2BMXsD1AW0kb2EgtHE7e3SQ+fuBw/xN3DdEYXf8hXkRFt/OKi
         cbRTAXE+2R/nOaLvM25caHX6wNB0J8THV69dRQKmumUTZlMJXDRfLnThBQ8zUwSXJBxW
         4U0y7AlsF3e/o+L0EfHSAzsLZMCafk2ibQ9jtD1UutMdNbZ33LRSztHKQp3NsFphyOT2
         Z3p8jDp0PFy2iNGyuzJY1HsZuvFouHDQunDHeFfIQ3/BwGBO1FQ36VlGxY+iT5pe8nG8
         ih+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784869964; x=1785474764;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rN9GaeCC8AYVH1+QdHf7ZR+ma81Q9VJG0dObH93Dktw=;
        b=l8iRjO5jNjJglY7w5iAhXLzlTxzLzfUlGii0TTRSUQO5WOglhfpwEPP1yYICyHLt/O
         NUp65BWeqHGuEZvr0aRbOSy9xhJo9v2ndZSkGbx/SCC8WV093w+7oxV1WY8w4GNf6Yrb
         CEbuxEv/QXBxsYaws11Ed1Y5hHcKTJ9C6TEdVJhH7nECHNE8klKgprZp5KroAmBmEI2s
         qCxEzNlmwqBlp4jwvV0JTAq8ZIac2QaX16oCklyoEb02ncdA6CCT8otWQ9x1/swzQr8b
         VsAIWKGD98ZhvROveWgQ/T6C7dm/Ngn8KRvS6CkGyvZObMtU0QVkaF2TwXLeRw/V8sHL
         hwDQ==
X-Forwarded-Encrypted: i=1; AHgh+RqXU3Zr5CAPgPhhcJzS4GEhxdfM4zDMAOSWUlXgi63Rhcu4NkHhzKLcNlpclT5I6czA5lDigls=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/zkmsSQpQEWLhpTUNVdRIwxhQyE9IextGFqz5pvsauMn2rGkN
	6XWjVZJLisZUPD4ierVeEskRDvI8JjcP7gDlGKqyxBcF8DD7cI2SsygEArZbfJT0wNqr
X-Gm-Gg: AR+sD105M8psrKgQmZrMleoO5VNJbXTwB/D3rjmRbOft3mulNFf8rHC5fk74WorjfNh
	8yoJHJA4/Top2lFJaENOuBROuYg1U87AaHKDz7yW4olc2lxOKZbyWCZs2yzXQBDi/evQLKrN2Io
	zwU/C78omIRq8qhd9GbAUbwSn0dGILwDTM12O7z2umoTA5w1nFtFPBqEWXCB2cOq6vRqpT5HXXM
	qjeJKuDgLKA7PHE7GD5rmXNgmxMJuSuapxVTtNSRAcYzF6Wq70ndYfyE3n4xBLyUI2uPGi632Tz
	RIgm9re25J5ul+S4pLbIam8nDtC2OJRH9ndHbrI/sY5SWjE2vLQF6GKtWPe/AcZffQu/8Q+thFk
	4R74LyKbht11BvWXTzC6bixBZXk3KYGRYqSpEDoGiCHi+hDSOr6+2aUWss6ZU2Mip
X-Received: by 2002:a05:6820:2d0c:b0:6a3:7f14:7d05 with SMTP id 006d021491bc7-6aad3fa6f31mr2879504eaf.11.1784869964113;
        Thu, 23 Jul 2026 22:12:44 -0700 (PDT)
Received: from dev ([47.160.132.81])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6aa76c19081sm4924823eaf.6.2026.07.23.22.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 22:12:42 -0700 (PDT)
From: David Corvaglia <david@corvaglia.dev>
To: Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Corvaglia <david@corvaglia.dev>
Subject: [PATCH net-next] bridge: mrp: fix MRP_Test option TLV length
Date: Fri, 24 Jul 2026 05:12:02 +0000
Message-ID: <20260724051202.61946-1-david@corvaglia.dev>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

oui is a pointer, so sizeof(oui) is the pointer size. The MRA
Option TLV thus advertises a wrong length (15 vs 10 on x86_64),
causing misparsing of the frame on peers. Fix is to replace
with sizeof(*oui).

Signed-off-by: David Corvaglia <david@corvaglia.dev>
---
 net/bridge/br_mrp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/br_mrp.c b/net/bridge/br_mrp.c
index 3f7126a7d720..179d2470b724 100644
--- a/net/bridge/br_mrp.c
+++ b/net/bridge/br_mrp.c
@@ -215,7 +215,7 @@ static struct sk_buff *br_mrp_alloc_test_skb(struct br_mrp *mrp,
 		struct br_mrp_oui_hdr *oui = NULL;
 		u8 length;
 
-		length = sizeof(*sub_opt) + sizeof(*sub_tlv) + sizeof(oui) +
+		length = sizeof(*sub_opt) + sizeof(*sub_tlv) + sizeof(*oui) +
 			MRP_OPT_PADDING;
 		br_mrp_skb_tlv(skb, BR_MRP_TLV_HEADER_OPTION, length);
 
-- 
2.55.0

