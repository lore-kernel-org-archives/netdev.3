Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4035E2DF3EA
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 05:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785390993; cv=none; b=m0mp1dfMUkMv/mcTP9qtyxB5jQ98WXcxUyPlRA5PnfKdu+8IhTcFyc/9jpN9p9kKtvR9+7DMxy6F23ash7+MRMOVadPhnJDJBmuNi2/1hTmn838GhrqhtctVYRghhhIkE2Iq4qyJpj3iL6bOZNyPk7J9rBqrEBllEr9LE1JBBOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785390993; c=relaxed/simple;
	bh=o1NAtXUM77f8CaQTUoM+7CGl+oHgdtjC6myhU2vayAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tI2pczbJF85jPtABkg4qnqjuQfQwmxnKIaSL6zMOyV9m81ML1EydprYq4NO3inp7wI+eL/HAX/mX/YGw8x301tRTouWniwO26dLrRxEUgNW7UhtqFD8LP+76kRYzPcDQzN9NIRoQ8gM8HXUTO7JeLuZ2lgP7jZVWFqsYCiRyxM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PMzkPvQh; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PMzkPvQh"
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2ceae1ed204so22330745ad.0
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 22:56:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785390991; x=1785995791;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=o1NAtXUM77f8CaQTUoM+7CGl+oHgdtjC6myhU2vayAE=;
        b=a4Wh/eJhHFhFD6voPk9ccwfv9zN/ys7r+FSNZCJpIgCWsm7OGlctcdGBMJBjDvv1JB
         VzMx8N64ufmQpYRdSf+/3rucSR3oD0kDW1dKdsUeBGOHcWhRDerGMCzh98fdR+CFfhsJ
         9RQ2x8lpDZIsUDejietu5J+w9NqyLVuC3gMVXjqUagAI/UasE/BQvgp3sja8FHBAp/PW
         rz10l30JIU5D7Nrv1DuLLweKLt6+tPOMkj7XiIQh2sqsxXod8E/E+DeWsdUCL2Aq6A9k
         E+4RFcPwFqlF5vIF8pMLUZ6of+Rk2rDZVz4RFn6paT0OiQwOULIMcC9uQo+XVMmva8Fz
         pF2g==
X-Forwarded-Encrypted: i=1; AHgh+RoCV12b8tDE69AsE44UDdWE8YByX54N8f6et4OvNqJ01iO88Fh5nL0iZQBkNacsdV3ZOuX8ZzM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmQOftYKRbXIHkTOSNOqWBi8cXDKmobCQ8bppMAadtLxUaPYi6
	CcDIsVq7XSLUbPmYqM7QEhZp1DPB1TP22SAoAtLbkSknGXiJMoep35g1Oqae8AD0nXjh04yVS5W
	KSu9ZNQKjjs21+zeRQZAHoEbbd68pNk5HTU0PGQF7uTTDo3HuXhb4D4VK02XS6voYKjaJxVPYfw
	WJmHVMUizWPlHzOolAZIoOA3csqyuar919laeJN41rNMjQGvR68t+vrxVrY/nCHkMkJEz5ECLUX
	1WmeBZEww==
X-Gm-Gg: AR+sD13J49V+QmFHge1F4AErvfNJBk5H2IntjrhzT1mGW+xT4pZuCU1/Sq3TGL7QrM5
	3IDIaidZzOe24QL7M6q14te5+h9tV2Hv2poX3ljqJSu86sTxYxSIzR9NRyyzVN3ZDKNI9gAHnl6
	S1yMxCjuvJe971+wK2PWr7t62VVTQfMPFmeb7YSEMXwwFekHAYCCxY2vYY81hYDH1VOS63JYgc1
	fcbqzKzrIaQ8OwRrw0aRnYplUatHU7dAMr+pCAoVFlBFohshFIYyZzyUAqrOf0oAOKhO7U+rLnN
	2Uwdmq6/Hk3K9CV6bIaTdcUP0sEl2s2SDXDxhAguVzaRmMQjOOwkhKUIzcTCflGarVf0DaT5gRm
	/3Xq9GWMYnP1L2xTV/LwYaNsiXpe1tcZ7orc19JZb5Oe8OZMGXrCAC/ffKMm7j+cdEnfpFioJvs
	/EBPYx6MYUmYJzI0gk9xioyx2CvO+uzpyzHA==
X-Received: by 2002:a17:903:17cd:b0:2c9:c083:cd50 with SMTP id d9443c01a7336-2d035bd2804mr12774535ad.17.1785390991420;
        Wed, 29 Jul 2026 22:56:31 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-27.dlp.protect.broadcom.com. [144.49.247.27])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2d022c1dd6dsm4037375ad.39.2026.07.29.22.56.31
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Jul 2026 22:56:31 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-977cd2ddcadso440293241.1
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 22:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1785390990; x=1785995790; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o1NAtXUM77f8CaQTUoM+7CGl+oHgdtjC6myhU2vayAE=;
        b=PMzkPvQhQ6AskUE3zkrwteROZssAtliw0of4en6EPOjC5L6DLd1nZ5AA+3GImKTIa0
         vvf7qCIwgNDmzuTvXdAKQ7GGv+ZVCIBTSOM4KaIj29V9FGSqJTE9mJnAqhoLb+T7g1ve
         kxfkj64KB4DLj0AJ6cGPoxog/TaCt7Guvl2ZU=
X-Forwarded-Encrypted: i=1; AHgh+Rr+ZNEULg4oGULsVSdNqG9a39wITtJ1kdHCaKza+eTJiyTXm1HBE/BthiFDZUx3YVxznPTnmGw=@vger.kernel.org
X-Received: by 2002:a05:6102:1612:b0:740:2bcd:24d2 with SMTP id ada2fe7eead31-7574dcc8e24mr460797137.5.1785390990060;
        Wed, 29 Jul 2026 22:56:30 -0700 (PDT)
X-Received: by 2002:a05:6102:1612:b0:740:2bcd:24d2 with SMTP id
 ada2fe7eead31-7574dcc8e24mr460790137.5.1785390989729; Wed, 29 Jul 2026
 22:56:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724142954.3101980-1-vikas.gupta@broadcom.com> <20260729163352.6e0b9bc5@kernel.org>
In-Reply-To: <20260729163352.6e0b9bc5@kernel.org>
From: Vikas Gupta <vikas.gupta@broadcom.com>
Date: Thu, 30 Jul 2026 11:26:17 +0530
X-Gm-Features: AUfX_mzCcBYqekHD3P4HsWXs5t2lIwp1q_7VpYIFECKs37TbqUUALNWOsbGT83g
Message-ID: <CAHLZf_tb5+JmoP9=LyKDwnmsSTzefC7py0U6HN17hGYqvU8jpA@mail.gmail.com>
Subject: Re: [PATCH net-next 0/4] bnge: add more functionality
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bhargava.marreddy@broadcom.com, 
	rahul-rg.gupta@broadcom.com, vsrama-krishna.nemani@broadcom.com, 
	rajashekar.hudumula@broadcom.com, dharmender.garg@broadcom.com, 
	ajit.khaparde@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000c3bf720657cdbb85"

--000000000000c3bf720657cdbb85
Content-Type: text/plain; charset="UTF-8"

> If you have to respin - there are 4 patches in the series.
>
> Sashikos point at bugs in the EAGAIN flow handling in
> ndo_set_rx_mode_async. Can you double check that?

 Yes, I need to generate a new spin to resolve the EAGAIN issue and
address the other comments.

>
> https://sashiko.dev/#/patchset/20260724142954.3101980-2-vikas.gupta@broadcom.com
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260724142954.3101980-2-vikas.gupta@broadcom.com
>
> And the concern about IRQs being in use on shutdown perhaps.

 Since the IRQ issue stems from the new shared bng_re RoCE driver, and
it lacks a bng_re_shutdown
 implementation to free the IRQs, should we implement this in the
current series, especially given that
 the bng_re driver implementation is currently minimal?

Thanks,
Vikas

--000000000000c3bf720657cdbb85
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
ZKzsTDzWEhPsCM5DcbMg/B7eD9n+rBWHxsk+yKJKdkLpkpTKdxxTd1Y5Ln+k5KCTjxlCUQQ7Q2Zz
qYU8bfRq5ZMwUVJD3NZCqEKbEIgSX2vXFS61zdPwnLyHyaC/erAWmgHLu4kzpk/V10NcnUjX9FYK
f/Ggi9MeMNG20gEIUbCg3RgYf89YLXUJDOuoz/Yajw/VuiVlwS81wF44DmJhAVcGzrI00uydpksG
oQY2qVlhYsvNTqU2V/uaBrKQnyM0PkU140cCAwEAAaOCAdwwggHYMA4GA1UdDwEB/wQEAwIFoDAM
BgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3NlY3Vy
ZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEFBQcw
AYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1UdIARe
MFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIBFiZo
dHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAyhjBo
dHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwIwYDVR0RBBww
GoEYdmlrYXMuZ3VwdGFAYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwMEMB8GA1UdIwQY
MBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBQI6pBWVwIN47wGrC1m7lYfqN94QjAN
BgkqhkiG9w0BAQsFAAOCAgEAOdSnSEyuTvTtsnmEilB0JfgRKx1MM7kNdv0pfWcINJhssfHD8Fc5
wm+JzenYR9yJAkntX0Lr9yv+OG0Jqhvy7u9gKljfI4jXO4qxZ2jf1YvI+fDK29/NV3JAQuipT3Vs
IxBI73CQO11VwMePOTsUNM1s+9cWT5zLuqOEEu+95jRo5KEtH1/4nahrToLU1Y+flylsBaAUhB72
KoBBzdewa+psa32lY8X23AWDoczIlUBmPt0hmApBvHOUCYszSiBu4/VhVDuq2iMBtnYAj2j9Q7Ct
pZHPj6fQv247S9dTDDym05r8arHAsUw7B29KvPfxeaqexL4gwQQjIsfdZeh88XYLXA+mvEej6OlO
YO3546G7bczFxIjO6V9RrvYEeAb+n7udXYymuIm02XtxIkr/Uk0gRuFoOpG2Dw1OH8xsOUER1+16
qGb2QKMgaKL/IIM3gXAuCxNVBOT+Fj/wh5hw7MFvTTXPFA8IKusoHZYpxdrr9xjoJ/wt6j4/E6K4
IO/WuSc4nM6kshiwIu5c6r97213ZtJFOrjoITiBIYFP0WQsTsEbWvaBX/7daT5IVr9rvCOCk2JA8
bOWwP4OYXCKJY5nZOntb0ECSI7RM0kGelGY4MAD42+OBWHxKU1Qvt5WK4kIXdKpdFp9Drv17PyCU
dR4AvAJyWnkqZyi5QuRg/hMxggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBH
bG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAyMDIz
Agxt8eaxmNwH4eu5pUowDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIAiZZBrwzWkt
OlXZOhQVkhAqOPPycQHFK8Mmdxm9FgKGMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTI2MDczMDA1NTYzMFowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUD
BAIBMA0GCSqGSIb3DQEBAQUABIIBAFYiN+EO7cFsNHC02nLpJ0phpTSVgqEUVRuXhwJujfXTEuaM
FIXAjVwIsnVE3qV0/RKiUkfNLKojveZdXGr0AKcBxRycdHSRT4BWCg4bQCkMP08xYA9STihVgUgI
xCidT8UhariFE879zz90hWL+KdVkB9UsbZCCbdSVsLIgiktQSllCV6MMRa5Uj7d/AnSCd8M2K4Vt
PHV/+jDRMzegAMVPcxwbtjtY0k0IdDfVofk0PHKXyhx4i5iAQK3wTmNnA/LAVLDTkhTuXSBnIRZa
hps9cipQZBqA6o5oCJQQFzl4w6eOlMLx9S/4x3DejKDqNUiGL23KSYlTv9SY2/OvccU=
--000000000000c3bf720657cdbb85--
