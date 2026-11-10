Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794329380;
	b=AYnVPo7ks7X7FwRexowMFqLC5Ny+v4q6+9npUMHm3dDzSq/Y0/lt2w1YyLndYySUAQ+0
	 ZFaixqiiJBmrmLI1chQ/Mt/37DnMkv6aH+8QYlJ285Hg9AyPcU3E4eeRh/rDSiTtxPKDm
	 nGunBemr413K2HT3jC1Y+XfxI531PyVr1dskVWYkVAkPdYrotXtUwELG3PpxdZ2WhZHV3
	 /AALVUYMcjNgN9LNL7X0B5HC6kSLqACNcTuMpAL9/UcSQwk8hlaoUdG8qheVJ1WgEqRqe
	 OST1491bEw3MOgmGRRFYauNinX1Jl86cDGYElAJ25Lq1uHfrwa2LqxW44ZbHaQTWBLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794329380;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=tP18IBGb4RAX2VQoul/BsJwOYmY36Sb1G+z0aM3/z1I=;
	b=idMePnLWYUvz57BO+slZvnC8gbsWs0VNpEBMuUoBgZjBw1Tvt/JWG98Wc9BoHTzZBORq
	 Ve6BtDLyHDw0mhKZTzwapjoE7e8SnAGDOITLC5LdiyBi8FJppSJaBRBv49ggRwHVNUtli
	 pcTldQrenl7VQTHhlk3Dts1Kk9wTmwxVrdUrZK3IvPi1kfLD9I5+9NGoBfstZFRQBpOy+
	 rR6WxOb8ItjH+ro8MJcJjM2gHJP29zI+vULsmH08ZffhDPq39eHyBvCUZbb/4XXwelIFA
	 7TFfQbSVnwPitdWQxroTfFYNXVz7vlbV/ZIlwyf3eibja7ArhjupHAVtilfUeZ3zh0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sd9gmcUC;
	arc=none smtp.remote-ip=74.125.224.135
Received: from mail-yx2-f7.google.com (mail-yx2-f7.google.com [74.125.224.135])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B769606A325
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 16:49:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B769606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sd9gmcUC
Received: by mail-yx2-f7.google.com with SMTP id 956f58d0204a3-67a19a2621dso1548806d50.0
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 08:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794329379; x=1794934179; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tP18IBGb4RAX2VQoul/BsJwOYmY36Sb1G+z0aM3/z1I=;
        b=sd9gmcUC5EjvUfKx68rTBxuM9bdbaznz/tEwxEWenOWnU4qLBJS8XdmeO9Tqxwj+lw
         oW3msGNKD6Cc/5Hqirx1MWT8/n2v8Qjm9PUcuicql2WYq+rF8q44tafK9hFR2FUQ9pYp
         OvMf+F5cXA6oZ3QGRiy68Xwm+LHm3/qhIh+r4ya2txJhybsQZsYqO293qHl5BNjQg7xu
         kRJyWMJJrSkEmzH+uxkug5xGmR3DD1NLa4QS4lTBW9dhmtICsLwf/0BnRL47ootGLSEC
         AF1ORHoqamMIBedGpXGvtYQ5Rp3f+VaA19VjR2KGUb+z3qUm3l7PYU9mWCi/qlXOPrJL
         wMAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794329379; x=1794934179;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tP18IBGb4RAX2VQoul/BsJwOYmY36Sb1G+z0aM3/z1I=;
        b=CMNSyOALDuhli5RQWPf+MF2kpOxTb/Ysm4JR5uNMWJpqdLQ8gc0rO45hwSLy4QMTyw
         YClnzXRFzj7v47nHe+iTrQKmXnScouSg7NPkuUziNAuI1ufY1INktl/ltO4u9e9IQD8B
         ZQ7EZpuePL8vNaKgssywGi9KWaMtlsK078Iv8lSGFlQ+3yiOXbbelyx3nzNNXibPHGgh
         sT/BouycRNMbhFms/VRgzL1h8W/OfsJMleYzf7ZtXimVQ5zPWWf67xJH+QMtzRElRjpx
         v4i0FXkwdELqzBgE+lwjbtcyaTRMDGEKoP0b4+rAIDEWg5WTJ18Qhe+tUf9U5cm9Xhey
         Yj+g==
X-Forwarded-Encrypted: i=1; AL+hErFmCzJo11bld0xITLgIIYcOCeCJZzHz59MydskOx1VI6wcXhFpa+E6V4XI787Lnn1zo1ZGnONc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/BaX9VIwRIbZAWlUPmhX+m8CXjCrzzkILKRnFuD45Cy8JIfXzP
	nHQQQ/rqZJWadF2QSG5W3LBov8aIHzqmYp4ydo678AHI6ac91Kvnd+3Z
X-Gm-Gg: AYBFou1gqRWBMuw81YEIPEWBZPeSLXMPITKdh3dz+PDGjEUdrv+ES3xATj4W+vlxa6E
	iZ42Z1NEPRAU9nPppUW6cVVNF1ktD/2pPTnUaRoeG5XCZglFLPxC1pPWZ/rrKLjmdMblI1gxVT2
	q9gD9v3CvxFddHR+8FHupvUk9jYeBnHQ5Y1ZELPsetYW6Nd+GHZdZiKhuyBuQMOB0AbhS7/fFrN
	P7lnnxJ7PI906WXEpyjoe2qLhDJT6Z5UBTxl1yfQSMQ062vY1n0gwvxOXuTMv4ecVabdscc3oPA
	hti7AJ6vZqB5YxY/b5wnuvzicBTk2LDoUIp0YNgnq2mv8Sv6gcTO1rKKor1uxq6VUdzGhkrVjfO
	/MMbybef2FmKw9M6QA3LxsAB+ppzm6O1uYAgqUTX+vpFvBk9MldcPLRDVBdiciF3b0aI2oEf5iS
	dch6Gga8qcbPAdDy1/LyPQZJLIQIL5UQ1FUgZq7LiNzUjlpYczC3037AfYT16mDbaRKyelo8IGF
	g5DuBRbCG2UdQZO4+Cta7MF7yQRaku4phADe8JoCBA9GFm1CRlnp+0rQYLMtdeUKbD0j2fB00nT
	B/XIya207QkjO0tjk7gL8Tep8UqDTdV1I+aHnpalgcgsPP3zWRWDMc9pPw==
X-Received: by 2002:a05:690e:12c3:b0:67c:fa4:2b9f with SMTP id 956f58d0204a3-67c566077bbmr2140240d50.15.1794329379380;
        Tue, 10 Nov 2026 08:49:39 -0800 (PST)
Received: from [10.0.0.48] ([71.69.222.122])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67c589a2354sm2244105d50.6.2026.11.10.08.49.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 08:49:38 -0800 (PST)
Message-ID: <83246c2b-6663-4c52-95f0-50dac116570b@gmail.com>
Date: Tue, 10 Nov 2026 11:49:33 -0500
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
Subject: Re: [PATCH net-next v6 4/6] tls: update the RX key when a KeyUpdate
 is received
To: netdev-bot+sashiko@kernel.org
Cc: john.fastabend@gmail.com, kuba@kernel.org, sd@queasysnail.net,
 davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com,
 horms@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
 rdunlap@infradead.org, shuah@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, hare@kernel.org, cel@kernel.org,
 kernel-tls-handshake@lists.linux.dev, alistair.francis@wdc.com,
 martin.belanger@dell.com
References: <20261105-keyupdate-rfc-v6-4-99b695f9eb4f@gmail.com>
 <179424471155.994134.17986033334400694237@kernel.org>
Content-Language: en-US
From: Martin Belanger <martin.nvme.dev@gmail.com>
In-Reply-To: <179424471155.994134.17986033334400694237@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/9/26 12:18, netdev-bot+sashiko@kernel.org wrote:
> [Severity: Medium]
> What happens when the KeyUpdate is not the first handshake message in the
> record?

Valid. A record with [NewSessionTicket][KeyUpdate] is legal (RFC 9846
section 5.1), and the check reads only the type of the first message.
Mainline has the same gap: tls_check_pending_rekey() does not set
key_update_pending for such a record either. With a registered RX
secret the result is worse, because the kernel owns the rekey and the
connection ends on the next record.

v7 will check every handshake message in the record. A KeyUpdate that
is the last message will be handled. A KeyUpdate followed by another
message will end the connection.

> The RFC does not forbid a KeyUpdate that ends a record with several
> messages, and the rule the code enforces is in section 5.1, not 4.7.3.

Agreed. The commit message in v7 will cite section 5.1 and describe
what the code does.

> Could the comment be reworded so that a future caller doesn't assume the
> old key still works after a failed rekey?

Yes. In v7, the kernel-doc will say that the key may be unusable after
an error, and that the caller must end the connection.

> Should Documentation/networking/tls.rst be updated to match this
> behaviour?

Yes. v7 will update the "TLS 1.3 Key Updates" section and the
statistics. TlsRxRekeyError will count every received KeyUpdate that
ends the connection, not only the rate limit.

pw-bot: cr
