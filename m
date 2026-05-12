Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD51349CC4
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 10:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778581055; cv=none; b=FcfjTJfCRSuWkLo0uQHrXSHgQTdsTHocZqGsPacUNAx07r1LvHVVWaoyJNoikRr+qlntORvWl00hDR5fBZVJEWCha7KGlEZRcwAVIELrygtwRej21Mk4c0OGPs29TgrKXOdGhkSqSWpL9kNNyW2YqIhqjfI2jlRMSCe6Ja9kuig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778581055; c=relaxed/simple;
	bh=7fHua7gVLtlLuWukdj6YfC8xUx+gNLhDKF2pfyqbI74=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eARZRlpvZekutKx/5W0Ul4qVe87kclFmo6hyRP55YjyWH2z1fjB/P9iGDZdSUswZPAtZ085NAyENRtX5hbsxjlWenPdZCzWj44P+WPQVmFED1PoiHQ0wXQviNVXmOH6+Cp9GZOeXIQM8h7GbduKSYY/BVcOfsRVrgoIxrzYkVG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KCMGL4Bj; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bTthbHQ4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KCMGL4Bj";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bTthbHQ4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778581050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wqFPwyr/JAovWcliGDBMBWbMd+chU64Fjc4DTjKY23I=;
	b=KCMGL4Bj8NP36aghkUDHhZ4CjrjkqYL2H8Bge8C+eYplUlHwRQuxOgIMFlEwAdTwscKCYX
	pABZA4XS+605pjcY9AHu5+AL1/TfpOvn/e9hhNYvMKJZQWKcn09SEoprzfN9azcXCXrv8Q
	dcTTxaNGQuQHBATQoCz6RTnJ/6FazLw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-FrJoXpkFOf2QSHAWeV4Z5Q-1; Tue, 12 May 2026 06:17:29 -0400
X-MC-Unique: FrJoXpkFOf2QSHAWeV4Z5Q-1
X-Mimecast-MFC-AGG-ID: FrJoXpkFOf2QSHAWeV4Z5Q_1778581048
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-44f1b4d0fb0so3539653f8f.1
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 03:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778581048; x=1779185848; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wqFPwyr/JAovWcliGDBMBWbMd+chU64Fjc4DTjKY23I=;
        b=bTthbHQ4r+lRFws5G2p0Yj1JMOirXfkESyZo9c+6DqPR5CKiTzSr8f4hnQTWYcaPLF
         z/Znl273hKsWmSroP23B1gZqLoWICbMfoP0twDBYzV7FHSaFwmmD7/l2vBQzyZfmlCho
         7KJQQWvWhO9P8ORWdXilbxXSMEprjiWm+hxkD7m7lzgIM5NMIi3tcaLci9xgGf1sVEB/
         AJ2/XX283ODfqzyQgdIasUkMlc35euzBKXyibOEFxi+qdAqMQx9TZ1myyCAxv3olCj1J
         hHtPrk8aIpfFgNF/U5pZgmcbVRoSDNsSVojkv8mAWnszHUcT4D73/YkFk3qIDtWroNvP
         ZplQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778581048; x=1779185848;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wqFPwyr/JAovWcliGDBMBWbMd+chU64Fjc4DTjKY23I=;
        b=S7AssUlRtX3HVGrB8ANX+6ZmF74wW2iawerM5x3TKCmNdz/kpZ7nmHaTLVDC9S0MMf
         esoo1xbAHMeN8nF4MxAHMEX+SZuex9r8+ABueEHjGd+3kPbgiLs7t0Wy3Z2rSnuSDYKD
         qpEP/xACtoBz6zkLE6xFkX0BrxBzEG7ZiwJ9BoRgehzdDFRBPzCfd/XvjB7Gog8cEHx8
         FaB2qj65OPlreguIdpDaXmvq0+IPqKOFs2QI8PQNA8bkOzCevTGOxvELM5VpkFj6eXAd
         SE3WQQXta6QfVXlza7zRVPn9v4zy2l0DPFWNcjv7oMmaYyc9wgnrkmeqzLkREj906qiE
         9uPg==
X-Forwarded-Encrypted: i=1; AFNElJ/bLUrQiuQqdyaa3HCviCd4E7TRIZxD4myUoCfrXmToWVRyZAMXd/iy1kGE3l+5hJ3UBmmeaUg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC6c/sfwIAg4bG5id9QVF0WPCXeyuvqtOl+qvy7g7LilCHLxpX
	TS9CKo3XCRrqanLvBpfe3QpgcjbN3u+yFtzX/YJNFp7fBb+8Pwn75URAnN0c18VlXGTYX0z1EXf
	peaNIpsBvoTNzkHiMZoY1Qogt+Fhz8B51kBet0WbVZyTrHWI7Alg2Cy1fXQ==
X-Gm-Gg: Acq92OF7ns7LSKb5+wmJosyLp33HcgaIPfypg3Jw83qakPS9/HKpTNW1fgqdmJfjhFM
	p8ddF9cjCHrWBq92/luxV4TzcTg+ZfAQqf466Zp2zoV0aDyaVk0Qd41fPitV/UEU6z4CYiHxNq0
	/Fs+Iz0ZqV9xk16GX0XxjveS1lR3a5DUjqzg4oioFdAbnss6VL3+CQSfvDOkOMoiz6+l1y/CObW
	RQplnQ4hvJKoe7Xc/8cujLUcgoXKvGxc7tv2xMQS0iBMpe79n0kd+WdArCfyEnBC5o00mRIliW9
	XNSGGDm2rZnlR1kEFVbqM2RK1BhAt7MSCxhdaK425+RhB9IDEfTnupN1c2YnWLoO8BMf20Kre0k
	tx07LOity6NH+xZgz4O1fOKPZrIuP/tf0IKgFNd+HJmX4aHhmL1d5p5k=
X-Received: by 2002:a05:600c:64c9:b0:488:a977:8d6 with SMTP id 5b1f17b1804b1-48e8fe7b863mr39018975e9.19.1778581048131;
        Tue, 12 May 2026 03:17:28 -0700 (PDT)
X-Received: by 2002:a05:600c:64c9:b0:488:a977:8d6 with SMTP id 5b1f17b1804b1-48e8fe7b863mr39018265e9.19.1778581047569;
        Tue, 12 May 2026 03:17:27 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.9.106])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e8e566bc8sm24781485e9.0.2026.05.12.03.17.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 03:17:27 -0700 (PDT)
Message-ID: <f8ab7286-8a4f-4dfd-96b1-db1f05b1f2b1@redhat.com>
Date: Tue, 12 May 2026 12:17:25 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 9/9] net: atlantic: add PTP support for AQC113
 (Antigua) (Antigua)
To: sukhdeeps@marvell.com, netdev@vger.kernel.org
Cc: irusskikh@marvell.com, epomozov@marvell.com, richardcochran@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, vadim.fedorenko@linux.dev, linux-kernel@vger.kernel.org
References: <20260506135706.2834-1-sukhdeeps@marvell.com>
 <20260508120156.3060-1-sukhdeeps@marvell.com>
 <20260508120156.3060-10-sukhdeeps@marvell.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260508120156.3060-10-sukhdeeps@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/8/26 2:01 PM, sukhdeeps@marvell.com wrote:
> From: Sukhdeep Singh <sukhdeeps@marvell.com>
> 
> Add IEEE 1588 PTP support for the AQC113 (Antigua) network controller
> alongside the existing AQC107 (Atlantic) PTP implementation.
> 
> AQC113 PTP uses a different hardware architecture from AQC107:
> - Dual TSG clocks (sel 0 for PTP, sel 1 for PTM) instead of PHY-based
>   timestamping
> - TX timestamp via descriptor writeback instead of firmware mailbox
> - Per-instance PTP timestamp offsets instead of global static table
> - Hardware L3/L4 filters for PTP multicast steering with IPv4 and
>   IPv6 support (4 filter slots for multicast addresses)
> - Direct hardware clock control instead of firmware-mediated access
> 
> Key implementation details:
> 
> PTP clock management:
> - Add aq_ptp_state enum to distinguish first init, link up, and no
>   link states for proper clock initialization
> - On AQC113, only reset the clock on first init (not on every link
>   change) to avoid disrupting ongoing PTP synchronization
> - Re-apply RX filters on link change since hardware state is lost
> 
> TX timestamp path:
> - Add per-packet TX timestamp request via request_ts/clk_sel in the
>   ring buffer descriptor
> - Poll for TX timestamp completion in aq_ring_tx_clean() with a
>   timeout mechanism (aq_ptp_tx_ts_timedout/clear)
> - Set AQ_HW_TXD_CTL_TS_EN in TX descriptors for timestamp-requested
>   packets
> 
> RX filter management:
> - Replace single UDP filter with array of 4 for IPv4/IPv6 multicast
>   PTP addresses (224.0.1.129, 224.0.0.107, ff0e::181, ff02::6b)
> - Add aq_ptp_dpath_enable() for comprehensive filter setup/teardown
> - Add aq_ptp_parse_rx_filters() to map hwtstamp_rx_filters to L2/L4
>   enable flags
> 
> PTP TX path in aq_main.c:
> - Add IPv6 PTP packet detection using ipv6_hdr()->nexthdr
> - Use PTP_EV_PORT/PTP_GEN_PORT defines instead of magic numbers
> - Move skb_tx_timestamp() to non-PTP path to avoid double timestamps
> 
> IRQ and initialization:
> - Account for PTP IRQ vector (AQ_HW_PTP_IRQS) in vector math
> - Move filter/VLAN rule application to aq_nic_start() for proper
>   ordering after PTP ring setup
> - Add AQ_HW_FLAG_STARTED flag management in open/close
> 
> HW layer (hw_atl2.c):
> - Implement PTP clock enable/disable, read, adjust, increment
> - Add GPIO pulse generation for PPS output
> - Add TX/RX PTP ring initialization
> - Add TX timestamp descriptor readback
> - Add RX timestamp extraction from packet trailer
> - Re-enable PTP after hardware reset
> - Wire all PTP ops into hw_atl2_ops table
> 
> Per-instance PTP offsets with empirically measured values for AQC113
> at each link speed (100M/1G/2.5G/5G/10G).
> 
> Signed-off-by: Sukhdeep Singh <sukhdeeps@marvell.com>
> ---
>  .../net/ethernet/aquantia/atlantic/aq_hw.h    |   1 +
>  .../net/ethernet/aquantia/atlantic/aq_main.c  |  34 +-
>  .../net/ethernet/aquantia/atlantic/aq_nic.c   |  48 +-
>  .../ethernet/aquantia/atlantic/aq_pci_func.c  |   4 +-
>  .../net/ethernet/aquantia/atlantic/aq_ptp.c   | 535 ++++++++++++++----
>  .../net/ethernet/aquantia/atlantic/aq_ptp.h   |  15 +-
>  .../net/ethernet/aquantia/atlantic/aq_ring.c  |  42 +-
>  .../aquantia/atlantic/hw_atl2/hw_atl2.c       | 179 +++++-
>  .../aquantia/atlantic/hw_atl2/hw_atl2.h       |  12 +
>  .../atlantic/hw_atl2/hw_atl2_internal.h       |   3 +-
>  .../aquantia/atlantic/hw_atl2/hw_atl2_utils.h |  10 +
>  11 files changed, 710 insertions(+), 173 deletions(-)

Very large patch, you should try to break it in smaller chunks.

> @@ -1035,46 +1246,49 @@ static struct ptp_clock_info aq_ptp_clock = {
>  	.pin_config	= NULL,
>  };
>  
> -#define ptp_offset_init(__idx, __mbps, __egress, __ingress)   do { \
> -		ptp_offset[__idx].mbps = (__mbps); \
> -		ptp_offset[__idx].egress = (__egress); \
> -		ptp_offset[__idx].ingress = (__ingress); } \
> -		while (0)
> +static inline void ptp_offset_init(struct aq_ptp_s *aq_ptp, int idx,
> +				   unsigned int mbps, int egress, int ingress)

'inline' in c files are highly discouraged. Use them only for critical
path and providing reasoning (i.e. the compiler does the wrong thing
otherwise).

[...]
> diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
> index e270327e47fd..a52d6d3fe464 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
> @@ -308,24 +308,30 @@ bool aq_ring_tx_clean(struct aq_ring_s *self)
>  			}
>  		}
>  
> -		if (likely(!buff->is_eop))
> -			goto out;
> -
> -		if (buff->skb) {
> -			u64_stats_update_begin(&self->stats.tx.syncp);
> -			++self->stats.tx.packets;
> -			self->stats.tx.bytes += buff->skb->len;
> -			u64_stats_update_end(&self->stats.tx.syncp);
> -			dev_kfree_skb_any(buff->skb);
> -		} else if (buff->xdpf) {
> -			u64_stats_update_begin(&self->stats.tx.syncp);
> -			++self->stats.tx.packets;
> -			self->stats.tx.bytes += xdp_get_frame_len(buff->xdpf);
> -			u64_stats_update_end(&self->stats.tx.syncp);
> -			xdp_return_frame_rx_napi(buff->xdpf);
> -		}
> +		if (unlikely(buff->is_eop)) {

I see this is pre-exiting code, but why is this condition unlikely? I
suppose the NIC is expected to receive packets :-P

Also, using a goto statement would avoid excessive indentation.

> +			if (unlikely(buff->request_ts) &&
> +			    self->aq_nic->aq_hw_ops->hw_ring_tx_ptp_get_ts) {
> +				u64 ts = self->aq_nic->aq_hw_ops->hw_ring_tx_ptp_get_ts(self);
> +
> +				if (!ts)
> +					break;
>  
> -out:
> +				aq_ptp_tx_hwtstamp(self->aq_nic, ts);
> +			}
> +			if (buff->skb) {
> +				u64_stats_update_begin(&self->stats.tx.syncp);
> +				++self->stats.tx.packets;
> +				self->stats.tx.bytes += buff->skb->len;
> +				u64_stats_update_end(&self->stats.tx.syncp);
> +				dev_kfree_skb_any(buff->skb);
> +			} else if (buff->xdpf) {
> +				u64_stats_update_begin(&self->stats.tx.syncp);
> +				++self->stats.tx.packets;
> +				self->stats.tx.bytes += xdp_get_frame_len(buff->xdpf);
> +				u64_stats_update_end(&self->stats.tx.syncp);
> +				xdp_return_frame_rx_napi(buff->xdpf);
> +			}
> +		}
>  		buff->skb = NULL;
>  		buff->xdpf = NULL;
>  		buff->pa = 0U;

[...]
> @@ -886,6 +912,138 @@ static struct aq_stats_s *hw_atl2_utils_get_hw_stats(struct aq_hw_s *self)
>  	return &self->curr_stats;
>  }
>  
> +static u32 hw_atl2_tsg_int_clk_freq(struct aq_hw_s *self)
> +{
> +	return AQ2_HW_PTP_COUNTER_HZ;
> +}

Why do you need an helper here? Using the macro directly should be just
fine.


