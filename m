Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195173C1D4F
	for <netdev@vger.kernel.org>; Sun, 16 Aug 2026 01:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786844712; cv=pass; b=kkW4wBgbrD0wFcqauOPdOF10NZvsRPN660eVNUdjIyKTIfstcXkPvhSmd8wHt7aj4ixH1cH21tnha5USrvG8EMcvWRP0HldHphBDigcbYGWMQmcUgQI9brgVshiMJnqS5Hd12sz+FadugeS+/DJrnJ2gc2shRWta/hVFUW2IK64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786844712; c=relaxed/simple;
	bh=kfYsGsVlx2LSXb+NzBc4Ja+XsbmxYmRYQgF4RrjduI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jWUBcoP5sQ2E211+HvQqQ9BdtRyMAJcn7XrrgobaoGKeXzKUJzJdyhdc2pfjfakNQNDKcw8QbHwYmL7meXafP+qUOkFHMMh4X5tyCMiDeTi29jZ91L+K3yKQi596HsbhmbsumpibTg7k3EK6RxCx8CVDZ7ZNCaMLPqPFuZhvNWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=GFKXquNn; arc=pass smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="GFKXquNn"
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67G0qjig3642497
	for <netdev@vger.kernel.org>; Sat, 15 Aug 2026 18:45:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps82601-s2048-2026-q3; bh=SBzO5GuiJiE
	8KfRRHPEXPGYU6uHkhMkhKP9R3gFGgE4=; b=GFKXquNnKlqW7qiqfZRKHO5EUVF
	i3BhSRslh0FS8T9wDsuXbZHhQ2eRGoNZxuxd/Z09D1ZIuysfWU3dATE4wpbPCJbs
	fWi8ZyAg/pXmoLs/jw3t+RDHNCGhbtT2xGqt+y0nxK4vaWH63GhrijB3rhnyXIbf
	4I10euKvMKvXWBVFSjf09IG+BAQuRk2MCaI/AejWJGryFygTaESxCzsByyNRHZq7
	9BaWt6dg/eHIxb/vc6/+1+b4dmTFOW+5IoEjYSriam2IoeumC+i/Sy2xat6fzlRT
	SYi7+Ye1QaTQsk0L3VmCfHGwD1PZwXVKcu/okWbLP/5yYRrMJhBQHY0vA0w==
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com [209.85.167.70])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4g2ke2c52b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sat, 15 Aug 2026 18:45:10 -0700 (PDT)
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5b2a35b9306so1150607e87.1
        for <netdev@vger.kernel.org>; Sat, 15 Aug 2026 18:45:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786844708; cv=none;
        d=google.com; s=arc-20260327;
        b=JNjNN5p8E5J+PjkVu9h54fUXip4j2tqrINw8ahpJbiUG1wf59yGXmAo+Sq8jWOP0et
         KLHI6tKo/Kpol/fJWKiIn07CXhrkVKxFVkHw22ZRYHBantgf3dB+CAi32AEr3a2rbG2c
         jn3zBMqvG6vFYCIBzol188pJa1dSp7DDZFC3ywmCXu3ZEZVPvpYOl9+K7v1xUwrq3lBp
         w4zDKuutO3X+am0Cc8+831vBbpkSoR8b5DbJbNXkoJFg2vFQgKQ6L97zf94PT7GKT+09
         g70IbSn3bvlVPx8lFiQ6e7/0jARrqzMs9xVRIcmo0P/tjPQ1WE/3M01I3fAUvX+loQIQ
         JWgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version;
        bh=SBzO5GuiJiE8KfRRHPEXPGYU6uHkhMkhKP9R3gFGgE4=;
        fh=sH+byn3vmDTYR3ODSim3QRk8LW1QGyiy0BawwymoMVk=;
        b=VCHKk2QjZR+wjETojHHWDxj37sUoFm0aGsrGOim7PYmp1OAkQwCB/2ZByHCx6JAaxj
         Bvrh19XMW2/Fn+y9swV8/AY1uE6tfHuaCQqvRVFwLaHk31ambJuSQ82XTKaf+CmYt2Zc
         vTcLYFTF0smp2wEvTcfnlf/p17+uVUeJ7myHlRijUli0JeZx2FEa/q/Yp/ZtdFi4L3GX
         PRktF71Me7cib6J8Ih9k4dqbMHWcbE4ztlhlzFRlwpZnVkZPkR9G207nYouwFgN9+jVK
         KMpj+5sIdSN4l/ew0H3KEto8sSfkBLGHOQ4qdkOvSBPypk1bpFTBCYy/BCMMqSTtMxXI
         z3cA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786844708; x=1787449508;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SBzO5GuiJiE8KfRRHPEXPGYU6uHkhMkhKP9R3gFGgE4=;
        b=tQwPKhwzt+1QAN+nXv/HIpJfJ8PQ3sexrbS9kK7/ZXDIW+hlmR1Xv5fwQHTyNyWR+h
         oLOH0AW2s+YcDIEVG81W7vSoq9v4NJQmQsZXcDLYBxPnWiwW2Hfdhv4fce6ph7t0KtMa
         KOZtmnUMspAUkDHJehu7CBXiq791LasyHM1ay7AD131D/hLRucxEHWaSQMDvdhcdwdyf
         9u4oRv+wpd4uk5ZI5JygDzAGT7kauFDVVKPRDkgxpc2Kpwc3m7JGhpskIuphubqhu0TN
         6oyI70tmg9VPTz32o0uumwdSN4ZkPyfNVgteMgHVIkEOuthTjg+fZAFmWLZ+i4uCvABb
         ABqg==
X-Forwarded-Encrypted: i=1; AHgh+RrT85ppN/K8sBqhhj8v+ENjzLKr7xs2XKOex1slucr55MAfUDW+dPEbb1IP8NE602susQyb830=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqg82vdJBpf4f47mpM4FCkzVX9+5KuV3E0Xx6bnbaLuQRiZobR
	y5g+lTKokUTHTyhE31uvvp2/f29OPoAcjz7LPdrOipzcJ1PRHwRLHts9NIm6zGDbHjxAJR1jmZn
	u+j0mk3EuslgcjguFzvy6qY5Tlk7Ot59UlkNCVnnqsF6pF+L0DCqJJh6YERSJzW1y2tmHBIUhA3
	zSOJSM5+ktqaSXpJaw+zXIo3UszcIchcs=
X-Gm-Gg: AR+sD10upH9HgP4V0KIpQ0D89jw0w0KsVOmjsS8rSkVUPVSZ0jL0gcnD5BUU3ys0o8S
	8hW4mc/bvJ1jHDJcvzhqMemhC9JrqX+Vm32qGOmaq/nF5+MMZjnX6mi9n3ian6L2u3hU3iUY0oF
	ufFyyzdf51CexeYveIGbuuPvy0K3S744D+zBAUvnSRq/elwzLjM1XTuzGVbw==
X-Received: by 2002:a05:651c:a11c:10b0:39f:7f33:e305 with SMTP id 38308e7fff4ca-3a1327dd583mr8985741fa.24.1786844708483;
        Sat, 15 Aug 2026 18:45:08 -0700 (PDT)
X-Received: by 2002:a05:651c:a11c:10b0:39f:7f33:e305 with SMTP id
 38308e7fff4ca-3a1327dd583mr8985631fa.24.1786844708075; Sat, 15 Aug 2026
 18:45:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731185431.2777685-1-gmj@meta.com> <CANn89i+wCHgSr3i7T_q6XL=n_JOSLF92LeWicy+_jJG3Lz4dAg@mail.gmail.com>
 <CANn89iLC3dQdqnQmMkv6mMvfvhsrcHqxfWqawYa=H=ZVxDR_XA@mail.gmail.com>
In-Reply-To: <CANn89iLC3dQdqnQmMkv6mMvfvhsrcHqxfWqawYa=H=ZVxDR_XA@mail.gmail.com>
From: Glenn Judd <gmj@meta.com>
Date: Sat, 15 Aug 2026 19:44:57 -0600
X-Gm-Features: AcwNN1U-K42sm4OLeT2g8xO3M_byrMXzZd8kTUqCrqFwURgh72gW18dfyG0ZP1I
Message-ID: <CAD7-H+nb-oc6LAWBzxPOAMBY3_K_Pdf4jtEnRCgJzkNSnjiMUw@mail.gmail.com>
Subject: Re: [RFC PATCH net-next] net: gro: coalesce padded small IPv4 TCP segments
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>,
        Kuniyuki Iwashima <kuniyu@google.com>,
        Richard Gobert <richardbgobert@gmail.com>, Kees Cook <kees@kernel.org>,
        Jiayuan Chen <jiayuan.chen@linux.dev>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE2MDAxMCBTYWx0ZWRfX4xFNv9wp435M
 Qxx7YsqmqbU7wbAUD5YSOU7r5zzOW7UKEn355whxu3abSq87/PNc4cWz/kYNoSa8bqks1IJZijZ
 9AJxsE5THIXK3tpK0UM5xLB/UksagiM=
X-Proofpoint-ORIG-GUID: fXSJTEw8ld3Pln0Iq7PB2dt_t4OmpPtG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE2MDAxMCBTYWx0ZWRfX6shcVdQugltL
 VN9egN5Z3IHPYRK1p0hdWgZ9KmqM2ViUHc86FWhvc2/sWwPFUmNNW5qXY9ui+q2kBfdq30hnldw
 p3DXaZn8K5v39LHieYnVR3aryCie/cP/4OrzG14ONNRYFr1f3+Gaeyw0/B3vHkCAf7sUsF347Zi
 VM2nFzH8+lGRLRGi9P/CwrtS73juI+ex9Xq+zB8sjZ6rbcDrHj9xT9/mDv0RHu+V7kfLEdto/0p
 IReurq95qCa2tGD6PGkqE3oPuH/5Q8cE+7PcatSPy6O/HAG7gzLSxNJGhZVdVRIAdJzGsGEVXte
 GjQqI7R+RRoz/K7PsQ99qUI/7lI71AeCKHxmeUXMWt7WXjt39La9/vJLwQktXh8ve37EriJlne4
 XlavojVMlNUB+wALLJHfY0R0vI7MYCBp/DfusIes3lSElALapqI+/CVEOxtki76Z9LQw9sUlESe
 DJqabPL7dz7Qjvfcj+w==
X-Authority-Analysis: v=2.4 cv=H63rBeYi c=1 sm=1 tr=0 ts=6a811626 cx=c_pps
 a=Ek2CW/51tKQgDdzxJl6u8g==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=8elwO82fXORLTBIkMd32:22
 a=AQbu2hA_U1hz7XJcf8YA:9 a=QEXdDO2ut3YA:10 a=5D7b1r8g3QutN-whcLxs:22
X-Proofpoint-GUID: fXSJTEw8ld3Pln0Iq7PB2dt_t4OmpPtG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-15_07,2026-08-12_01,2025-10-01_01

> Also do not change frag0 and frag0_len: In GRO, frag0 is strictly
> reserved for page-fragmented skbs (napi_gro_frags(), where
> !skb_headlen(skb)). For linear skbs, frag0 must remain NULL.

Thanks for all the feedback. I have incorporated the partial
checksum optimization into my prototype.

Before presenting a prototype that addresses all feedback and
provides quantitative evaluation, I think it's important to discuss
the frag0, frag0_len point that you raised above.

gro.h:20 agrees with that description:
"Virtual address of skb_shinfo(skb)->frags[0].page + offset"

As far as I can tell, however, this appears to have changed
in c7583e9f768e ("net: gro: enable fast path for more cases"):
  "We therefore can initialize frag0 to skb->data so that GRO fast path
can be used in the following additional cases:
  - Drivers using header split (populating skb->data with headers, and
    having payload in one or more page fragments).
  - Drivers not using any page frag (entire packet is in skb->data)"

skb_gro_reset_offset() was modified as follows:
         NAPI_GRO_CB(skb)->data_offset = 0;
-        NAPI_GRO_CB(skb)->frag0 = NULL;
-        NAPI_GRO_CB(skb)->frag0_len = 0;
+        headlen = skb_headlen(skb);
+        NAPI_GRO_CB(skb)->frag0 = skb->data;
+        NAPI_GRO_CB(skb)->frag0_len = headlen;
+        if (headlen)
+                return;

-        if (!skb_headlen(skb) && pinfo->nr_frags &&
+       if (pinfo->nr_frags && ...

Unless I'm misreading something here, not touching frag0 and
frag0_len appears to leave the trim patch stuck. Trimming
shortens the skb, so frag0_len goes stale, resulting in reads
past the trimmed length.

Updating frag0_len after trim solves one inconsistency, but
updating *only* frag0_len causes a new inconsistency.
skb_gro_header() computes frag0 + offset before testing
skb_gro_may_pull(), while pskb_trim_rcsum() calls
skb_might_realloc() first, so the head can move even for
a linear skb. Refreshing iph through skb_gro_header()
does not appear to be enough on its own.

I believe that both frag0_len and frag0 must be updated together.
This could be coded directly in af_inet.c, but gro.c/h owns updates to
these fields. If we want to cleanly update these after a trim, we need
a small helper in gro.h (other fields already have similar helpers):

static inline void skb_gro_reset_frag0(struct sk_buff *skb)
{
        NAPI_GRO_CB(skb)->frag0 = skb->data;
        NAPI_GRO_CB(skb)->frag0_len = skb_headlen(skb);
}

with skb_gro_reset_offset() using it for its linear path, and af_inet.c
calling it after a successful trim. The write then belongs to
GRO rather than IPv4.

Let me know what you think.

Thanks.
