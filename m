Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.97
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793092246;
	b=a1bfy73ykEyN1hFgz9DkS/M4klmc2bBqn2NFD/9N0nCH50l9ouVId2tEgSy2SEv5Cd/U
	 ww2P/iK2w5NqJbwwP42rzz9rh5A6D6/QcXvecs0vdU14bcgNW5ejM5Cod30S3mdQejiW6
	 7h30eeM8fsIbsy7sXe14bF2F4GU5EKkRgEMlxV1aqh5e3ITlhuAwRiAjfLJqJ0MkT/SLh
	 EsMh/fJYxIzsBL+/xAybbY1++w5+CIZoyGpQiQNJEEeu3nXCYFfvZpYOoqAk7Q1nrsoBI
	 Qhh0Bb46yvsGqpEeZFLDxlQP9C4DZPsqqt8o+Km2N9jRs99tOcLYFuXbk9pI2oiZA7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793092246;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 X-DetectorID-Processed:Content-Type;
	bh=JsA0PNA2lg5b3sx7uL2HeEkBmgUppAxcgkTuhBgbNQ8=;
	b=DRcbLaxBr/ioohRpgQwS3pVSoPe+MPxfu+N1Q0C5SqXU1bLwNwgBS3ut9Zh7YBCUFjDT
	 H6KuGMfj5ZaxtaH4gRTy9/MnoJx6FGLso3d69jwwI8JnSPKlgcbopjobOrxt712YGterU
	 IlaRHG0sDBkF4vrK7r5g4P8Fru9tjZn9klz/yjHPA9eXGUaxr2rl6LM2sEqQAaJnVoyl9
	 +G9XVwJ498z6fL0yBUD30++mPkkA5NBAk2THA+rlSyjvpe+6GQes6BCQVM5Ueg4iCmlQ5
	 tEZXokDsqhsMRdmc3JKm18tPhgOMfQQ6H9PXV75uRSzYUa/R1+UzGTVBL8urywobCYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=bPmf2iNi;
	arc=none smtp.remote-ip=209.85.216.97
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A159606A323
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 09:10:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A159606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=bPmf2iNi
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-3ac9f49b984so496279a91.1
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 02:10:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793092245; x=1793697045;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JsA0PNA2lg5b3sx7uL2HeEkBmgUppAxcgkTuhBgbNQ8=;
        b=BmU1OqK+6VKio2/z4wXATZ0lXjiyTKXJb7BhK1/CEk7H8z5km9+UuJTS3BgCz16mkx
         vZ+m1UdfZCUdrNL6SJDQ4XUHS3NfUq5LzJdcO4ENKip6MQry0eZNkVKi3N77YdizVjpv
         jROrmAj1gTjL8UKSyYNjEsRSIikeQ/Pvp3ZGXf6KF7DPVDCxyeV/erdZBX97Z8HO9P6m
         ERFDfDEl4+/85HIHhgD+zwied6dER2QUk6KcUhlAGrox9UPGklGnW5ZngUmycKln/PqJ
         5iZ0sJOhi04qJTyeL+q7GWD+ExI1UY/oGxdWAzRjTgShKZ+bIzOWTPO5crJUVIsJpW9Q
         QurA==
X-Gm-Message-State: AFq9FYIbJQuuw3xP6HeYB+CCKUjm88X4aGU+W97t5bywAyePspQ/R3yZ
	1RH+4nEJ0vwgisooFPI8LjYjL5m6iXKHHevY8d6LhXxEo1R7fb3/Sa/9kAzN3sj4eQafewmmGd6
	QXUKQV4M4+1kPEFh2V1uFoEcDs9G06hkNb70F+eQa20q04S10sZNHkp8w9MH6lVrYPLBJq2KegN
	WW3Q4VVx3smV7EavOBgCap+LSVoB7W9GgRs9hBOyJp0JYFh8uRRe9/H3F+e6ts6F1LjHSM08e8L
	QUVk/rfdBnAVg==
X-Gm-Gg: AYBFou1UnZQoKynlMe8fVWiSvqzIr+OXgHPJqBlX3FzQNLO2zoiE6BQYleNMbmX/Byg
	VykrAWZEUULYxWn73ZJ0slYDZQiBaDemETU60VPBZTn7ycYsjWFrnG2hus6PoZrshhkBWC1LWZR
	Eitb8f88c5RD74t1ViTEIdITuTlv1GwCP2WOgumgZTZzhpaKKCplopp1nglIqKFF8o5hcQlIlLC
	4o+DzR2CiKpvSAEhzwU7y3/aeTxW6iGUoRwN5orLBxWrR3gAQLeON4BIYu6nwyx95nAVI3e0Yf3
	5GFKtlU2gb34Cr6se9vN8P5JuIb7SJv0f/PR4MOXvF3HTwvAzq8KEbiq9NZJEDZJvZYforBb7Ya
	am6Ztg+qeLh9PgX4y6FWLgTWGgb/pXp8DyAgVLUjVir2uBE3oKcf71xfxDFnMzjxi8l0TsjX16J
	L0CGzDdLNHrfuLfYQ5YivaVShrzeOUTtChIFM=
X-Received: by 2002:a17:90b:280a:b0:3ab:b764:8256 with SMTP id 98e67ed59e1d1-3ae4028447emr1118256a91.17.1793092245130;
        Tue, 27 Oct 2026 02:10:45 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-23.dlp.protect.broadcom.com. [144.49.247.23])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae41527924sm508545a91.4.2026.10.27.02.10.44
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2026 02:10:45 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8a086ed8980so627953b3a.1
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 02:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793092243; x=1793697043; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JsA0PNA2lg5b3sx7uL2HeEkBmgUppAxcgkTuhBgbNQ8=;
        b=bPmf2iNi+Gp87BjWBq6Xsa/bHZRq0wMkiscK198+Ht+B1V1o2u4pg2eC2wVhBQFIAQ
         piXPoAw3757UoyIcte9tHjXWg/PETMYaMXvQfYyTh3/iRlGNRpOavhPktfMbXCnwK31x
         SRa2oi3lftvEiFIoR0i0a+bM0xbLq83jYZOUQ=
X-Received: by 2002:a05:6a00:1413:b0:89f:d449:7524 with SMTP id d2e1a72fcca58-8a5a5fc2220mr1263548b3a.4.1793092242967;
        Tue, 27 Oct 2026 02:10:42 -0700 (PDT)
X-Received: by 2002:a05:6a00:1413:b0:89f:d449:7524 with SMTP id
 d2e1a72fcca58-8a5a5fc2220mr1263533b3a.4.1793092242538; Tue, 27 Oct 2026
 02:10:42 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026220955.473247-1-noam.d.eliyahu@gmail.com>
In-Reply-To: <20261026220955.473247-1-noam.d.eliyahu@gmail.com>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Tue, 27 Oct 2026 14:40:30 +0530
X-Gm-Features: AclHuK8vG272yQNksZL2XMWb2KP-04-p1tlW50fyIa3f_9NbrI38Y8wq4TVqb50
Message-ID: <CALs4sv0=eWvwDh4mfq_OZnULn=mZY-GvmnVarrx+84mxwcnp_g@mail.gmail.com>
Subject: Re: [PATCH net] tg3: Invert restart quirk logic to restrict SNP
 power-down bypass
To: "Noam D. Eliyahu" <noam.d.eliyahu@gmail.com>
Cc: netdev@vger.kernel.org, michael.chan@broadcom.com, kuba@kernel.org, 
	edumazet@kernel.org, davem@davemloft.net, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, stable@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000003690ac065eced252"

--0000000000003690ac065eced252
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 3:41=E2=80=AFAM Noam D. Eliyahu
<noam.d.eliyahu@gmail.com> wrote:
>
> Commit 9fc3bc764334 ("tg3: power down device only on SYSTEM_POWER_OFF")
> bypassed `tg3_power_down()` on system restarts to prevent reboot hangs an=
d
> NMIs on servers where NICs were initialized via SNP (such as Dell PowerEd=
ge
> R650 and R750).
>
> However, skipping the power-down flow globally causes the ACPI _PTS metho=
d
> to trigger fatal PCIe AER events and hangs on other models. Commit
> e0efe83ed325 ("tg3: Disable tg3 PCIe AER on system reboot") attempted to
> mitigate this by adding an AER-disable DMI quirk table. Maintaining a
> growing list of models for a secondary symptom misses the root cause,
> leaving systems like the PowerEdge T440 (sharing the BCM5720 NIC) exposed=
.
>
> Fix this by inverting the quirk logic:
> 1. Restrict SNP power-down avoidance strictly to
>    `tg3_restart_snp_quirk_table` for the specific systems requiring it
>    (Dell PowerEdge R650 and R750).
> 2. Restore standard power-down behavior for all other systems, eliminatin=
g
>    the separate AER-disable quirk table.
>
> For systems affected by the original SNP restart issue, their shutdown fl=
ow
> remains completely untouched.
>
> Link: https://lore.kernel.org/netdev/20251221175050.14089-1-noam.d.eliyah=
u@gmail.com/T/#u
> Fixes: 9fc3bc764334 ("tg3: power down device only on SYSTEM_POWER_OFF")
> Fixes: e0efe83ed325 ("tg3: Disable tg3 PCIe AER on system reboot")
> Cc: stable@vger.kernel.org
> Signed-off-by: Noam D. Eliyahu <noam.d.eliyahu@gmail.com>
> ---
>  drivers/net/ethernet/broadcom/tg3.c | 48 +++++++----------------------
>  1 file changed, 11 insertions(+), 37 deletions(-)
>

Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>

--0000000000003690ac065eced252
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
MjAyMwIMClwVCDIzIfrgd31IMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCAZHICX
JIz8bj4oB6EDwV+KA4okEn2JAYphMQRpjK2IjzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjEwMjcwOTEwNDNaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBbLyV0tZTFSpz20r6fE/SAckk6YAnTucm+NWYOcxe0
5ZEbBMySf3j5Y+JoTVG7mYCRYU9WQDRjrR5kBnn5fcHpJ/Qa+AGKV0ubck+tu+jYiMUj6G6E9smS
Npyt4FJn5VzcxjsnxZFfZrSv5hRbDGkbvqA9ECGURdwqsCkTnAyMCBDbglNn8wFFXB6IAE3Sw10J
Ns1a7xvYyLl+ma2Erf/uEJzFi61NqPeE0muL/q+UdHBJwKtxkNFtaIZKL+CfShKlL+j4DVmW/qrn
FvPVxt1+tMVCqyCmfO3Z9Q9L2jv0cKVmNOVQAw1S/kwDVNibar/70eJzankbEEvjOhPA55TY
--0000000000003690ac065eced252--
