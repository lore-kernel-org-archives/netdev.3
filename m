Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794478519;
	b=BIMjePN3ZiXcNdfk4RZFOOMtEtnYuBN7ZJfGHBfBIwH0SaG5dWv20hIUZOaj3Q3SNoiT
	 61ZQyDHCxzHCIoSkYaHs1yU+GbqOxZaJK6jbLd5xsK76+rsUtNf0dvSv5IYFYqRQA0HvS
	 CfbRsD+UW9JUCYz8C1aX0RBK4M4h84+8UcoiA3oeWOOWFLzExyZdeiPxUaWBSNdLx+DK2
	 aswVS/zlSu2RF2nWVHbYPgOGl8GX3XS9sHVJcOnAVaVFTcwT5FeHW+qW/vlR1IYdOoflm
	 o87+rXINgCPoC+M89v+pRyM6+qT0w/17D7X/sN+w0OyoCuzduOegaeFzPZX5xxA65jA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794478519;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Content-Transfer-Encoding:Message-Id:References:To:X-Mailer;
	bh=/1Q/PUELyNwj2qbyBRmSt0cgWWpENEFwGaSV2JeSfBc=;
	b=GgwhKQXUP2hRd4tMZn/DHXApY3PdwYvQ8VqQh71aBJtjMBwnu51Gg1HSGiTPecGTqDcY
	 UX5sedpNCSuWzedr+NKuDkQB8jCxbhbOg6r983QvUIbPd3sc3fYZWnKUvhQN4D19ludEo
	 aXQRBAM53TwxYQw9dqjPRXHz/QSek1+kAp7tfddbw6bmQvhLuOaMx0/bWmXgb+hcB6HdF
	 RqMWIXLoF6OoyHK0ra0mVC3VKsFejMPDoLD0jPEDsihK6Pgv71wVNRH4gJCXpNtoc3HV9
	 rcqvMjW3YTTa/WxvMPdkZDcqy9gavI80Gu0Fd16fedEtYWDlkXxi4IXQy50q6/q4YiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o28cZZr9;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73376606A881
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 10:15:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73376606A881
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o28cZZr9
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a60f9474c4so50242595e9.0
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 02:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794478518; x=1795083318; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/1Q/PUELyNwj2qbyBRmSt0cgWWpENEFwGaSV2JeSfBc=;
        b=o28cZZr9g9jpgYFv2IkAdXN/FB30Ic2Om9QMaoI9ptc/Dkeq/fsb+ikjytptwp0jTM
         q7tA+X/K+O3Pk/FuYrVXthU4TrnP+3E5EnIejJqCn4boNKG0biOUA1GBrf8AzQRzIKH0
         xnKEjzYujKDlA1FV+NPcLYP2vrl1DKhmkwduP1Uc4aMXEHNihvTgDDQGppuRJ/4052qn
         GF6GrrWInW2v27loCh6kOUH4RlNMIHanQVUhdsRRlLvWW2afxHB5CbP39iByEX29auVe
         ex756m+6QLhIlcsHJjwFiCK1RJWKoo3OtKPZstJAJp43gXOtrqW5njw0txhEY1AupJGt
         V9Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794478518; x=1795083318;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/1Q/PUELyNwj2qbyBRmSt0cgWWpENEFwGaSV2JeSfBc=;
        b=qIBWGWRsNHJDUrtHBGxqhBocnuXRyrZTREH0QTGjfuLSnGTZmVBqiesbk6uABvSbQm
         Gr3/PAxWvzI9sY3pfEP6hGKK8fGKbyvrW+LXxBM5MJa1iCTOGVwyJiXWORFbZk3C6Gfc
         1ElyX6+MGgmGyD7lld4u4Y5QO/krTfdt7R++K1btAM2OlhaacCSGLCwRZOrA0lQc/V28
         E959bx6/HVeBOPRBts+BrgvWYrbalmilw5BUZnmUwdfUljMD5WFZ4Xz1xZoISKKcK/sI
         idOjq2pEn+/mNUg+UAKxGQ398MHvUepTTejtumrNnZeOCTTgOfTJGRMhHtTeder/5YcA
         msQg==
X-Forwarded-Encrypted: i=1; AL+hErGl1NT1HimrSgobxnev5GFQfgl/nLxgyt2qQAGvn7hvLEPDF+Vobvy4zOaSLPSGwKZIKdOJCTc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8GPOj5F9kKEZQ/vXuDxU+fXrq6xLS0GhybJ3opSPFHXPmRibvw
	FG4K5SdbcOMYzki/UmrkJZBeDFSx3copqccjxFWb7jKRN7UtpcXvPP5W
X-Gm-Gg: AYBFou1b+XF2hsdMMnrerOWl2Qtcvo7scLobnBX+5MFi8MSyGulKgombuoMT+k2kykK
	hLy8px3AYd6SnQI2GGyazY5AnpminlE4vybPIfBF2UMxR2dI7QB9N6vQoaUtvmfPbwLtD5oN1Fa
	nDghmmG9YbkndtgYfHDN0N/ccMpDvmD9ZEOo5WtKaLaODnvQIFNCnHh0jho+AHw2u9DXhsxzEfa
	2uEo8zgdFnoS9co8uNgk1Yd+wJemAWTc+K5XiDZ+kfcAPl6hJRzg9sxItyrjevx98iDXHySitmY
	kFLBkMXrrNei6Ou/V1brnsolXwpAK91zxF6gcyqofT+hfxVVl8jAJeAGOqmtEWd1JIIT7KA860d
	KpGUYBdAQYFl1WNz3Y0GBkgiGxySTeRsdnUMrJY7Evtya+2M8BfIn4aVPVMc8n7hEneeEzNptKh
	/EaaJfrIGK2fBzNlTNT6E8El59DVM4yF31tPeYtp7HxCsjfM1FbAMRvYEdkvq6JGh8zMdQM6/ha
	I2/TEIviRECYXuuPkg66D+Bzfgnb5HESqiakKWe2gEQMS79UsHX/a2xjjZaHn+QYKncUk4/hFUa
	8+wiRGrYqs2F/eU8+dJ8tYbn0Gqr5iXRXedJJ0fzeD6910rD3bI=
X-Received: by 2002:a05:600d:2:b0:4bb:52bd:a3c7 with SMTP id 5b1f17b1804b1-4bb52bda3e9mr9993475e9.6.1794478517767;
        Thu, 12 Nov 2026 02:15:17 -0800 (PST)
Received: from smtpclient.apple ([217.111.110.194])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e26700fsm66747305e9.10.2026.11.12.02.15.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Nov 2026 02:15:17 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.200.71.1.16\))
Subject: Re: [PATCH ipsec v2 4/7] xfrm: prevent AES-GCM nonce reuse after
 early GSO
From: Usman Malik <usmalik90@gmail.com>
In-Reply-To: <20261108142652.1330952-5-Jeremy.Jean@oss.cyber.gouv.fr>
Date: Thu, 12 Nov 2026 11:15:06 +0100
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Sabrina Dubroca <sd@queasysnail.net>,
 "David S. Miller" <davem@davemloft.net>,
 Boris Pismenny <borisp@nvidia.com>,
 Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leonro@nvidia.com>,
 Tariq Toukan <tariqt@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>,
 netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <7A2301CE-C145-4CB2-81CA-4A2BACBA8430@gmail.com>
References: <20261108142652.1330952-1-Jeremy.Jean@oss.cyber.gouv.fr>
 <20261108142652.1330952-5-Jeremy.Jean@oss.cyber.gouv.fr>
To: =?utf-8?B?SsOpcsOpbXkgSmVhbg==?= <Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailer: Apple Mail (2.3901.200.71.1.16)

On Sun, 8 Nov 2026 14:26:49 +0000, Jeremy Jean wrote:
> With software ESP offload, xfrm_output() attaches a secpath before
> calling xfrm_output_gso() for an encapsulated GSO packet, but
> skb_gso_segment() leaves the splitted skbs sharing the same secpath,
> including xo->seq.

I tested v1 of this patch and posted the results in the v1 thread:
=
https://lore.kernel.org/netdev/20260930144523.435271-6-Jeremy.Jean@oss.cyb=
er.gouv.fr/T/

In v2 only the commit message and the code comment changed, the code
is the same, so the results hold.

Tested-by: Usman Malik <usmanmalik@engineer.com>

