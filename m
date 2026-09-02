Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D455220698
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 00:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788309242; cv=none; b=qH9aC6y4Fsyx9FsKNnZitDnxKpwFqJy9lpVPD1aDFKWENyMO0CK819d4HsopDDgajs3ExcL0HctL5veugPjSY4EVC7fd1da300XGGvBlKVDYgnvFi2f2rCTCfeBt3RJm5/WwkQ7LbUuX9puQWeb6mNGn0Xl2P0QJ25b98MewJYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788309242; c=relaxed/simple;
	bh=4wAE0NxkiEdkAAleAMcFPclcMVHr0G8MVJ1gpMI9L8M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W/oEQSNFNWDz/T76sWyKDBbqUlUS7d6UhTHLHozNMy4Tnt6EI1src3WqTjtUNnATGLHC/w+35FDMHSEaX0yuh9fqZRJhxRbaz1cQZePXvVjzswWrxASMQxDwvv8I8L46D/yuKRzuXboBU8EqwJmhr+J7Tk2Z7oI5Ocu8TeuiGSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YYpRUYi6; arc=none smtp.client-ip=209.85.222.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YYpRUYi6"
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-930b571432fso87436285a.0
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 17:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788309240; x=1788914040; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hKgcx5mk08ss4vN4B9ReuZ9rwLI1lHEadPLIFgnxJe4=;
        b=YYpRUYi6JcVHkUtzUMmHXcDRXEh8DvWe8ebqBnUWiFhCki7PBA9Q+EZXInXTBHJRCK
         /TrakmMI5VsxieH3ZSpdKbgzTv3mCybDIW291nF9cQ+faHcNpqzZAo/lqoR7rfK5B617
         Em4Rq3Bak3nX3kOagEEv4Rb1gNCj7cnbyiIkLwDkJm/YYaYbmkZsHeQTo6D8SgIyOqZX
         fos1BrDk9tb10HyTOrOqe0n0w55vsT/3adsxTYF81MVLh9Bd2cnN+g3Kh4SqKWNSzhHD
         sDEEJ6sEcc7NV2Hdcfa8o1lmk7l8ld+zXPvwqk9pDVEKu1crK6z2cz5BtmGoCYglaSQ1
         uRKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788309240; x=1788914040;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hKgcx5mk08ss4vN4B9ReuZ9rwLI1lHEadPLIFgnxJe4=;
        b=phnBIwKWEzVywqPjv0wREXIHd3jTfX0HbQcJAzFp8SbLbbt9o3T28Q3wcPxHyac/k6
         JwmTnrjchqPs+o9rbGp5tIVqgCpGxngEzUIvwmwuqx4gXfnI2JAodssYbkbuB1RmQoBC
         q1H/6ApgcX2NJpBJuwnRmJMUDt1bL/qHsbUi9/jf7P6XtIoPACwofA1UCRWW06L9UUA6
         8DgNGrMFZTUGWYWMOc6JNdf8qDCcqkaYFEVk0Fu78r43rzAgNz0/sLDy0q91so8GaNC4
         q4cX6bLSORXxUWQbCsA6jy47zDwsPek4dMWVNeq3suwoDbKSyEfqOBaP5+vm1osMkQos
         kVdg==
X-Forwarded-Encrypted: i=1; AHgh+Rq0WXoyvqBpRDUYh3XVM6J6iJS/iQQpEIFa2Rc6VrRFQAIj6Wk2u8ksE4S5Y6tlzI4gho1IrA8=@vger.kernel.org
X-Gm-Message-State: AFuF++nUs1Sdsnz7ANZJGlNv6bojHYh+U2pUhA/Aa9RMCkmaT2yTam33
	wr79viLGDimeyW3YwzFnMJLPVK4e9gK1xD3MiWX1EiXpUA6B3bp9G4WyBsKIj2fE98qWvOVWn6H
	o94FHNMWnqyR/xw==
X-Received: from qkyy17.prod.google.com ([2002:a05:620a:9d1:b0:939:194b:60e5])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:2906:b0:929:f78f:6bf9 with SMTP id af79cd13be357-9396197135cmr90247885a.16.1788309239830;
 Tue, 01 Sep 2026 17:33:59 -0700 (PDT)
Date: Wed,  2 Sep 2026 00:33:43 +0000
In-Reply-To: <20260902003344.1931843-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260902003344.1931843-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.966.g6673acef38-goog
Message-ID: <20260902003344.1931843-10-edumazet@google.com>
Subject: [PATCH net-next 09/10] cdc_mbim: do not assume mac header is set in cdc_mbim_tx_fixup()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

We should not assume mac header is set in output path.

Use skb_vlan_eth_hdr() and skb_eth_hdr() instead of vlan_eth_hdr()
and eth_hdr(), and remove now redundant skb_reset_mac_header().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/usb/cdc_mbim.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/usb/cdc_mbim.c b/drivers/net/usb/cdc_mbim.c
index 877fb0ed7d3d71c0e55fb5d29c269030b6c5b684..c773be03875634d16f64cc60c2bfe8a718356071 100644
--- a/drivers/net/usb/cdc_mbim.c
+++ b/drivers/net/usb/cdc_mbim.c
@@ -240,13 +240,12 @@ static struct sk_buff *cdc_mbim_tx_fixup(struct usbnet *dev, struct sk_buff *skb
 		 * the accelerated out-of-band tag, but fall back if
 		 * required
 		 */
-		skb_reset_mac_header(skb);
 		if (vlan_get_tag(skb, &tci) < 0 && skb->len > VLAN_ETH_HLEN &&
 		    __vlan_get_tag(skb, &tci) == 0) {
-			is_ip = is_ip_proto(vlan_eth_hdr(skb)->h_vlan_encapsulated_proto);
+			is_ip = is_ip_proto(skb_vlan_eth_hdr(skb)->h_vlan_encapsulated_proto);
 			skb_pull(skb, VLAN_ETH_HLEN);
 		} else {
-			is_ip = is_ip_proto(eth_hdr(skb)->h_proto);
+			is_ip = is_ip_proto(skb_eth_hdr(skb)->h_proto);
 			skb_pull(skb, ETH_HLEN);
 		}
 
-- 
2.55.0.966.g6673acef38-goog

