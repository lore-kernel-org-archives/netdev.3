Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794523983;
	b=AGqM8axvYjmzk8FNuQQHn7EdPBMF+oDZs5w0NQkQn9FvJfeiG+1xIiXztRatk4WaLZKT
	 pilK1ANPPuDPTOh2cJCOcbH5J+uW0z2K6qwPh8wkgRbrV3eabq42SZ1fpA9VZsBaz05GZ
	 MK+742eow+BeFLKxHrbUfENSbWcOI1NJJuErxNHsA0sJCPkR9gBm/uH3ejUaImnu1oqPx
	 QJ4KE1jSQc0tTw80LsbtYktwYUeZTRjP4Tkz68eTMc8lqSB7RBm0qmjIlH9mrwpYQIWhp
	 bqRcJGXZjmkUKnlA/dOhKtgJJCObDh46gJHXiiM9rudtosmILtGs/CXk+wVV7YHxTow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794523983;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=WwAITWmdbZGC70BWRrDzhQCdxo59dHOpJmNv4zDF21c=;
	b=oKLI+hCbyoRDT+txJnuybwTnMZeDhdpWbKZJO+SRLOtPYbtn3AqerIeWk+oVPA1SJZQ3
	 nG7x7nirnZD0gubcs/BO/KY/oK8Doz2l1zbw+2K4ihNI9xFvZulOHxuI7uYYsn8mnTERI
	 GsU9eX3sipFXmunCx0e5dQ60L8usgsxNP/XYhXmYbfmkBG5zLUZUqzrZmp77rsqgZAMbf
	 A8hP+5DKbJADE/FeiujLCtoRsYqHnP7y6J72/EDiDdoX4FpRzziXX7kic0aFwURcShhEz
	 b04zh3t6Hrn+/Qwe/nzqrMpiH+jwQ4GHh862Em/7l+YMXHs8lMwdCiXvoSw2mIt9yZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hYpb2wR+;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=oNwAr1hM;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FBC606A31C
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 22:53:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1FBC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hYpb2wR+;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=oNwAr1hM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794523981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WwAITWmdbZGC70BWRrDzhQCdxo59dHOpJmNv4zDF21c=;
	b=hYpb2wR+264idlXsYGkCZXwIXCtetnWNQ/++wxLAfQDsmjUSVH8BC31HDabe86HHe2Ux4X
	o0SRdTwWaEykOUdTujSxPUS18FtL7sKdzVoBFSo7RB23ksOCK4AZoef9vjTdlJzT9BQ1Ie
	ZLlyiiF3NUgW+qN3+nn5gv+alVb78LE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-278-4RJumwftNOmp5MS1s8AC9Q-1; Thu, 12 Nov 2026 17:53:00 -0500
X-MC-Unique: 4RJumwftNOmp5MS1s8AC9Q-1
X-Mimecast-MFC-AGG-ID: 4RJumwftNOmp5MS1s8AC9Q_1794523979
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-499ca65ae87so167566f8f.1
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 14:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794523979; x=1795128779; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WwAITWmdbZGC70BWRrDzhQCdxo59dHOpJmNv4zDF21c=;
        b=oNwAr1hMXyFoFQ7jGtGCu1sz2JZm6j4xKUBVFeqvItKvqR+ATJm7ON9pLy4qhE4/Oa
         E0NhDcsEQpSCsorKb825Owe0LRDrp4JpvWFXHWXgYwjp4IBVQvyL6iLCFfLgoC9VfkCz
         +PPp+TvZeHvbEufKKJJTjrgkmGWvhEnPA5Xqjtqb0p0UTIdRFa+so7v8fboPqlf5oez8
         tjWyRnMJNj5ea8aIhZ2m292VEtjF63P+an8qgZKxUAqMMpnyaDXAiqp17DFd4oiXw0n9
         4TzpA1lXnJDr6O6wxAJHQk+OkwZFQKOsQzWovKwiwsjo0ceCAURS3sKndsnDknD9HIt8
         iZKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794523979; x=1795128779;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WwAITWmdbZGC70BWRrDzhQCdxo59dHOpJmNv4zDF21c=;
        b=gmvYvk75CuDx6VBT1pieV49N8/Ejppt43RvW3CAau8Ng9logrl5H07/0lcN9XlNo18
         M9KnZgMtMQ2EFoykLbnRBJaXPNlHNphxPd2DsU5Y0v9uHVuj/A0YkPNFwdDBf1GOgxsA
         gycAl/HmH9QnkTWmPpolzWz9eTzJHIOFkZDCH+RMWPdPR0d/GZH4hWK4OziP+HXhmMmE
         Bi9GUNpNEmF2vxYFkRsFpaoNP3WIrq2wMjSy/0K1EYfgTVO2AvWEMuiJlfpfKivOsgK6
         IkMyx90oUqem7stHmU1CCLct/HrZLGmFTc9E+3vJ+decStiROlsM3F+jAeHYkqJX+X22
         XoTQ==
X-Forwarded-Encrypted: i=1; AL+hErG3u5kK8RD/FWIaOwT+Wf2mvSfUA0HHxSJSZBjrAmCUs5+jpAC6Hm15UdyvMlQfFbLCp15S7F0=@vger.kernel.org
X-Gm-Message-State: APuU4Z++yrIu/cPoSeIsHhfUsaDm0b4tJT2IVfooukU541jivOCpgm9e
	smtdQwPVmraavqslDlWt3zXo/0KPvTx9uRuV8ir+YEnZsa7p8nogU0wbhSRE3bAqVQWLATJFE4e
	CtnxxWFdWaxIbA6ko2hqaYYLbMMNu1NBMe2+4prKFTQeE2OTiHb0OhRatnw==
X-Gm-Gg: AYBFou2fJJnOkfEUrX/vs877xjJ+ULzVy24zmx/6diPTbSr2Nm1eztARe661xqolJ0u
	bbL1VlRab2U2Z7Y+s94bUVfTTXAHaovJ8G3TlacD97SZeIYeXTVcSVUj5CN1mEAWhBbUSvj2sMf
	xsXuhJKJGMkOTpNoKVkXNdXPvzLNVluPchl6+sWqSLVMcwicMYF8nHUO2QGCmzjQl51RQA/E7ng
	tLsdCubty6NQn7BJ5LWknVTuYTpWoqybhRyheQEszlIdXabYb+UcvpssuBzmN30/tv1v/e8LOz9
	glbwbrR0hf/ziORTLE6tsU1zFzOZ8TKykQ8Hoa1EZ5K9anMvlmZIdhVgG9+JAg6VyF3iviv5kcJ
	/fh95Rhqo79gULf43mnEZaERXVRsEPA1/DAxvw8zg7g==
X-Received: by 2002:a05:6000:3cd:b0:492:aff5:da4d with SMTP id ffacd0b85a97d-49b01734c32mr10021209f8f.7.1794523978942;
        Thu, 12 Nov 2026 14:52:58 -0800 (PST)
X-Received: by 2002:a05:6000:3cd:b0:492:aff5:da4d with SMTP id ffacd0b85a97d-49b01734c32mr10021143f8f.7.1794523978200;
        Thu, 12 Nov 2026 14:52:58 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1511:2900:ff37:b35c:a97:952d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c609c602dsm1590908f8f.46.2026.11.12.14.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 14:52:56 -0800 (PST)
Date: Thu, 12 Nov 2026 17:52:53 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Longjun Tang <lange_tang@163.com>
Cc: kuba@kernel.org, eperezma@redhat.com, jasowangio@gmail.com,
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, tanglongjun@kylinos.cn
Subject: Re: [PATCH 3/3] virtio_net: add rx_timeouts per-queue statistic
Message-ID: <20261112175235-mutt-send-email-mst@kernel.org>
References: <20261109094310.103979-1-lange_tang@163.com>
 <20261109094310.103979-4-lange_tang@163.com>
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
In-Reply-To: <20261109094310.103979-4-lange_tang@163.com>

On Mon, Nov 09, 2026 at 05:43:10PM +0800, Longjun Tang wrote:
> From: Longjun Tang <tanglongjun@kylinos.cn>
> 
> Add an rx_timeouts field to the per-queue RX statistics and expose it
> via ethtool. Whenever an RX queue gets stuck, the NAPI poll increments
> rx_timeouts, so it counts RX queue stuck events.
> 
> Signed-off-by: Longjun Tang <tanglongjun@kylinos.cn>
> ---
>  drivers/net/virtio_net.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index ec7c248080c5..feb6bfbb1c5a 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -135,6 +135,7 @@ struct virtnet_rq_stats {
>  	u64_stats_t xdp_redirects;
>  	u64_stats_t xdp_drops;
>  	u64_stats_t kicks;
> +	u64_stats_t rx_timeouts;
>  };
>  
>  #define VIRTNET_SQ_STAT(name, m) {name, offsetof(struct virtnet_sq_stats, m), -1}
> @@ -168,6 +169,7 @@ static const struct virtnet_stat_desc virtnet_rq_stats_desc[] = {
>  	VIRTNET_RQ_STAT("xdp_redirects", xdp_redirects),
>  	VIRTNET_RQ_STAT("xdp_drops",     xdp_drops),
>  	VIRTNET_RQ_STAT("kicks",         kicks),
> +	VIRTNET_RQ_STAT("rx_timeouts",   rx_timeouts),
>  };
>

Is this consistent with any other hardware?
  
>  static const struct virtnet_stat_desc virtnet_sq_stats_desc_qstat[] = {
> @@ -2983,6 +2985,12 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
>  		u64_stats_add(item, u64_stats_read(src));
>  	}
>  
> +	/* Count a stall recovered by this poll. */
> +	if (rq->watchdog.stalled) {
> +		u64_stats_inc(&rq->stats.rx_timeouts);
> +		rq->watchdog.stalled = false;
> +	}
> +
>  	u64_stats_add(&rq->stats.packets, u64_stats_read(&stats.packets));
>  	u64_stats_add(&rq->stats.bytes, u64_stats_read(&stats.bytes));
>  	u64_stats_add(&rq->stats.alloc_fail, u64_stats_read(&stats.alloc_fail));
> -- 
> 2.51.0

