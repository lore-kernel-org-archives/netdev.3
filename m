Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792762963;
	b=1frcHYlioGxg+BeXAXJVIc1LflYf6jOD4Jz4YifDOTwlt8gYudzl3aU4p8CvWEhrcOVh
	 n/xaUpD4J66OF3qjNiCBm9P5nTrK7G9U1LVTV2BFwq3CE/qsEvy1iuy5r/gprNJWk9L05
	 xCp3kRtPhi5l++o5048iS7W6GJvYOUGvPvBk/28kyzwL8CsIGTOUbAu7y5f96imfT8wWT
	 aOQ1Ucb0Im/CSnMNRC2CbWjkjcTj91Nwlm4Z9nZF4AURKLnmgmnrLmduY2I6PODKkiF99
	 32eEEWVTBlxh5ZMTcCFiAt2G7Vr6weOA4BOP9yAAJeLpnk3ShCNjfMEMM8Bs8SCKIBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792762963;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=5mbhKX3DfGtGfedq6uqJfFeSJNxxutG+9ZWTYOg7Sp8=;
	b=bZiLo2FKHFKlSXlV1SvseFo+h+sQddnEIGf06YVfZiosQx7nr3nFDRjbVXc83pLGqoAD
	 ttFdvl7br83JhLvMbrEOinS9GmHEXgYv0nnoO1lu0rKGSt7Ok/j9Qeb4JtLhAdIsHGdiC
	 zBnLlaCwovkSIPKSdrfnh45Glww2tkXDFv/jAAzaW8odJ4aoh1lwg28MToTVd/TDC34LQ
	 NoT811oB+UZYhPd8uch0aT4DskXDTnmLKMqXE3pbueG33zo3iIPWmyUp7VpdIVC9UO+6u
	 /tI38gLyXzHZSlqb/wAS7/qW5sk7VpnKLde76A5JJnt+ILlEe89g4kPM2IkPDNfxYuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HcpNJ7ov;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=mLoNwoNQ;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4983606A31F
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 13:42:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4983606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HcpNJ7ov;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=mLoNwoNQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792762961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5mbhKX3DfGtGfedq6uqJfFeSJNxxutG+9ZWTYOg7Sp8=;
	b=HcpNJ7ov0Poerj1UgzZgMevlNmkkrAu3tQB3/lkVr4bGKTQ3I7Mw28Y+JlvaX3ZZ2A460E
	WW8gDRlyws7OZahQn8BpYJChXle8m8dMz2fLyltyrmYCCc6TUeeitzA5H9XUEdfduaeUKB
	Sd6prytP887WAQAa6YW/bNPuT8XVyco=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-lQBghpGrOAWKEm7o9p3q3w-1; Fri, 23 Oct 2026 09:42:40 -0400
X-MC-Unique: lQBghpGrOAWKEm7o9p3q3w-1
X-Mimecast-MFC-AGG-ID: lQBghpGrOAWKEm7o9p3q3w_1792762959
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a0284121c6so7990995e9.3
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 06:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792762959; x=1793367759; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5mbhKX3DfGtGfedq6uqJfFeSJNxxutG+9ZWTYOg7Sp8=;
        b=mLoNwoNQep8NVa40M+rnnTywoG8nNs4wFF60QvGxXJASBWdtiHkKyNMfEMLxY3HwDY
         jeUGIABUq2pX+KcJZY/2ToUhJqMmBn+JUKPusPzoOtT4ZGs517KIma3WJwA8wfTwjpMG
         gezId4Elw6XMYyO8WmnOuoQApXDTR4KMK0vMI7PcHw5yMX8YUIXL9MtUaWdSa2cJtrVS
         hkm7Da1eCojE67cXHixhWOglIrjHGMUGmytgJnTnIb/Kl6W55PE/0I+OMe0vtejBJzyQ
         bqGHg/4WiISPLUyGKeQTxV/tFq9PWpKxzMhZ07heEpOO1agY8KYfholJ5uh9slpvztmY
         RbDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792762959; x=1793367759;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5mbhKX3DfGtGfedq6uqJfFeSJNxxutG+9ZWTYOg7Sp8=;
        b=UsLsS+JJXixZCg1OsySroMPlBBEPX56sxamRHk4bZcfozpgmtobrDmcoINOArRriXo
         rrEsnRyno+kLCjHT0g0c4nmsbjUbVeXaAIIN0ifVgbAg49AvtUBFmo35OijJwd5mDOvz
         4JBHSC2XkrT+vbhxhc5wdr314HDkxyxercurcn/L6gZv8IOP+eHSeUSSunVSBOOQfWfT
         TO27VO3SlmA6HBeHfJRp4r7D98eR0gm+Z7ZG8y5WtzpX28jBAsXCdAgV8V8BeeRUJiWX
         32HTkKVdUT/E1uL0+/cT7k/mKWEclomlPt4Hd3B/vZXWVtC24oHLz8ct2pdAA0/7A3pd
         NHyg==
X-Gm-Message-State: AFq9FYIGinBOqsFUpvV1/0qMDkel5LLn9nDc6W02WgY+Of6Ulq+SWg+e
	gw+f2iuXRBXVixBkNQiu4wm2eq/GJufh/HHR/F6bKTjCXP820cldU/vR847Uai4OA4usEPseE/Q
	vCPyvt60xQYiP/iijpcRDkWt8tY1xD9jjK6ERejuJV+LjcCHJW+nIgAegMw==
X-Gm-Gg: AYBFou0liPUc+X8ihyR3uqSNbn4HZ72ugIkqrrKCE2PgkIOm2Xv4ECvfpUXD/ASksyo
	OOzVc0pPdl2dsIqQ6yF/hiIUHZ/0SL7tsRZrQwKGS/PyjiEtQi4hVYAxuRW9b7HvdEu7pjudM+w
	+RxT9l0PZ2BtTroNSohSYz7d5nz3LaMDCeWJnGGMfRnWgeqTPFuJZyG/0dRcYHH8cl3XQSFn2qk
	7qcjKyP3zpOJJwa3xjYYDq89HWdWwrNV6lW2UEoQebZf96tigKXADA5v91P9aoO92OsYo6FWUuu
	wxmvQEeXH+StXMBDxxD4AuFZh+pgzbDx2HPFP71JMjeqSWY1BzdUu4+KGpJo48gzn10HU1zCQSu
	IePoZmqMsaAWreUx0VgOCfGjlvy5acWGAFB299RD2Wz+sOeBPv6goybDAtwpqeCHEzSLNezD4bw
	==
X-Received: by 2002:a05:600c:4e43:b0:4a2:16c7:fd2 with SMTP id 5b1f17b1804b1-4a216c711f2mr23995815e9.21.1792762959145;
        Fri, 23 Oct 2026 06:42:39 -0700 (PDT)
X-Received: by 2002:a05:600c:4e43:b0:4a2:16c7:fd2 with SMTP id 5b1f17b1804b1-4a216c711f2mr23995125e9.21.1792762958636;
        Fri, 23 Oct 2026 06:42:38 -0700 (PDT)
Received: from [192.168.188.234] (ip174-129-192-82.pool-bba.aruba.it. [82.192.129.174])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a29cda9686sm5966445e9.6.2026.10.23.06.42.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2026 06:42:38 -0700 (PDT)
Message-ID: <94fc21b9-f01a-4fe3-ac3c-bcc0c92a0b4c@redhat.com>
Date: Fri, 23 Oct 2026 15:42:37 +0200
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
Subject: Re: [PATCH net] net: page_pool: bound queue_idx before indexing
 dev->_rx[]
To: Dudu Lu <phx0fer@gmail.com>, hawk@kernel.org, ilias.apalodimas@linaro.org
Cc: netdev@vger.kernel.org
References: <20261021155611.68473-1-phx0fer@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261021155611.68473-1-phx0fer@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/21/26 17:56, Dudu Lu wrote:
> page_pool_init() calls __netif_get_rx_queue(pool->slow.netdev,
> pool->slow.queue_idx), which is a bare `dev->_rx + rxq` with no bound,
> and then dereferences the result (rxq->mp_params.mp_priv / .mp_ops).  A
> queue_idx at or beyond real_num_rx_queues reads past the dev->_rx[]
> allocation:
> 
>    BUG: KASAN: slab-out-of-bounds in page_pool_create_percpu+0xa74/0xafc
>    Read of size 8 at addr ffff000006587eb8 by task kworker/0:1/11
>     page_pool_create_percpu+0xa74/0xafc
>     page_pool_create+0x14/0x20
>     ppidx_work+0x2d8/0x34c [ppidx_probe]
> 
> queue_idx comes from the driver's page_pool_params, so validate it
> against the device before using it to index the queue array.
> 
> Fixes: 0f9214046893 ("memory-provider: dmabuf devmem memory provider")
> Assisted-by: LLM
> Signed-off-by: Dudu Lu <phx0fer@gmail.com>
This patch is suspected of causing initialization failure for broadcom nic:

https://netdev.bots.linux.dev/flakes.html?min-flip=0&br-cnt=20&br-pfx=net-next-hw&ld-remote=netdev-BCM57508

tentatively dropping it.

/P

