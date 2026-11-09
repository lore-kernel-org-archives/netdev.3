Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.97
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794216312;
	b=X+2SA3eb3k4yxsfvPCokdQVxLQYB0rvDWdd81/bE9F0+AG8ky3Fechm1fEiH6AgWEFKZ
	 d/T2DOuE9LXa8r7Xy5+a7vN8dwkVxM7d4OusU4R6McpDQ3HpSegc6qLTNwoq4d7oSKGKZ
	 da7JPrPohhjs7oU6jSpTERsVxBhQMCC+9+O+3zb8vjIIia1e2iSeLYb0uMi/vV4AD8IDC
	 Rmj2tNbBccjNf8Fts2nQTRAYGsM5y2LBLTpa4h7NNlzbcGS5tzTOnKRMUcYMq8RZLiGnx
	 NiSiuEscbo0HDYqumR99VAzYQuonvhNFYxEj2OPND1TeT+7Y4nE6K4xhBMGfvczmIfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794216312;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-DetectorID-Processed:
	 Content-Type;
	bh=R4+NWJtIDCDM3c2RruYa9/IeoWBTuNHanXBXYsCVmg0=;
	b=y18llc6hsf+OmgKa/S2NtF+i5xfrgEcY9HYd46prB0K+6ZK3FwqYq8xGag9V2PqiK/OQ
	 9Av0JYhhLUiS1gia6iMqhmsV4Z5UHPanvIhLJxXUBvfnj9Ov0V9wRAGAokFDxDSThef0M
	 lnSQo1ysUgB5enyRVP2eGdauA2tRS3a8nLsxwkEblaKqOdHN4xcyf6U4IUPPNt/Z0Es+/
	 5Td5gzNksvdCrf8qlEdVTKck2w4RhNtlJFHLxDsjmRebwpb35JyFDQfLZ5BIH+WIGq+eQ
	 rQFa/2NPaKpstLliMJx3YJumMva87KhN95LPfcRTjEGG/gyxn22+ssOT8M+OUGjrU7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=gIVxRdrN;
	arc=none smtp.remote-ip=209.85.216.97
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4384F606A32A
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 09:25:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4384F606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=gIVxRdrN
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-3b09a83d12aso410125a91.2
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 01:25:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794216311; x=1794821111;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=R4+NWJtIDCDM3c2RruYa9/IeoWBTuNHanXBXYsCVmg0=;
        b=lrn7uuWA1QOtnLF3K/Uyhf/t+z1YyqpKGSRCbevdo6ngGVbfPoMZAMfBGikTgncRgm
         pReQ6i60nz86erHiWMrdHgUcBwShl6v0PA7jNyPBRtj2QWk/naPBuWTtYs6hv9hDrvvJ
         Bkaxy1ws+JTZVrzK+gWqsM6BxAo+mNO51W6Oeg9gvBUgS7nmjqk5lJFHjU08uwco+TFY
         bfbz5S64ielGptH+kvbcPf9egzJl0qLXV8VSJyBVACsUoo91h8lnvkBQ69HXI/5ugVLH
         rssjlupoqf74oMjsun8lvegmfOjOlwMa6lFZ+V1rkOEUh+ngMS3RDQxgFa4Gz5xLBlro
         +r3w==
X-Forwarded-Encrypted: i=1; AL+hErHf0QOOsRGze8OIv5Eli7XifOytaG/XsmRHFMcnZAewjPB9C/aUXQNQfi6bQUizkPhOTqtIzpE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+PcrGlMUX95+ZKKx6Kvq6C+WHiPnPrFFlEso0xm4Jy2d2mGvOO
	Hu0fSoGhhd0MHFlxcC8k59Y0oYQx5UsZ8JUEwyI79+bfDfASc/HSTPzpSssUzqFS19s9TCK6YL1
	I8TYvIqL41bVyWXKJvTjkCapRaCnwo2y3rf8NUXoiiSL5kW3M0P0QBMhO2oihDb5nwo9PvgYDj9
	krIbrTUeBmFb2m8EdcbTxR2GzP0ym8/y2YHjJ+SUp0HgtdOacPX+kCrHPqhpmw88S9R1D71N9iW
	ZQsJPvhnvY=
X-Gm-Gg: AYBFou1FQkRZvKyEGf5wA29CpankffzGZ168KOk11OSzzjKTKw7Z+5K7JnwulVn4cCP
	3WrYjCS0d7B3uANL5eS5zgqJQXIaJa7QUiYqRILBObCOFoR01sgvOgl6+CVsTi+avMr05S8v87o
	DKPyuWryKShAzDozNAWdi88KOmqCNwjy0P45Z619ckgvfNyymG2VBvBoO5us3NgbsVmtuH5UWUl
	nPkYYyQ4vqW6Y7/2zrx+WIHxT3V3rnFWeuBajTg52EA5mxLR8akvn8Hf60bPkiuMiTaBefrgtdm
	xeI7cWeLmA3aSKdx7nHsGbyRi6LVpjxSV4yuHj32W9yOQ8ilv57TChjapvar3bMGvXW3pQKwEa7
	V/x+0foTl/Up/QuJY3yAmGsDjPzHaAZNs5cK+AhELvKAnWr2Cpti342TsXxpEDuxfmRfimZXbJq
	M5O4jlbdCj3KXnwuuIWRQh3xBm6zekRODV9O0=
X-Received: by 2002:a17:90b:4b01:b0:3a8:211b:6c8c with SMTP id 98e67ed59e1d1-3b12d3c0f05mr3643882a91.22.1794216311473;
        Mon, 09 Nov 2026 01:25:11 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-17.dlp.protect.broadcom.com. [144.49.247.17])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b0fc1b5f7asm2119532a91.0.2026.11.09.01.25.10
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Nov 2026 01:25:11 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8b852fdd55aso985430b3a.0
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 01:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794216309; x=1794821109; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R4+NWJtIDCDM3c2RruYa9/IeoWBTuNHanXBXYsCVmg0=;
        b=gIVxRdrNeHI43s1Lnj2ixrJSNseN4aUN+xuIJ1M4W5v3zNBufHd8mNvy8wKfdP/38H
         86SREHUqKUux75aEiNs8DsFmMGh31vcgivmW+yRNyB03aqRKbgf3U1Y2XNT/q5pr3f83
         26Xjmr+Hkk5ktS0jWfGjzEf8iwJgM1IRUrF4E=
X-Forwarded-Encrypted: i=1; AL+hErHQoEmQR6zjDpcOyY7USI5QatM1tGGkUeh3pOFbP8OW6cdnLh/clz2NPbb5WGwl/rePQ4fisyI=@vger.kernel.org
X-Received: by 2002:a05:6a00:4b16:b0:8b1:e8dc:c894 with SMTP id d2e1a72fcca58-8b66c3ce2bamr3474247b3a.5.1794216309554;
        Mon, 09 Nov 2026 01:25:09 -0800 (PST)
X-Received: by 2002:a05:6a00:4b16:b0:8b1:e8dc:c894 with SMTP id
 d2e1a72fcca58-8b66c3ce2bamr3474231b3a.5.1794216309155; Mon, 09 Nov 2026
 01:25:09 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261108065526.710152-3-pavan.chebbi@broadcom.com> <179421058149.994134.13195419627896454196@kernel.org>
In-Reply-To: <179421058149.994134.13195419627896454196@kernel.org>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Mon, 9 Nov 2026 14:54:56 +0530
X-Gm-Features: AclHuK85V2ADeH-S3deseYXC7LKIqVZ839UnUIfAK8MmItiLrQfya7oPvKBmPEQ
Message-ID: <CALs4sv3VBin0FYN+grPrBOC48rC=+80wxORsNRo0f88X5iHTOA@mail.gmail.com>
Subject: Re: [PATCH net 2/4] tg3: Select PLL clock when preparing for shutdown
To: netdev-bot+sashiko@kernel.org
Cc: michael.chan@broadcom.com, kuba@kernel.org, andrew+netdev@lunn.ch, 
	andrew.gospodarek@broadcom.com, davem@davemloft.net, edumazet@kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, shravya.k-n@broadcom.com, 
	vishvambar.panth-s@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000cc7b9a065fd489f5"

--000000000000cc7b9a065fd489f5
Content-Type: text/plain; charset="UTF-8"

>
> [Severity: Medium]
> Does active_speed here describe the link the chip will be using while it
> waits for the magic packet?
>

The check intentionally uses the link speed recorded before power
down, not the speed negotiated for WoL.
The failure was reported and the fix confirmed on a link that was at
1G before power down. I will amend the
commit message.

<-->
> [Severity: Medium]
> Is TG3_CPMU_PLL_CTRL_STAT per-function, or is it shared between the two
> functions of the 5720?
>

Hmm.. yea the register is documented as reset only by POR or CPMU
register software reset.
So I may need to treat is as shared. I will confirm this in the
bootcode and make the required change in the v2

pw-bot: cr

--000000000000cc7b9a065fd489f5
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
MjAyMwIMClwVCDIzIfrgd31IMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCATPT7G
rHIhHdDwBkuKPZ1Isvk8PAgvgzoG76UUfBlpgzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjExMDkwOTI1MDlaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAkVdiUgyp2mggUH8zSjcX3xzJdHUpjDZll3gTMNI5p
a5Y966B6CYwiFy6VOhTrruOfiApfcTBBK11eOTgcpVWZ7EYt+IQY5DIgaiYkxopbmIOFVyEIWa8Y
2IHmspDG7R1vwx7u0Voyn0tyWJHpyHaR5nEtPtSHkTM1Pb88V6gE3MTdS5/6cYpNKG5Z8KGQ27D7
ZPkrWJnGdv0mVomkLrv533HrTvBT7kwvaapPIrP7a5/VZKbbb5WfKgrJZA0YdGyty7wRPyBcyc7s
Ngd2qu17VCQkeumQCUgXXA/9vpwiz0BUV8eMAnjAubjno4rWW6plK3zjpQRq2bwwQXgYyTqf
--000000000000cc7b9a065fd489f5--
