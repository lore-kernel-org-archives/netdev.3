Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081E04F7CB2
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 21:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791840425; cv=none; b=GwoCqpozpWPbnFEZvFO1goLl33vKAcUgLFcVhiLsXcfx7bQbZAMWu3zF4y6rgz+ScgQajaAI7rsf4R+CgEIWyLwlrz7IJgqynHBe/2I38udFMQjDNSg2x4T5kyjlNHfn7QyNqjIa1nV1PSVC3F4N58meCrx/QsbVMFTvkjVE1tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791840425; c=relaxed/simple;
	bh=vFCTPi6RkqhF5HPuqeIigpw8olvShpvLUVqeUIoJdYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pSvUJPE4N/L/+duKKo0sqJLF7Vz0sJ464Ls9foEh3D21AtKsHM85U29IOM+l0Am/dKDpgWIDkvzIBBWuZRbb4BloyhQ4hgewFe12y0RYunzKmght6BFhlVqtrqvtpdU5YSldcDen/fmQ+bq+eZLegb1y7q8EKw0krPIq3bCrhlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=UuPUM0He; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="UuPUM0He"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-881269371acso2062311b3a.0
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 14:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1791840423; x=1792445223; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=00lr0ueSHjjLFpqBUflLoQS+JH73YrWnwKwvoX92I9o=;
        b=UuPUM0HeTJ/ADEIghcha+FZah2r1LoSTx/oKR1mcAhddvveQVx+4banNqP2RU3CsTY
         LJ++V2f0XycCs4OQM6j3dOCi6hmgN3I4a8ATKZmItwuAeFCIyAYiX63tMUmNaQWXeqxA
         FRo9JNB3KvPQjw97HmOqQMAZsH5OM2xHx1E5PcmH8ODMIXZOgEV9UHxwryORjEAM539C
         k1h4aIjiBHEEI6b3aCwPPZBxbriyEzUxl4P+CQQYn7av7Rx1194ZgGy+P1sOpMKVKiVa
         o5B4e38Yv9ieFFKRRqYzydXFevulTXLoTGVb6YqtbgNIWFIv7Wy51EHhDGn3CIb8oRyR
         +13w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791840423; x=1792445223;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=00lr0ueSHjjLFpqBUflLoQS+JH73YrWnwKwvoX92I9o=;
        b=yHZHAh8isOWC7qfz6JSYxoFtk+xKoug6g0wpTw/DstBBgZ4ntwPp8c6MH8dDiR6Z74
         C5K8WbgkANkiDQD1IjWf13owJnO0wCDaaaG5V+UygHTsMV1SUwWTH27OaYmw7Agelf21
         Uk6PsLWrzOihKv01zIG/OwfookI9VAVSXfOUf/TEGlRUh5JYGyF0OG+lk9rNa8sClNMM
         O8eMoJCtRLHWAtJ9yG5cVGyAOyqGr8zrGj5x2QkK4kcKeQy4/rf+PtoD585kaM/gRc2K
         TGn8j14HtUxE1ZrUokVQMaDWRLhvKZIZqHm5ongKheFlX85NY9Dk6Isi6Mz0c6s/abik
         ZyUg==
X-Gm-Message-State: AFq9FYJzi3+i0LjrmFj3o6IhRk1dkLuCghvPltzXedM7d0udNaBj1lBU
	1YStxIQgAgVzm+YxwQpPMiIDqupbgzzzO8C+C8H97P33SWlCeJ9Nw6TbjT5WRpC+WlWHeImUvMZ
	LeQRd
X-Gm-Gg: AYBFou0SfrhROrW9Dws537CZFCwAEhx8fsK93Y2zbB6DBdGsudBVOBmDnWuGvnnmVpz
	SqL+aJPKe/qHzkkJ3r+8w/mFQhuoGwQa7YwZJsLEXAAn9X7+QGTAXi3U3iZRTF/Z4VFhyikJOh2
	dYz5LkYNOvJu1g1M1sbHr7w3V1xpwAPzrvEqdYrbMkf8dPPuAWFNKNGicsJLeRgTgF6BE79a/rY
	tulsGGDX6YCOjf2ygTUDVRc/hamHj55JjeMu2KEW/uXfgL2uW5Q2gyOq2FVlSwN3mRF66pWpIn7
	TrGBl0Uo1nj6to2v9HjlwYiR+U+sXDJei7PJxCRThc8/dmf7ytpJKCkE8Sm5vthnrcTg8G+J0OI
	uD1rkkXzjzJy+RRTv2DB4MPV4V4c6UDvJmB79J39pr6xKsTQFo2y15seRTEWtRTitdHyLaFp5MV
	L5UNhr7Ckfd6DhMtkw9G7GnSIAYXkc6WaY+fjqP62VIqpijl1xnHVYxXJuLh2G0CPyPDF73L1UT
	XexD0lhrjI61VDwKuOMZCU=
X-Received: by 2002:a05:6300:6698:b0:3e1:4fbc:5ce9 with SMTP id adf61e73a8af0-3e164f32a4emr6971521637.20.1791840423279;
        Mon, 12 Oct 2026 14:27:03 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:58::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd3d9e53f8bsm4705338a12.24.2026.10.12.14.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 14:27:02 -0700 (PDT)
Date: Mon, 12 Oct 2026 14:27:01 -0700
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: edumazet@google.com, horms@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] bnxt_en: Pad short SW USO segments to
 BNXT_MIN_PKT_SIZE
Message-ID: <as1QpaiN8tTtZ1vx@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>, netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	edumazet@google.com, horms@kernel.org, linux-kernel@vger.kernel.org
References: <20261009215426.2377946-1-joe@dama.to>
 <20261009215426.2377946-3-joe@dama.to>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009215426.2377946-3-joe@dama.to>

On Fri, Oct 09, 2026 at 02:54:24PM -0700, Joe Damato wrote:
> Each SW USO segment is hdr_len + seg_payload bytes. With IPv4, hdr_len
> is 42 bytes, so a segment carrying less than 10 bytes of UDP payload is
> sent shorter than BNXT_MIN_PKT_SIZE. This happens with a short last
> segment (e.g. gso_size 1400 and 1405 bytes of payload) or with a
> gso_size below 10 bytes.

[...]

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
> index ef04c9d08066..80d5c4f963a9 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
> @@ -82,11 +82,19 @@ int bnxt_sw_udp_gso_xmit(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
>  	if (unlikely(num_segs <= 1))
>  		goto drop;
>  
> +	/* bnxt_features_check() makes the stack segment these, but paths
> +	 * that skip validate_xmit_skb() (e.g. generic XDP_TX of a GRO'd
> +	 * skb) can still get here. Padding every segment would need more
> +	 * BDs than bds_needed reserves below, so drop instead.
> +	 */
> +	if (unlikely(bnxt_sw_gso_pad_len(hdr_len, mss)))
> +		goto drop;
> +

I could be wrong, but I think if [1] is applied this drop can go away (?)

[1]: https://lore.kernel.org/netdev/20260928223648.2739371-6-kuba@kernel.org/
