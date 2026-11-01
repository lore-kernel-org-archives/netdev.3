Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793555527;
	b=wC/ZFkLVGyFhVw6Vic7L+EU+7iU2AcJEtKqyEcUjGLzm4R56TCC20YEvUNJLPNJtIeGL
	 EdtQHdPgvZUq5T6HRTo6sZgvws4zEgsRITv+JrsLm15OeQdiATx3GxCJ1/11kGOui4IEN
	 yqXzESsb9/KviNY8UR3qBXeYEB0ytmXJRC45nIEe1oAdWoNpxgUPPoKJZD55I6naQXTdd
	 cH8Djr2TiVyfAldy54OpZYmbJJbbEQdjFozjnvKIRdVEilN3X2jfA34AQVQVeslfnQj3J
	 wFF+WepAK2O5y6L+m+3Elgi3G16MUa4mt1BTB8HWgdi4+Gb5hXQ35FS2ma8yOQGGOuA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793555527;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=dW1mzaspx9sbyMYPqoIn8n6kH4dJWWly5cyH9qGVB7Q=;
	b=U8aL223ncYB/ghEQrXOIU5mp44vx62u150pn5BXx25rxgupIuFjYImco64lLJ+dbiKyw
	 Y7IbmmRL6ricthGN9joBIQnEy+OkrPnkRyEL0Ps3AGstZxfyy3461CIX+Yn4e2YD5PruO
	 taJvrXCH8vsjHpK/xHwZJbM6ZfOQ5tqLwFy6poVP5azkA99l3R6MNVtLADj+DN3XF+zrU
	 gMTAX+b03xEB7EhTcrhyhIByMWPWV2UmhTfFp3lo/8DYmLoSWZ8kLEeGDx0BYdlDMNH27
	 q0puVwGqctODpKP21LVAF/NDersIaUSZcfOxoP7lX68lucmD7wLjNcVRX4HH/L5ciSg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=DjBEpGmI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.170
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E87A606A326
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 17:52:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E87A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=DjBEpGmI
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-533202fe429so272211cf.0
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 09:52:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793555526; cv=none;
        d=google.com; s=arc-20260327;
        b=N6OxKbDfBlihX7FtvdGAhUdGivLTl5GUmSFfas48vvFBcxaF5GIIUSDrKwmz7HJCUB
         cXQAwNEepivmg7hqb24nOGjXHsuyYTTf8TxTxY92xyJcHOiQDofjn8WhBXcdv7sw++0W
         F63vEVck9BGiP66eb17mjtFUjpt9JrjgMxV4dSoJWD36XKs+SAyOf072UYvtcEFLvgmq
         dCX/XdeTZf+FKQM6qMqVwvKFYd/fNpceSN0nAYybwlK6bVRG8ACUMioBh+YcbdKj7mVO
         8HQBPfcVxCl+NohBGXDvLhMz358hYjZyzvtV8JOfKHH3F1K7YM09GPAW+B6yvKglFpem
         ajfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dW1mzaspx9sbyMYPqoIn8n6kH4dJWWly5cyH9qGVB7Q=;
        fh=IrrhpjiqdAcakG/NTPdPyIITbF1g2/feWaEMCi+hKpo=;
        b=lN8SQQzcQEVZ3vSnVWHQi4lXrktD8SxyFZ4ed1x5SKIrdW+alTEHuh65Wj19ehlkCN
         YztPaNIF6p/1Uh3FAr9sigee5eWTsHcA/i7cD+9klag+tzPXOsaT388IylIPnydybFuc
         uQ9cvmXB1vsPmkQWDeAywhlM7d3VrU/VBj9mEGM3XTYakP1fSJyZg8RBKO0vu7Fam62Q
         JbCQcY/ry2Y/eM5Ifo85pqyKrNwlG88gCEmv5HWHJh+H/BbY4g/k6sC0YxoTobPViH8a
         eCNU3kIVcmMRljuG2CdPSFo/QhQq3+NvgsWHFAGMwZ1qgRhYmoLrJntzuidxJmf3Sbnf
         DVAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793555526; x=1794160326; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dW1mzaspx9sbyMYPqoIn8n6kH4dJWWly5cyH9qGVB7Q=;
        b=DjBEpGmI+r7dfQKyiQrqGnPNTRMC4LJRPaSiGGCX45yrLB1LzkLmP/xKJGHyEAEqUP
         1OlZBuolem3VW+ZPZRl624U/BufDFEFOlZe5+IUpHzA7oxT3puds5PMGm1yjiQG1OoXp
         XxU0zy0a8Lsg23CmhQMSCRrQktNWpiKtw1ME3y+3gBl7ilOIUm2vMTByKqpq2LHwecq3
         kRwZP0wvzCTpqgoSk1/84ba3z8p+4E5gsheB3skt8if31Zb0xZJkPoCZHHBYcKzM176A
         t+K5krY0QgfnAskum5GOi/SV2pBRHV1ldu5MaNdGsVThH/MYXQ2XSW77Y5WFpFHcy+96
         c1oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793555526; x=1794160326;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dW1mzaspx9sbyMYPqoIn8n6kH4dJWWly5cyH9qGVB7Q=;
        b=aTq/FOGldLcQUzJl1nstEeI3MaEDnp/fewZeeJVjvDdmJztOvdkVO1b0zNxX3QniPW
         d++RgXrWBk5RZ7OehnOZFTXK7AJfyG1SFl4Ce8ZRILIUd0f+FKbbdH4tdHsUglQi/9EX
         C5ILTBig1TMIDxe9G+++zr6RX9unHCMYXdw99MZAEpdrfdaBLmlEQF4cMFltFus69SVO
         Ccx5x7grEvdEDIeE4KndMjwzekfSr51t4EwsBqfIm56GnCF7liIqppEEQj93EKWm6bJY
         /rCPuwlNv1UvR2NJJtVMHMA6dpUmfQdLY3Yb9+oDz/AQhQ9a0rAuCt+l+rsjRipEtPzi
         FaRw==
X-Forwarded-Encrypted: i=1; AKwUvBzkL9pwcD92PmBtfWJz/N8eJJvwGtnD/eJeANoCPfO3/mNmQew+0hvYyDy3CXj6Pg6JLbO6XIU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ9NT+QrzTWui/nFgDL5e+U8UzAzhAeTZ9hJuGCER0VF2Fco8gB
	0utGnQgLpv4KqgjTlR6+ljJJhAmwWwUcuDAahqNyuG0cyUcrb5ZpP/8fAkWFBCcyvK3F8+sRlHu
	kyvIUvZLTNmCv7Lf+Rb6qmVDR5jf7oVJksLyid4qH
X-Gm-Gg: AYBFou1u3ir6lFXoN5wH+lTIwC+ukx/ks/271z1MGyZc220pR2x83gS08raECSNZVwh
	heJvVbo4OMDrWD56lXXgm2F/jvBOWeljGRwuNywrAZUHCgiU63Q/hrB7gVuR8dpmYl+hr5aAQ1u
	NfMKtidibqlBmb5ehjgjP7Seiaei7VOYnShHYoOhXAuf7NvQxGx1YlidG2Q1Xe5FkNRXSbPO02B
	5MbrZ1LdELgxpdkmIX4BIinkUqtCPUeofFXO+ODBTvE0Bktk+5+LU774k+o/YWU3Ldvtt2LWD0V
	LVic+PRfIs+DbYddFJ4n0gi9gPK+vdRIfNw1SQjbojJRz10g4APfj5RIe1h9vCsUyiWkqh3mykD
	5VdA1UpvNKpC1ECqQzTDqVNFcuKp4M6L/yB2dBC8POPxz0wpolkHM61mh1qYo7w+eVzINWdsikL
	8gj7F0ohts9SqFfOpJCyxXEENFiq8=
X-Received: by 2002:ac8:6982:0:b0:545:7949:80a5 with SMTP id
 d75a77b69052e-54579498560mr14717631cf.12.1793555525329; Sun, 01 Nov 2026
 09:52:05 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <6426d558e45fc6ab724c40af62e4a8793215dd8a.1793219189.git.gnault@redhat.com>
 <audm81hsgydhfWn3@google.com>
In-Reply-To: <audm81hsgydhfWn3@google.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Sun, 1 Nov 2026 12:51:48 -0500
X-Gm-Features: AclHuK_qGJpWCKHWf9TmzkJm5PfQse5u8fQBhEyA-3gTPxC9fkZLUM7kk9hyU8A
Message-ID: <CADVnQyke=Xhtt3XFBstE5oDiZAXq0zqyN1XtCa_fe3iRYzKdDQ@mail.gmail.com>
Subject: Re: [PATCH net v2] tcp: Fix dup-ack detection on non-SACK
 bidirectional data transfer.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Guillaume Nault <gnault@redhat.com>, David Miller <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@kernel.org>, 
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Tom Williams <Tom.D.Williams@morganstanley.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 1, 2026 at 11:22=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> On Wed, 28 Oct 2026 21:32:35 +0100, Guillaume Nault wrote:
> > When receiving a pure ack from a peer that also sends data, we can
> > have SEG.SEQ > SND.WL1, even though the segment contains no data. This
> > makes tcp_may_update_window() return true (because of the
> > "after(ack_seq, tp->snd_wl1)" condition), and tcp_ack_update_window()
> > then adds FLAG_WIN_UPDATE to the segment set of flags, even when
> > there's no window update.
> >
> > Since FLAG_WIN_UPDATE prevents the segment from being considered as
> > dup-ack (as it's part of FLAG_NOT_DUP), this can inhibit fast
> > retransmit on non-SACK connections, making recovery very slow as it
> > now entirely relies on RTO.
> >
> > The "DUPLICATE ACKNOWLEDGMENT" definition of RFC 5681, section 2,
> > says that lack of window update is a necessary condition for a dup ack:
> > "(e) the advertised window in the incoming acknowledgment equals the
> > advertised window in the last incoming acknowledgment.". Spurious
> > window updates can thus prevent dup ack detection and, in the end, fast
> > retransmit.
> >
> > Avoid this scenario by setting FLAG_WIN_UPDATE only when a window
> > update actually occurs. Pure acks with SEG.SEQ > SND.WL1 can now
> > be detected as dup-ack and trigger fast retransmission.
> >
> > Also, stop setting FLAG_WIN_UPDATE in tcp_ack()'s header prediction
> > path. One of the conditions for header prediction to happen is that
> > received segments don't trigger a window update. This flag update was
> > thus wrong to begin with. Now that tcp_ack_update_window() sets
> > FLAG_WIN_UPDATE only if a window update actually occurred, we need the
> > header prediction path to stop reporting spurious window updates too.
> > Otherwise BPF programs would get inconsistent window update information
> > (CA_ACK_WIN_UPDATE) between fast an slow paths.
> >
> > Finally, add FLAG_SND_UNA_ADVANCED to the definition of FLAG_NOT_DUP.
> > This is necessary for the case where an incoming segment acknowledges
> > less than a full segment of the retransmit queue. Such segments were
> > not considered dubious by tcp_ack_is_dubious() because of the spurious
> > FLAG_WIN_UPDATE flag, which prevented the segment from being seen as a
> > duplicate ack. Now that FLAG_WIN_UPDATE doesn't cover this scenario
> > anymore, we need another way to mark these acks as non-duplicate.
> > Adding FLAG_SND_UNA_ADVANCED to FLAG_NOT_DUP is the natural way of
> > doing this, since, by definition, a segment advancing SND.UNA, even by
> > a small amount, cannot be a duplicate ack.
> >
> > A side effect of this patch is that repeated zero window acks received
> > from peer can now be considered duplicate acks (because of the the
> > "|| !win" condition in tcp_may_update_window()). Therefore, they can
> > now trigger fast retransmission and fast recovery, including congestion
> > window reduction, when the peer is stalled. This is RFC compliant and
> > shouldn't have any negative effect.
> >
> > Add packetdrill selftest. Before this patch, the 1001:2001 segment was
> > retransmitted upon RTO, now it's sent right after reception of the
> > third duplicate ack.
> >
> > Thanks to Tom Williams for the investigation help and initial
> > reproducer.
> >
> > Reported-by: Tom Williams <Tom.D.Williams@MorganStanley.com>
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Signed-off-by: Guillaume Nault <gnault@redhat.com>
>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Neal Cardwell <ncardwell@google.com>

Thanks!

neal
