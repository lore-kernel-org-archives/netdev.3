Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.134
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792519107;
	b=0fiR8xufjIy2suKhtM0eU4+q/moQm/0r0B77fOE86KKXogsQRxvvbIyy3uRVSMKRrmRg
	 DGdL8ItVvsQKGmvb8AZ0Ark28TOkbla6J5rmKglRYGzReMY8ijATL9kXM8Ka9C6DhovGB
	 XJbWRln8FunrU//lURHuWhm+OjhxvCAXmLkxhVfaXL3gWIwjcuFx5leS2iKd99fdo+Pkk
	 NkXN/NhTfk2YehC5DafHlB4u+9VR57WvQFAzsuUWrSfi4uj/FOAMJDchIcYIEoPDITDko
	 Z+8RL+fu0Ivi9N3/xDFihsBU/HFtJBRLgI/IGtmzP+uZ51HEGX1lVvWRBjdwkUM3uuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792519107;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=lfvzxumMX8GZYmj1PJHBaPnkGMwtjZCWGV30UbLz0Q0=;
	b=RDKA7Tjgod767taMZKYOu62522wOnrOST/+eEwlMutDcJn2ikBcl+FTBJYrLWZJ9fqVr
	 BrYQr3SQJNP5WIH9qnhxw1bXNKALYXaszpZEp3HiGkQAQAS6woe8Md7kZzl1+BY2ouXv4
	 SRK/R1y0sGFWkIVBysBkKZyk4Q6gSFGLo+m/o+xVSowfnld69hhpOzWWdW2yKC4t0dLMo
	 53iEiRQRv6hwk3EJBH+lt7+rgb7uWHLiaczM5Vray8VIDjZVranU3WrbBhNzOJfYsvB9F
	 wRXBbaA/7wIqDeW4IhO+D4ZXXWIiun5z9JVd3F8j8VkPGFER951suuRjbVQS8gzfpOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="hk7DKm8/";
	arc=none smtp.remote-ip=74.125.227.134
Received: from mail-pj2-f6.google.com (mail-pj2-f6.google.com [74.125.227.134])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBBC606A31E
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 17:58:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6CBBC606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hk7DKm8/
Received: by mail-pj2-f6.google.com with SMTP id 98e67ed59e1d1-3ad211ad92bso798473a91.1
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 10:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792519102; x=1793123902; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lfvzxumMX8GZYmj1PJHBaPnkGMwtjZCWGV30UbLz0Q0=;
        b=hk7DKm8/HVQtDM7SfuNCgwbY6d9oYkVDTzKvh3xFFVJcjWgeTit4nQ3APKC6JcXMvs
         5b1sQ076nR/cD60jiZzZnASVUl2A1IZZGCAtZTv89HFO9xMKTFkmD6zhLqjP8L3wg7YT
         EZ+XvNHUBXYD7s1wo8gn6iYgnI1fN0liSodgV4PIsesSa9bemHyZzT4hLir3wzeKGmpn
         2cfYdmBPyJQrErJTZ2N9KyeYzowC/aQbw4VYo0vWXFp7rwMFbz2ltIGvlLTQQcEQD2Dv
         OdgjfMkoZTll+JU+ZxsujBTKAj8fDZLFfw03WYAg+wLvoNDOd2pzWmEdC15h4Plr2owA
         0SZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792519102; x=1793123902;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lfvzxumMX8GZYmj1PJHBaPnkGMwtjZCWGV30UbLz0Q0=;
        b=UJ2PiGp7TRDt5g+22tI3vlBTRV5Cx7A0W+IANvF6uJBGxrs7Nzd4PlJbZGRkX9GxWk
         ZsfxqbGPC7ZEvC0vY3LQ4Etp9YyyL2R65T8LwqGjpqaaXBBlIvuASaC7cbKLicI4b1ul
         lscrMRw+NP/danfAsO4+VmACDwh2XuCQxCfnNkugtDa1aKV6WGSZBa+UJF+qZo9j2u1w
         h61DIZCm2kfVaJrZBtDmxumzLAWcFh5UPQx9hiD5KPBg76BIIZixXmecDVF8GhSMdacw
         uRKSs4qN3T1p8+DgGO+zV9PUNPdDfvJyLcoCECr0d774kE4VsT3KQAfoKWSM/+nFr5jy
         nQTQ==
X-Forwarded-Encrypted: i=1; AKwUvBzBMYn4XZJheEcGq+/Ykp1Ccuy8iVqr1BwBJdjVXcYjME3Fx2i/BpDgq+qLkY1J5BZ8RFKapB4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJb4xvQGS1KLzO/ZSZGRAPVVwgp1aK4iAKFTco6EG3oV/iuTzTX
	3cPF6XNBKfFw0Buch12le3l45DVk6HocoAlZejpLesRcfQWDSZHwYrZZ
X-Gm-Gg: AYBFou1i6uzhmirJISOdMjI5jrp/Fi7S2QsLbqIMH9EJjiizf1Fs5XGJ4sZZY0VLDwa
	Baifhd5OlQPUnCUx+dfkvklgo4TrHUprPj0Fh/PhC2B3OVZY/fZWyMNDxQjUTljgQOtmR6+wf5I
	sH7K5ORekY0xm8VzG+A5XVqHOlPYAjLqj1d/MPGYoJabVT3obF+hrsdNa2m2PGSyrA+UQ20zftn
	eAf7b8/pApW0aCgIjhlexIQMkxh5eXJiBRZTlxOISNU0cPUl2+UABJYSCqgbeZ7ebRRW9TDBmbO
	549p7AWcQgU+gzq2VrgNVLQOf2aZ4kEHRPnHXjYt4VeFrD2irfBempUNe7l5RfyTXhTpLnNv7ny
	a9KpMOXu6w8B7s3DUFsmArTv4u+DoqMjd0w3vOzHmczAGbWB3WWmypgoPW4D/0XeVPJhz101GGe
	NCrsFwIt+wSX69GDTxW7xAq61HHzn9ZoQ8n613nOJMndMnO6+UBY+B4/BF1V1WvMSamdhbvVSHh
	kOvW+kgsNu+l1V1jbT2YG8DDZk/HPtycS1Ec7582GyAKGpy
X-Received: by 2002:a17:90b:4b09:b0:3ab:188b:c5bc with SMTP id 98e67ed59e1d1-3aceebb4bb9mr10542274a91.14.1792519101713;
        Tue, 20 Oct 2026 10:58:21 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:6::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad82f0c0b1sm133581a91.0.2026.10.20.10.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 10:58:21 -0700 (PDT)
Date: Tue, 20 Oct 2026 10:58:13 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Willem Ferguson <wferguson@cloudflare.com>, netdev@vger.kernel.org, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	ncardwell@google.com, bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, linux-doc@vger.kernel.org, 
	corbet@lwn.net, linux-kselftest@vger.kernel.org, shuah@kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [RFC PATCH net-next 0/4] tcp: carry a BPF-chosen identifier in
 TSval low bits
Message-ID: <atekzexnMd27Kctl@devvm7509.cco0.facebook.com>
References: <20261013103906.2660384-1-wferguson@cloudflare.com>
 <atFI9vl5hy09Dc0t@devvm7509.cco0.facebook.com>
 <87a4oaf3mv.fsf@cloudflare.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87a4oaf3mv.fsf@cloudflare.com>

On 10/19, Jakub Sitnicki wrote:
> Hey Stan,
> 
> On Thu, Oct 15, 2026 at 02:45 PM -07, Stanislav Fomichev wrote:
> > On 10/13, Willem Ferguson wrote:
> 
> [...]
> 
> >> Questions for reviewers:
> >> 
> >>  1. Is encoding an identifier in the low bits of TSval acceptable in
> >>     principle, given the trade-offs above?
> >>  2. If so, what feedback do you have on the implementation?
> >
> > Don't see any feedback yet, so from the top of my head: looks like you
> > control two sides of the communication, so why not a custom (bpf) tcp option?
> > Would you need that on every packet and it makes it expensive?
> >
> > Or any other field you can abuse maybe? IPv6 Flow label?
> 
> Nah, we don't control the client unfortunately.
> 
> Client here is any device that connects to our edge PoP.

I see, so you rely on the fact that it gets mirrored back.. Btw, looks like
there is already some similar tsoffset/ts_off infra? Have you considered
plugging into that?
