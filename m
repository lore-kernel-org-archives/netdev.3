Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9E7279DAD
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 01:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791510187; cv=pass; b=dWINcFFqa2Ov1anVgTpPd3vQBw82st8LY/H0voG0KKGmIRcTGgm7Ctufs5/V5HaXGBu6WbIfY0kzELYk7GT9YfaCw/bAArCdv6wQTNPxJ/wWS5q7AYSIsxswteod8Ntb1qla/jk41yVzKt5zhwYl7KwzKm1Q7VArdWJEEWyhrQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791510187; c=relaxed/simple;
	bh=n8YcwL7I6ncHN6Di+TjkLj9HcqFEku0JBz9C1UzgFh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dA83LvOXgCILBrme8wlqRoy0rkh++Y+y4yd6xvxXQsbU990pGj5zOMLSvaH6ZwapwUF/6MWH000/rYRQHepT9qfemRoZ/5KTs0TR1EZAgvWRa7enoHP3/fiAqEQF3ZpFsiKj97yJCqkQ43/HszxYzvWjkYkjBsuN8nQPLIjmAeQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dQo5ywy2; arc=pass smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQo5ywy2"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8714288dd3bso1970043b3a.1
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 18:43:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791510185; cv=none;
        d=google.com; s=arc-20260327;
        b=ZfascMISVX2l17+eDTaMW3TnMO+0CseUYcfeqqkCpzvG7sAD6lPApJUTjyQP6aM5RV
         hEOnW9hsVHeGDIWwiB67ue+iuYVg8KJOSg/kxH+YIgZEXD6HGE0oWOcox2PbCuIaxmBA
         EGzUmDOwCbsAitiPt1XWrpyOtqrhMIGX3btw/aqSy8hjm4SAv6PrvYQ27yK4RvPWj5zB
         Vo6/aX1EgFRvrtwlGoX8gnLNIRB0WDzo3Vj3wDDYyp6msV9bnh9aqGPopRY268/gBDBv
         QwquiIW6sdkdGko8SMw+LEZVFVJcAdUlcXYzz1wcldJvhBUJs2yPf6bK9gQwxo/hAklm
         HNjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nvNO4+uRT42xaw6c57vhH/gJBgCPU/zxf+gr5Cfeshg=;
        fh=FcywtlDZoDkM4edKsFlp1mDZyBkJFKZZqzJffsc2CVg=;
        b=DaNkHHJn/ABwTI50vEtvDnPfl6xwGac0jBRXoaScuv80rknqGEmuxR9NRGqhJb1VzK
         tQmbwNXosrerYCK9f+zKsjucRLKzeyuEpOiYlopAfqyIrPycSAiXiADPfvqiLZyD1WVQ
         g9Cz9U0ClILfMJpzr8+gXZQV4RPxfoWbnvw7Qzl/FmX/K7Qm2p7CY0WgWJGhzf+7uTv+
         lTKrVpxvWy8XAsaHcKKoCvwS54PvrdHDvVUuJ1BEnIZtP/t5W2MUqPmg92WFVg8WiyNx
         qSTgg5xmvOfPio+I4ebTSsTOrMDhGANErQePoc/qdpC6yXvEjWp+K2Nt0CXATEhfr2iw
         Re8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791510185; x=1792114985; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nvNO4+uRT42xaw6c57vhH/gJBgCPU/zxf+gr5Cfeshg=;
        b=dQo5ywy21i/At4hQMF37VWpi03lvu3GNJ0j2LYtt7liPTumA3n2u06dukLRNWTc1tX
         LJGaTB54UI/YvfHxdeWz0XcrKmPTPd9wi9JZdRfAdq94tayyQnlc7++cVdoTV8f22STR
         J9Rrdmuikcw2bnwZlQYB9SUzEmpoMHnv+vRD43yWW5c22xQB64BNPTvNwzauYN556aRt
         xiRHZ3y5a93vSPUchTqcGybbFjGsDRbq/ElEFpDasrmwlA5UIPVsqY661CSyZyUwpMMg
         1kgjyAhIDkW+6rJXBW21xTalGUKYdLpdFi4RDds4E3UptnCjjB57o6ixsqmTVhc6DSsT
         bozw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791510185; x=1792114985;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nvNO4+uRT42xaw6c57vhH/gJBgCPU/zxf+gr5Cfeshg=;
        b=qopX4T7xQ6CquIGaLrin+taxNpeEHYXmS2dzMmi4ICStXu8NeNVsuOMUhDal3vbt1f
         ypLZcdZudnDV3RKw6yDMV7gs7+uWEVIXS8BSaEaU/BAemy7rd/QO6rNfXCyCGDy5O5Ov
         INQ1VydJvfxJqkL0/E3e6k8FuLcrmG2foqIYiW1ptulpYefWEHl54qYgWmQ2cKfC6xN3
         qR1CA/OCdtJLIcQRgjJu77pK71ygKmJ+P5TnQg4ucxvomtDnh2D1jyPaOyll+Rw2PiVA
         /4MtjQoWNv5IHW+PZ5CXoIyvt+Op2cg0lg+Y86AhGcsIUxSIqXUq9PdV6g/yqxLGbLEw
         qc5Q==
X-Gm-Message-State: AFuF++lQZSdudCimmwXBQit2aCcu0nJNgLusLXb8daqSmoxh31Hl03kq
	2ChXAIMV71oXa/yqk++/4BRKSKZUZFt8BIze8DdH6QHsjGMRq0TMVcQ5yDoQEoeRunee5OTtDW5
	wlg4jkGnFDBXMIGEp2PLARQKRcKkn5N4=
X-Gm-Gg: AYBFou1vBtGfYXWmjTtSigROnnbzE1DHuWYuaZtEnUhyGrL9xHP3Yt6kPeOGwXYmbIp
	sgyR2v+6ByqzvBK+XlbSnfOv5u+/MFofyHIAp6ogYOFCCQyxA+dJXMdUFxq+RpvkiS7khwrBXkN
	MpihDyhtq3K2G8rogOqq+2gvmic2qc6AtZM5MAeKc1T/KLlR8o0vMRulQFzfbZ4dC5LGzfx930g
	sxgqJdZ1UK2kDGfXZjS7kReHl7XOcQdT1dtbrNHmDsoOUUjPzX3g3+33tgbnmeF9w26pmhsefcW
	6NpZ/2hkjRuqJUF5xJw+TNWwcKIbU0PB1OVIXpLM9KYVN9G2Wx4U5Wi8SsFVtteiQ9PeMa4WzxC
	Pa3OVCh/Ze/BS5qeGTCNU6Erq/7DL4j3dDAhnKW7ZpJAlKYrk8GBBeD+ih4bm08k=
X-Received: by 2002:a05:6a21:483:b0:3e0:da23:874e with SMTP id
 adf61e73a8af0-3e16bdae7acmr234756637.21.1791510185039; Thu, 08 Oct 2026
 18:43:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <04d71cfc6acd9df9eb52e4f998c35eee568c4319.1791227050.git.lucien.xin@gmail.com>
 <179133511607.434549.17774997950314089010@kernel.org>
In-Reply-To: <179133511607.434549.17774997950314089010@kernel.org>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 8 Oct 2026 21:42:53 -0400
X-Gm-Features: AclHuK8W1Wf3zRSa6LnwypKbXEMa4xVD7fPbE6nLopWcgl-4MV4wP3DczF0C_mI
Message-ID: <CADvbK_cYEE8nb3H8CB=sy_8HRmC+uxxFq+EC4bctyWQ+SnbOVQ@mail.gmail.com>
Subject: Re: [PATCH net-next v16 09/15] quic: add congestion control
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
	mef@scarletmail.rutgers.edu, paul@jakma.org, kuniyu@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 6, 2026 at 9:05=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wrot=
e:
>
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 2 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] quic_cong_on_packet_lost() (net/quic/cong.c) lets a packet
>   that was sent before the first RTT sample start the persistent-=E2=80=
=A6
> - [Medium] The New Reno handlers in net/quic/cong.c decide whether to
>   react to loss or ECN using only cong->state.
>
> --
>
> quic: add congestion control
>
> This patch adds struct quic_cong for RTT measurement and congestion
> control, and a quic_cong_ops interface for congestion control
> algorithms. It implements the RFC 9002 state machine (slow start,
> congestion avoidance, recovery) with New Reno as the only algorithm. It
> also adds persistent congestion detection and pacing.
>
> > diff --git a/net/quic/cong.c b/net/quic/cong.c
> > new file mode 100644
> > index 0000000000000..4779ffe90a3f2
> > --- /dev/null
> > +++ b/net/quic/cong.c
> > @@ -0,0 +1,319 @@
>
> [ ... ]
>
> > +/* NEW RENO APIs */
> > +static void quic_reno_handle_packet_lost(struct quic_cong *cong)
> > +{
> > +     switch (cong->state) {
> > +     case QUIC_CONG_SLOW_START:
> > +             pr_debug("%s: slow_start -> recovery, cwnd: %u, ssth: %u\=
n",
> > +                      __func__, cong->window, cong->ssthresh);
> > +             break;
> > +     case QUIC_CONG_RECOVERY_PERIOD:
> > +             return;
> > +     case QUIC_CONG_CONGESTION_AVOIDANCE:
>
> [ ... ]
>
> > +     cong->recovery_time =3D cong->time;
> > +     cong->state =3D QUIC_CONG_RECOVERY_PERIOD;
> > +     cong->ssthresh =3D max(cong->window >> 1U, cong->min_window);
> > +     cong->window =3D cong->ssthresh;
> > +}
> > +
> > +static void quic_reno_on_packet_lost(struct quic_cong *cong, u64 time,
> > +                                  u32 bytes, s64 number)
> > +{
> > +     quic_reno_handle_packet_lost(cong);
> > +}
>
> [Severity: Medium]
> Can one congestion event halve the window twice here?
> quic_reno_on_packet_lost() gets the lost packet's send time in time, but
> never uses it. quic_reno_handle_packet_lost() skips the reduction only
> when cong->state is QUIC_CONG_RECOVERY_PERIOD.
>
> In quic_reno_on_packet_acked(), the state leaves recovery as soon as one
> packet sent after recovery_time is acked:
>
>         case QUIC_CONG_RECOVERY_PERIOD:
>                 if (cong->recovery_time >=3D time)
>                         break;
>                 cong->state =3D QUIC_CONG_CONGESTION_AVOIDANCE;
>                 ...
>                 fallthrough;
>
> Here is one sequence:
>
>   - A loss at time T starts recovery.
>   - P20 was sent just before T and is lost in the network.
>   - An ACK of P21, sent after T, ends recovery.
>
> Later, P20 is declared lost, either by packet threshold on a later ACK
> or by the time-threshold loss timer. At that point the state is
> QUIC_CONG_CONGESTION_AVOIDANCE. A new recovery period starts and both
> ssthresh and window are halved again.
>
> In RFC 9002 Appendix B.6, OnCongestionEvent(sent_time) returns early
> when sent_time <=3D congestion_recovery_start_time. B.7 applies the same
> rule to ECN-CE.
>
> Should quic_reno_on_packet_lost() compare time against
> cong->recovery_time instead of relying only on cong->state?
> quic_reno_on_process_ecn() gets no send time at all, so this check can't
> be done there either.
>
> The ACK side has a similar gap. In B.5, acked packets sent before the
> recovery start don't grow cwnd. In QUIC_CONG_CONGESTION_AVOIDANCE,
> quic_reno_on_packet_acked() grows the window for every acked packet,
> whatever its send time.
>
True.

Will check quic_cong_in_recovery() before calling .on_process_ecn,
.on_packet_acked and .on_packet_lost.

I may also remove these cong->state switches to simplify the code.

> [ ... ]
>
> > +/* COMMON APIs */
> > +void quic_cong_on_packet_lost(struct quic_cong *cong, u64 time, u32 by=
tes,
> > +                           s64 number)
> > +{
> > +     if (cong->pc_detected)
> > +             return;
> > +
> > +     if (cong->pc_start_time && time > cong->pc_start_time &&
> > +         quic_cong_check_persistent_congestion(cong, time)) {
> > +             cong->pc_detected =3D 1;
> > +             cong->min_rtt_valid =3D 0;
> > +             cong->window =3D cong->min_window;
> > +             cong->state =3D QUIC_CONG_SLOW_START;
> > +             return;
> > +     }
> > +
> > +     if (!cong->pc_start_time && cong->is_rtt_set)
> > +             cong->pc_start_time =3D time;
>
> [Severity: Medium]
> Can a packet sent before the first RTT sample start the persistent
> congestion period here? time is the lost packet's send time. is_rtt_set
> shows the state when the loss is detected, not when the packet was sent.
>
> RFC 9002 section 7.6.2 says the persistent congestion period should not
> start until there is at least one RTT sample. Appendix B.8 only looks at
> lost packets with lost.time_sent > first_rtt_sample.
>
> struct quic_cong has no field for the time of the first RTT sample.
> quic_cong_rtt_update() sets cong->is_rtt_set =3D 1 but doesn't record
> when.
>
> Here is an example:
>
>   - A client sends Initial PN0 at T0.
>   - It sends a PTO probe PN1 at about T0 + 1s. The PTO from
>     QUIC_RTT_INIT is about 999ms.
>   - Both packets are lost.
>   - A later probe, PN2, is acked and gives a first RTT sample of 50ms.
>
> Loss detection on that ACK marks PN0 lost. is_rtt_set is now 1, so
> PN0's send time becomes pc_start_time.
>
> PN1 is then marked lost. The gap of about 1s is larger than
> (50 + max(4 * 25, 1) + 25) * 3 =3D 525ms. So the persistent congestion
> branch above runs, cwnd drops to 2 * mss, and min_rtt_valid is cleared,
> right after the handshake.
>
> Should quic_cong_rtt_update() record the time of the first RTT sample?
> quic_cong_on_packet_lost() could then use only lost packets sent after
> that time.
>
True.

Will replace is_rtt_set with first_rtt_time, and check it before recording
persistent_congestion.

Thanks.

> [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/cover.1791227050.git.lucien.xin%40gmail.com
