Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793109132;
	b=n9LMemse+1ITECswP/ZrQdzVdLGMcs/hBlnyDazV5lEm7Q5PY0/pWj+5iNSX3ILImh5g
	 s1FqYTfT8tEMgDxfLY4dpPml2Ly6MmBL/AYyQr4mFvLDuTeDKhQ2gOQ7ly5yxdBM5V/is
	 YicNXGGADhQcZEDA2LOHq38TBOFF2skOxkWzn3+vsni+DapXAJnVoKFQpWMXlukNAPglK
	 jah4Qu34i9LvWlOna5rc+DanWt/IRXqbALytAwzRCh6/CfekuQJZ+hSVWFsYdXDjK+yln
	 w0ooCe1ikX/kOH+qME4mHdQOtiZP/1hE+qFWx3nVS/j5oQZwh2fl/62Yo09kwUaBkug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793109132;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:In-Reply-To:References:Date:
	 Message-ID:User-Agent:MIME-Version:Content-Type;
	bh=8jEi5qIpG8gQOI7FRIQQ0chgu6dVk016vQfFaDNaGlE=;
	b=ZOfi1pM6x6LxNwCv9VzLaRBBl1v5dWwvwQNAk6TOjHZjBougn8AA38DDmTo1+DwaheiL
	 Gz0qmOjeRnBCb38FxsiBli3FOgH8v00q9nLW4B4/005x0RzVem5rL4AvP27WRrdIzoTSU
	 uzKLtFQtl8UO3ZfZ+u71Yat2iI80SRQea29CLAbDQlvDKr3tYJqkEJJLNvYP4phFCmgEz
	 eBv9v+oT222G2DRGCjEskkuULffKVcdfbNabT3Q20wusw8actvW5nq6ihdpcKj88mP3GT
	 ZNA6NmHYtLrgUbcq3NPFtDGmHekjO6J4mDE3cpUtjF4adB5VQlj/yxsLdbRyAUw12yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FCoGJED4;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=sRfE7G1o;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27117606A31A
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 13:52:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27117606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FCoGJED4;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=sRfE7G1o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793109131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8jEi5qIpG8gQOI7FRIQQ0chgu6dVk016vQfFaDNaGlE=;
	b=FCoGJED4GSvNcPCbL+EkM4UxWvBsO9HyB/F6A48DVd4jKUftYCPxzFbDu2G8ddIhBnAQXA
	Run4yOdJNmL9QQ+r9MaQoggsRY+azRnKp+B7l7spLWSW243jFzsq9OrvQU/FrZDFA55TRu
	UZYEYaXGytsg8qG2TSxy+GM/D9ABHiI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-BekXw6ESNj2ZB6tcj7JXlw-1; Tue, 27 Oct 2026 09:52:03 -0400
X-MC-Unique: BekXw6ESNj2ZB6tcj7JXlw-1
X-Mimecast-MFC-AGG-ID: BekXw6ESNj2ZB6tcj7JXlw_1793109122
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a4af69e06fso19149515e9.2
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 06:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793109122; x=1793713922; darn=vger.kernel.org;
        h=content-type:mime-version:user-agent:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8jEi5qIpG8gQOI7FRIQQ0chgu6dVk016vQfFaDNaGlE=;
        b=sRfE7G1obD0lIC8yU1g01oaWx/P9t+0jkOBjjaqEA9oKrrvB4HlMrwJrpACkBgxoOo
         oNF4QAR+INPc6ztxJyh3Ms4oLjs8tBOX5+HJRvhYNosKQmeKimDf41ley5aSirn/du47
         iI222EQ2HnymkyrFKhBJB026RCcyJ6hmMKdWhyZ1W/Z6GvkIUr8yOsp56GA/COj9wXI0
         UIYgL5kNhuAWGLt2sYO8BHVQqvaagjdoVg7ckRzj6/bVlZJ9G7Ye5Pp/nLazSAPFDOU+
         fAGhWGMrarLwtSBQ6KmqqGimOpQoBdzbRKwlTQq+ewjv3rlbPcogDiM7jOw0BCRphK02
         5kcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793109122; x=1793713922;
        h=content-type:mime-version:user-agent:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=8jEi5qIpG8gQOI7FRIQQ0chgu6dVk016vQfFaDNaGlE=;
        b=w+yWeQTvUPqFaKXpMKzeZlMsEqd4v+tESVZWBrtRwDLIguBiTcjp1riBr2EiaxDVkn
         dfmGrFjF89uer0hc7jRwV8UxdvLHksj0Cv6TethqTDRvGWIHUNPWFrw+qqWA9ElWGfLd
         0L5BokqMX/j8hnRu+f6cIhA+zcmnvPQfbVRy0WcnEq8AvW46Uv+J3t7iUG6f0i0QBI3O
         mxSpCHSVCv4Lhby2NWye7twkaNiJp3wKegkBW2LZCP0PN8vTZ3OmEgmn77xPoR3ES4+O
         gpnrey25O272KPwDotsXe/6quKlRqBPkPgvFhK/PkPzOGduAJLFA2EBKdNKf4Tse2+2L
         yrPg==
X-Forwarded-Encrypted: i=1; AKwUvBzaN04zcmEgHdVcO2I7/oyQ5kqMQlLKVsiFmM4SdyGbYNqZWW5D7lYDssD9cO9LRyuWSbfwMHY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLmxQVmbyWSRfzN6WkDGJfel01sQsfU6AnTEPSZNa0H2ej5GrC6
	9YcO71/3079Hj2r7PWOfs6ZR9ct48iJQGRt9BwhkRm52uVEv/AxyNCgyC7GYIBYXVERUeXKuwf+
	o+9hbTg+M0vl6FFCXsSgDsRc9VcN3gtjQXfP0Ko3wWJ3DIdzixDdNsVG5Og==
X-Gm-Gg: AYBFou3R+aMVvdPimDrH4/Cd73pahGTFzaYaNMV4rYJeW2GAujL/M1Xhtkq61pylX72
	ECG3dgW3giWwKvPt83v7ZNvG1NJ+ZXSe9AZgbv7v7ibvCPCnwFDR9bFgo28aWnyeqg7c/iwBKts
	3Oh1vt8B5tyFWfptKbj1PqMtX9PhCIfxbqroUUxLDoNezMXFYou76QY4xwdLwxXKyxBVk9oMFpy
	1gEZAa3ThcfuJ5oZKTQ1HGbf9aYpdM8xRuVAmNHk5fjT19Z0KGEj7elcoaGbgoz5t6cN7r2lf/G
	3tmEPAInpWrdSyiD7Lk16NOwYaBbVgLcEj+OD0TIEsMJtMlRjxU7lleRR0d9R7KxLU4aUvE3nb/
	/7oK+gMp8UPvyUTyVEvstyJgGvOw3nw==
X-Received: by 2002:a05:600c:6095:b0:49f:e701:51c8 with SMTP id 5b1f17b1804b1-4a35ac7f0d2mr170105155e9.9.1793109122508;
        Tue, 27 Oct 2026 06:52:02 -0700 (PDT)
X-Received: by 2002:a05:600c:6095:b0:49f:e701:51c8 with SMTP id 5b1f17b1804b1-4a35ac7f0d2mr170104585e9.9.1793109122028;
        Tue, 27 Oct 2026 06:52:02 -0700 (PDT)
Received: from aconole-thinkpadt14gen4.rmtusnh.csb ([216.212.39.190])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e4115f496sm21923362f8f.5.2026.10.27.06.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 06:52:01 -0700 (PDT)
From: Aaron Conole <aconole@redhat.com>
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,  Jakub Kicinski
 <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Willem de Bruijn
 <willemb@google.com>,  Simon Horman <horms@kernel.org>,
  netdev@vger.kernel.org,  Andrew Lunn <andrew+netdev@lunn.ch>,  Eelco
 Chaudron <echaudro@redhat.com>,  Ilya Maximets <i.maximets@ovn.org>,
  Jamal Hadi Salim <jhs@mojatatu.com>,  Jiri Pirko <jiri@resnulli.us>,
  dev@openvswitch.org,  Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
  Ren Wei <weir@nebusec.ai>
Subject: Re: [PATCH net 1/5] net: add eth_type_trans_careful()
In-Reply-To: <20261027082604.1485903-2-edumazet@kernel.org> (Eric Dumazet's
	message of "Tue, 27 Oct 2026 09:26:00 +0100")
References: <20261027082604.1485903-1-edumazet@kernel.org>
	<20261027082604.1485903-2-edumazet@kernel.org>
Date: Tue, 27 Oct 2026 09:51:58 -0400
Message-ID: <f7t33trs135.fsf@aconole-thinkpadt14gen4.rmtusnh.csb>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Eric Dumazet <edumazet@kernel.org> writes:

> eth_type_trans() assumes ETH_HLEN bytes are present in skb->head.
> NIC drivers always provide this, and they should keep using the fast
> version.
>
> Devices looping skbs from their transmit path back to their receive
> path get skbs built by the stack instead. Their link-layer header
> might have been popped by tc actions (act_vlan pop_eth, act_ife decode)
> or OVS actions (pop_eth + pop_mpls / pop_nsh), leaving fewer than
> ETH_HLEN bytes in the linear part. eth_type_trans() then hits
> the BUG() in __skb_pull().
>
> Add eth_type_trans_careful(), which first pulls the Ethernet header,
> and returns a drop reason on failure, so that the few devices exposed
> to this can drop such packets.
>
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>
> ---

Reviewed-by: Aaron Conole <aconole@redhat.com>

