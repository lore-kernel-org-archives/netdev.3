Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CAF4F0539
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 13:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791898208; cv=none; b=sZgjFawjMm1cOKb2sBOM8gTQASVN4QcodZju6u77bVK9GSevU4CZqfTjnReVvIZFqFyRDmAQMjxu4NQ+GRBMr9FLIpm3H3MwvDjqjMDpYtvzMPRwAJks3OeaDJLZSflCr/XH8VUGpPc7aNq1fMaGqF1it6zHBMlBrq6jmClHgSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791898208; c=relaxed/simple;
	bh=MYb+KZhXthdS1tI1u5L6tYn5kd9NKgccGuIs3/6bcFo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=AKgB44/Kb6gHRDzXNORh5huYIPq2fVcOdNQ0VkD0PKGxyh6VRuqp+RgGxpnddjPHUrd6wzfnKvEvd2xOL7jeEj56H3dPOG+v9ffYtqTyRFxQ8y0kCCRucZfWf5dyFDje9q3CvadThcH4NHQihH1jJ+mHjuCSDpxdSTCpVJazYlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bOuNoX9W; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bOuNoX9W"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-533778ab0bdso34267641cf.3
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 06:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791898206; x=1792503006; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HdYWexqI8VnjnVIAaPxGnMoLpd+H3V236ImJISdPKrc=;
        b=bOuNoX9WU76ro+ZOSrp0N2Fba0IRKIAIg80EFZvmjoIo0RW919eSojewJuu94sNM2E
         AA0/2arLdp96VSdm0c7s//SUwMKP+b966JoASumBME3WSENL9LE0rFhaoMdUy6n2LNvI
         x3w4YnKAPUZNNVbbT1x62nB8+Z4MWc2oyaLeK+hufkJT2NhoptaWpBW70D5gCSy6kMoh
         UeFKAUMhWbGh/9Jn6zCuVI7acQ++15yvhq3wVHim7sOmv+silQnRJ25EHBzHGH+r6a2s
         d1LRnFFNAWZlLBJ6xzYJzMiHNNj3w6jkJvIn/3NosvDD+nk++Sc8DQMDzi4W/RSMcEEQ
         8n7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791898206; x=1792503006;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HdYWexqI8VnjnVIAaPxGnMoLpd+H3V236ImJISdPKrc=;
        b=UF+3bMErIbvYr7tX/FpMX1trYgWOz1/bHsHVr4jKe7P+RnsrZ5DsklFcPjWq/Ahnf7
         yTw1T+7Rgcsf9FLHGnqiIRIorp2bJ0oWbBLeLUsbbHUgyYqWHWYgw5GKrgbq28/G/cVM
         UW2csI/TUizzrkKQnMi3B4MIGeX5BclGuq9XymdOuanWsHbaEFFJVGNsEmxXospGmoI5
         AhVSv3vzIxp0KYN0OCv5iPW44sgGUdtVNB05Oa/JpWnNKk4XVaQ9O4p0Io/fOCzkKoW5
         lAf/U/a25+R7D2tdUdaLEOMavdl1NBnRqu+tt1UzDDrap5scU3p1843iTvmEQDIigD9N
         U5Ew==
X-Forwarded-Encrypted: i=1; AKwUvBxa4A008LuIpxeQQQgAMFjnNz4H52C72OQ555QRFhB65x/UbT9G0/2+7qjuyCqODaw6D9/rGEM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ9ZXUUDQizb9mfcpdAyB4++dAR+II8hS0Eit56TqZPRZ+3A8IQ
	x2FaNhFfwojFvF2lzKn83/6n779QIzrqh0qv+WT5dZUDnACdqqNbPK6f
X-Gm-Gg: AYBFou1dFbq7bQSn8Fz6CN90DGdXn3rwfsw3s89uUOCQwemkohcuZCq9cQcCKnpKBWJ
	J/obqpQn5lJaCFFj5t1qaW4YBuoMLL++Ej/CZWkHWwbFaetLukQnXi7WDnJOkuzqA5VzrxO9Yea
	3Txi9SgNTgJWNdqTQ5YF0VWYzN6EPtiZLE4NpOS59vJHDKiMrZOpDARFPY0DlDUrPDm/jwqwnKG
	adYxWjRvJZb8mTogIytRNQOXZyrRrAJJYnbmGKWgIx7n8tG+9m+GBsfo9U0WgZtsHugZMX6YF53
	mGdYJkMu8yYMwbSF362zwvMFF4vZkibFyzytUWddekyI8tvFOVoHAZmC1C8SSfzm0CDlXayZ6Sa
	rOd1Hvn+suwkaTb2V0y7P1b7JzUfSHmOp1s9Eec3RhFP98CXBGy88OjxfEt8tWk+EZSn6cOv1FY
	5G7lcSWhGgXaCcaiko1K9zdftZ3HrXewAyj695YmaylEw3y51vrEFc81LH06ObYPQ2m8uyGJW/Q
	68=
X-Received: by 2002:a05:622a:1e1b:b0:533:386a:edca with SMTP id d75a77b69052e-5359fae2dd8mr197794911cf.16.1791898205969;
        Tue, 13 Oct 2026 06:30:05 -0700 (PDT)
Received: from localhost ([2600:4040:9399:4000:e553:72e5:7d37:c7ef])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-535e652f3c7sm24443901cf.26.2026.10.13.06.30.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 06:30:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Oct 2026 09:30:02 -0400
Message-Id: <DM3QWDZ4B408.2O12B5PXKY8AR@gmail.com>
Cc: <alexanderduyck@fb.com>, <kuba@kernel.org>, <kernel-team@meta.com>,
 <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <pabeni@redhat.com>,
 <ast@kernel.org>, <daniel@iogearbox.net>, <hawk@kernel.org>,
 <john.fastabend@gmail.com>, <sdf@fomichev.me>, <edumazet@kernel.org>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next v2 2/4] eth: mpnic: report per-queue stats
From: "Daniel Zahka" <daniel.zahka@gmail.com>
To: <netdev-bot+sashiko@kernel.org>, <daniel.zahka@gmail.com>
X-Mailer: aerc 0.21.0-threadmapfix
References: <20261012-mpnic-counters3-v2-2-8afba81c2d5a@gmail.com>
 <179189313526.434549.10762925482009523771@kernel.org>
In-Reply-To: <179189313526.434549.10762925482009523771@kernel.org>

On Tue Oct 13, 2026 at 8:05 AM EDT, netdev-bot+sashiko wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] This patch reports the RCQ `rcq.packets` and `rcq.bytes`
>   counters as the netdev qstats `rx-packets` and `rx-bytes` attributes.
>
> --
>
> eth: mpnic: report per-queue stats
>
> This commit exposes the per-ring packet and byte counters through the
> netdev queue stats API. Counters for deactivated rings are reported
> through the base stats.
>
>> diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_netdev.c b/drivers/ne=
t/ethernet/meta/mpnic/mpnic_netdev.c
>> index 5164475a0f943..c2f4a326a8f0f 100644
>> --- a/drivers/net/ethernet/meta/mpnic/mpnic_netdev.c
>> +++ b/drivers/net/ethernet/meta/mpnic/mpnic_netdev.c
>
> [ ... ]
>
>> @@ -146,6 +147,77 @@ static const struct net_device_ops mpnic_netdev_ops=
 =3D {
>>  	.ndo_get_stats64	=3D mpnic_get_stats64,
>>  };
>> =20
>> +static void mpnic_get_queue_stats_rx(struct net_device *dev, int idx,
>> +				     struct netdev_queue_stats_rx *rx)
>> +{
>> +	struct mpnic_net *mpn =3D netdev_priv(dev);
>> +	struct mpnic_ring *rxr =3D mpn->rx[idx];
>> +	struct mpnic_queue_stats *stats;
>> +	unsigned int start;
>> +	u64 bytes, packets;
>> +
>> +	if (!rxr)
>> +		return;
>> +
>> +	stats =3D &rxr->stats;
>> +	do {
>> +		start =3D u64_stats_fetch_begin(&stats->syncp);
>> +		bytes =3D u64_stats_read(&stats->rcq.bytes);
>> +		packets =3D u64_stats_read(&stats->rcq.packets);
>> +	} while (u64_stats_fetch_retry(&stats->syncp, start));
>> +
>> +	rx->bytes =3D bytes;
>> +	rx->packets =3D packets;
>> +}
>
> [Severity: Medium]
> Do rcq.packets and rcq.bytes match the qstats meaning of rx-packets and
> rx-bytes?
>
> The netdev.yaml spec defines rx-packets as "Number of wire packets
> successfully received and passed to the stack". It defines rx-bytes as
> "Successfully received bytes, see rx-packets".
>
> In mpnic_clean_rcq() in mpnic_txrx.c, packets++ runs for every META
> completion, including completions where the driver drops the packet:
>
> drivers/net/ethernet/meta/mpnic/mpnic_txrx.c:mpnic_clean_rcq() {
>     ...
> 			if (likely(!(rcd &
> 				     MPNIC_RCD_META_UNCORRECTABLE_ERR_MASK) &&
> 				   !state->pkt.add_frag_failed)) {
> 				bytes +=3D xdp_get_buff_len(&state->pkt.buff);
> 				skb =3D xdp_build_skb_from_buff(&state->pkt.buff);
> 			}
>
> 			if (likely(skb)) {
> 				napi_gro_receive(&nv->napi, skb);
> 			} else {
> 				mpnic_put_pkt_buff(&state->pkt, true);
> 				if (rcd & MPNIC_RCD_META_UNCORRECTABLE_ERR_MASK)
> 					errors++;
> 				else
> 					dropped++;
> 			}
>
> 			state->pkt.buff.data_hard_start =3D NULL;
> 			packets++;
>     ...
> 	u64_stats_add(&rcq->stats.rcq.packets, packets - errors);
> 	u64_stats_add(&rcq->stats.rcq.bytes, bytes);
> 	u64_stats_add(&rcq->stats.rcq.dropped, dropped);
>     ...
> }
>
> Only errors are subtracted from packets. If add_frag_failed is set, or if
> xdp_build_skb_from_buff() returns NULL, the packet is counted in dropped
> and also in rx-packets.
>
> The buffer length is also added to bytes before xdp_build_skb_from_buff()
> runs. A failed skb build therefore still counts toward rx-bytes. An
> add_frag_failed drop adds to packets but not to bytes, so the two
> counters also disagree with each other.
>
> mpnic_get_base_stats() reports the same values once
> mpnic_aggregate_ring_rcq_counters() folds them into base->rx. The
> miscount carries over after a ring is deactivated.
>
> fbnic_clean_rcq() handles this by jumping to next_dont_count for dropped
> packets, so they are counted in neither packets nor bytes. Could mpnic
> do the same?
>

v1 of this series matched fbnic in this regard, but the bot pointed out
correctly that rtnl stats docs say that packets received ok at the host,
but dropped in the driver (mainly skb allocation failure here), should
be counted in rx-packets.

> The counter semantics come from "eth: mpnic: count packets, bytes, and
> drops per ring" earlier in this series. This patch is the one that
> exposes them as qstats rx-packets and rx-bytes.
>
> The later patch "eth: mpnic: count Rx allocation failures" also counts
> skb build failures in alloc_failed. Those packets still stay in packets
> and bytes.
>
> [ ... ]

So, the question is whether or not rx-packets, reported both to rtnl
stats and qstats, should count drops in the driver. Here, drops are
either running out of shinfo frags, but really just skb allocation
failure.=20

The docs for rtnl stats strongly suggest an skb allocation failure
should still be counted for rx-packets.

The docs for qstats imply the opposite. Especially when xdp is not
present, which is the case as of this point. Once xdp is introduced,
though, counting an skb allocation failure in rx-packets becomes
reasonable by the qstats docs, because xdp runs before the point of skb
allocation.

Another option would be reporting rx-packets differently for the two
APIs. I think this is not desirable, and seems to violate what is in
the stats.py selftest.

So, I could either submit a v3, which would just be reverting to v1, or
take the approach here as is.

I'm going to hold off on sending a v3, unless there is some human
feedback.
