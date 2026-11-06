Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793934091;
	b=2zlAS1m+VgqVWnqkZO+j4mpq+kU2O2FVnotY3wFiTIxVCsJEQyArcglazC2IKG6Zqljn
	 kEuKQ8u+Asb/VMPre5WTo6yN+GYWD0cf19m8xhS7mShH3rAz/T1k5JN2lUhQc31tBVer4
	 PLNHAwYw+0TuFQC7Yelmfq7o2Ss4pc1rFQlyYIAeFX4zyYhPWBxxeyyMIqXEen/ooYsS4
	 VsoDCFoHelZWMBmMIXiEjpDJyEZfQ078jd/V9Wt1EFcHg6dw6hl5Cf7LxiBO/tgG3vUU+
	 JPIdUbgUkDkU7kOgNfDmFM5R+vIQ7Kcy+WXvRO2bXX08obQkWVziP6T8XCcQGetR4pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793934091;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=t6aRulHNXUeC2tlehsSj6ODcF0+cJ04EmVwTbLYgrmk=;
	b=FLyiYEaZlukk6TgW2aFZtcWMYFD2YKbPiYR61loMKpxLE4vmq26xwjhsRCtA9uCEBzZt
	 ObYEs5G+YPSPdMG6wZi9GTblpkNFOkpCgYLu0qr7mSIuAIuljHRPIFQVxN6pktFEk0f+V
	 ctb4G0nuoWkyhEibSdYQDmnBL23jwmbzUzX1opfibuQd5pcNErwi8PwsHpfcNE2lLvY63
	 zCRlm1dRcWesgh4wNIObLch2J/nvykrN4x8w7LrDJOY7cA0tueGsEvSrhUG8zyjAa5VVC
	 eXQJtpFymTgxgNWtpzQFQi7sXlV1mrthiDppFKaj7R5Uqo4YS9deFeCzZW21VL/Kheg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JCl4Gfy0;
	arc=none smtp.remote-ip=209.85.217.44
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D07606A32C
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 03:01:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84D07606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JCl4Gfy0
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-7777fa8f1ccso58880137.3
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 19:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793934090; x=1794538890; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=t6aRulHNXUeC2tlehsSj6ODcF0+cJ04EmVwTbLYgrmk=;
        b=JCl4Gfy0EBXXqrT5LV6qnfQdzP0zEsd279x8qeNp9xw1/cvvvBRYQcDjrC6GVeX8h/
         jfNkCTg3MZ5RUsyP2iQuXxG4os7zuN8QwX7y81S6xL7pSjyoZk6R8TkaCu9hAu5Ei2Mh
         ZYkL52QTJfBup6LDoFjp90Hjg/RUnODdQXlU4YnyTkPTvCix/uDocjDzixnymYooFjcG
         mITLgCR0CeXhXzH+uQTVkTtGwBXuEg/5MeuLoAFtpR+R2QCNGMLBO2V/+KSn6tW80Y+t
         z+0aKEtK5SqkEXHYzQKScdpOb75WveqS3Wg+sjB4Bw2zM0KWOR9c4WxkJOWS2cosEbUx
         d+dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793934090; x=1794538890;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t6aRulHNXUeC2tlehsSj6ODcF0+cJ04EmVwTbLYgrmk=;
        b=iRqA6X8ZR6/J+WcqoXjaWKwU1afBl+3bNAmaeWTo1p36bRSjJBQaZbZ3v/FHZw3Hog
         1dBcalRyvspVXLMjpczzWdE9q0P4xAoRo3XTrFgRByVw66nfVNo7AaZTRenu46CUdmDp
         U6XFckEwjwd9VLyK6SmyVe3sZtWEqM7+WQSGRv6Jk0qeTvZzMpJVrZ1GU1h+2iwYe1lN
         Aw12dJJuWUFqBs9A6/sUmxq8atzLA8WKcSVfe3FME3vwGPeR0QU+5SX9cqGwZYP6uJIh
         SvE+N1MHufcsRTbnwrtHbpi6HwaQfVXn7of6V0PM6CxVTHC3I+Xht5bbeeZqcqp2yO1j
         sCoQ==
X-Gm-Message-State: APuU4Z+fI9V15gRc9DVV/ibM1l5OyQ6uTLWSRGOxfHDg1IjKl4+3DCsW
	qOzSAJ5AOs0mCXFa8/0n/gnZF8LlVEEAfiPQ65lG0Luz1PLZapUvf+H7bX4w1A==
X-Gm-Gg: AYBFou0lG5jIchS6+uH7H3CY0H7x3a+QkX0fbn6Bzemm9vsIVJboRDLFfxkMk4YOttV
	ELBpqxED+fbJWa/rpTWzYLT5Niqs8Fv6RIswlC+QOhQFQj1lWitH+05UbLZPMgnom5z/U1xDFwp
	EidTeQklpGUAwmVdz5k98fpCVfRU84XNdKAPBSqNs8H2QPyZSUnM7je0FfnLeciOUhPuLSSanMF
	xJDB1BBRZqrtpKnR3zT/NdNB1FflB/gS+Xb5NGJ6dsy7mY6daA3hpgLap/FcYeFXpgBNU2iSmu5
	wzWJTylhsWdHZyTItqMeAlesrvzjYJe7OfCzARjLcKZZ3b0sRKms9Y5uzINQOZ6AveFYNC57E45
	k1ks5QjWz7Y3CP4Aqr3G9BuuTyY753Ei8d4X5LgP1yKGjisyMIshTlPEF7FBChy/2ycFx95j73F
	71riDt6sJzp+8vVSF2tEwJczgGm9x/P7ftPE7j/tvohSgGnccfiMDAt3+N8VZFu+MeXV17vnlX/
	h5m4pTBQ0byIR+snxvU56JgKk3IBwVhaGm//TI3g3beRFPXSsCRh25ciFRzI98h1zy4CfFAj6N3
	TKG+JarxzYUTiGDIOTUjdA8KUjYT3gzKHpkr0YLfcqDaCiAYBU6NujMNYXoWGHN/iU5eLoiF689
	5JkGYzxXr2MtritWsBwoIBTojV4z0cDiz5YDSVdIL9/eJdItca6H9hzxEEQ5bkyrv43k6Htk=
X-Received: by 2002:a05:6102:160c:b0:7cb:288a:b66d with SMTP id ada2fe7eead31-7d2a15989e3mr838027137.20.1793934090385;
        Thu, 05 Nov 2026 19:01:30 -0800 (PST)
Received: from gmail.com (223.230.150.34.bc.googleusercontent.com. [34.150.230.223])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99baea8e48csm854885241.10.2026.11.05.19.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 19:01:29 -0800 (PST)
Date: Thu, 05 Nov 2026 22:01:29 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Xia Yan <yanxia@cmss.chinamobile.com>, 
 willemdebruijn.kernel@gmail.com, 
 netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, 
 dsahern@kernel.org, 
 idosch@nvidia.com, 
 davem@davemloft.net, 
 edumazet@kernel.org, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 yana06070@163.com, 
 shuah@kernel.org, 
 linux-kselftest@vger.kernel.org, 
 willemb@google.com, 
 tpluszz77@gmail.com
Message-ID: <willemdebruijn.kernel.1e8c4e152eca9@gmail.com>
In-Reply-To: <20261106021245.246267-1-yanxia@cmss.chinamobile.com>
References: <20261104092240.15649-1-yanxia@cmss.chinamobile.com>
 <179387153949.488856.16266299848614841295@kernel.org>
 <20261106021245.246267-1-yanxia@cmss.chinamobile.com>
Subject: Re: [PATCH net v2 1/2] ipv6: fix cached route reuse for SO_MARK
 control messages
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Xia Yan wrote:
> Hi,
> 
> Thanks for the review. v2 fixes SO_MARK sends, including the concurrent
> sk_mark case that came up during the v1 review. Sends without an SO_MARK
> cmsg keep the current behavior.
> 
> Willem, you also raised the flowlabel and dscp cases in the v1 review:
> https://lore.kernel.org/netdev/willemdebruijn.kernel.6ba984cf38a@gmail.com/
> 
> I'd like to keep the SO_MARK fix targeted at net and handle the
> remaining cache issues separately in net-next. Does that split make
> sense to you?

Agreed that those additional concerns should not block this patch.

Are they net-next material, or similar bugs and thus also net?
 
> I'll wait for your feedback on the scope before posting v3.
> 
> v3 will also add a fwmark 0/0xffffffff prohibit rule to the
> connected-socket selftest, so reusing the cached route instead of doing
> a fresh lookup fails the explicit-zero cases.
> 
> Thanks,
> Xia Yan
> 
> pw-bot: cr
> 
> 


