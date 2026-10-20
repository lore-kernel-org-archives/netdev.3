Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792505152;
	b=OQoPPg77/tO+HPHvPhegsLtMkDTC52LCgVYNRy+xxLeKBdOQvIp3VEWnmlbYoAjLmKlG
	 X/ZXGv5zCB9l3GG+74tiQyj1r8CdOTLKpwj+LJ0kACqMJzHC9+q3iDA20uAE+i4S9Zub4
	 50hYfa9X0j+6mBoz4ZDrQ+xsBCDfTfvQtge7MQ9bOTv+6k9Qzlm71mUgP70Bm/pc8egng
	 O9NAeRrAiVDxWEK6Gy/xUSvtQLpii6jAhtF2y1cuZLYaZ9t8ChTBWcp7wfVYwofJQFPBz
	 JzCcCa7qtZCHZV8gfF4hCqyvvHMckSk6f3E9tiNobOU0e5eSZcOLfi6xXMqVKu0Mozg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792505152;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=9ykT13PSVdEhkpSDogty+KQ6PO4mrXSOM4DldWxwlI4=;
	b=E+8lbPOojQrwRIN+M1HJ4IYOm/jhErD5635whQUtsuHkNxXoITZ9AH0w8OMrmu8Oy//A
	 BhDDT2CIK46jWzixhi+odTiRtcygHbvJLj5p+0kw+CAntpp1bTvOiv18Mg0D/nr8dMChl
	 7xqBNbuUWwB/RDZY3hp0JnZWHngISA7oXGpwQADbHSRYThwaZ6Kr2i2K8H3PqHGlVuquA
	 qvtUc5OS2UsMrcvf6ijxXs9SUHQB7qvrUoZOPeTyGPaBH+HFgHGjmWn3nKqWKloU73hzT
	 uIb54fw4d4HJyruHz+OeQ0ahigDLNLKLq6OhmoDOu2S2957PWkWRJfjbWvreEcAU9Iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="a4VjQ2/S";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=BVuZOrII;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079DB60A262E
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 14:05:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 079DB60A262E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=a4VjQ2/S;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=BVuZOrII
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792505151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9ykT13PSVdEhkpSDogty+KQ6PO4mrXSOM4DldWxwlI4=;
	b=a4VjQ2/SEoLm/waMt1N3lK+NFYorg3OLkXl0cXlxPjYXHWXTTnj3Awg0l9HS7XeeC7zKHp
	OBHBQ54rzkkgrp4tU6wx8cOaMXT2SiZRWgCRS46XGxjXxzHBjKiKWGolHW6DqLd47qRgwd
	FPHD6qZCFAYIoQcIkMVdpALQ5oeYcOM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-j0ngIGFOOuqGehqSuOgB-A-1; Tue, 20 Oct 2026 14:05:44 +0000
X-MC-Unique: j0ngIGFOOuqGehqSuOgB-A-1
X-Mimecast-MFC-AGG-ID: j0ngIGFOOuqGehqSuOgB-A_1792505143
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a16faefac0so20070445e9.0
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 07:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792505143; x=1793109943; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9ykT13PSVdEhkpSDogty+KQ6PO4mrXSOM4DldWxwlI4=;
        b=BVuZOrIIRZeNQ7/dQ54GjubARN7Ii/zM6ccftk6Numa1K1g6WTAo2y6KApvG1+TA+b
         VhM6V+oduSJOVU3pQR5H11182ZJL2rPOGYmVpySDisop50RXbEJsCHiNPpmQ1SroM5Y/
         mpCwq+y8luRBaJ5FSwRoHQp8jqg9BUEgWiFAl8l0WRKdpzKALRRP3CMHsWatOHJU2aXm
         inV6qDJwsbNK0pFpnFblyXeiBvUpIknGMLOp9DpWZq7qsG165txoBQnfx4pNgFygcrr4
         Hh+8sedn03eXfvIc56XssmAttSBjVd7lz7fddPOyn2223/Ep8xbANcj5l7vdLbKquic7
         FqXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792505143; x=1793109943;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9ykT13PSVdEhkpSDogty+KQ6PO4mrXSOM4DldWxwlI4=;
        b=C5rv7m35FtR0Nf3djVKpsN2dec9u6XErgB/v7RZi43PhtMhPi0kimeQpjsan17HhxL
         YB+8h0IfIE7xlHmTfeekfYqN15SFDlMRf8amtY6dxp3Dfgu5OJ2Gy+/kI9tR8HXpj44E
         JWy9aQ9oAhYS+tr/vrSZfWJmsOTCymy0cAzDEhk3Cv5KZtilnfbqgAymYAKQ1UdriFoc
         R/gWBzbzHMqGsmxGNvEbcFO4I4V2/bFvwn7RNzF72lJRhU5sRcdLPo0d5g59myXfddQN
         4WLvZuVePDV2nhViHDpGGQtvl8Dk6rdLMTtLR7gL1wqrxOziI/JkPlP0+umQicMWAHRa
         BY5g==
X-Forwarded-Encrypted: i=1; AKwUvBwyyRBSLq3nc34MXwYIB7Oa/mi4C7MrrLR7zDG+vgiUmDGCKwqhaqHzEnqMNq0fuMWEiTFJr1g=@vger.kernel.org
X-Gm-Message-State: AFq9FYL51aEOMYkhmb48QHYyrrIp+1JM3LH7GhcM0torn9Ev+lfp8Ph+
	jgb4zXWq1P8KOyPj3H65TrcvcBJruvrKCdkrPxvu8zHVUvqB/BDIvG+xcDFbAP2dLw0nv1u0XQL
	QdTxuiNHcbhXOMb7JMAGIfU6cj3M5GHTR6svrT46CeEZPBNWRBXCsjjJ7Bg==
X-Gm-Gg: AYBFou0kZUWllk56cqmZ2ZmV0n0861Rffv1HBRdbrDTPBCtDN0hR6z1RhJb8/HGq2Zv
	HoXYWLuQt6m+rpZ3Acsxl/3ne5SRGo4mpgQnZIeTLQtMu9vXgc7gmf8wFkuwzjqxfoRjvsmplZr
	rlj8E1jRPY+Cjfq6AFbzayKLCb0YBbZLDgTl3UPkdloYd9zLjnUEpG5wZRjhwhtQYyWeeIhEwV4
	uOZ2u97NfkTUWr/QIT3oWz0B/pPxgyFExz7Rs8uRhCrjsBLqvJWBrUn7rqnDZgQR3K/IZKy+qXY
	+tLBcKQc5Jdb/SGxEsJU36zNoCKLj74bwNzBaEMeumZw6W4oURe1W59jTbvY+vxXlenIVUBR055
	XsfGvUwFf23b5/xhXpmdte73KBP8fI1D9toLo+cLeV+9qS6OGrZduX8E5OmmrsIYn2MAU9eddGA
	==
X-Received: by 2002:a05:600c:3f0e:b0:4a1:fa33:441a with SMTP id 5b1f17b1804b1-4a1fa33452cmr18514525e9.2.1792505142695;
        Tue, 20 Oct 2026 07:05:42 -0700 (PDT)
X-Received: by 2002:a05:600c:3f0e:b0:4a1:fa33:441a with SMTP id 5b1f17b1804b1-4a1fa33452cmr18513575e9.2.1792505142147;
        Tue, 20 Oct 2026 07:05:42 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2d43242sm69875765e9.9.2026.10.20.07.05.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 07:05:41 -0700 (PDT)
Message-ID: <7ceef2dc-717c-44f5-9974-1ed8f0440fa3@redhat.com>
Date: Tue, 20 Oct 2026 16:05:39 +0200
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
Subject: Re: [PATCH net-next v3 0/7] ipv4,ipv6: convert the getsockopt
 switches to sockopt_t
To: Ido Schimmel <idosch@nvidia.com>, Breno Leitao <leitao@debian.org>
Cc: David Ahern <dsahern@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Shuah Khan <shuah@kernel.org>,
 Eric Dumazet <edumazet@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, david.laight.linux@gmail.com,
 kernel-team@meta.com
References: <20261015-sockopt_expand_out_v2-v3-0-7d05ef2df448@debian.org>
 <20261019081907.GA2725184@shredder>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261019081907.GA2725184@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/19/26 10:19, Ido Schimmel wrote:
> On Thu, Oct 15, 2026 at 03:05:29AM -0700, Breno Leitao wrote:
>> This series continues the migration to sockopt_t, as described in [1].
>> do_ip_getsockopt() and do_ipv6_getsockopt() still take a sockptr_t pair,
>> and everything they forward to now takes a sockopt_t, so convert them
>> both.
> 
> Acked-by: Ido Schimmel <idosch@nvidia.com>
> 
> Given the user visible changes, the fact that the merge window is now
> open and that this isn't the last part of the conversion, my preference
> would be for this to be re-posted after the merge window.

I agree on the above, also clashiko noted that patch 7 lacks an additional

CONFIG_IP_MULTICAST=y

/P

