Received: from mail-pg1-f225.google.com (mail-pg1-f225.google.com [209.85.215.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BB630E0F2
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 16:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786119202; cv=none; b=lEj4dupc1Vx/va+L/eKs01UmpMEyp0lKSapD4rk+fiUzcMVc8bHLElZNt9gysAZ9CoH9wLuDO25AFv0JEJJ7s+M3no4xsS+kfFvnqOhsSNGXTI4g4tuVm4oECrEORNcp3uKO61Ah5RzaSbfyiJ/5GWOhjwtOqGDOMH+b4dglxJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786119202; c=relaxed/simple;
	bh=snhIlsaXVI8ssQqhThDAiHPYfk+BpJjiEo5wi4QlZPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cxjfz2xA2utRUtCgSMLmivWzoWnIaOzRKgUvBuGJQC+uxt2YxYtqztB6FLEISBLl+iQ16J2X9hgmeOyWr0COrXooyBu/xmUobBrai3TX+FbdNE6bCsrmVYT7fSxxQ+fEqherVT9Ztf+Pm2ZZ8qbS+yA4IU3zLt9PAsNPwc585CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=STKOd86I; arc=none smtp.client-ip=209.85.215.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="STKOd86I"
Received: by mail-pg1-f225.google.com with SMTP id 41be03b00d2f7-cb5b8572b70so3896141a12.2
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 09:13:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786119201; x=1786724001;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=L/2V2ru4+nMDBZ/K2XKerKJOnGQZnPNnc9/Pk6bAe+k=;
        b=VOWCz6di8m4dZgYoSN2gpEWIBEVCaIECOkRvxvxHpsDEgiHEawuxxueEuSoNSPCKN5
         rKf+6j+KdI1DVROb6Mj1EGQGFnJkBbICC1ihero76DiYXsjaWKCSg+ZMf9TNCJH3N8YQ
         2y810XxC+XPyiMc7U2jJnLH73ZDRZ6IYcGrxyh20OcYd8qbXY0nvMbcqvNfOxOy4X6xo
         wxjdAZFiTggiQ7JBSLYBysOD5dqRXmBP0Yh7fkTDs+RaheFwo9BMyyoxifK1HWOe7t30
         +qSMR5dhdiHXh2cSMNKjh+I661biwKqkXNeaWplRjoatnXc8TirjA2XDtAUZ2n/adSvp
         Kuqw==
X-Forwarded-Encrypted: i=1; AHgh+Rp4zZhW/pOstWDf/Q3ENhyQY3MyVUpFATdv2BllAGh3lz/H7ytJV2MO5/vNHBRYH/BLlogUeM4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCWr1vbbBr6mnlP4ahFGeDdWSPZ8MYUEQsGdPnvmcmPhPtB9i3
	CfhhguG0YHYJxkgPHHqGXZEi6ywSEomDLv0kd0R85/2kwcVpO3LezIXmkck2A3aUu3YGwlmQzu4
	THqnVjlIAhS18jEC4EgxWV+0SVQPBzf80pruQeeppBUTA2RNae5zsgGDvXgzT5q0jlx30zASGco
	pyH6p7dmgvYc4WGN9JqwcMdPt11h7Dz2bCkq78P1NZ6NPAxuJtar7c1wgXr/IAAJBZKqPSIGl/8
	qfNsP0Joq7/wQ==
X-Gm-Gg: AR+sD1007+8274qDMyu/96QVjuBAAokAJSsh3pHapUbtq0eKtvcEtOthyJH5Vv2nDLU
	mA+Hh3IC6vMs7OU52dAKg9R9wtwWeiQBMMRi7hVPyryp/mtsOwuy67RLjiICvgNG1SQ0yPRXaPq
	ZDlnTQDDH+Nmd5sEek6nGEJMNFqrhrU8rdfy5joTq/IyhWpgy5trWkaZMplsKl00X2Xs3zXPTez
	oOuw5I1SuHZDZRofR8ctnfeUvxfOmz2sOaTQCuPo0kciH7CJ0d556roU/7EFTFFRN7J2Q2Ysuq1
	1LfdoKEE7ozVvjBCR1746iwhnQBwrEX8lS5Bh9WmLeHVEMKgPb437Cka07Lv+qy3liBNW20XOia
	e8QIVVGChqVqPC6VabTGXAQvWDNRNYLI9Sqq0u4BY0H3gxty+1xvexV3b8ooP34F3wyWgsOHi/u
	WQCByLgXZevHw9KpJwWGgXEHqwnetCtM8q9no=
X-Received: by 2002:a05:6a00:12cd:b0:84c:2d22:730d with SMTP id d2e1a72fcca58-84f2e025e01mr21966691b3a.29.1786119200599;
        Fri, 07 Aug 2026 09:13:20 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-84f5a488b67sm565430b3a.8.2026.08.07.09.13.19
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Aug 2026 09:13:20 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84859a64079so6094190b3a.3
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 09:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1786119198; x=1786723998; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L/2V2ru4+nMDBZ/K2XKerKJOnGQZnPNnc9/Pk6bAe+k=;
        b=STKOd86I5kXWZgB+hWFEhPG5rFN8fwbYiTFie1QuDeBJCHLwhzdCJUOXrojOKugenL
         UP4yl3Aa3HAs6Lh1AdGTisuEnWRc7cUKyg6Iu7mOC5nwud2WaJEs3GKTbtplSMWAFxKY
         GxtGQ1h4+ItyqciCOej0CiQPhwT6U4jHe4NGs=
X-Forwarded-Encrypted: i=1; AHgh+RpB+vwBoGyFyqwckNVRb+zGnCMTQRnntU8OL9C4toWQ2QKSVUqBJ1sKY5UZjH10+qIsMv11WtU=@vger.kernel.org
X-Received: by 2002:a05:6a00:399e:b0:848:4d1a:9556 with SMTP id d2e1a72fcca58-84f2dfd0a11mr24374384b3a.11.1786119198025;
        Fri, 07 Aug 2026 09:13:18 -0700 (PDT)
X-Received: by 2002:a05:6a00:399e:b0:848:4d1a:9556 with SMTP id
 d2e1a72fcca58-84f2dfd0a11mr24374312b3a.11.1786119197420; Fri, 07 Aug 2026
 09:13:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806201849.3161402-1-vadim.fedorenko@linux.dev>
 <CACKFLimm+_nUX4s5MoNw+cavA6pXr+1ZDpRO+4Fya-ZBfzhreQ@mail.gmail.com>
 <8d21f245-abde-47b8-a7c8-b62a1ada6200@linux.dev> <CALs4sv3A4bY6-+S9kid5BQEiyQ76gbpnYoS5r+=KUKsB48fyPw@mail.gmail.com>
 <a43426e1-91d9-4d8c-9514-3808928cc792@linux.dev>
In-Reply-To: <a43426e1-91d9-4d8c-9514-3808928cc792@linux.dev>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Fri, 7 Aug 2026 21:43:05 +0530
X-Gm-Features: AUfX_myTkN5jCwZGLbf0U-5KxO3v7w_--L-JWYfGxqC6tpLcWxvre193qrLs36s
Message-ID: <CALs4sv0pZWUJiWcUTj5W-zyV7uu5NFBTjT1nSD4yY=9H+p6xbg@mail.gmail.com>
Subject: Re: [PATCH net] bnxt_en: enable PTM function
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Michael Chan <michael.chan@broadcom.com>, Somnath Kotur <somnath.kotur@broadcom.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000580f97065877482f"

--000000000000580f97065877482f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 7:30=E2=80=AFPM Vadim Fedorenko
<vadim.fedorenko@linux.dev> wrote:
>
> On 07/08/2026 13:51, Pavan Chebbi wrote:
> > On Fri, Aug 7, 2026 at 2:16=E2=80=AFAM Vadim Fedorenko
> > <vadim.fedorenko@linux.dev> wrote:
> >>
> >> On 06.08.2026 21:35, Michael Chan wrote:
> >>> On Thu, Aug 6, 2026 at 1:22=E2=80=AFPM Vadim Fedorenko
> >>> <vadim.fedorenko@linux.dev> wrote:
> >>>>
> >>>> The patch mentioned in Fixes missed one main point of implementing
> >>>> proper PTM support. To make it fully operational it has to be explic=
itly
> >>>> enabled. Add missing call in probe callback and disable it in teardo=
wn
> >>>> callback.
> >>>
> >>> We were actually discussing this internally just a few weeks ago.  I
> >>> think the FW always enables it and that's why pci_enable_ptm() is not
> >>> strictly required.  I'll let Pavan comment on this further.  Thanks.
> >>
> >> In my test even though firmware was acting as requestor, pcie_ptm_enab=
led()
> >> returns false and disables setup of getcrosststamp callback. This happ=
ens
> >> because kernel doesn't know that PTM is enabled.
> >
> > I think the right thing to do would be to first check the capability
> > from FW (which actually decides whether we can support PTM on the
> > installed RC/platform) and then enable it in the kernel.
> > This is what we internally decided to do. Can you wait for us to
> > complete that work and send the patch?
>
>
> Could you please be a bit more specific on how FW decides? Does it
> remove PTM capability in case it's not possible?
>
> As you can see from the code of pci_enable_ptm(), sometimes parent
> device needs PTM enabled as well before starting TLVs, will your FW be
> aware of this?
>
> What I'm trying to say is that it looks like you try to reinvent what
> has already been implemented. pcie_ptm_enabled() is harmless in case the
> platform cannot support it, and you are gating getcrosststamp() by FW
> capabilities already - why do you need another check?

Ok I understand you now. Maybe it is fine to have
pcie_ptm_enabled()/disabled() called for this version of the driver.
Since FW currently always enables it, and these calls are harmless and
turn off .getcrosststamp on platforms that don't support PTM, both FW
and driver/kernel end up working in sync.
Only thing I would argue is should this be done in bnxt_ptp_init() and
clear()? Since as much as PTM is a PCIe feature, the cross timestamps
are tied with PTP.

--000000000000580f97065877482f
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
MjAyMwIMClwVCDIzIfrgd31IMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCAdbcxm
xrMnYIyvPCyC35JFds+bh5Vcyod1iIIM4BK7cjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjA4MDcxNjEzMThaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBn3Ca4x1v0BFR1pxwmao9+dw8hGDXOhZhp98nsNJos
p6ONL0oCxkqFyCQ1HVxMBxK9+MMexQF4GVGfIEUJaQW81ziPFkqhJSzMEgAqYtnpUaTirVI+LuH/
5CUhH9f2/NRwVCeRYfuYEc9Z280n8+tNehiSG+84Wc+hIUcJto0dzPyhUlRm8UotNaoEZZwukmkd
nAbhgC3IGFS+XoSl+mNKO8ZPSsHB6nmSwV8WdT9Wt66TbjyDuNJyS9+IRJxFOxg1IDzXv9EmE8bg
7/qm+g2sIJWaP7/eFMnItGuK0rO269Qtq9Pb1QolmOSTutbfnMB1nmmQxcCsfopsEBg1luxe
--000000000000580f97065877482f--
