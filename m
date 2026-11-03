Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793695226;
	b=sqTlWJqKXVDcSQFyfjOygf617sL5X17l3Ihwr0vfaGHFdKI6PMOu/mZyWJCiOiSYpULz
	 a6WGBKmu3ed1sLlOE2uuDcQoJ+GGPZf9oKM7yvtc71ebT0RSiB3Muz7gLUbga3Qx35peA
	 j581Dbpw2dK8gEAG/+IouqMgmXQPLLMV2CrT5PbLSSvXFSJBJG0FznhhWF2wXfAaTf27F
	 LuCJFAnertmIQAToKRNJeOXaWZpTEq89zBvhCi1113/phKynf7yhWTTG8Nqz3E9wTTAOW
	 nkyrKodNa+Z6gxKYES2WrU+OazZY1+O5DwHqZJo9BDdXPvgyvNi99jYLOp9kDzym92A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793695226;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=pKLelRsmTgibfF1F1BJ921aniTOw1uL+mfZpFdJDcCE=;
	b=YDSZkj4Q1xwG6sF+oMiykyQndeQXDyIVJfqbqti0OvZfZCrpZHDzhk4SIVSYIydGgusY
	 YGbtV1UYLt93KZBL8iGKKopIOimqLwGHC/hwSc6arHHXthic5IPTZ2pGNWIzCE9v1NfyE
	 muegfJnWj/L7iMwFx0oQBEpk27183DG5QtKYLxd7rq4H2/cCAo4bn6QlqO8D/zoyr7Adg
	 8vrsrDuahm8TFmMUvcpFi/s8iwZJO9eKimAEMYS8HLR5ixSU/wymtXxC1R+SdU6DYUiUR
	 oFMbVSNyr9S9CecWeh+u0ZGsMiMJKBP5pzLIHTbb5LoDQ1ur+6u/nXAesZfEYyMeewg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="E54R/Th5";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=q4XUYoz4;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31462606A947
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 08:40:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31462606A947
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=E54R/Th5;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=q4XUYoz4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793695225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pKLelRsmTgibfF1F1BJ921aniTOw1uL+mfZpFdJDcCE=;
	b=E54R/Th5vtszQ4Y571VZqohiGIaIYINsXWVSs2KabEIvdvdyiWjx0+GPNgyNZEmclxobzL
	wSkG3ZMKD2drgJH979FOL0EDQiO+l9otoHTcHtFfRcREm/11RFzLRTpwIMjvKWmtOsVp6e
	gMTr/6Gc9a1DC5qgba73tMDCYiQqsz8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-fWZuH-7YPzCR9WMkDyt2SQ-1; Tue, 03 Nov 2026 03:40:23 -0500
X-MC-Unique: fWZuH-7YPzCR9WMkDyt2SQ-1
X-Mimecast-MFC-AGG-ID: fWZuH-7YPzCR9WMkDyt2SQ_1793695222
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48dea677afcso340175f8f.1
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 00:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793695222; x=1794300022; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pKLelRsmTgibfF1F1BJ921aniTOw1uL+mfZpFdJDcCE=;
        b=q4XUYoz4QZ5U/UeO9wjqdjmr7wdclbxnCN3r9/e9izS2cUZIzrHYMEjNGDsRN+JSh7
         S/dhhbIcHUhjVSWCmqD/7bkf3RN3eF1s+4DVBmZjBGqj4usNfcmUUdyePVNKrHfpqQTI
         63p6DVl1BYL1RC5kOThSjFca4xKjP+JMAdI/8ehXEl0a5iJYkrwdfPR7IpK2StVjcsci
         REh9+gRECqGHDM9Wncy0nLmdL4GnHHcKAdnF9StjWzI1B5f6LMP7jzAYyb14YCYWR9xt
         wNCwMAJwxh2mJ/bPa7IgAvwK6GgWyxZ5+4oS1Y17RkLLv51r+I3Ao/6nqtOiImsukkNG
         gh6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793695222; x=1794300022;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pKLelRsmTgibfF1F1BJ921aniTOw1uL+mfZpFdJDcCE=;
        b=1I/3F0qdsHo1YQsx8yJP/Oy6m4pwwtgqiJvojpIcdx4axt9VnIfgnC+u2dCs94rzig
         YRLByiVThR2g8ZM+6pTIIDyv6NlkinmCoakqHP+J9XBptmiQDcChBXFAIHyMnJx6dFx5
         rYuWFSyZvIBC9jtM6DVMLI7x+1mAXfW6XhSvq3R/mUCtG1E8IHQ2Cw/+6iL3ENZXYrCk
         jhWfICGLZJvv36lkdIfa8/jKMGCO/iKZPnlb1Pzl+u2OmF5cwghxAspqujY3z9jJdYUv
         tkQ/93F/PG28/uLqytBULjzMJ7Ss5ARU1XB7044708xEY0pWb8aYJEqmhB4EyZbRKbAb
         hPOA==
X-Forwarded-Encrypted: i=1; AKwUvBxuaQZIgzfN18+l9dD6FgtVgnzeKUE4+HdJII/23wTqY5xqlq+ztZtnTDekyqdARUEWKn8b8gA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+SzZVNYEJAJxBxZIh35uwGDUy3KBonhjaLK94ghnX8cLVrU6rO
	2iDCqKKH+GiMBHdmk+1xE7kezdeMQf200krZv+IWmaH5Om9QjZL6+QtE0hbAqpiyXJH1342jToH
	y54wwioyZLev+OQ+Bukl/3815g7GHAuQ/tAuhLm0/5mioQgv4HbBvnvn/PA==
X-Gm-Gg: AYBFou2wyCC6nF5ZCtPARTpJZiW0Bv9JgotYXBEufTv/Eo/Htk7ZG9p7LucE2JxpXdJ
	Ly7AspOV801JKJs8FIMO+apGnHdjAQkckIFmGc2/A1SJQRXE5zapnFqt6eulTnZuxar8mOPCQGk
	YqFG09IjqLsxZDRYHzzJu37P2H1OYj5rtM8iBaesn14jvR4HP5RQ3sVZ/6mTPVGVu8JlbF9t3c2
	OnWJ1ACz8x4vOrK+guaaH1Uu9v1PmgBr7KmUVajkKuTe6d8CzczPP7EQWa0UiV+tkG2vyEjU7iC
	2oD4Y0UgoqEC9Ki/hdZU4XiGzSL1ogZGtnpIf2dldVgq+ueDdyetMDXktT1QLcvLYIqrth72xeD
	q0QgAAdxLdr6XXjexLm5EWsWFP7gQS3QmZ8Sqgv+xIeCH7ORQZBNfuyoysN5kfeLoTaaaVbCNmV
	9Wqsv+iu9hoJIj8KUa99REeVFDbZARkZ/nD/ARuQLOcc8=
X-Received: by 2002:a05:6000:2007:b0:48e:5e63:27fb with SMTP id ffacd0b85a97d-48e6e2dd32fmr30251213f8f.20.1793695222524;
        Tue, 03 Nov 2026 00:40:22 -0800 (PST)
X-Received: by 2002:a05:6000:2007:b0:48e:5e63:27fb with SMTP id ffacd0b85a97d-48e6e2dd32fmr30251181f8f.20.1793695222153;
        Tue, 03 Nov 2026 00:40:22 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71a4d3e9sm26624201f8f.6.2026.11.03.00.40.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 00:40:21 -0800 (PST)
Message-ID: <c573bbcc-e0d8-4f43-b14b-09c676a6fe38@redhat.com>
Date: Tue, 3 Nov 2026 09:40:20 +0100
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
Subject: Re: [PATCH v2 net] udp: restore hlist_nulls for primary and secondary
 hash tables
To: netdev-bot+sashiko@kernel.org, edumazet@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, willemb@google.com,
 horms@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
 david.laight.linux@gmail.com, willemdebruijn.kernel@gmail.com
References: <20261030122045.3035709-1-edumazet@kernel.org>
 <179362213820.3131.12108035098960840444@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <179362213820.3131.12108035098960840444@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/2/26 13:22, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 1 · Medium: 0 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] The hlist_nulls restart does not work when an IPv6 SO_REUSEPORT
>    socket is tail-inserted back into the bucket it was just removed from.

This look real to me. On the flip side the most straight forward fix - avoid
tail insertion in udp_lib_get_port() would re-introduce the issue addressed
by commit d894ba18d4e449b3a7f6eb491f16c9e02933736e. But rehash already avoids
tail insertion...

/P

