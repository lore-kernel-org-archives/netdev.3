Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792785194;
	b=lwE5IvcRPv+Hz2K+5kD0RnlaLuIXjrqeOYEPrdrpad1s2CQ//A1P0++Tr4r3WGIZnC1C
	 I/HmP2+Kfo3bj+nPfv1WStbuVvnHAzmWldXeARkNxjCLa+mFQqp0O343Ss03uPjA5HrAV
	 XJsDxjImqlUaqt9WGyCqgtYC15L4i5pGkZ8XnoMm9f1piLzE5Lqj5ssZCmjm59thqEHpe
	 l1jyvhSqK8W+JvXTUZgKy5DqhJNtP0e9RSYftgvS9cZS3jChEXjbeRkSnWb6OhiiEZL1/
	 +Ioi9Zs+FVOIQZbchnx2/z/YPmY3W9iNgLbtsdYEHPn8xEbPETeN1hIqnjMZCcFKmLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792785194;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MYMvGahXwl+NkKbqUxWpkDAanrsDHqw5aIx8j0gxjPs=;
	b=z4mUTD5SW4URdluRCGPQQAN4bGoHK3iiT9cezYlfSpR6Hfqe3blMd715nqiccgVl4OVq
	 HBI7WeSkDl+AcoV/oQtolp2qqU01kyP1RRoXXo7zgOMzIlWfQ+2f6QxnzMs3OoQ0xJRg3
	 5n3dEPyb4+fA2PP0IGwlDeuZ6s0yGD3iebrziBWFHpUMh5UDQQddPb8lPz11GMcVbZe+h
	 H5NqHvJV4CyhqW760+b9IF7+65xPz3pCRiD/odS2V5/ZJ3hDSvqD/5keoShq1hIyJWy5K
	 cQLvmWi+FxxBOZkkn2fL55LKtPZNqPIXDmxYXhCY16jka9FZ/GItFlYJrlkeWiDeoFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SNymd6a1;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9758606A31B
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 19:53:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9758606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SNymd6a1
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-487049569b6so736240f8f.1
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 12:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792785192; x=1793389992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MYMvGahXwl+NkKbqUxWpkDAanrsDHqw5aIx8j0gxjPs=;
        b=SNymd6a1wWN4/3R20ghV9hJHANXsMHNZSjpLs7ikUYUtr6b9oz82iVM8+eYTK/D3vU
         IGsAk8eCbL0wRGWa2VkqZqGYenDcQblbEh7NY5P5CnCrzU0GVQJd8GQdSa9LiNUopKf4
         H+smT8EN7qxVHmRrLBcf8NQKwog626n7OpXx7vMBHc3nJNf4Ek+rT6LmoMS5Z1OSQAkX
         /vhr8qGpafrpNzpFK/lC3P8bxKvBmvsJGKTJoKns+JWDQ7uGfMcy3Ble1kF/ytdKyupE
         4LNMEbbDLPq2dsN94uKUpxZoySsaQkttM4MnXwwrNGH90oR3nHt597WX+Ij+22CRbRl2
         pKdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792785192; x=1793389992;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MYMvGahXwl+NkKbqUxWpkDAanrsDHqw5aIx8j0gxjPs=;
        b=p3zmvk8CoLuo5hwfAYtA9h8E4zN6puHOyBcBGbWv0IjaZeGP814ekgFSmB80qv+w0r
         P27gx49aO37/9GSHxJAXDDOuXnaxikBPCzmgZOGOIhOTHvtYqU/Tm71vLJiFSlfXnd4B
         aYPbUq2q4WU6eZS8Nt4613OaGTaDr40Jv24zNw18m/dbBHUI/G8IlUOddOIFSO51HCwz
         jpUIyYhAV9l17R/Iv0+l4C0V4XYXzyz5VWS2dyzF1C4d/fcNP/ytUGzgfyDCbEgMXLji
         M7HywUXat8jqjM1nRhIQQl3hgPCRRjtE8fMArW4fjttSJhWlRi5ZEGN2bYb9Mm3wuFmH
         PTQw==
X-Forwarded-Encrypted: i=1; AKwUvBySOK4cy7zlLAv+45VcQIQI16NL3fNtcXqXhhARX2SFS/EScvOAcvo8h7hWfLhpUIL4eiLuiSk=@vger.kernel.org
X-Gm-Message-State: AFq9FYIn7LwmNLmy33wI85Z4DWslVF8XUB/c2Yr6KKW7QChZru1hCHtp
	LyOqJ/e+tGL3gDDNgEmdF4t5DQat59DJagHmJu9nA1EqVAVP+L5EDJUuPUZE
X-Gm-Gg: AYBFou1V06dLnvgxA89FHwH80R4LaTgTY4iWjmLkrmqRK/XvBvYXaiP+cgZ05R67uoT
	Wxo/sS9nh5JEtT5VbiI61AxsBW68LCw1vl54e/HzaK2eZdAHWENZptGFz4FO1ceDKdK9mCTM51i
	ma8+QxpvJuNWwzN8F1PTsMalp6K3O9fEHSvM/njysdYk3Pv+xjnnysMhsDEzCDUspBIvDog7wOc
	VgDOqfe0gtVj8mYIyfFQ5sQ+f5qo7srniRskr0/05N7/NW7DexSc+NawzRJcg9cixrZ+QLYOY0b
	KIoAcw+GrQbk+eR2yzTGwlWoB2ZAVGGCW1C1pze5TWCbcN04Omgwi0eKsfB1qLX40HKr4jEp7wK
	TolroV/7UIEAiYx/OzKsevhnXgWmchc91NaENJeAIAkut6TLLVyE21nysHkNPqBxOBcf31uc3Xu
	GP5gQKpEDwPuJNAzqVh4AMh3zbvsHLFyl0bgIzkQ55cNIQ6B/gIlnxJLwdOEDNT/Y8Uk3FNEpbh
	Imr/iPgK0HhrHYU1alWwJh27A==
X-Received: by 2002:a05:600c:19d4:b0:4a3:5a42:b29c with SMTP id 5b1f17b1804b1-4a35a42b345mr2557955e9.26.1792785192118;
        Fri, 23 Oct 2026 12:53:12 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a359fc1207sm4434875e9.1.2026.10.23.12.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 12:53:11 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Qingfang Deng <qingfang.deng@linux.dev>,
	linux-ppp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH net] ppp: fix stale pointer access after pskb_may_pull in ppp_ccp_peek
Date: Fri, 23 Oct 2026 19:53:09 +0000
Message-ID: <20261023195309.3527129-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
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

From: Tristan Madani <tristan@talencesecurity.com>

ppp_ccp_peek() caches a pointer to skb->data in dp after the first
pskb_may_pull(), then uses dp after a second pskb_may_pull(skb, len + 2)
in the CCP_CONFACK handler. If the second pull triggers
pskb_expand_head() due to a cloned skb or frag linearization,
skb->head is freed and reallocated, leaving dp stale.

The stale dp is subsequently used in CCP_OPT_LENGTH() and passed to
decomp_init()/comp_init() which read from the freed memory.

Re-derive dp from skb->data after the second pskb_may_pull.

Fixes: 1da177e4c3f41 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/net/ppp/ppp_generic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index 1a610a18893ba..3998ce4332f42 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -3157,6 +3157,7 @@ ppp_ccp_peek(struct ppp *ppp, struct sk_buff *skb, int inbound)
 		len = CCP_LENGTH(dp);
 		if (!pskb_may_pull(skb, len + 2))
 			return;		/* too short */
+		dp = skb->data + 2;
 		dp += CCP_HDRLEN;
 		len -= CCP_HDRLEN;
 		if (len < CCP_OPT_MINLEN || len < CCP_OPT_LENGTH(dp))
-- 
2.47.3

