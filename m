Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D9F4D2EF8
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 18:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791397016; cv=none; b=ijBrl/mY84nKluyndkRw3LnzmA9sLY3o2BK8B5O5ZgRSHT0jSI/BIVEsnEwgt+oTijtnChi0SNCXSODM41Ab77tyGwDFM1hHtPboql2GLzjD25ABmhj+FQLjSGs4KZ1w8W+KgoOL1TzXkuNkgzcEmp1m81tvQMf535mZkVNbDlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791397016; c=relaxed/simple;
	bh=aE3S/MO9vLOemBhMvEWEtBv4CYrulZjUcAw8T5FEx9E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OPYQ0QvLRsE2GGANkqysXJ64M04lBb5zAHW3siaLcyOSlYA5rJo8bRF4IXlTB796rsfwibQCPijw+hKv5vSByDyT82PqJqiXm7I/9g/yt2zeLmIoBfQY3/zkJGPb0Pq15KqKtGBhDtgw35jTCHPewDpNlRf7fB20eP0lDxDexa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=phZMt/nm; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="phZMt/nm"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-533930955a4so19992141cf.3
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 11:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1791397010; x=1792001810; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DbLtENrG5I00kMX4i+UCiZIr5Qm/AkQbhE28uvMASeM=;
        b=phZMt/nmufB2UOX8QExs+B0insi7qEQd58keteUiSUff+59nBs+4T7aQ0NYM1CaM6m
         oIBw+vu471oZ/TgqD6oWPkHnN4iizvcrGhH1mFQgP+AzTOjEoss1lzpDEaCApKein7eM
         rN86Lfzv0euZe1WaJVvDrJmmnuvSJyu2ilmvwIj7tpUHti20nzP93I1eqhXjmAr2hdPB
         9E8TXZ1YjE8aeGgl45pgDzfYVwd0CNJYUF1c7uJ82DKtrruwwWm3rdgZ2wQIwI/xIBIo
         RENmXtgiytt7usnSxWAPCDSKVB6oR0ttFzqWZkZBw8r7e8AOwJ1/PQzQ2dJi7JaVW3kn
         dqMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791397010; x=1792001810;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DbLtENrG5I00kMX4i+UCiZIr5Qm/AkQbhE28uvMASeM=;
        b=B/D9ru6KOIM4X+e0yeH/t7V6UYVAI0NClS/E0Ojq3wNfFqBEr1Oh2eszyqSkPIicCB
         W0sAYKOhm74YS1tn/2KURPNqpcqFyP4Ah+BBkmyLqYnd86jFPyGdwFWumoT6WIUsGV+K
         9B5bXyWC7Ge1LhwaRB2nmDCS6pq7Rl+vGnJY1TDr0gzXHfiArfXXtXBRpDW0EPYIOUir
         UA7DotqL9tZTlWYhW6+/28a/b6rkOEul4t9M9AD5G7RA6gJQQWce+PFtkJ/VOhdxTExf
         HWiYJWm7bjvTA1VJRIvQ1Zrs9tWY5lLe/QnY2DXi/liR/WZlbkEnRtnCan3QiKyVkRVT
         qdTA==
X-Forwarded-Encrypted: i=1; AKwUvByIO1rAwzItmjMhp6WPgJJX8T5YMfh4t+U2LKYQFFAL+L2IgDO3dtCGlgk5O8qp0dCHMpp7988=@vger.kernel.org
X-Gm-Message-State: AFuF++mN6gdsoL2n5+3eYz09em2ZAZzruUPWMB1mTeABhYSe/MIQUmNx
	g9bDmE2Y5xC4y9r0QwFpUe+m0/lnygh/hUUUcyiVEeWEWX4jBcVsJHyIb2robxU3H/E=
X-Gm-Gg: AYBFou160WHuLm99HoyOQO31JjtBrBbPjAlJBCVItkUmU+EZ3elUVhymhwPvHvxV9tW
	9/h5ONN7lbcQLVUytVleRcN8e6S5JCdm3aNk8Mf6IAa6KMAf+cam6ZhXcZDn0DtdXSHb9w4FmEq
	4dwUr7uEf9LzIPwRaqsMQTl+shbw/irTzxx2tE8jG+krEjJYTGjcmf3MBdk5A16wxZXqRfXCeSi
	4Kt+IoRXoetROO2VjqNT9N0OskY61SXFzD9VNEWLcxExlSMizfPzenrff2de0MM4U2We9RHuEo9
	vf23Q4FEGlFtrxuc0E6qrhfoZSfC0mesKleVy8EKUS6seYAwATxzMoaBSXG+jkKQvv+cW1oKtQl
	MSZ+XmsQmWysWvYHg0HEWB4TbJiB2pMYcW+Y7/PN2Rw00klLqnrAfxZKygnktHroqxBNXV8hIoI
	G+M6ZBvTvA4U8LzkaDmbSXQPyffU7Dr6/k4k0aNSdrqNPQcrY7rVyPMOgbWfXySPBzr4KhgKSks
	jKqzAn5/qz865/gX6dwC6C5QA==
X-Received: by 2002:a05:622a:60b:b0:533:94fc:1e69 with SMTP id d75a77b69052e-535755237d0mr54333081cf.21.1791397010017;
        Wed, 07 Oct 2026 11:16:50 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.242])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5357214830fsm26034571cf.19.2026.10.07.11.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 11:16:49 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 07 Oct 2026 18:16:22 +0000
Subject: [PATCH net-next 9/9] net: skbuff: don't reset truesize in
 skb_condense() if the pull fails
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-b4-pskb-pull-tail-drivers-v1-9-9512b0fb977b@toxicpanda.com>
References: <20261007-b4-pskb-pull-tail-drivers-v1-0-9512b0fb977b@toxicpanda.com>
In-Reply-To: <20261007-b4-pskb-pull-tail-drivers-v1-0-9512b0fb977b@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1791396985; l=1285;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=aE3S/MO9vLOemBhMvEWEtBv4CYrulZjUcAw8T5FEx9E=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QAKmlD/cXgBiooOoWC6A+H7tw5dWzG4gHatAYnnjbF9tFpPNqC/1rDXMvdLjveUvTCKNu/kJ24U
 cYCfNc2tlrQI=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

skb_condense() pulls all of the frag data into the head and then sets
truesize to cover just the head, but it ignores the return value of
__pskb_pull_tail().  If the pull failed, the frags would still be
attached and truesize would undercount them.

It can't fail today.  The caller has checked that the head has room,
that the skb isn't cloned and that the frags are readable, and pulling
all of data_len eats every frag_list skb whole, so nothing is
allocated.  Check the result anyway and leave the skb alone on
failure, so this stays correct if any of that changes.  Use
__skb_linearize(), which is what this pull is.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 net/core/skbuff.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 43ebe61c7fc4..70df607da05e 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -7118,7 +7118,8 @@ void skb_condense(struct sk_buff *skb)
 			return;
 
 		/* Nice, we can free page frag(s) right now */
-		__pskb_pull_tail(skb, skb->data_len);
+		if (__skb_linearize(skb))
+			return;
 	}
 	/* At this point, skb->truesize might be over estimated,
 	 * because skb had a fragment, and fragments do not tell

-- 
2.55.0

