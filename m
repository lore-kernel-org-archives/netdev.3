Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254924594A
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 15:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774625741; cv=none; b=qZs6jPct936kUcuqxQpWZvjGchYqxVMhVIv1gl5KHbBjJMgTEP8v9OU1OffI96hQVvEPXj/dGYxaQKWQVI5tR1Msw3c0tzhpx2OJnXMjFZthn9JJkhnKBLx/dC3OGjVrkYDpUxI/44VVgDKok6SqXRyH17cRELrbyRsnnuGE5gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774625741; c=relaxed/simple;
	bh=9tGnF2uOc24xA7oV6IGN3IfFS2WdAyzc+CjZ1Y3zCpo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BqRiJ0QGc9g4Ex+m2ZMzSMxS3slF83KFkwTMKam4lap0WaEkR8Y+hH/4NH4eZXp724f0mgfyGG4tpi7rW25IunfF41ZbGoYqWG8jE/4ntZLiQSPQPchkPS9Luy7075PCS6lR5WKbbKmy3LNCp7DBXHwsWKImfTWqHWhfqYaDsUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rFpI+8VL; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rFpI+8VL"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2b0c8362d93so11128665ad.3
        for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 08:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774625739; x=1775230539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZxaCG2wbeKGdyIyvVHQIkk/pIRMFC2kB/SluPbDe8w=;
        b=rFpI+8VL7F6a5ufC1OxjJcieJ863sl83DXlAsOJhomBOnFWyqxiKYHumNbx9tLGE3s
         DtWj77ulvNJvW19xl8bc5zP9rteflTXks2gmIs8xyct8bAdhBcVSUinM0VebaOVRGAZX
         Tpro4jg9zBQqzGjXJjdIx/5rSudifS2pl3Jdq8WZnMKBFWeCn2oZQMLiF1O2E0FPRfXx
         ggO3MN6Jthev9sxzkAvVnCn5C3fwQE5Dyk10cupZlLtpKN1rGbiWNsm0+wYYfyGZMlex
         aLsVgb52Wt4YACNEvd2bDWWBcmkuLK278UoeLlAVKFzFUSozn+UR/bMVjdy4cp7BjRQM
         t9Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774625739; x=1775230539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IZxaCG2wbeKGdyIyvVHQIkk/pIRMFC2kB/SluPbDe8w=;
        b=d522rQF5yzEqAVo1dHqbAe7Slgu+v2jjKUSsXm5jW+InUnboOoD7qimr3zvlXkMXB0
         O8oRZFa/s1ZjeFjONNSnI5cysD5XLWqyvLxOIz3jTd8exLxkWagEH4opRrGrt/t0K+Lu
         wpaS+eoxS5EswjUcRcf3WQncD1GeRkeBuzy9NxJTB3m4QNH4CYHPkAVUrER26xc2fHp0
         DwXz7gtPwnYQslzrDAlFvTy1pmSd/YhKbYUWCVGazNE4dvb9gvaxIWy5IUK4s+tTplQ7
         wMAcFlQhpMCCqEY6GW4AwW4qfNanCweDnENqht0G6QL6JgrbEo0yD+nQxJeZOLbzjhDO
         zlVw==
X-Forwarded-Encrypted: i=1; AJvYcCUNGFd5AAseZTbFkQXIn//4Br2a8zWuJ0AG73mQciFANRHmaxy5388VFdmP82GpRtze8MZY9CY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqORrD3By180X7A1UnjMdJIdSHu3PlaZhYtecwnmIaqcienSfb
	4qiLBq6D8EYO2zja9U2MOD+Yr1fXoYt02i7Sj51XkVRTsv7d03yaOLKI
X-Gm-Gg: ATEYQzxWr2JUOR1h9ym9HDlfpBWpG3Wo+sPNKjrM3bDz17DholUyvMWl4D1d6AjKZJx
	zc754vTLhYXVwmFbvMLaa/4XbjlRwraIatSCwrs81JMAStxI1du3HViuwqU9dwWIeYS1FjDdmW2
	4rCzRny3xvCN/qz8/WKsN1UHbBLZRWR/zkGfsewYGcxo6RtbilnKt3EG/m4Ix7rijRoURH7Jcgz
	yBEfcjyuuKE8L3mCgzXhWdxMut5jsWMD0aqnGRkUPB52U0foOduexY204Mn2+G9ivH6vPCML1VE
	vq8XQkMDWaOYS3iusdva++WlF7TqoThobJEnlSsj7cM+JxxS2y2RXet2KFC9oHxHDsflnHkMCjP
	dMebsEGnf0RK5im1Xjw/hLapwvIadV0iw6nxm3lJU8g3h24f9NemDK+kovTaJCseNM5V/ra4/gI
	4Btls5/Ke67/WDOygIYFCxLW6TEGiFUuqzRohN/kIwBgLxbuI8RMbV4hJm6MXaF93Dddvs5hy9Z
	lpaypdOhbOA3Dwoy5Ssxm5PbEfrnem6QJxo9Bryvd2nmdbsQ92gGPb4E1+ZIxkm21PIUuVedpGK
	emY8Hfe/3Rg=
X-Received: by 2002:a17:903:285:b0:2b0:51f6:d468 with SMTP id d9443c01a7336-2b0cdc22e12mr36228035ad.17.1774625739173;
        Fri, 27 Mar 2026 08:35:39 -0700 (PDT)
Received: from DellG15.localdomain (2001-b030-8055-ffc7-2d87-7642-b84f-7a21.hinet-ip6.hinet.net. [2001:b030:8055:ffc7:2d87:7642:b84f:7a21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc7afad1sm79099845ad.31.2026.03.27.08.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 08:35:38 -0700 (PDT)
From: Guoyu Su <yss2813483011xxl@gmail.com>
To: edumazet@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: willemdebruijn.kernel@gmail.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	syzbot+1543a7d954d9c6d00407@syzkaller.appspotmail.com,
	Guoyu Su <yss2813483011xxl@gmail.com>
Subject: [PATCH net v7] net: use skb_header_pointer() for TCPv4 GSO frag_off check
Date: Fri, 27 Mar 2026 23:35:07 +0800
Message-Id: <20260327153507.39742-1-yss2813483011xxl@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <willemdebruijn.kernel.19f0cde3c6457@gmail.com>
References: <willemdebruijn.kernel.19f0cde3c6457@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzbot reported a KMSAN uninit-value warning in gso_features_check()
called from netif_skb_features() [1].

gso_features_check() reads iph->frag_off to decide whether to clear
mangleid_features. Accessing the IPv4 header via ip_hdr()/inner_ip_hdr()
can rely on skb header offsets that are not always safe for direct
dereference on packets injected from PF_PACKET paths.

Use skb_header_pointer() for the TCPv4 frag_off check so the header read
is robust whether data is already linear or needs copying.

[1] https://syzkaller.appspot.com/bug?extid=1543a7d954d9c6d00407

Link: https://lore.kernel.org/netdev/willemdebruijn.kernel.1a9f35039caab@gmail.com/
Fixes: cbc53e08a793 ("GSO: Add GSO type for fixed IPv4 ID")
Reported-by: syzbot+1543a7d954d9c6d00407@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=1543a7d954d9c6d00407
Tested-by: syzbot+1543a7d954d9c6d00407@syzkaller.appspotmail.com
Signed-off-by: Guoyu Su <yss2813483011xxl@gmail.com>
---
v7:
 - Drop revision-diff wording from commit message body.
 - Minor style: keep variable definitions contiguous in gso_features_check().
 - No functional change from v6.

v6: https://lore.kernel.org/netdev/20260326121813.457049-1-yss2813483011xxl@gmail.com/
v5: https://lore.kernel.org/netdev/20260320141459.9691-1-yss2813483011xxl@gmail.com/
v4: https://lore.kernel.org/netdev/20260319005421.14908-1-yss2813483011xxl@gmail.com/
v3: https://lore.kernel.org/netdev/20260312104351.185370-1-yss2813483011xxl@gmail.com/
v2: https://lore.kernel.org/netdev/20260308083319.1255118-1-yss2813483011xxl@gmail.com/
v1: https://lore.kernel.org/netdev/20260307162905.3697050-1-yss2813483011xxl@gmail.com/

 net/core/dev.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index fc5557062414..831129f2a69b 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3821,10 +3821,15 @@ static netdev_features_t gso_features_check(const struct sk_buff *skb,
 	 * segmentation-offloads.rst).
 	 */
 	if (skb_shinfo(skb)->gso_type & SKB_GSO_TCPV4) {
-		struct iphdr *iph = skb->encapsulation ?
-				    inner_ip_hdr(skb) : ip_hdr(skb);
+		const struct iphdr *iph;
+		struct iphdr _iph;
+		int nhoff = skb->encapsulation ?
+			    skb_inner_network_offset(skb) :
+			    skb_network_offset(skb);
 
-		if (!(iph->frag_off & htons(IP_DF)))
+		iph = skb_header_pointer(skb, nhoff, sizeof(_iph), &_iph);
+
+		if (!iph || !(iph->frag_off & htons(IP_DF)))
 			features &= ~dev->mangleid_features;
 	}
 
-- 
2.34.1

