Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AE83769EC
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 08:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788338058; cv=none; b=qTOgHeTNQ6z+j0dOAxRn4Fc79jK364pKbCbzaHQFvha29O1d1f57BgpXjW1AIxCZAypM+OpEf+p/zJQv5qWT9g7cHP35zNs139C2w95O5NP5YuzU1YzIKFCVWJ+XyBpq655YwpmRzmBNT0K4T/xPFrbOIwsjZVpaDmVnEyBlUVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788338058; c=relaxed/simple;
	bh=nQSMfLXooTdM45Aimk7uiT9RoDYsM7bG1cJP54C7pfM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=CCAGDS+eeziHd97jUHQxbrZpTqtmEu9tGf3nSd0orPL5VfEyMDLMgHNx06eDqlt+X+9Yi+n6g4Kp30VQVQZfMTI9v9HLaNcITH7vS0G2bq/+r93enMoNayry30HewRn7Tmw/JuuWG5gk76KmZRnZomXCIQuJX1TEeOXFs6x0eUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TToWNUaI; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TToWNUaI"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cc11a905ba5so564631a12.2
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 01:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788338056; x=1788942856; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=MxYlVCLZdHbqd24Lf2nyCsb+xngw/v49TM27dJoKKB8=;
        b=TToWNUaIzVpT43/eIGmJ+sOviGw2SfZ8QptGM38+SAOSxmkvqNYz8eIbdmJFYn83uq
         /nVkVStUn4g8joTePTsh8Vhe7/ZU56dDVpDZt9lunDTEGQVeEvFFsQ1F5zUZMfNq8RPI
         Sql79FsEQrRb7iocvyoVGgxqGuZhJ2ouDWef80ihihUijrsru8/94BV6Ed8N1g2ywXVZ
         pVxlhLQoHme9sGYw8MiQVtvh1d2qt43rvP+H3FT6meqhJr27FrGwKE0f0k6UCCDtXV17
         KcQ7wt+2aGc967l3KYLxSJrJVdgIRhvlD45vkTBLmBWOkKLN1TleIHOEBPFr782WxLTg
         2F1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788338056; x=1788942856;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=MxYlVCLZdHbqd24Lf2nyCsb+xngw/v49TM27dJoKKB8=;
        b=R9gvQmtSWW4TJuVpKj8fb6ORHC6SWKbmlN6yY+5gUYOMNT2r5OD4i6ootw8ZUctSdn
         hqJm0bnDmaVVLmLiAxWAdgXoPWEuCzCgBWPJAf5ZlxJUcFJmXSYvRmw7gAogbJM6FJxJ
         Dedl0z1AYgYXRu0XGu0REE0F/yRvniDzSgHZ/Sew1r8t60YZrY1bs1MiZTUrfRoKrIC2
         MxPGjVL/5FQswtx49FX7CGvttC8GfC1lxFRRBDUw3KnnZYeoog/2ei+3ppEGzLLWYfnl
         NT8KFaPecbyaPbmoCaEHhxoWf8cCcN1wxB2dKCbk3zRHQ3ly3PQaoELHibnNvXhH6TOP
         PEIw==
X-Gm-Message-State: AFuF++nRhm17AXtjafVQMagxGyiHO27LFJVhoz5Q1D8KukG1+UTM3740
	eeWfDZ9qMNVF3+9cFIGdqvXxBdcFnZMKYFP3RakdDGL2HzVF0T86fEFS
X-Gm-Gg: AR+sD12QPHL8FsAlfE6P9UGJN+ydmEoE2vi5/+gatx+XL4/kB3b0rdn1llvOs6lynML
	lqHOnVIpe6dDU+Vq8UOrF3qi355eNv5b64vk2a2DC5dUvSmKhPpchR96VflcaD6MfF/bqhUys0d
	KbewjZpHqY5dFedhi2PpxDGsgfqSwWuWMf3IEJxzaKdcfPbBkyZ+x1RJjf0RKpVZ3pYFGKAS7q+
	XB38tPjaI2qraXkxj+vl4veCpNaw5JrM2BPNssUSXoMA22EDDQGX9gOPNnoMapH543wgc7kWIkK
	Rp2iEXlJVwNrujCyJT6ID9huVJD/5WRpr9c2EujGTfgvMe4RI8KO8uVbvFGkfZ7XL1XsXNJRv16
	YxpopA6tE4yELEaw6bo9+cpoMSLgJ3910XAmy3RflNVNvwKN3nzs0gIkpp9f23SD3D4fYzEKixC
	UYkRh9VjL7zneH+QArmMotUNC/dcnI/Kpsz2G2NZPS6MFVggKl4KerUrD0KIC2mWmjpKV1Tgc=
X-Received: by 2002:a05:6a20:a124:b0:3d3:af85:eb99 with SMTP id adf61e73a8af0-3d9af3f35b9mr4310867637.27.1788338056366;
        Wed, 02 Sep 2026 01:34:16 -0700 (PDT)
Received: from [163.43.103.131] ([163.43.103.131])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc34d0022c7sm726419a12.15.2026.09.02.01.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 01:34:15 -0700 (PDT)
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Date: Wed, 02 Sep 2026 17:34:13 +0900
Subject: [PATCH net-next] seg6: reallocate the skb head on L2 encapsulation
 only when needed
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-seg6-l2cow-v1-1-e823ce216454@gmail.com>
X-B4-Tracking: v=1; b=H4sIAITfl2oC/yWM0QqCQBBFf0XucwPrGIr9SvSg66gjscbOVoL47
 231eDics8MkqhguxY4oLzVdQ4byVMDPXZiEdMgMdly71jGZTDXd2a9vaprBV313Lrli5OARZdT
 tN7siSKIgW8Ltb+zZL+LT94Xj+AAFIu4leAAAAA==
X-Change-ID: 20260902-seg6-l2cow-77dc3ba41232
To: Andrea Mayer <andrea.mayer@uniroma2.it>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yuya Kusakabe <yuya.kusakabe@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1990;
 i=yuya.kusakabe@gmail.com; h=from:subject:message-id;
 bh=nQSMfLXooTdM45Aimk7uiT9RoDYsM7bG1cJP54C7pfM=;
 b=owEBbQKS/ZANAwAIASrX0XUqXRtNAcsmYgBql9+FlANzp9nxfyrPzdLUPJx3pqGmrdCXoEf+4
 riHCgA2duKJAjMEAAEIAB0WIQTaB7usAfxNKMeqa6Yq19F1Kl0bTQUCapffhQAKCRAq19F1Kl0b
 TWa+D/4mWf99a/uWnnddkAbdfKxfimeoxmhbibYJ6ey7R67XQsLRX/ixjAbjAd0O2sTvdusSLZJ
 tkFR+vKXbc9mONJuiiu03A+LigfUAjgWU6N/hLrYMXH3XUpwNr21QBqxW2Hpg5OYUSTfFTJFzB9
 b42plVdTTu7gWGpvNzrPABaGz5n699ULJZliilMYag2bPGKrt+StlDO2W9IHl2vVvuVig9452RP
 YQlxObylwpy5UgTtdHCmPs+2gIKSPoLnFVt02RMZnIZvezw7CXS8gOHVdwcZXvla9C2WrPbPPgF
 WV/AFIKRwBoMpsAljygK2rPnisqIRswwGAJyOkU08/5EI+91uSqraLpKfGfRw5o4YfGVd/or/Db
 c6tG9MR/hRG8WuHhzSlHBXAJTESbQtpeL/LtrIUh4uB8J6SaMjeoeQc5gwwa4qUG8eHau8uxOHu
 C+aBlQ4dMy6XcxTjXlOQd15MsbWrR4A0m7yv0pcGCLbGBfS1UW3xaI4yJngOHRv6fbA9LFH/++t
 LU8Z4yekS1NHl9r/kKpM++iKCCpK6GYUwpzefDQSp189+72BhNWJkW168GXFr/GqFaErqvkiYX8
 vh75ZEL80UtyqdoObGxbAmj3Yd4r+1MOlEFu5hGYEbz2i3TRxBwCrBnhRNBYJS7OjXwWbpoSROQ
 PY30aMtKkEi/6nQ==
X-Developer-Key: i=yuya.kusakabe@gmail.com; a=openpgp;
 fpr=DA07BBAC01FC4D28C7AA6BA62AD7D1752A5D1B4D

The L2 encapsulation modes of the seg6 lwtunnel reallocate the skb head
on every packet, where the IPv6 encapsulation modes reallocate only when
they have to. This site only has to fit skb->mac_len before its
skb_push(); the outer header that follows is already covered by
__seg6_do_srh_encap()'s own skb_cow_head(). On a forwarding path neither
reallocation is necessary: ixgbe leaves 206 bytes of headroom, against

  14 (skb->mac_len) + 40 (ipv6hdr) + 24 (SRH with one segment)
  + 16 (LL_RESERVED_SPACE, via dst_dev_overhead()) = 94

for the whole encapsulation.

The cost is amplified by CONFIG_INIT_ON_ALLOC_DEFAULT_ON, which many
distributions enable: every new head is zeroed in full, and that memset
alone accounts for 16% of the datapath profile.

Use skb_cow_head() instead, matching the IPv6 encapsulation modes.

Throughput at 0.5% packet loss, 64-byte frames forwarded through one
2.30 GHz core (Xeon E5-2650 v3, ixgbe 82599ES), offered by TRex and
binary-searched over 10 runs of 10 s:

  Before: 660.7 kpps
  After:  991.3 kpps

Assisted-by: Claude:claude-opus-5
Signed-off-by: Yuya Kusakabe <yuya.kusakabe@gmail.com>
---
 net/ipv6/seg6_iptunnel.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
index 61c6a27bf202..a6556efd8e0b 100644
--- a/net/ipv6/seg6_iptunnel.c
+++ b/net/ipv6/seg6_iptunnel.c
@@ -446,8 +446,9 @@ static int seg6_do_srh(struct sk_buff *skb, struct dst_entry *cache_dst)
 		if (!skb_mac_header_was_set(skb))
 			return -EINVAL;
 
-		if (pskb_expand_head(skb, skb->mac_len, 0, GFP_ATOMIC) < 0)
-			return -ENOMEM;
+		err = skb_cow_head(skb, skb->mac_len);
+		if (unlikely(err))
+			return err;
 
 		skb_mac_header_rebuild(skb);
 		skb_push(skb, skb->mac_len);

---
base-commit: c8ea08ba34f2a2e9bfb18ff3d69eb2d69b324f49
change-id: 20260902-seg6-l2cow-77dc3ba41232

Best regards,
--  
Yuya Kusakabe <yuya.kusakabe@gmail.com>

