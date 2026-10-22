Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792685006;
	b=g8+WM1na0EuHOqzagJUvIAbl3efQIIRecNiuivxcRCrSUFanxCzlVeEvgJ+RsF5D1b0q
	 kVBBIvueHp9/fPMg40rFjQ8hLz65ijYQnW5cNi4MZAMr1jyuRC8ZqlC1XA4s6mXlevW21
	 XHWBd+binDea+mGEG1sT7BZ5BleWQRqmB/qv8Z2Hr+Rdfp8JTQw9Ni+2XIdUyFy9xoNYe
	 0f0xZ3rvT8qWmydmHzk6mNLzh1PdRku35yBtAGVoHyb9mOlVfI+xXddQDrCcsvugSkMb7
	 o7oAfHxgMkG38+hjmYw2Q6TNWomteLNOw9a/aMO/XDa0eJYXLpRgjC9exXycxo/qt0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792685006;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=SVFAWxvzAb3W3SMI+TC1aWbeNXvk1djSQ+jrgiQGj/Q=;
	b=QHP9cROJfSAz1KTCpE0qZcyBwx9hc5UFrTOBXl95ROszTWnhq9yg3WLhZtktz+ZI4Meu
	 qkPtWj4/WaatZy5kfItT1F56Q1L4qB1bzTVX5XFfzalpv069cQIi6AmijKAKyv7ExWwOx
	 H27FpPADEQ7j5IVavPtzmKsKQ8L8I2sMoTYy7hvCkEFnJaq4OxpGG0ShwcToItAvMEr2T
	 rvfsesBOdXC1YsD93Z81hrX7V4sk9QekVScYybOzUNfl0NVZpOP+15bpLYDJaR/HrpnPf
	 gQEY/VdcXtus4/UD9ynxYpmUJ88oxhnPgC2QMM3NG7AaljoRqC+xtchyBsqvJtuaNvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=P305wpJP;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=LwliRngU;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F506606A319
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 16:03:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F506606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=P305wpJP;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=LwliRngU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792685004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SVFAWxvzAb3W3SMI+TC1aWbeNXvk1djSQ+jrgiQGj/Q=;
	b=P305wpJP5MSmh4PvxjfoaCWrfcV4rpwu/TTBCCwniutsOcI5BcbC37uvqgTiAll+1gWIvp
	NSMKHLKj1rhRv4oDicyhRxwq+oxfyc0D/bUx6i7qYoRZeASrWlRSPiai4lmUrpvjXSARg/
	/zrRpgKv7z2/TwyrHnH298XAyN/g0BE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-wk6Lzsd1OX-2XctzRnN6Ig-1; Thu, 22 Oct 2026 12:03:23 -0400
X-MC-Unique: wk6Lzsd1OX-2XctzRnN6Ig-1
X-Mimecast-MFC-AGG-ID: wk6Lzsd1OX-2XctzRnN6Ig_1792685002
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48c7fe9736eso1741983f8f.0
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 09:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792685002; x=1793289802; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SVFAWxvzAb3W3SMI+TC1aWbeNXvk1djSQ+jrgiQGj/Q=;
        b=LwliRngUjYZmFwcEXeJ7W/xgabJNRUL2OmEKs9SrgYKFIWUzcHahcTTmokMNrgYgT8
         n/O28UfPkqDhJ0tMiRGFmjgHm6vr+8ctalpE8K29PaM4hCk5J1d50TYQJ1oK4c+KsdyM
         BW/DckiHCJHzRWn6/fhzVEAwrgy9p4Uf94OVSG9OixUAOTa/9nR/zgm8Nlq4ItekW1K0
         LszelvuNOhDqorBKk9nA5QGdNUB4ZwMZcNHB5j7Fr4c0nUBpdTFINe+BGVlocJ2aIpZ9
         tYApLZ6k2QqVYitkmsNgQtYTKvMHDQdLfKcLjfdG8XCJ3stuQoN+yNNKjD/trRAwisnG
         tVHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792685002; x=1793289802;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SVFAWxvzAb3W3SMI+TC1aWbeNXvk1djSQ+jrgiQGj/Q=;
        b=ZeWjAaBhFQ/opD6lEWijqJJgxKCphIowLs0LULlpQYvnq2DZbRP4gccznk+krSvApV
         +EKf7yHacveGRsB5mMVuF3kydT2PjtQD5sbtG086SWBDb3GyzKw/xB6OA+JhTq7xTQWU
         4gEZHWRG3x5GKFlX4nqD7WQcxUMlw9GcvZduuLW5Ddub6TGcEQnCEz7OmKFxUrMBFGAR
         4PI0UCw3K4QTyThrgXPa+mgHjZ+3SLGeIT8sdpnuudn6HF4FyOjUVnhyF58L6rtzDuLk
         VNFnDeup66+1bVtqCCLR+pzWY5ijHC2g1U/rsLysnE0qIPqoLyxe9OOtbUrHOJ0BPITI
         e0Mw==
X-Forwarded-Encrypted: i=1; AKwUvBxw01mqVfHfJj2poz+BLjWNMgkKG8lEdAPz6ElzDRxzGUXVBKqdXRgpL6XUzyr5zVt2FvxNgPg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKfIJMBn3a5i1LofBNJC7p+EItrllAp5J69th3JIP7xlFc9iIQN
	ZGc1nqwDHrK/rPzoQYknaGZPoOksLAxhGSrQ2ni+HVWZzy8D8FOGNyuToVUl2wzEqyQwdA8e5ap
	Jutuu8JOShFpNke82Byq8xPROdtVQLt6/B8ApJMkV3DOHnle4DuHaEX72Ag==
X-Gm-Gg: AYBFou1iAsoN/b+6u5ZvCbTZBK6aJe0okBu8tGXhVKUqn09mG9fXWOqIVZml9mjiVpc
	o5+hZO5RYxO594iZKj801fd99iKK3dy3DXThVpaZkaI55K5fHUGfmR0ytI1zoIYI2VkVJwc3jyh
	zNrKiCS/lOvccRzk8UzDMnAd0h5Lal//1nrPXw9UChaZs8tfsYDZji4NgJK5VMshxe/i/LXAndx
	DR4twKnYh/3C7Jrnhd3gibiEbPPAntVizY8Btv79HqA009ToaTuOFIPggwyC1GyRG7oUuSxXLQ/
	MZhId+XTY5LV+QwIpzZCQcoo1tA18AIiMf+mLtKIZC5sF8HSgPCw3ysLOfwW9D1OSIA=
X-Received: by 2002:a05:6000:4906:b0:48d:fbf4:8961 with SMTP id ffacd0b85a97d-48e264ae1aamr11320116f8f.23.1792685001468;
        Thu, 22 Oct 2026 09:03:21 -0700 (PDT)
X-Received: by 2002:a05:6000:4906:b0:48d:fbf4:8961 with SMTP id ffacd0b85a97d-48e264ae1aamr11320034f8f.23.1792685000839;
        Thu, 22 Oct 2026 09:03:20 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e25828e54sm13888889f8f.27.2026.10.22.09.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 09:03:19 -0700 (PDT)
Date: Thu, 22 Oct 2026 12:03:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	shaos <shawnq1@163.com>, Jamal Hadi Salim <jhs@mojatatu.com>
Subject: Re: [PATCH net] net: harden qdisc_pkt_len_segs_init() against
 malicious GSO packets
Message-ID: <20261022120246-mutt-send-email-mst@kernel.org>
References: <20261022155436.117507-1-edumazet@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261022155436.117507-1-edumazet@kernel.org>

On Thu, Oct 22, 2026 at 05:54:36PM +0200, Eric Dumazet wrote:
> An SKB_GSO_DODGY packet can carry untrusted gso_size and headers.
> 
> For instance, gso_size=1 and hdr_len=65532 for a 524275-byte frame
> makes qdisc_pkt_len_segs_init() compute an accounted length of
> about 4,294,574,091 bytes (after gso_segs silently wrapped in a u16).
> 
> With DRR quantum 256, the dequeue path then needs ~16.8 million
> deficit refills before it can dequeue the skb, keeping the CPU in
> the qdisc path long enough to trigger the soft-lockup watchdog.
> 
> Commit 8f735d64382d ("net/sched: bound qdisc_pkt_len to prevent
> qdisc soft lockup") added QDISC_PKT_LEN_MAX to bound size table
> amplification. Use the same bound for DODGY packets:
> 
> - Make gso_segs a u32 and drop packets whose segment count does
>   not fit GSO_MAX_SEGS, instead of silently truncating it.
> 
> - Drop packets whose estimated qdisc_pkt_len() would exceed
>   QDISC_PKT_LEN_MAX.
> 
> Fixes: 15e5a0307164 ("net_sched: better precise estimation on packet length for untrusted packets")
> Reported-by: shaos <shawnq1@163.com>
> Closes: https://lore.kernel.org/netdev/20261022144755.65025-1-shawnq1@163.com/
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>
> Cc: Jamal Hadi Salim <jhs@mojatatu.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>

I'm all for stack being more resilient.

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  net/core/dev.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index e76762e29360ea87ade0846e4a4f9016dca587d6..573bcc9d67b1b1e21e844f054f0b51a172713a90 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -4175,7 +4175,7 @@ static enum skb_drop_reason qdisc_pkt_len_segs_init(struct sk_buff *skb)
>  {
>  	struct skb_shared_info *shinfo = skb_shinfo(skb);
>  	unsigned int hdr_len, tlen;
> -	u16 gso_segs;
> +	u32 gso_segs;
>  
>  	qdisc_skb_cb(skb)->pkt_len = skb->len;
>  	if (!shinfo->gso_size) {
> @@ -4226,6 +4226,15 @@ static enum skb_drop_reason qdisc_pkt_len_segs_init(struct sk_buff *skb)
>  		if (payload <= 0)
>  			return SKB_DROP_REASON_SKB_BAD_GSO;
>  		gso_segs = DIV_ROUND_UP(payload, shinfo->gso_size);
> +		/* shinfo->gso_segs is a 16bit field.
> +		 * Also make sure untrusted gso_size/hdr_len can not inflate
> +		 * qdisc_pkt_len() beyond QDISC_PKT_LEN_MAX, or deficit
> +		 * schedulers could spin in their refill loops.
> +		 */
> +		if (unlikely(gso_segs > GSO_MAX_SEGS ||
> +			     skb->len + (u64)(gso_segs - 1) * hdr_len >
> +			     QDISC_PKT_LEN_MAX))
> +			return SKB_DROP_REASON_SKB_BAD_GSO;
>  		shinfo->gso_segs = gso_segs;
>  		qdisc_skb_cb(skb)->pkt_segs = gso_segs;
>  	}
> -- 
> 2.53.0

