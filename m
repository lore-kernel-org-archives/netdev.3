Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793265355;
	b=G8+YGZN43bOfyVxyCSpbZ3oxABGYZ6MQD7mjed/l5NZ+cEF3p2ho3Fpejof0SgFLOLhV
	 eEtvjkZA8LlscHMvD4b4RWBI39LJE2o2B8McfhwJ9+YEj0IF392We8rYQ1RqnyvFyaK/B
	 RCSJmfkLCuBqdyVQ0VUbYly8K6HG+nf6wNcGftotOAlLYwOGlu3803oQ0Tq/S0XI1A3Io
	 jiNUKHcE4iJQCb4EHUhMl1748mAK4A240sgcKq276GciRZAWzz+rNEF80NkWjwpsbQgcg
	 QYH2DSwqylhJxsEHJnXL3ZFr+JYkfCa45rGEueTCGBJkVUzT2miFgdn4oDN1QtJtaxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793265355;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-DetectorID-Processed:
	 Content-Type;
	bh=IG3coSvH2rxonblcfd8xM/aTYWF217iDwaoPYy5Pq8o=;
	b=YGRt3oGAh/ulzOpLV6O5aNs9Efx1CMQ5NPR03RVVebBfl3pSAMn4GJCEgOWxIlnQ83E4
	 AEV4pzMWeOufaFuOCvX8xRODYGJwDUlvwTKF3wVHudTsxTIJmbMQ8nvKJvZNRzmJa0wcT
	 nHZDPb19aqqV0ToCa9fCKsi1y2ziz2c75JCGvP8gBKSUTcAqnyf0gDs/KotKXHmOM1zkJ
	 M86bN4ENa4zCc41h4kk/n0T6q11EIoaxgVSJ2mF6oPdcF7lqiKfymOwJ6Ypxol25vPjy5
	 UNgNNoLCk6KG25rJE/jeaZ5NFuffpqgSnYJtihUMyGRrt7fNuasugHvfi7C9qIlFZ/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=TvgeSWwo;
	arc=none smtp.remote-ip=209.85.161.100
Received: from mail-oo1-f100.google.com (mail-oo1-f100.google.com [209.85.161.100])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF259606A325
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 09:15:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF259606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=TvgeSWwo
Received: by mail-oo1-f100.google.com with SMTP id 006d021491bc7-6aa9606ddadso1523558eaf.0
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 02:15:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793265354; x=1793870154;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IG3coSvH2rxonblcfd8xM/aTYWF217iDwaoPYy5Pq8o=;
        b=ycA+NEDpPgM/LVC+Ce0/n16nFuBum4iYagDS+gJlC6M9J4y0WxPuyalOskOBk2CYXW
         eRALVW7KXCNnA/RXuwsHCL0KCAieYH2rKb9aAkJHziTm8hOIYRBV7rLnoYvFcZsCNsEH
         oAJ8KnHJovIgc+JGuryHZwh0VeHLq0jHCBpdjqOsySBoPuMwfxIxqSI72W/DgrGt4/vb
         BYkeWknJBpqcjnvMz4iL1/oiF63ozKL269F/QX12blLcGIJSAwNzm+3gwBbXDJmdU1RM
         zahzSXVZc44ydttH042mJwQhR0cPuKLzQXXPz1N1FtmLJQFp4eoor5p/QMIE3J4B4KIe
         TTYg==
X-Forwarded-Encrypted: i=1; AKwUvByXlKShcPeMSyrs/jkD0R8Lwl1sqYzdUPNRqmFckGEb05kRqoDg7+bTzWvFJBpODl+nfE6jEhk=@vger.kernel.org
X-Gm-Message-State: AFq9FYKvHuGxnrjv9J8Zl6Ok4nr3hhAkkkXb9PelOAHrdfYmcMRsQyQH
	rQBaykFtdFDzT0I6IPSpTLZTSJZ0tqqm2hSXFdwRrHA2USRqHJQNevFsGawOWklJY7DzHP3RfY9
	6pTtQhc3ZwB1teA0WBzbRKcMQmPpVZb+cg84pt1wJB5NnNnUMTG80IvBf+8lnIjusDpw4m1BhPH
	P0jlfETkcuCj1xGdcqGz9osGnyqW+h5gRE85UvPKHtEKGHtRNAHpt9sw/O7T8DhfVgqgGZ2Zfs+
	y9mLk6sIKE=
X-Gm-Gg: AYBFou2WCcZMc3G5BEEr7Kx7cqHNgkHfSN73Lx3fHOUEwLxckXLd5pO+4FbbI7MHpCG
	fNFwVKbIA4zpVoQsTCwaS5km7Yoc+a+XIovaiADiU/RtJZgDPXvA+AcJ3yVwzASSsD+GanTGKPu
	IpTMlLjkVBGGRxXmMe/GHlOh74+Er86JbvTYQaXfZm3b/dU5tIDJlaifcUO+guZBHHSgvp7LmQj
	xNfKyu7X6VR1azzzZw2UrqeHHXFtVvPZXZUvrmra22JlDxx9LCmoToxyiw1bWT7Z2AQtQi2hIeV
	It2AXM1X3DEACYHhQB1rhkiuBArQYj3gM61RQHUU97ux10kaVtxBrgKARy8TAPuDgFmMpZ6NyYC
	rkYuhe+JDceQlAmfves3dSAOcTUNSEBDDGXna73svIxQIaHou/1sKDwL8w5WL1K1E7+VgPz1hjH
	URkOVj7d0vybJ84aBkSHrc4LLMuhQzubgFRzA=
X-Received: by 2002:a05:6820:c3c7:b0:6f8:2346:cd78 with SMTP id 006d021491bc7-713eb054edcmr1999367eaf.5.1793265353604;
        Thu, 29 Oct 2026 02:15:53 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-4a8b7724a96sm53590fac.6.2026.10.29.02.15.52
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Oct 2026 02:15:53 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-89fb6a45c48so2461954b3a.1
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 02:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793265352; x=1793870152; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IG3coSvH2rxonblcfd8xM/aTYWF217iDwaoPYy5Pq8o=;
        b=TvgeSWwogyrqyFediFfpDAYJOJxQeGv5G5t3Lx7yjVxHD96T4DkFBBAYcGrPveStJI
         ex0ZW8s6fIWWZ9zXkwwLLQgx4joLTKxPSccNCMJ1QrWpEamDIZCMRu6AYlTkfahTNuQO
         8XxLfj/aDVpLR3JyeXgCJuUk052rJ+KRm7d0o=
X-Forwarded-Encrypted: i=1; AKwUvBw80HilIpolr8stIw4WK+onHyBZk7/KnPNTQa6FYy15nzUVkLc+Zt24n6IHpl1LbkKhG0BJJqE=@vger.kernel.org
X-Received: by 2002:a05:6a00:1393:b0:8a0:7677:c895 with SMTP id d2e1a72fcca58-8a6e85a106bmr4158000b3a.50.1793265351893;
        Thu, 29 Oct 2026 02:15:51 -0700 (PDT)
X-Received: by 2002:a05:6a00:1393:b0:8a0:7677:c895 with SMTP id
 d2e1a72fcca58-8a6e85a106bmr4157983b3a.50.1793265351383; Thu, 29 Oct 2026
 02:15:51 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <DBBPR07MB73884DEF3976DAB7FB0713B1996E2@DBBPR07MB7388.eurprd07.prod.outlook.com>
In-Reply-To: <DBBPR07MB73884DEF3976DAB7FB0713B1996E2@DBBPR07MB7388.eurprd07.prod.outlook.com>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Thu, 29 Oct 2026 14:45:39 +0530
X-Gm-Features: AclHuK_jE9ny3O5kBamHrWz63GUjOUdzoYCFzT5Avlg_MlzQEkkx--nwS6BvmVQ
Message-ID: <CALs4sv15fD4j=j8EbNK_Oiyok70CEbYUrVw46EqdPEiiZDn29w@mail.gmail.com>
Subject: Re: bnxt_en - ambiguous timeout warning
To: =?UTF-8?B?RnLDqWTDqXJpYyBURU1QT1JFTExJ?= <frederic.temporelli@bull.com>
Cc: "michael.chan@broadcom.com" <michael.chan@broadcom.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000004ebb79065ef72062"

--0000000000004ebb79065ef72062
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 1:35=E2=80=AFPM Fr=C3=A9d=C3=A9ric TEMPORELLI
<frederic.temporelli@bull.com> wrote:
>
> Hello Michael, Pavan,
>
> Using Debian Trixie, I can see the following ambiguous message when the b=
nxt_en driver is loaded
> (NIC is a P225 with latest 239.1.168.0 FW)
>
> [ 1381.294010] Broadcom NetXtreme-C/E/S driver bnxt_en v1.10.3-236.1.155.=
0
> [ 1381.310464] bnxt_en 0000:01:00.0 (unnamed net_device) (uninitialized):=
 Device requests max timeout of 100 seconds, may trigger hung task watchdog=
 (kernel default 120s)
>
> This warning is shown even if the FW requested timeout is lower than the =
kernel watchdog.
>
> So, locking at bnxt.c (kernel 6.12.114) :
>
> #ifdef CONFIG_DETECT_HUNG_TASK
>                if (bp->hwrm_cmd_max_timeout > HWRM_CMD_MAX_TIMEOUT ||
>                    max_tmo_secs > CONFIG_DEFAULT_HUNG_TASK_TIMEOUT) {
>                               netdev_warn(bp->dev, "Device requests max t=
imeout of %d seconds, may trigger hung task watchdog (kernel default %ds)\n=
",
>                                                  max_tmo_secs, CONFIG_DEF=
AULT_HUNG_TASK_TIMEOUT);
>                }
> #endif
>
> The warning can be shown in 2 cases
>
> 1st case:
> when the FW timeout is greater than CONFIG_DEFAULT_HUNG_TASK_TIMEOUT
> However, CONFIG_DEFAULT_HUNG_TASK_TIMEOUT is a kernel configuration param=
eter.
> The kernel watchdog can be modified at run time by using sysctl kernel.hu=
ng_task_timeout_secs
> Shouldn't the FW timeout be compared to this sysctl value ?

It can still change after the driver is installed, in which case it
will still not be the exact value. Going with DEFAULT seems right to
me.

> In the same way, should be more relevant to display kernel.hung_task_time=
out_secs in the warning than the default value.
>
> 2nd case:
> when the FW timeout is greater than HWRM_CMD_MAX_TIMEOUT.
> There is not detail about this test in the warning message (so the messag=
e related to watchdog issue is shown event if there is no watchdog concern)
> HWRM_CMD_MAX_TIMEOUT is set to 60000U (60 seconds) in bnxt_hwrm.h
>
> In my opinion, it should be more clear to have 2 distincts tests, with re=
lated messages:
> - One for the watchdog
> - One for the driver internal HWRM CMD timeout

Yes but this is a low value change, is there anything getting impacted?

>
> A last point:
> Why the Internal HWRM cmd timeout is not set with the FW required timeout=
 ?

bp->hwrm_cmd_max_timeout saves it, right?

> (in a dedicated variable, with initial value =3D 60000U, then modified if=
 the FW is requiring a longer timeout)
>
> Best regards
>
> --
> Fred
>

--0000000000004ebb79065ef72062
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
MjAyMwIMClwVCDIzIfrgd31IMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCCzJuPC
uT6ptm384a4AQzZEUgpf+t+gDnC8HFsFgsXMQDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjEwMjkwOTE1NTJaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQApHJ1nqTHa9JTaBLt4GBsYvVM/pKCDMEZk8915NNMK
dcPIq0ILBVd0SB+pk/rbNSQzh/Zhs4XfcQWnURZNpn3aappqY7Bktu3qZ7AKhu9YBtr4TAugiTEt
IVtjS6AyI2+mzwlsUnV3prqq0pmqvlSVHiFlp1jGsmlf0SW4iX6ExKDO2RSlQNxqNGaoJ7L8ziIK
M058H6PebBxAZUiGJ1IHOal9vOW6GnjkvwDZze9X8fEvEboBR5rfrzLMBB7gPyN1WngQ6Z0eKMVF
1YMAAwqW6SlqGJoOjKUoFn1W7zeYPGMLopzjdEWz8xQ7gym6nTsSLeOBsRb7PXN2DN5ZFXHh
--0000000000004ebb79065ef72062--
