Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792532114;
	b=GxdbSTUjVjf8mX85SlXeUeknZIGobNgP3KfrvTxE/DiAgUf04yi4t6GaIU5sisbX90BR
	 jRC0hmg9onrJDXQBlrB5SockN6FOhlgJfce2NvOw3r78i8aNREHcSMOtlcjrxaSqskQ1H
	 GFL+hb9XzD+T5sGqCw+vk508P5gCXffONILuxLqGAD6A6SD4Exw7Vaoc21jIxIjw4yCwq
	 cmm0VKhzKeeHlkSqH9IGnIkDr5LRFQysNi6ORSsP7jvK8X+5LhthdZEMq5qRAmJwxS8Vg
	 WhHbHLOmEebTQ9j5vcoe7gNLYl9Us51velX22p2H0G4jcR/Pee64wmU4eGMqWArk9Jg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792532114;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=kxbmWpHG63bcj8caJCx8dB80g5mvO4e9eYY/N+k9SP8=;
	b=3LyzMqMokcWr6WNutkrc1bbBoOI7jBcJOBZtFnBwJpREtVjo81Z/lKgyi1mgHd8U+dPC
	 8sdcJcJEUnUrcfpT+w3XM/bX/Rs0Ri32tvUCRGAR0jZiiVY9sBh7otdeIRxdeNIEcpxAG
	 mvt8eAdQFNj9sIrNi/n4aCA0+Cfudv/1zMlumu9ThV5vkGGUuF5SypVlWYQQKjJ9FSs+P
	 gxz69C5ZrDaGcxDdO0xLVw/TrKaNgJNjSFuyGGVGrgt3WG7FyyGaj2+oU/Eu3akg//GcW
	 OL9MjrU6HXvDjqAPhNY2g6+a9nHWOHVL/ge5o6P6Ccy3ctKEERkygiJNK2JnS0xuobg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pOUaCAVr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.43
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC49606A31D
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 21:35:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9CC49606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pOUaCAVr
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-7cc2bb73cd9so36611137.3
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 14:35:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792532112; cv=none;
        d=google.com; s=arc-20260327;
        b=rDoI8vAAWo5acbMRssveU5PVoS20LlPgdM4EfuGlhFpMGqNGlipok08kF0Hi5v4mAa
         0DoSim6uL8+g9rLCV9NdAYWADv5Ou8ZQYq3fe4cd+n2GAUF1mRpb73r5GLNGZmG/h+y3
         gasbLtTVvnmM62+WtH3vEMgnmCGJdwtft7W6hy0WPSg8OybR9KSE+Iwmx8c5WBlxiMYY
         v+4L11z4btez/MuntOpxtM+xhI06X94cFGg8P8sGSYhhwBYfIIT166077M/xbVBt5Eoh
         /+xI7yo4YQQVBdEx7i0Lnh29th3ejUf9XkdgiLDuVBhAIAe4VLs67MjklcD8oNZgLdb9
         hWuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kxbmWpHG63bcj8caJCx8dB80g5mvO4e9eYY/N+k9SP8=;
        fh=FcywtlDZoDkM4edKsFlp1mDZyBkJFKZZqzJffsc2CVg=;
        b=ea7ULMtdBsvYYnXIh+TbpHwuecnB9GyELSpbPaqDY3FumJebq/+13TVqSOqjCvAVGg
         GgpxMW+ov3oS2Uj7zs6RuW+pQRxqvWuTRRjFtU5z5i60fFHzKFy08bCypx3YbmaHQr6+
         yDwqq9mRy0cFnKkVqLiTRFug5nTzTXvTVjChop8oPVMKhPjedItDniKU/ES/Fg/EYc2g
         4r3OFkQ9IEV1CFLsQaouQO7ru2w1uOB6liRp7faPF/3+pN5Y0CcvXtAMQuombTsmnWhg
         6SgG3luI3J3jdwAd99js8nMAKUsyUE14UPxGx1w3QWabSiO+z3LyzHt4fewma6QGcKOA
         8xzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792532112; x=1793136912; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kxbmWpHG63bcj8caJCx8dB80g5mvO4e9eYY/N+k9SP8=;
        b=pOUaCAVrjxYubrKNIq3KlVZ8P8wsutpG2JfiTOZSU2hCnHiDXJSVLwjH8kL9VQ4BeL
         /P3utoyemwNhyAEQefHUSZzbPprW5gbLPp5bBKV/tOE2gUD6UW4NEBx3d26IqfBuMPVq
         qSZ9NQukAA23m9+iyQ6v3FJhrHy1Om56+uSgfyCL7QRjXfjax8YVpiRKK9hKE/4uuSFB
         aocIg51LoZqc+dVUnMAKffzS753u7PCQDvZhOgtpfwB6zvAxtttThOmYaIeqRO7pNVDe
         wpAgAFtGyle7Vw9wGCdP2sruAtSnRapso3ZBiJYPYmzMqOF+Hfzv+/7WkxidRcmaE0T3
         Am4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792532112; x=1793136912;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kxbmWpHG63bcj8caJCx8dB80g5mvO4e9eYY/N+k9SP8=;
        b=BFY99vbSfFfFuqmsA6NfexXe2WWSRZk522QMihx2ZLLrxuE5GREKlB8sR4i/Y4KeJA
         LT3ECAlvIi3MSwmzGpJ+a3yekuyT+PUjnqWorcgNKzGYTfSirV83coPc0fv83mIgKj2x
         o3mx3TR9zneDNfQdX4DuVEiWdRr2XqgglplnbBEAdodlPEH9hLStuT1xTrmU3FNA/ZqY
         PQVKVpr+Tm3Z+g6xuoSIaFuAAXU0xtZ3SVVcI7pOPvzD4053goouYvLcZXzVWDi+ybxb
         GqvYROJSwzTL56dmw516+Rorbl6aF1jwZ0Su/hRZiYQ5I6ecF+HSB5jZ2rRDHvZOtpUO
         y0+w==
X-Gm-Message-State: AFq9FYKu9YkcB1fScaF9foFGl/tPuJY8SiHLP9Wk2FwbEyC/QJ5ZNekP
	73z2JWLtabgFckOh55yN4eYleR4Pf0JjivwDtJY8vfpBWryK1CUcVli06iHy0ZR10phKzQWNOOq
	UC4vXhTai9wsnzx4kkJCQ7Q+GD0H7xgw=
X-Gm-Gg: AYBFou2bKEFtI7WybNzinrM+7yiw9pMnyfgKQYb6h2R2BQsfoRkMr0ES0Bm6xmTiIjH
	5QKf8L6n7nxjhTvA7aAk0gnGoudgzB+hWrJLZbuIr0YH7F1alum76jtmXrYHp09RjjBVZ73AcNi
	evsDeYA7RdrwrT1LddJkI4GmrEC/83pwDyeRs37dQLQJ4wSzKZ4/Zqa8SYiS1vCjkNEaENJe5WL
	sBhLiF5VVhbu+2F6pUkgIKSNZLrrnWC2hhkYl9lIK908jFigcgPe8O2psQ7uA8BNPhCx5rXRWPS
	lNsuL8lr5qnoKRjGlnvUiIk3WQPFptTF/hvM8D0ctjKM0HAJyq3ye7MliGj4fMNv9+zNlTbfAp5
	XzaMI6DBZUqUJz0BpKaRQtoJoyNpAqjTX5VwADLkY9MV33BjRIkeJwhmHSTrWlsZt6LGkDXPqvY
	1CbcbCPIiA37zY
X-Received: by 2002:a05:6102:448f:b0:7cc:2cd0:e73c with SMTP id
 ada2fe7eead31-7cc926c4d1cmr146631137.25.1792532112476; Tue, 20 Oct 2026
 14:35:12 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <9e1c586f76943aa9fcd96cecedec805c66fc6e07.1792164438.git.lucien.xin@gmail.com>
 <179244540161.3135.791644548439735124@kernel.org>
In-Reply-To: <179244540161.3135.791644548439735124@kernel.org>
From: Xin Long <lucien.xin@gmail.com>
Date: Tue, 20 Oct 2026 17:34:59 -0400
X-Gm-Features: AclHuK-cqHur22QaAJB_O1MpvembykENtwhk63DMyFXPnpV5d6Oxh4y7OPcqRQU
Message-ID: <CADvbK_cWtvHg2Mbgwe1+2TZgGDwF9DY5NO8vjim5RLwufW3e5Q@mail.gmail.com>
Subject: Re: [PATCH net-next v17 09/15] quic: add congestion control
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

On Mon, Oct 19, 2026 at 5:30=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 2
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] When quic_cong_on_packet_lost() (net/quic/cong.c:94-99)
>   declares persistent congestion, it sets cong->window =3D=E2=80=A6
> - [Low] The commit message says the implementation "adjusts the
>   congestion window accordingly during packet transmission and=E2=80=A6
> - [Low] quic_cong_rtt_update() (net/quic/cong.c:207-209) throws away the
>   whole RTT sample when the raw send-to-ACK interval (cong->time - time)=
=E2=80=A6
>
> --
>
> quic: add congestion control
>
> This patch adds struct quic_cong and struct quic_cong_ops to the QUIC
> stack. They cover RTT measurement, loss and ECN handling, and pacing.
> New Reno is the only algorithm so far, and quic_init_sock() sets it up
> through quic_cong_init().
>
> > The implementation updates RTT estimates when packets are acknowledged,
> > reacts to loss and ECN signals, and adjusts the congestion window
> > accordingly during packet transmission and acknowledgment processing.
>
> [Severity: Low]
> Is this accurate for the transmit path? quic_cong_on_packet_sent() never
> touches cong->window:
>
>     if (cong->ops->on_packet_sent)
>         cong->ops->on_packet_sent(cong, time, bytes, number);
>     quic_cong_update_pacing_time(cong, bytes);
>
> The New Reno entry in quic_congs[] has no .on_packet_sent, so on transmit
> only cong->pacing_time changes.
>
> The commit message body also doesn't mention pacing. That covers the
> pacing_rate and pacing_time fields, the 2 * window / smoothed_rtt rate in
> quic_cong_pace_update(), and quic_cong_update_pacing_time(). Pacing only
> shows up in the version changelog notes.
>
> Could the commit message describe pacing, and drop the part about
> adjusting the window during transmission?
>
> > diff --git a/net/quic/cong.c b/net/quic/cong.c
> > new file mode 100644
> > index 0000000000000..765f50660f0e4
> > --- /dev/null
> > +++ b/net/quic/cong.c
> > @@ -0,0 +1,287 @@
>
> [ ... ]
>
> > +/* NEW RENO APIs */
> > +static void reno_recovery(struct quic_cong *cong)
> > +{
> > +     cong->recovery_time =3D cong->time;
> > +     cong->ssthresh =3D max(cong->window >> 1U, cong->min_window);
> > +     cong->window =3D cong->ssthresh;
> > +}
>
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
> > +             return;
> > +     }
>
> [Severity: Medium]
> Should this branch also reset cong->recovery_time?
>
> The recovery state comes only from quic_cong_in_recovery():
>
>     return time <=3D cong->recovery_time;
>
> The only place that writes recovery_time is reno_recovery(), which sets
> it to cong->time (now).
>
> Take a single loss-detection pass after a link outage:
>
>   P1 lost (pc_start_time is 0, first_rtt_time is set, not in recovery)
>     quic_cong_on_packet_lost()
>       cong->pc_start_time =3D time of P1
>       quic_reno_on_packet_lost()
>         reno_recovery()
>           cong->recovery_time =3D cong->time;    /* now */
>
>   P2 lost, sent more than the persistent congestion duration after P1
>     quic_cong_on_packet_lost()
>       quic_cong_check_persistent_congestion() returns true
>       cong->window =3D cong->min_window;
>
> Every packet still in flight was sent before now, so the ACK for each of
> them returns early here:
>
>     quic_cong_on_packet_acked()
>         if (quic_cong_in_recovery(cong, time))
>             return;
>
> In that case ops->on_packet_acked() is never called. Would the window
> then stay at min_window for at least one more RTT, until a packet sent
> after recovery_time is acked?
>
> RFC 9002 Appendix B.8 sets congestion_recovery_start_time to 0 on
> persistent congestion, so these ACKs grow the window in slow start. The
> state diagram in cong.h shows the same transition:
>
>  *             persistent congestion |   Slow     |
>  *         (O)---------------------->|   Start    |
>
> Here, though, the derived state ends up as Recovery Period, not Slow
> Start.
>
> Nothing in this patch calls the quic_cong_on_packet_* hooks yet. This
> would show up once the outqueue changes start calling them.
>
True.

Good catch.
I will reset congestion_recovery_start_time to 0 on  persistent congestion.

Thanks.
> [ ... ]
>
> > +/* rfc9002#section-5: Estimating the Round-Trip Time */
> > +void quic_cong_rtt_update(struct quic_cong *cong, u64 time, u32 ack_de=
lay)
> > +{
> > +     u32 adjusted_rtt, rttvar_sample;
> > +
> > +     /* Ignore RTT sample if ACK delay is suspiciously large. */
> > +     if (ack_delay > cong->max_ack_delay * 2 ||
> > +         cong->time - time > QUIC_RTT_MAX)
> > +             return;
>
> [Severity: Low]
> Is the 6 second QUIC_RTT_MAX cutoff too tight here?
>
> cong->time - time is the raw interval from send to ACK, so it includes
> the peer's ACK delay. RFC 9000 allows max_ack_delay up to 2^14 ms, which
> matches common.h:
>
>     #define QUIC_MAX_ACK_DELAY  (16384 * 1000)
>
> For example, take a peer max_ack_delay of 8s, an ack_delay of 7s and a
> measured interval of 7.1s. The sample passes the ack_delay check but is
> still thrown away. The same happens on any path whose RTT stays above
> 6s.
>
> The early return comes before anything is updated. smoothed_rtt and
> rttvar stay at their initial 333ms and 166ms, and those feed into pto,
> loss_delay and the pacing rate.
>
> first_rtt_time also stays 0, so this condition in
> quic_cong_on_packet_lost() is never true:
>
>     if (!cong->pc_start_time && cong->first_rtt_time &&
>         time > cong->first_rtt_time)
>         cong->pc_start_time =3D time;
>
> As a result, persistent congestion tracking never starts.
>
> The v14 changelog says the cap prevents latest_rtt overflow. latest_rtt
> is a u32 in microseconds, though, so it doesn't overflow until about
> 4295 seconds.
>
> Could the limit be raised, or could ack_delay be subtracted before the
> check? Nothing in this patch calls quic_cong_rtt_update() yet, so this
> only matters once later patches call it.
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/cover.1792164438.git.lucien.xin%40gmail.com
