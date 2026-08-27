Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CE938C2DE
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 09:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787822663; cv=none; b=OWr8fQsWK1nGTkrgC0B5bWSLgbpoumt7uQ4vjbaTO4nwlZdC364GtzhAwARLKCGrZ3LnFdAaAGClLI/29ujSV4PAC+Q+vLA/blJaz03Mz8r3I7hWbWl2CNqVU8oxNOPoxALpNhoydorIYUI/hn1HtFeLfj+C3vPVQLyJqK2v0c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787822663; c=relaxed/simple;
	bh=IBmJbkNMgFmJERJ6g19VWGy5ikQWL4gJgL/BugDgM9o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jB1kyw1DnhBOMKSbW3cebj1aItRLu04iwcphYeVQTeWPHp6buFhhMRwlaJAjDSvco3CsSLBYzmMnmQffKTFCVURvy1JggedCDVVXbX/cV5TBnqoxAioJmh4Hr6VkePi7E3+MuxJwdB1oiswmQey4FLgwK3TxFp82T5kMb5Pkky4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AuxNqK5F; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BpZnXpJL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AuxNqK5F";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BpZnXpJL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787822661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eEQmWu5OysgJ1XpUoXvqWdsuSXoKhoFsPybLWRrXnE4=;
	b=AuxNqK5FkKbSv/IYksK154ycVULgnTs7wkkxTAT0QUeN7gtAvzu9MdZOIieKLuqGveKFKT
	WocgXSxPmm5h/o86hyxwSDvT6G6oAicETnKv9jP423rMQQ8R4/P1AvG3SLixeTR1a1hcnd
	QR0FyWM8nLYx/cd7293yJPhwtoWTaLg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-By13qXD3NZOjGk5sjrPqqg-1; Thu, 27 Aug 2026 05:24:17 -0400
X-MC-Unique: By13qXD3NZOjGk5sjrPqqg-1
X-Mimecast-MFC-AGG-ID: By13qXD3NZOjGk5sjrPqqg_1787822657
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-482db84a6eeso402364f8f.3
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 02:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787822656; x=1788427456; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eEQmWu5OysgJ1XpUoXvqWdsuSXoKhoFsPybLWRrXnE4=;
        b=BpZnXpJL+7owmRyj7jP+hAs4klPbaahJGCeOBfJS9tgmUtA0LhVG3QSqmb/qyhP9h+
         Wg+kVuNH6J2DP2Q8z2eVH/xCH7Yqz2Ov3R0S46EkJkarUrxcDOQULFPQV73nEDQHuAhR
         OERjgMiMLYVJ6YVswjEsQ0BCNe4vY1zCovXgzUXMy93lmmp8BevxR6Z9erGOPmszxQlD
         c7ts4BsF1jlygo5EmO9e8jXclaq2DXLwU+2AjeEEjVhLbyjiIovcT2qXieCAlhZWqibp
         6TCPk2bwLh0LIl4fI3nuR0+hRg+0brJuM49jacT30hWiodZ33ih5FHdrzMn3xVTY08vw
         5hvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787822656; x=1788427456;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eEQmWu5OysgJ1XpUoXvqWdsuSXoKhoFsPybLWRrXnE4=;
        b=VDC+KdSrvSUEhR0iRb5CTd4V77n1EL86l1g7T5lI27U+A6b5GrPDaWGe77hsJRCt8M
         CxSM36b10omevcnABvo7KhXjengXypIfJyMDD2Y14trsp/tFPXgRrZ0i/NzGj6gdIQB7
         B/eyiAf9AVopbKLpGD/oPxS3Ryxv4xVc4W+anTNiwwgefrSkseYN4umHvCZ7tPLN2lgM
         93gqJaXR0iaUmhNZ8PEQ+YbFSeTx4x6xZSerVtA/l3HDVuE+zLbYCBWoFSio7Nl/Xlvd
         c2Ycvjg8blK3Xgt4toz9eotW67b68yW0kG8ka7BpMZQ868+JMnr2pRDyB3JKST2nUtiu
         oMCg==
X-Forwarded-Encrypted: i=1; AHgh+Ro8ca5UmKKSVuYRO68P9ZD6YoDF09FBqhTlTLVp31+LVmDwZ2Y2wJT1E3cTik+SViXvUiKvD2g=@vger.kernel.org
X-Gm-Message-State: AFuF++lRTYOel8I+XKrotiQeBd6AAZr7xp2nF7+rsZAFk1Y5gRo2EZCQ
	oMid2drlGTuaYUs/aVQp/XF7svaiv6rkZ9jx53Hx303X9o4sedlzW0I6fV1A+N1Su16Szu4+DJA
	MIWCtPnp4GVT2t9zL0oUXTsZIvSOfErGTiFZEaI7UiOVWOb6l5zBiMszbvA==
X-Gm-Gg: AR+sD13mgab7u3x/uvUTSWOx9hAns/uHni2wHtX0BU0DSOGvRODZng8xuk9lXoRfl40
	iI0tMBE2lTxMyqM1leUbUUr9d8HqXxOgD2TsDZsee0GefQsjOpVJc+gX2Ki5w5T6TDYH5fyxaf9
	saqAOTeOCWNqIygih2dsX6DkMnpd/kvEVQi3ciJtCsUaCoaIoy42mz0dRoCcWhrzentid1oF2xz
	DeGa11yuTvBKHQFLT/UTuCvjvk2uKO8eOp+aqBdHr/5LipR/ydO5bvHtaaS0JBqdAzD16SfNC4b
	7eym7I9QyqNTXYPFPpJFvanFmFy4vUVczwKo4oOMDyueLr1p2TWTvldYkj7GDiTGECtsuUjAY2n
	7tuWl+6zlXZaqt3gKwj8hGJxarNTHyABd7DjMUcE7ByMESQKTUeI+LofqLdkAiwL+zlXMIqg=
X-Received: by 2002:a5d:4cc9:0:b0:482:a9d7:7ced with SMTP id ffacd0b85a97d-482e26f2d68mr14712758f8f.14.1787822656466;
        Thu, 27 Aug 2026 02:24:16 -0700 (PDT)
X-Received: by 2002:a5d:4cc9:0:b0:482:a9d7:7ced with SMTP id ffacd0b85a97d-482e26f2d68mr14712674f8f.14.1787822656045;
        Thu, 27 Aug 2026 02:24:16 -0700 (PDT)
Received: from [192.168.188.103] (ip46-47-231-195.pool-bba.aruba.it. [195.231.47.46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482e28dbe1dsm8097951f8f.22.2026.08.27.02.24.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2026 02:24:14 -0700 (PDT)
Message-ID: <76fed437-dbd6-4d5f-bfbd-2c00fb745013@redhat.com>
Date: Thu, 27 Aug 2026 11:24:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 4/4] net/sched: act_mirred: account for
 TCA_MIRRED_BLOCKID in get_fill_size
To: Victor Nogueira <victor@mojatatu.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, jhs@mojatatu.com, jiri@resnulli.us
Cc: horms@kernel.org, baowen.zheng@corigine.com, louis.peens@corigine.com,
 pctammela@mojatatu.com, netdev@vger.kernel.org
References: <20260824153903.4143642-1-victor@mojatatu.com>
 <20260824153903.4143642-5-victor@mojatatu.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260824153903.4143642-5-victor@mojatatu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/24/26 5:39 PM, Victor Nogueira wrote:
> tcf_mirred_get_fill_size() only budgets TCA_MIRRED_PARMS, but
> tcf_mirred_dump() also emits TCA_MIRRED_BLOCKID whenever the action was
> created with a block instead of a device. So tcf_mirred_get_fill_size is
> missing 8 bytes in its accounting.
> 
> Fix this issue by accounting for TCA_MIRRED_BLOCKID unconditionally:
> it costs 8 bytes for device-mirred actions and avoids having to read
> tcfm_blockid outside tcf_lock, where a concurrent replace could change
> it between sizing and dumping.
> 
> Note: Dumping mirred with blocks currently works in most use cases, but
> would break in some corner cases, for example, if there are 20 blockcast
> mirred actions in one request, each with a non-ANY hw_stats and a
> non-zero user flag, with a listener on RTNLGRP_TC (or NLM_F_ECHO):
> 
> budget 180 B/action -> attr_size = 20*180 + 24 = 3624
>                     -> alloc_skb(3776) = 3776, tailroom exactly 3776
> emitted 196 B/action -> 20*196 + 24 = 3944 > 3776
>                      -> tca_get_fill() fails

Sashiko also noted that the above should not be reachable in practice on
top of the previous patches. If so, would it make sense to divert this
patch to net-next with a slightly different changelog (and no fixes tag)?

I think the first 3 patches are good as is (i.e. I agree with no need
for accounting in patch 2/4, ATM).

/P

