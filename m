Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AA049EC43
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 10:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788778364; cv=none; b=ighn72CNO9oFrmBHpwJVcyQv6k5uhwQZqfcJfSeBfk/in1K7usrFFoYRSNwFLqDd4y+UNf/W8NZ3Vi0EgCBoy2/yQUPb5ZHzpblzj53Io1GN0jszAmh8qDEJALcSPEgngvvnpSdRQDJpKBFaFunRvtBBayNdT9Il9nFpXVbotx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788778364; c=relaxed/simple;
	bh=h1ZF1W56dL6/r0RgWXJeczzYimE4P9maVag8fcLZjDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DKEAvoYYiOyEKn7f1G4IW+SE4DzgKP3p4+KN1RdgxE4gPX/l3+UDYu6t1j3nuuZhbN/EsXjvpoqs+ajj9GTS38NNY22zmquLrPqUbuKPPcWq4Z3f3S4rMlJT1iDXYZmuIZSzFE+EVLHBix3o/V6YNUdFiT2mMmD2kMu9lBkG2zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I3ovtm8e; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I3ovtm8e"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49b8e527d63so40477345e9.2
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 03:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788778361; x=1789383161; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=h1ZF1W56dL6/r0RgWXJeczzYimE4P9maVag8fcLZjDc=;
        b=I3ovtm8ecrLEol+Rv/dcvdE7ClSRafynHqs9bGBMsl6l0c3YhqoxcnG2EUatA0weLL
         AiJxfmiuO0pBsWsNkCtOJSeZ1B6czZCPujJQaqHLt5ZY4MQ+5G1Ng8bxwLGnjBKJfO+/
         GszhpThtsWyI0wbRyKSWYay3edEOxz7MD07q/Nx+4KhhjiQFu0EtyT192atHdMtyqfz/
         6Yk3/keX2j7NfUafeiXAtj38C9y6b5E7l5wHb4Su6l5V/ZdK3TaTmM9Y/R4qmcH1i23W
         87SAOydPUF00n9PLrVHv3asi2RqgMDsa3RLPkWqze+3xTlL3Fo6K5KURBvEtAmC35NM/
         w51w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788778361; x=1789383161;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h1ZF1W56dL6/r0RgWXJeczzYimE4P9maVag8fcLZjDc=;
        b=Hkh6yK7MHWMjyWFQIsknOp062hutMvpAJ0XGXiFxw9j36mAd3EqLUMFE/P5Q2Vx6Cl
         p5UyFrXyMkmdpESZGWQLVxoKPRq34Gzld7DEMUnOCjeOTCLXYU1gdHCX2eh9C7atno16
         AS16H9pvrp0zuks8JExJRXXaRlwbz0jRyYehWHTLGmfu1tt1AmiP8gvRlZBxMq4GzDsO
         JagZcvuonkxubemz08Q05txJT0tptcwm/AeR0teu/qGW+G11rJRS2YgUVFpVxw3boMA4
         lOvo06Sq26dFxQfvG0baxECi10ux3rr+OkHtQMqApv/lIhxXUKSjgwinCRS07HPE1x6Z
         xATw==
X-Gm-Message-State: AFuF++lXzU7kqbHRznaYZo2LKUefDRMq8AiZFrtwkipc5p/LNHBVDVDV
	nIEwT6/5EPQBWHhPXcSjwqPF9fa12eGsnN3CXJbcc27EdnrTmuEGQuNf
X-Gm-Gg: AYBFou2oAmfZXGarPXgA1TSn1mRk8YUqXjcmzW9U6N5eUzkkj/SGWA21UznCV5DJ/vT
	bSrW2NM4CFTghw71rvTy1H1t7qvx5hpM0ghKXXAnCuqr/s8Zh/lOYK4LYnbEisLJtKz4n9Lg0Em
	xSu8K8AxbxPgaBRu8taxDyHfalL85Xs04Ibx27ELUM9h7D5KY9Ce5gqXkUavupVeY2MDp1xgueC
	SgrBxLUwCRzjPq9X1dZi9Q0sOBnOpTWQcKdRRjJnyPKQJoPugCXNQFzUBBD3lh8sIigYczNyzCY
	RDyBdF+/a358GVAEoAzDlRSgtXiSCF8vMOmDkt7gB+qkETDHnujzqJTLdekxRzUV/NluQF9DFjC
	oMPu9TAuBne3JyPVZh2gGAZ8IUaDWkOolNtYUhj3yw2tAxNz9jUwk1hXwQcl9/frVgvh+xlUib5
	gsCpTjYV8j8xLOUwi+a4SKxQ7UtLcLzzjTNwMc4QkgCutDdhtAqgJxMUejH31HaBXhbVni1YZJX
	22pKIhxVf3laA==
X-Received: by 2002:a05:600c:3b02:b0:49b:9202:6f80 with SMTP id 5b1f17b1804b1-49cf8220edemr238557705e9.6.1788778360821;
        Mon, 07 Sep 2026 03:52:40 -0700 (PDT)
Received: from kali ([169.224.126.247])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cffdb2c40sm175663215e9.1.2026.09.07.03.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 03:52:40 -0700 (PDT)
From: Ali Firas <alishmery18@gmail.com>
To: kuba@kernel.org
Cc: netdev@vger.kernel.org,
	idosch@nvidia.com,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	Ali Firas <alishmery18@gmail.com>
Subject: Re: [PATCH net v2] vxlan: vnifilter: validate the VNI range in vni_filter_entry_policy
Date: Mon,  7 Sep 2026 13:52:23 +0300
Message-ID: <20260907105223.3960496-1-alishmery18@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260906231609.2995559-1-alishmery18@gmail.com>
References: <20260902154609.594009-1-alishmery18@gmail.com> <20260906231609.2995559-1-alishmery18@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I have the measurements now. They split into two independent problems,
which changes what I was going to send.

Cost per VNI, measured with per-cache attribution rather than estimated:
128 B slab (kmalloc-128, exactly 1.000 objects per VNI) plus 64 B per
possible CPU for the stats block. rhashtable buckets add roughly 11-21 B
amortised; the RTM_NEWTUNNEL skb is freed promptly and retains nothing.
So 256 B/VNI on 2 CPUs, and a full in-range request is about 66 GiB on a
64-CPU host. My earlier 521 B figure was an artifact of
CONFIG_SLUB_DEBUG_ON inflating the object to 384 B; it is withdrawn.

rhashtable cannot intervene: max_elems is 2^25 against a 2^24 reachable
key space, so -E2BIG is structurally unreachable. Every configuration I
tested (2/4/8 CPUs) reaches a global OOM instead, with no errno returned
because the caller is OOM-killed, and UID 0 processes killed in most
runs.

First problem, memory. GFP_KERNEL_ACCOUNT on the node and its per-CPU
stats confines this: the OOM becomes CONSTRAINT_MEMCG, the host survives,
and unconstrained callers are unaffected within 0.4% on both VNI count
and wall time. It does not produce a graceful failure — try_charge()
invokes the memcg OOM killer rather than returning -ENOMEM, and the
partially installed VNIs stay until the netns is torn down.

Second problem, and this is the one I had not measured when I wrote last
time. vxlan_vnifilter_rtnl_msg_handlers registers RTM_NEWTUNNEL with
flags = 0, so rtnetlink takes the locked path and rtnl_lock is held
across the whole loop. From a second namespace, "ip link add dummy0 type
dummy" takes 0.011 s normally, 4.47 s during a 1M-VNI request, and never
completes at all during a full-range request — it is still blocked when
the OOM killer arrives.

rtnl_lock is global rather than per-netns, so an unprivileged user in one
namespace stalls network configuration for the host and every other
namespace. memcg accounting does nothing for that. cond_resched() yields
the CPU without releasing rtnl, so it only addresses soft-lockup
warnings. As far as I can see only a per-request work cap would fix it,
and that would change uAPI since the full 24-bit space is a legitimate
request today.

So I have the accounting patch ready, but I would rather not send it as
if it closed the problem when it closes half of it. Would you prefer the
accounting patch on its own with the rtnl stall described as a known
remaining issue, or is the stall something you would want addressed
first, in which case I would need guidance on whether a cap is
acceptable at all?

Reproducer and full measurement data available on request.

Thanks,
Ali
