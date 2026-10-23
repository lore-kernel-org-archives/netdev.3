Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792756448;
	b=umsjQzt9Af7mM4ECOVoV6Y25AVmNzq+YeN6592eXjOlr3VGVA/jqSViQoO/m2RM1arPh
	 T+XBCTK3+09SpXtMucouxg5nkCCU1TfLeDyheI7R6uoxXA36SKqco4/AgD2SrzYD+lkyi
	 lhOZsUB/NgeruZRZA6Jf/OLy8F2zsx8J9TuuLsw0Buo6tYFxN5ZgdTVZSmaB30jLCOc55
	 WfK587mAWoqkignuB0KbzfhORMkk0rGLCQhs5qahBeEU7pAQp4GFPgl+n1h6SnkVLZWxm
	 ZIkTgFGpzbzzazjP1FgGZqzOQ0g7avwgHv6prQsqyahogGzDnIX4fblJD3DmSLjp3lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792756448;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=ynHNzvWKkQ6oefC3ZMeuf3FS1RItp1haMjGuBj9NObU=;
	b=iudbDGLTYUbc5DfpeIL9wp1LzmZ4Lle8c8xkuBZllv5B3dVtGcbL6UKl2DT83/VtGZJx
	 kJC+4JTXLctrvpSeh4Bo2hEvg1CfIA/YtL4oHjQljwiqIcgHz0G1c/b3YWSetSTGbP15g
	 Ds8e8GDqyR378pvFnX9t551JaGokLu0RLBZFIP5QnCXP7QE3eonEYAmN7dvcTYkwkm/Dd
	 zLcvb+MqFQ08/PGMeju98W+46lmN2kneKY6s7nwtxpnpGVjcQbXHBZBOoyoQD+R6QF/Gm
	 G24+PiPq0ZetPiWwsNkS9L8LibTITHlmPiWGt18Qe3lsojcFGFS/Y9/9QV0nSlfoTIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ie2HYgTK;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=MF5+PAbU;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9F4606A31A
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 11:54:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB9F4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ie2HYgTK;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=MF5+PAbU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792756446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ynHNzvWKkQ6oefC3ZMeuf3FS1RItp1haMjGuBj9NObU=;
	b=Ie2HYgTKeUFLSc5STgLW1VQkHtL5SanMQGvqh3IC8tMqgUcLsz5LPl+jsRIBruTXqXFinX
	MyO+tn9Afbv4WdVV/eEnKIItdxhzVzoUN2v6BzsZGVKiK7O/3WBdsvGXHHe69x1wQ0hgei
	RP6hYnP+7vJ08kGku0+bbGgo92Le2A4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-v7SZjuTaMTKJTli-yFaoqw-1; Fri, 23 Oct 2026 07:54:05 -0400
X-MC-Unique: v7SZjuTaMTKJTli-yFaoqw-1
X-Mimecast-MFC-AGG-ID: v7SZjuTaMTKJTli-yFaoqw_1792756444
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48c7fe9736eso673607f8f.0
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 04:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792756444; x=1793361244; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ynHNzvWKkQ6oefC3ZMeuf3FS1RItp1haMjGuBj9NObU=;
        b=MF5+PAbUJiSXucR5/+0iSvr/Ma/Eo8RPGsIDVgJutZJ7G5ePF1GsAMlA6U2YF8W+M3
         2xJ8zJ8AMFxvLlgB7S2B2c0KwfK/OAUL36hkc2oVSUS+iUqQP1rFj7aHepXr6h0ErnOf
         G94ISkt7Xx53irQ47/K+TEqX0/wEPEd5CIifHPnwExtFvAG1sRyd9k881i2WD/ZLhUE5
         FYzTThS32HXXSazO3RNcohUU60NbruihyD8/qL/F5Am0TN0i4xOgFZNNlLJ4/Jm3pwxl
         ZQdZnzxB0ajn8iOmxuut5FXhCjFLa7X0nTPHST2Karc4W78mSNDqXu2abagMWmvSV8+6
         1WRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792756444; x=1793361244;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ynHNzvWKkQ6oefC3ZMeuf3FS1RItp1haMjGuBj9NObU=;
        b=SDTyIIztnGp/MyTlZSnzRVkbxipQ5sgpZCiCVXiMh4hyMPW5MX9uOzM8vfrTqrWTuM
         v/P5juUbOmJ8y+p1kFbtnQFRT1n5vSJD892nEJbRKQTgR8l5WEOB7JpPU+mkoM9DACSG
         6mSnygETNiMhDOvTl5u7OpW4sHnr2fyqgN+Ovj5zZ+MuSvfQDyuhm0g65eD6+uU9RzES
         lMNX1QooPYUT8UiU3BYqYOZKfKcbLJAdnAmviZvnmXmDnUL6bSG6zffe4wG0Xh796o5M
         TMvHaubb55juhsskBsdgV+qdNMJjgEjxklQN6DyHdbSr+KN2xRkRsN/CwpWwlMsLNE/9
         DoLg==
X-Forwarded-Encrypted: i=1; AKwUvByykuo+cGTlwThkfD70kBaM9MHhmWsI8y+STJ94Av5u1fLdIcJQIleoqWTq93VQ0zkYyhZwZB8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIZUPmSmKyh3p+xvLUVIMjAAK7r+XHfh81GZTA/pkzGWgiU0j3z
	Qfq7/xekbMOXSn4wbaBHm8MyCyNqSbm0xcS+n+eN5JzCJnFtdi+nC2CfuYiHNBcHsIDRhtXvNqZ
	OJeHLuTkb/tUnCgHmMf77HSvjJ+or3GJnNHNFelh5FzHoR9bEy90qGk2WHA==
X-Gm-Gg: AYBFou1s4woTatYzOWVMGTcUo5rBY4/WGSVRifERA32atKfQl4e2aj3Qk0g+Gl8GK9p
	vmIKHUcEW6j4h+wNzCugiGfu3nuSEmZFYOxlQZ4vSHb/msBi3cCxfGXEgsFFQqKlRaLegJ6oRkL
	ibcUPHMmxlthcjBT2PAByOMYM3mjEN2NBSSYf1fBTikSri8cwHkk/WOd5nyGTaL5RAtQ4hHcT/2
	5yITK4uaK4ZDhDrZwbO66EqSDKW0iiak1msVN9KaT+5CEvqyI6T3ow9JgPGC7zC/n2Sk1dZbVYN
	PF4y+AsfGBbc+IaWZC1Rv9kSWUW3NowyuFracmi02tImKV7Tsi7eLwKp+1ByUQAbTTsvyDLroNJ
	fICsGHUACDYOgUf7ZXfQc4tjADFDoHkpVS4akaKJuk+Ty17EYdE8dQw==
X-Received: by 2002:adf:f9c3:0:b0:48e:2114:8ab9 with SMTP id ffacd0b85a97d-48e3859cd63mr2545261f8f.31.1792756444126;
        Fri, 23 Oct 2026 04:54:04 -0700 (PDT)
X-Received: by 2002:adf:f9c3:0:b0:48e:2114:8ab9 with SMTP id ffacd0b85a97d-48e3859cd63mr2545185f8f.31.1792756442931;
        Fri, 23 Oct 2026 04:54:02 -0700 (PDT)
Received: from debian (2a01cb0580324c0086a938fffe1eee25.ipv6.abo.wanadoo.fr. [2a01:cb05:8032:4c00:86a9:38ff:fe1e:ee25])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e37edce44sm4798905f8f.3.2026.10.23.04.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 04:54:02 -0700 (PDT)
Date: Fri, 23 Oct 2026 13:53:59 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Eric Dumazet <edumazet@kernel.org>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Tom Williams <Tom.D.Williams@morganstanley.com>
Subject: Re: [PATCH net] tcp: Fix dup-ack detection on non-SACK bidirectional
 data transfer.
Message-ID: <attK12w8jcboavEk@debian>
References: <2ab9dc5f5b5e9f50d7a4aa02a6b6759fc86314c7.1792658454.git.gnault@redhat.com>
 <CAL4WiirZKwGSP6w5vtbEQ-KXY3qR_ie3HuyRuF_JVEoC3PiO4A@mail.gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL4WiirZKwGSP6w5vtbEQ-KXY3qR_ie3HuyRuF_JVEoC3PiO4A@mail.gmail.com>

On Thu, Oct 22, 2026 at 11:46:48AM +0200, Eric Dumazet wrote:
> Le jeu. 22 oct. 2026 à 10:49, Guillaume Nault <gnault@redhat.com> a écrit :
> >
> > When receiving a pure ack from a peer that also sends data, we can
> > have SEG.SEQ > SND.WL1, even though the segment contains no data. This
> > makes tcp_may_update_window() return true (because of the
> > "after(ack_seq, tp->snd_wl1)" condition), and tcp_ack_update_window()
> > then adds FLAG_WIN_UPDATE to the segment set of flags, even when
> > there's no window update.
> 
> Nice catch. This also matches RFC 5681 dupack definition, (e):
> "the advertised window in the incoming acknowledgment equals the
> advertised window in the last incoming acknowledgment".
> Maybe worth quoting in the changelog.

Good idea, I'll add the quote in v2.

> > Since FLAG_WIN_UPDATE prevents the segment from being considered as
> > dup-ack (as it's part of FLAG_NOT_DUP), this can inhibit fast
> > retransmit on non-SACK connections, making recovery very slow as it
> > now entirely relies on RTO.
> >
> > Avoid this scenario by setting FLAG_WIN_UPDATE only when a window
> > update actually occurs. Pure acks with SEG.SEQ > SND.WL1 can now
> > be detected as dup-ack and trigger fast retransmission.
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
> > ---
> >  net/ipv4/tcp_input.c                          |  2 +-
> >  .../tcp_bidir_fast_retransmit_nosack.pkt      | 42 +++++++++++++++++++
> >  2 files changed, 43 insertions(+), 1 deletion(-)
> >  create mode 100644 tools/testing/selftests/net/packetdrill/tcp_bidir_fast_retransmit_nosack.pkt
> >
> > diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> > index 99baf14afdfd..ef20bb5a0523 100644
> > --- a/net/ipv4/tcp_input.c
> > +++ b/net/ipv4/tcp_input.c
> > @@ -3959,11 +3959,11 @@ static int tcp_ack_update_window(struct sock *sk, const struct sk_buff *skb, u32
> >                 nwin <<= tp->rx_opt.snd_wscale;
> >
> >         if (tcp_may_update_window(tp, ack, ack_seq, nwin)) {
> > -               flag |= FLAG_WIN_UPDATE;
> >                 tcp_update_wl(tp, ack_seq);
> >
> >                 if (tp->snd_wnd != nwin) {
> >                         tp->snd_wnd = nwin;
> > +                       flag |= FLAG_WIN_UPDATE;
> 
> One behavior change to keep in mind: because of the "|| !nwin" clause
> in tcp_may_update_window(), every zero-window ACK used to carry
> FLAG_WIN_UPDATE and was never considered as a dupack.
> After this patch, repeated "win 0" ACKs at snd_una with outstanding
> data (receiver dropping in-flight packets because its queue is full)
> will be counted as dupacks and can trigger fast retransmit + cwnd
> reduction while the peer is simply stalled.
> This is RFC compliant, I think this is fine, but a packetdrill test
> covering this case would be nice.

Indeed, I also think this new behaviour is valid.

> Also, the header-prediction branch in tcp_ack() still sets
> FLAG_WIN_UPDATE unconditionally, so CA_ACK_WIN_UPDATE (only visible to
> BPF CC) is now inconsistent between fast and slow paths.

I feel I'm missing something about this header prediction code. The
comment says "Window is constant, pure forward advance.", so why does it
set "flag |= FLAG_WIN_UPDATE;" right afterwards? Do I misread the
comment?

My (theoritical) understanding of header prediction is that one of the
precoditions for it to happen is that SEQ.WND == SND.WND. In that case
we could just drop the "flag |= FLAG_WIN_UPDATE;" line. However, I
can't see any such guarantee in the code (but I may have missed
something).

In the end, should I just add a chunk like the following?

 		tcp_update_wl(tp, ack_seq);
 		tcp_snd_una_update(tp, ack);
-		flag |= FLAG_WIN_UPDATE;
+		if (tp->snd_wnd != ntohs(tcp_hdr(skb)->window))
+			flag |= FLAG_WIN_UPDATE;
 
 		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPHPACKS);

> It is quite sad that some TCP stacks do not use SACK in 2026.
> They will still be dealing with decade old bugs.

Yes, we have what we have :(.

> I am unsure if this is a net candidate, perhaps Neal and Kuniyuki can
> give their thoughts.

I posted it to net because I considered it's a bug in the duplicate ack
detection. But if maintainers think this should be for net-next, that's
okay too.

