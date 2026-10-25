Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.230.69
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792925777;
	b=fbab6gCObR9C2qHtRObKrS+K+JRyRjOdN3uSKGiL0j3ltiziJqIEEe1EzXUi7jquzcd2
	 VgJpd3zrAyILlLlNxbjco5EHn3G4o9ix2pLSBAoyNkj5PvcWJntxW/WeeVUcN99jO2MPV
	 fEIhvcX0FQAzJOQJedQTCw33uKnDwiX+/pf7B9nlDmcwl17Ce6CKdSR2jYar4BZ4gPjhX
	 8zQjXy7ihfD8WAAwAs7ILFcBgoIi1yFR/KEWYwz8jZT66F9Hj6V/Nc4md/xQUXmWIdOEf
	 gWUl4rwtQRxzYT2z0g7EktlyI9Yss8N5lRq0Lz2iqGb29N5jd2cNZ4HYNXCD81t1YXQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792925777;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=PQ9oPbDcyFUu9vKXUdSTs+d8wwqivnD6ZFmNWnp5kLo=;
	b=SLpwkKvhYl/800ZR875UOBXxj0UIR+fuhjxh6q0F1Uq8wW8K6GtA3tQr4NDmbL58jMyP
	 ZqOZjXrX38EfWE/CY1JisLJutPpsaoRodK0r4kSDro0bXG9kLxUkniTfE3swdw7451Xrz
	 zc15Y1FQgCysJQu7GkTddaV6hh2gmh9wUN8XTHp2jE/dViWpDVC7pmMNH+BTqxJqE1xf/
	 G/ooNtLy+NcmAbGlgDbpjcDlYyKC6FgepYkMZo+Sf7FKZ0vubclcWT96xqNRZNLUDP5AG
	 ERNEQ6i6WY7sNkyHb1ZTYpsrdFJEa7gANZfI9btNpxf3fjUQTUcnW18lEt0x4nuKbaQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aBsBQbbG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.230.69
Received: from mail-lr2-f5.google.com (mail-lr2-f5.google.com [74.125.230.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95869606A31D
	for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 10:56:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95869606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aBsBQbbG
Received: by mail-lr2-f5.google.com with SMTP id 38308e7fff4ca-3ab2a40750fso13287521fa.1
        for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 03:56:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792925775; cv=none;
        d=google.com; s=arc-20260327;
        b=ZwRWfxYn9d19RvfI1mdXzeBGTIxDgaac/lgKPzZM95q0iYarCTpMHksKkBh2pVnUBc
         i6xLkfeqlc9EaefCZtCizr1NjZYxkotWa7TEEm1P36f+VvxraUMfUSUXPjs/X8yiID4i
         XzJmhPs3Cn7HBHzY8NGwG3N3OJWJEFcK808gIeK2q8kU/GAuwmFJ3R1BYA5HX+DOb2YX
         J3fz/cWNjPhqZL29+AFLZaDPB30QveqWiX3srhfVOJod0unGb9ld5AJJ1k2sbin6GIgR
         EMe9SL5SbQTS87AHXnRGwpdtjLJSPtrnfx07Lh18ItPl8ZB2h+lBVLrdkCfGRksWV1PC
         ZgmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=PQ9oPbDcyFUu9vKXUdSTs+d8wwqivnD6ZFmNWnp5kLo=;
        fh=dolYqnrEXOJhal4Z1+M2B/MYu92wmwD5QYsxuxMomZQ=;
        b=NavvpF7FTKDAZyTgGnlYFrK+V8r33ZtOeABZ4pQhB/7xn3259I6k3n2HBEKb5YH/7Z
         2lNkIZrcW4t934YcjJTlB2asQ4UPi0M6hj/q06UDivxdx9RfEEO1PCs5tsX5tL6TwKDv
         MSLJ/2GOwYRYl9iCZgIT4GJUtnmGyVjwj3Q6JHhP3M69e1AFP2fmUMMXLMdX6auSJYdB
         yJ2QF6Ore9EecCriBVffR577WP0ofiOab2Jl8wycY00S/EX5RE6SeOf+XXgfWI8svLEy
         CMSXpuIQ6uCzfgM6f7NiP5ITMN0H8Su+zYwfgK+vNCqdB7X7r2falc5Eeiy7j7PCtoWB
         zzGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792925775; x=1793530575; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PQ9oPbDcyFUu9vKXUdSTs+d8wwqivnD6ZFmNWnp5kLo=;
        b=aBsBQbbGrR5oIcMkRpjhIJOCRIj0IBNpXKDrD9zx6fjxtqAjanBd8Os8H1+r/zx4xl
         6+d9iCDWj/+HcSqnEi5qIBrwLPwFKxrm2Z4z8DNQ6nYnOI2+JfH07UoDN719vncV98CI
         Gb0i+IhAzhpM3ubcWw1leJy/SqXVZy5Bo9MphwDvPUdirxwG8qsXq4EHsJKd3yuj4puY
         AP+aDID/3bVQoeMc2hu7+IJytNzYAFpiGaKEu6W/cCARUEAteXrW0q1ieeacIrAP61Tw
         fLiyUBmegszzpiqM9eBq0VC4YUVJdYtl8hjrr9hie3DXXg03neioxurhKqjl2HANR2eO
         zuPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792925775; x=1793530575;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PQ9oPbDcyFUu9vKXUdSTs+d8wwqivnD6ZFmNWnp5kLo=;
        b=dXCeVWWqDx3FIexRA69iPNr25a3p2HQ4XWeyt3HaNYt+7xZmabLO4v+FB8dDr/0oOe
         rMqf27Rcsy93KVcmxiDqY/jCyHcasJh9ecvr3oaak/ZCMHGe1B4qAVhLXNUUTjYj5bvn
         kmCKo/lM2zOcRUz39XzOLGpMqbYqroMeje0JoUmXONuG8zMYeXooETAJQORJXXyZNRTX
         8R0tYpttZeMqvIsnYBMHTmEjxqy38YI4NE0uNmT9iE2mt+wPBfelEriYBn8c4CCwXy9o
         Qwpw6WA5nioFYMi3JStxPoO35sAgGlL4YBFEqUOTLIg0vq3rYGPGaOnYWlNxJO3coFt6
         j0Qg==
X-Forwarded-Encrypted: i=1; AKwUvBzhUkbSBJJZH+xtJ80jU5NZkOygTfGdrccxz0dUyF5zbmJ+/MjZ5UQNwMD5yXYy2rng7MFGcF8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJTuaAkOEIariPOS9BWXysIlSb3VlayFg3IApXswRrz3Dss6CHg
	uqiGxAeZDhJvu/BmOg4cGgF6buj5wCJp9YVAz7Hz8tUsp9NZ9enIiYDAiCtxgbG/pjP/oamCVck
	WCyVefxvoLQYM5s2cpKqjJWGR6u0tYq7kp45e/ckHvclSwhX7iQ==
X-Gm-Gg: AYBFou384O5IG4/cEkpKsfS2V2DDupgY9pZhIbaltVD4cDAiEdQ3C/lTCKU++2YOsxx
	0h80XyhIaW2VR408UrxztLiv3m/q0QOcbpka5SZdYoaxaaz9KbNpaHbmCZpzkZgCiOJuBAm53wA
	kSbWKjiL4w1QtZ/0Q68CAKZMOGll+wJGGwBxgnzzLmOWxxu2Nf3XMfwva7YneAGu9lT8iZmuFfm
	FHHtH1sXSBP+226Lw/iRTeIfbQ66UjV4YxjE1G3ye2bbUzWBMimFA/Aq+LmMuPMGmTvHgfvNIxz
	2nlBoRKIQdmF26oek/s2+q9t169C6ROmIbkC5OSmQAVRLXID1KWRehQEGH5triNxhziRUt9OxhM
	no1g43DlGU2OdmA7IMQCkpDN25xU/o/396VGN8w==
X-Received: by 2002:a05:651c:1a08:b0:3ab:1532:1d71 with SMTP id
 38308e7fff4ca-3ac6fd438c8mr9891841fa.23.1792925774545; Sun, 25 Oct 2026
 03:56:14 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAO-4RZ1ZCPNR2Z4xoHDh0Vp3SO51oX7ojuH0CG4MsD14-RegcA@mail.gmail.com>
 <CADvbK_e+ogH4zafpqz8N=jY-oBruke8OLd4PEz9xa-y13Ys_3g@mail.gmail.com>
In-Reply-To: <CADvbK_e+ogH4zafpqz8N=jY-oBruke8OLd4PEz9xa-y13Ys_3g@mail.gmail.com>
From: =?UTF-8?B?6ZOu?= <fengaojigui88@gmail.com>
Date: Sun, 25 Oct 2026 18:56:02 +0800
X-Gm-Features: AclHuK-trGKoI9DjC2wqpShC4KLQ6ZGpweFu80pdhBG5d1lHmaC4sUY362mgIH4
Message-ID: <CAO-4RZ3_m4BN-+dkGdteAGdUwRHd4SA2pfAD+_+6z+iH+btrHg@mail.gmail.com>
Subject: Re: [BUG] SCTP: KASAN use-after-free in sctp_unpack_cookie with
 fail_skb_realloc (7.3.0)
To: Xin Long <lucien.xin@gmail.com>
Cc: marcelo.leitner@gmail.com, linux-sctp@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Marcelo and Xin,

Thanks for the analysis; that matches what we observe.

We reverted 62b08083ec3d by hand on top of 7.3.0 (the surrounding code has
changed since 2006, so we dropped the goto nomem error checks). The three
sites are sctp_sf_do_5_1D_ce(), sctp_sf_beat_8_3() and
sctp_sf_do_5_2_4_dupcook(), replacing the pskb_pull()+goto nomem with
skb_pull():

--- a/net/sctp/sm_statefuns.c
+++ b/net/sctp/sm_statefuns.c
@@ -751,9 +751,8 @@
  */
  chunk->subh.cookie_hdr =
  (struct sctp_signed_cookie *)chunk->skb->data;
- if (!pskb_pull(chunk->skb, ntohs(chunk->chunk_hdr->length) -
- sizeof(struct sctp_chunkhdr)))
- goto nomem;
+ skb_pull(chunk->skb, ntohs(chunk->chunk_hdr->length) -
+ sizeof(struct sctp_chunkhdr));

  /* 5.1 D) Upon reception of the COOKIE ECHO chunk, Endpoint
  * "Z" will reply with a COOKIE ACK chunk after building a TCB
@@ -1211,8 +1210,7 @@
  return sctp_sf_violation_paramlen(net, ep, asoc, type, arg,
   param_hdr, commands);

- if (!pskb_pull(chunk->skb, paylen))
- goto nomem;
+ skb_pull(chunk->skb, paylen);

  reply = sctp_make_heartbeat_ack(asoc, chunk, param_hdr, paylen);
  if (!reply)
@@ -2253,9 +2251,8 @@
  * are in good shape.
  */
  chunk->subh.cookie_hdr = (struct sctp_signed_cookie *)chunk->skb->data;
- if (!pskb_pull(chunk->skb, ntohs(chunk->chunk_hdr->length) -
- sizeof(struct sctp_chunkhdr)))
- goto nomem;
+ skb_pull(chunk->skb, ntohs(chunk->chunk_hdr->length) -
+ sizeof(struct sctp_chunkhdr));

  /* In RFC 2960 5.2.4 3, if both Verification Tags in the State Cookie
  * of a duplicate COOKIE ECHO match the Verification Tags of the

We rebuilt 7.3.0 with the same configuration (7.3.0-kernsight-kasan #2,
gcc 11.4.0 Ubuntu 22.04, KASAN/KCOV, CONFIG_FAIL_SKB_REALLOC=y) and re-ran the
same 42-program sequence that triggered the UAF on the unmodified 7.3.0.

Results:
- Unmodified 7.3.0: the previously recorded run triggered the UAF
  (1/1), with the first report at t=212.7 s.
- 7.3.0 with the manual revert: both runs completed without panic
  (2/2), and neither serial log contains the KASAN UAF report.

The same input sequence and fail_nth annotations were used. However,
removing these pskb_pull() calls changes the fault-injection sequence:
the reverted runs logged failslab injections instead of the original
fail_skb_realloc injection. Therefore, these results show that the
original reproducer no longer triggers the reported UAF after the
revert; they do not establish equivalent injection coverage.

As you noted, this issue requires CONFIG_FAIL_SKB_REALLOC; our tests enable it.

The revert patch, the two serial/console logs and the syz-execprog outputs are
in the repository:
  https://github.com/Zheng-zheng-codes/sctp-unpack-cookie-repro
  (see revert-test/)

I can also test the other two paths (5.1D COOKIE_ECHO / HEARTBEAT) or 7.1.3 if
useful.

Best regards,
Zheng Zheng
