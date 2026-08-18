Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3904647ACF6
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 18:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787076581; cv=none; b=CBQL7SW1c33JRIqLfvENtbPtjkxVN/YJeCuqsqD3B7iPPmrpcyN4OxYROe/whWZasMm/1NEbSbmBCMLrGRZY5B9vumdjWWLTuKMxcBXE8AorHp+OV7TJHhBTv0rxBO2SULW60SPCD2F2hN/pktoepspJJ6FLHyMlWd5SlRvMfm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787076581; c=relaxed/simple;
	bh=fePiLZS/g3Bx8H0TLNR7mUgRZEZ8yYZVNkO8Y+/pq6Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qGkSZovRVBkAOkOdj6jW7WF/sQRgvKHqy4ax35+uQnIHZ4do/PRuTODFHCct7JULTg6w6lHzmeXwK+TuQ6H/GSDGkGPlpx4ISAk9T8bJfLvHkdNHpIG5OFkUqUSDlnkMjNFSfrE0tTF65RFIRh1J1hDrDG1jbl+9NWdT23qo8u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NJRB3tIj; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VL/MF7uh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NJRB3tIj";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="VL/MF7uh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787076579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UbMG91XJkSDOVCgcf8S4eiNN3mjMzoFKvd3Nk1kKRdI=;
	b=NJRB3tIjOv3arqAR/rEPeYsYcEWHnGslaoXDqyqdtIZcSYu6y5eb3BfYl6vQAoK7qSRbjz
	PkBRlqenBKmJw6ZMg64JqwIJIvefVBHdMJAMWep7ck/eh6z1MH1CDB2avT+F5H9AKLxJjw
	4t+Sx5zT6ciUESdUJvjA+wNhe1XdO0A=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-cIDYcN2zOl-O-n1KLlfbYw-1; Tue, 18 Aug 2026 14:09:37 -0400
X-MC-Unique: cIDYcN2zOl-O-n1KLlfbYw-1
X-Mimecast-MFC-AGG-ID: cIDYcN2zOl-O-n1KLlfbYw_1787076576
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47fe23b5acdso78488f8f.0
        for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 11:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787076576; x=1787681376; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UbMG91XJkSDOVCgcf8S4eiNN3mjMzoFKvd3Nk1kKRdI=;
        b=VL/MF7uhJohrENXEmMvutZCA3fLN0Z81WDGMZ6qbL0+WT7FPZGzNsKY7QqBSpJU4RR
         HHmRmoucnN7lO2GfaXrH548ve9bV30gpRQfc68x8PGyqJn/zQcZGiMPbEKQPZENf4Clt
         NvG9rDYuXINQqjS1JN1TVIMTg4ka/QDnrGbGavh/qViubilKgxOp7LA4R1bdeL/ZRbbS
         A8eElxf4JcOIP+QGn+2F10q/PQOvv38jkoqYkkXzY6GhyQl2ZQH2w9yRH9s6iUQvGBy6
         jBfdnsUGYZKtyPjj1nxU6I098slCW5Md0+Gr+WPFTZ5qTAHCTNNGN1FKTyzb1FJ36eTo
         DSFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787076576; x=1787681376;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UbMG91XJkSDOVCgcf8S4eiNN3mjMzoFKvd3Nk1kKRdI=;
        b=YCrzLbtK/CuEdmksm7Rw7yQst0EI9foUmedC0sM/Zm/6NQ8Ues6ZvR0Ot8MLvNA6pQ
         0hxREEHWlrQ4k/lN3odJ3if7C0eSWU/wFiU0t+6LD5WS61wc9P4b6kL4vRFPPwXbm7/n
         Br42E6TbfuTfKFFNQy/iJe2K6DNrjiYS1o6oXP44h8W9c7INiYMdPK9COEaMHBn3zCy/
         5ZhA+KTgKiJMNtjJtu6dzvss74uuZqnWeBbtNU86SPQ1ZHuLoSYNwa9JjDPA9Cylnd3F
         Hvv+mxIco6EG3xQtD4mcnxHmJ9kFWxxpv7+lYoMZmH3Fl5fmcB2iYRe/GKhsxME6aAbo
         9wdw==
X-Gm-Message-State: AOJu0Ywti5UMyr2kCy1tG3HejfDyLi09mwaYVVFP8YKXbTOKpXdHGO+5
	fHfHzlHP3cfDDOKwF9PXkzqZCMWt+kZ6+ElSqGWt0Qai0vIjgkMBhkntNvop+b4oqqDY66Rejzj
	yzLmQFhLUE0Mnu4KNkJXN+tkXST4GUlvOQAl5gPLf6rLVLhFOLK7zc1Pmpg==
X-Gm-Gg: AR+sD11V234p1KcgBA/QJ8KQpXd+XLxQTdnSUoqhTqM3GIg0xykBC1hbuI6hcMZQhHV
	dbL4qcnccN7v7Oyw5486Afig7Z6U7ZW8nX0BWXvgM+1eQ+4nj1vvGbF2O0rPZXjcH/NSfOThCKV
	7HQDKYMS6UBNxOYsSyOFPDKzvpcdBKKuy5Lo282pHcKeJ5S6w64a6XBFZndZP31v10XnG4ECguu
	HQemcI75pBmkw3JQVw4fUPBH0QsSjofW0XPzsf5ampMvLPvdz0sVBqwBZgR9q2m9kUdE1qoUuIe
	BnWkNsFhXRJywykG82K+CJ8lOobebvPxk+5jx4JhKUyGbWBCBNxmEmyQQ8dmwomG9qwtm8B4cLX
	Vb2GednF/WWL5/KNQo6QN+OIQ
X-Received: by 2002:a05:6000:29cc:b0:47f:773f:2d68 with SMTP id ffacd0b85a97d-48160738c19mr44990100f8f.16.1787076576474;
        Tue, 18 Aug 2026 11:09:36 -0700 (PDT)
X-Received: by 2002:a05:6000:29cc:b0:47f:773f:2d68 with SMTP id ffacd0b85a97d-48160738c19mr44990028f8f.16.1787076576088;
        Tue, 18 Aug 2026 11:09:36 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5a7c603sm14758633f8f.21.2026.08.18.11.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 11:09:35 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 57C3591AE2A; Tue, 18 Aug 2026 20:09:34 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>, Jiayuan Chen
 <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, Kenneth Lee <kennethbwlee@snu.ac.kr>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev
 <sdf@fomichev.me>, Kuniyuki Iwashima <kuniyu@google.com>, Hangbin Liu
 <liuhangbin@gmail.com>, Krishna Kumar <krikku@gmail.com>, Martin Karsten
 <mkarsten@uwaterloo.ca>, Martin Willi <martin@strongswan.org>,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next] net: xdp: don't assume an Ethernet header in
 generic XDP
In-Reply-To: <d9c3234b-99ac-430c-ab62-9b1412af3461@intel.com>
References: <20260813113229.381136-1-jiayuan.chen@linux.dev>
 <d9c3234b-99ac-430c-ab62-9b1412af3461@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 18 Aug 2026 20:09:34 +0200
Message-ID: <875x179u75.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alexander Lobakin <aleksander.lobakin@intel.com> writes:

> From: Jiayuan Chen <jiayuan.chen@linux.dev>
> Date: Thu, 13 Aug 2026 19:32:24 +0800
>
>> Kenneth Lee reported a bug [1]:
>> 
>>   skb_vlan_push got skb with skb->data not at mac header (offset 14)
>>   WARNING: net/core/skbuff.c:6474 at skb_vlan_push+0x5ec/0x8a0
>>    ____bpf_skb_vlan_push net/core/filter.c:3239 [inline]
>>    bpf_skb_vlan_push+0x216/0x8b0 net/core/filter.c:3229
>>    bpf_prog_run_data_pointers+0x17c/0x240 include/linux/filter.h:917
>>    tcf_bpf_act+0x31c/0x940 net/sched/act_bpf.c:50
>>    tcf_action_exec+0x2c1/0x720 net/sched/act_api.c:1147
>>    tcf_classify+0x6e4/0x1080 net/sched/cls_api.c:1860
>>    tc_run+0x31c/0x5d0 net/core/dev.c:4411
>>    sch_handle_ingress net/core/dev.c:4486 [inline]
>>    __netif_receive_skb_core+0x141b/0x2ec0 net/core/dev.c:6054
>> 
>> bpf_prog_run_generic_xdp() just assumes xdp->data is an Ethernet header:
> Most XDP programs expect Ethernet header at the beginning of a frame.
> Unless you write a custom one which doesn't.
> But then you may face that XDP_TX, XDP_REDIRECT won't work properly --
> cpumap Rx, each .ndo_xdp_xmit() implementation -- all expect Ethernet
> header at the beginning.

Yeah, I don't think we should start messing with the "XDP is Ethernet
only" assumption at this point...

-Toke

