Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.97
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793293756;
	b=znKbfFxVaLPJT3bG2IwG9+QjNFO5R+YY/s7188ALZK3UmDnHbdPClwHpym3y9VoAxPCz
	 F/Wzi5uKEsZMRX25S7pn4xw7udYHPqwNZcAGza//nYx4lMRxmPDEy4aGq9pHcddjzc7YQ
	 /EO96a0lvCR+kb7aPXS5NGWVqFnlIeEFQuF+YdKPoMQ1pq5lGG7itno13fOYvypfMyXRu
	 3zVCLxnP51oVA8eT32l6LWRP8m8fnSJlvtprLl/6vgnl4E6frtkxkQ4qRjhRs3dC0Mb0t
	 QyMk+YcgTLMqNDbw9Bqwa9wD0WW3cZsMKtihe4ZBCeH0ioKoNH6imJZq/5KvY2h2eGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793293756;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-DetectorID-Processed:
	 Content-Type;
	bh=hP7xWTIyLpyCYbDGSyHIbd+6oFiLKq09+cf5FQKobZM=;
	b=HE1BNTAX5cmLWpPhoTtXRZjQd8EN241FCSJhTrCSTOgotKVkZAdJJnihmiJOL9jWHrad
	 MkE5ImO90M/pWV9cFS+SNRPIhvyO9actbWbgTcVD6YaUs0jL2SJXuhG6MLrUFRPztA8mt
	 pvUubxT5wH8zyCgvuhq6LmVV1Uk6eZOTQ5QWOEWTYA3f3qOPFWJX28L+JElsr3yLmzFFi
	 E/EsuwLUr/OVcY5kI5mRrNU+r9kFpzSxRg8alHwOI1umV8vALAGHpcxePISiaK5Ws5KIP
	 jHV2z/atZi7EktmcR9RIOhgRt6hEunNgyaD77N8U9MXeNfh/SKDnM3wSVvBmRQUVaQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=a1tfj+hz;
	arc=none smtp.remote-ip=209.85.216.97
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE654606A31A
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 17:09:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE654606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=a1tfj+hz
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-3ac91ac8924so1552202a91.1
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 10:09:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793293755; x=1793898555;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hP7xWTIyLpyCYbDGSyHIbd+6oFiLKq09+cf5FQKobZM=;
        b=PKQlEh3V8iovsxs/LHPCkHjfe0J4w9dJxV9/spNf9QMMIqKlYgha52GGaC5hoOl75l
         11VDLWO++rLhZ38XiyRc2houMlIQaSqeJ04ELfTrlpuXpWNDmvBHN2Nfu75Q9U0SR4KM
         bSSyaXVR10zQlkAFUEMQ3CJMNTVh7kvRCvpQHQKt4W+ANevS1baSIXcGGl/j1sg94HeK
         nY/LYbzQXGI7mADqZDLXop1EQbmCKp+Ag8J8vlD7brr60yMUP+nOeBgeNgsCFMlOPw1M
         +RUBTHg+5COn7H50yW+He8WLoz4SwP0gqXh9sKYTrqzPnTvdWsm5CgheNwFLVO8+6UOI
         5h+w==
X-Forwarded-Encrypted: i=1; AKwUvBypwstTvUYggSBlwdVaQZxQaj2SZJ2Im7wbJ4B8mIoP2YRsRxiQ15ALT6hanPi2cYESihQ9jMQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ/sDgSFlxvkiPgWXFFht3J6AMl/OyqD5DNQuLEFMY8AEyW/WoX
	eju21l/gEY+3fm+kscJ0pcS3q4UNpT6THa8XE6JOcf2kNudrJA/oHJEDxYm7ZD7nbrirbmAMJLl
	kkJOTtWPejQvckLVHOQdA1VbMe7Y91c62IYECCXaoqMnubt7lcDGLWJZ9g2EBfV2ZGYCvjcn/f8
	yXObey5LKARijOo8w0uzr+nn+EWxeEIZrz6xyrNRGVm9EGZkNETHS/8Rg1Sr0h/NitXjszf2pha
	2+KE1e99OLqNJbLMg==
X-Gm-Gg: AYBFou2g+3wmlyyBsZIWgx4OXOq47wn+GdAcPYbOwW+ZZt8eZWGSRYVLutjdzb6PUMx
	4wMgVP3FLOs1nTlAwbiPCk0tKPXIqZwQT5Tt09fHvzhybnFNJeBOD5eH4jWudw2+q6Cv0m5Eroi
	KvsSBtfO4DWpt/n3VPTHXLGSTGkYyRS+U5ePHAD8UusVORvY9PehK8fvUNU7llj6rqaiPD7ju2l
	hpDGI81MFakMU3LZ5wgtaKckNeqYWKNXy6xT0lNN2RwJx3ZdepD3tQikHix5ZbM9qg7uaNfc3Io
	JuL3i+5g55eEAO7iPLlFJJQGzxeKRZw/pwNfPcP+enUslO7gMzrXSSVbi60tdx3rncw6h9lhGUh
	cEZzem/HxVDFQzMSak3hqtQSzMQVJtpiXmct9b5hmns4GhXpd/fyiFEbXLNpe8ZoNOc5TPrQp+S
	OxHyXSeDvDoTLay6jeub/VYfCft5tvnlXkQWsHbZY16g==
X-Received: by 2002:a17:90b:1b0f:b0:398:c3ca:1ebc with SMTP id 98e67ed59e1d1-3ae580a8351mr5097878a91.18.1793293755026;
        Thu, 29 Oct 2026 10:09:15 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-22.dlp.protect.broadcom.com. [144.49.247.22])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae6e80415bsm2402837a91.3.2026.10.29.10.09.14
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Oct 2026 10:09:15 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c4069f03949so115176066b.0
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 10:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793293753; x=1793898553; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hP7xWTIyLpyCYbDGSyHIbd+6oFiLKq09+cf5FQKobZM=;
        b=a1tfj+hzUiRdMycK8raWQidtPFs+ykCbhCswFHrZNwf9XokZhzqAiQdUf5zDv9qpAP
         DtyFtLpGEnrGXzdUXfp6+pu1ULvR9DBZzg6QcZLyWA09HbeJp38uXkigByX6YgOdLgNV
         aUXpFsuNjGaKnBC7giwCEFpf+Rq+jQN96KrQs=
X-Forwarded-Encrypted: i=1; AKwUvByReLMJeYxIymJUHwDEo91odxyksC+vJZz6K0khGwZkoU8IYqaZchayyQanV17k4YRzfooOgaw=@vger.kernel.org
X-Received: by 2002:a17:907:7247:b0:c46:7de7:e41d with SMTP id a640c23a62f3a-c49d13b3532mr325881166b.18.1793293752852;
        Thu, 29 Oct 2026 10:09:12 -0700 (PDT)
X-Received: by 2002:a17:907:7247:b0:c46:7de7:e41d with SMTP id
 a640c23a62f3a-c49d13b3532mr325878966b.18.1793293752484; Thu, 29 Oct 2026
 10:09:12 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027234940.1267225-1-kuba@kernel.org> <CACKFLimhAH+1JT_ommiBoXfn7UDQ_bvO+jexrRRQNKxaAo1UMw@mail.gmail.com>
In-Reply-To: <CACKFLimhAH+1JT_ommiBoXfn7UDQ_bvO+jexrRRQNKxaAo1UMw@mail.gmail.com>
From: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Date: Thu, 29 Oct 2026 13:09:00 -0400
X-Gm-Features: AclHuK9mByfH3ryWn6TsSovSmfn3-KoVJcdflxOqQN3MNGTA91kvC72ORA-E4bs
Message-ID: <CACDg6nXMtOGwp7MLmS+8dtjt=U9KiL8uHOShxkjudihH=mOL2A@mail.gmail.com>
Subject: Re: [PATCH net 0/5] eth: bnxt: fix Rx buffer leaks under OOM
To: Michael Chan <michael.chan@broadcom.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, netdev@vger.kernel.org, 
	edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch, 
	horms@kernel.org, pavan.chebbi@broadcom.com, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, eddie.wai@broadcom.com, 
	brett.creeley@amd.com, ap420073@gmail.com, joe@dama.to
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000229a32065efdbd23"

--000000000000229a32065efdbd23
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 1:59=E2=80=AFAM Michael Chan <michael.chan@broadcom=
.com> wrote:
>
> On Tue, Oct 27, 2026 at 4:49=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > Commit bd3beb5c8691 ("eth: bnxt: disable rx-copybreak by default")
> > changed the defaults putting users on buggy(ier) driver paths.
> >
> > Fix various ways bnxt may leak buffers under OOM. The first patch
> > fixes the real bug that was hit in production. Second patch fixes
> > an issue I hit while testing the first one. The next 3 patches
> > fix other Rx buffer leaks pointed out by an LLM during review.
>
> For the whole series:
> Reviewed-by: Michael Chan <michael.chan@broadcom.com>
>
> I've also asked Andy to review these patches since a number of them
> are related to XDP multi-buffer and XDP_REDIRECT.  Thanks.

[resend: actually plaintext]

I went to download and review the mbox today, but conveniently they
are already applied to net.  :-)

Overall these look good to me.  Thanks for these fixes to the driver.

--000000000000229a32065efdbd23
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
tJVewHuOmXgWQxNWV7Oiszu1d9xAcqyj65s1PrEIIaHnxEM3eTK+teecLEy8QymZjjDTrCHg4x36
2AczdlQAIiq5TSAucGja5VP8g1zTnfL/RAxEZvLS471GABptArolXY2hMVHdVEYcTduZlu8aHARc
phXveOB5/l3bPqpMVf2aFalv4ab733Aw6cPuQkbtwpMFifp9Y3s/0HGBfADomK4OeDTDJfuvCp8g
a907E48SjOJBGkh6c6B3ace2XH+CyB7+WBsoK6hsrV5twAXSe7frgP4lN/4Cm2isQl3D7vXM3PBQ
ddI2aZzmewTfbgZptt4KCUhZh+t7FGB6ZKppQ++Rx0zsGN1s71MtjJnhXvJyPs9UyL1n7KQPTEX/
07kwIwdMjxC/hpbZmVq0mVccpMy7FYlTuiwFD+TEnhmxGDTVTJ267fcfrySVBHioA7vugeXaX3yL
SqGQdCWnsz5LyCxWvcfI7zjiXJLwefechLp0LWEBIH5+0fJPB1lfiy1DUutGDJTh9WZHeXfVVFsf
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGozCCBIug
AwIBAgIMLAiVyur+1MRjdDgxMA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI1MDYyMDEzNDMwNVoXDTI3MDYyMTEzNDMwNVowgeYxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzETMBEGA1UEBBMKR29zcG9kYXJlazEPMA0GA1UEKhMGQW5kcmV3MRYwFAYDVQQKEw1CUk9B
RENPTSBJTkMuMScwJQYDVQQDDB5hbmRyZXcuZ29zcG9kYXJla0Bicm9hZGNvbS5jb20xLTArBgkq
hkiG9w0BCQEWHmFuZHJldy5nb3Nwb2RhcmVrQGJyb2FkY29tLmNvbTCCASIwDQYJKoZIhvcNAQEB
BQADggEPADCCAQoCggEBAOP/A/G3pTTF6D8/BCAHpxJpQjOueWirQLqbjFWJTHsh6ADFdvKs+izD
0snfZopX+ZSMfR+NKl12zoJaZy/HTGiXvyeLACXBAP5i8J+smf3H0UZo+ztl9s/CLIxDfjquoQYV
UHAKWXC5euJvZ4N4/n2E35/OV6VV3JeKQHAiSOXhljrejDS6Wk96WYaQKawDm0jYH6OoXDnR/CMn
3bcNBRgaGW5VtJUP5jpTLrsQFC25kFf6fA5/HWLsVdOwkBWic80s6HCG0ROnFWnbLPL49NGItRmc
Cndhx/wUdeIk/qDpB3NiaC0IsvVNnZLIIbEl5kBojwkZV0jD/VicntRDJ78CAwEAAaOCAeIwggHe
MA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEF
BQcwAoY6aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2Ey
MDIzLmNydDA5BggrBgEFBQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNt
aW1lY2EyMDIzMGUGA1UdIAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoD
AjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBB
BgNVHR8EOjA4MDagNKAyhjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNh
MjAyMy5jcmwwKQYDVR0RBCIwIIEeYW5kcmV3Lmdvc3BvZGFyZWtAYnJvYWRjb20uY29tMBMGA1Ud
JQQMMAoGCCsGAQUFBwMEMB8GA1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQW
BBTQMVctYYJaUBLeJgZz6cT67l9WmjANBgkqhkiG9w0BAQsFAAOCAgEARE5k774M2TzT1K6LUDrm
HBHxHxe8rQpJrB59lyOANT2BjSITyUXPC/Up9ExGhYbioibOJALdaBhATnMgqw03EJLpr7Sy/mY9
g/LlaPMSHU0vcuhuU15DAwQfJ9Liw4K9AmTo0MnPKgiSDLWT8yuphPFiXATg1x8+K1b/KEt8t3Cx
3pY6cGPUH4iJXz801q7ka38emkBlMKS4i7eWgwCSHR/9c7JvlrVYT5+wqYCbmPasbv3jNS0MfEdY
qNLhtJABTy1ePhWmAzFMlbexVyN3FeWCOtxrnnD6tFhYt9dMX2kSvti9voE1cPJfyHj7IhvHVlUc
aBR5GY5F9netDgPvbqg1YpqYZwxblN6i91QhywTGSydHpbgJAmVEEp9rKvGJirwRjORPt0wXb3b6
6BzJD4dFfmqoXVKRl6WHOOICEKWVcD0OnPRdCJEXiSW6y1xobGpElvWmB7lGIE+W9V/Efv17PdJa
/u6hPkFWZBhzmFzEWDSaWvsfJpk3Jb+8oHhOk0IERLc4VLhPNhyMOQq+aL30GjEej1lqr79p5a70
/+WaRxxlypFBMj2V0384P2ACDsYAayPdKSx5aoEJWmW2cc/xR0LxENIsNWeqUBvEjcA6Qud56l66
dGBNtVCEGdHfKttDlWel93rPRa77UmnqEt+6YNFCXnuhaSUJGOA0yxQxggJXMIICUwIBATBiMFIx
CzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxT
aWduIEdDQyBSNiBTTUlNRSBDQSAyMDIzAgwsCJXK6v7UxGN0ODEwDQYJYIZIAWUDBAIBBQCggccw
LwYJKoZIhvcNAQkEMSIEIEbYiXBw0Qrfo9A7dGT3HF0xs5BbhHeRlLCyHzLSWnFqMBgGCSqGSIb3
DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MTAyOTE3MDkxM1owXAYJKoZIhvcN
AQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0D
BzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAEJ75LwF2qFf5wnE
dTxYXcHcztnklr1L8y/pbsy12aaEG9pmLNPuijL0D7u9R7zzar5b9yBN3npmXnQwXYICj36SlaIx
yXQhwI1eBqId6Bi5n97GCAL1sYtUiVQCTi3BA61NBaa1OJwJpZCmIKasxTVRrzTfjVYNLaNCYbKY
ZIarRbkID1+d95z298+B5CWxNyKPdZgVXPW3AQEIBeIG3PAzxmSMGBJDh1VLUylldmqiFOrc1nwR
T1mI+KMOyOiZPM5SGEwOIFDu8e7slo7iB15fyiA/H6BeHjdIDFGMKysa5SjgWpOZp/vhlptm3Pqs
sGI5erW0r/WWdrWnOJr0Q6o=
--000000000000229a32065efdbd23--
