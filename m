Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0EA39021C
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 07:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784878469; cv=none; b=GcUsNSCqjYDnIKy0GhFxy4WiKEGnXLawcYzKElb48/FNLF1vqy7QJptm2Gudvq7MBO3l+vgckt2ChBekPzl2k7Mvr8TnrGZsQwNxyDWXalojsWJcnJoLGU7SiadnsWH1fPx8b0grBnYO3KHBOe0s5K9N5ue0y6ijW5DY8c6bFBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784878469; c=relaxed/simple;
	bh=vXpRSWi/oVCMquWL7cTrWQgG+Q6PVnMDhgoEilSgEXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TDWHnVAfLb3ArmSzqn4LmdxHgZUIODAxxPKhmQ8o62c0GNlXWQ3dtgBTLU0+HRRs2yANpbkqpG24hsq+f3KI62UL9w+2WomhHV9cBE+8rjEKDKXROIorzKjiuPG7ENtbozfGzkNtv9EwVjzmcMbvkzJBt62XKlx2MgnKQjFp6D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dn83Ve3r; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dn83Ve3r"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cedda2ce6fso1222785ad.1
        for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 00:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784878467; x=1785483267; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3LzKJmUsJl3t+t7LREmJa3ZK6twh8h3ZLCQyYGIQu7w=;
        b=Dn83Ve3r97W4wC0W+r41vBC/v9UQgyUnxNOU0JchMsc7G9ahtILugIzT8PHus6syKf
         OqWH7Kx0tnNNyhslbXfFyBPcLXG6TmGduyX7a2qDp3gdEW89jtuxRI/RWQ64dLH6OjPY
         h4G45Sgs973/xlhJIPN1zro/fc2qjOm9X//l67w0YU/Rwvyq4Y8Stg2QX1tuVAvAV3D8
         Xytzc/2nNlQvUkbMFeAKmdC2ivIMXbWOMIZl05QncGbb5fANX1SyBBwW4tIF0tloqqZU
         3UIijQ6Xyg4XNNYfQSIzo3EoWolZqbnpI8JNbWAcIdB/DarK165o4XxykQEu9/WaNYJr
         J7MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784878467; x=1785483267;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3LzKJmUsJl3t+t7LREmJa3ZK6twh8h3ZLCQyYGIQu7w=;
        b=RF2pZSHK7FMAiP8xs2dAmbZ3ZrXHkH18R+Y58RfkFA84g/UL6/AZjf3oLbYnjNYKX6
         c1PCaZ0Sgd1FVU4iRVlGmC54qEoGRK5+x+wiv4oP2CYaUHY7q+Cia4qIEnRIM3ZnkJ19
         A64FnG6M9OgLxOgiUgz2KRq8jumd9agkOOmFN3zFXaGeJ2TSW99RLhyjoEwR90A485Mx
         tyNWgWxxbSXtz+OMwWwv8n7tf6vXBE+qUaDmXFkc7afB7GEXwM/L/yzi3aRlW41SVd+3
         k5LfAM/TBS2zN2Guo1EpE0Q1iISOPvZBPQS7hzqAz2+JhW8Qm/8Jzask8kfb47j2Iv4D
         3hRQ==
X-Forwarded-Encrypted: i=1; AHgh+RpJXO4SrXJfK43k0QOdFmWkcieQUD1ZjfLsDF2bzSo4Tq2GgZZi+tO4D0gsBGMUn1BWcJt06rE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy82F4lOtVi003uDH4Z5Fgfz6epryGsV/AeiRHnTt8PhLgrJ3nG
	ULHEtaMi3ytmgiiZlN/YajJhJAbZZk9EpVEwOnoEuPwqDKf/Rb4hg/O1
X-Gm-Gg: AR+sD11GGd8bE2fLO10DZlnbW6htfQK2ZVAnvveW+ZpG/1/pqh4+adrUaFjVYEgHs+X
	gMS68alxNW5mg0lx1ucz+sny3AdDUptFa1w7UOh7hPgwFtH+HN0mLrADBTI1qxC5fhLDBM4U/Zo
	DlGmG6xg1hQRoaVw/kGbu7DbzaxZhBss05PQVQoOGmAoGcJP55BLz8zakqNAsgUFEzGAPAPfzzI
	hb9p/U5d52KJrvuwLB6gWBy4F7s3DpOTisYoZ01fuJSrgAhSMRtImGzzNvWqV3nwTzT7jk+Bh8F
	YLyGNs4mfVHg8UmMCse0quuf3gy5R75yv/SnaW/Ddj4Xt7DW4Gct4PnbawR8pthId0KLc0pc8Yo
	pDYi9XxBzYGJ18Ro1ocaw3JoyDsoET5N/u2pZD+WHjM0BgG0aqS2OFuCgDdmm91ZxaxGKbtewsI
	UvnKT+/0vaX5FjUvukDpE=
X-Received: by 2002:a17:903:468e:b0:2c9:fbde:ab66 with SMTP id d9443c01a7336-2cfa6c72079mr71784215ad.37.1784878467184;
        Fri, 24 Jul 2026 00:34:27 -0700 (PDT)
Received: from [10.22.76.22] ([111.223.92.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8efa39ddsm46944805ad.17.2026.07.24.00.34.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2026 00:34:26 -0700 (PDT)
Message-ID: <6b684c2f-1f98-43ea-84c9-9b6f162d5e9f@gmail.com>
Date: Fri, 24 Jul 2026 15:34:23 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vsock: use sock_error() to consume sk_err after connect
 timeout
Content-Language: en-GB
To: Michal Luczaj <mhal@rbox.co>, Stefano Garzarella <sgarzare@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260719220103.684489-1-phind.uet@gmail.com>
 <al3UuvBhfxp82krV@sgarzare-redhat>
 <78225425-1ca7-45fb-85cb-9e04f489e68f@gmail.com>
 <amB15TdzPAEk9A9C@sgarzare-redhat>
 <b81bfea4-6b19-4cc8-95c0-dcd4ad42476e@gmail.com>
 <95cd0d4e-58c9-44ab-b94f-fcf57b88583b@rbox.co>
 <amHN9mOGj7oMak4-@sgarzare-redhat>
 <27412e44-ab4b-4dd3-9685-481875683860@gmail.com>
 <a6cb1b8f-d8cf-412a-a204-3a26e4db0bd0@rbox.co>
From: "Nguyen Dinh Phi [SG]" <phind.uet@gmail.com>
In-Reply-To: <a6cb1b8f-d8cf-412a-a204-3a26e4db0bd0@rbox.co>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/7/26 05:43, Michal Luczaj wrote:
> On 7/23/26 12:26, Nguyen Dinh Phi [SG] wrote:
>>>>>> ...
>>>>>> Yeah, we need to handle that part better, I think it's a leftover when
>>>>>> we generalized AF_VSOCK to support more transport than vmci.
>>>>
>>>> Speaking of leftovers, I have trouble understanding where does vsock set
>>>> sk_err on listener sockets anyway. If it doesn't, why vsock_accept()
>>>> checks for it?
>>>
>>> I can't also see where it can be set TBH. Should we remove it ?
>>
>> I couldn't find it for listener side too.
> 
> Removing sk_err handling from vsock_accept() solves the problem, right?
> 
> thanks,
> Michal

Yes, confirmed, removing sk_err checks from vsock_accept() does solve 
the problem.

Thanks,
Phi
