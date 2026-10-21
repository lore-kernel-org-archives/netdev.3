Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792620247;
	b=E0QJL12dgQ1XX0/pG5qX/NAIn89Ud0+ek4unsJL1YmEIhX0leBmNZvR7Wb+zSgE4NghG
	 +1QeYgokVT/62s8QmXIOVUKmMJBr9O8dwIWasGszYDuhkK5el2Euj0PyKc/djFi6zf6wJ
	 KUC8/Xrg01ECcS6oaL08SpeToAnZ8+rgE9obGVbCsNobGG9u6oFbAdBOUH6OioPbN8qXs
	 HKnJ/axMPX6xh1XWdyi4ruhgdN+TXpuwgYdUKgRU1IJ60U3yaU/LndenP9/jUv04HQNPf
	 XIQvgQHpT2XEBRd5pjohsFO2okQxIGmIN3ViuOyXs8okPq7LcpanOpCEHT1HT7JEmQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792620247;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Subject:From:To:Cc:X-Mailer:References:In-Reply-To;
	bh=lG5s4Mw3QlF02WaVqxKlut5zcHWhED5dwlHSwNS05WM=;
	b=1eYk7mWCsJojpa8DcyQkWBQzxQRS4bIN28OgctG3TkV7TV2w7DSMOZeVk/GXZqVdkrZG
	 owRHIAsgQoAld2RGaJfYnPmji2fZDg1HXWa51FPG5+PJnEXN0wMS6AGbLeyD3ASGS97bw
	 ctZRDqHnYoCNDPlZQK60AGtVC9jgWM5nx0ocGZURYOoKxSklxtmvQnURBKQeWsdMmCmU3
	 akHa2CGKjG0m4VusD2v2mbX1t9sJsWQeEMBqgTRyraZorXZle7BNIwaP7/ubi9RDV4zvt
	 vNI4H82Y/KvjJWFMV/hl5ntMrpDoWk529b98tfCbFeEoNaT3s/OzGqIxOiOgHFDdEjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="U/VM8qeJ";
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CC9606A31A
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 22:04:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3CC9606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=U/VM8qeJ
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2e9f6a16aedso7219885ad.2
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 15:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792620246; x=1793225046; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lG5s4Mw3QlF02WaVqxKlut5zcHWhED5dwlHSwNS05WM=;
        b=U/VM8qeJFsFQB/Tf2sRDCj2FteWlYuHoaLGK8sGh6CW6BWzt3KQ/AaBqLnq45XOEMx
         CmSWWqriULFtitXY+tKjJ+9sv7eEQweX7ii5zW330nAQ5LdZNCVqg9U/rPus85ctameS
         1b9mBBsE+JzixQ0F49aC2uBAljszdmIKmZQrDTjsNReyBleoEOzHLk2ucmn6c27uZYCz
         6ZMgDkE+pFH+dckVBVV6uXHPVaRFWVvT2wKHOWOILH8Fu9GvLa+4s+uulbqy5mIeAC7E
         OnndhkOfw0IXUmxnQr2ZZIpe1TrblQMMd2+QLsVa2sA1Z1D0Xs4oscpv6Psf7IUBGJHY
         9iJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792620246; x=1793225046;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lG5s4Mw3QlF02WaVqxKlut5zcHWhED5dwlHSwNS05WM=;
        b=RqYxxLaUsBNvW597tYCiO4sQYz1ZWjin3VngnrmkuAk+gsAs5LyoqEpJZoLVsZDkwb
         ZZKl/JTwHEVS0oNmy2XHS94sb8keHdizV1GJxS1nBkq0jpvHVVX0n7FRFFKS7ecZ8mPZ
         4LzMpa4zFJLjAJuGKA7JntqYER5/eepMcq6oIe1RCKZGegBoGRNrhuBCJmknYCRZbvsZ
         PNO0tcX7C+I0oFpCpDWhJJ1ZgHpPvHXNmVKQh7A3VX9imB4fzdLAvvNvBsl+HWvdgkJR
         K2KIJErPpQ8WAjrDeTXLOrmbyF3JfB2Fcz+jbwKF7UKOLRj+R2zgiCkPsIrwxnadecsd
         HRtg==
X-Forwarded-Encrypted: i=1; AKwUvBx01g7U8CxQuLDiBu9lvXukMszfceZagcpwO7J+RFQ4ueoeur7MWo9n9YHNoVclOqkEl9mIDPQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYLacGf/xhzzpG+mwXJrf/moKoJtkkhTmgAZwxQNgOgXGJUmGlag
	1ZI2xIKgQLptBz8J7+j841srYv7BfXTdxVlCV5A9I+25iWFSZIx2QWuu
X-Gm-Gg: AYBFou0bRnH31Nee8ERba+zhR6J8S14NtTwT29jBidvag7k+ZOwcvqD1YBca2Mis/pk
	jmn/S/VcRLdp6aHYc8LJ6JaWchSYFk9NBOuXUYRvNRfHMtvzVA31SC8lvfOk4xHfvjh7rNWIVmK
	KJAdsX5ROi/ZLZh3YXTJOHSh4jI68+8OHvUVZTBxjP6Neh8FAl2Hjq/myGJ2c34NUXWfLlcCaBs
	5GlyIY/z88CypVGEYTd33nQpTY3mvA5iR1VTmMv0qetcNeXVcGufokMvpUwRHTaMe6Wv6VT9HQ8
	oXnTOt9RntmN9jQpx8J2eIPVLb/36X++O/yjgtwLCCRQlEQyOFhVQOjtz3fDcqnolGIwTbj6gi+
	agT/AyguhdgMF2vGsbOnhkuX6TtCxabCEJXSSUtfpYgDczvO6S8M4gP0SibYb4l8sm8/nHTmrrQ
	LUP1ml8JnZKMXDJNp+MzaYvJ2KbZFcgmDAp3CecTwDJAtOsJkATjQUFvK+RLsgcbAA0bNT+pO0D
	B4TENBcuS5ET8P7YPtjT0Feb+pVaIEh0dGbaZlR51jAbJOIcYaBrRTiBg1nS+o7LQyEUK0IDgJO
	1JfZsvc4c4AjsZLQMKlb+OghTYp1MFh3ezOO2UKUurfTyLHb6lGlKKVcjYl/Pyj08oOEvF9hHf+
	qp1n0DA==
X-Received: by 2002:a17:903:37ce:b0:2ea:19bc:2fd3 with SMTP id d9443c01a7336-2ea43e24abemr27977835ad.24.1792620245977;
        Wed, 21 Oct 2026 15:04:05 -0700 (PDT)
Received: from localhost ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea3b4557c8sm15852745ad.46.2026.10.21.15.04.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 15:04:05 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Oct 2026 22:04:04 +0000
Message-Id: <DMAUUBNDJCOQ.12UWI6DR7LNYU@gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Use memmove() to load bytes from an skb
 and an xdp_buff
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <bot+bpf-ci@kernel.org>, <ayushmanrout27@gmail.com>,
 <bpf@vger.kernel.org>
Cc: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
 <memxor@gmail.com>, <hawk@kernel.org>, <drosen@google.com>,
 <netdev@vger.kernel.org>, <martin.lau@kernel.org>, <eddyz87@gmail.com>,
 <yonghong.song@linux.dev>, <mason@kernel.org>, <ihor.solodrai@linux.dev>
X-Mailer: aerc 0.20.1-349-gb940a4174a3e-dirty
References: <20261021103957.17532-1-ayushmanrout27@gmail.com>
 <5a586e05ad8d24d79759c1d99d6d58eb661dc6f4a4c8d258e05a4962cfe7e59e@mail.kernel.org>
In-Reply-To: <5a586e05ad8d24d79759c1d99d6d58eb661dc6f4a4c8d258e05a4962cfe7e59e@mail.kernel.org>

On Wed Oct 21, 2026 at 11:04 AM UTC, bot+bpf-ci wrote:
>> bpf: Use memmove() to load bytes from an skb and an xdp_buff
>
> TL;DR: bpf_skb_load_bytes_relative() still uses memcpy() and may corrupt =
data
> when its destination is an overlapping dynptr slice; should it get the sa=
me
> memmove() change, or should the commit message explain why not?
>
>> diff --git a/net/core/filter.c b/net/core/filter.c
>> --- a/net/core/filter.c
>> +++ b/net/core/filter.c
>> @@ -1789,7 +1789,7 @@ BPF_CALL_4(bpf_skb_load_bytes, const struct sk_buf=
f *, skb, u32, offset,
>>  	if (unlikely(!ptr))
>>  		goto err_clear;
>>  	if (ptr !=3D to)
>> -		memcpy(to, ptr, len);
>> +		memmove(to, ptr, len);
>>
>>  	return 0;
>>  err_clear:
>
> Should bpf_skb_load_bytes_relative() get the same change?

+1

pw-bot: cr
