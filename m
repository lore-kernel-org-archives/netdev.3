Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5B94A2A50
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 12:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792328342; cv=none; b=bEyeR7gZ0f/wXySDRBv5P40s/tVmfv3bQfYjKUpv1Gb0e0cfBl6Eohh6Ei/OjW9YI7mrx9o1osKsuKOp8vomdt2PaVHL8mKiW9qtgNmbU1Dxi5cj2kh3ImdwtAbK/Mi388MlkhxORweBOERmomhlJfCOjreCeEqm3Pt2jA+WCCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792328342; c=relaxed/simple;
	bh=xih+s2KFtttYTx6T74aVSZMuDsuhlUy7Svwh5hrbQI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qie+4b53ksswqGfDmSxQ/XAUYy5kByDgckPsEv+vQxhPxXy4Ld+qUtNWdrtKHgdlkvjpb3oApY69BqByAuX8IdDYXqs427fGz/DM4ON8Pdh5LQ5Ff6AEVQfx9DCoMFoLbWqRuhOEZ07xNg21J6X3uuSfGKVRziGADuPsN3n9fEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de; spf=pass smtp.mailfrom=bairaktaris.de; dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b=X5X/n7Yk; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b="X5X/n7Yk"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6ae27f06c2fso2126092a12.3
        for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 05:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1792328339; x=1792933139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bv1EJmOK7h8sNxkOvCcPCKfg9hj7RXyfrxtzfcwxHvM=;
        b=X5X/n7YkkgWgkQMDYSdEVQRD4r+5Fz86d1imAGRBLy9er5bTVxYSQbNsHkN7UqeE7k
         xzn549gJwTTtWUIc5DmapF+o6oD3PI+eSgNh30HUxodr+ijJOf2SghJExs64Tp5MOKdB
         q8cU0YwAXOEHpa0QFOaERX3JkUUDBxm+c3Kg4CXSKF32WvKOEC897CWGZ5t68x+c68Gn
         6Q8l9otyaz6ewk9VCKM35cX4oNn3tSzbBH1jECw6I5jrHUAfB/NbVvXea3p4iQ4HNsBC
         mFmEA8zyar/b5ImPUjv9PxPO305EKWR1vBjOhuYQejw5D92pbTMZWLw4/9AsgOfs6WEg
         B/ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792328339; x=1792933139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bv1EJmOK7h8sNxkOvCcPCKfg9hj7RXyfrxtzfcwxHvM=;
        b=2JcPQe8v+39UB+rU1Wa8Ut8etvaYb7m5Pzt2pY2RGCjFvjpshLsrRLTID+I86kBgKZ
         q6vldeXyE8eJDoeAGP1TcrLsvFGMfh8+vKPLhRrSfCsposIKqP12UrUosqolHS/31A5i
         TVJy+uyF25f5sPVxJjInQlIg+ThVyBb5l+BGbMBBK04z4HjfPJE4I6wx5scbJm7JTSOR
         qSEdBn8EYF5b2qMRLywX6rVL9TcJe3VM9j+N7aVttxPi6ljagd1DXgYnJA2KWlocEVdm
         sg4j6Dy89pdQg1ijCL2QqIeqPqtq/BhB4nIiJ4uDSrbW8RPGrSzsZUmg8udUBCE2zCZX
         wogQ==
X-Gm-Message-State: AFq9FYJx8V4gCcjgP7LUkzaw4t+wcDuySTzHjJ3EwY7Ll3aKlmkmHAUy
	zY9P2ooHShYmxck52iyWXZ5PipumAxFLlapTiuDKmO8bajc+8kaejZW3yGuPhsMLCJd1N4/sjdU
	RWgPfqHnOH9E=
X-Gm-Gg: AYBFou28qJuYH2S3vJaewdNrajQZ8Tnvlqyn34LAFNmiVL0XJZQbE13EDfAssPqxClW
	TNAsY40CZsnOOYEEv2cwbxbtphcwFmrJw5zlEvnvmqe0ikJn7+qA1p520CC4SUMdQUwB7DXjwpU
	nes7gCs/Az/UPaix9SBChP2rCmg27OfKP11MBYTn9jKkou9sH4CgpTN9yZ85xWtjY3ZnzirrICO
	6zf0hm+yvY1z/MkB9zYD7j6NILfTKz7tPa+IoZyaNkpyiGmpWx4zjoIs7n6p1N0uSDEv/SNJsTL
	nXoXt9dXYCyIA3fW6fFFPpTvGKLI4hC0J32K9kN/D/csVRhoVjgQ1PZcEvYFH/KuSI2adJ3aaNX
	rW2Bc2r9fVMu2dUuOlA+gIlBTB3rF/ceB/RgHIFzlS2mQLqdOHr4gziHV6mHvNXlHr3e47iwZY3
	V6wuDuYvpu1aECgHVMpjWKL/cZaoVCJfFrH6rURqby26yYtJZ/O7kV8ft32XxGOpa/fnTDuw9oM
	/PgImU/u3duDacIZ9r13o2XQG9+CQHAwbPIuqnG4Z0bXNgi0xSrYaKrXSRKLqO2RPHjgy17ijww
	DatQ9IwlYyS1GTikdNXlVdom3X9EJYM4rMrx51y4UC9RjXsIyID941/2iSNVd4RqoSUERzApfeM
	xilbpwGQNDCaw+uJHMvwGOlI4aL3VgoUEt6S7m44Jxw6G6RzqeRoKzwm9XPuJp93vmi2BPYpnfE
	7YFykdUKgG
X-Received: by 2002:a17:907:9720:b0:c24:6f60:3f7e with SMTP id a640c23a62f3a-c419a846304mr373018066b.2.1792328339174;
        Sun, 18 Oct 2026 05:58:59 -0700 (PDT)
Received: from Desktop.fritz.box ([185.181.130.213])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c40912ce05csm259032066b.33.2026.10.18.05.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 05:58:58 -0700 (PDT)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	steffen.klassert@secunet.com,
	willemb@google.com,
	jiayuan.chen@linux.dev,
	mfleming@cloudflare.com,
	almasrymina@google.com,
	bigeasy@linutronix.de,
	richardbgobert@gmail.com,
	ecree.xilinx@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3 1/4] net: make room for the tunnel header in skb_segment_list()
Date: Sun, 18 Oct 2026 14:58:51 +0200
Message-ID: <4e860f6164233f06f80a604047d817322a0c9870.1792327155.git.julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1792293419.git.julius@bairaktaris.de>
References: <cover.1792293419.git.julius@bairaktaris.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

skb_segment_list() pushes each frag_list member back to the outer MAC
header and copies the tunnel headers in front of it, but never checks
that the member has the headroom. A fraglist GRO packet forwarded into
a tunnel and segmented in software then hits skb_under_panic() on IPIP,
and on VXLAN the copy writes before the member's head (KASAN:
slab-out-of-bounds write in skb_segment_list()).

Call skb_cow_head() on each member before pushing it.

Fixes: 3a1296a38d0c ("net: Support GRO/GSO fraglist chaining.")
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Julius Bairaktaris <julius@bairaktaris.de>
---
 net/core/skbuff.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 41beaf625421a..3f358c0fc0483 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4729,6 +4729,10 @@ struct sk_buff *skb_segment_list(struct sk_buff *skb,
 			}
 		}
 
+		if (!err)
+			err = skb_cow_head(nskb, offset + tnl_hlen -
+					   skb_network_offset(nskb));
+
 		if (!tail)
 			skb->next = nskb;
 		else
-- 
2.53.0

