Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792504802;
	b=ZBv1Thm7BFW1qY4HVGzTkjxaYzj/rMxKpjLVoBvFMtWL03se6dj5fE54Qn6LWtFf8G7J
	 C8x33vI2KHBdUuV9gMiFB1xvBv+VdUd3IotAWou1cG+YbnuD6PE/54JwzUmnMAhsZwoag
	 GoPiMfteKOzl7raWPBgzvIpCq+sAQfSE0zg8S91SKfKMQOF79AF24L4M0Ck4VEZUNUS2P
	 BaNBQirf3Ytn2XNr3z5vypu0cSc7feaccpivNhmldT0HHjf+eFYSQDMN5BX333p8z22uI
	 zioGvC84dZMcIUFakv0MyvxpStafyZCZRkOpVdSJwOMXoB17ZoTw+d5gUOa4th0MpZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792504802;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=9ykT13PSVdEhkpSDogty+KQ6PO4mrXSOM4DldWxwlI4=;
	b=1nrE89OMpVPP1r/RaQjI/qNyh276QqcCXXdYWJ9poYYIHMKBI7tnrl/vyE6dI5YJ8FIJ
	 wV6v/NQjE5BwWsSDpX4tWGEeo2zUxnFQMLtnrVg8PKZr/QEBpD4OC7Ct8mdwdWnsfo3f8
	 yBJ0slTv/mmLtAeiHLVj9OfTrmjtTm1yru7gUgMRdXq8bYNDPG8QpN/AMH4AfIs1UEtCW
	 XLOKlSq23Ik3Bx+6vi5kuScynYWL+K+fJhihMZ/3tvgEhWoGqe0WVIqWeRgeveS04mOpj
	 eY4wiOtZ/VjxXa+1WQfiak5AgVVwZqY0WOtQa2h79p+sJI4OpDqb7DgeFCzRG0DjsWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=d9vYlLx1;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=mR8JAM6D;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A63606A31D
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 14:00:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3A63606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=d9vYlLx1;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=mR8JAM6D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792504800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9ykT13PSVdEhkpSDogty+KQ6PO4mrXSOM4DldWxwlI4=;
	b=d9vYlLx1uJfQpOLx3cae9BhEjSKAJrEJ9RcFJlRlYz7g8vr790qjfZnywlZeZQ2dMEad8P
	tt7XZUJ2cdZejWWgQLSlU1l+t9Vd11OUucNjVU82OllWk3l46WmpafYZ//6bdbMCmJabSS
	cSrvGpCL/r4LWoX5pb2aFyWO4uuKAPk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-jftO1_IcMy2I2UD7V_Bxyw-1; Tue, 20 Oct 2026 13:59:59 +0000
X-MC-Unique: jftO1_IcMy2I2UD7V_Bxyw-1
X-Mimecast-MFC-AGG-ID: jftO1_IcMy2I2UD7V_Bxyw_1792504798
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a1de9dac94so21903645e9.2
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 06:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792504798; x=1793109598; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9ykT13PSVdEhkpSDogty+KQ6PO4mrXSOM4DldWxwlI4=;
        b=mR8JAM6Dx+SPWbfkeZnOuGFetgjlmDjbH+LFq7jAyJiAKciZVgzTSeI6Ngc+/YyH0P
         mCirkApaIVqwGqDQdP2i06rvMK5Lzpo/0kN8K5u1fw/RGJHTSQa9GjEofK8nUNDMiR+8
         R2Gb3eriJjl0yEV0gN6e3mnMU+2KU+03pZhqTDSW0iKY45Tof4QGCbXBCBmRfrOJGxN3
         SDa1e9D2dcwGvBSzSTbmKB6Y7A/s8AxccXVSNLU6bh6lQ/ZgeRH3t3pU4xR5+F4KqSna
         74f949/TZbz4xCOso7OpWx31lR91CKkQO8Scbt1MpT8t8+oiHGy/upa3vJ7adtQbFopZ
         7D9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792504798; x=1793109598;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9ykT13PSVdEhkpSDogty+KQ6PO4mrXSOM4DldWxwlI4=;
        b=m8xSZdVpvnBGupwUe/nf23r4UOIspyBgkoUx4PS/MtT4PeSlQ7pR+cF4GpsjKjB0ch
         VxtPkgj9hXIPPDMEcMH/GDm28LzdL8GvrV7i0Bet6L1eBYONRaofJC2SHn53pK7MQ8Ad
         rgpRs1+mWrtlEesI269d0FiDaWD+hjNlA6KJ5n4em7E94XuvXkDmjwVMzmFlEo+0Ahzh
         rmZRWHbeapAXXmLHXGGAXQRpkfyk9Gty7ooihzZNDFoU5HDrWngGxwvarVMihal3cjgF
         JB5RBrOeHMLlqdUJxlnuEuZpK5vxwfgNd/1sNs824ScYE6bpB7NysXaWOyoSv70RYMmF
         3fYQ==
X-Forwarded-Encrypted: i=1; AKwUvBy8PYp5HLOLw5FXy7ylI942h2VCq7NlxCMi7+tT003rvciZoWhTp+yERqfr8ZyR1qkJ+IW16jI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKdwhBcQGJaE7O+3iKFW9tLsv0Uti3fxvMNkHBhoBsZeiu+KX9Y
	cqU0Znwlmcv6Ii6TW1ajHeVQy3qxmQZzZLR7Wq+gp2oHcG5R0lQ5qj87m8lWjgBbioTE8nWniPy
	YRUUnKIMsisrzLnBeM/wvO8x4qf858AnP4umUbLAl6uuhrMn2DNYeOpzT/w==
X-Gm-Gg: AYBFou1rKDwP1Y6Rvaq8+2RBbc7Y1I1hrKhjkl6vM3llE4EE0rCrxEM4/bB267kocZ0
	wGSg9ODOUNAuUMZzHO1zNlgbhUYd5Fp8D4CrvQXuF2QMbkwT1HQYOZ/TNssH4hwI5GVg0yZ8VkV
	iRsH8usJO2EWUoQj43PCTeYK3t6xBFFFU9J0ZygTk+83ooM3zwqMRanfHXrverP4uuq/rXIXxw+
	18AegIv2rYmCXXKd9hYgcSSo7yWeOota3DjBva3R0kXnhwkqUkYeB61PYPB/JelYDVPZxbIr+m2
	87YWSVCRO8GUR5+rsElaeArKtjxYBQWmkTjG3+FaSS7ol2oxXV/cCMbMgR+olIPgmgGXL3g73Jw
	eo53ELW6hyeHH+4dSsewHsnlspmQxjevTwUS7MafKL3+jzoQKoL0EDR/ao4APeyWLbphuSPsTmA
	==
X-Received: by 2002:a05:600c:4e14:b0:4a1:d307:b526 with SMTP id 5b1f17b1804b1-4a1d7464034mr234316785e9.0.1792504798231;
        Tue, 20 Oct 2026 06:59:58 -0700 (PDT)
X-Received: by 2002:a05:600c:4e14:b0:4a1:d307:b526 with SMTP id 5b1f17b1804b1-4a1d7464034mr234316075e9.0.1792504797756;
        Tue, 20 Oct 2026 06:59:57 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2d85a9bsm82778815e9.15.2026.10.20.06.59.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 06:59:57 -0700 (PDT)
Message-ID: <106b3ab1-77e2-4656-a124-7f78ad890ee7@redhat.com>
Date: Tue, 20 Oct 2026 15:59:55 +0200
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

