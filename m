Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792504157;
	b=S0Z5H59J4eGU29tHhFsDpl6V+Do4bC+KrdC7RsRwJ0SAF6hSFjhg5Q2gfHzN00joZ1u1
	 qAtiGgy/yyx9/Umw3mYVUZohKzlhttyv/wJ9B+HC7OP9TfcdsrtNarfbO5QFbeOlbmPWN
	 izQDPUwVGbK7o87FQCbO3N4W8QzNrDfzWfb8JozWEva58XEtsoV86UloHPkBIh8gdf7Eu
	 NtFKwT+dOejpL7UF+FyRcLq/swRG1kdVOk27lT9p25V7W/Esd3b/jLlYUKtU6d04R+CG8
	 Q0Jjtfh6wS7YCliBSmsaMNeVo7juOinULhd1irkj8AToozwmms8hvPhiH2DEcfDBi/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792504157;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Vx5pn8LfJKkYukkBFBaIEiQbK6iX6OqWjqt7DXKords=;
	b=X26vhbOjccZIthTgkeVO0f2CBBL+zMzgsKPYXKN3r2tcExndVV9SOC4e1JSiXBCkrMPY
	 bXjXga4Kvgv7raQD9zegMYDDMW+Fxuw4KW+6oSY4dGnIfFocNAnKAZbEVi0hjcKQsyS/5
	 Mj1kVADbz5m0JJM3hsYKH/QVflM18nq1Vr+5tW9TIMudWuqSe7I0RRMrV2LORxhVgTCiL
	 wOykOlpE21F7/R5HRbX97i2mSPWMePI0cKcGSNNn/9CXAxufqq88DT6ZGDQTWMTfhJfFw
	 tFZaCmhegpVp/BJqJ3oYgYaV8PihxO2rft0O3OdSGOGV2/fiAfXbilr+gLFsf0SZpqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qQpRgCIB;
	arc=none smtp.remote-ip=209.85.221.170
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBCE606AB01
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 13:49:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6DBCE606AB01
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qQpRgCIB
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5eac48af23fso868288e0c.2
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 06:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792504156; x=1793108956; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Vx5pn8LfJKkYukkBFBaIEiQbK6iX6OqWjqt7DXKords=;
        b=qQpRgCIBv2HcEljAYpQ+GyAMm/ETVu+Ak1bTpWnkvkKdb8jiTNswmqyaTjMjBRv1QO
         3VajOtVYiY66DUePelWveibiWhlWIsbPgFZTDKsW6Ue0sr/DN9zRI1qkrCxwRwpHhUL6
         zLQGIQV3eRzcgdcqh238UBSZRoiq9jaZBZmDQSpj5SVBM/60GBQ6qFzkL+e2jJnPsI5v
         7opj3f5RPUzi2OpBbRu9NxkVzJfMQNr9Fcy+SBNXorNmhV01hSbKprI3dB0pPOx05jD5
         VroN/7WtsFq8dYET0gfsDloqDlNb/EavO14inXf9P1CETV70e7tE8sCs9MJfkoGoLo+k
         EoFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792504156; x=1793108956;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vx5pn8LfJKkYukkBFBaIEiQbK6iX6OqWjqt7DXKords=;
        b=ZhApeEAwKAc/5YYl195OjG2gmrQnibOfnPQjv3mfyOCisICxbGqkAH5AVO4BVNd3rv
         /i88B4V3l0M+hyMJcfzoK1v4yMHWigvrlJATk/d1e0f7PiTS8mfDqKnrdbJovUbHq4Op
         z1y/M4Uf1iTiNUbnGQDx3HJHweyNUwFbcqdeKkulObMydl59hV461i97owNFEVTz6Z2x
         J3atPMEwvXjRSd6IH79IB/8RbeXtyv1ZJL7lJFXsg2vrlG+9EBD5Yp3itJ6wRXdrFbl3
         mHrzCvy4n3acEpvtxljWDRN2PEz0WwIIrqhNygXKz+Gp8hHGLA4Gza7/LFZOa57dKCis
         JTzg==
X-Forwarded-Encrypted: i=1; AKwUvBz3hFs02+H4s+zdpWavRDmDkf9GPCMFz57XsUnqHdN1RcF0qil2CA+AArt3exX1BTlEP+b0Dxc=@vger.kernel.org
X-Gm-Message-State: AFq9FYKdB6iykaXWRPttt4NZb4POHTdsd4rsRZ/EvptiNJ5+XTgwfJQB
	lXe4PiS2Y5Y4oXFf+dDmyIGgXbSm6gxPNOHTdknbNb4TReGLbc6NMBaL
X-Gm-Gg: AYBFou2WmS9kvpkGTOs45ULzN9hPP4wzY2jmdEzM3lX8s/CCjd3wgebhiC5LHpG09v0
	npo4If7ejBNeOpL/tgeCiHSZgsZGvnKfnB9Kd1StqUVjV6mpPTl0RHDPpoTbpEgJkbHDDoI8AHE
	vqnlMjYWSJMJVlDjirUw9XIPSYFMM8Dg3paJ7CIK1EaM4Ab5pmfJ/H/fv15eSg7ufPOFx++02Hl
	AxizSz64IZiYkv3vqcb9E78NCtJ0s2ZkeCe5ZgxrgcKS7EbMKLjEP5XHGM240nBMNRR9twZlJoN
	tKxp99OX1OXRHxGowz0TchcFGx6scI/ts3SB+SYgOxHdQ/02padH0keLc6onKVS/a6til/LPndy
	v26I83bPoD5+sw8s4axg/W53Qs9XcfGeQPjRPcpCic1WDI9Y6rVimOkPNoDT0xdo44nTQKYePjF
	BXyuMXVpGRBnBPJ2bYGCbFBGRMbD7nLAUogIjh4qSLyXpGwb2Q7DP2WDE+RAwBlRz4I7AoljH7N
	KeAfI6djVVLHtXf5lDV+akoY1/hEkLdCAP6kFl2799ocLx029E51lLuFAmvt6nBqNSsccsVsXpx
	Y9mmU8hosvg4hlxBKgw53N2oYhUiyF2EwMCTFIkm/uSkUf2/5/6WVCBVRTOZ83kjoifnHm/f2g1
	P2csMbFBOSmvEI2K61IoO
X-Received: by 2002:a05:6122:1d05:b0:5ea:e052:2ef0 with SMTP id 71dfb90a1353d-5eae05230d8mr360440e0c.9.1792504156234;
        Tue, 20 Oct 2026 06:49:16 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ea9b518bc8sm12525922e0c.11.2026.10.20.06.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 06:49:15 -0700 (PDT)
Date: Tue, 20 Oct 2026 09:49:15 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>, 
 Josh Don <joshdon@google.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.1d24f2bb46330@gmail.com>
In-Reply-To: <atbsxDZecXYSDBqH@google.com>
References: <20261019230758.2960779-1-joshdon@google.com>
 <atbsxDZecXYSDBqH@google.com>
Subject: Re: [PATCH] udp: Add noinline_for_tracing annotation for
 udp{,_v6}_send_skb()
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Kuniyuki Iwashima wrote:
> On Mon, 19 Oct 2026 23:07:58 +0000, Josh Don wrote:
> > We hook udp_send_skb() and udp_v6_send_skb() using BPF fentry programs
> > to monitor UDP transmits. Both functions are static and have two
> > callers: udp{,v6}_sendmsg() and udp{,_v6}_push_pending_frames().
> > 
> > After an FDO profile update, udp_v6_send_skb() is now inlined into
> > udpv6_sendmsg(), while an out-of-line copy remains for
> > udp_v6_push_pending_frames(). The fentry program still attaches
> > successfully, but it is silently bypassed for all uncorked sends.
> > 
> > To address this, make both functions noinline explicitly for tracing,
> > as was done for tcp_drop_reason() in commit dbd5e2e79ed8 ("net: tcp:
> > Add noinline_for_tracing annotation for tcp_drop_reason()").
> 
> Unlike tcp_drop_reason(), udp_send_skb() is a hot function as
> inlined by FDO.
> 
> Did you see how this change affects to udp_rr performance ?

Yes, maybe I was a bit too fast in assuming that this does not
meaningfully affect performance. A tcp_rr is worthwhile.

Or, since these functions call ip(6)_send_skb, which cannot be
inlined, perhaps a robust obviously free path is to attach BPF
hooks to that (and filter on sk_type and sk_protocol).
