Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE99442360
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 13:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789911085; cv=none; b=TPL2poD4oPHYVz55G57WxRaUqnrYVTpVYB/Jlpx6O5bwHyNToidxf7EbSHA+ExW5YQYfYLhCryB6T9H2T/kH5O7G0aGuQn0vsqgZgnamt6XzgXW9pkRQsYmQuz1iBPQ5xdJNFE11VEpHP4GDyM+CxII6VJ9qd3fC1NAS2ySLhcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789911085; c=relaxed/simple;
	bh=fPaQkWK+fK32Dyr7B/S+DLhIcCTxdxkXCQui3ZKLhO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WcaGyjeMQ0spvUj47+Pq4/zXEUxapiGKAzwZmQNPyr/ZL+0mJMrY5PUegUkExAIWTNWAr6GcWaw39dAiBpPAyMB5KXbXuKU4z5Dr4B0DDK9Hs/yUzb9EBc7THmT6CARe9qA0pT1/k2MwmFJmlm04pMLnZE/LByHWz38rjaP3aok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com; spf=pass smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b=rhYoTI1q; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b="rhYoTI1q"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-8692a856865so2055776b3a.2
        for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 06:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20251104.gappssmtp.com; s=20251104; t=1789911080; x=1790515880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/395ug1pHGaL0BJ1839r8TpPmXHk1ghvOISHFNYH0d4=;
        b=rhYoTI1q2/v7c/HC1lQ9ssiSsdMh/uO3JrSMDxmGf/DZX50M1qSTxne1BngY4/BA1U
         yAA+TzkBSZbKdYhSuo2GPm0/PoPBknrjv/g1Ihcg5p8Fiz9wrdFLoimd2oVoBwIFAPWC
         CFTrjrtGAitZGYcoGN0ikkn6uDTeKC0WTyUqoB4TR9Ns8Q3DSvwDkwHFO+u58ZplRKRt
         wZYFO/n2qbFbfP4SzweYX63zeGjb9Z4YXwP3SdyNMRMB/andhWTN88khlCLkxoWkGkTj
         e4B6KgYw6SRFaR8Oofl3EQw2erWbDGx+Npz5BMJBWBQu9VoP/1meq8DArfJ0WSPZFry7
         KQmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789911080; x=1790515880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/395ug1pHGaL0BJ1839r8TpPmXHk1ghvOISHFNYH0d4=;
        b=WBSsWuFANrseXNhZYMv4Qqbn0v3SYbT9f2QOSAU2PD6vLlKmkaO7mYSkQGIBuyzisX
         O5QyTmhjJGuiqtmpBabUbORa3bfqxbm6p8aJ8EM1EqnWiDIJ8uLVqU1h0oisLh8lAzSb
         /tiQBdgXhdUaBnmPKmgGLVK/na+RrdmOBjNlQKwhSw1pW2ZGFeSdGwBrjTQynCCYk8qs
         fDfEI7CEPcdQgykURRIYByib+LNvWDTOnzW4Su6lmKj+Fy5yHfujTQHtRPb87HbFCbe/
         r+9m/bNQsvRsy4z2r7bhJMyRd0fjGfiEvL7HJaiUXbJcgqQ6Vmqj4EGD+jMF+93R0U8d
         VM1Q==
X-Gm-Message-State: AFuF++nC3w1FjedQTvBhFo2/Ubb/AjEbbY+UDKTYNPHUtJaW/K9PPOEH
	PZj/nzAbZRk7exBL/uyyb4Cycno/8DOKk+VdHuYjgWOF43an3cW8qSqTXRraINFO7Iiesqcz4bT
	Okqd+hAI/cmIMfYABj6UG/plW445RKD6Dram8bWR8KdAtFrRO8DV2tupUsNL2yRHLasmIRgs5k2
	z6Kw==
X-Gm-Gg: AYBFou0ZnI5TGxnl4YQjmZ9pKulSPbsM7Hr9rdj48eqMr7HdMLg+n1lZjMpuq6VA/lP
	qiUOTHKqeKLZrFdwUajV4ErgxuJQPSwECTgQdXr30fheFUBj6Tjw7C51Ju7vD7K/purpFBCJSmB
	hg8T9UrI/g3sTZVeng+mtmeW1Vx+BRy5TFz0iqemmBHZhSV49306lJlPXQDNeHiYKz6X0RDo2Dg
	SM/rZXgrMSKUoiMEKPeHtatcW1hhXyuJrPgzjqTv/pK/c1RuG2Sxs22WHIQKnVZLkV84F6Z8+1U
	UzVXQdOw8HnPZAvJEg8OmiwvXCfA7HB+4itrrJr1vleMLc2soI3mAUQ51GMR9nOY0DTzymet58n
	mqEWdHxyFb/8UOvQO8G0ngMOu1ZpPxX/24n5MXdKY7+O3RawkPV7SboBGaX91tXUd8wdEVLKJ7h
	DZWD0GoYi2CCiBY0DuJ3YLoh3kxjGW3qjNCRyQOfmXsKB9QZ+b9OcNArq08NhmLgCt53HfNpcaa
	a7NkAvNRiQ=
X-Received: by 2002:a05:6a21:2c11:b0:3dd:85a8:4c5a with SMTP id adf61e73a8af0-3dd8c57e0e7mr11753211637.33.1789911079720;
        Sun, 20 Sep 2026 06:31:19 -0700 (PDT)
Received: from localhost.localdomain ([23.148.204.241])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144da432647sm17850018c88.5.2026.09.20.06.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 06:31:19 -0700 (PDT)
From: Wang Zhan <wang.zhan@smartx.com>
To: netdev@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	keyong.sun@smartx.com,
	Ilya Maximets <i.maximets@ovn.org>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	dev@openvswitch.org,
	Wang Zhan <wang.zhan@smartx.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jason Wang <jasowangio@gmail.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Alice Mikityanska <alice@isovalent.com>
Subject: Re: [PATCH net-next v2 3/4] net: core: resegment oversized TCP GSO skbs
Date: Sun, 20 Sep 2026 21:31:05 +0800
Message-ID: <20260920133105.3611768-1-wang.zhan@smartx.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <willemdebruijn.kernel.32be703ea17ab@gmail.com>
References: <20260918084651.3022878-1-wang.zhan@smartx.com> <20260918084651.3022878-4-wang.zhan@smartx.com> <willemdebruijn.kernel.32be703ea17ab@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 19 Sep 2026 11:37:45 -0400 Willem de Bruijn wrote:
> >  	return skb_shinfo(skb)->gso_segs <= READ_ONCE(dev->gso_max_segs) &&
> > -	       skb->len < netif_get_gso_max_size(dev, skb->protocol);
> > +	       skb->len < netif_get_gso_max_size(dev, vlan_get_protocol(skb));
>
> If this change is needed, it is not new for this feature and should be
> a separate commit.

Okay, will do it in v3 as patch 1/5, with a Fixes tag.

> > +	if (!skb_is_gso(skb) || !skb_is_gso_tcp(skb) ||
> > +	    skb->encapsulation || mss == GSO_BY_FRAGS ||
> > +	    !skb_mac_header_was_set(skb) ||
> > +	    !skb_transport_header_was_set(skb) ||
> > +	    !skb_can_gso_resegment(skb, features))
> > +		return 0;
>
> Is this duplicating/extending skb_can_gso_resegment

Okay, v3 folds skb_can_gso_resegment() into skb_gso_resegment_max_segs():
one caller, so the checks stay in one list.

> > +	if (skb_is_gso(skb) && skb_is_gso_tcp(skb) && !skb->encapsulation &&
> > +	    !gso_within_device_limits(skb, dev)) {
> > +		netdev_features_t offload = __netif_skb_features(skb, false);
> > +
> > +		resegment_max_segs =
> > +			skb_gso_resegment_max_segs(skb, dev, offload);
> > +		if (resegment_max_segs)
> > +			features = offload;
> > +	}
>
> This is a lot to put in the hot path for a rare use case. Consider how
> to make this less expensive.

Okay, v3 enters on

	if (unlikely(skb_is_gso(skb) && !(features & NETIF_F_GSO_MASK))) {

features is what netif_skb_features() returned a few lines above, and
gso_features_check() has already cleared the GSO bits for an over-limit
skb, so the common path reads two bits of a value which is already loaded.
An oversized skb then pays one __netif_skb_features(skb, false) call.
Could you take a look whether that is cheap enough?
