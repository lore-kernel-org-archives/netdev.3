Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794527269;
	b=k9ollYxtPmgUkZXDQjj79oX5ajpHbxDgOr3b6QlQXEfwKanDhdKRHYmkvwQ32G2ZKg32
	 rOtG6SOihKkkKw2mvVnlp9oGI4HTCthdKHzEf570EcLZYJ/ju2GkGBx7N1xUO/4oRIyGZ
	 O8NXn2ThD+9S2GgWzH63Csot+9qsO6CtBclonzBHTi/lg1uIPn72lqe2H/uNh0yKSVxK8
	 48/YzmM4htO5I/XMOm96ju5C/P9tIer7T1VG2YYcpym+ALYUvqgvdSFeIXCj+uw6L3fQe
	 ytPkoTju0YjGFdfhexZJopuqItuiuo6YFIUPp+x2rV6h6sbtBTxVax8rhzntcEyk91w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794527269;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-DetectorID-Processed:
	 Content-Type;
	bh=9OvE8qoDCjV8jnjn5/yVNrYcjGXjQs9lclwVCSK9bVs=;
	b=Bk/Wn+E6AOwGOQQ/ZHNVclXmwmnhDGDzDluBAs1C0hn+zDaiVgW/z5L9iiKr0x5dXiY2
	 YwOD73KpCDgWUxe8tMc8bSSlEw6hR1EsLbX+o4lRCPQdPmHTmH4LNJfNBOaS1L9/lJQdc
	 ZH5lvF4fK2XSnxS/K5nmmVsQ2zdN0uHXvNsNqBB0ZILzH6fxeNoZl5ZSyA89yn4Nocwbw
	 0snkLRmMhiAJAZZL0kF/xNJTke11a1wiHjySeyenRWhemdqpt2zOj9Hmgyg5pO2o471ij
	 OGMchfugZW9kiSYJlEPEylUTexFa+384d9xv1k1pCANUEsPBqlR201j0i0/CfnAIDkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=c6UdY5Aa;
	arc=none smtp.remote-ip=209.85.214.228
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7973E606A321
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 23:47:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7973E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=c6UdY5Aa
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-2e940d5d2beso1589105ad.0
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 15:47:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794527268; x=1795132068;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9OvE8qoDCjV8jnjn5/yVNrYcjGXjQs9lclwVCSK9bVs=;
        b=zRYPzzSP6npRGNI4lfv3XkyP7TjTb4uvzhJRYtuXtDqSvFcqz9WrWKcVaXM/1wwhve
         2ygBHnVmTUEiWq8SPGNmrlS/tfULvGFluBO7qk5gfstmu4LG79G08erB23EBhugT6HJW
         1IOZh/u2CDlafAdRRGxffFTjwCRsufhepRMbUyIPSLciliLKSktldO8mMq/2LLWi50u1
         IZN1+0k1W0Rm59bU9DLfr07Awt+EfapD8OF7H/9GAZC7SzyBlKNjm6iQR7ypNNAFM9Ki
         RWheFBJxGy1uWPkqpQOwfrVWQT0EMKtJ7hXedfUa8+LfFvl7UhH3vGxwBjww+Qe4rf5O
         y4yw==
X-Forwarded-Encrypted: i=1; AL+hErHxbQDOEcCyMQfvweEy7ifyfUU7WrAkKsE8dRmF0fHfx/ifOEENzqr6oG7fB9j8nEgTweprm/w=@vger.kernel.org
X-Gm-Message-State: APuU4Z/eCyhpCSL9M8CxOXjKgwW6diydItLvzwtmgaEapTgNh5Y1lpVq
	Xy3REgfCYlCiu2C7/IZ6V/uMCADUYQy2GuKqe48UaluSyxoObdLUXjEe7hyocJF05HMohGWz4hD
	43O0eGGGspLTc2aFxDgvn+pDTL0P4URG0U/pTeawU6HEvpVSQc/Bh5EjAfswECA+JjtOcHLqpo3
	zQqZCyzAvGIslQ8fkk8aQH4PTc6O6BLx4jg/FRV37PIgnh26qNvEFBic8awvVCVGF5xLCkxU0hf
	/x1T8Qqr9k=
X-Gm-Gg: AYBFou2JVBY6snzTdocPBu3IZsgXEXAT+A6PeQSmxVbMbct29L5z8agFehMTnivBPc4
	ON+BNaX1vwEpUoPawXEFufjcN+Y5jfgG9Z0kcgiwND2SMBjMPXsf0HUEvghjz4gUhbmdSkR1+9S
	K7bNRGePc/g5P10ndgjSt/qI8OHvN76ISpW4ML8cuJpKV3BWGu9m6HlQZ8IoewnkbCwt/5yTktl
	pV2PZQn8efyUJ97oSs2qzVo1QJlGhi0S6hamLlyyExWFCRuvan4/3cj97cUP8+rQpXmYUzODjo7
	FWx2xPtIANsUBNfqgqJCDBXVfJqvPnUwXzBNs+HoPrJ/vxK8sKd/DSMpRr9bU+RAEO251sPJX17
	UmXIHyEqVUb5UCeBIih5xfODEhqX2YRAqfZqiOgPMRikzal8PGwTGndplAetOrXQ/hAVf5+TBI3
	jOi6i8ASvkUD1kfowupLoHm8t1aSRWVoaBwcE=
X-Received: by 2002:a17:903:2a8d:b0:2e9:58c5:8c68 with SMTP id d9443c01a7336-2ee0dc95826mr6716135ad.54.1794527267476;
        Thu, 12 Nov 2026 15:47:47 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-22.dlp.protect.broadcom.com. [144.49.247.22])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2ee0f4fe47dsm326715ad.8.2026.11.12.15.47.45
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Nov 2026 15:47:47 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c49b95262a5so21394366b.3
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 15:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794527264; x=1795132064; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9OvE8qoDCjV8jnjn5/yVNrYcjGXjQs9lclwVCSK9bVs=;
        b=c6UdY5Aaw/jUdUfS8mJuBLiERoSNuC9lEzfIoUASSb/X/cJICqnkKADk8bA5bpRNJo
         PAvJhUlJmq59FYGWOFrpBn9xHqyKquaqIcyohzNxB/z4jk2SPg6XWtdv/DiK++vYlaHn
         ppYTq8ScafPpzo9R+d8eK2L7BCxwzdEkP1xB8=
X-Forwarded-Encrypted: i=1; AL+hErGbmIHEweQPqHQCtp+9B0Fq5v1LPLOEEvS2MAKYDGczjAcLt4cVBseIROHwktEmW57sIs35Ksc=@vger.kernel.org
X-Received: by 2002:a17:907:608f:b0:c4d:456c:4a29 with SMTP id a640c23a62f3a-c50963dca44mr62977466b.14.1794527264207;
        Thu, 12 Nov 2026 15:47:44 -0800 (PST)
X-Received: by 2002:a17:907:608f:b0:c4d:456c:4a29 with SMTP id
 a640c23a62f3a-c50963dca44mr62976966b.14.1794527263855; Thu, 12 Nov 2026
 15:47:43 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110174943.2106347-3-michael.chan@broadcom.com> <179450866678.2199510.18044059314286997868@kernel.org>
In-Reply-To: <179450866678.2199510.18044059314286997868@kernel.org>
From: Michael Chan <michael.chan@broadcom.com>
Date: Thu, 12 Nov 2026 15:47:30 -0800
X-Gm-Features: AclHuK_zE_KNt0wKp0Et1Gyw3xrnZZvT9fKu2T781jKNPfOAaJ27K4lB6RgvcFA
Message-ID: <CACKFLikGcfud2pPGMDs49BUAFWcSUy4Ep=UY3NXYHB+bBbdkNA@mail.gmail.com>
Subject: Re: [PATCH net 2/2] bnxt_en: Wait for the PF in bnxt_resume()
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch, 
	pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com, 
	keegan.freyhof@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000024b9c706601cf0c7"

--00000000000024b9c706601cf0c7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 10:37=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wr=
ote:

> [ ... ]
>
> > +     if (BNXT_VF(bp)) {
> > +             for (i =3D 0; i < BNXT_RESUME_MAX_RETRY; i++) {
> > +                     rc =3D bnxt_hwrm_poll(bp);
> > +                     if (rc !=3D -EAGAIN && rc !=3D -EBUSY && rc !=3D =
-ECOMM)
> > +                             break;
> > +
> > +                     /* Wait briefly for -EAGAIN (FW busy), a bit long=
er for
> > +                      * -ECOMM (PF down) to allow the PF to fully init=
ialize.
> > +                      * For -EBUSY, the message typically has timed ou=
t, so
> > +                      * try again immediately.
> > +                      */
> > +                     if (i < BNXT_RESUME_MAX_RETRY - 1) {
> > +                             if (rc =3D=3D -EAGAIN)
> > +                                     msleep(250);
> > +                             else if (rc =3D=3D -ECOMM)
> > +                                     msleep(750);
> > +                     }
> > +             }
>
> [Severity: Low]
> Do the commit message and this comment describe the failure that the logs
> actually show?
>
> The commit message says:
>
>   the initial FW message may timeout if the PF has not been initialized.
>
> But every quoted log line is:
>
>   hwrm req_type 0x0 seq id 0xb0 error 0xa

We can tweak the commit message a bit to make it more precise if there
are other changes.  The Medium issue below is not valid (see below).

> > +             if (rc) {
> > +                     netdev_err(dev,
> > +                                "Firmware not responding during resume=
, rc =3D %d\n",
> > +                                rc);
> > +                     return -ENODEV;
> > +             }
> > +     }
> > +
> > +     rtnl_lock();
> > +     netdev_lock(dev);
> > +
> >       if (bnxt_hwrm_ver_get(bp)) {
> >               rc =3D -ENODEV;
> >               goto resume_exit;
>
> [Severity: Medium]
> Is rtnl_lock() enough to make the VF wait until the PF has finished
> initializing?
>
> On the PF side, the end of bnxt_resume() drops both locks before it
> reconfigures SR-IOV:
>
> drivers/net/ethernet/broadcom/bnxt/bnxt.c:bnxt_resume() {
>     ...
> resume_exit:
>         netdev_unlock(bp->dev);
>         rtnl_unlock();
>         if (!rc) {
>                 bnxt_ulp_start(bp);
>                 bnxt_reenable_sriov(bp);
>         }
>         return rc;
> }
>
We've double checked with the FW team.  The FW will not respond with
success to the VF until the PF has finished calling
bnxt_reenable_sriov() for that VF.   So this Sashiko Medium issue is
not valid.  The VF cannot race with the PF calling
bnxt_reenable_sriov().  Thanks.

--00000000000024b9c706601cf0c7
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
DPVtLUtep/P3evQuAtTQRaKedjamBcUpJ7qUhBuv/Z07LlLIlB/vfNSPWe1V+njTezc8m3VfvNEC
qEpXasPSfDgfcuUhcPR+7++oUDaTt9iqGFOjwiURxx08pL6ogSuiT41O4Xu7msabnUE6RY0O0xR5
5UGwbpC1QSmnBq7TAy8oQg/nNw4vowEh3S2lmjdHCOdR270Ygd7jet8WQKa5ia4ZK4QdkS8+5uLt
rMMRyM3QurndiZZJBipjPvEWJR/+jod8867f3n0CAwEAAaOCAd0wggHZMA4GA1UdDwEB/wQEAwIF
oDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3Nl
Y3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEF
BQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1Ud
IAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIB
FiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAy
hjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwJAYDVR0R
BB0wG4EZbWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBQAKTaeXHq6D68tUC3boCOFGLCgkjAdBgNVHQ4EFgQUJbO/Fi7RhZHYmATVQf6NlAH2
qUcwDQYJKoZIhvcNAQELBQADggIBABcLQEF8mPE9o6GHJd52vmHFsKsf8vRmdMEouFxrW+GhXXzg
2/AqqhXeeFZki82D6/5VAPkeVcgDeGZ43Bv89GHnjh/Vv0iCUGHgClZezpWdKCAXkn698xoh1+Wx
K/c/SHMqGWfBSVm1ygKAWkmzJLF/rd4vUE0pjvZVBpNSVkjXgc80dTZcs7OvoFnt14UgvjuYe+Ia
H/ux6819kbi0Tmmj5LwSZW8GXw3zcPmAyEYc0ZDCZk9QckL5yPzMlTAsy0Q+NMVpJ8onLj/mHgTk
Ev8zt1OUE8MlXZj2+wgVY+az2T8rGmqRU2iOzRlJnc86qVwuwjL9AA9v4R13Yt8zYyA7jL0NiBNP
WaOSajKBB5Z/4ZVtcvOMILD1+G+CVZX7GUWERT9NRXw/SyIEMU59lFbuvy4zxe3+RbOleCgp3pze
q8HE2p9rkOJT3MkCNLxe+ij4RytIvPQXACsZeLdfTDUnjeXCDDJ9KugVhuqMelAZc4NissPz8FOn
2NK++r5/QamlFqYRhsFxSBIvhkh2Q/hD3/zy4j17Yf/FUje5uyg03FblSBOk2WYpRpXEuCpyn5pb
bYVIzfhQJgwGfO+L8BAeZIFjO1QL3s/zzn+RBlTl4wdDzh8L9eS+QEDhMcSsqb4fFRDbsoVuRjpx
R5MunSUzk4GcmmM19m7oHhPGeKwIMYICVzCCAlMCAQEwYjBSMQswCQYDVQQGEwJCRTEZMBcGA1UE
ChMQR2xvYmFsU2lnbiBudi1zYTEoMCYGA1UEAxMfR2xvYmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0Eg
MjAyMwIMZh03KTi4m/vsqWZxMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCDmb8XD
uMUMXTtz5hqt+4ZF6FGgPhEMaIdamBskywAJvTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjExMTIyMzQ3NDRaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCB2/GOb2nHHnl8cosHKLZTQ7rAY3c/6hVSJ9y8y6VC
HBwyQWxcsmkzJSHafFEeildEACndqTcpAmzcu6rGYVfoSnj+9R0B+ffikjObmFAZsW2QOT6pADZE
u1/8L3fvbw9JcT9gjXnaiVAzq2RHZyOwxPIEvcFCjWR0nGo636esJXWy+oPIe8pDjYpbLBrHF2Rs
bcn44xENVU5yEKM0pgeW6BB38bUmcws31t6CdrBlXWh5OI5NyUECJa2eXvlnjJ6Fabmy8LZs8BfJ
GQE7ey/HizwM4GBT866d+G6jzed5okXMFCAJa2xbm+ktZheh2q2WasBSkC9Uk/Sf0Mgf1P9O
--00000000000024b9c706601cf0c7--
