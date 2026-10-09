Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28A6343D8A
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 16:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791563318; cv=pass; b=BbQ+4+TtrHl40XQyvcL0twphXWKj4UYAB6AlDl07ym/gzdK7y2GOmh+XbhEGkVAZZS6dC82IyKUY55OKHEIBGdKTJYwnvh+tPoN4Ob8bjftQG2nsfxknzD0IXFP9eQFqPlufvCZlYaU+wJVe/8xXs+XB9M1sKWu5DTl4UhHG5/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791563318; c=relaxed/simple;
	bh=aEEZOJq1YQBCl+EBhhXBbW8ir1k7qWPCFd9LKrrdcJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fUIuMV3bvRr77AuxnGUXhOTK8SpLB5+DluoVRAISghG7ARvx+VLv+Vkp1OOsZvK11IdxyBEjO4owqGHjin1PwYdlODcCo8fnMZaENFoSOHGA1LMNlm6bfAXW+np57jsb2WXlmuceDE5oBympJHMoUDOQadPMIBFeffChViFAVX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o+35tXEh; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o+35tXEh"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-150ef97e790so6258c88.1
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 09:28:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791563317; cv=none;
        d=google.com; s=arc-20260327;
        b=L7BvJjKTRoQDVw/VMGMk2V+iactgCO409NUUdjYLnoPhlsSfaK+bt0PyoLr6ZPYVXw
         4YjKXtonB9hwp99ht/SJofsRewS7EYNPI0j7XvwmyFNJK0H38/Ww5D4w4PT1AXtoGsCg
         PhKFeJ2Yw9FvvH56figD+uspkN83Itvk1whF7CDaM8qGz+eDTIwc4OD8YKa5H78ff15G
         AJK2fcFT04AgC1taBKG7Z3b2gEnX7NVUKFnvESt1BXamTo7dWXfqKt233JFRLEf74v+3
         Uv27uncM/mDAvEPWw5GYsjmmXZzeMAgY6Y7jEfMD8P1qcD9maIykGoREcO88h0X3Opcs
         2nOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gEeyzzUSwXoU/QlTHcalzbT11R3NUJQd27RQiZ05uEw=;
        fh=NT8ETwoEV/uQFjtHemcerQAoQv2RJAyDrA9hu9NcNtE=;
        b=nVdD3JuMhDe/h9rtXj9yOZ2nvtk/BOJoHKxmDMIcr0EfewJx+Usd0cIDlOeR0LzdA5
         E9bT1VXzbV5d4s3J54ufa/bZRLaPIaesEJEAom2gDiSIqbQq+E9VoNbN0Ex1j31CPKWs
         VvIvMmFdw+pf/336bJciFiVTnYf2kvgdTEWYShmYc1QJ4+JAs8BxTpyLHTZnqkGnLk0R
         c4O0+ITWP+ab4EC64uSo+Bg3VBWQJOh/1QidpRpAzmeTr/GsHkS7xhsbvQowtksrTr6s
         40VhhqXmW939gXtW7vVZ+FUhsU1Kdr0Q9ru6vmfEYH4S1x8LdGVUQSYWX0jNKTT7iBL1
         XMgw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791563317; x=1792168117; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gEeyzzUSwXoU/QlTHcalzbT11R3NUJQd27RQiZ05uEw=;
        b=o+35tXEhoUP055stHe450elM8Pde7XjT9r6mpXr9QUNVD5DEHxovL/+mbE9yLffc7u
         AelCVfSrubGoxQlCuqas9iv0BdB7BiXlqTICakIwKQTEOp+LpHLYTVhJPUfPURrslp8h
         Y9VCy3LBTHSB1LavwadSPIutBsxXhMd0X/7XzE/4FVSxCfGwwmHU57mq8xGKAobKpGmf
         p4lu+rQq9rVx9H8lzoJndqGjBHiYgs7QEdTEvPApfMfw7JvbuCLtUFhvYI+CG6UOxe9x
         4sBR+o2tFi8kFuvD5Vk1lWwm/XADmEEGxbpNG/6sCB4jF2yOtp6Gc5finCtz1csUig9s
         FGfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791563317; x=1792168117;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gEeyzzUSwXoU/QlTHcalzbT11R3NUJQd27RQiZ05uEw=;
        b=cxF2ntKZYYmSyfNj0Gm66c5l3M3jlDzOCgwGY0hGq7r+jUvirAiQh70yyOi+uN6n8L
         PtsQ/xknWebYmAGznQ+vPDjE/YP+WTug2DAOCG71baUDTVMJbMun7WHUWe1jPfLRx2Wy
         O3SOEYEkn8k6csTErpcsDnrmBUBKPlMi4FGCUf3A8/9MQ5WBGaXUJqp+lzp5aWOj1j7M
         T6Onu8c89229tslQcGDrzMmJkt7qaShuwVo8TYA73YwMoi/s/IPgwv58Ys+b4Ha1PSTK
         z7dauqCqiyK1w5q8o0yABMYQ6FewI0R25+qmayRZ+Vmg22VNBVN22UGbHKnzneD72Nc6
         G4XQ==
X-Forwarded-Encrypted: i=1; AKwUvBzMpia7szSUDOt6OkAVAMF4Hlpqt2VcrcHALN8kT60mXSsPt+UEKqcNgg6X2INcqTbgisXMUfo=@vger.kernel.org
X-Gm-Message-State: AFuF++m1vHL0gVHf3kiYiV0LfZy56Gaxt/AnKcPiZH33Y+rdsxxXykXi
	WmVwQ47ix4hOB9z1iTauaKMbXklBKlTZKMqo7su3s9F/1bqekr0/DGEFL5AeYMOjKx9SK+F4Wxz
	Rg+QznjbevgVOToDMZLApHoP/w1KMjUn/bdNa2qF8
X-Gm-Gg: AYBFou2HSsVVptTzvcIrOlIwhPz+HtFmKtTC/3oUlp+Vv58w1vr86oNTw0wSQ42+iIH
	gMGXNXZ3K3Rgdilt18ybSEHiDVwFdqwtjqdm5uX9G4e2qrT+nwNZviXbYZPP2ud+ty27tu9+npS
	G9Bqi/eFoW1t2AdasKDXiIcNq8ATiP36qMcjLuATTfTFeRg3mGeuR6auV5VvIsIht6hWyLzM3EB
	5u7J3wfi8VKkvdeLQXuBKbMxLNWwS+YuULHkfuzAdVrrmj5+pJUPMuwqafhWml7Ep7Jbu622FR+
	kmXBIzdFpgB9CxCiOk3ULQaj6HNVnYgKlNHM7iFEZoRT0p0V1n0BjjoUhPDboKmmXA==
X-Received: by 2002:a05:7022:1506:b0:12b:ff98:1ed9 with SMTP id
 a92af1059eb24-16a4d57c474mr309609c88.12.1791563255822; Fri, 09 Oct 2026
 09:27:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261006-b4-skbuff-bug-on-v1-0-1b4434c5357c@toxicpanda.com> <20261006-b4-skbuff-bug-on-v1-5-1b4434c5357c@toxicpanda.com>
In-Reply-To: <20261006-b4-skbuff-bug-on-v1-5-1b4434c5357c@toxicpanda.com>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 9 Oct 2026 09:27:14 -0700
X-Gm-Features: AclHuK81ahTE51wC2Bp7FXQn_Jc8YWHqO5IFJUkY7wkhMiw-xblsjCBwxgAMBh4
Message-ID: <CAHS8izPj0JCi=-tjNBTYH3=-ak_VLCeKeWxTrwAt7vs8LDgn5Q@mail.gmail.com>
Subject: Re: [PATCH net-next 5/9] net: skbuff: don't BUG() on leftover length
 in skb_checksum() and friends
To: Josef Bacik <josef@toxicpanda.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kaiyuan Zhang <kaiyuanz@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 6, 2026 at 10:10=E2=80=AFAM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> skb_checksum(), skb_crc32c() and __skb_to_sgvec() walk the head, frags
> and frag_list and BUG() if they run out of skb before they run out of
> @len.  By then nothing has been read past the end of the skb.  The walk
> stopped at the end of the data, and the check only tells us the caller
> asked for a range the skb doesn't have.  commit 06a0afcfe2f5 ("xfrm: do
> pskb_pull properly in __xfrm_transport_prep") fixed one such caller that
> crashed in __skb_to_sgvec().
>
> Warn once and return what each function already returns when it can't
> do the work:
>
>  - __skb_to_sgvec() returns -EINVAL.  Every skb_to_sgvec() caller has
>    checked for a negative return since it learned to return -EMSGSIZE.
>  - skb_checksum() and skb_crc32c() return 0, as they already do for
>    unreadable frags.  The resulting checksum is wrong, so the packet
>    fails verification on receive or goes out with a bad checksum on
>    transmit, rather than taking the machine down.
>
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>


Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina
