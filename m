Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793550175;
	b=bBXFzm7I5GuEKzhEUxkcTqSNdkvAWqS/VQPXsKMbIbrc+2upxdOIUDTUPVockT0h3SrH
	 C+Lo99ib4+5eCDrqcY1elZ8+tJcCpvOskn7JwnqZ3jfdvd5hXwslLpaMeD24U8Q3yPv7E
	 lZj/XCs4B8arOEtPSURMVg4iO+sNF7ZRZgq6ealafnC5NVeR2Np3tQeEfBGnCeMBF6GIY
	 dkSDLEtvuln9XX9kaUgIpxOPzIVrEA5k240hD6ONwlFJNVNdh06RuXvBwJXzyU2au5l3V
	 O80f5cZ2nGTHXUbI6ouZt/wUrpOVjT9vJN4gbzwooZXMZ8ongapSHouyg4yh0iM6c8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793550175;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=Q6Kkq6xSR/vy5fD2OpVN5KrXeg6aNXcKuj+lH2cRIUQ=;
	b=rmy7N2lzYsnzhzEmtdR00YellcxT8lZo8C2KeIX4IESYC8++hPqpkM/zPV+tL9q8hzIL
	 +0yUmvYRx4tGmAiSZwfsb5EA0C1NlU7b3/3lsDdEvT8sv6JBxIOuyItySS9yqLIoQAiC5
	 AxtGQB9zuPOyaKWHLuEZY6+PRfYAp3GAfwYIczNp4GChuoZpNLshY9EfDy5LXgpUtE7dN
	 xh+EazuYNeIytK45bkGtpxuy7XlN+ggj8Qctc0RJH0I2nyN0sP3An1WUYivYmQaz8aJBl
	 cytd/sLaY2PO6p5oU4bhdSh703LE9H9cg9aj2PBADJ6JIi4cFynkCMZiEsThd+6zT2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=KLW8D878;
	arc=none smtp.remote-ip=209.85.216.71
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF69606A324
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 16:22:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AF69606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=KLW8D878
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3ab926c236aso1807481a91.0
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 08:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793550175; x=1794154975; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q6Kkq6xSR/vy5fD2OpVN5KrXeg6aNXcKuj+lH2cRIUQ=;
        b=KLW8D8782PwP8SbqpYB7XktTfuJTSTeA+IK/plAbJCCGMeT9YjViTQ5H60buVPg3ic
         NwbiRrdxFIcEETuv13hRKTI1PwGi4ff7YW5WerC02J4dItguReszUCSJmCHczKZ8bhQi
         6s42+g1998ZCxhzELEhqbqY50yeNpOfMkTkIm+OIRAhwNX/UeuIpnLaa211VzvIuijli
         ZbMjeUGBccCjfQG2jW2pcDQ1a8rTPMg7mFhcm6GeCrpMz6RTnOjPTRBG0hmDHLpDueKL
         O+v5nt6hCYxNjFiJ86GnJG+v6dNkq6b4DuFbKjzK1AaaI6LXHsDG2myFkCb1TehaASkN
         lQ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793550175; x=1794154975;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q6Kkq6xSR/vy5fD2OpVN5KrXeg6aNXcKuj+lH2cRIUQ=;
        b=VIeC3BQf53NkLHOLX5rnTipfQLLSweCW3lJQHOzSOVJHyFaTEz3g9a+dDNXT7bvEZ2
         cmntKYP6rXy+GuTu9PkBILhtF6J0Jk3p2JGDkwrhvZCs6PBA8+3a3fcqOGthHZox6O5u
         QhyUpLfgLtbQTsIFmbxT3VQpB2hXWnlvgNTzyCp7yvTEWCxwKs11buL7Gb5u0VWWe4Uf
         GR5HbXVWVgjG/wiwdndot7rrhnR+gipMoReLVeOId028wIaMhJ8+9BICw+ywqlkCpBCX
         JJ+3JjfncdUi51kxs5OAtUBzAAkPUN9eKOPaHNLK7XNbjG37S9JpTZ6OtNudvzrTLFFA
         tRvg==
X-Forwarded-Encrypted: i=1; AKwUvBxyeclWLehrJkRh/30/cXAJ7GBZtpl02THKUOMyAiDPC0D9YxMVBLlKTVNyIKrT8b7Iks5DTPo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+jOYt1ppsnGGPBjSsn6QP7OXBt/5mZRAUcnQcdlrl+xMtJCYIB
	xgcaSBjkOz/x5BaReotfDGkq2GsfIJKIrnCyYK3z6B/rfh2i/Q6jydG/BEbtejMKd5Z3mNWbvIY
	xIP1b7g==
X-Received: from pjbmg2.prod.google.com ([2002:a17:90b:3702:b0:3ab:133b:49b6])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4a46:b0:3aa:f2c4:12e9
 with SMTP id 98e67ed59e1d1-3ae8953617fmr7052241a91.3.1793550174575; Sun, 01
 Nov 2026 08:22:54 -0800 (PST)
Date: Sun, 1 Nov 2026 16:22:53 +0000
In-Reply-To: <6426d558e45fc6ab724c40af62e4a8793215dd8a.1793219189.git.gnault@redhat.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <6426d558e45fc6ab724c40af62e4a8793215dd8a.1793219189.git.gnault@redhat.com>
Message-ID: <audm81hsgydhfWn3@google.com>
Subject: Re: [PATCH net v2] tcp: Fix dup-ack detection on non-SACK
 bidirectional data transfer.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Guillaume Nault <gnault@redhat.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@kernel.org>, netdev@vger.kernel.org, 
	Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Tom Williams <Tom.D.Williams@morganstanley.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, 28 Oct 2026 21:32:35 +0100, Guillaume Nault wrote:
> When receiving a pure ack from a peer that also sends data, we can
> have SEG.SEQ > SND.WL1, even though the segment contains no data. This
> makes tcp_may_update_window() return true (because of the
> "after(ack_seq, tp->snd_wl1)" condition), and tcp_ack_update_window()
> then adds FLAG_WIN_UPDATE to the segment set of flags, even when
> there's no window update.
> 
> Since FLAG_WIN_UPDATE prevents the segment from being considered as
> dup-ack (as it's part of FLAG_NOT_DUP), this can inhibit fast
> retransmit on non-SACK connections, making recovery very slow as it
> now entirely relies on RTO.
> 
> The "DUPLICATE ACKNOWLEDGMENT" definition of RFC 5681, section 2,
> says that lack of window update is a necessary condition for a dup ack:
> "(e) the advertised window in the incoming acknowledgment equals the
> advertised window in the last incoming acknowledgment.". Spurious
> window updates can thus prevent dup ack detection and, in the end, fast
> retransmit.
> 
> Avoid this scenario by setting FLAG_WIN_UPDATE only when a window
> update actually occurs. Pure acks with SEG.SEQ > SND.WL1 can now
> be detected as dup-ack and trigger fast retransmission.
> 
> Also, stop setting FLAG_WIN_UPDATE in tcp_ack()'s header prediction
> path. One of the conditions for header prediction to happen is that
> received segments don't trigger a window update. This flag update was
> thus wrong to begin with. Now that tcp_ack_update_window() sets
> FLAG_WIN_UPDATE only if a window update actually occurred, we need the
> header prediction path to stop reporting spurious window updates too.
> Otherwise BPF programs would get inconsistent window update information
> (CA_ACK_WIN_UPDATE) between fast an slow paths.
> 
> Finally, add FLAG_SND_UNA_ADVANCED to the definition of FLAG_NOT_DUP.
> This is necessary for the case where an incoming segment acknowledges
> less than a full segment of the retransmit queue. Such segments were
> not considered dubious by tcp_ack_is_dubious() because of the spurious
> FLAG_WIN_UPDATE flag, which prevented the segment from being seen as a
> duplicate ack. Now that FLAG_WIN_UPDATE doesn't cover this scenario
> anymore, we need another way to mark these acks as non-duplicate.
> Adding FLAG_SND_UNA_ADVANCED to FLAG_NOT_DUP is the natural way of
> doing this, since, by definition, a segment advancing SND.UNA, even by
> a small amount, cannot be a duplicate ack.
> 
> A side effect of this patch is that repeated zero window acks received
> from peer can now be considered duplicate acks (because of the the
> "|| !win" condition in tcp_may_update_window()). Therefore, they can
> now trigger fast retransmission and fast recovery, including congestion
> window reduction, when the peer is stalled. This is RFC compliant and
> shouldn't have any negative effect.
> 
> Add packetdrill selftest. Before this patch, the 1001:2001 segment was
> retransmitted upon RTO, now it's sent right after reception of the
> third duplicate ack.
> 
> Thanks to Tom Williams for the investigation help and initial
> reproducer.
> 
> Reported-by: Tom Williams <Tom.D.Williams@MorganStanley.com>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Guillaume Nault <gnault@redhat.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
