Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39033E00A9
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 21:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791493423; cv=none; b=ipHxcGfKlxp9oWg6oExodZs6LfT0LD3/80NiEfJ2Ls9mSzgiVLRNHXsoerL8cizn+VlANwy/Ymur6h2yiktsB5xLKRLNXq0DreMiVS6QrfS7JqrRbBTutAXwQ9Za5Vn9KMiI9WhypHT1lMHqSOxlwA6ZBN/nFl0jXGcun9TuuVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791493423; c=relaxed/simple;
	bh=eg6ZiA9VrIpAG1HGYjPkKMEWwjo8D3VwigBhj0jOQMI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y1StRPxw2b57oYdWKSfOWmdKTtxDXX0yA19gwVW9syQRnPN4bRz6o7a93SBYPDuULMDJX3lweEEDyzdtpavE38eLTvj80GGRaKuX2WAPRFn91hLNx+ufvKWs683AeZXLiovXiI9JdmwaWR/MNdDdBCbC4lULzXiLAZ1X0/OIZm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=YRK3ADz0; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="YRK3ADz0"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-5337fb43c16so34910401cf.3
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 14:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1791493413; x=1792098213; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jXT5xqnUz/gqqG3F9wxnjnCJ7kPBk+m9Im3cz1NP6m0=;
        b=YRK3ADz0+hVZ7K+hfPF/hdt/Z9G46F8iuh3Tai54g+aiuP/kTbub+RY1VS9e7ZyaPO
         3FV/plDWv4vVxCsXSnqyTnhWgyyCXZHR4tKGFEXQNy/KRbW3y70tIiKburGK6xrdOoUg
         rUHKlsifMKyuwQZ5pSu8vDzzKVddmbPUrdL2vhUNmYQx2SdLh5JwoUthCmyANxDlRoea
         FDghV9wBdpO7MWw8iXitbN4pOyuP4sfBzqNUZ1PlNilBrhfmbj9y3IDdqjekZqluOXNd
         54fakGnvgLOaY/5Ywy2PeElX2Ps1jqMKLgGceLRiwpQKsc39jOz6LcAyseWjDhmMnOU0
         ukjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791493413; x=1792098213;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jXT5xqnUz/gqqG3F9wxnjnCJ7kPBk+m9Im3cz1NP6m0=;
        b=U3UaARBNUsw9TurCEYdjKa4iClNhJtg70fhQEwlfolqyxU05QO4IlQ2Ex6NW1BktXc
         tZ9hJ56ghXjHlQMHKGWQHG9VdJEdvnR2lOlaFyI2IqgJRmro5VbI7Job+eLaY6v9puVk
         tpVkF94Qx39g3TB9uKnLSV5zZtTHoNIlWHK2uG3BR/KwiXJ+ulGGDVquQPKt9hYewafG
         GUk/rFEl86ib3iIgeThgaahw1hhZc86/H2N4amVdCl4e4NtvrZi4Wa36CKZMbHI5GNgr
         JKfdil9H+WBE8t4AzK79cw70nSdjUWIzDbPxJmP8+9ZqrNeruebmJPJCAXAfVu9LksCl
         xn/A==
X-Forwarded-Encrypted: i=1; AKwUvBwI5LIvfOfTXY6D5E3gfmJP/ngSmy2TPcibYyhhGWj5r/0i/45C85KyWtn4lt7MPW1xeTvKFos=@vger.kernel.org
X-Gm-Message-State: AFuF++nsKQsCwOKFF8kEkOnMqmH7CbqC7h5NJBYEQEE5BRS7qau/FDWF
	uUnqiZKvYFjW2/9UTBb5XPK+Aj0ToQe4JKLKf/vzklU3JZVmDxJcAYiA/ViBTMXkuhE=
X-Gm-Gg: AYBFou1HowdslrM7yhCr92of10s9v0eC7LBbV+nsJFclmifdouLTehBAzBu+g5sw6/v
	kJoEGPDpawrf4Ofky2MFlfj0Balhg0J5HsLC1PbfzKy4CB6d6HrLcN/RRWXpLhSIT2SWnj3uHcB
	XGBiFZ5oM5cPINHpONkeFHahw6p0CxG9aOYFA2fFe1SnSDv7rZp/UF/8m7eKdwJz/BOYJCGayxC
	h4pghvbiB40XWwwggkm2sWqM/KiAs9xupyGEWSpdY9gJnrtOZWRPnlVjr3OR4XROpPIfcKfeBEK
	acIYb7s1bYdPus5TasfDkJro0Sf/sC3Nfvnqc7W2lMopG9oucG+7yaDUdxOOxSMPq0bR9xvnz+J
	6ymG9VeV5ZbiMvGuJGUxECzzCFdtBes1qqapzlb+ax4uIv0E73XCACLUc4UBgcsn7q7qlUH7T5i
	gGc40jOGLogQaj89V/+WnaImY4tS3eatHpRtrsLGfuZFSgwlDj3hdRAmqw2rNyr9xuPjgyaEY8m
	5Q8hdHvAxX3lNM=
X-Received: by 2002:a05:622a:1a91:b0:535:70c4:9a94 with SMTP id d75a77b69052e-535757c8eecmr123953171cf.74.1791493413537;
        Thu, 08 Oct 2026 14:03:33 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.246])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5359b46dda0sm3472151cf.4.2026.10.08.14.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 14:03:32 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 08 Oct 2026 21:02:52 +0000
Subject: [PATCH net-next v2 05/10] xen/netfront: check for failure when
 pulling in xennet_fill_frags()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-b4-pskb-pull-tail-drivers-v2-5-8f2bd9bee138@toxicpanda.com>
References: <20261008-b4-pskb-pull-tail-drivers-v2-0-8f2bd9bee138@toxicpanda.com>
In-Reply-To: <20261008-b4-pskb-pull-tail-drivers-v2-0-8f2bd9bee138@toxicpanda.com>
To: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Eric Dumazet <edumazet@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Juergen Gross <jgross@suse.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Manish Chopra <manishc@marvell.com>, Rahul Verma <rahulv@marvell.com>, 
 GR-Linux-NIC-Dev@marvell.com, Shahed Shaikh <shshaikh@marvell.com>, 
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 xen-devel@lists.xenproject.org, intel-wired-lan@lists.osuosl.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1791493385; l=2516;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=eg6ZiA9VrIpAG1HGYjPkKMEWwjo8D3VwigBhj0jOQMI=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QAYzg3nASJLuLmRvMNvnGKJmwP15K/QJrV/X+gIw+dmiWX6S/LgMrQ8OB+kIWHKPWdMQHYgaFiD
 sh9Hj7FexRAU=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

When the skb already has MAX_SKB_FRAGS frags, xennet_fill_frags() calls
__pskb_pull_tail() to free up a frag slot.  That frees slots in two
ways: it pulls the start of the packet into the head, and it releases
empty frags, even when there's nothing left to pull.  The second part
is what commit d81c5054a5d1 ("xen/netfront: tolerate frags with no
data") relies on.  The return value is ignored, which works out only
because the nr_frags check right after it drops the packet if no slot
was freed.

Use pskb_may_pull() followed by skb_drop_empty_frags(), and take the
error path explicitly if either fails.  pskb_may_pull() does nothing if
the head already holds pull_to bytes, so the BUG_ON() for pull_to <
skb_headlen(skb), which protected the subtraction, can go.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 drivers/net/xen-netfront.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
index 2ed673649c48..007fa3bbc9e6 100644
--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -1174,18 +1174,15 @@ static int xennet_fill_frags(struct netfront_queue *queue,
 
 		RING_COPY_RESPONSE(&queue->rx, ++cons, &rx);
 
-		if (skb_shinfo(skb)->nr_frags == MAX_SKB_FRAGS) {
-			unsigned int pull_to = NETFRONT_SKB_CB(skb)->pull_to;
-
-			BUG_ON(pull_to < skb_headlen(skb));
-			__pskb_pull_tail(skb, pull_to - skb_headlen(skb));
-		}
-		if (unlikely(skb_shinfo(skb)->nr_frags >= MAX_SKB_FRAGS)) {
-			xennet_set_rx_rsp_cons(queue,
-					       ++cons + skb_queue_len(list));
-			kfree_skb(nskb);
-			return -ENOENT;
-		}
+		/* Out of frag slots: pull the start of the packet into the
+		 * head and drop empty frags to make room.
+		 */
+		if (skb_shinfo(skb)->nr_frags == MAX_SKB_FRAGS &&
+		    unlikely(!pskb_may_pull(skb, NETFRONT_SKB_CB(skb)->pull_to) ||
+			     skb_drop_empty_frags(skb, GFP_ATOMIC)))
+			goto err;
+		if (unlikely(skb_shinfo(skb)->nr_frags >= MAX_SKB_FRAGS))
+			goto err;
 
 		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
 				skb_frag_page(nfrag),
@@ -1198,6 +1195,11 @@ static int xennet_fill_frags(struct netfront_queue *queue,
 	xennet_set_rx_rsp_cons(queue, cons);
 
 	return 0;
+
+err:
+	xennet_set_rx_rsp_cons(queue, ++cons + skb_queue_len(list));
+	kfree_skb(nskb);
+	return -ENOENT;
 }
 
 static int checksum_setup(struct net_device *dev, struct sk_buff *skb)

-- 
2.55.0

