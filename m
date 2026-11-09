Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.97
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794216181;
	b=ObAU7cZYQ7VueBP+ePi9wtXDGZT5owpX49lOXnaN3A1qE9d4mYlZEEE7z6scMetIo71T
	 mGUYK0QdzedbXpOhW4gbXaKkfiZJeFKGi5UX4n+lM9INNL1ijDJQzxK3JLTeBGhkv893/
	 m//xQqvCVzq2nXpbjYy96m1TeXZGSb5hG16bhEa5ZFLrFFfIUh6dxQ7Z0XYTRjT71KuHI
	 M6K6AJ0LdvVrlqshxeCfqafiT9PfzgkFlMl9L4rufegY4TqmajATpW4DTFIfqNrb0SrWF
	 BUv72u8qnS3DmoiO2Gwe12UFHVXemE6KxJShs8fuxdmBTY6Df/p6uju3mvZV1JmsNFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794216181;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-DetectorID-Processed:
	 Content-Type;
	bh=km89tEkrvlRmZOWMQmvYOqAYa0Gf5YWMP8s2MMfPFug=;
	b=xW3Of8+8Oj2Bfeu6DNnsZoFgl6QVE+znYebOoBsZ716vsgIJIeF0JIO350XD/b8jMIB6
	 ktpvZV5ZvVy9YUdw+fMDNTztLkxFEEfllprJy10HPwcgo1FJpmG3JtuKtahMV4o+gt+X9
	 dvMLpILw4Y5D9RYbz/v5+IeLstWUsoOVEv1xJgJutQyypBj+HWZtxjw2YdehIruagwBMA
	 1i/6ZKU3waXqFfjWavsIp6QpH2VIj6amn4J+YSlRGhPKqGRc5aaZiX0lWjeVmKXNbpEgf
	 gjUZrcxDubN3YkfG1aBCYDgTYjnWEqEgiQaY8mL6XGHYpsVBKqPNEx2sH2cPFjfH7oA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=V7JVV79x;
	arc=none smtp.remote-ip=74.125.82.97
Received: from mail-dl1-f97.google.com (mail-dl1-f97.google.com [74.125.82.97])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06F6606A333
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 09:23:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E06F6606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=V7JVV79x
Received: by mail-dl1-f97.google.com with SMTP id a92af1059eb24-1b244fb7fffso713552c88.1
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 01:23:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794216180; x=1794820980;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=km89tEkrvlRmZOWMQmvYOqAYa0Gf5YWMP8s2MMfPFug=;
        b=BwTxxHo1u3ePsOam3xaWJ/HIMhnonX5VCPKyMehYTuP8mPg7kMmpFqQVjpYmb+urq+
         kEBRnuQsjZR303+VNF5aWsu6ZBosqJpq/9yYWL+7ckkq1iybX7UrENU//9nf30wqRx9S
         RP3sbqWP7vVKhqzjLncP9nf1WA4X08p5jZGKiMXd9bcoWUp+YdAfyRKrg53AiTVXHXL+
         w5Y1sXoJ3I2/FVkGhf4J7+dPFiDmqEiP5855yCHwiZwExdEriN+6uqnew5Y1/qCcGlMD
         y9YWdCBjD8JNlOTz6E2vjD+Soyuoi5VopD4Opc/cPlS74R+zZUc3z+wiufB1UGEW0cH8
         676w==
X-Forwarded-Encrypted: i=1; AL+hErHoUJvASnfmZ44InDXGDN4Z2vtWH8S+NoXfJehvRi3Gc9RsYaXWxHzishmEG2atpxg1VJ1ylvM=@vger.kernel.org
X-Gm-Message-State: APuU4Z91YBAkjGcvtcnuc0uWmvdOHQOE5UB/wcaxF6Vx1w51o6uC2b2Y
	4pJm8kAalKL+YKAKU4F/6ci6Y6bimAMYYAFiB8DjsqGXpa8YLhIopHMfIuQnoF6E5kc5u1BqOmG
	kH+essu69FEQkdcyWr+albIhd2mJckDuh/0t7Wn8DQczKaSlEHd3P2BZLZ8j0em0PZbjFTBgrId
	HMPK4K20AH1g9zApdDMbndj3Csd2cLZ6kbNl27IseLC/LHoM2geV23jBuBsejloioHPRIh22P+x
	8FuqaKpOYM=
X-Gm-Gg: AYBFou2n8NMSjAE2Zpw+//lBIJmnRC+lu6vQKKhx1TsbBro8ZcIMcjYrfRvu2HHJm0t
	abcMa1c9zsnf8hkHPPhTSmIhzl1Og1nmxxDTVQgRZzOYQnm+qyqYj1SMwatQUSuxle5PSE/c/Eb
	v+eYWXgpnDG1jKowqxiTBuUx6gI9X3PUXBIM9CXspF57orML20BtBfCDz6bucSefDYZ2dHrwBVc
	qZ9OkLiMOg/1wtVltlySm2uAVLa0+zudEKHqv4q8tS1wle5Ah6BbqG0nQmjibBcGzD/xk5bBOZt
	f1VAeeUjZ7Nu7YpuSKw7WXCdBfrfXqGBEp9zO8lmUwepOFlGSlotf7kORwbmqEx2EQSBgV6fozm
	SKrdmV03AHY9YITZv6AfzJCUFBMNlljePA8E3ye6J6nggk+B+9ZMSryc7fnu01Ove1V9+TLrzzf
	jhwVucrN2IEpCOjFLWFADZTNjb0b1d7HSe5tQ=
X-Received: by 2002:a05:7022:f507:b0:168:3243:c91a with SMTP id a92af1059eb24-1b39fe88720mr5470140c88.13.1794216179570;
        Mon, 09 Nov 2026 01:22:59 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id a92af1059eb24-1b380e1ec1asm39515c88.16.2026.11.09.01.22.59
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Nov 2026 01:22:59 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8b930598cf0so754248b3a.1
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 01:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794216178; x=1794820978; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=km89tEkrvlRmZOWMQmvYOqAYa0Gf5YWMP8s2MMfPFug=;
        b=V7JVV79xCPPULDLA1J1KQuMUMU9HE5I7XTvlzm4mIptbuYsi20q6GzSpW9ff+VWVlN
         92RUepT44qGxf7GrBxtlmls3tRRol/Zc57v068PVlnA8/qQS+FTk5+c3j3lkQRil2D9W
         9qtvh9ehrTs5QmFvUQgMNsLx25iy6lCyljJdM=
X-Forwarded-Encrypted: i=1; AL+hErEGVisVmnAWJJXG5MZI1WVhgNSC1vOiWvYPW/brQzY3TTHPuhftiMQPo5oatGI3MEPVtkYMyUE=@vger.kernel.org
X-Received: by 2002:a05:6a00:1399:b0:873:f7a4:433f with SMTP id d2e1a72fcca58-8b66e632e33mr2873300b3a.26.1794216177766;
        Mon, 09 Nov 2026 01:22:57 -0800 (PST)
X-Received: by 2002:a05:6a00:1399:b0:873:f7a4:433f with SMTP id
 d2e1a72fcca58-8b66e632e33mr2873285b3a.26.1794216177270; Mon, 09 Nov 2026
 01:22:57 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261108065526.710152-5-pavan.chebbi@broadcom.com> <179421058284.994134.5773030258623536643@kernel.org>
In-Reply-To: <179421058284.994134.5773030258623536643@kernel.org>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Mon, 9 Nov 2026 14:52:44 +0530
X-Gm-Features: AclHuK8x7Pcq-67IuK1G07XNWBIzKDeTm5dxLmTlLWbT3_mYCSlZg61N8BY76u8
Message-ID: <CALs4sv3qcRCJvDZZS+EmiSo5KPATDzUT=Xmk7CyvVYHSBKjvRw@mail.gmail.com>
Subject: Re: [PATCH net 4/4] tg3: Fix heap overflow in unbuffered NVRAM write path
To: netdev-bot+sashiko@kernel.org
Cc: michael.chan@broadcom.com, kuba@kernel.org, andrew+netdev@lunn.ch, 
	andrew.gospodarek@broadcom.com, davem@davemloft.net, edumazet@kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, shravya.k-n@broadcom.com, 
	vishvambar.panth-s@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000f24881065fd4811b"

--000000000000f24881065fd4811b
Content-Type: text/plain; charset="UTF-8"

> [Severity: Low]
> Is "theoretical" accurate for the buf += size part of this fix?
>

Agreed.  The buf += size part is not theoretical, it is reachable with
ethtool -E on unbuffered flash.
We will amend the commit.

<-->
> [Severity: High]
> Does this fix hold up on SST flash parts?
>

That is a separate problem from the one this patch fixes.  It has been
there since the original code, and this patch does not change anything
regarding that part.
The heap overflow this patch fixes is the memcpy() of pagesize bytes
at a non-zero page_off, which applies to every unbuffered part.

<-->
> [Severity: Medium]
> What happens here when tp->nvram_pagesize is 0?
>

Agreed. We will reject a zero page size with -EINVAL before allocating
the buffer, in the v2

--000000000000f24881065fd4811b
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
/HTPxpDrr4vzZL0yoc9XefyCbdiwfyFl99oBekp+1ZxXc5bZsVhRPVyEWFtCys66nqu5cU2GPT3a
ySQEHOtIKyGGgzMVvitOzO2suQkoMvu/swsftfgCY/PObdlBZhv0BD97+WwR6CQJh/YEuDDEHYCy
NDeiVtF3/jwT04bHB7lR9n+AiCSLr9wlgBHGdBFIOmT/XMX3K8fuMMGLq9PpGQEMvYa9QTkE9+zc
MddiNNh1xtCTG0+kC7KIttdXTnffisXKsX44B8ECAwEAAaOCAd0wggHZMA4GA1UdDwEB/wQEAwIF
oDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3Nl
Y3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEF
BQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1Ud
IAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIB
FiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAy
hjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwJAYDVR0R
BB0wG4EZcGF2YW4uY2hlYmJpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBQAKTaeXHq6D68tUC3boCOFGLCgkjAdBgNVHQ4EFgQUxJ6fps/yOGneJRYDWUKPuLPk
miYwDQYJKoZIhvcNAQELBQADggIBAI2j2qBMKYV8SLK1ysjOOS54Lpm3geezjBYrWor/BAKGP7kT
QN61VWg3QlZqiX21KLNeBWzJH7r+zWiS8ykHApTnBlTjfNGF8ihZz7GkpBTa3xDW5rT/oLfyVQ5k
Wr2OZ268FfZPyAgHYnrfhmojupPS4c7bT9fQyep3P0sAm6TQxmhLDh/HcsloIn7w1QywGRyesbRw
CFkRbTnhhTS9Tz3pYs5kHbphHY5oF3HNdKgFPrfpF9ei6dL4LlwvQgNlRB6PhdUBL80CJ0UlY2Oz
jIAKPusiSluFH+NvwqsI8VuId34ug+B5VOM2dWXR/jY0as0Va5Fpjpn1G+jG2pzr1FQu2OHR5GAh
6Uw50Yh3H77mYK67fCzQVcHrl0qdOLSZVsz/T3qjRGjAZlIDyFRjewxLNunJl/TGtu1jk1ij7Uzh
PtF4nfZaVnWJowp/gE+Hr21BXA1nj+wBINHA0eufDHd/Y0/MLK+++i3gPTermGBIfadXUj8NGCGe
eIj4fd2b29HwMCvfX78QR4JQM9dkDoD1ZFClV17bxRPtxhwEU8DzzcGlLfKJhj8IxkLoww9hqNul
Md+LwA5kUTLPBBl9irP7Rn3jfftdK1MgrNyomyZUZSI1pisbv0Zn/ru3KD3QZLE17esvHAqCfXAZ
a2vE+o+ZbomB5XkihtQpb/DYrfjAMYICVzCCAlMCAQEwYjBSMQswCQYDVQQGEwJCRTEZMBcGA1UE
ChMQR2xvYmFsU2lnbiBudi1zYTEoMCYGA1UEAxMfR2xvYmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0Eg
MjAyMwIMClwVCDIzIfrgd31IMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCAvDFp2
Ny1MTzhoJWBz3q3fPr1FgJPETdYJPearYd2dEjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjExMDkwOTIyNThaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBD7SQC1/YfTkpOW9Me1NIHXyKs5NubSn+VtpgR6pT4
Pk1NJfkiLFxGXy5yt24siWc9OpkutWSC/mNCpIvZ33IxiGBD1wvbCD4+ZsGmb5gIaKG+QgR3n+RO
qj069yp81651klEg5NNBLIr9Slqze5YnKNZTgj92gfMDFItlkBMhta/fkVOCTKrUFdJ9qjBxk6hE
UQM5YCRgDnktFupdrHD2rtoP8NKDwI4gMrDv1erc5q0vrTmxcQXyDkEFk81xFLROOJu2tolw/o+N
NaNZ8gBD5y9mP0mo1f5y1MveLwrabZGsfxepI5K8bibtZbj4ZLjbUwE4ihZ3tDx4bNVGAvsn
--000000000000f24881065fd4811b--
