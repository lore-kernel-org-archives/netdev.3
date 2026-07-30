Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415E03803E9
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 03:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785381180; cv=pass; b=o02TYTcpacRW3LzCAOP8LEz+8uOjgfppF4eR0oQCwNZKoVi5h4zRoLeHqMSCWiFP6on4I7bkgfGAWO6HBg7vYbQ3H0ktgaa4DoZv516CqhAV6pWISte5Kj4mQhbuKCgPd9FsGrbzO32v0bTzWJEri/Xr2YEJWnREcCk+Z2DSZsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785381180; c=relaxed/simple;
	bh=In7RBCmHYZ09TNZOHM06Bg9lmsVQgh4FrpPRtcDavDM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=eeHvdK0FZX4Np9VIR6mtz9Gqc+juyuaN5RPJoWbEF/5XICRNxpbVuI810JXyqBMjU5R5zwecXpPkeBjq+qe87F5DKsSd6LngvA4AtgcmKsaNX+RG6mdmqXmNp6T2OVUQyzp1SFpjoUeyhD0HTYPs+0TZ7E0z+qRYIFR0TNeqW88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aronleigh.au; spf=fail smtp.mailfrom=aronleigh.au; dkim=pass (2048-bit key) header.d=aronleigh.au header.i=@aronleigh.au header.b=H4FLkDrd; arc=pass smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aronleigh.au
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=aronleigh.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aronleigh.au header.i=@aronleigh.au header.b="H4FLkDrd"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8f256eaedf8so14592586d6.2
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 20:12:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785381175; cv=none;
        d=google.com; s=arc-20260327;
        b=i04lqFeRHubJHO/wvDqjq6uxANGNVD9QDkMXe1HtJd3ITnxNxbJbFL4mFUHZRkYve4
         pLr9zBq3D9SJOp7x+SHTiuo78BnA+UZ3hJ3AS+urErjIIa+iIY7SfxnolAa4eGd6YZoG
         MFzW/5aTkjSGGaeE0Zrd9ZfE77R4/6/NHEQsy6yYk6pEaUJZVxtrk53VZncL9EMOlBNG
         tfh2XBVA/qqADxDeiun7pjqza7nJAWIaDaC0/OsERuOHlPys/Fk8sJj23bP83ISFxV/g
         sNVC2Xzc868r3Y0d8d646EJZ8LHwmdNNOD0fCWsVapDX/PxHfBh4gjwvLsovYzChM3hp
         0fuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=Xl6z19DhTD/cT0yvcBqIK1w93FTqqag56/74jr7/luw=;
        fh=URNcnYaPuXYJNykgNzrhuvWtlfYfYPIq0VRPzRvj+O8=;
        b=DH9v8nN6sU4yLE0uuANuDuwBDBZy5BUbfTuexP4Ffb9I4ReB/OwGnNJwqCa9YJuAl2
         yXBbiPWGOQB7+Yho8wBkxrRYXiG+DgqqIGxIESe3X61sjau8kt5fxVXfyfdawnrRIFra
         SB6RIk8FN9clQYtVUBjDRTYXwaV0ebuUEkjmdoeZFFw6j1bhxS+0T2/qA92wFE0gdDsB
         hY49jqP3bHdkkl4b9U531OOc530fDUavV2po92D2a39QtjB3LMdssbbsVpISnujggxH1
         wypfaBIP490QkKzVCN+ynmzSJwPPkNRKMa/mcPfTHRWejiMMJqZuGmooZyzPYh8UCbpy
         mINw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aronleigh.au; s=google; t=1785381175; x=1785985975; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Xl6z19DhTD/cT0yvcBqIK1w93FTqqag56/74jr7/luw=;
        b=H4FLkDrdqMLmLmB1yQVEnccoRUvnH7D9JYbPCUj0GxpFs4xJDevhKgVTP8/W4z9hKm
         qronvTo/mHKAi7dkFGokRz70rEu55dP/O8f3JSsCgoFd8WRHvqdg/yunZKIRS2HwL7VD
         Mi31ag6nhtjM4/Un9HO6Q/XzOCTJky7VRXkZNIKdDb5VYCdtFLYrq60Mf1Bv//In8x2g
         R4YcU8XVBBntDqa7LjF6WegRTv7+IggWcxvWeT19Hmx+8NWVcUT8F+jK+LIQWvK9ntyi
         6g60wO/R2H9/Ym1CQxnGwROFRfe89IFVDV6/KydrbalZ1AdOmMvftVb9s38QoBQlvFt/
         3oTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785381175; x=1785985975;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Xl6z19DhTD/cT0yvcBqIK1w93FTqqag56/74jr7/luw=;
        b=InUwJPuLbm3s1VQRAGjdAEvsG5p9dvGUYylpcgAEwIrHP1S8kT2NMFBpRqbBLmhqGT
         Nb/PnKBxZrYt4Hb5cujFnMjPpy+mnzXS7p3DTzs1I+11sKzIQ7HNyzg9RsUgTOV+dgqg
         /m0eGIoSkhtphJJuQsuGgK4vyL1QsdksMBGwFZdD0D8gegzKZYjLZXQUAu11mPaHvx5c
         M/LMcRQL/75s/tJg5NTRkqunXyRjD4hnom5hTEwAzEw1DZ8yuNNysN8i6APX8xnXszpi
         k0X1Q0Sspqtd4wuEKKefvoccK4Mk+kn+7fqejX9HZ5tv0SzIJSdHHBMvEwHxhb6DO4V0
         GE4g==
X-Forwarded-Encrypted: i=1; AHgh+RomS6RlJWnXGWpTv0Mu3dlp9uTaWtzvggYoJHnNYug1kQTGTrDI/8WAFBRi+Ur0gqLWUn4XE/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNkXk/3nKGUOa7ytFWlqh8TDX+LO8AoxoDz7XHxbhPXTU/vqTh
	FKLBfJhDlBK2gN64NilB7YUFVpmNa2bpsCTnioUqwjvaGnH0DDAWFaU4YR+pF209gjwr0EullT3
	syJKDY4reGeNA9JzH9BojiWu4H84FTspdl3fBL6hFCOQ=
X-Gm-Gg: AR+sD11NLEiz7ozcMDtlmIDWzZ2miBJmUo5nTjmnCDNVfwPLWGewGVmVpmsTOUZN/xJ
	piS9+c36RexLKdlqVkKHdJhtfad4fh/gBmmqPscn/+YdB9kyIzaf49dXPOQsrvOXrvNQoHC11lF
	8SRyamehM5MDnFoOuzdHRlGGV/qrocc1DxFAK0O/N2QbWmrsrgjf/b7qyZKGaM5TeorFoX2C+rN
	r/+Ydqv3C6nwUkToGGQgDAxZhhOT3tBkvhVIYCeN4otYdISljlH451LI4oiGuWYRaJ+ePoBIGEw
	S1U6qJSaJrEje+FCOIOhiz7swAybyzbg1f74eFiHfFLvnz6jvHDJU1/uWD9UifAkU6tCbQeS+qV
	gwCo=
X-Received: by 2002:a05:6214:234e:b0:8ef:24e9:4258 with SMTP id
 6a1803df08f44-908347a96a6mr7470676d6.39.1785381175505; Wed, 29 Jul 2026
 20:12:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Lilly Aronleigh <lilly@aronleigh.au>
Date: Thu, 30 Jul 2026 13:12:44 +1000
X-Gm-Features: AUfX_mypJDGDYQfaVRX13rAghU3NsXueNoz7bUo51S-X-Bl4N-87iZga62Hppng
Message-ID: <CAFrrV-O1fesaza+5_WqH8OciXRu9KKE4UsB6RcMamDu0j2-nBA@mail.gmail.com>
Subject: [PATCH net] xfrm: iptfs: avoid canceling reorder-window drop timer
To: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Christian Hopps <chopps@labn.net>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

IP-TFS uses xtfs->drop_timer for both partial inner-packet
reassembly and the reorder-window drop timeout. Reassembly completion
currently cancels the timer unconditionally.

That is only correct when the reorder window is empty. If the reorder
window already contains saved packets, the same timer belongs to the
reorder-window state and must remain armed so the missing sequence can
be considered lost and the window can advance.

Only cancel drop_timer from __iptfs_reassem_done() when the reorder
window has no saved packets. The existing drop_lock serializes this
with the reorder-window paths, and a failed cancel remains harmless.

Tested with a reproducer that completes reassembly while the reorder
window contains saved packets.

With this change, the reorder-window timeout remains active and the
window can advance correctly when the missing sequence is not received.

Fixes: 0756947654468 ("xfrm: iptfs: handle received fragmented inner packets")
Assisted-by: ChatGPT:5.5-extrahigh
Assisted-by: Claude:4.6-opus
Signed-off-by: Lilly Aronleigh <lilly@aronleigh.au>
---
 net/xfrm/xfrm_iptfs.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
index ad810d1f97c..02fbb8d781a 100644
--- a/net/xfrm/xfrm_iptfs.c
+++ b/net/xfrm/xfrm_iptfs.c
@@ -698,8 +698,12 @@ static void __iptfs_reassem_done(struct
xfrm_iptfs_data *xtfs, bool free)
 {
        assert_spin_locked(&xtfs->drop_lock);

-       /* We don't care if it works locking takes care of things */
-       hrtimer_try_to_cancel(&xtfs->drop_timer);
+       /*
+        * The drop timer also drives the reorder window timeout. Locking makes
+        * a failed cancel harmless.
+        */
+       if (!xtfs->w_savedlen)
+               hrtimer_try_to_cancel(&xtfs->drop_timer);
        if (free)
                kfree_skb(xtfs->ra_newskb);
        xtfs->ra_newskb = NULL;
--
2.43.0
