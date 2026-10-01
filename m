Received: from mail-yx2-f38.google.com (mail-yx2-f38.google.com [74.125.224.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBEA395AD3
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 23:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790897444; cv=none; b=GGVtCxmGZNfryEUSuotbLynaX17oCJccxaaMlwJ6WrxUX/pEGnmt4YaDlkkMPKLHXk5Xc8ZFtNseDzgt//hsIMnlEz9URrEirFi1GM1ChCmIAZMZJa3P92vaH3dY4dcI+Mxyd63Q079DwaMY+jRyRbpxjpA24SrtbyX4+tnEh6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790897444; c=relaxed/simple;
	bh=WLTB+sZZf2wNRSIM+S6/SLdIn2Dkw8XFfu5Iy5GOmMA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=u5TriexY428H1MKL7OlvNkMjvU+dCCXqRRA8OrEOUcJFfPP6uhUljU6Y7v/z04Cr0vr8ysQIOMdkdhVOqfRgXnVG4NNOxqk7289XvmP6qPOa8wuqTxSWfTyWcqUjNbVZOQiqbcaFDFUXgJja6xafKXYJLusvW314wl+xJyFksgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k7jMDS7m; arc=none smtp.client-ip=74.125.224.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7jMDS7m"
Received: by mail-yx2-f38.google.com with SMTP id 956f58d0204a3-6768033d654so2474218d50.0
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 16:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790897442; x=1791502242; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FN4DLb9s8h7PnriBnjldQ6rFsgm/l6KqXxxzeKqYvwk=;
        b=k7jMDS7meSzKUYgG6IFXwfPG3pNUIXqBkN4JRdFlnF5xLU5vVmK1FWhIn6+YYMDeRJ
         8Y8/O++q5LzIHWHi5/u0LvvfqC/AW3NozMGY55XL/W8pciyRdmsGvpWy5HbNMDWiihXE
         TGPJMTi39nJXufyYKz+eE5E+heMc89JUsxNU/QFWvcVF5dSdY2UMnlMJvuh8dHVxYKAn
         xIjCLzKJA/xoK6zngNhWE8YSDUArFGyDa/MSPzxvLukk7w3MFsy+OJqK39wdFRIAJGaV
         tWxJqEYQqCtMJ8XsnC3LqJeIlOxhwpMvvwEkEMe/DplJpSQlE7hVZBp7H112K/ymcpGV
         Y1DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790897442; x=1791502242;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FN4DLb9s8h7PnriBnjldQ6rFsgm/l6KqXxxzeKqYvwk=;
        b=cPi4sb2xAFxDkvxjcN4jOfrAuzYzxMCSGN0681G6geqIIG9YduJ1sMFCcTPH9dxId0
         6vVZnDMUKTneeblHuaejI0etkjAfSAlQVyqyIiOfYX36+k7CiMe7XO9rp0CQq4IqT6IZ
         +8iD1NqthUdCUU7BIwuUIIZaWa3UIB26cLEKYa5+4PwGBRkoTWSpj+3wet+3CHPIkbK3
         1jo+NqhCnQ/NYXwJJqWBSzUsoYdq+W2apOxom+j5wNlBGBaRSEe/d8A3yuURV/SaKmMd
         vTq9w+ts7N7GlR4E7Skop626Rl0nJmk1Y0eiu4A7e2NENKSiR+Z9vOb5VQGwD+dHgi06
         Zp8A==
X-Forwarded-Encrypted: i=1; AKwUvByVWb7nOEGywf83rq8grlnz+17CQlI+sEZ1FRw9SD9M6C4BKOBUyQod0D9mhhjRjorLSaXmIS4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJJGyVYk5596B7t9YgTSE30auolGq90F9dTZvWFhSeSEU0wCmFy
	9BbkDq7j+xi/ksJHWK3ZFDWaIJEuqTZ/E5tyYDG7iPNK2M++rRtj0/4B
X-Gm-Gg: AYBFou0UN7EHnPMQjmztIunDXlBsv/vvxZlX7ysDlPGqeoM659oLspAdxvYoDUvl8dK
	2M0uUyJ9+EYFipEyktUqFQsqRndqWVCO8DROhsJUsMnr3sx/ImevbArZxQCPWcDIZqfa8pnKduf
	1nJQpOjbyQS5DrcdrvgKeryPt7kBR9caAd1WN6Xf/EenSolk1f1nt187LeuGDbjJR50iSzU/BJ+
	ltD8qrw+oTMthJ9W8Z/dO+fMuPa+pG86vCPbOGEtcAF/Z8SOkjjHa4yPQh0WSXI/I4ETAcgsO5G
	bDDl1lhTSdLNr8gvnzBcf90PYjtFjqddZpPQ/5t6OLCE4/Ai0sWpjlNql5dfnZO2B/NLU7lxDTV
	8bHq5ggc7fDff4PO6BTy1wZVsSKB52fWxGlnTFS9wiRt4D0b0H4dvodRq0tK49asohodfA/rhV7
	2CDtNBKqfKhSXhGuZytxsUaSvOr9NhFdOc1yhj77gLGfHJ6z5UvNS0uWjC6anclfVtHJIIgcQ41
	hVJ2N/Cp3HXVKLcuJOysxFVPR1gCDZbgXwxGKdjcNYrxAYhLEm+
X-Received: by 2002:a05:690e:43cc:10b0:672:a055:f994 with SMTP id 956f58d0204a3-677ac0d91e1mr350168d50.55.1790897441671;
        Thu, 01 Oct 2026 16:30:41 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8ae33fe81fdsm2974547b3.47.2026.10.01.16.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 16:30:41 -0700 (PDT)
Date: Thu, 01 Oct 2026 19:30:40 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@kernel.org>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 netdev@vger.kernel.org, 
 edumazet@google.com, 
 Eric Dumazet <edumazet@kernel.org>
Message-ID: <willemdebruijn.kernel.2a4826c889744@gmail.com>
In-Reply-To: <20261001191140.2818991-2-edumazet@kernel.org>
References: <20261001191140.2818991-1-edumazet@kernel.org>
 <20261001191140.2818991-2-edumazet@kernel.org>
Subject: Re: [PATCH v3 net 1/3] flow_dissector: avoid u16 truncation of
 skb->len when computing thoff
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Eric Dumazet wrote:
> __skb_flow_dissect() computes key_control->thoff using:
> 
>   key_control->thoff = min_t(u16, nhoff, skb ? skb->len : hlen);
> 
> min_t(u16, ...) casts both arguments to u16 before comparing them.
> Whenever skb->len (or hlen) modulo 65536 is smaller than nhoff, the
> truncated length wins and thoff is set to a bogus small value, even
> when the dissection succeeded. For example, an IPv4/TCP frame with
> skb->len == 65540 and nhoff == 34 gets thoff == 4, so callers such as
> skb_probe_transport_header() point the transport header inside the
> Ethernet header.
> 
> Such skbs are not exotic:
> - At the time of commit d0c081b49137 ("flow_dissector: properly cap
>   thoff field"), AF_PACKET with PACKET_VNET_HDR could already build GSO
>   skbs larger than 64KB (MTU checks are skipped for GSO, and
>   alloc_skb_with_frags() accepted up to MAX_SKB_FRAGS (17) order-0
>   pages on top of the linear part).
> - BIG TCP now makes skbs larger than 64KB common.
> - The following patch makes tun_get_user() dissect IFF_TAP frames
>   before eth_type_trans() pulls the Ethernet header, so a GSO frame
>   carrying a 65522..65535 byte L3 packet will be dissected with
>   skb->len in [65536, 65549].
> 
> Compare as u32 instead. If the resulting offset cannot be represented
> in the u16 key_control->thoff, cap it to U16_MAX and report the
> dissection as failed rather than silently returning a wrong transport
> offset. thoff is still set on failure, as some callers (such as
> eth_get_headlen()) use it regardless of the return value.
> 
> Fixes: d0c081b49137 ("flow_dissector: properly cap thoff field")
> Assisted-by: LLM
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>
