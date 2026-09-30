Received: from mail-pz2-f39.google.com (mail-pz2-f39.google.com [74.125.228.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2C04BD0FB
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 11:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790767740; cv=none; b=m1NOQJS4wtZJEa262zzr1288XGSdqBqgMHk6RvxTTZ4+s8R2rEIZ82VcKEK7c1QXb3+gNi3UAILCOmos0KvLuHw//GDYKQyDJ2FodlAqhMpvpEPpp52IzoXJVAB8dhD/f6FqA8uU23qngRFk/HvndXnehzriyGEsga9vQByTSKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790767740; c=relaxed/simple;
	bh=s7RHTsXfEOg+gwqThuTUUiknVQDtwJu49s4s8eAwliU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lepmorRuv1MtDF1zOosdwj1+GNBbqWVPDCZSMCG/egF/7h3gfU9Po9EufmXqgAVls/WnMQDIaHs9J47i8XHCA8WeD/kOr3F+V8wtDJiurwhMhyjVlSvlUYau7GQbttRu/PoAiozIFNw0kLk5rtzERGMLHwuQmfWEun5qB0qxmao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b6HK6dgz; arc=none smtp.client-ip=74.125.228.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6HK6dgz"
Received: by mail-pz2-f39.google.com with SMTP id 41be03b00d2f7-cc7979d1dedso1658329a12.3
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 04:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790767739; x=1791372539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IEgFM2qnyZ26U72V739p3+vOc5ZxhizwkmlzBdho0QE=;
        b=b6HK6dgzzxZ2RMEkcKA8yfjFWWf2H5jHbXKj9myYLaxpdKRuZHXnCQuqirX9MDjQ1B
         XOI8ROM1jW4WT3VGSUt8gTuIEkhdRhnlWTCIA0JCYHd4Z4iTifGxNJarroHEj/iagz2O
         joHp6EMFZe9zaE1HqVLy0XUJcEQ7aph4lfYrtIX08PNIn6rB4xn9WlKSKhb+sWT6B9qJ
         y9vPqbl2O57Dj0FO6sOmhf5Ndl2fogbnEl2N0J6Hpx4/onrs5NysCnvsRf/bdS1cGFAV
         X0oanAwP99Nw8eCyCLk6PrLz4vS30q5RxspefbG5/UinKyOxBnnVRvVn8aBWRNUY6cR0
         WrgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790767739; x=1791372539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IEgFM2qnyZ26U72V739p3+vOc5ZxhizwkmlzBdho0QE=;
        b=Pnd0EXLIEOZ6bU3vY6PFc0XntIsITLPUNbwM5Z0+JtCEUO/W92fkgUUR9Gf+aKfH3U
         sq3nsZSH2Ypj9LcWJQfvFDsrFuymIaQYqrZUBkorrpzmxzlO8hULJh9pHqf6p13c+D3s
         eI0bZUiENgJR/v4p9e8v49Pa7USGfslBC3ocKqwuzL0xIT5CzVgojWgA/WAsu0i2WV8N
         NvHyN99b0zjMq8/mXGSBKsxcf95Pn5oml2yZukb3VeZRCoxf615qcxZch+0+CMWRLn0n
         723Wx3KGgjwdKchMt8LBByjg4dZQPvfSR6qMo+zcM/APB+TV2sbMZhwU2XeUtw9IGlqT
         flPQ==
X-Forwarded-Encrypted: i=1; AKwUvBx5DFMkkrVcInUaVaWtggy7sxTDjItfcZIu7xTOVgiBEmKNac2trTp0nY8NL+ztMQHC38CLFJI=@vger.kernel.org
X-Gm-Message-State: AFuF++l2qnj/q2mxQ7uy08mwCefnXoecIo5gxMBCkN2MJ+gH1X8ol10L
	7p0YuKFGyXzUKpKhvbQSJ08B7TnUS0bpVolpqRqbgbZlwEFRWkGl/1ny
X-Gm-Gg: AYBFou2B8s0Jy12bQC80WV9uEMGtUTcJQYPlSir48ZBE0gUnqAzr21b2IRvdufAgGzT
	ys4DbCpzfpZ30Uctc60y4OKKIv2INlGQqtH1yUA6aoehZFuzj+FqbEsC2jPzg17eGH+3nbJW8Bw
	d8X0cRJZ7VG/KWvJ5cQOPZ45/BgKCjgUvqELEVh1JwDDAweN2Xt4ql7WMqcUPPYngjT4QYyNAOW
	YIowtI9UFqev9+dCOWD5yKY8LlHbd1BwUjETBZIs6FkbYtGMoTTAYZjs5wLYXhIwXhVqpgvsEk8
	yvF9cXOZQuhPUYesbfgkgP2qdt3Y7NcBgvYp6syX7ktzsWBhLlANwQk8QELviVKM7DYfYS7sY9K
	ouV8ZXczBN7GwKpeFHAG0+nEmzr5+jEpu0z/fRzhnYkNgH2W38m1PEkAs5dgRU81f7ty0uiL9j/
	rLENKDLzMSqql/TeOkTyrb3VHZw1MyJD34cMZgM/7bqzM/VvIzNRJH3x7zKUwjD2VXmr/hQbj32
	Eyv/f9zMr0B7EqsiF+jlNT5XVCWyX1GYvOeDIY47GS8SnIloMefHBA=
X-Received: by 2002:a05:6a20:db0c:b0:3c3:7a0a:18a6 with SMTP id adf61e73a8af0-3de9e7aaaedmr1396101637.18.1790767738577;
        Wed, 30 Sep 2026 04:28:58 -0700 (PDT)
Received: from m-upc-A520M-HDV.lan ([2400:2410:3f60:500:3fb:270c:7df4:18f])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc7dab46db6sm712637a12.31.2026.09.30.04.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 04:28:58 -0700 (PDT)
Sender: Yuyang Huang <uyoko90@gmail.com>
From: Yuyang Huang <sigefriedhyy@gmail.com>
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: Ajay Singh <ajay.kathat@microchip.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Kees Cook <kees@kernel.org>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	Nikolaos Gkarlis <nickgarlis@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Shuah Khan <shuah@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf.kernel@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Willem de Bruijn <willemb@google.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v9 1/6] netlink: specs: rt-addr: fix the type of target-netnsid
Date: Wed, 30 Sep 2026 20:28:37 +0900
Message-ID: <20260930112842.21323-2-sigefriedhyy@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260930112842.21323-1-sigefriedhyy@gmail.com>
References: <20260930112842.21323-1-sigefriedhyy@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel parses IFA_TARGET_NETNSID as NLA_S32 and rt-link.yaml
declares its target-netnsid as s32, but rt-addr.yaml has it as binary.

Signed-off-by: Yuyang Huang <sigefriedhyy@gmail.com>
Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 Documentation/netlink/specs/rt-addr.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/rt-addr.yaml b/Documentation/netlink/specs/rt-addr.yaml
index 0ecbd24c890c6..17ead22034515 100644
--- a/Documentation/netlink/specs/rt-addr.yaml
+++ b/Documentation/netlink/specs/rt-addr.yaml
@@ -119,7 +119,7 @@ attribute-sets:
         type: u32
       -
         name: target-netnsid
-        type: binary
+        type: s32
       -
         name: proto
         type: u8
-- 
2.43.0

