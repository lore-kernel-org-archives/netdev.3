Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9FD5172D9
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 13:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791898481; cv=none; b=CvP7TCvbmKQAFk2nWpjvGFmNVvMTIf9nUf7dhMtbZ5U384PFE3Jebj7Ebi1+gWzI9ebPWHUpGmSMUXTCJxN1w/qC8WgKsqQw/gbMmQfFmd50ey1+uFlx1gO0FXzFdWFbmQ9/5nOS3Qe+SZ3UfgnoUZke0vktV4whQdsWdmf3IJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791898481; c=relaxed/simple;
	bh=FqXfdBvSOpLrYH2GCauC78C/T54bfdJv+dI5rp/M1FY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ahgzrpDtdscLYMrB30jvuA34YxhWB7eLq9Me9zcKwasCZeSnRYEqqzFZyfgrAnzEbA3xjhOb0HFARm+O6kK9rLeU13d/mQ2AhC41wFm/sw70YTpHCmTHXHRV5H3N57awr8eGpNtBqFASdB/3TUFugfsnfnaSJZS1+p/XUwWBkJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q7CwYOy4; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=thV+IwQE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q7CwYOy4";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="thV+IwQE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791898479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TMxllgf8Oy65ELVJn05IHyidVK+eMAVjjDY5aKGoxCI=;
	b=Q7CwYOy4WQ6OS0dwZtfluMTM0eQkWJZfl9QVuj771+DLHdwtfIaQszbci66432jX+fonHz
	PU902xmFrjnGKhoK5k1tryM3MukWlg3uUbWTayRGQlYxSvNLHjrF1OFoL5VY/PygcKHafF
	FpjhmIKOZghs08FDhB25ocWYyYd7KSo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-1g4VmVgSOdC-pJqF7HdR4A-1; Tue, 13 Oct 2026 13:34:37 +0000
X-MC-Unique: 1g4VmVgSOdC-pJqF7HdR4A-1
X-Mimecast-MFC-AGG-ID: 1g4VmVgSOdC-pJqF7HdR4A_1791898476
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48aef5cfe43so1796451f8f.1
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 06:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791898476; x=1792503276; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TMxllgf8Oy65ELVJn05IHyidVK+eMAVjjDY5aKGoxCI=;
        b=thV+IwQEPOj/ya6bWr2y/1p2BvdhwdNs2dK8ubY3MojxdHy0Bb5pfy4VyTC1/tzKfz
         8ZJYP9IcxckSNeEzHkD1OFe7Dbb25wDEulVep8BVmSktAHFuh+62od6+hzizmH/1J7lN
         X87RlDKsnGhEtZ9wCW7jBStr6poCbzLw/n0suTz2yVdfshqmqi8KfQexHiIfN1Yxmmv9
         ed0pJAjq+8Gguvs9uLxOq4Qvl20PcNWsHyRgriUk1xCMzp8kbdoUn/hRfzvaJ0S7oD3t
         0iekgmseEOuyPm4C9ZRC+ge9u6uU9gLsZTxcSH+CZ5wtq4dWI06mNgIO/YXSN5m0E1s6
         sXSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791898476; x=1792503276;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TMxllgf8Oy65ELVJn05IHyidVK+eMAVjjDY5aKGoxCI=;
        b=b7QGm8mRACESElRfRKIur3GszIKocYWBaNEKh4sG4EvznxuvFJZEEYx7bG1ds51T2+
         LSAUJu8jp1yrbmoAPHcE5lFGfx7XpXIILllk1sZ0cKdYfgg6rOJNiAubJxq91TuZB5+o
         1AUCBuMP4et3qieGL4bd9WKspxmkDsbFbh/ubWwSYSHIa1kv3gDgBkTx9P3vP8bDCsVH
         Zv5pUNM9TyooBbDRNM+WAWl6ElQGWlXkJCV3i9NgWPGZ5G2JMvc69J2OULV2I6dtrSuG
         rCZ2z3g5BrzvL80BC17acH+L1d0J/epvcnbx+5isG1DL94ekAb67zDKXHRULhd3Q/n0w
         TJ/w==
X-Forwarded-Encrypted: i=1; AKwUvBwnQdg25vHIicmGO8KsvEgYpYN4NXnLI/NOP4BFZ8BISvi24j2NXkLvgyh4RphhUrrj+rM1XOA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJlgNgn1YTBaz9VuYgpnewLn0r0/6/oPAOa/pw30NA3LOjZxr8a
	VOBEheoLJqOvsbkWUDcKhMpkcOH+wjGvlMH9Pn5CV3zG3h6OUFSJzHnrszcq4ezBrHu2zXVGFB7
	x1h/5B+1yv6uLJsh/ZGpQA+gx63eJZ3Kmxhl2K3fqY7g/IjMD1MiRV3jbCw==
X-Gm-Gg: AYBFou0FZxMIZRZcnWdZlGoaJ/kpu86yT+SJngDNPqT2AbyW+0D49RjVFPthGFveF8I
	dWzvqGWLRGHPOXqbWMMHPaGsYveQbUH1LhomI9Cqp5FjHvtFunucTvfKuWKOi7L3FHXtoCCeq9q
	QCJcgelI2puMMLYUC4j4siRIck2Mz4krMKFFy2mf1QxtP55ROCbfiSg7EsMco6SCL2jOcVHwD0X
	TlL3Lh1ByZaGwXG0SFCy8cQJtigpukCX4SgfoqDbTnC5DQjx+dEts5HmHkY6tLbjlBER0rTn1BM
	71Cm/OSfQMPTZyrLOwPt4sp8tXnHyzo28d8ykWTuEiGExMKh147gAclsFO+nz3UmcB/bEPyetTb
	F2y6l0CoVlFAA6z94tsngeZikgqZNyxzQZf8VoKHpcR/56/xnjVjPOg3re3Tt2rGhqP/ojLgH8Q
	==
X-Received: by 2002:a5d:5f50:0:b0:48b:50e:5dc6 with SMTP id ffacd0b85a97d-48dbacda8edmr26953862f8f.34.1791898476122;
        Tue, 13 Oct 2026 06:34:36 -0700 (PDT)
X-Received: by 2002:a5d:5f50:0:b0:48b:50e:5dc6 with SMTP id ffacd0b85a97d-48dbacda8edmr26953809f8f.34.1791898475731;
        Tue, 13 Oct 2026 06:34:35 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0ab506bsm5756128f8f.27.2026.10.13.06.34.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 06:34:35 -0700 (PDT)
Message-ID: <619ddfe4-3d85-4636-a508-3ff461f2a09b@redhat.com>
Date: Tue, 13 Oct 2026 15:34:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 6/6] net: net_test: add tests for TCP
 re-segmentation
To: Wang Zhan <wang.zhan@smartx.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 horms@kernel.org, keyong.sun@smartx.com,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jason Wang <jasowangio@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Aaron Conole <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>,
 Ilya Maximets <i.maximets@ovn.org>, dev@openvswitch.org,
 Daniel Borkmann <daniel@iogearbox.net>, Neal Cardwell
 <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 Alice Mikityanska <alice@isovalent.com>,
 David Laight <david.laight.linux@gmail.com>
References: <20261008100651.2534957-1-wang.zhan@smartx.com>
 <20261008100651.2534957-7-wang.zhan@smartx.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261008100651.2534957-7-wang.zhan@smartx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/8/26 12:06, Wang Zhan wrote:
> The GSO engine can now be asked to group several MSS segments into one
> output skb, which is what re-segmentation needs.  Add KUnit coverage for
> the max_segs parameter.
> 
> The parameterized GSO test gains a max_segs input and four cases: a limit
> of two MSS applied to a 3003 byte and to a 5003 byte payload, a tail which
> holds one MSS and is therefore not a GSO skb, and a max_segs of one MSS
> which must leave the output unchanged.  It drives skb_segment() directly,
> because the synthetic protocol it uses has no gso_segment callback.
> 
> Assisted-by: LLM
> Signed-off-by: Wang Zhan <wang.zhan@smartx.com>
Sashiko noted this may require a small follow-up:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261008100651.2534957-1-wang.zhan@smartx.com

but that is indeed better handled as a follow-up, if needed.

/P

