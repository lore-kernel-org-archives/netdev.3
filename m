Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F62D346798
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 14:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783693356; cv=none; b=dLz/NHv/V5jh4PHfDTmuAlmaGjmiuoMPlJM0LKfjHG7h/50JXHGoqjzmnRyLmrxzxbrYcnNFlAVbAYCkUb6UDWc8fZUIjnOp5c0UnsHkH1eW9JHH9QhXifCsb4BcMCeEFnfhMC/CByMYNRZ4zAha5MI5Ly1YuunFj+8zrUB0AGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783693356; c=relaxed/simple;
	bh=gBCTx+v8nVlOXzCjoApsdEsJlk5c3j/eok+W8ISLSzI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=IE4h+vawxbygiT6zF/2+zew+WHkbECB6Tw/1UDimTz/HCn5cF/cVyJQK26KtAR0cStuDjg/0b2ydsbaWaEllB98CxNtr9FrWZYEOG/yidFSvipKFUzICvQULEdWPYjMh9zPwi6Otg+00E3yd4JfzgcNPlF6Chm30/2q/TPG/oiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F/TFb6CO; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=OKAnnI+T; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F/TFb6CO";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="OKAnnI+T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783693354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QIIxrKRaN5mITQXo7eTV15HV7psrG1dEO0p/YVFCHNA=;
	b=F/TFb6COuRJnto8kUAPDZVIcKjWUG1vETxRVwU2O3dT7V/FT9LSZmRno0/yAPJQxXzKAAt
	gFf1PDgMtincS53BECtERCfO0wtGuUGU5mCHUqHwAOPxMGntuYHORaLDlsHJEEw+FuDr9e
	N7r2TQtqdi2gTJ7plI4px6q4lXHgYJ0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-fbvXfHAsNS-grRInVTqnvg-1; Fri, 10 Jul 2026 10:22:32 -0400
X-MC-Unique: fbvXfHAsNS-grRInVTqnvg-1
X-Mimecast-MFC-AGG-ID: fbvXfHAsNS-grRInVTqnvg_1783693351
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-475b0b4e8d5so966796f8f.1
        for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 07:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783693351; x=1784298151; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QIIxrKRaN5mITQXo7eTV15HV7psrG1dEO0p/YVFCHNA=;
        b=OKAnnI+TsWY2YjAzrqTqQXH9P1rAjfaXGlxMzt7LPkYM1N1R+qd4uyfQLxyDVaWaS0
         HWsUQ0ASsa+j1olJaXiuyHmXiu1isxhGNy9aSc+yCmbpwr2pOV6lsQeoeCP4KC+IQEbd
         lKjaa9VbYebXvBgTr2b2R7rbimdG+Y1N2cOnWQDcDkfWtIicl2//RhT4+Zh5MNTUDKBu
         1+uycrxEg571q+Ajoe8+JV860d3F4VBX37ZOPB6ZvAG8mTE8UpRF1JreM5U0eHObvt7i
         C1hWQ/JhbAUuQgJd6xPncnd8vtOb/JU2DZ3t6f8h9rQQaGnF2cXYi+2WGVwtJUiHTRFO
         2YxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783693351; x=1784298151;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QIIxrKRaN5mITQXo7eTV15HV7psrG1dEO0p/YVFCHNA=;
        b=RR+BM4X0roK8yTpcGyXQTCNqZh/shTKfVDLj/vXiHTU/SvDN4PIi1QHqcViBkzJW94
         HWH29J7c3+qwip7uw8IJKKjisLZTbmC+j124fgwyqjPhZNqKOAeN9s4Q9WSqxFwEJSe9
         yrcwFoZH339uDu7WyP518CFEqb5t3WTOtTpdI1h5yBbBlGBF1zNREDSUT4jXLVJ33FOt
         hY4Vfa762zMVujO0WIY1a/b5IwuPa02glGI9XsdGo43ee9Jn7YnHsqxvP5gtLmtfX+er
         7qa4uLNB335XP1NbXnDACba8GiquMU1Lmisg8/2/dYnkCXUV/wnNgO57ScVHyQwtVI95
         jKkw==
X-Forwarded-Encrypted: i=1; AHgh+RoFBFSakTbrW54tbztguwKMfC3kwsgjUxT3rd1pBukK5KUyffuRlezhYyRzqO3lLqvxgc1TUps=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy48T4orGjsgN4M1kECB92dHlRTa5sPJ1/MlTOnOxbmt0of3H00
	OYO+DAL5uyl5qFjpORqPkSiWFc9kO4fOK9YOBFd2lidHxHFiwFguz2cFQieUhQoeY8t2GcsLxiT
	B6pwb8QOXL6VoyYVTNyfttOvTxc+igHaa64tS+/sVrcY5OVx4SXZDsF2VaQ==
X-Gm-Gg: AfdE7clGpfOYuNmejJyi89hlZyHKC/iK8N3fTx5ozA6NDIMKkDoejUBkFkZ/QoZIW6r
	C2deO+yPe+r5tQsxKZgOcwLJFiieqt1Dmg4TTv0c0VZwHFZ7qMM1IvOT4iQNqP4tpIeKAzlvHnD
	Mby2kr2ynsh43C7Tv6nMoniPzkLvH0W+H582nJpQE7I43htqKDKtakL/j22J05ben0yEp/Nr5hD
	RVcsWn0QKJdpakeBJh6ECxcVm2cCXlUsdn8Tj7hPb6bxiLY1U5JbzEY7Cbhofpgxw0GUA8nvHuu
	+nIw4PO6wC3QX1U1Qlrlb2j8v84x4Uv2cidl0TDalb8TyaJzILx/KtupWeTnuiOVIjNl+8zCJBx
	e0vM0L6M4gO2H7DnrdRTh90vQPu6Wct9KUt0KD3GvvPsxT4Hg9Qu1DnEHP3ax7LXQWT8NIjDaq4
	EnM98zqE6XrD+P
X-Received: by 2002:a05:6000:1787:b0:475:f100:35f3 with SMTP id ffacd0b85a97d-47df076c9bcmr13840157f8f.48.1783693351112;
        Fri, 10 Jul 2026 07:22:31 -0700 (PDT)
X-Received: by 2002:a05:6000:1787:b0:475:f100:35f3 with SMTP id ffacd0b85a97d-47df076c9bcmr13840125f8f.48.1783693350667;
        Fri, 10 Jul 2026 07:22:30 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa039bcdasm63073100f8f.21.2026.07.10.07.22.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2026 07:22:30 -0700 (PDT)
Message-ID: <e806a628-3710-4bab-bbae-b6dffe3513e1@redhat.com>
Date: Fri, 10 Jul 2026 16:22:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/3] vxlan: RCU protect vxlan_config and enable
 RTNL-less fill_info
From: Paolo Abeni <pabeni@redhat.com>
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 Ido Schimmel <idosch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20260708160411.1355008-1-edumazet@google.com>
 <991ec032-c6fe-4236-be22-323a9e3cb07e@redhat.com>
Content-Language: en-US
In-Reply-To: <991ec032-c6fe-4236-be22-323a9e3cb07e@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/10/26 4:20 PM, Paolo Abeni wrote:
> On 7/8/26 6:04 PM, Eric Dumazet wrote:
>> This patch series converts VXLAN configuration (`struct vxlan_config`)
>> to be RCU-protected, allowing lockless readers and enabling RTNL-less
>> `vxlan_fill_info()` netlink link info dumping.
>>
>> Work has been split into three distinct parts:
>>
>> 1. Refactor helper functions in RX, TX, MDB, VNIFILTER, and OVS paths to
>>    accept a `const struct vxlan_config *cfg` pointer (or pass specific
>>    fields such as `flags`/`saddr_family`) rather than accessing
>>    `vxlan->cfg` directly.
>>
>> 2. Convert `vxlan->cfg` from an embedded struct into an RCU-protected
>>    pointer (`struct vxlan_config __rcu *cfg`), dynamically allocated on
>>    device creation or changelink, and freed via `kfree_rcu()`. Update
>>    offload drivers (`mlxsw`) and OVS (`vport-vxlan.c`) accordingly.
>>
>> 3. Update `vxlan_fill_info()` to run under `rcu_read_lock()` instead of
>>    relying on RTNL lock, completing the transition to lockless link info
>>    dumping for VXLAN devices.
>
> I *suspect* this is triggering RCU splat in forwarding self-tests:
> 
> [ 1955.481960][T11074] =============================
oops, sashiko already spotted it:

https://sashiko.dev/#/patchset/20260708160411.1355008-1-edumazet%40google.com

/P

