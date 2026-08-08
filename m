Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECD11C862F
	for <netdev@vger.kernel.org>; Sat,  8 Aug 2026 04:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786163967; cv=none; b=ghTYCWY8lRavn4F3afNsWxfaOEL1kJo0swXK4zKcGG32lETujZgT0nJjSacbjCR4UsuQMarmbcvOUvOveEspBwqK49slC6kCPbOLWJ7lvwTxbG0w2PrDiA2SGDo+S9Di3l6A6l60lXy1vHx7q/qHePNNAqwAp2cuQ433uJNXlmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786163967; c=relaxed/simple;
	bh=8712PvIRoNHwOGU2QVTldiuAHAh9AiJb1p8FLzIBeZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rPE7FXBykDKsbHBrMK78jZO1SZB1aZZfLeg+2t21bGQJhFmIzZrzhNFxmPQ9cVFIH2L7/mhA6e4UjbazSQj1Alis5/uAIBSNd9DwU0hKlH3oVODca/KnllC0rnBtPX/ITTBnB1VP8aOAgTJJxepYD1PojCdTg16pOS/as8L/lH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=XQTlwvww; arc=none smtp.client-ip=209.85.216.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XQTlwvww"
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-38e69bdb0fcso179251a91.1
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 21:39:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786163965; x=1786768765;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8712PvIRoNHwOGU2QVTldiuAHAh9AiJb1p8FLzIBeZI=;
        b=FsugOvsUnpCMZXmy8bKYhGK2Y2BE88f2/ygQLt293lCy4hYhoGUwfrGqqdewIXrl1F
         58BQNQGD1PUCNNBba30IUwohFpiAzaa/klHzKgpn08GGL8dgpj3ALnttwiJUGBQBV+XU
         NeJ60VzgLCIObHqXbuhKSruLUltIPDZ8I+qGcqpnq3QAMgXtxBVFjdTck8gXn2XCNu58
         POk9ywjgB31JR81u2r8N3dGtkMnwwe6XjQQ1oFKkeCqHVSwkn6CbR0lKxInExlbiJnOb
         Rryouu7LkYI/VOko2m3xvuCNh2otWrmNMYz0kud6ZFHcI+7yrRTfvRHTEEFohl+q0yK2
         ee2Q==
X-Forwarded-Encrypted: i=1; AHgh+Rq5udp8m4Yxd/k7bg+JS5o64qMXxicOK9jk3/H0hD7hW2+twuBiriAdiAqu7Yxzxh0dnahKxgU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo0D2EDzG84i8MpdOLyKjFDvbFcTA8mRJZLkBmupIFdSfPIPgj
	ynO4gXkRFHAq0HG3yLJQc26oC4kdfXyYOmHy5wP0sEXfCUe2QwZ/GLodV4l1Zqx5egnRKcACt0N
	JwRLMrgCpSFWjpL3rgozDjvQrbjNgQXsdx8pZj3SZC17BMzV3Jy5RNJHxyrlVn0r6hF8qWrAB6I
	2cxo/DEJLNrOYlApQKpWfsc6y63cMgBq183fn0TFec/RtgCKkifmwtCVtBoQvHASFg9c8+BLnzo
	GrYfbEzgE1E0w==
X-Gm-Gg: AR+sD11Q1NO4jObGh2LCJj1dBkmYhpATNHUffZq5kSz0VIsd2RZhCYPxD3LwBP5kccC
	MskHhcCYT4bJ9guhk8BFvh/70PpUhvr64vZhOeXZckfZerKBXafli+7sGhntHwgCX7uQgrfhXkv
	NSLZT9VBAwJhize9HmtBlnUHbS5asegbXDaFyjDt8B68kj2sUOx6EQiliEbHxzvkbWnGgSkQbMP
	IrykIAgY+Hfq6VOdoRENlPzmXv1xkEmLNtM2EuaH8F9g4MIm9gi4+TDCW1vbMjhz7qmHMVEvywe
	H340iTXR/Qo3dbE+ubh5Q/H0Ad/dKW1hUMhdpo3LqcirsAzfUGT7LIgvokW+jePN+ovX2TAjEFa
	xIlkty6f/pzRGWNH/K8F22G6PaEoFkappJO60OpuMYWwSoreM4P0/gl4t7CSML0OSbU5hx8Hate
	50ZCZ4wTyW24vzhawU+3H+4Z1i8Q4YxPIO
X-Received: by 2002:a17:90a:ec8c:b0:38d:c74d:29c5 with SMTP id 98e67ed59e1d1-3903c5c0c92mr29820124a91.19.1786163965178;
        Fri, 07 Aug 2026 21:39:25 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-392825d6b3fsm883580a91.12.2026.08.07.21.39.24
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Aug 2026 21:39:25 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cbe9733fbf6so138100a12.2
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 21:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1786163963; x=1786768763; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8712PvIRoNHwOGU2QVTldiuAHAh9AiJb1p8FLzIBeZI=;
        b=XQTlwvwwoFCEGr1z9n09ajiSaamfiVBbAEKZwB5NwKTq8p/kyUMHpJoiraDosXqLcE
         xjTT/WAnJuUJ8WFwowjuNgsZzG0dgaAbPoCO9Gqv8oqyVMRMTAPOV/HYGW8/N/sx3Iw9
         M8U0lR9TjREJW4vre7BYbe3B7Cp2G5xO3CG30=
X-Forwarded-Encrypted: i=1; AHgh+RrUgDkC9mKdmn6edTodc2xm4Ip5Hp2FBuvdLXPiU7wI+1yRag6LJzNUnyMsGTxy1JBZdcDpU8o=@vger.kernel.org
X-Received: by 2002:a05:6a00:8083:b0:847:8e98:9a4b with SMTP id d2e1a72fcca58-84f2e12db9cmr34217318b3a.34.1786163963534;
        Fri, 07 Aug 2026 21:39:23 -0700 (PDT)
X-Received: by 2002:a05:6a00:8083:b0:847:8e98:9a4b with SMTP id
 d2e1a72fcca58-84f2e12db9cmr34217278b3a.34.1786163963016; Fri, 07 Aug 2026
 21:39:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806201849.3161402-1-vadim.fedorenko@linux.dev>
 <CACKFLimm+_nUX4s5MoNw+cavA6pXr+1ZDpRO+4Fya-ZBfzhreQ@mail.gmail.com>
 <8d21f245-abde-47b8-a7c8-b62a1ada6200@linux.dev> <CALs4sv3A4bY6-+S9kid5BQEiyQ76gbpnYoS5r+=KUKsB48fyPw@mail.gmail.com>
 <a43426e1-91d9-4d8c-9514-3808928cc792@linux.dev> <CALs4sv0pZWUJiWcUTj5W-zyV7uu5NFBTjT1nSD4yY=9H+p6xbg@mail.gmail.com>
 <a8ba2491-186a-47f1-8222-1b4dc67254a2@linux.dev>
In-Reply-To: <a8ba2491-186a-47f1-8222-1b4dc67254a2@linux.dev>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Sat, 8 Aug 2026 10:09:11 +0530
X-Gm-Features: AUfX_my9XVILfjeaNWbtIKFQwC-49ZmsKe7DDzwXb7dWZ1UOPTRA4myl7Z9gGeI
Message-ID: <CALs4sv17EUFZ8vG_7tC0aDJhVT1NbCk7xnzEET8ZZdoHrPW4ng@mail.gmail.com>
Subject: Re: [PATCH net] bnxt_en: enable PTM function
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Michael Chan <michael.chan@broadcom.com>, Somnath Kotur <somnath.kotur@broadcom.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000093c36a065881b4ce"

--00000000000093c36a065881b4ce
Content-Type: text/plain; charset="UTF-8"

> > Ok I understand you now. Maybe it is fine to have
> > pcie_ptm_enabled()/disabled() called for this version of the driver.
> > Since FW currently always enables it, and these calls are harmless and
> > turn off .getcrosststamp on platforms that don't support PTM, both FW
> > and driver/kernel end up working in sync.
> > Only thing I would argue is should this be done in bnxt_ptp_init() and
> > clear()? Since as much as PTM is a PCIe feature, the cross timestamps
> > are tied with PTP.
>
> It makes sense to have PCIe things tied together, because PTM is PCIe
> feature. Cross timestamps configuration are already in ptp area of the
> driver, so no need to change anything around it

OK. Fine with me.
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Thanks

--00000000000093c36a065881b4ce
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
MjAyMwIMClwVCDIzIfrgd31IMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCA7hECs
b2Yhg3JT5q1Q6dCmqbhUlyB6jkQWFDE+hFOZWDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjA4MDgwNDM5MjNaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQB5iyv0Lqu25L5YXuUrnWM9iVp8t5p3aiOT9ynLe3Rp
TR/xXudi0trJIGE2OAPXJ3EvVxRAnBtvEYnEpC0dZkllLYNTEfUjSGsL7r74poes189m1TCfvPOi
DvJnm18/Z2FWRN6Gbc44okhGc2xcXQH7L2azbKcv5qR+0TpRb7BkOfqtodOdycuM1sOS9GDe8wtf
NnHgF9b2Cpy+4GXaqrPk7bUUOJEe1wA1hrYGFECL2rU7GC94SeaZil8UmkHutrmlArQh9rjkoPuS
cSet5wG/7e0lMuN+o42oTq0G4lmXT5M+koYk0Vl9PHWRAZAMH0SOywFf0dUctAxxPkKWkrbo
--00000000000093c36a065881b4ce--
