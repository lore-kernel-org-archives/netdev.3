Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344403F1AC6
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 10:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787652054; cv=none; b=eTih2e+tF3p/Amplu7Xl623de5x6jJ3+cKzdfWvRVOVCnsFjTVp/41JjW89wL0eYFc6d15NvefbUVLODc8UEhSvbrzjwVvio1ctPxcrcm/vYY3sJDLPJrugCQwoqlIWebOZSLrrhYPNoqhR91byx2VfZbbbxSvKFNHt4AQmMai8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787652054; c=relaxed/simple;
	bh=MTeY5Wj2A537PcAl8w2zs34Vdv6IeLJI4cMm7fLYNhQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dIFlVOrqi5aIT7WQwc2TP9Y4OKtsE10yDxCRX9U40HsGSoNByF+SXyUxIBjaGQleDaaxYNY7u03+xyLptNl1cMWxm4QzRD3ScYFhQCQTvJ2aXelk8EJ0fp8rtbss14CCICvHnKc3jb8nasLOGX3Ggcxb+0UytiYG45mUHJs9zTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e9uHHK4t; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HnPAuatw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e9uHHK4t";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HnPAuatw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787652052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0NU7zn4NpIx/9n/bcxiTGmb+4zsi3/IUQL8xFBOWNFE=;
	b=e9uHHK4tpAUztde200jkMS+VvpfRn+CtRkbBUXD34ctBYIrdQrUGyGkojGLJpLSaFy/rOk
	47iHvAYcwA9709HfdstS4swZeTEnkznLuLxodsFqKDWU84PjTUxidOV0tczSXDDiqKJuPW
	dl45cVJe25Xzc7aGEpnnT57R2BLwHOc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-r2BrrbdwNJ2t-ggILZ7awA-1; Tue, 25 Aug 2026 06:00:50 -0400
X-MC-Unique: r2BrrbdwNJ2t-ggILZ7awA-1
X-Mimecast-MFC-AGG-ID: r2BrrbdwNJ2t-ggILZ7awA_1787652049
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c167e032f03so358279366b.1
        for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 03:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787652049; x=1788256849; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0NU7zn4NpIx/9n/bcxiTGmb+4zsi3/IUQL8xFBOWNFE=;
        b=HnPAuatw78phIBulEqiJKX+M2ZfFEiezwN6tmuQYu//Nc7M9ycufOypVAbsKHwHH0s
         jiXUnm3Rpmbh7n0bpFP8G9rtIax1axIxRh+dzxNG/2r4/UlI54Og3NyV/Mdcn304T14H
         bfiBBQuGduY9/ltImzPS6IhhFReufZtxkx6s9W3R2+vwVxwV6S9NFN3LZP1huSufwUbB
         BLgq2PXkwi331j/KHalp+7FCF+2dMkQLgvd9vnsbHd1HNuQMJlnSA0Tq+wfiyvrjbzTB
         rAAURdq3oa12YQJwyuGPLdaNbul4+qAo7Bqda9qpJACc4t9lrrMYcqOAte+5nc6N+4pj
         8zlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787652049; x=1788256849;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0NU7zn4NpIx/9n/bcxiTGmb+4zsi3/IUQL8xFBOWNFE=;
        b=g/j1MgE025Rvs8edmrdEAot6R3Wo8AkmdjiT0v6if6Al7GBw28+0uDpy4bP1u0E7LO
         /js501JsYcNGA/SQk1AfnPGQoa6H8yF6eFUc4Jnboryn11mU0Wxstya9XYZhLcWw4I9V
         KkkiAC8HwirfwcGFfJSYweVTXMNBrYtCYV6XZdUcXf6DVJqkPKFfO1VAtCrk6wQuw1NB
         0MZy+dzPXtrw3Pot4rzmXq0+opAufv3WWD0wIr5kVuaCSc5AuN6sBIrILyN46eIUg1IP
         N07i7SWYIv3w5+0EdmZ9+wdD2jPyBvEFUl8yoEFKUEjiJA+dm9vgACZ5e3TmwGBHgd0A
         aMJg==
X-Forwarded-Encrypted: i=1; AHgh+RoiZM75zzKkiJ1KXacjWkKMYuwjrQ1bWUk6NLG/JGbY7mGIp3xog8lOiUeb8omWvIa/w9QYTkw=@vger.kernel.org
X-Gm-Message-State: AFuF++lP08kumG1XdvrtnCi/5mCgjlimCXB5vSWbAsEoAEKrzXNlupph
	aErDzYp74/aJK8x0eLhuprqWaTzvN7N3XaTzDWA/AokQdbn9z8RHfevDii5MbBD04dahmV6Rt07
	EKAqN+NUeMBuCXTU4PZDr8FV77TyxFLlXeJvjfE3hcIBtUVSyff+zFft3zg==
X-Gm-Gg: AR+sD10s4SO4adC92Abb0PU2oUud0CMYnUC7buPD98VS7ocEQTE57zWwHQG2jucsc+6
	CZVpGPCNgVVY8jRxpFvIJjLPxcHu6TGH0QL5aFAv70Gp/b8orSvx5Dy+pz4UJsyVewxep3cr5OA
	jC5EnaDBm1ZyITYLsC4cyQW1lIl2gao7m7iXYgRqu97BPoLKeTf0LUHdLArr+xORVZYvK+N9G9b
	YNODHcjEg7956DJBtZLr9uCNIXviARRSZSsDgRIo1iK9MwTsYKcOAN7MEZNnLZgnQWeeiGVr6Kz
	4JGKk6PZKyAnmvQShQ3p4swVobbdaTA/Es3xyexE6QJyJLNnTJ8W3dogauTCuxf/gzl5+PHkDXz
	icQThx+fCeSZD2y3BQ/uczcnoCOTLB8xE9LfELhbV2zPuYyS03oUQQFDiGQYbu3HBbG+cV5VY
X-Received: by 2002:a17:907:72c3:b0:c20:2d38:e518 with SMTP id a640c23a62f3a-c249238c382mr2862369966b.2.1787652049117;
        Tue, 25 Aug 2026 03:00:49 -0700 (PDT)
X-Received: by 2002:a17:907:72c3:b0:c20:2d38:e518 with SMTP id a640c23a62f3a-c249238c382mr2862359166b.2.1787652048499;
        Tue, 25 Aug 2026 03:00:48 -0700 (PDT)
Received: from [192.168.188.103] (ip46-47-231-195.pool-bba.aruba.it. [195.231.47.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249606b683sm1842658666b.5.2026.08.25.03.00.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 03:00:46 -0700 (PDT)
Message-ID: <d595961e-0d7f-4fe8-a483-f2fb7ca7111a@redhat.com>
Date: Tue, 25 Aug 2026 12:00:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: mana: remove unreachable dead code in
 mana_bpf()
To: Muhammad Falak R Wani <falakreyaz@gmail.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <DKWZHHOFA1F3.1EL2DMFNGMP0Y@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <DKWZHHOFA1F3.1EL2DMFNGMP0Y@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/24/26 9:09 AM, Muhammad Falak R Wani wrote:
> mana_bpf() declares an uninitialized 'ret' and falls through to a
> trailing 'return ret;' after a switch statement whose every case
> (XDP_SETUP_PROG and default) already returns unconditionally. This
> statement is therefore unreachable dead code left over from an
> earlier refactor, and it would return an uninitialized value if it
> were ever reached.
> 
> Drop the unused variable and the unreachable return.
> 
> Signed-off-by: Muhammad Falak R Wani <falakreyaz@gmail.com>
## Form letter - net-next-closed

net-next pull request for v7.3 has already been merged, and therefore
the net-next tree is closed for new drivers, features, code refactoring
and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens after Aug 31st.

RFC patches sent for review only are obviously welcome at any time.

See:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer
pv-bot: closed



