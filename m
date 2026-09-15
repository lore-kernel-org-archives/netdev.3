Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC1F3D45F7
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 08:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789461122; cv=none; b=Rq7z+tShLdGgV00LARjHkQ+0MCg6PPLJCdm2PtQxzgsahgh9eiykgGuQCt5erbJhQxg8t2EqXqmqlAWBgBAk1/LZ9Af+OzmYhUnHzjajiA8zszFDGDJk7Y3zzrF0tcDRwwRg2hR0G8kO7cD+B0CjD+p+F/AVbKIzD28YKu3081k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789461122; c=relaxed/simple;
	bh=Dycmcp37qz6R78WFWXjA28lq3JBfvKhCYGVidPoIuwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pYYaFrUTHnmq7gUCTmxTDn35T1SPcbWx7XG3RP5do9qHOUfKt0K+2SCoSA8WCFPabY0r5Wvujp1wI7aMjGIEZT8bQ46NTYuvTABh6I155JNLd0QdSlkJ6xbJzwawv0LzPBdgtgcrtVRUUSu6Vhi7haRxY6mKVb/rLhvnTnI03JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kQ3u7P6w; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQ3u7P6w"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747ed6d6eso21991245ad.2
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 01:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789461119; x=1790065919; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UbV7XQLbZlfCHs0VBxXQwGcD6a80bHzq9vR/E1aGc2k=;
        b=kQ3u7P6wowJg39qhjXHNAWHwLvgZ4nDf3O8psPyKFT654aQyLLXQen1IoeJjorxjMV
         5Dj/9PoRlPU7xe10/vofwZEfa4tp/U4kFix0jnO6syrdrqx9vHLm36JREBWOdezUkyXS
         n2GqJJ1loQs6vNCf9f0CNt8RP6Ex7Xw3R8nwhZ82xqdHJLXfOaYf1IuNEoyoqh+z8TOM
         4jhUO388MPVnxBCS8WnvSP1/J3rssUdMjxA3u5iDYX658XFh8oTlRc8bJ8EKr2ul0nxC
         OvT0/7w64X8nSSwFdjQpHtbj9wdOTaq2WAUADYnY/TstRg0WDUsmdJeXLiqdd9tlKqM9
         +xRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789461119; x=1790065919;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UbV7XQLbZlfCHs0VBxXQwGcD6a80bHzq9vR/E1aGc2k=;
        b=oWllZv8/O4Zvx2644LjvVvxDGf+WZknPT9P8SosERtlqpkUC2WtvLb/NTMZ9CGqa5o
         fYNIH7n13RlXO91ullFkMqA/adjOfEn36bsM3BIkyDRB/gb0w9MpAIeHgrORzETv5GlX
         yAmbh41Ye+UhGuyh4n966PkPEeFYcViMqjOiGRAHEUFHQ6TzrW87nT4vm5HmSrbOS/hi
         +SjPNGMQc2HxXTk2IgxptPzYokjFBUNdg9rV8knL6I3Fecc4xCL2Fvt2uyttjyWGbuRb
         D/RUWcWRjHv3h+wb0YF++vV9569hEr0TxtIojg5nz47y+Q+5RJaR513iwk9G77NtJ78d
         hTmw==
X-Forwarded-Encrypted: i=1; AKwUvBwxB1EtGZWoBwtaPiQKQUUS6bVYmJnu7zrcnXv9ICkB+6xoZ4lk4EMpFz/Vt0D/dr9eqjGWyLk=@vger.kernel.org
X-Gm-Message-State: AFuF++kG6uKGKbMKRAcpo8craPHWMRQIrLXThOeDlHiX8YnxkYMvw0MR
	gxxBbHGbZbTbqz2LiJfYGaRHr7+awuzeJ1A4Dm240bCp+ci0tlXZTrpP
X-Gm-Gg: AYBFou3sYWZomoWxdIt/2om4n40FzRiRzPNokj0oqvyqXw4jKYuny3XSXUIzwu9uvhO
	lI0gWnDPyn5z4Z+hcL53UR/btqNkD90Y3gx/Vx9xdnj9um3/+BVvekmHP6Iuqv4Ll+fMgCMvPLW
	5rpef8Dfo8Y4Q3c0X+D4ol0a5vbrtgpU4RnkON9tpGugYXdjT0ITglniOyn6zCqsXwF0/bcX8jZ
	irQ+xeLOJPv3RAGgVMW03Cq7Z1RZZJnFstEDOAlOCHAXdE6LSljGmKk1GCYGkgHpAAtAEFz+6jj
	L3ZfO2ZxoRjfd0bQFGN4rk8OggZnyJuJGED2JfdMou9gDe2CAYKa8HgzF9baUgmaCk3BVgvWt0s
	+h7aos7cUYNqj9RFApmxxuQCpvRbDckjH+XkWrDNfaz9d5Pxg9SSTdCyMXAixEUmnTDdj5ODB4Y
	IKAdnk8JbcIUb7nVMH2vnsDWhvHLSzjQXDYddwiEi/u5MF2wzKARi6N+IOCMoxQ9Xv3rKM6wCEE
	905CJrjaN9vEMs=
X-Received: by 2002:a17:903:4585:b0:2db:210f:c104 with SMTP id d9443c01a7336-2dd6c6eb512mr140794795ad.10.1789461118326;
        Tue, 15 Sep 2026 01:31:58 -0700 (PDT)
Received: from [43.242.224.196] ([43.242.224.196])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4cf72dbsm34608277eec.3.2026.09.15.01.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 01:31:57 -0700 (PDT)
From: Roshan Kumar <roshaen09@gmail.com>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
 herbert@gondor.apana.org.au, netdev@vger.kernel.org,
 Christian Hopps <chopps@labn.net>
Subject: Re: [PATCH 01/12] xfrm: iptfs: fix stack OOB read in
 iptfs_skb_reset_frag_walk()
Date: Tue, 15 Sep 2026 08:31:54 -0000
Message-ID: <178946111414.531190.8806329997967238720@mail.gmail.com>
In-Reply-To: <aqfOg-hbkOP3kwW5@secunet.com>
References: <20260907093020.2228346-2-steffen.klassert@secunet.com>
 <20260908224803.1587019-1-kuba@kernel.org> <aqfOg-hbkOP3kwW5@secunet.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Steffen,

I had a look at the review and it is right that the guard changes the
len == 0 outcome, with one nuance worth splitting out.

The sharing branch needs a prepared frag walk, so the guard can only
change behavior for skbs that are frag walk eligible (head_frag set, or
all data in frags). For those, before the change
iptfs_skb_can_add_frags() fell through the "while (len && fragi <
walk->nr_frags)" loop and returned true, iptfs_skb_add_frags()
returned immediately on its own " !walk->nr_frags || offset out of
range" check, and reassembly continued with ra_wantseq++. With the
guard the same input returns false, takes the copy branch, and
skb_copy_seq_read(..., 0) returns EINVAL, so the in progress
reassembly is dropped.

For linear skbs the frag walk stays NULL and this corner dropped
reassembly before the change too: the copy branch runs either way and
skb_seq_read at the end of the buffer fails the same way. I reproduced
that part live on v7.3-rc3 today: a partial inner packet followed by
an AGGFRAG basic header only block with block_offset 0xffff kills the
in progress reassembly with and without the fix, so that part already
existed rather than being something the guard introduces.

The review's suggestion closes the gap for the frag walk case: return
true when len == 0, before the offset check. The dangerous walk in
iptfs_skb_reset_frag_walk() is skipped entirely for len == 0, and
iptfs_skb_add_frags() keeps its own bounds check for len > 0, so the
out of bounds read cannot come back this way. The reassembly outcome
stays identical to before the fix for head frag skbs, so there is no
efficiency cost either.

Something like this on top of the patch:

diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
--- a/net/xfrm/xfrm_iptfs.c
+++ b/net/xfrm/xfrm_iptfs.c
@@ static bool iptfs_skb_can_add_frags(const struct sk_buff *skb,
        if (skb_has_frag_list(skb) || skb->pp_recycle != walk->pp_recycle)
                return false;

+       /* len == 0: nothing to add, proceed as before the fix. */
+       if (!len)
+               return true;
+
        /* Reject an @offset that is at or beyond the end of the walk's data
         * before calling iptfs_skb_reset_frag_walk(), whose fragment-advance
         * loop is otherwise unbounded and would index past walk->frags[].
         * This mirrors the guard already present in iptfs_skb_add_frags().
         */
        if (!walk->nr_frags || offset >= walk->total + walk->initial_offset)
                return false;

The len == 0 drop for linear skbs existed before this change; I am
happy to look at that separately once this series lands.

Thanks for forwarding the review.

Roshan
