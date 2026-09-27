Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E722E3CE4B1
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 08:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790497467; cv=none; b=gmVjSHBW9bQndXETxp0iharbt3CijkfqgxTDlgKod1w2lc7RBWPki250QEAgF7eqzn20DM75WmNk5PiPhpj3Qhl4hwGC4bfoMzYN6HTZWH8bszccehX/ZIhkecSMY/m4L4Xxy/fB1LFQuERVYEk3h3gB7BX0nMFeTDwAmr+6uEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790497467; c=relaxed/simple;
	bh=3rxqKQhNHuL7o+xcCUTkX75IBd8KS+Bj2j0NN6nk9ZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=prnHFJKVaCvbAHZzKK5N/arkBsvHU8VxGQbyjQF+H03JQtbUXkc+EPJfCJnYlvNp3RWA/NDFu4tSnK2pB1li/N7IOGCMneHdB/CLgSXoLJsbqTAuqzvfBGzON/3k2SLVMIxan6YSfqo3awKJ5rZIPZfGmAaA4pu1hIpYtIHX1nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LiwPjk0D; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pcOAUr/O; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LiwPjk0D";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="pcOAUr/O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790497463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CwGov1WfVqjaD3uyRV6IMvRELVNTsPWtY2wOQdAbySA=;
	b=LiwPjk0D+ndrNTCR+LMbb5/pDl9PZcbJZvbBXQp/QSyZHyc840xLgbZiYSQg8kZ3TTzjY+
	V+9/FAZY0Kv2+peAPhhy2vGTqJ8HL1s+nDmGqFVaTwKDQ2+EEvHbGfCxm1nT+FizRT12dP
	PHcjXwJGrhnO1loZVGLR0ITS7aLK4tg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-VZquBg6FPgaqgJOabACrUw-1; Sun, 27 Sep 2026 04:24:21 -0400
X-MC-Unique: VZquBg6FPgaqgJOabACrUw-1
X-Mimecast-MFC-AGG-ID: VZquBg6FPgaqgJOabACrUw_1790497461
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49e661c6440so13325465e9.3
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 01:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790497461; x=1791102261; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CwGov1WfVqjaD3uyRV6IMvRELVNTsPWtY2wOQdAbySA=;
        b=pcOAUr/OLQLVeoB+CBbsv/eSuAhBw9CvatSVn8VHZ5eANZ+zwaMXL+yx2t3D1MxOqq
         uLm8UgyK3WB8jwjHDEFqcNn3pL73i2C5eP33g7ynnsHUhbzaSgvfCN61NSbhNGZo37qu
         SiI1XkLTWBNXzGS9fdtbJJX9czHaWabwYvD8VpO4uSTtlVtfziqNGdyQIbptyjHeUL23
         JM/y4smBn/3Aukw6HJCa29JK+ej82a/tB789DdCvUgPynDkQ8KSVZVNXYwsCpDDXMb8K
         NKDM72yx8YgvjXQbNOuNYa5ZWDJoqOgHibr8044APutB81lX75cb0E+RGVU8NIsNRYGf
         CARw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790497461; x=1791102261;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CwGov1WfVqjaD3uyRV6IMvRELVNTsPWtY2wOQdAbySA=;
        b=rat2P5etKk+cAckHyPI+O9lYJis9CivqZ01h4bICFokn+t6y/XJ3xiDriAxEgjCx+u
         6Gd1i3Sx3Gq7k9e7eyr1wApscQctSZPe1Wd7P86n1qAZvEwl0VkL24CdNQAWR/g3CPcA
         sjSQwPN3I48a41n9h7iGw3JUNB5wpFC8N3Ie33HnFHGwYOKecrx1NnAw1d1p3e8Wivfh
         yV6eG+2Wsb1QDfEColptPWzxNBuk7SL1euo1+LzZwPMU0gyggpZn4XHDAGqRMUSZr6iI
         8EEfhbyMRsvlnoYlg19qwGylXLhvj7JFOuHH0R1Ji7NQpf1INDWhmZW5EesfrK1UNiVs
         VSzg==
X-Forwarded-Encrypted: i=1; AKwUvBwPG1lcB4n5stIbxfoEjTME3PWyCWi0nfNdVxC5N4c629SYvaqfWUHDIpGg0bTlSx22JnE7NmU=@vger.kernel.org
X-Gm-Message-State: AFuF++liTDdO6VmpoTv/nswd6n527Ps7EwL5Bl210vGKw9vZLx+iBO3R
	sH/HCYGrWkgxwyG/Oa8PRRay0nBazwjxXsub+VvPXb/XWQVhLYluDPlgv97LNFolXnnfngJIwbV
	rQ/irIRwSu0cM85r26wQF8DXjZn50VoIHJUpA35vjnvOIrFmODQvNGYvs5w==
X-Gm-Gg: AYBFou1jeJuFl3XjJJw1bv6N+W7c87nBqTMeaoWfvNYAaAAO5/4DaHxOm+HCtwQm6ws
	9oIR2GNMJ81ieFPDpQKV/G5MBxHai+YiMFjQNb9dy31kStBHcWLDoZncwwxj3iZkNngBStzHiAX
	pTFqes4CP63bw9LCFC9P0BGICOI8Nd5GQEe9Wu6wCgkDxANMjlpXCZwgJAoUvpwWZ41taZgrmpm
	QWEaYlYgr9ONcHp4lm9WcEw5eX9aHCqaabfjI19bMoNS9AdTL04rZCTIlgZpab9ifk4z9JkxtHN
	U/4XuBpAEK7si3CvW31jcQGeYkgw1+Jgq7cigMQuDxe5+BVMHVEks5WG3r0qpee7fnki30YJvS3
	tEKz5S94vFWTCb5itEadgLZHSVbzf48dt6SeqkLjecJCuw7a55CH4tXxAr6oiRZC2a/+3F04R7w
	==
X-Received: by 2002:a05:600c:83c3:b0:49f:fdca:c348 with SMTP id 5b1f17b1804b1-49ffdcac594mr41988905e9.10.1790497460701;
        Sun, 27 Sep 2026 01:24:20 -0700 (PDT)
X-Received: by 2002:a05:600c:83c3:b0:49f:fdca:c348 with SMTP id 5b1f17b1804b1-49ffdcac594mr41988585e9.10.1790497460317;
        Sun, 27 Sep 2026 01:24:20 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0018f3e68sm40012525e9.9.2026.09.27.01.24.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Sep 2026 01:24:19 -0700 (PDT)
Message-ID: <8862b9ed-6f96-48c6-a134-6e8635c38987@redhat.com>
Date: Sun, 27 Sep 2026 10:24:16 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/7] net: skb: isolate skb data area allocations into a
 separate bucket
To: Kees Cook <kees@kernel.org>, Vlastimil Babka <vbabka@kernel.org>
Cc: Pedro Falcato <pfalcato@suse.de>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Willem de Bruijn <willemb@google.com>, Jason Xing
 <kerneljasonxing@gmail.com>, netdev@vger.kernel.org,
 Kuniyuki Iwashima <kuniyu@google.com>, linux-hardening@vger.kernel.org,
 Harry Yoo <harry@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>,
 David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Jiayuan Chen <jiayuan.chen@linux.dev>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20260921075811.too.775-kees@kernel.org>
 <20260921075820.1718334-7-kees@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260921075820.1718334-7-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/21/26 09:58, Kees Cook wrote:
> From: Pedro Falcato <pfalcato@suse.de>
> 
> SKB data area allocations (as done from alloc_skb()) use kmalloc().
> These allocations can be variably sized and their contents can be more
> or less controlled from userspace, which makes them useful for attackers
> that want to overwrite a use-after-free'd object from the same kmalloc slab
> (which often just requires the sizes to roughly match into the same kmalloc
> bucket). [0] is an easy example of an exploit that uses netlink skb
> allocation to target another similarly-sized accidentally freed object.
> 
> While other mitigations like CONFIG_RANDOM_KMALLOC_CACHES exist, these are
> probabilistic. Use the existing kmem buckets API to further isolate these
> allocations in a guaranteed fashion, when CONFIG_SLAB_BUCKETS=y.
> 
> Ask for the accounted kmalloc type as well as the normal one. AF_UNIX
> sets sk_allocation to GFP_KERNEL_ACCOUNT, so without it every AF_UNIX
> skb data area would fall back to the general caches, and those are the
> ones most worth isolating. GFP_DMA is left to fall back, being passed to
> an skb allocator only by rare devices.
> 
> Link: https://github.com/google/security-research/blob/master/pocs/linux/kernelctf/CVE-2023-4207_lts_cos_mitigation_2/docs/exploit.md [0]
> Reviewed-by: Kees Cook <kees@kernel.org>
> Signed-off-by: Pedro Falcato <pfalcato@suse.de>

I would be curious to learn how about the memory usage delta.
However I see buckets are protected by their own kconfig, small
systems can unselect them.

For the networking bits:

Acked-by: Paolo Abeni <pabeni@redhat.com>

