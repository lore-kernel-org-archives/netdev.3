Received: from mail-pf1-f228.google.com (mail-pf1-f228.google.com [209.85.210.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB91E2F7F09
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 04:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787286020; cv=none; b=KIVKWkDvstUluaJxUKGvPuhaf4afiaMTkNXPe/RTEEt2HjS6OcJuOzlyGjEJW51AE3Q/2oKAHwJzGc8XtofQSuM4ekvxOrRzaPRLUgGyU8CqCqlP8FMKV83nTRixwYiTp6JIjQ577M/OCRBw2YYsDa7gzC4K55X9poA03ce4rfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787286020; c=relaxed/simple;
	bh=Z6MxMcFGGNSCf9ekoQngj6dcATO6RIKIHMqw/fAqXco=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mKuH20SXT/iOxUsqbj1D9A8WyO3PKT6l15ICb1gUTMYBkoEgcUwV/VkbyZPDZi+sJx21f0s1It6OE1alEiV910A33JdPKoouxrnJFKzYorjLsXwQhiz3ig7cl6GK9Of96sk994jpXHgMbQBJ3cRfCkoicuB3sP+r2XABZeJNFIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=I+acG18m; arc=none smtp.client-ip=209.85.210.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="I+acG18m"
Received: by mail-pf1-f228.google.com with SMTP id d2e1a72fcca58-84e3007a2b7so472685b3a.0
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 21:20:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787286018; x=1787890818;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3yqqr7PiYNHfGSUaE0gWKM322NdJyYNyz95C+H4wzRw=;
        b=enR2TV9d+vu7v5yYdjtdLTYUJblpZnn866Gjyoi2ZqQjx2xNBUTAMojQ27+QIQMcDW
         y7CZc+mi4g30SfaLk5c7Il9FlUSpgoiEcL9PBYa2w5sQdm4hZ3gbHRHlT0q+VtqYdq4R
         UGF35uNK/40b0pJ35Jk44esqzpK8FAU6RDYhdzMDgOnQpeezi0LtsUknjE8d5Fu+u29/
         uKNb2CbT3D6iMj0G4iaOD3WSw+gHbZDLcrsgI937sp2KpPJCXl1+TWM+fe1I0z6Eryop
         n6YGnsULoLNwg9TpM6Yvt/oqh5XpN/qGtGTwxeCsOmqB4fYpVfbjKPfQGfuoKYM+zeBw
         LZ/Q==
X-Forwarded-Encrypted: i=1; AHgh+Rrid2YzROSv6d1FVtAEywSBdYjLfLg/bgiR6uHjD+fyi4MF2M+i+0uilPMzqdmJKhRPvkOOyrU=@vger.kernel.org
X-Gm-Message-State: AFuF++nQmfePVdRHK/f/m8JBIBq4H/HwnNYXNxcQjmE0Zy4yac43GxCj
	QO5Pc0lW8nqdjgmt3/YVrnyQEBpJqOzOpMq4ol4/B80ieeCiHuCzDAWgsGEi/7coxp4mpU5Tw32
	CbAGlxm0JHYwk2v80T2r1znd1LjDttOKzrXdrDpHNcjzINd751Uq8jBQtfFjoASeI1GCD7x//iO
	ldqzsFoqQMgv5jaPLs0J4hDImKEP/Mp/cYVhz8ZZC4MZNcu4sL+0kklCwdnWE0ee66tgw2WsFLh
	QbS/K6pMwg=
X-Gm-Gg: AR+sD11yAwO/cgruAemdWs1nzFl/u8zQP4cauNLu3sKhETckcJ9zI/wDsWVF4uC5DiD
	SbgGV7j5JrdS22s7fKr29gc+w4mZWpmkYnsbxRvq+T7be6JRUYgv3gl6qvxS4NhhrKPcg3J7GVs
	EKe9mdgiqZe/eKPNDVaB6zo9frP9VeVNnW400843wZzKuen0+kAxRG6/tvjsapwvNDh2BhhkZ7L
	ReV+XEuyhln3IkQKcaaByw/FqQ0JBj7A6vtCPusmVEtIp8shsGR6aA7xJii1CcXBKhf8x3n2qUf
	T1SVXObftKZ4LckS9LR0Agy6slTh59/OKCOTTwEFN4FuVXgaTz3A3toyqbHQRTxf6Xh1GNok1Lf
	XvDzovWgjHhI2pIuTyrlgq5q64HfoC8o/XDn01rzdKPqHMpZ2JLvGkKjAxNyb2rDdypm5aFo8jT
	ESEG3sqWuI0tWJAM7KhNYKOgEEkX5vCaYoI64=
X-Received: by 2002:a05:6a00:e1a:b0:847:83bd:6676 with SMTP id d2e1a72fcca58-851fa05baa6mr5496047b3a.17.1787286017794;
        Thu, 20 Aug 2026 21:20:17 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-26.dlp.protect.broadcom.com. [144.49.247.26])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-851d336b34dsm2352111b3a.1.2026.08.20.21.20.17
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Aug 2026 21:20:17 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84a67b16217so908610b3a.3
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 21:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1787286016; x=1787890816; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3yqqr7PiYNHfGSUaE0gWKM322NdJyYNyz95C+H4wzRw=;
        b=I+acG18m9j3yAi8HpqDjLlXQKbn36HaIp+KCbfUtjCXsmMDfxCZOv61+YsvOf/6bx2
         ae+OOmgx1rhz23R3VbepsUS0t1qjdxYfujiD/XfZsgAUUotJ9WRCalYRDOIiyX3Zp8ss
         rRgPVPSFSrf0oR94QlT96ika1UmiOKeya+ftw=
X-Forwarded-Encrypted: i=1; AHgh+RrZSrgeXrv1WawSSTeRBRByIdiB7Ss1wzk7+ra2+Kt82lsWF01l9euNs33NGqIRtGt9NZV+XBQ=@vger.kernel.org
X-Received: by 2002:a05:6a00:288e:b0:84f:3f5e:f072 with SMTP id d2e1a72fcca58-851f9f78300mr5349548b3a.10.1787286015847;
        Thu, 20 Aug 2026 21:20:15 -0700 (PDT)
X-Received: by 2002:a05:6a00:288e:b0:84f:3f5e:f072 with SMTP id
 d2e1a72fcca58-851f9f78300mr5349494b3a.10.1787286015424; Thu, 20 Aug 2026
 21:20:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820220544.1240879-1-thwalsh@redhat.com>
In-Reply-To: <20260820220544.1240879-1-thwalsh@redhat.com>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Fri, 21 Aug 2026 09:50:03 +0530
X-Gm-Features: AcwNN1VTOsRUSlRBNv7-siM0Rdlc-zyryAs0TT5Pn25LF1PvMOGPkOVJXB5NGnI
Message-ID: <CALs4sv36yBmdfnm8_PWD4CrAKboOeTLXYqY3vGSN=yz2ThV-Rw@mail.gmail.com>
Subject: Re: [PATCH net v2] bnxt_en: Gate TPH enablement behind
 BNXT_SUPPORTS_QUEUE_API check
To: Thomas Walsh <thwalsh@redhat.com>
Cc: Michael Chan <michael.chan@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Michal Schmidt <mschmidt@redhat.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000001b15f2065986f4ed"

--0000000000001b15f2065986f4ed
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2026 at 3:36=E2=80=AFAM Thomas Walsh <thwalsh@redhat.com> w=
rote:
>
> In bnxt_request_irq(), pcie_enable_tph() is called unconditionally to
> enable PCIe TPH when setting up interrupts.
>
> If the NIC hardware or firmware capabilities do not support queue ops,
> attempting to enable TPH during bnxt_request_irq() is unnecessary.
>
> As a result a flood of "RX queue restart failed: err=3D-95"  messages is
> seen upon boot.
>
> Older NICs (pre-Thor / BCM57414) do not support TPH or queue management.
> TPH requires queue management to restart the queue.  NICs that support
> queue management (with updated FW) all support TPH.
>
> Gate the call to pcie_enable_tph() and setting of bp->tph_mode
> behind BNXT_SUPPORTS_QUEUE_API(bp) to ensure TPH is only initialized
> on devices capable of supporting queue ops. This prevents a guaranteed
> -EOPNOTSUPP error from occurring due to NULL operations.
>
> Fixes: 1410c7416dc3 ("eth: bnxt: always set the queue mgmt ops")
> Suggested-by: Michal Schmidt <mschmidt@redhat.com>
> Signed-off-by: Thomas Walsh <thwalsh@redhat.com>
> Reviewed-by: Michael Chan <michael.chan@broadcom.com>
> ---
> v2:
>  - Updated commit message to include context on hardware support
>    and added Michael Chan's Reviewed-by tag.
>  - Rebased onto net/main.
>

OK with the consensus.
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>

--0000000000001b15f2065986f4ed
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
MjAyMwIMClwVCDIzIfrgd31IMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCDMt/Gi
66DzLRVz8oyQC9n84t/yu3DfgiAlhWUIZ6VmzzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjA4MjEwNDIwMTZaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQDFy2axtsmtTxeLXxUbJ2ejOfVxI2FV+KtoxNkKatsL
xLADI2LfxK4PF1FEDBKLCGQDKFdbXOgcIdj0E270IiaEbEQ5iI86KKUHOi7I4VcsDfB+00oT8l3j
guUYKDrCLg+75tsRRFm/Vu0i9nQZNteGH2D7AbWc0Q1307W+f6Ydj/duanmO8LFi0OctRaCWtTjp
5088ZwMeOLqmtp+10BFvk/PwnImrIPx8AH9xryakkB62zflBAwbiKrG4+5MWJ0qpm+kkk8mj+ECS
MfhSi3Mp6uvSvtzBEH2D68KGtenOo8kaZ1pIN6pbRqZ7HfhtsMDMtQiy3iNW2wMlAfndYuoS
--0000000000001b15f2065986f4ed--
