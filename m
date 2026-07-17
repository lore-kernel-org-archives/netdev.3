Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2363E5ED8
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 09:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784281662; cv=none; b=AFh9vtx8cDL6vBSDjZNl3RfUMBUmrWQGjBex0rAjO5jUriKugbKsMTPl2QX3dhuVFPTyePRtk/o7Sv8Ag8XB76ILD9JYdl3v56jq0utgz5bEPLgKBj1oTfRR37JU4RVWITYbSxHUqO4RFEoyMeS1pwuntn7cvq9M6MnV8M+ziPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784281662; c=relaxed/simple;
	bh=SA1xMJwP+nvYyGy44ETv4g2iY2c92GT627gCU7j/mvk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sEPiRV5piRDyr7gH99HFqDHaY3pRGNAGKujzpMLKewTxxbRtNQPRgnjWUHBr89VNDE4gGOfOFTiNStR10ZPH0Rc9TRAQHQ3JoZSw8IvyW7gMvivrW2PgwjMnxAbQlXPsFWo7ddIVeRYkXSTawpPgp5ztXoajjGM7Gxs2mTgsgeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hBqgEUcp; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gKnsNsKm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hBqgEUcp";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gKnsNsKm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784281660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9UfOzvi3ApW9raJzhRo6rILl0ALfG4yRcSmV5u5K+uI=;
	b=hBqgEUcpKCZ5rMwNdrkb92WoqVH8LOYHOuIkLfBScLVAoYXAZx38iR5JcL5dRU+CHPMcrt
	WBokR7x3NVmaxKJEaGoGJeIa3FSvxPKT0hghSkEBPtahrLD/b+hHmz+qhw/eVWX4X1a1hU
	Ta78pO3tfrCoXyPx+UhG7FCw0Isx6U0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-zMBPqdmoO0G753hn3zr_XQ-1; Fri, 17 Jul 2026 05:47:38 -0400
X-MC-Unique: zMBPqdmoO0G753hn3zr_XQ-1
X-Mimecast-MFC-AGG-ID: zMBPqdmoO0G753hn3zr_XQ_1784281657
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4729d2a64efso817227f8f.0
        for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 02:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784281657; x=1784886457; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9UfOzvi3ApW9raJzhRo6rILl0ALfG4yRcSmV5u5K+uI=;
        b=gKnsNsKmO8YiELvI0BG/ImVNbBOrmDufJS9/5FRjbXySv0wjDQ4aMBFwiR2Mpd1sWo
         cLEGcz3frJiiRDdZNaLKxfdKPZpGNgzWPA9JzM//GvmbAxHNWA0h3Gj/4TidAYtIPE0g
         gChwzINrQJVkpA+UYXwbgN0t/pVIUOv31Bq+lFT2ncBgTqclvU0+5VKWMujWHbTLr0rl
         NTaVSz2PcH92T2Ma9s3uDfXDCI2eWlFpaIcmvFVNjjxkI3SlGZL673KrDqmdzGxsiqPB
         twsXPRHsgjNOd6APHC/mIAVlOOVHj1CrJkTZSegUAKItps0vwZV8wiJ/Qw3lTIWyAiuf
         3OMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784281657; x=1784886457;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9UfOzvi3ApW9raJzhRo6rILl0ALfG4yRcSmV5u5K+uI=;
        b=OMQHiwWqUIEF2IiiSUzKNLFFjnh2iQwENhr7kdowVQt+mCDBYhVxtCAYntk+QJV4+2
         qv76ENBA3GGjYpA9E2/6oR5lG4GGpAm+ckmMddLzkICIrj+GhwHyci97z4kB+w4uNmcc
         I1PYRJPHfOBP1aRYzaX/CK4nKinkP9+q4Jla1I6d3Or9AFTYvVoH3TBMB/4g+5UPxLLO
         lw3Qkut/T5SLaIKQ/guj159S8nO+XUy2gm8zDKoMGgVVn9vM4G8R4a6GJ8AVSCIoMB9I
         h+7yI35reftBF2VMgtjEp177KfUCQFTzkKMGkoF/JcjkO0jig9YmE3Al03B/FLqibdxk
         0nmQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrio0QAPeEGWPg9E7DuUDex0x21w5gIImx2fBuJDhkJAXPT1YaVex7ak8tAfjDBRkYilr28Mgw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvb6mExJeHxgN/ivuhPwgrGsJqz4YZOmSQiFlWeQQczbmRFBab
	AdoWcqo8rqSI7THxHhwaD01odRITBO34zoHQdh6uf5L1O2V60geKiJ9ZfYPSolPgRwm8tqumnco
	SfWZB9281CFIY6tBUi/V4XaTlSINLZ2h12aOErugIJtkVlmwsezhC7sdshQ==
X-Gm-Gg: AfdE7cnhzNlCjG7uK3c3wK6t2Lp4XSvdZzLkBqTHRaSg41IP5sZXLCBHaMx9fHAxP0M
	J3rrVd7F+sv2c/bXwbmys/huJjvDlhSLqYzDP2188vaMqlqMd6ur9TB5lGm/AxkvQsDrYbotUZU
	0NHyWnZn82slR6287USQnh+ln17bpcOor/6PGhGbraJvTTUzkTeUVAHVqtA0O5RxNnlCSu5sbVa
	dlbQNHJExrEmSiQWc0KPwoaYhj4sPgxI+grwFfNRPCsaXUTmbajCcfW4f2sAyd9l3Mu2Q9MEnqK
	8akmnKGu/WclCefMOf224qvBnsoicxZ7spc43g70IkGumhqa2BqnGEvyOgoQ3Vtfcgz9LyKaX24
	vhpKYm0w8XMGgA6y4RIw+J9Rg4c7KYHZa0gawFfcaHQ6kcMzuipejfuzLDM6oHEYitlD2l6tCQM
	ubBA==
X-Received: by 2002:a05:600c:35d1:b0:495:3a52:71b1 with SMTP id 5b1f17b1804b1-4954aa1a34fmr16279005e9.5.1784281655579;
        Fri, 17 Jul 2026 02:47:35 -0700 (PDT)
X-Received: by 2002:a05:600c:35d1:b0:495:3a52:71b1 with SMTP id 5b1f17b1804b1-4954aa1a34fmr16278655e9.5.1784281655105;
        Fri, 17 Jul 2026 02:47:35 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2edbe4sm35888375e9.12.2026.07.17.02.47.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2026 02:47:34 -0700 (PDT)
Message-ID: <62b9c471-e6a0-472b-a549-81128cb9a8ac@redhat.com>
Date: Fri, 17 Jul 2026 11:47:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net/mlx5: free mlx5_st_idx_data on final dealloc
To: Leon Romanovsky <leon@kernel.org>
Cc: Zhiping Zhang <zhipingz@meta.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Saeed Mahameed Michael <saeedm@nvidia.com>, Tariq Toukan
 <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Michael Guralnik <michaelgur@nvidia.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260702222507.1234467-1-zhipingz@meta.com>
 <9e4e455b-c10b-447e-9fe6-80672f26fd8a@redhat.com>
 <20260713080816.GA327832@unreal>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260713080816.GA327832@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/13/26 10:08 AM, Leon Romanovsky wrote:
> On Fri, Jul 10, 2026 at 01:25:45PM +0200, Paolo Abeni wrote:
>> On 7/3/26 12:24 AM, Zhiping Zhang wrote:
>>> Workloads that repeatedly allocate and release mkeys carrying TPH
>>> steering-tag hints (e.g. churning RDMA MRs) leak one
>>> struct mlx5_st_idx_data per cycle; kmemleak flags it as unreferenced
>>> and the kmalloc slab grows over time.
>>>
>>> When the last reference to an ST table entry is dropped,
>>> mlx5_st_dealloc_index() removed the entry from idx_xa but the backing
>>> mlx5_st_idx_data allocation was never freed.
>>>
>>> Free idx_data after the xa_erase() so the lifetime of the bookkeeping
>>> struct matches the lifetime of the ST entry it tracks.
>>>
>>> Cc: stable@vger.kernel.org
>>> Fixes: 888a7776f4fb ("net/mlx5: Add support for device steering tag")
>>> Reviewed-by: Michael Gur <michaelgur@nvidia.com>
>>> Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
>> @Leon, @Saeed, @Tariq: just in case this fell under the radar, it's
>> waiting for your ack.
> 
> Tariq and I completed this on Jul 5 and Jul 6.
> 
> https://lore.kernel.org/linux-rdma/20260705141920.GI15188@unreal/
> https://lore.kernel.org/linux-rdma/0bb37f75-c94a-4a10-b115-186b71daf14f@nvidia.com/
Thank you for pointing out and for the review. PW lost track of it,
likely because there are multiple copies of the same patch/revision and
only one of them landed on the netdev ML.

Applying right now.

/P

