Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815AA44A3E7
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 11:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791459334; cv=pass; b=b/aDDU3w/3I0HGWvGq4BHSJAnpbGaucYPXn5fkx/KrKUp+S3WL8CGyMM60I9XAZkmuFnqVg0WDmdSu9ukIEeN0f8L70iRs6e6H3ciUR1eTwL/TcPlwgNg5qtjCj53mpuhHTrYMJJtIquzKhvO3fDfP0h8/MGOOhLyX1LBYJ6sgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791459334; c=relaxed/simple;
	bh=qwS80d1Sq3GZmTtrcuSn4QH3WH9VVgg1Y27sZBwjsZ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bN5fAnv2NIU9by3lRR3nyqqkAZGB+cUAN3tTyXnqalTweRZNdol3kuvccUNTp+oJn5zq7NUPzf93knEEy9t6X0gODPf2zuzajD6GkAGa0X5AehuFCX9Ih23iFm+0CGZVwT1Uj0G4VQKPfcUo2MRyC3xTvnRIaVdNHMROvrQYq6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sairon.cz; spf=pass smtp.mailfrom=sairon.cz; dkim=pass (2048-bit key) header.d=sairon.cz header.i=@sairon.cz header.b=gftZ58rR; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sairon.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sairon.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sairon.cz header.i=@sairon.cz header.b="gftZ58rR"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2df8c28a0b1so17494955ad.1
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 04:35:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791459333; cv=none;
        d=google.com; s=arc-20260327;
        b=eQ1M9n9ZObb4/ufUvDDtJqXKmnka5i6xFS3nvcbpMrjs2llThf7OhsWXtOPrEelHF1
         Y/sx9jhjdrCyCUiG3cu9Ea7qyRZ07o5j3lSBCWO2s7eBFiFy8aJfyCYo8bUwIyZDk6o4
         WwHq8iy6agn6mWNNmAWXYx6YL4go0bDYGj/F2G8FYh+D3SRlagk9yDKWVXEiY/TuQzDP
         g6Cd55UZ2IORPyq8k03wdq9v0I0SPI7lj+TXAEFsvzuEKDABzwBwEQqHzjTRqYL4zzNY
         ryfHs3GhCZpipNn0/tBuKi7m8lB/EnKxOE2FAFRNZHjBk7LXWsYs3Ck3F6U8Tg2k5kch
         7CcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=WJ0j6cOAzgWtBhqKOpMaIaa9HpzVeoPjmiPtw080gpM=;
        fh=qiDQYUlgz59nkG7bA/bYtNJ6DbYJBQgMM+3iJLk8VuU=;
        b=T++vaoqE6L80TS+YrJyjErKA58JdiVULJ+ZG3nnrIPjaWdFQHLMAIMYgSlPVlmgEBP
         FmvDSqeIQP0letR9A51MIBD8Wlda7+hPVelzIvnM+55S4gq7Rh2I5WZfxRdep0tmwZG1
         pVo/AYTH+V0Ct2Ro2P0Se+Qh6fbr2OQtfi4fOGkc22E2NiIgxosq7pRakspnjj1jeA2e
         uM29GuyjrXOzswNWO/t/66cf5lEv6V0utNR7jOi1C3XlpORiExvX2Wd7nKkqo86s0LZu
         TFfnnG8Iu2qOmmDuae4spU+oTIR5M4jd/oTjXBq4u7Es4y9nQ1fggTnJ3krxAOhTFwjI
         cVmA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sairon.cz; s=google; t=1791459333; x=1792064133; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WJ0j6cOAzgWtBhqKOpMaIaa9HpzVeoPjmiPtw080gpM=;
        b=gftZ58rRoGgxYAhe/FtQZh1dcTPnEdH+TN2L0gEXc7m23OeyFfJpNQXJmFdIZe+KRi
         zJ23HbEsI7DOK0Q/o33dU/IIhhPwiRle9yp7tj7o3Vhf4twFcVq8Ng1kahSWPotI3jJQ
         Yv/wvg0wAk1tk7mPaUZiJ5UPBA0twGgWEPfzkYM9fFBa3L42nRxARrbeCyrt6KAn1O65
         u9gO5kqc78DrJJtGqAxnXOi6MoHKhsNdibo4u4Vc9DDMr/WpweRN8CO2s8jvSMIAbWXy
         3lEi5zbQGwu76BgGqFg6YmoWznorm0qdJLMADp8mBnTLmcnhvo1BkodEKz1hbq9RIYGt
         td4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791459333; x=1792064133;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WJ0j6cOAzgWtBhqKOpMaIaa9HpzVeoPjmiPtw080gpM=;
        b=xSzzAicseX185nyVabrTUPvdXumqqkv+jKsT1VEG/UsNbX0dEJE913gy2yfa6Ka+qe
         OtByBPlgVX4cqTweSY/O3MY10knn/ng2Q/oYUFf8ZDfwCDPgqRlDVuUHCqeFMgmVqBZU
         oY0H0O6UQpZMSD5qfeJvOzAVzrkQJWQe5qANisPkACsF3N9odbt9S0DIL6SFzCALbrig
         0EapDKmReT/xipWrS3xsqU8RSEffxDJqfvOXGSm8CT/EQ6hptJCekw0RkI6JCtF9Mjp6
         ReHunQbOPzH1xg8fCwA/LzPxSuHYIPxRsx9+0vvh0W4amCnBuStdOqT7Rj9qMHClQZgS
         hANg==
X-Forwarded-Encrypted: i=1; AKwUvBzpmEzQaTL3eOaOoS0XlWHCjEp4XdULXAbvhyt+KVB9ANXBYwWbprczLfV1MNDTHbzv2NGfjEU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKIh3WJdnVXVzbTK7G3S6l7qgmuAHCgf35I512fgL5LnmXs7U/J
	0sPjaBNF19V5CVHzrYvpmymTfGGMri9RReUYCnP++OxOZdoddCSyzoNHKh6jEtSz1w0QWwbnS+x
	YsA3fMIhCZL5cLEvH7a5K2hVob/BhDlTeapBFxUHRHg==
X-Gm-Gg: AYBFou2cXsMB3VTaRb42KOeEnGPSXJIa3fWbA2uv+fd50JEgn56PifSN547hrsFoO1s
	JbUq+W7le6BG3asHxkcG7ZvtmJ3twhdCS6jVRKS+DgTMNMacCvR1J0gFvjne3pfNHS6FhbhKzKF
	dKRZzFRJ2+bbLBhNrt+Rcufuv2Y64RhZV69DG0cJa0gV98AP9PcRq7kSsqGOLsyd3XEViFqxvKD
	Yb99e5NdXp0cAP2HmMN+s9vzHVUyKWzLyp8kUgUa+Magwx9VS5tALZ+5+seVGhzWoWLFDGjEJbB
	r2wqkOQJ0JjgnXWZSsWYzoCUIMq9bOFLdGx2n1p/rNULVSWhr1+LzDq/QwmqOBr750DffViymrr
	5vnVAOtPpzDP9zcuOW84hUQD8SJ/4fID4O8hbAV9lL7qtBDzRjnc+fE9k3cxbNlrXO9mM7inTly
	A=
X-Received: by 2002:a17:902:f78f:b0:2e8:b51:a94a with SMTP id
 d9443c01a7336-2e80b51ab89mr14161265ad.60.1791459332533; Thu, 08 Oct 2026
 04:35:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPa5EdCj3v17tB-SF2JNecq5Q8s1Pranr-XzAFWNpNTBPgPG7w@mail.gmail.com>
 <a6193df2-98f3-409f-b73f-5b91835a0107@kernel.org> <CAL4WiirwF6bZwocErCthJ+TUu7wipRfSibRBoKWjjkA2nVSrqQ@mail.gmail.com>
 <CAL4WiiqSmW093PDngLrUNiNA5GVKeM3+tAO7KMDJeyjYZ7GRzg@mail.gmail.com> <4c98eff5-c8c7-43ee-b59a-adb833978816@kernel.org>
In-Reply-To: <4c98eff5-c8c7-43ee-b59a-adb833978816@kernel.org>
From: =?UTF-8?B?SmFuIMSMZXJtw6Fr?= <sairon@sairon.cz>
Date: Thu, 8 Oct 2026 13:35:05 +0200
X-Gm-Features: AclHuK_tvli5e8RZKmXkQP-Qa8CuMz9cFdX9rYwTM6ujlWxZGIxES2B32YmtH_I
Message-ID: <CAPa5EdDk+HuVP0H1+iqOcHDHZnfdika5WOQcgSaMtfRFWzqZ+Q@mail.gmail.com>
Subject: Re: [REGRESSION][BISECTED] r8169: TX stall with checksum offload on
 VLAN frames with inline tag (REORDER_HDR off) since 1517d1996b52
To: Eric Dumazet <edumazet@kernel.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org, 
	regressions@lists.linux.dev, stable@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, nic_swsd@realtek.com, 
	Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Eric,

On Wed, 7 Oct 2026 at 00:00, Eric Dumazet <edumazet@kernel.org> wrote:
> Note to testers:
>
> My LLM agreed with the change in vlan_dev_hard_header() (above), but said
> that no change was needed in vlan_dev_hard_start_xmit() (below)
>

I'll need the patch applied to 6.18.y for testing, as I can't test it
personally and I want to provide testers with the same kernel/system
version as before just with minimal changes. So do I understand
correctly that the patch below is what you want to get tested, no
changes in vlan_dev_hard_start_xmit()?

Regards,
Jan

diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index 560521cf596e..67648152add8 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -49,42 +49,14 @@ static int vlan_dev_hard_header(struct sk_buff
*skb, struct net_device *dev,
                                unsigned int len)
 {
        struct vlan_dev_priv *vlan = vlan_dev_priv(dev);
-       struct vlan_hdr *vhdr;
-       unsigned int vhdrlen = 0;
-       u16 vlan_tci = 0;
-       int rc;
-
-       if (!(vlan->flags & VLAN_FLAG_REORDER_HDR)) {
-               vhdr = skb_push(skb, VLAN_HLEN);
-
-               vlan_tci = vlan->vlan_id;
-               vlan_tci |= vlan_dev_get_egress_qos_mask(dev, skb->priority);
-               vhdr->h_vlan_TCI = htons(vlan_tci);
-
-               /*
-                *  Set the protocol type. For a packet of type ETH_P_802_3/2 we
-                *  put the length in here instead.
-                */
-               if (type != ETH_P_802_3 && type != ETH_P_802_2)
-                       vhdr->h_vlan_encapsulated_proto = htons(type);
-               else
-                       vhdr->h_vlan_encapsulated_proto = htons(len);
-
-               skb->protocol = vlan->vlan_proto;
-               type = ntohs(vlan->vlan_proto);
-               vhdrlen = VLAN_HLEN;
-       }
+       struct net_device *real_dev = vlan->real_dev;

        /* Before delegating work to the lower layer, enter our MAC-address */
        if (saddr == NULL)
                saddr = dev->dev_addr;

        /* Now make the underlying real hard header */
-       dev = vlan->real_dev;
-       rc = dev_hard_header(skb, dev, type, daddr, saddr, len + vhdrlen);
-       if (rc > 0)
-               rc += vhdrlen;
-       return rc;
+       return dev_hard_header(skb, real_dev, type, daddr, saddr, len);
 }

 static inline netdev_tx_t vlan_netpoll_send_skb(struct vlan_dev_priv
*vlan, struct sk_buff *skb)
