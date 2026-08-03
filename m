Received: from mail-ua1-f98.google.com (mail-ua1-f98.google.com [209.85.222.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA9738735A
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 16:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785775626; cv=none; b=QJhe+KI/fwUVWqqG8a6YpLRhbP7OkhnQZYmuiMVoM6wVLkhs0hVc2yf+YNnFeNL8Sf9AnhUlZaOHvh08cKnRfvGhvI+wkoNChVALqluBvSn33vGkNhsrIex1jqRQa1+DLYCzfSB3GtRaI/6fJ7v1hCYSw+sf1Rr/wYALGccgAdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785775626; c=relaxed/simple;
	bh=i69e9Dqf15DShYKdmoUnsOl+Igji7wV3vql1mkrx7U0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u3Ds62kf9RZFAt2NFSRWTXZHyFQilpYLeXzXui3SmScET39WvdLsgtH28eg6mnRJxW8opqGgynTURStmzFuekVkh3qMMcOzxqqKbUfyi3Epfvt9xOa6jGOvVmNu7U0Mmx/NqRQ9I6Cx2KsHQJ9419XnQbfMuLhvVKVJVEwu0APU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QUmAnRvJ; arc=none smtp.client-ip=209.85.222.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QUmAnRvJ"
Received: by mail-ua1-f98.google.com with SMTP id a1e0cc1a2514c-9770e900464so66328241.0
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 09:47:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785775623; x=1786380423;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Di/B8phqRShBoi9s2j8jfW7JB1l6Ai2HJUb3OWkMFzA=;
        b=Kiw8CjsfIvYD5nE+4UEn/SU7Z2jBh5YUvInEpjbWGH2HBEUQISXUlPh9a7q0Lsm2g7
         cwJS3aBz0iOuXQEelIyQi7ZJBQdbwfGDUsmHo5fvY5gwUi/okWf8yOuYJo9+hyGivW+o
         +aM6BB2iO2gX76/vYeV7IaJl4Drdg61VWie7T5wrdhMWNFJMzkGrdo9/DtsIJewxRQaP
         ZLMfiqy/P9bRjB00KhtPY5np9Y43Xgn0mR815I3VFqRmAB5MC/dqQ1bC+DJcY0FlFpSV
         zxI1xld5kIejymwMexm/8B0qexKTfHgPuGO5Al5IpRA1FreYiHes6pKhx7LwJjRB+yBT
         vGsw==
X-Forwarded-Encrypted: i=1; AHgh+RqgUx4ZTgHtCrRcBs51G+IFu7GlUT/7rJPCYK/Vln/nql1692IrNaaqHlvih+977iwrHxV60zc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJrjNeZa9eXs1a2xk05Fg4kt2QYGfSJ2aR1Ch/U1YBh/mDK2Kk
	QIher84yG4256yLt8KL2VwGEoT3Cu+s2IrRoRjJKvzJn/CW+UTmSLIssWLUZMMXUM76sYSr635C
	ufrMGUTA9DHlQXlwllInNKZw8Bd0EYLBvRn2+rwWkxZIbhK9MQGXQK6/21sX+YBNkkIm+p7SN1T
	J4itBp4QDgpk7STxeAI/g62KoFTI57ii18YCkoSMVgH3qm2BTev+KQK3GDn1vYWWIk0CrHPdlec
	ow5kAlasGjYGS+Y+A==
X-Gm-Gg: AR+sD11qiGoN3S2XIOTQY1hACHBpXlhxrfZOSihCiWkJk1+TULpChsCQcbiihmgGE3w
	p+ZHIS6wz+lxv3g5DgEbgnjZyOQjH6Hg53zOGN/CXQ7f9TIfdqhb8jAnFmj80uE+UOrQ2ughv0n
	YMApd40hmK8WfpJmDlu2S5JU5/1r6dDFaXlSL8VawJxcZnYuHqcWRwBWw42cVLfHTrYysP+qxmZ
	eUdk61sIXVid4+1xqhbywdsuzq/byiMM2b11IB+MeLI/ra7wOBIpDVyGYbdsvUS5iEvsW2fe9Au
	X3sQWwExQxinHeArYW6EKVqOHJyDhID4dZJFCPwalzJsfeQsZiZth2hgCoqrhFQdxSTkODg5RDl
	lKVJPsHTgCriMUcPZLScZ6q3KyRnBLv8iRJcD0iIFxEGvk5h0ErxbFIjVclnY+4nWKkQtpbO/j5
	4uT1Zf3niZ4x9FRj46WBdTJiNYQhqA25v/WHUyrbAdcQ==
X-Received: by 2002:a05:6102:448d:b0:632:5db8:f672 with SMTP id ada2fe7eead31-75f74d854a9mr162496137.6.1785775623298;
        Mon, 03 Aug 2026 09:47:03 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-22.dlp.protect.broadcom.com. [144.49.247.22])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-759b8918e3fsm882272137.5.2026.08.03.09.47.02
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Aug 2026 09:47:03 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cce14a21faso1242295ad.0
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 09:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1785775622; x=1786380422; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Di/B8phqRShBoi9s2j8jfW7JB1l6Ai2HJUb3OWkMFzA=;
        b=QUmAnRvJZxc/KsENZb9BG5ieNK0HjerejpBSpd5OQJFov2Rr4YvnhP8P2ZxlZLKdDh
         2gXhPnR9ZZt5T9/ice2xAYQEi+acPTf0i8E3asWT9W8lthqfd8McMYpYkOvfr3mT13/D
         42UlCGAyU8RqvdL1B893iHcmKyPY7Gx3TFAk8=
X-Forwarded-Encrypted: i=1; AHgh+RrV0Pde8Olr8vgrnKDyBaiXFtgRy64QgreWw2OWyPxfQLHjTT0GsnIkEyQ8nn2TUm+MQRjYz+s=@vger.kernel.org
X-Received: by 2002:a17:903:1248:b0:2cf:b23a:3e68 with SMTP id d9443c01a7336-2d08abc6e7fmr1947315ad.25.1785775621961;
        Mon, 03 Aug 2026 09:47:01 -0700 (PDT)
X-Received: by 2002:a17:903:1248:b0:2cf:b23a:3e68 with SMTP id
 d9443c01a7336-2d08abc6e7fmr1946965ad.25.1785775621474; Mon, 03 Aug 2026
 09:47:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731192301.1427645-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20260731192301.1427645-1-alok.a.tiwari@oracle.com>
From: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Date: Mon, 3 Aug 2026 22:16:46 +0530
X-Gm-Features: AUfX_mzWv-7xi2nCp81lIt5ugtO4sdQ0OJDw3g0edFRu94tx6crO_U6YqRp17fU
Message-ID: <CANXQDtZqg-7Qb_PwV2uJmbB1mJpg-27zfyiD3gEb+9HMfXVJHg@mail.gmail.com>
Subject: Re: [PATCH net] bnge: Fix NULL pointer dereference in aux device release
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: leon@kernel.org, siva.kallam@broadcom.com, vikas.gupta@broadcom.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	alok.a.tiwarilinux@gmail.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000009fcacf0658274972"

--0000000000009fcacf0658274972
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 1, 2026 at 12:53=E2=80=AFAM Alok Tiwari <alok.a.tiwari@oracle.c=
om> wrote:
>
> If allocation of auxr_dev fails during auxiliary device setup, the error
> path calls auxiliary_device_uninit(), which eventually invokes
> bnge_aux_dev_release().
>
> The release callback unconditionally dereferences aux_priv->auxr_dev->pde=
v
> to retrieve the parent bnge_dev. Since auxr_dev has not yet been allocate=
d
> on this failure path, the dereference results in a NULL pointer exception
>
> Retrieve the parent bnge_dev from the auxiliary device's parent instead o=
f
> auxr_dev, and free auxr_dev only when it was successfully allocated. This
> allows the release callback to correctly clean up partially initialized
> auxiliary devices.
>
> Fixes: 8ac050ec3b1c ("bng_en: Add RoCE aux device support")
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>

Reviewed-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>

> ---
>  drivers/net/ethernet/broadcom/bnge/bnge_auxr.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_auxr.c b/drivers/net=
/ethernet/broadcom/bnge/bnge_auxr.c
> index 67e93e17d4d9..0955b488b6fe 100644
> --- a/drivers/net/ethernet/broadcom/bnge/bnge_auxr.c
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_auxr.c
> @@ -141,12 +141,15 @@ static void bnge_aux_dev_release(struct device *dev=
)
>  {
>         struct bnge_auxr_priv *aux_priv =3D
>                         container_of(dev, struct bnge_auxr_priv, aux_dev.=
dev);
> -       struct bnge_dev *bd =3D pci_get_drvdata(aux_priv->auxr_dev->pdev)=
;
> +       struct bnge_auxr_dev *auxr_dev =3D aux_priv->auxr_dev;
> +       struct bnge_dev *bd =3D pci_get_drvdata(to_pci_dev(dev->parent));
>
>         ida_free(&bnge_aux_dev_ids, aux_priv->id);
> -       kfree(aux_priv->auxr_dev->auxr_info);
> +       if (auxr_dev) {
> +               kfree(auxr_dev->auxr_info);
> +               kfree(auxr_dev);
> +       }
>         bd->auxr_dev =3D NULL;
> -       kfree(aux_priv->auxr_dev);
>         kfree(aux_priv);
>         bd->aux_priv =3D NULL;
>  }
> --
> 2.52.0
>
>

--0000000000009fcacf0658274972
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
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGqjCCBJKg
AwIBAgIMFJTEEB7G+bRSFHogMA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI1MDYyMDEzNTI1NVoXDTI3MDYyMTEzNTI1NVowge0xCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzERMA8GA1UEBBMITWFycmVkZHkxGDAWBgNVBCoTD0JoYXJnYXZhIENoZW5uYTEWMBQGA1UE
ChMNQlJPQURDT00gSU5DLjEnMCUGA1UEAwweYmhhcmdhdmEubWFycmVkZHlAYnJvYWRjb20uY29t
MS0wKwYJKoZIhvcNAQkBFh5iaGFyZ2F2YS5tYXJyZWRkeUBicm9hZGNvbS5jb20wggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQCq1sbXItt9Z31lzjb1WqEEegmLi72l7kDsxOJCWBCSkART
C/LTHOEoELrltkLJnRJiEujzwxS1/cV0LQse38GKog0UmiG5Jsq4YbNxmC7s3BhuuZYSoyCQ7Jg+
BzqQDU+k9ESjiD/R/11eODWJOxHipYabn/b+qYM+7CTSlVAy7vlJ+z1E/LnygVYHkWFN+IJSuY26
OWgSyvM8/+TPOrECYbo+kLcjqZfLS9/8EDThXQgg9oCeQOD8pwExycHc9w6ohJLoK7mVWrDol6cl
vW0XPONZARkdcZ69nJIHt/aMhihlyTUEqD0R8yRHfBp9nQwoSs8z+8xZ+cczX/XvtCVJAgMBAAGj
ggHiMIIB3jAOBgNVHQ8BAf8EBAMCBaAwDAYDVR0TAQH/BAIwADCBkwYIKwYBBQUHAQEEgYYwgYMw
RgYIKwYBBQUHMAKGOmh0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjZz
bWltZWNhMjAyMy5jcnQwOQYIKwYBBQUHMAGGLWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dz
Z2NjcjZzbWltZWNhMjAyMzBlBgNVHSAEXjBcMAkGB2eBDAEFAwMwCwYJKwYBBAGgMgEoMEIGCisG
AQQBoDIKAwIwNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3Np
dG9yeS8wQQYDVR0fBDowODA2oDSgMoYwaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3I2
c21pbWVjYTIwMjMuY3JsMCkGA1UdEQQiMCCBHmJoYXJnYXZhLm1hcnJlZGR5QGJyb2FkY29tLmNv
bTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBQAKTaeXHq6D68tUC3boCOFGLCgkjAd
BgNVHQ4EFgQUkiPQZ5IKnCUHj3xJyO85n4OdVl4wDQYJKoZIhvcNAQELBQADggIBALtu8uco00Hh
dGp+c7lMOYHnFquYd6CXMYL1sBTi51PmiOKDO2xgfVvR7XI/kkqK5Iut0PYzv7kvUJUpG7zmL+XW
ABC2V9jvp5rUPlGSfP9Ugwx7yoGYEO+x42LeSKypUNV0UbBO8p32C1C/OkqikHlrQGuy8oUMNvOl
rrSoYMXdlZEravXgTAGO1PLgwVHEpXKy+D523j8B7GfDKHG7M7FjuqqyuxiDvFSoo3iEjYVzKZO9
NkcawmbO73W8o/5QE6GiIIvXyc+YUfVSNmX5/XpZFqbJ/uFhmiMmBhsT7xJA+L0NHTR7m09xCfZd
+XauyU42jyqUrgRWA36o20SMf1IURZYWgH4V7gWF2f95BiJs0uV1ddjo5ND4pejlKGkCGBfXSAWP
Ye5wAfgaC3LLKUnpYc3o6q5rUrhp9JlPey7HcnY9yJzQsw++DgKprh9TM/9jwlek8Kw1SIIiaFry
iriecfkPEiR9HVip63lbWsOrBFyroVEsNmmWQYKaDM4DLIDItDZNDw0FgM1b6R/E2M0ME1Dibn8P
alTJmpepLqlS2uwywOFZMLeiiVfTYSHwV/Gikq70KjVLNF59BWZMtRvyD5EoPHQavcOQTr7I/5Gc
GboBOYvJvkYzugiHmztSchEvGtPA10eDOxR1voXJlPH95MB73ZQwqQNpRPq04ElwMYICVzCCAlMC
AQEwYjBSMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEoMCYGA1UEAxMf
R2xvYmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0EgMjAyMwIMFJTEEB7G+bRSFHogMA0GCWCGSAFlAwQC
AQUAoIHHMC8GCSqGSIb3DQEJBDEiBCAWk34KEksuWNGuYzGEIcklodXKqMMOYLWVKZkQb29fZTAY
BgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjA4MDMxNjQ3MDJaMFwG
CSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYI
KoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBnmS0U
b9JWs6V+7JppIMk3jctJ84G6WWa4f9AnGsXFJ8RN7RxhJjH0MkKsv7unLxNpgLttB+V+ex2yynZt
nspGMwscKeY/PNV1/ML90JzluPNSRHWfcDaMf6jIKqOb+K9FSbX493QVrTvphYvi0GIaC8oJKDtG
+PGpeOa09nmv//VFHgmOoAlNmEujHrI0avbsibPssEPBXvvAYAZOuXYKc230fxlRfnYQKi1o0Joy
aaMD5SahUsHlutLjfshWN17/cBGjURLyVzN+ExBlA62cLohgbjqv2ajzL8T+6FtSGfBopYyHPDIg
gcgClwIrz/vNuHUu9IqfV9qBfn78NgDz
--0000000000009fcacf0658274972--
