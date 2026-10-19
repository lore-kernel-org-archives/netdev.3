Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA0B4963D2
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 13:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792417875; cv=none; b=u6M4CFNVfAuK4p8J0itQOYG/aUYyddPBcQjrwkaf0gRefeCEe/NHe9UdAJ2YbwhBt9Y84CpJsjzVLp8ObpuNA3jKMbz0EBjSdBp25OesJRmkQAQIumE92AY4Vnc3YHo83WJEsAZUNLaRnmYr+zo9pLyrWd6/WxJt+Wkpll1NtLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792417875; c=relaxed/simple;
	bh=wii8wzXlG4ePvSd6K5rd8H498XoB8iUyEaQEAS7r5bk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wt23kVWGsgqoq2Rg1pYAKuWae5ErZw8w8LamZeMFl4qqHUQnYgu8MtWtxCP1FukCBo67Ep3z/M5TiWKH5iCiTNBEltaT7GJESgBFSPTiPtH9Rw9a4OTnJfFnkLY66L+B/3Vpjr5UwmcET4RoZvYOr6hbfYiSWxd6wtR5pCKAfbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=mckjeKYO; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="mckjeKYO"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-93ead211f14so242740185a.1
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 06:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792417873; x=1793022673; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2aRCuku2oKEDF0Op1/pBMZnZUn6snlu290Nklz94qvM=;
        b=mckjeKYOpnxff4OsRRRXyaZ/PP39mMekGJg5kwIsWESUbWKxEMZSd9i/vAg3DC+krJ
         Ovo1S9fHj60EJtVjcdf0DqA1JBMhYD4ZW+lYOZ2JBfgQavHu1DLMIoH1PSp9OA3Dv8l2
         smtBkDu5n9lgduwGxTi1p1jsq/TbH4q8PjSlxzJLLV5ejtLZx0ZwhZ8b8cCLz7vXZTqw
         YQxSUHn1kn3oP6yEgItonDvMbECvWORxTT4QocCUcvnsKJuHD9PVMGQfz1VPeIkpNZ92
         bb7vj2do7lMm/4WfqLXkJURxPKM0em7a1rAjahR740t2r0aHPefdCGneXBT11zsGv9XK
         6qdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792417873; x=1793022673;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2aRCuku2oKEDF0Op1/pBMZnZUn6snlu290Nklz94qvM=;
        b=MP1zmp7avJZ1OHvQS7C3+l/CSEc+PVL9MvJAfr1lO5mIHHJ0XQWWjRIG6YLB8/4hvV
         GscJc8VRNpLvDRq1T7dnzyRFP1Cj3cRSE1eMR9XYTvgcmzZgFU8opR/fZyu03deHVVTO
         g3hrwhGQr7KaJ9DIgiqs10z/Z1BsmrC5823zwXaZLg4znGcNGveBYzCaiBEf98n3OCbY
         GBj2PVV+BhvSPm77L/zsCgqeLX2W7gR8NiMQgxSIVkVQvxsA/ZNv0tgkn7+Q+7lXcI8h
         ihHDru3Gpezp4zpT6b1UZbowKskzsXaAuCPgV7IavuTGhDJrXrnnJTG34Paqf5EJ4Pn4
         7Sow==
X-Forwarded-Encrypted: i=1; AKwUvBx94KoUdazy220o2N9YrSq5M9JdMF7hZrYuy+2UC3d8CqWt0ce2V7qMiksRroPdJqDfp7QsPJk=@vger.kernel.org
X-Gm-Message-State: AFq9FYLGji7KzoJfByDOZLxncgUrZuLt5/IQVt3DEw3GGcEqvJTjdzxO
	niBGh48X6LgDh1IAaQT6DmYlg8X9/IOHK6DBbPmLuvt0S1ZBvb35z7O3nty7EF9EB8g=
X-Gm-Gg: AYBFou2Ij6O49YES79KzNQwxjWIu814DT//q3w4Fjg9AGBH4kc/FRgc1kQeBGYkqRUg
	GGJaU74oEw0aeNvZP6hfXXcaWUWQEiZBVSy200Z052bQZLv/MiIfoNHW7azpiY5zSVi5DY97Ly0
	5rCsdbc4BVZwAUnCzqf6n5cMbttDnM3gk2cIGSiCu7kbiHMY+LqZQ2b/y7Xdl0CgCtC4SNKxcyh
	wrLvqPC99ffS/6Q2CH8MxUvbHKRQZ7kN9U4NHG9HnoBmQs+iUOicebQQ9P6HJofzE2CXyz+rC++
	A5uMfVwcax2HXmINykin1rwHC15fROxclp129d7UUq1Oc3r0ncmWt3gJMpzm6B8xyzcxvRkzOKn
	t4M612RshVbM8OtDBAXI2Ge+GWkaoNJ3rBsELSTfwqDnjgtWT8E7vfFpPPI4WUloAShb8IXczXT
	lQNF0XWc1iZZRGs1z071IXQscmXtlMCFZ89upJ46jo3f3CH8oK6e2ZJ9EZyYggRUrjWWBNJ+epL
	iV68fbW+3je8RE=
X-Received: by 2002:a05:620a:4608:b0:93e:fcac:a91f with SMTP id af79cd13be357-93f17f9f371mr1747377785a.37.1792417872286;
        Mon, 19 Oct 2026 06:51:12 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.247])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f332739d7sm575249785a.28.2026.10.19.06.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 06:51:01 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Mon, 19 Oct 2026 13:50:38 +0000
Subject: [PATCH net-next 04/15] net: skbuff: fail segmentation when a
 segment can't be checksummed
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-b4-skbuff-bug-on-followups-v1-4-41dbef50b9f7@toxicpanda.com>
References: <20261019-b4-skbuff-bug-on-followups-v1-0-41dbef50b9f7@toxicpanda.com>
In-Reply-To: <20261019-b4-skbuff-bug-on-followups-v1-0-41dbef50b9f7@toxicpanda.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Juergen Gross <jgross@suse.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Fernando Fernandez Mancera <fmancera@suse.de>, 
 Mina Almasry <almasrymina@google.com>, 
 David Laight <david.laight.linux@gmail.com>, netdev@vger.kernel.org, 
 xen-devel@lists.xenproject.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1792417848; l=1895;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=wii8wzXlG4ePvSd6K5rd8H498XoB8iUyEaQEAS7r5bk=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QFNR28egIht/ZoRyU32fPc4iNKinzI14ufAnhDAIIBXEpJO58NOkbKAc331mB1ZlQKPGaXOwjPS
 ler9rEAlgTAU=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

When the device can't checksum the protocol, skb_segment() computes
each segment's checksum in software with skb_checksum().  With SG on,
the segments share the original frags, and a devmem TCP skb keeps its
whole payload in unreadable frags.  The devmem MSG_ZEROCOPY path never
sets SKBFL_SHARED_FRAG, so the __skb_linearize() fallback is skipped
too.  skb_checksum() then warns and returns 0, and tcp_gso_segment()
writes a TCP checksum that doesn't cover the payload that goes out.

That's reachable with tx-checksumming off and SG on: sk_setup_caps()
still gives TCP SG and HW_CSUM, so the dmabuf send is accepted, and
harmonize_features() strips the checksum features but keeps SG.

Use skb_checksum_full() and fail the segmentation with -EFAULT when it
can't checksum a segment, as skb_segment() already does when it can't
copy one.

Found by the Sashiko AI review of an earlier fix for the same path with
SG off.

Link: https://lore.kernel.org/all/20261009-b4-skb-segment-nosg-unreadable-v1-1-7e2334a55fe8@toxicpanda.com/
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 net/core/skbuff.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 40d2dd20d47d..88ed2dd99dc0 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5239,9 +5239,13 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 
 			if (!nskb->remcsum_offload)
 				nskb->ip_summed = CHECKSUM_NONE;
-			SKB_GSO_CB(nskb)->csum =
-				skb_checksum(nskb, doffset,
-					     nskb->len - doffset, 0);
+			SKB_GSO_CB(nskb)->csum = 0;
+			if (skb_checksum_full(nskb, doffset,
+					      nskb->len - doffset,
+					      &SKB_GSO_CB(nskb)->csum)) {
+				err = -EFAULT;
+				goto err;
+			}
 			SKB_GSO_CB(nskb)->csum_start =
 				skb_headroom(nskb) + doffset;
 		}

-- 
2.55.0

