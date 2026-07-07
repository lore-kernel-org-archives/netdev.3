Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CBF19D065
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 08:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783413932; cv=none; b=m3ph7tV7H5G2BRKC59YqSiNpiwKKengUIzXGRHcNo6tLiABLBUFJK0fvczsvl7q7upovkuCxNhURtPis5xl9qpjlzx17UfYhfQZ8a2kwCzhKOv1yKuFUOPrbtBv7EJnlJIIf1VVIi5uhZU2Mdv7uPb9iYnEKx1buIuZX6+ydO3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783413932; c=relaxed/simple;
	bh=tlwKcaYpnhlrmwYXGp448EifMjMd+UfA0EFtVTEhYZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PXdw5mxrvLutG/qU/+jKa5hHrVUKGzsXkeikrhOh57n1LblcN9nL8+V1lMIkxRITx+7PQObwL6zsle3jcPiPAAv2Rwexqy6XRj/V4j/auhEIQy2Jve1+5MYQpSjsowVXOtviXGC0C1PNDASL/0VTVEEmd9gyX1g3pKI0g3VbEcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gWw/zZFI; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=J0HgxWNQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gWw/zZFI";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="J0HgxWNQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783413930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WBby4NIaLLIhvVGMeDiSJrQP+NcVkO4R8rZDsmeFUN4=;
	b=gWw/zZFIzgAjrUf/xJyhy1Ku64Z0fQ0awBlQBoHwmpvgH663fKaHGqoMJOGtnxEVQ1pIGZ
	RDxjUdZEfX5TYVQHAmmuF4oEynrgNx1LrQAFkZGEF7e7T2Vf63S+Jo4KOfayVtirza/Cdp
	g8F0yAveeSlQ9egWo/AS1ikwT+GjBTA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-IjGBg7qOM1CiyIa53nWvYA-1; Tue, 07 Jul 2026 04:45:29 -0400
X-MC-Unique: IjGBg7qOM1CiyIa53nWvYA-1
X-Mimecast-MFC-AGG-ID: IjGBg7qOM1CiyIa53nWvYA_1783413928
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-493b54823bdso2767715e9.0
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 01:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783413928; x=1784018728; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WBby4NIaLLIhvVGMeDiSJrQP+NcVkO4R8rZDsmeFUN4=;
        b=J0HgxWNQLJWV+mZjOXeTL40iDG/jzr/B5sD8uh5A+FEIdIIK5si9fAWXP5/wTXqc3T
         jKmX4NvMHbg7faaMs1IzWSVIxU1rKMGC3pQ6aSA7RfG+eOXSB0a5WtrC14GMiFE/29AH
         X9CG5z+2wy/tt+j+wlmsJtglvD8/Il/Jak6MQoPu5vGhE4FNLkawWIpewO0BUuF6kB5K
         dXv9pMIJgqUC4eJenJpopiY2/FbCEhRHhOxKi++i+8ab4Ywq9lyyyT55NSVHaxR3ERNK
         lHhheWwVNtKsuEgSwsumcbetzY2Hzo62AH2w6aYYlNPT7R2+yAiLdg+NsZZqaCir/ODt
         iuRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783413928; x=1784018728;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WBby4NIaLLIhvVGMeDiSJrQP+NcVkO4R8rZDsmeFUN4=;
        b=ldTyAvrWXhy1i3em/Um+yKH8SdAvJxzdn5W1xi/7KXTv8XhkIEkHVsPzPRyRu3tzqu
         2dvIsFF3u7sri/lYTU4sPrB1gLO1ONF+An09KAXWap7DHoRDklW+cZK5I7VM2f6qu90F
         X2ZDNYTOhlI2ekVe5xBLpfGWvE0iIGz8SNB84qAlXyy4A2z/pWQXwH4msXFiuTifhHKd
         1MXppAviGtr3LNK6imeFD2Ax8Qku24n9CtFv1t5AGXXb83TYYJYHb/e7QNfgggmk8S3j
         U61KU3gVgttdnfsqFj7150JYlLubp4UIGHXYAhiL8/23t6oDArpR862R9F5M5Pg2/zlt
         f21g==
X-Gm-Message-State: AOJu0Yztoh+z8v32ZuBXUimWEl8Coh2FQRd16RJDZb4cQnhNFPwThquA
	swYz/g7vaDPc9CU4vRPQoRiQ437Nb+yiJ+bxNqffqWyshLWH99igsNmNGrPzIsokybuYhNV9332
	sPAg3HNNviAiUGF28iES4f3r5w4B0+SPRDDuO+0GlRuRtBtHcDO+6/IbJbA==
X-Gm-Gg: AfdE7cnn8JxsXypIoMJr8q9Pi+hveYN091Dgw3Ji7kaLAu51r48hAbeyLlwFGWRbuCc
	opmidzmL8RwnCjSK6NwLyGVNMBCfVSu98kMkPa3IYfyvcXhFbmVkioQt8Hh4YrPyIU/Y5LXCguv
	myVeN1xPxKRVils+rGEV8bxP05bYMCaN9BNADSuKK0+ybx+wr4pHPy7f3DzNmFt9A3YerGFiRt1
	q473hTHH9Npwzpf2OlJk3vvPjxhoXEEtvPjgXNTObTtYffpOmHdWJbG4cIJ40eRu9+43gabvOaj
	zlu0PxEvE8emM60pgMm967O0uZVN74JSFjX0/Q9/ny10aPE8cAsArFm+yLiFvdpU9AshmjpR1J1
	jxgyqFSpPP4AejHtiZYsE7TBbTtmbAG13ltYK2k361DNeZyx3Px9UqNWJcGMAweTcWgVaxvt+xY
	AejpeBJ1i2iJGS
X-Received: by 2002:a05:600c:3487:b0:493:c2ac:58f with SMTP id 5b1f17b1804b1-493e1011ea5mr18167315e9.8.1783413927767;
        Tue, 07 Jul 2026 01:45:27 -0700 (PDT)
X-Received: by 2002:a05:600c:3487:b0:493:c2ac:58f with SMTP id 5b1f17b1804b1-493e1011ea5mr18166965e9.8.1783413927358;
        Tue, 07 Jul 2026 01:45:27 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0f2186bsm31669370f8f.36.2026.07.07.01.45.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2026 01:45:26 -0700 (PDT)
Message-ID: <b110e40c-6a63-4490-8def-356471b5bda6@redhat.com>
Date: Tue, 7 Jul 2026 10:45:25 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/1] net: rnpgbe: fix mailbox endianness
To: Dong Yibo <dong100@mucse.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 vadim.fedorenko@linux.dev
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, yaojun@mucse.com
References: <20260701032208.1843156-1-dong100@mucse.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260701032208.1843156-1-dong100@mucse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/1/26 5:22 AM, Dong Yibo wrote:
> The rnpgbe mailbox exchanges data through 32-bit MMIO registers in
> little-endian wire format.  The original code had two problems:
> 
>  1. FW structs with __le16/__le32 fields were cast to (u32 *) before
>     reaching the transport, hiding the endian annotations from sparse.
> 
>  2. No cpu_to_le32()/le32_to_cpu() conversion was performed between
>     the CPU-endian MMIO values and the little-endian payload, causing
>     data corruption on big-endian systems.
> 
> v2 fixes this by introducing union wrappers around the FW structs
> and adding the missing byte-order conversions in the transport layer.
> All pointer casts on the mailbox data path are eliminated.
> 
> Changelog:
> v1 -> v2:
> - Remove all pointer casts on the mailbox data path.  Use union
>   wrappers (mbx_fw_cmd_req_u, mbx_fw_cmd_reply_u) that overlay
>   each FW struct with a __le32 dwords[] array.  Callers fill
>   named fields with cpu_to_le16/32() and pass dwords[] directly
>   to the transport — no casts needed.
> - Change transport signatures from u32 */void * to explicit
>   __le32 * so sparse can verify endian correctness.
> - Add comments in mucse_read_mbx_pf() and mucse_write_mbx_pf()
>   explaining why memcpy_toio() cannot replace the readl()/writel()
>   loop (the mailbox uses 32-bit MMIO registers, not byte-
>   addressable RAM).
> 
> links:
> ---
> v1: https://lore.kernel.org/netdev/20260617083531.251119-1-dong100@mucse.com/

A few process notes:
- this is 'net' material, I'm applying the patch there
- no needed for a cover letter for a one-patch series

/P

