Received: from mail-oa1-f97.google.com (mail-oa1-f97.google.com [209.85.160.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1281368263
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 06:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785393328; cv=none; b=PXBLZodkBj743IWW59uV5gj7+CaYw7JnJo0bu5eFtx0E7iD9AkcWDir6DnYl9RSaPr+8ADy6lqaqT/SnJ7CKRobwznT4jujlUJfQRRlF6kEsUZ5UdRKb+2t+c7T6/0xVpS3VgQwFKl8vs4nooLPA0JPoRqyaa3p+dHQ7ZYUifig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785393328; c=relaxed/simple;
	bh=J5vZTxUpBflOe54oFn18oXdJHySodDRj/pKuu23IJwU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j8YWVlj5T9Vsw/iTJat3YKuHjZrl2+0wDLt9VhvsIq9SWoHVBBbdLgzFZLeHAnEXm/knKfIXQSxhhmqf/nd3BGf6lhBVxYr5ffCJplBU2LXwKPnOH0YPipd9yT+Q+XzLrgrZtKq72KkqsDsMfsn64kpuPh1qfNiWQ626+fnzLOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=bMPnjGfr; arc=none smtp.client-ip=209.85.160.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bMPnjGfr"
Received: by mail-oa1-f97.google.com with SMTP id 586e51a60fabf-43b7e186a0cso515597fac.0
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 23:35:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785393326; x=1785998126;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=o4txhQCdGGm69Rz7gvizavJPPFx4klwZzUSI5gjzUvc=;
        b=nAMoNMvOs5R97l0kR3HHRdiXNg+wr/lS48OtVIhMyE8KMr6ARUelu5pLC/gT6tCu3k
         MeOtyr8hrgWq71KC83baEXLCBlZogyNskQP55z0DQyFF7jF8U74FScWURCeFAaJzoDG6
         GolhoJBTQ7k9pPZegO3+SiL/66/IQYbxVewKSO08Vcx2jnH+kMxfY2xeuhJWbojYwiza
         s9756IEtyQ/yMqgLVJ1c9ZOqTrIeezqNhsrggvAtc+pIeNP7OeaxW0kX3//vB26WWqey
         G4nLAJFZdps7R9zhZJm/UfJz54u0ay6Xfz5OohanFjajynOgGpDME1s59jAET6fjkJjR
         zdmw==
X-Gm-Message-State: AOJu0YxYN3kQVR/s/6xrgo4IaIqWwEsYMmUr/kdT5/SFzXyzKJYMoXYp
	OluN6zRfYX9z3bbTRfcqrMpR4png1/A+0NHj241o9RyRB2JfVjGWj5sTWcEWjbfLRoGcmFUrUEH
	lXEakz+C5serXX4V8OkVPzJyxbAk6VhiI6eH6jHGk1daV7MHLMo3dbkT5BFjz7mk7GmqyRNVwvH
	5uibr9SPc5RH/lavh3/yXdIeWmqBNuE3GFTvPhEE66QZgfOK3KS3mL1+bHurH6nRDt5yClrvygM
	CFAyUgv2RY=
X-Gm-Gg: AR+sD13pPth++trSByzn3dvQ+sa7m1bu8nGcFnci+jylzMELmRrrHgnC3g4NU+DRxJc
	1N1GIXqrFyemjObaAaWxrZAKaN+0OA9TSQo+bJ/OR3bM5s/i1DXUUJ+0WfIsGhcSyU4ubgbPtrd
	ot8O0S4EdCada0jCXCrXNrYntNS4hgNrALV33dwNrct5aveYbGO76Deo/VStF+YPwuE6MeKDRN9
	4lsrr+a6wqREUQ8QZ/JZICHXrZZtICLuBjCKf1jTMSKruMUe+Sa0CS7NWrHJJEphP+Nsl990ymk
	qoUj1fY2eWNxGeorlB4YTIr8ql1r3hITgZ9cMTX4oAvCEuyxAOdaZ4gBurHc69/Uu94Vp3bF/9f
	GFSInLygCpk7zkvbLrg6WulbW90t7KWEdUhi8nReos/A3b1+KxawPsC41EGFDDWWOSrt3kNEAZT
	NybpmsOZX/YqxM1BDDCPRk3Ed2Cfz+onPfL80=
X-Received: by 2002:a05:6871:eb14:b0:448:4fe7:8b68 with SMTP id 586e51a60fabf-458c1ae9978mr746417fac.26.1785393325602;
        Wed, 29 Jul 2026 23:35:25 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-26.dlp.protect.broadcom.com. [144.49.247.26])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-458c2bb1e9esm107852fac.14.2026.07.29.23.35.25
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Jul 2026 23:35:25 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c15f0aea084so139523866b.0
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 23:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1785393324; x=1785998124; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o4txhQCdGGm69Rz7gvizavJPPFx4klwZzUSI5gjzUvc=;
        b=bMPnjGfryec8jfUZx+MTsyoB8iB34Obgiy6lTi9AlUu7RKtm79C6FAHQDSCrqArTCf
         v+yWT8a9b6lb8p/x7TIpcFnstMFf2s3xiAxLoSkPug2rT2Vwa51vtD2dF2682sQn4inu
         XWFf1BNOijTgAY8SUgRDxZtoGJYq4YTbL3DfU=
X-Received: by 2002:a17:907:9625:b0:c1c:6150:c2f1 with SMTP id a640c23a62f3a-c1fa53ab08emr70827766b.8.1785393323828;
        Wed, 29 Jul 2026 23:35:23 -0700 (PDT)
X-Received: by 2002:a17:907:9625:b0:c1c:6150:c2f1 with SMTP id
 a640c23a62f3a-c1fa53ab08emr70826066b.8.1785393323416; Wed, 29 Jul 2026
 23:35:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710042400.3996847-1-michael.chan@broadcom.com> <20260710042400.3996847-10-michael.chan@broadcom.com>
In-Reply-To: <20260710042400.3996847-10-michael.chan@broadcom.com>
From: Michael Chan <michael.chan@broadcom.com>
Date: Wed, 29 Jul 2026 23:35:11 -0700
X-Gm-Features: AUfX_my0U3xxMIGWrks9f9340Ak6HTz4u-L2KfRAz3IjgUoibJequBXCleJAhLE
Message-ID: <CACKFLimbGNJSg23FuzrTehD63K644eGKu9yuVJGfshyZN+odww@mail.gmail.com>
Subject: Re: [PATCH net-next v5 09/15] bnxt_en: Add infrastructure for crypto
 key context IDs
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com, 
	andrew.gospodarek@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000de4a3d0657ce46f3"

--000000000000de4a3d0657ce46f3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Responding to Sashiko comments:
https://sashiko.dev/#/patchset/20260710042400.3996847-1-michael.chan%40broa=
dcom.com

On Thu, Jul 9, 2026 at 9:24=E2=80=AFPM Michael Chan <michael.chan@broadcom.=
com> wrote:

> +void bnxt_clear_crypto(struct bnxt *bp)
> +{
> +       struct bnxt_crypto_info *crypto =3D bp->crypto_info;
> +       struct bnxt_kid_info *kid, *tmp;
> +       struct bnxt_kctx *kctx;
> +       int i;
> +
> +       if (!crypto)
> +               return;
> +
> +       /* No concurrent access; see the locking note above. */
> +       for (i =3D 0; i < BNXT_MAX_CRYPTO_KEY_TYPE; i++) {
> +               kctx =3D &crypto->kctx[i];
> +               list_for_each_entry_safe(kid, tmp, &kctx->list, list) {
> +                       list_del(&kid->list);
> +                       kfree(kid);
> +               }

Sashiko:
Is the locking assumption stated in the comment always met?
Looking at bnxt_io_error_detected() in bnxt.c, it appears to call
bnxt_clear_crypto() without clearing BNXT_STATE_OPEN or synchronizing again=
st
asynchronous socket closures:

bnxt_io_error_detected()
  if (pci_is_enabled(pdev))
    pci_disable_device(pdev);
  bnxt_clear_crypto(bp);

Response:
Yes the locking assumption is always met.  In
bnxt_io_error_detected(), we do this under netdev_lock():

if (netif_running())
  __bnxt_close_nic()

So BNXT_STATE_OPEN is always cleared and the device is quiesced before
we call bnxt_clear_crypto().

--000000000000de4a3d0657ce46f3
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
MjAyMwIMZh03KTi4m/vsqWZxMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCD2BW77
NvJNfDd7sCAkcgvIOYlTozSscNDHcP3QJNY3DDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjA3MzAwNjM1MjRaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBAe279Dg+SOCj28Pmq8rFC9Xmwm43vQIEP1dpFyZgS
hddH6Gv6UtkzpjoGcGBEhdwjRFUG78/sKH9KYhTBXx4aTblRVxwUEXGroF2/COiuz3lbymW/SGuq
pdkyh8BoewIIMuBVBkH6DKwlQF9WJXptN9z1kybi2aoMLixTh5Y4cP5x4i7U08swCXqpke3IgpQ8
zesQIF7wJyf8Xo9fhmKRjc8hVT+WkuPvfifxKWWCw36Qhe0S3xW9zT++K2fZ9HD2YpX0+/mPYHYy
SVhO4TuqKkEG/uPbo8NEQ5U0cr5AdgO3JyIM6VYdskXR2DB36qzk+rWtUdoowwj1IcUM9Qxu
--000000000000de4a3d0657ce46f3--
