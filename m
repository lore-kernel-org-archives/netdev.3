Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3CE352007
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 05:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787551013; cv=pass; b=Tnq6X4h3h7yckVjQPUKVTYH1kwkjiJiPtHaspVNoEBNVJDXbRzK/w19y78X8VsSQtDVnkBSn4xg/FYhXQPUaG/n7y+QIKMS3Cbhfaj/qQs3ss5RImgDa22Z+nxrbbhzI3wCSkKKg3qkpkllT3tn6JIRyb57R5t+YO8HdyxvZUE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787551013; c=relaxed/simple;
	bh=N/9gx8m/mOHBe82/8NV9/wNPFSUhoDxwkOc6O9oxnds=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=cBC3ZEc3L/Ry36P5n/LXtmXKbXqCjgVKpNFjdT75VyTIWhtY53pfEpVxpCGg6L77r+QX+pnCwtZGRfaRz7boqq3tTFUtcXxquJXDKq3uEt+tYgWK+PLYHyyFIQSe9lYz3v2+NEdyRcC6HJuULx/TUr0ONpC7s6tvkuAgqqn3kgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aronleigh.au; spf=fail smtp.mailfrom=aronleigh.au; dkim=pass (2048-bit key) header.d=aronleigh.au header.i=@aronleigh.au header.b=Lx19QxDq; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aronleigh.au
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=aronleigh.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aronleigh.au header.i=@aronleigh.au header.b="Lx19QxDq"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-51c04bf4711so26820291cf.2
        for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 22:56:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787551011; cv=none;
        d=google.com; s=arc-20260327;
        b=g2TFbNfAcyPmVtQgB5PvCpSxGLuwPkv+Y6bcT2see7mGBdFGVCxfzdgrH8cw17xzfI
         I3MkBTHt17wVNCAvGGSUE1PIu8MAp0sjMASRU1S0tJv72dG10WoDQLAMrRiSyIB6ASw2
         YL1ERLR3Nv7lxitpHYk2UJMLkjqsVIvjObt0EUITn0DwexGVcWaD5/BPa3YJAXCHd6sQ
         FCRt5ycxdBT5yd2ooupM02fG9M6DqQSqiLR0vyxddVto79p2/8gMwWWqPSaLk5GPCSoA
         4NmibmAzY9gTIp2h6y3ZBZQC5gb8pETXemlwwi/wAwjxcBamhh5460SAcRwXl/sELOW5
         EIDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=DwkO4wkkSYzO9TH3bfbEy3G+7kS1Icqyi367uHODOGY=;
        fh=l/UXv20vvCt7hZvnU1e669sxSh+n7PRR8JDUrgY21sA=;
        b=Q2g07tvEU460NMOVPsuZ3go2hf1VrxpW2iY88uJIj7Pabnpfg7LTO5swIJ2lNTVXum
         X0YuLKRZ7LLCQB9sYNS+KEExO/C5U4P9jiB7TGMkj4VZc33MtApeozoVgXFaobUpdHrZ
         4OMHpNs8EyEtrbK33dkP7IjzEIiveFYBnfaOVKqtSnpSo3UDLckJVA5UasOSCAYUt8NH
         VwdHVucRo2bqeKJfvFmpr1EFVlUxFYqfwQg75kZGVIaF/Sumk4Rrcxiw0DHdg2USyGIW
         2OVGd8Z19ZkCrdJHqKpQpU5AFjRQpMzDyPLDwxgAOTvMVlFhiTvgtGN/YkrZixBtbVnH
         RyOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aronleigh.au; s=google; t=1787551011; x=1788155811; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DwkO4wkkSYzO9TH3bfbEy3G+7kS1Icqyi367uHODOGY=;
        b=Lx19QxDqaj0eV5TMjli9ZqgFYkoZ/Kgst27PY/hUs1S5CAiJ967or9waaiBFtUruuS
         xfLXDp1aYWWalaDBeDq2mYLELpuu9vlQqLy71SGT87I84WU2O8hf77aq7lVUVYVIkMmt
         FAvtubIkeS0rt7JvA1Ceu/GWpVmGXURqc0q/r3MmHM8jtUZE12ilxX/uq65QxdswAQWX
         eGyA1zNoRMTYPguThiNRbRVvGjrWR+xcTFWV86n/hu6h0UTQsJpzz8+XjNh6vmxssJKz
         cIenVYbGhvlcAFlmHeQekaTrCmeUMxfa1fNrkvt2hGPLm8bj1Cx68N4lfNH6c/Sjum6u
         e0jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787551011; x=1788155811;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DwkO4wkkSYzO9TH3bfbEy3G+7kS1Icqyi367uHODOGY=;
        b=E2kIK8JV/UUc06LHY42+ARi8f0yYXoLj8LFGtBc2DwEBjuv6QI0rf+gZzZO5Mu9UJ0
         QmXQY74I7OUO/EjAprxNAzkJUAo1ASd0x7qEx4p0ylmmO6YPcGz+3p7Q9OQ4d5lKChVa
         7g099nueNSQfaDu1ONiYPmaO3RVZfNGNIffwtENcrOJqq57puNy161ruG58wRR71nbwR
         ZgG03dv1bsR9y+E2D4aavLvvUaJQZgYBhyvKUGLrujPAMYKHFbqk0qTwzH1kkS6cNYU9
         kFi0xR4D+2F5FukYUJdvnqW/AZx590Fjbq7rWMcqCiQjyz39gM1ne4lNFdgl5WSMhUb6
         show==
X-Forwarded-Encrypted: i=1; AHgh+RpMcN+Cqd06dqbQ0b46q/YBO3B+0Pdo5DXZSKm9Z/Hr7s7upv/0QinY6F7bGXQ6aPmo22DUfvY=@vger.kernel.org
X-Gm-Message-State: AFuF++kJM6MxfVMFK0ub64kojbby1BEBaLJJIRKQgXWT+q8wStsvGOdw
	5tLua9klVaZlqErAIr3+0+WJAksJItrkEimLsyDwphPUwdOFPKTSLdP2Yv54KCVzKGBHQ7D8iBi
	c1zFZAECmbRLzlPNVvyiCgDfBFxJJfQTtkCLNXGU8jRU=
X-Gm-Gg: AR+sD12QWj6Xw0BbxTcOysP6tIFVT6iJRNAbLo2zeo/a8gK/YqkmmfP2qYRRtiTdYUZ
	J6LWGC7ceMuceQLMmndb3rLYjO1We48HJO/YJe8zWHClrj2olZzadoexYEU3ta6NFRO0HIim80K
	o7MLjEwoN70JKitpDaetmJtR6IZZbhoYLMAd2AdYyRCRGRAS5OkFiqU3xoU7cYydgCT4lRjPPkp
	+Mn+BdMwsI1Hrl9lxunVEWVsfDmul97L71JVgYp4as8uL1WdPHgdB3sSese5vRHzwzAb84izxk7
	odHgOrdlULphM1I0H3hIISZ21LOg0BMD364f9p0d0MzQ/qEuZ1fJclBBWCWh6pbN4De/orNUTwg
	V
X-Received: by 2002:ac8:584e:0:b0:51c:f8f:13e with SMTP id d75a77b69052e-52e09d1e1ccmr159696191cf.40.1787551010799;
 Sun, 23 Aug 2026 22:56:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Lilly Aronleigh <lilly@aronleigh.au>
Date: Mon, 24 Aug 2026 15:56:39 +1000
X-Gm-Features: AcwNN1VKhHWIURsaB_lB3DteR6xFPzaW4qSWwEijFxpCy7RHJJioocZqEyslNHc
Message-ID: <CAFrrV-NeRaP=0k5a1b+6oNOCz0qBUuFwCo2xxC3bDc6XR+wmsA@mail.gmail.com>
Subject: [PATCH v2 net] xfrm: iptfs: avoid canceling reorder-window drop timer
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
v2:
 - Rebased onto current net tree
 - No functional changes

Link: https://lore.kernel.org/netdev/CAFrrV-O1fesaza+5_WqH8OciXRu9KKE4UsB6RcMamDu0j2-nBA@mail.gmail.com/T/#u
---
 net/xfrm/xfrm_iptfs.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
index 6920940a35b4..23e0face2b9f 100644
--- a/net/xfrm/xfrm_iptfs.c
+++ b/net/xfrm/xfrm_iptfs.c
@@ -707,8 +707,12 @@ static void __iptfs_reassem_done(struct
xfrm_iptfs_data *xtfs, bool free)
 {
        assert_spin_locked(&xtfs->drop_lock);

-       /* We don't care if it works locking takes care of things */
-       hrtimer_try_to_cancel(&xtfs->drop_timer);
+        /*
+         * The drop timer also drives the reorder window timeout. Locking makes
+         * a failed cancel harmless.
+         */
+        if (!xtfs->w_savedlen)
+                hrtimer_try_to_cancel(&xtfs->drop_timer);
        if (free)
                kfree_skb(xtfs->ra_newskb);
        xtfs->ra_newskb = NULL;
--
2.43.0
