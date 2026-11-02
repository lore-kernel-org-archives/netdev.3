Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793620124;
	b=n/ZV9dLTP0AwluG9eJIZTvu83mhWb9TiYxdrkRPsNWC0Ngun4N882/qmPbU7kYJp60zX
	 7gCQUrh/ShU2p881vzvXx0Egpf0hprDnT2beeRdjgyDubvRm2mBYIUyuXi0JdEpxd0/li
	 YP/fuOK3wkI6BBdptAyUYdpeWvIx8pJn+V4N7dNiQMGwkg2fK9aXkZw00m1UronFnYFHO
	 cEhMy/Vp2t4jxDUcWzWL04YgG1Z0s8xp+DH/nCuUYaDrbHGPC90hKyYbUzQUbkMoNqGBt
	 SKvS/hB1rtSnCE+ZRCqzdQCXD9V75PxO5E+EFvbina9/eHbQ0UbqR8L5ULUqZ5BpVpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793620124;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=SJMWixFaZLRsZ4Hl1XD4V62BsN02jkA9imQJRFP2Ruw=;
	b=LvDQCBGZMFKymnHO62ZWmXgR1KtQUDE11NEhKzy4z5P7mycCOKc2A/yTwR9XhPrHi7Ry
	 9ZRiUm0avUH699H37RBrHKUyVEQkfld8xZSM8Oeu7I0Wn9DD2F6k8KTSxTipg3kb27T6q
	 wKd6AoXL6aMvgoiAIyI+2xroeswwP/GwqNgN3kR8y6gEPOs7YFRG/MNJh3DEwyIGvgnO3
	 1a2gzgLqohhLALqe+LheEog6T7wGOTRobehcmm1dDNRCayZmTXI2o0F0J4L3tneuV7Bse
	 +a5ifGdnp8E+51eek1xeQS1+2pawg+xYku+CApiMcwBc6QIiqH9jUoLdDOx+UGv3iYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VwKC63E7;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=V+2Y3auc;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7B3606A329
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 11:48:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E7B3606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VwKC63E7;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=V+2Y3auc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793620123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SJMWixFaZLRsZ4Hl1XD4V62BsN02jkA9imQJRFP2Ruw=;
	b=VwKC63E7gXAt7jA8i1/2TWcGW+eW1SHGmaLpx1JpVxzf3X7GnbHRurQM7+SvR4ihOQyHEx
	rx22CY8yzl2Uec6ATjyEHLclK2rtj2PisTTTnJ/CBeoteUzJR/eRyr4bLTGCDBpNu07isr
	Vb0yM2vKvsHsf+XzvaSofoCgPYdI6HA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-QP_U19P1MrSJUIjpvi8rzQ-1; Mon, 02 Nov 2026 06:48:41 -0500
X-MC-Unique: QP_U19P1MrSJUIjpvi8rzQ-1
X-Mimecast-MFC-AGG-ID: QP_U19P1MrSJUIjpvi8rzQ_1793620121
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48c415561aaso1980815f8f.1
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 03:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793620120; x=1794224920; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SJMWixFaZLRsZ4Hl1XD4V62BsN02jkA9imQJRFP2Ruw=;
        b=V+2Y3aucgs5B+MhZba5RM/XB9p8JwmNL+C8mWwAACltGp1ifrzmBTEL/EU+BWRC9J8
         fObcOHZHLdreIpQzJPaMVPVetnfkQypmbM9+IqiNN6M3EppD68doozk2sYpFVeME2Wk5
         9dpsZn0gyEOGz/JPnXPOHd3tZen98QemsrwA3JY6vU6lWad6YLMBJmmVxzrpyVLllbAf
         c0/MQglXNNtBghT6VQljgimsU2zYgd42opEnzJpN3mla4FPv9we5zn1waEBnqRpIX8o2
         FNDaZOCNojx+T+08Rx53sNpd/Mom44tSYjXBpMhAEG4s6iEgthETvaK6uEOuADoN/iYF
         W84w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793620120; x=1794224920;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SJMWixFaZLRsZ4Hl1XD4V62BsN02jkA9imQJRFP2Ruw=;
        b=h+PYVdyysn3SIZbgzHIMXR47nIRoNSEIhasowvp+KcmN2yHDh+DwyH/8LtjB0Nr7oe
         GnmHlE8OAcx3gvWE72UgjiRwTJB6A5wDHgZ/U7gsN34vThY8y5sOFRqZWA1u1ZDdsysP
         dPXu04yIPI53HCh9qeEK3IOyikf6nd9XzrMTm8yBI8Q1XVE6KnRvv+Mi9c4/vJ1jcJBA
         bqttZqbpquls+YcDIc4I6MFeek/7qTcQo+jM1O9gtW3yM+UjY0Y/LZ/pwtTWrLym3ygB
         eeIsUfM1ZPzwm1l8JT2fzJ18eks1botIcAPPPiW823VHXLs0qAcIeOHFTbYg4tmxh8cf
         L/ug==
X-Forwarded-Encrypted: i=1; AKwUvBwrqnXhx7M+9c0jFkQcVhoSLKYmwTdhMPkZjuzegpvRLh0vGbxEy4ldEy8jvY6cmxxlyeEUPng=@vger.kernel.org
X-Gm-Message-State: AFq9FYJMhTZeoErv8BsU887WqERxIweaGd4HVZLCyKtWZGnjEbjYpRU5
	86bXtJ4DyO4/GCI6krXEhpc3e1SyleCEv8EpkU2BadCG3jh400jjR/J9KRhG1KX/R/cO5zs0Gjl
	hKKNN3ZOLm6f8bLeGQ4v3cPtv01/QhSPrBmf9wsNpVihR8AlHIeXTHg7e7Q==
X-Gm-Gg: AYBFou0HrPb8JrO5w6UEnFhG+Ed/F6UrS3YmE9eVyUjEfUqendrObf27uxmdQdw7jEB
	Nd+4/3K+5gd6WpOgId/zI61DF4hTIavkfFSS4KvYTYntfyEYR3w5pUDSHAbWhFUHckX+5hOHwXL
	Bhw3L7ef2G1U8PZmhPLX7RlLL01lb4kmf8aG5iJfiJbbpHY6P/l1VBiup8GfmreTwhUHSjoe9wa
	9gv63gRtEsL4qYFK4bhR3r8i+NogsKJVRaVrzgeIvmqrjwqa/OmJPf7DBwxvVdKsPdJxShkIuCE
	R56kGozoxRXqN9StJV0vU2YqmE9xR6NSFnSOyJrT5wSPeOEzkwd55lSXu1wRrTdLCD+9fZIU0LM
	BaOxkMAt5QknJK7S8HPDEqmmad/B9N70Ooi2ZPnsdZAJ9nt+59y6x5S5u6G4l4bxwSONxwCqYG4
	bN1z0ikDch8xRGeb0P4/+9MPa/oyWT2abFReaTYHUJXnY=
X-Received: by 2002:a05:600c:3ba0:b0:4a1:e0db:8cf8 with SMTP id 5b1f17b1804b1-4ac151a84f0mr220535715e9.3.1793620120546;
        Mon, 02 Nov 2026 03:48:40 -0800 (PST)
X-Received: by 2002:a05:600c:3ba0:b0:4a1:e0db:8cf8 with SMTP id 5b1f17b1804b1-4ac151a84f0mr220535305e9.3.1793620120207;
        Mon, 02 Nov 2026 03:48:40 -0800 (PST)
Received: from [192.168.88.29] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa813d2640sm337173005e9.6.2026.11.02.03.48.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 03:48:39 -0800 (PST)
Message-ID: <4de42b50-1f80-418b-94ff-95d656f08bd2@redhat.com>
Date: Mon, 2 Nov 2026 12:48:37 +0100
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
Subject: Re: [PATCH net] ppp: remove SC_MUST_COMP
To: Qingfang Deng <qingfang.deng@linux.dev>, netdev-bot+sashiko@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, leitao@debian.org, norbert@doyensec.com,
 hataegu0826@gmail.com, paulus@ozlabs.org, Brice.Goglin@ens-lyon.org,
 akpm@osdl.org, Matt_Domsch@dell.com, linux-ppp@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261029074935.40509-1-qingfang.deng@linux.dev>
 <179339596607.3131.10030375792154782283@kernel.org>
 <84396bab-166b-435f-9663-0aa2939de3fc@linux.dev>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <84396bab-166b-435f-9663-0aa2939de3fc@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/31/26 02:28, Qingfang Deng wrote:
> On 10/31/2026 5:32 AM, netdev-bot+sashiko@kernel.org wrote:
>> Would it work to keep the define, with a comment that the kernel ignores
>> it and that it aliases SC_DC_ERROR, while still dropping it from
>> SC_FLAG_BITS and SC_MASK and removing the checks?
> 
> I found no trace of existing users (searched GitHub). Even _if_ there are any, _and_ SC_MUST_COMP does not alias SC_DC_ERROR, the logic is still flawed - received packets are silently dropped without noticing the userspace.
> 
> If the goal is to prevent the removal from backports, I may split out the removal part into a net-next patch.

I'm sorry to disagree with Simon, but I think we should not
change uAPI unless strictly required.

I would just mark `SC_MUST_COMP` as obsoleted since <revision>.

/P

