Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94644AF68C
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 09:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789636588; cv=none; b=oGm/JQD8Da0hyaXNxqNcBgBm2OSPnA4hcpa+ntAjLOj5JwtG90RPq0/40dMsHj8LvNMPU9EArYU3gaBTChRvq+YmS5YSF0pdBOYpsI43KFHcM0iGXtWlCS9I+zfr60fud/YQdLRk0S+r3A4WTq2ZD3HEvSFzK3pG/sDpBI76Smc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789636588; c=relaxed/simple;
	bh=wVFGrWQQBa00Kr1v3u38oJ+Psc2Uy+oa8aI6FjA0COU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SOgEF3QD4COBedSze43MgZhsjlwQKSM0rPqDLMahB+ZhG7++pKlG9O/0Mf+IfnZtjWQDBYfdxOmGhFeCpAfqHkB0B3zOxeCCuJ3kHRcS6z3b96pj0ktBwbaZ67F3dV7lqVW2k7YfUXWE5gMU8V+WcOka0/oxwhGDxFpmfG+fjso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FVJadweY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=I+P6SdVe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FVJadweY";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="I+P6SdVe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789636584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YasMKQ2T/AatfsN0JjpUO/fKJtg6yNiDvHeBKdEJON4=;
	b=FVJadweY/p2GAFPubmv+sYFhRnd8PdFrWlyz+762gHnnsDtsDytRKOOP7oeP2GHIUtfgZJ
	PtMcHVlv5OUkL+xgAAG1hQqEPlRw27mJo52tA8g8yYUT0hNXHl2vh7P4IHB384ZPKbQdYp
	15r8AeLCsxBcWL2tKNy2tZbAAZuaWlA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-Df5WNI_uMBGVvzhWt7HZsQ-1; Thu, 17 Sep 2026 05:16:22 -0400
X-MC-Unique: Df5WNI_uMBGVvzhWt7HZsQ-1
X-Mimecast-MFC-AGG-ID: Df5WNI_uMBGVvzhWt7HZsQ_1789636582
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4870142fd5cso273575f8f.0
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 02:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789636581; x=1790241381; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YasMKQ2T/AatfsN0JjpUO/fKJtg6yNiDvHeBKdEJON4=;
        b=I+P6SdVejhwgRieImpF/lHGRd+wYWPhq4gVaoxap5KUvQQHwjurNfGHBFXw2xP14rl
         D9pOFxOpxpJ1xjL+x4AWXq3ZBhJvnFeefxlGMneXIIaMbVEYshgibUbLTXovtRA1ZZUi
         CXtmKwF/7XoKY2uF9g4QylCIj1k02aN0GzYQk0vx9yoYkswRyneOPzRR9DjtF8q5NMvm
         HUUxeFWhJFGOzTmlJwKsIHvzGQNiJLGt371OGM9+B25jya20S/gWBF7DrqIkPuUxQFyH
         AWRUaE4SRHNdov5SEb63C6JV3cZO4aLk9szefKn8oakK3AIE821ujVkyy3FNz4J0/qGM
         bIZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789636582; x=1790241382;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YasMKQ2T/AatfsN0JjpUO/fKJtg6yNiDvHeBKdEJON4=;
        b=MWRzsrk4/FOWJX05Qhdhmag4skYavaeBDSAeIWjyCD5QuL0ju1TTieiVtWjUhPKdzl
         kFdsOD0TwYuh8dphC5F6jC4kwd/A8wpnpfLtP0rGaruTVJH2EmzmwpzNABWVkckFOPgS
         54gQfNVbPSuUPRpjsAxk1MYSaqrKqJS5MK4qr0aPTmWbRV+JRn2c/19xEAlB7GrH+Au5
         yKJqVSCX6Vpwrl11+Bll1KPCJRnQm0HZw9L/xD2jsWC076mSA/W4AAjbYa8UgkvsxyFT
         NstlzMXPsTvCsHafqnOvhUfs7Gqn9kgKmpYzGtCo977i4pXOzyj+7PQ4EGcHwrfaqBax
         Sr0w==
X-Forwarded-Encrypted: i=1; AKwUvByVdtQTWhxw3/dQx4Z/2xPhZ5sqi+D5EpJ1RntENGvNY3Rxm45XMnfPU/pKxXFNXl0wHewHknU=@vger.kernel.org
X-Gm-Message-State: AFuF++nioTd33rSG5YwstsKUa8sm3YuVqHtYX7ojlmI3563P7dbdErW7
	BN0Kw5QITtQZqF3u/UipIh9xu+E6jbHPhIArUI/cVGNgXKUPc6Sezm4qild3laHm9yzju901FAM
	iHYLjNSiOTEumntz+l1gXe3PQUqSXizroNfow7w48XKNggIPXxa/grGgdiA==
X-Gm-Gg: AYBFou2dx7mQaSrjMycqX0WOpa/kGDuT3pkjKMm22/VdeZOxjO5CQkTGo8cIdA8YPET
	Ltn3KDwOUTHgLRK+CRdjpwxlhC2uhnMVPZso2j69UhWkiB3BA+vg6cTa2CEskX11zA1WHZN3/cM
	W/3vAs2EiSnI/0UX5opdNKKKRCeCpfEGM7GovS3QMl07ePiP8S2A/7ywpqsSHQP9BMSjoy61xr7
	ZTciCsqPoXWUA02WI6NLSkUkG9llKXICuoSOHnQacz6mrmdA2I92+cTbux9bYDjPkFQ5A5dYVre
	xZacgukoL1XmJuyHsIXSoRD8By+6olJHDjzoXIXATPgvozgIgF/RPZ4oSxspybqj0ZajqySLFCF
	dskHeZqm2VIagR0n1duJReNiNDg73LFfKmC6/ZN+m7Q9UGuT0q88qT3y5Thwv6GCqurkboynsgA
	==
X-Received: by 2002:a5d:6f12:0:b0:487:fa6:c921 with SMTP id ffacd0b85a97d-4870fa6ca22mr5920390f8f.23.1789636581613;
        Thu, 17 Sep 2026 02:16:21 -0700 (PDT)
X-Received: by 2002:a5d:6f12:0:b0:487:fa6:c921 with SMTP id ffacd0b85a97d-4870fa6ca22mr5920348f8f.23.1789636581205;
        Thu, 17 Sep 2026 02:16:21 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf37e69sm14006115f8f.29.2026.09.17.02.16.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 02:16:20 -0700 (PDT)
Message-ID: <a0b83186-7399-4d79-8226-ff43611184d7@redhat.com>
Date: Thu, 17 Sep 2026 11:16:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] packet: use ubuf_info completion for TX_RING
 packets
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 horms@kernel.org, andrew+netdev@lunn.ch,
 Willem de Bruijn <willemb@google.com>,
 Katherine Leaver <kleaver@janestreet.com>, Bjoern Doebel <doebel@amazon.de>,
 stable@vger.kernel.org
References: <20260914214229.1674102-1-willemdebruijn.kernel@gmail.com>
 <20260914214229.1674102-3-willemdebruijn.kernel@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260914214229.1674102-3-willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/14/26 23:37, Willem de Bruijn wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> tpacket_snd sends skbs with frags pointing into its ring slots. Slots
> are released when skb->destructor is called.
> 
> A call to skb_orphan calls skb->destructor before the skb is freed.
> This can cause the slot to be reused while still linked into the skb.
> 
> Switch to standard zerocopy completion (ubuf_info) so the slot is only
> released once all references to the payload are freed or copied.
> Restore skb->destructor to standard sock_wfree.
> 
> To prevent userspace from aliasing in-flight state on shared ring
> slots, allocate tpacket_uarg per packet, rather than per slot. This
> adds a small allocation to the transmit path. Use standard kmalloc to
> allow backporting to stable kernels.
> 
> The uarg holds an sk_wmem_alloc reference, rather than an sk_refcnt
> reference. packet_free_tx_ring waits on sk_wmem_alloc before freeing
> the ring pages.
> 
> As a result a slot is released when its payload is copied, which can
> be before transmission (e.g., in skb_orphan_frags_rx). Any slot
> timestamp then reflects the time of copy, rather than of transmit
> (or skb_orphan).
> 
> Revert the now unused previous skb_zcopy_.._nouarg infra.
> 
> Reported-by: Katherine Leaver <kleaver@janestreet.com>
> Reported-by: Bjoern Doebel <doebel@amazon.de>
> Closes: https://lore.kernel.org/netdev/20260909085542.3370986-1-doebel@amazon.de/
> Fixes: 5cd8d46ea156 ("packet: copy user buffers before orphan or clone")
> Cc: stable@vger.kernel.org
> Signed-off-by: Willem de Bruijn <willemb@google.com>
FTR both the 'high prio' sashiko finding here and the mid one on the 
previous patch are IMHO worth addressing.

Also I'm wondering if the extra alloc/free is visible in perf figures? 
Out of sheer ignorance, can't the ubuf be carved out of the ring?

/P

