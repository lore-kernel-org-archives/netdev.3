Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B12A23A99F
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 01:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788485056; cv=pass; b=K3QJOSCC+pmj19NGHt5QwvU7/TJHDCCHHrdAlL+kK1esu+w+L9w2nAaZKg82zgNQzmeqBDYWErPd3xeUzIqPIc4HIHaEF6Cca/cwiRc8b03BqfrRS6PV6EbGSDPqVpjZKU89iss8QnMdYMrJoNVCFQpckGwwQVKJ8AAIYkZvpLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788485056; c=relaxed/simple;
	bh=wwNOSdfvBfWhwJ/fjEWS9PAnwLSGuYcjOh78+uKt3og=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m1Qeh0kBsGZAKFs5Pg4eecRqMqwTw95itvVcoknctjIqydOP4V4t4Jokfbzgz0iTcficr4GF16bZP6ETVb23HoaAQDDLnTYo1wvI0ctYaFlPJSTX96RwLeCV7QtLEQmXS4c0bMwK8MK5xMWGbOYTmfXhpf3SJ1epOu+wUlUmCHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qn7zEtif; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qn7zEtif"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5b4adcce4b1so482039e87.1
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 18:24:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788485053; cv=none;
        d=google.com; s=arc-20260327;
        b=T/AqQ0dWJgxqnfGCu5xRUOgcNROrsw8QkP0rruM8UtmxYgcqU8FLs1OrMHW+6bXxZo
         3n0IbdWqdyvHOy1N8DC48+AxMFMp4K0NTAqnqTuStxN947jvX5S/fcZ8GNr3bZsObHm9
         4n04eMEcmneEh8ZH3gSY9cwaScIu9zr86I2zrOFTEJt1eqqU5aVLDvlyAR+f/+LMBPC+
         AzizpOwDkFv7aDUq4PRd3t/wcIHAkoxcTlk3gXbYZmAQzeXNihkj3BjN4l6tspVAftAt
         bWCwLfswVKCohDBSDVia4JUC29b+LeUouyJ0RTNSpiHZLM16zK/AH3XxeSm/fGe4dkvl
         1dcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=V2/30HstUwHfXkbdeQnzzUjJbfvh5oDXpf4S1HaYLSE=;
        fh=LcnyEc54OEd8Idj8oHMeVNTjXB04mcziNzO0lwMzets=;
        b=QBijER3Cm7ibTS9+S2oJoTidwr6eknhuiOO6L4EfXAnSns4HlIAadVgv3fB3296IX0
         fGKddsm16SgC3aZCsTsbNIO0moc8aAiKPXfhl9n6bo8syPG/Kdl7dt1XdNA+vGfBtt+H
         0NqRqj1HgTDZXRL/joOxx9rs3SRHY5sdvciOGfCmr4dBVSiXutRVptbsegNpzUyby3zP
         YC9VV8ZvZ7rqBjia990pIqS+YHa3HFGr3kZQOLtjdCMMyLTEWpJKZLHSVTtMl1s0kwsF
         KBgwYFVBZcFLTD4OUsiwc/i2AOSgnSZfmn/0PlINdvVCqHiV7uZHYgFn2ZnvN8O6R6hB
         +GPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788485053; x=1789089853; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=V2/30HstUwHfXkbdeQnzzUjJbfvh5oDXpf4S1HaYLSE=;
        b=qn7zEtifzw5BeO3YhkdRPWvxLkXV61qBW/SbIZAc8iwR4l7B/32X35pvLptHd1w6UP
         6waWf5K+T0eayCM7mO1oxxKq+YuZWfSUGZuhtD2GuQ0fZOeIR5VZKFLUGqq7Q6ibuHVQ
         ne6SEdUveKL7MpOorx6yO1KVkcCMEVeWDIeLY3yJNvGBCfeI7tWGAay9gqAunOZ+fVsM
         b1UbLgcTS2BLL9d+dSjFnUI4z/H6YzOWS1VKkvlN9T/W6iIK182bZRxYpGs4V6wB6IGa
         3canyYPbWWKW705DJQPKcae/NwVy+vE3i29jy53t4pNuB5ItVlRFpILl9hN3eSNVz4Gv
         mF7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788485053; x=1789089853;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V2/30HstUwHfXkbdeQnzzUjJbfvh5oDXpf4S1HaYLSE=;
        b=jtRbmXxKCle4vduWHS1W0ScLAJz+xOMtDezUA9Ub6IMPmgNsoFiUAmX1N/tmdHOC/x
         tqIP61NZVFD746tuYhvV+UwIV3dLGmnFsFUh0rcWM4kSto8jZbPV1pklie7b8jPg7Z+m
         8IpW0oomky/j3WeZ/a7vyw70aXlUD0Hz/m+/NsnCb85KjH49FTSo1PSonXmW0oDr1DgK
         wtXbJ3crGvVEprpRLIXnWw4fy1+xyX8KobJkcUJvpoWpBIz4X7I1KJf9m1wuEf5GTVPb
         VBdPZz4SoOoICIggLahWsTpwrZgMTA9HMndKRkrWmMxGIDSnsvpOgN+RVIeTCrivFsx4
         /okA==
X-Forwarded-Encrypted: i=1; AKwUvBzeVZZX2zi+qZ0ijm7LcB5BMkXrFCvbFb0PXxdc8EiOx/CIeyfiaHLAqOZUGhgtFtZM7JjrvUY=@vger.kernel.org
X-Gm-Message-State: AFuF++nZVUVoaYVRVB60pBMw+gwxKPtSPLM+zBnk8WgTapxxCZc4/YcY
	RMbEmBVcuLocGKeVcK6cLXQGvPBWxPp/Uc9Aug2fc4thUFgKDBwYfrNNFoXoYkwG+9DBCkq7pdk
	JG+8+ItN+U756pyPSwOl76Mny4Ku+pFw=
X-Gm-Gg: AYBFou3N30prThZUcnzIKJwiImyJkJCjcqVmCQGe2rFC0fRUNmoDYntRe7F/tcobh+a
	8R0y16x1X+vCvw172QkxD+NPHy7ZEf+7aVvgWd2FjmVSITAejK4TtaSQmZUDjoFE/tEtR+4DWw+
	PqbCO3IA7PfqGjuNhzlW9icgESjDl038jxCPPbl1vgDTp0JsAdWuaF0mXWhDPYsUGZkKNGl2CD5
	MLNcG6TM5CxfXZj1CROURjomtEAYml7rn+MRbwm3EnFEQztnwwGAglcIk+fc+moIoti4ssK15Xx
	4EJ461PqU67hqWkkc/rUExlWI1Diz+sVV9NNr5KaJw0qIczx2HFEGIqeBP6Nf2Asn1ocyg8fHXo
	Vv0bt6AG+ns4AbfkQd1IXV4dW0Fnsck51ylesskcqdnxm7pFmVgkMolucNy6UZ8ZmujEosg==
X-Received: by 2002:a05:6512:1253:b0:5b4:86ab:5236 with SMTP id
 2adb3069b0e04-5b616f23886mr515343e87.19.1788485052774; Thu, 03 Sep 2026
 18:24:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902121028.74092-1-kerneljasonxing@gmail.com>
In-Reply-To: <20260902121028.74092-1-kerneljasonxing@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 4 Sep 2026 09:23:34 +0800
X-Gm-Features: AcwNN1V6gnsIUY5hSqz0CJxZlN7Z6slcRuUnOWUgJ2HIMMQI5iR93j9VlRR21R0
Message-ID: <CAL+tcoDj+jqjMaND_+AnKyaxJ3rV_AbhQXBU6U8TR1NOBuUa3Q@mail.gmail.com>
Subject: Re: [PATCH net v3] xsk: set network header on skb at generic transmit
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, aleksander.lobakin@intel.com
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
	syzbot+f16c1b285c9f63994eec@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 8:10=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.co=
m> wrote:
>
> When constructing an skb in the XSK generic transmit path, neither
> xsk_build_skb() nor xsk_build_skb_zerocopy() calls
> skb_reset_network_header(). After __finalize_skb_around(), the
> network_header offset defaults to 0 (pointing to skb->head). The
> subsequent skb_reserve(skb, hr) moves skb->data forward by hr bytes,
> but leaves network_header still at 0. This makes skb_network_offset()
> return a negative value (-hr).
>
> When such an skb reaches a tunnel driver like ipgre_xmit(), the call
> chain pskb_inet_may_pull() -> pskb_network_may_pull_reason() computes:
>
>     pskb_may_pull_reason(skb, skb_network_offset(skb) + nhlen)
>
> The negative int from skb_network_offset() is implicitly promoted to
> unsigned int, wrapping around to a huge value. This triggers the
> DEBUG_NET_WARN_ON_ONCE(len > INT_MAX) in pskb_may_pull_reason().
>
> Call trace from syzkaller:
>   ipgre_xmit+0x958/0xcd0 net/ipv4/ip_gre.c:658
>   __netdev_start_xmit include/linux/netdevice.h:5400
>   netdev_start_xmit include/linux/netdevice.h:5409
>   __dev_direct_xmit+0x4b6/0x730 net/core/dev.c:4942
>   __xsk_generic_xmit net/xdp/xsk.c:1079
>   xsk_generic_xmit+0x277a/0x40a0 net/xdp/xsk.c:1120
>
> Reset the network header so skb_network_offset() is valid (0). Unlike
> AF_PACKET, AF_XDP does not need to locate the real L2/L3 boundary: an
> AF_XDP frame is always a complete, opaque blob from userspace.
> AF_PACKET only cares about the boundary because it can cook an L2 header
> itself (SOCK_DGRAM) and supports GSO/checksum offload; none of that
> applies here, where the frame is sent as-is via __dev_direct_xmit().
> So resetting the network header is enough to restore the invariant and
> avoid the crash.
>
> Fixes: 3914d88f7608 ("xsk: Respect device's headroom and tailroom on gene=
ric xmit path")
> Reported-by: syzbot+f16c1b285c9f63994eec@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Df16c1b285c9f63994eec
> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>

Ah, I noticed sashiko in V2 explicitly pointed out the good reason why
probing is needed. Let me rethink more on this.

Thanks,
Jason
