Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55E049B45C
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 15:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789573744; cv=pass; b=SoXx6rOuR46PcKkEsSAhhnL6/h0x+SoFA1Slxo8N0Sf9XzsFlWMoKLj0QITx+/vObhU/RD4fmu47gHVmiZzSL82HabjLHtavNHhRoKUGKBSHNfceuiUBAfvuOPWzQz3wvr7Z4vSSRAhZr6n91lKpCXu72t1Ul/kIwdYOmUrSwQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789573744; c=relaxed/simple;
	bh=2HTFcw51GJTpM0vzPofi6oeFOtDofXyLi0if3h9f4Tg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z3dy3MgGaWgPSTWhc4iv+1slwLU4tLmtyg0OvOkNBYGgo+0r3hgZ0t//RtRsbTOxUTSDDfaXLyKVpohSO7rqt/apEEcAAGnEowdlUGaIOUzoXOYl65pEs4LsFo7p/UKLN6yyGZGawUqG2kvNXoFxx9pCslHXXiQ4PpDvTpb3ZyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FamlximZ; arc=pass smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FamlximZ"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-868a9c48f9eso1072589b3a.3
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 08:49:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789573741; cv=none;
        d=google.com; s=arc-20260327;
        b=MERArzrQz5nH8Enfy1UltgC+zKoaPRIj8CPLLAR447RwU2NA1gc6N5PkYfGVTepZP1
         mTe1H1mpS7NucWuAM9+iOxWDRxl9okqew1evsUuglPjHhgELiI7HOjl2YTl+i4f2Sb1S
         GQdJpSb7JekdXbaRU1dB6NWO0btCLObisZNarzFCQ11MjqTf1FeU2AaQKdnRAwwr3v9E
         f5mUSmDuUyHvxPbMsNLJ6s9QrUUaPGLBqdgbYxOM/xciCjU/Vo3mC23NFP+mblfTuuK4
         MRl2KKmtGw1yMEo7qlEpOQZlUms2HVxlG/aOX1tDqCPPr64AIhivQ/TWXg1MJIapK6Ch
         lS+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9gmxz7ND3t4uc8MZW2dQN60LpvsltqXz4L3oWlJ7Ftw=;
        fh=QFMgEb3XV5rS/ZRBmyHUP58oM4AaOHTWaWQeeAou20k=;
        b=aYuhX3b/f9fEXqIxMvE839O7hyIOQaRitd/CmjzSflNkiWG3VCJzR+RfiuQHebak/B
         wrSYaiY2pQs7UABrG/YbLkJX1LmSJgrtNlyFAJjrRf5bCHCLGAxjl0E+KhdLzZr2u08a
         HTj0z6mNcurPPgBV9YdcmjMscEQd0Rl+b2R/7hUrjpR8qCoPCanMqg1dt28GuVCTwcqL
         3FCVaMJ49CsgT/ih3jN9PMFmPmOU70MZ2x6z+dMJbkI1nJGZc12ZwumcMsbh0XEv7tGV
         MG8UMrQBWdhP1L+dTJ/VGnwZxjI6WcQag7b3H6HmXma7h6E44XTuDFshqsTg4luJJCLQ
         KszQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789573741; x=1790178541; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9gmxz7ND3t4uc8MZW2dQN60LpvsltqXz4L3oWlJ7Ftw=;
        b=FamlximZGdrzR+/F3Zu1GMSPUjJmbhB7nInxQ6RRRBCiKHc3C3r1ozqMW3qpU0ev5q
         9dtThWRhvmQnPu3BMXzCY9mC5H3DbsMxi51uji3OnH+pirxFnBG0JpWvppxsTm23us9t
         snIvLRQ0gx5T1M8BtT881KF18MEb2sfwP/iW23oTYMoEuRoln+FZxmVpczBUEAiuFbvt
         VgHkPECX7U8hxJwGRGbJHYcAVnxhJpsY/Oos30QCOo3/qURGaOnotK59q0YxhuCCqUUK
         N8FNqUhIEKW4N/dXriY4+uMffMUeWiFobn5rXpV3GI+41LfJ518PvvSzsdMbaD1ziAwO
         OiDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789573741; x=1790178541;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9gmxz7ND3t4uc8MZW2dQN60LpvsltqXz4L3oWlJ7Ftw=;
        b=oBb8ut/bV4TIH2ci589+FRvwAcZNzBilSi9vuYa5GPKcFwG5a1F0MyNqqCgYP821U2
         meCmF3Y4xDYtwhYXT93gKbKX6wK0LSvOwyaR4Da7dqItnMgIeoGZdNew7//VdLqDIox8
         eSQKUqAYk3IcRj3pFxXSStf+jKNK/yMkW4g3a6GLOM66J18op1JuVEn9V9l4vDxTc3d/
         CB9g0rH1AoRM1Ucg/PzjWY8HyJ195C/5UC3n05yMUDewqdLYD58KCP6hHViDXIARYpP9
         DuoNAqvfjenm0EU8OcngS9FM6ARrqrU7T3axiKUxyYJGTpyM0KECP8UoIPObUjKsw0ks
         6Dqg==
X-Gm-Message-State: AFuF++mKS1KZ0nUCb346YucpenXNqqxnplDw2c+DxLFggDv2nBGilPPe
	zQj1/tQxr2KA6cZlb7en97ynDZO2epjVHf9GgMXx6Cjyco3qh0bErbkZ41h8fUpLPbfoo0UHcba
	PdJQ86WD1lxvB2+mKRsgXHiE1GHhoKwc=
X-Gm-Gg: AYBFou06jsWSOyholWS4aNa5cRnvl+HjEKJW5ovDcr9D8wRmThSn4t+o7/lDao7zDyR
	gzQjJafDRisldwJr3wK9PAihRbEUOQ+ujxNeEXrk82w4guhYLbGNika7iKGmXuHuliKkZqSxiz/
	W7Cf3MbL0ApCj0F9kY2qrJdtlh8diKBzNhllIfTeHZl+NJmwYGKobfsqBjpL4cXpaH3kzo055bG
	PL1mzmqcJg6YwmlUUR+TPvWjDJ0wiEt3DKl7Bbe5qD7sGmn50ktlatZkxd+rOMbBp4VQqY6SbkC
	3lHI2XcV5h+KnRjeWN/dQ9aPDPe1VEKQLqNdc1ikYg5Jb0fceAV1OG9lwy5ksDsbhXEPW3wmbIS
	jbtYOhV/1GX4bmFCZb75F3v7/1Wnh6cKkVMOUNlmh6QZU+7/lza49Ipjg
X-Received: by 2002:a05:6a00:a88e:b0:872:20f2:3282 with SMTP id
 d2e1a72fcca58-8723de188d4mr6336975b3a.22.1789573740955; Wed, 16 Sep 2026
 08:49:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ede5ba63212b87ddfa14acf70426b81d87501e44.1789393775.git.lucien.xin@gmail.com>
 <178950184662.22033.5889968066649167674@kernel.org>
In-Reply-To: <178950184662.22033.5889968066649167674@kernel.org>
From: Xin Long <lucien.xin@gmail.com>
Date: Wed, 16 Sep 2026 11:48:49 -0400
X-Gm-Features: AcwNN1Xi8cSlHvt5PrpP04qaA_yB_ZBp9zlIFRWFrwm51DDVLQoanNnzmXwbS2M
Message-ID: <CADvbK_eU+ozoWVcCWEhKuyeBK_c78Eqp-OTKQHqUBTu8hwq+hg@mail.gmail.com>
Subject: Re: [PATCH net-next v15 09/15] quic: add congestion control
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, quic@lists.linux.dev, davem@davemloft.net, 
	kuba@kernel.org, edumazet@google.com, pabeni@redhat.com, horms@kernel.org, 
	metze@samba.org, mbuhl@openbsd.org, tfanelli@redhat.com, hepengtao@xiaomi.com, 
	dreibh@simula.no, linux-cifs@vger.kernel.org, pc@manguebit.org, 
	linkinjeon@kernel.org, tom@talpey.com, kernel-tls-handshake@lists.linux.dev, 
	chuck.lever@oracle.com, jlayton@kernel.org, steved@redhat.com, hare@suse.de, 
	aahringo@redhat.com, dhowells@redhat.com, matttbe@kernel.org, 
	mail@johnericson.me, xiyou.wangcong@gmail.com, alibuda@linux.alibaba.com, 
	jbaron@akamai.com, illiliti@protonmail.com, sd@queasysnail.net, 
	marcelo.leitner@gmail.com, daniel@haxx.se, andrew.gospodarek@broadcom.com, 
	mef@scarletmail.rutgers.edu, paul@jakma.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 3:50=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider:
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 1
>
> - [Medium] Spurious persistent-congestion detection:
>   quic_cong_on_packet_lost() (net/quic/cong.c:125-140) is the ONLY place=
=E2=80=A6
> - [Low] Commit message vs. what the patch actually enables: the message
>   says the implementation 'adjusts the congestion window accordingly=E2=
=80=A6
>
> --
>
> quic: add congestion control
>
> This adds net/quic/cong.c and net/quic/cong.h with RTT estimation, a
> congestion control state machine (slow start, recovery, congestion
> avoidance), pacing helpers and the New Reno algorithm behind a
> quic_cong_ops indirection.  quic_init_sock() now calls quic_cong_init().
>
> A couple of questions below.
>
> > This patch introduces 'quic_cong' for RTT measurement and congestion
> > control. The 'quic_cong_ops' is added to define the congestion
> > control algorithm.
> [ ... ]
> > +static bool quic_cong_check_persistent_congestion(struct quic_cong *co=
ng,
> > +                                               u64 time)
> > +{
> > +     u32 ssthresh;
> > +
> > +     time -=3D cong->pc_start_time;
> > +
> > +     /* rfc9002#section-7.6.1:
> > +      *   (smoothed_rtt + max(4*rttvar, kGranularity) + max_ack_delay)=
 *
> > +      *      kPersistentCongestionThreshold
> > +      */
> > +     ssthresh =3D cong->smoothed_rtt +
> > +                max(4 * cong->rttvar, QUIC_KGRANULARITY);
> > +     ssthresh =3D (ssthresh + cong->max_ack_delay) *
> > +                QUIC_KPERSISTENT_CONGESTION_THRESHOLD;
> > +
> > +     return time > ssthresh;
> > +}
> > +
> > +/* COMMON APIs */
> > +void quic_cong_on_packet_lost(struct quic_cong *cong, u64 time, u32 by=
tes,
> > +                           s64 number)
> > +{
> > +     if (cong->pc_start_time && time > cong->pc_start_time &&
> > +         quic_cong_check_persistent_congestion(cong, time)) {
> > +             cong->pc_start_time =3D 0;
> > +             cong->min_rtt_valid =3D 0;
> > +             cong->window =3D cong->min_window;
> > +             cong->state =3D QUIC_CONG_SLOW_START;
> > +             return;
> > +     }
> > +
> > +     if (!cong->pc_start_time && cong->is_rtt_set)
> > +             cong->pc_start_time =3D time;
>                 ^^^^
>
> [Severity: Medium]
> Can persistent congestion be declared here even though a packet sent
> inside the interval was acknowledged?
>
> quic_cong_on_packet_lost() is the only place that establishes
> cong->pc_start_time, and quic_cong_on_packet_acked() can only clear an
> interval that already exists, so an acknowledgment processed before the
> first loss callback leaves no state behind.
>
> With srtt =3D 100ms the duration threshold is roughly 400ms.  Consider
> packet A sent at t=3D0, B sent at t=3D100ms, C sent at t=3D500ms, and B
> acknowledged first (ACK processing precedes loss detection):
>
> quic_cong_on_packet_acked(time=3D100ms)
>         /* pc_start_time =3D=3D 0, so this guard is false */
>         if (cong->pc_start_time && time > cong->pc_start_time &&
>             !quic_cong_check_persistent_congestion(cong, time))
>                 cong->pc_start_time =3D 0;
>
> quic_cong_on_packet_lost(time=3D0ms)      /* A declared lost */
>         if (!cong->pc_start_time && cong->is_rtt_set)
>                 cong->pc_start_time =3D time;     /* pc_start_time =3D 0m=
s */
>
> quic_cong_on_packet_lost(time=3D500ms)    /* C declared lost */
>         /* 500ms - 0ms > 400ms */
>         quic_cong_check_persistent_congestion() =3D=3D true
>                 cong->window =3D cong->min_window;
>                 cong->state =3D QUIC_CONG_SLOW_START;
>                 cong->min_rtt_valid =3D 0;
>
> B was sent at 100ms, i.e. between the send times of A and C, and it was
> acknowledged, which rfc9002#section-7.6.2 says should disqualify the
> interval.  Since neither the acknowledgment timestamp nor the packet
> number is retained (the number argument is unused in both callbacks), is
> there a way to reject this interval, for example by recording the send
> time or packet number of the most recently acknowledged packet?
>
False:

The above case relies on packet A having a send time of 0, but packet send
times come from quic_ktime_get_us(), which cannot return 0 in practice on a
running system.

Thanks.
