Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793102808;
	b=vp6jcVp+fbVnVv2dHw9ib8p5gwMfKjottHYajkQpM7lwzVsFxhkVHKGe7VvOhKZREO4c
	 nQRAFln808GAD45ohOe4ZYaYY9em07ec+0uUdZegzM9DOw1YBkmoWo0kOld54VWVeCY6X
	 4VPwioXfVULJTTQmigT0pmBGy5oLQVujVUPbKCp6P409kfac+XETKWTcxwAEA8/5KGKNf
	 K1DyTDBXA7cmQqYkdqEluxfrHFQaSkujKaEWQd3LiEHfGYFUmwbsA0ew7fStsQYQQirS4
	 v7oeUV7nFu5s00qv+immSuLz3c8EKxlu7tKGgoag2cj0yQ4lmKjII+jW+zLBsExDfvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793102808;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=g8KMQj2HsPBF8Jjs/G4X6DPysUQ80f4vvkU0TZL7PsU=;
	b=5C5UF7w27aRm2GK6vGhuCzzeqvsCxn/SEJkKNSokRX6EvZjvKg2htC3zzYxbiYTnWVj8
	 UV3QdPmpN4z22Sta1qHQr6xS1wCUtkGfycZIcozRBs9KxrKSnTvp7gQDTsT2diQgU7EqX
	 9W3WjWRKlurZNeoSSE5yudludVmpKve2TFrU+efXd2lTA7fnPh0/K2d1Q2pey0s5eqntU
	 0yH9IUNmQDr4qQMK0CM/DLDAb16eD9KRKpDDG/eZ5TdOCjsKZjNRsRkFbAcdMbY3R9pkO
	 3REiOHhbLzNTmAUX9WxDPYr3Lps1cW3F6aMRfOJDvQgAevfjz5KofeaE0h76KREr1ZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=C8wf6H+A;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=RXPeLHkn;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD4D606A31D
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 12:06:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2CD4D606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=C8wf6H+A;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=RXPeLHkn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793102806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g8KMQj2HsPBF8Jjs/G4X6DPysUQ80f4vvkU0TZL7PsU=;
	b=C8wf6H+AYeIBEpNoYU9zy+75ULNP/v8GQ+JI8YeV0z07n1Y+A6DfJJMoiLDsRAkdopP1nm
	mDDqcgNZtSs6bwlt30sfqIwMVo1hpfZjo5uyPypqxGriI9Ja/hmZFjb/UVoEAAKB0hRrO2
	t5vzy8hgE7y5Sd8a2kTPo8g1uS2cPCU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-6nqhNnw4Orix7NSFbMfqaw-1; Tue, 27 Oct 2026 08:06:45 -0400
X-MC-Unique: 6nqhNnw4Orix7NSFbMfqaw-1
X-Mimecast-MFC-AGG-ID: 6nqhNnw4Orix7NSFbMfqaw_1793102804
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a4654add56so26736015e9.2
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 05:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793102804; x=1793707604; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g8KMQj2HsPBF8Jjs/G4X6DPysUQ80f4vvkU0TZL7PsU=;
        b=RXPeLHknvGdIZGmmQOg9CAJu4ZQtCgOy3X3PowC0Os1DVS3R3aAap0u/wm9XlHjjU0
         HM7EnBYUihFyrhh1OeTuQm1swnYuwj1Fq5vCpeTtiKUZayZvLx2FW2nE2iCCCEN8uLZS
         rm/XjIP89WmKbQEYcS1deWV+VA4VJRJYm+1PAToAyM5Brkq2jjR8JxmcLQ4Z7AVNuVBl
         IHAFFIrp8q1UELTYZ1iRU7F0s+8NonqxUEMQqQIT9XKQIOqDtIAL9X6LF91LY+mc2I4L
         bl2+O7sPWb1g0mhON7TtdHK9xkW+VDA6Y7xxWXbXmAA0J1q8u4nHXpudB6pPMGTKXTzt
         FJ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793102804; x=1793707604;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g8KMQj2HsPBF8Jjs/G4X6DPysUQ80f4vvkU0TZL7PsU=;
        b=mvlyWgVpM6zScLbdFOwDYubcryFkTdECKOrPyRnbsi/qjwTRl4u6rb6X8jjLeWgi59
         Dr79eMy4iaBzaQm3NvqL+NA1X2VaPhfoc0ikXcn8BEA+V/5OaVji6/fWqK/ZIyBvUU5Z
         85HlK98ldhV08PgPTroL1uTw72Rv8T6C7DLUx7Vzmtp2rBzjOr9a1ER3GgGp8NOVoZGd
         xfw3u+lBQYu5pKcXRne3qEnB1zeUMC1+PQPtJNm/edjwm9ixZEW/I1lvdN3go9ZctSr+
         eSnwsQhEQ3jd4epfQRWpA5tyJ/ReknFulL39IepHmrjtClGRNMVWV3qeIsYxdqqaQQ6k
         QzuA==
X-Forwarded-Encrypted: i=1; AKwUvBwkGa/v3MhlqdTwsZq+ZZ735a5GtzZlPUhfu9psY5YNDbquuETeAJbyt8gDkibFH58kmHCOcq0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIFunfJrdCtS5l5OM5/q3r1FFxH0EcOtAMii2VDJOWnnIlPyreC
	9Q9htl8+htxwFi9CPR5/PrsKAH4AasbN16/tf6kSd5aB/d6PgJ9qVs1kBI/tMAD5ofwNZXa2Gin
	W+6WwSI0rjYwZqiX21CHaExBkLupSch+KWc0zBhh8VRsii9Jj7smrs5wR+w==
X-Gm-Gg: AYBFou22MxovRJ5sNIVEG6yot3Kwf4IMDRBqviz32+2H6Rh+zBCo03yrCiIxy7hv2zv
	GzHtGmiVc8QG/EDzQxyfyBuxLuGa1PjKaBnyyWBBUEgU5+1EE95h4RjnWzGkSo1ztvUXWU7LeZ1
	xFHb8d4qweURJVJAr7zKW/sJM6f/7GQkTenhKjtsDLXLTFWP5D6fsBM4ydS0KpDpwLjZp78goOJ
	T7IJP5LG41EcStRIS7KvBHXFh4ityc8cJoQmJSQD82+Jlzj350qEgIVVoSIJDN7k1d6gejZHSA9
	JtkgamO1M64Ss/0J7tdlhIfNp/zoxyVaqC+Nz9T52UFW1oElOWS5Y/SbaKXLceiVM2vRtYKOe1F
	K3QuHvi7kUQfunvbq+CcJS/MtnWIYHdnOyivFnH9gzsvghCwsBDHlayF2vdJxgOmuEKrO3d70FA
	==
X-Received: by 2002:a05:600c:608e:b0:4a6:42cc:bf66 with SMTP id 5b1f17b1804b1-4a642ccc70emr103979825e9.11.1793102803681;
        Tue, 27 Oct 2026 05:06:43 -0700 (PDT)
X-Received: by 2002:a05:600c:608e:b0:4a6:42cc:bf66 with SMTP id 5b1f17b1804b1-4a642ccc70emr103979245e9.11.1793102803120;
        Tue, 27 Oct 2026 05:06:43 -0700 (PDT)
Received: from [192.168.188.234] (ip174-129-192-82.pool-bba.aruba.it. [82.192.129.174])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a2d9280sm259748385e9.13.2026.10.27.05.06.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 05:06:42 -0700 (PDT)
Message-ID: <096bd22b-c569-4998-a943-0381c3fa9998@redhat.com>
Date: Tue, 27 Oct 2026 13:06:41 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] virtio_net: reject stats replies for queues outside
 the request
To: Lianjie Wang <karin0.zst@gmail.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261022182710.2055771-1-karin0.zst@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261022182710.2055771-1-karin0.zst@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/22/26 20:26, Lianjie Wang wrote:
> __virtnet_get_hw_stats() passes the vq_index of each record in the
> device's statistics reply to virtnet_fill_stats() without checking it,
> so the device decides where the driver writes the counters.
> 
> For ethtool -S, virtnet_fill_stats() uses vq_index as an offset into the
> output array, which the ethtool core sized for curr_queue_pairs. A
> record with the vq_index of a higher queue makes the driver write past
> the end of the array.
> 
> For the per-queue netlink stats, the queue type also comes from
> vq_index. A receive record in reply to a request for a transmit queue
> makes the driver fill the struct netdev_queue_stats_tx on the stack as
> if it were a struct netdev_queue_stats_rx. If the device offers
> VIRTIO_NET_STATS_TYPE_RX_SPEED, this writes one counter to the eight
> bytes after the tx struct.
> 
> Fix this by rejecting the reply when the vq_index of a record lies
> outside the range of queues the request asked about.
> 
> Claude Opus 5.5 was used to review the driver code and draft this patch.
> To reproduce, the virtio-net device in QEMU was modified to answer an
> ethtool -S request on a one-pair device with a record for a receive
> queue the device does not have. On an unmodified kernel, KASAN then
> reports a write past the ethtool -S output array. With this patch, the
> driver rejects the same reply with "Failed to get hw stats.", a
> well-formed reply fills the statistics as before, and the
> drivers/net/stats.py selftest passes.
> 
> Fixes: 941168f8b40e ("virtio_net: support device stats")
> Fixes: d888f04c09bb ("virtio-net: support queue stat")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lianjie Wang <karin0.zst@gmail.com>
> ---
>   drivers/net/virtio_net.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index daab43ac92ce4..0473fa9947858 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -4955,7 +4955,8 @@ static void virtnet_fill_stats(struct virtnet_info *vi, u32 qid,
>   static int __virtnet_get_hw_stats(struct virtnet_info *vi,
>   				  struct virtnet_stats_ctx *ctx,
>   				  struct virtio_net_ctrl_queue_stats *req,
> -				  int req_size, void *reply, int res_size)
> +				  int req_size, void *reply, int res_size,
> +				  int first_vq, int last_vq, bool enable_cvq)
>   {
>   	struct virtio_net_stats_reply_hdr *hdr;
>   	struct scatterlist sgs_in, sgs_out;
> @@ -4976,6 +4977,10 @@ static int __virtnet_get_hw_stats(struct virtnet_info *vi,
>   	for (p = reply; p - reply < res_size; p += le16_to_cpu(hdr->size)) {
>   		hdr = p;
>   		qid = le16_to_cpu(hdr->vq_index);
> +		if ((qid < first_vq || qid > last_vq) &&
> +		    !(enable_cvq && qid == vi->max_queue_pairs * 2))
> +			return -EINVAL;

I think the above check could be simplified to:
		if (qid < first_vq || qid > last_vq)
			return -EINVAL;

squashing the following in virtnet_get_hw_stats():

-       if (enable_cvq)
+       if (enable_cvq) {
                 virtnet_make_stat_req(vi, ctx, req, vi->max_queue_pairs * 2, &j);
+               last_vq++;
+       }

(likely with some meaningful comment).

/P

