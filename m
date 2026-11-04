Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.230.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793835298;
	b=xnVVw7AxuhxgRsF+Lusiz6TY3h1HvuiaLZtQw4fsX2ZOGddonr4qlX81p7cwEq8qR2ff
	 FlmAUmClaGYWFN8DBouNALqcytOtiICmLseSmuNschgS8PvKSKSyP3USxWVAOCnlgg0YY
	 cGJeu/iynP6lS0fZ9/JOCg+2QIHDqE9NGTdqYTSuH37WS5iJAPcKcD4kGJsd6BQIaHYDS
	 QvdrAxy7tHcCu60hzSxdYbE9sut6IKj5gP9xi6ctMNzZsvv/zc2A6faClLmF457BC8pyF
	 Yi5PrEjg+ODJwBTi9sKpElpoFpimhG4vcsgNZ1TwTz46zGfyOPBHEhgyjH4xG4DVnXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793835298;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=LfE6XYGuOtutQi6QIVbHin4gqCciGQW2WLAtGNmvG6Q=;
	b=tTIe1Yfm74JBN+QvL/Sx9OMX2r1e7t2stjjbflxP8m8wZqi9BO9XSA/phgW9ObPRcOw7
	 lI5MH3/6g3nYEzGzXOLcuGbG5PlBxHXakw1CqaH2+Pm0in24lRBbmiv9rFKpVwBsmL2ma
	 3nHQ5ix9O1B8HT0y82YNYyKo4dJm5fphIJST4/OFeXoqYqgkMNPTbh1ByHDX660ZpvqJq
	 rNoDnih41E2o3U7f+m/tGXOilZy5wM3b6NbnkJev+75m86iCAEu5WBrzkoOPn766EOkbj
	 6zqLEmn8dkF8Uap30lfc5gcihvLDmVHfDomWBAmdhVFHITv8PYJRd7uwUof8PLrNOxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=74.125.230.200
Received: from mail-qk2-f8.google.com (mail-qk2-f8.google.com [74.125.230.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC6C606A329
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 23:34:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5FC6C606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk2-f8.google.com with SMTP id af79cd13be357-9369a6afaf8so98008785a.0
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 15:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793835291; x=1794440091; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LfE6XYGuOtutQi6QIVbHin4gqCciGQW2WLAtGNmvG6Q=;
        b=oS7uv8AV9GQs+J3J5ITcjDbJ45MfrP5WlJdXu9KisS72I4zpWoRJN5mJENlCQNWjx6
         w6K20K4KUKSGFDrMS302lTQndqWgqfIIfYI4hiFH/mHVzQym9VVyMDrRCBCOb51DMcFl
         ofIQOr/qNDRlwNFNSvNiGZJyTOhzeJbFV8bAw8e+jKUTpwf9QgJv2xX1b7IFT5/ZC33z
         NtdznjXTZpPlty80dmkYSVqvYGXC19ugvUN86LkSV4Ng/wYHohFRzaMwCARIKOv50mQ3
         4t5AO2K5tdru0p2GZBx61QhznZr06ky45CDetlhp6aKoK/W9dCwWbUxhQLSjm/9isl9p
         5p3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793835291; x=1794440091;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LfE6XYGuOtutQi6QIVbHin4gqCciGQW2WLAtGNmvG6Q=;
        b=TK7f2nu6AOo9otCS5izRqFz+LYWjOz51JrYGPdP7dOPsZnbug0wiapMPPueJAjlJrW
         SLs6LUSN9xge3dMUh5HoQDTeX4+ixSuJZInSuZScWyFzop0SZGeWbAKHdzxnusAZmTIx
         wVpe/Ofe+/2Q9t8tCE7KaRgPqw96ntEA6eV0QfuS39BrXZUUfI8iJgrVSXe/7RfW50Ou
         S4rvekOuhsHw7ZPkXPZ/8rWQiB/wYSakTb+3wjPCoU5cb3qqPYHDPT5a4v6ONnKnL8ks
         hAUY2y4p6khVawS2X3sy0fn6cEl0AflytHs6cRZFjQehu11xmnSfr22IuH5LQRESnput
         9JVQ==
X-Forwarded-Encrypted: i=1; AKwUvBwoOhO/5H9JHJjSaKhbl3ej2g3xOCIo7d8Gn4fbVZ67EEjVh7UDJcG+VqWGUaNHDbcki6ER7Us=@vger.kernel.org
X-Gm-Message-State: APuU4Z9S5gYUDlL3fEhjQxuw66nU+JbOlGovKDeAV9LxBzcZKOpoaD5+
	n8sgsxetg6djKGkEIpL/6PGRHhxV2grBx/bCXDV4iKy3JKTHmmf1mwds
X-Gm-Gg: AYBFou3bZLIF2C+J791mbaLe95f3a1mVZCU2z7pVCNvIvdxiN8f7d8lA0YAb5qASyrg
	5ii5dnKsSLWXziDa2OmIbAu1RWDCVSLZ56k5guGM2/fdw/yK1d5okrgFTMQ4iUv5fbDkNGbI+tu
	qY7D9qD22xWWHERmW0Srcun4+KMZUlbXxzjWyfaC8hqUZCEWquhg4cBO76wpQ/xyTP3t0Gqqz3t
	Ytr64jiM2s5osBPyiYWsGbRMHilXD3Zhq/9mGiHsoGIurnGkdIvSRCKsEyJgMTb1QCpRnQ6bMKo
	HAPbZ0cMuO0wi+4qUae+fvcsUkgOB+S/OwQjgyehjPCacEdH6+v6Ox3liWeQtEg2VoYpvihJhYu
	8lN3RJFTPNVaAl2krzacjC23ppj5AmQQ+ka9bS5U5257tQYAA1DxsAaYDHgdDcKn6PU2zNYtSaD
	JGJO40u9k3+Y1XJHLfXXilrBZW47HwUGv6cx5/Ok61rqJfAYnJ75jSzydKIQF3gti5J4GWj4+NY
	IEwFosBQVw395lf+7rXE+sBUSLZRnM8+lNA/YM1EhVSncrXEKaqrPSjWV8PxK5sEDKEKDqtxikl
	7wckRxVO4unFbwATqL8bkyW86L2PxwdZ3gE=
X-Received: by 2002:a05:620a:2994:b0:939:4a44:5f99 with SMTP id af79cd13be357-9442156ab2fmr2992527785a.10.1793835291266;
        Wed, 04 Nov 2026 15:34:51 -0800 (PST)
Received: from [10.0.0.48] ([71.69.222.122])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d488f183sm324141685a.39.2026.11.04.15.34.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 15:34:50 -0800 (PST)
Message-ID: <0f61c649-6e27-4f09-a69f-026f91d89848@gmail.com>
Date: Wed, 4 Nov 2026 18:34:48 -0500
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
Subject: Re: [PATCH net-next v5 4/6] tls: update the RX key when a KeyUpdate
 is received
To: sashiko-reviews@lists.linux.dev
Cc: John Fastabend <john.fastabend@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Hannes Reinecke <hare@kernel.org>, Chuck Lever <cel@kernel.org>,
 kernel-tls-handshake@lists.linux.dev, linux-nvme@lists.infradead.org,
 Alistair Francis <alistair.francis@wdc.com>
References: <20261103-keyupdate-rfc-v5-0-de1ab90a88d5@gmail.com>
 <20261103-keyupdate-rfc-v5-4-de1ab90a88d5@gmail.com>
 <sashiko-outbox-198140@kernel.org>
Content-Language: en-US
From: Martin Belanger <martin.nvme.dev@gmail.com>
In-Reply-To: <sashiko-outbox-198140@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/4/26 16:43, sashiko-bot@kernel.org wrote:
 > > +   memcpy(crypto_info_salt(info, cipher_desc), iv, cipher_desc->salt);
 > > +   memcpy(crypto_info_iv(info, cipher_desc), iv + cipher_desc->salt,
 > > +          cipher_desc->iv);
 >
 > [Severity: High]
 > Won't these memcpy() calls trigger a CONFIG_FORTIFY_SOURCE field-spanning
 > write warning when tls_check_pending_rekey() -> tls_keyupdate_rx() ->
 > tls_keyupdate_rekey() runs on a socket with a registered traffic secret?

I could not reproduce this. I built with CONFIG_FORTIFY_SOURCE=y and
GCC 15.2 and ran the keyupdate selftest with TLS 1.3 AES-GCM. There
was no warning. In this build, __member_size() and __struct_size() of
both destinations are unknown (-1), so the field check is not compiled
in.

The result depends on the compiler. A small user space copy of this
pattern gives a member size of 0 with GCC. In the next version I will
take the info pointer from the union itself, as c43c1c24f3cd does for
the same reason.

Martin
