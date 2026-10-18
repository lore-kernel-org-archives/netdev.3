Received: from mail-qv1-f99.google.com (mail-qv1-f99.google.com [209.85.219.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35544382F0C
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 15:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792337554; cv=none; b=gaSCnvL619rPGrFLzCEH/qb5IVY/bkdY7Si2OvnU5f+BgeBAln7S1hU7KlnDeL/3Bb55K53yXyCUZhDX/UNpT9YilABhdZsJtcrR0lEs0zK6pWM+Zq/SZ661g+GGqgaoaOGsayVyvNEgFsvxRjumdcuX14eiexsEzT71eMF1ZUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792337554; c=relaxed/simple;
	bh=mHfa3UVs1EDrVFJfq9wtx0TL7XL46cjKFZvNzHvcpIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JhVB0Las25V0EtdekNtgsskzkwC+pCX1TcOfNKyYuJOMFQnlej4AADInFBHbEVwYfGqPkOCBQ4OelvCh7U7bhWQwLeDljmarOat7YiyHxtPn+zUWXFfosbB2k0nezTesPqgxWdak+4ZdcckUC2Z0rfGyOEHeaaWUF6bKx+nkDuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LZ30bb5i; arc=none smtp.client-ip=209.85.219.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LZ30bb5i"
Received: by mail-qv1-f99.google.com with SMTP id 6a1803df08f44-918f75a68f0so21801916d6.1
        for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 08:32:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792337548; x=1792942348;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BkN9HRmKBgkqsLLM19jZtVX1xpsg2Nw7kLQilzGsDgE=;
        b=FKwohxYaTzWWHMO/ajoZUphhP9ZXRbR6CqDhZhVcg6m7kEfmDqbbuRFKkV2L78ITeB
         WYJz3KESb0VanqmbrUKFD0htnN4x+2LCvzJEW7Kl1v4lgD76h7M5EZ5QBTyePc9XrC7k
         1CtMrQ7KYMRZFzFYIIfGvLZFuXTTgUEDxuyrVly+wOnQBAAshkiOZpojwJKX7KAXJHma
         NdhHO8NR3x6VoxLjMXr7ZTg4lw7bErx11KEpfCEBVompxLTerJ8/m4oCKbqePuGK3Ftu
         81PjBOilQDoxWTfPnzZ1Tzt4pyFxD9y9jVApGim4ZBpX2GqWcKbDrAOZvHRb8i9imF/B
         mGNA==
X-Gm-Message-State: AFq9FYJKhjRePab7FrR4tcnCtdCAg4lbbPbnpsrA25GvErRaoXCoJGwM
	8TJbLSj2JATTyuBxA94ZadEDnbfqomceDfHmodEkCtuT3nhVzNbTagpTpXewUm8fh9+4RzvWdOo
	VAAiXJbMNWXRdogWePdJ5RNGipN7I4XXdZdTFIsRhnuTVd+wwDUydHYjpFr8Gbl4hvVJhoYizi/
	gIVsnGWlEDygr818T8Yuf6TFcNGu9adYeHaD4FyNWMOIAOjUIqJZyzwN0YjddL06QzxfhK2QxqG
	MATDK19pyX0LLMB3KrU
X-Gm-Gg: AYBFou1N43wM2swktgGKPumtUHjX8hYRZvv1Sqk+VaMRsbPa8a3+0bqvfcuPtvaV9W2
	HzJUZSv5law5536UvKvu1OefCAgutHCgafYJT4lWgnd6o9RgYtKAyPDaDVxd5+hn0Icmu0spaIm
	26LmBUSbPUhwP49ScZaw0Hbww224vFgkq9gRJBsM5HrWLvqeRrXEVD8CPJ2YV19jCwi46PeK6ko
	f1HROfu4chD+cinMaGFdcxPlE+tgGuWjXDCDMRJQbe45lYn0JFaVHYthCfzPLLzqH71sh6uClOg
	Kxb9SxkAD5iLh32tlolkhYSjvMlYr8ZKe/ussnwJdPfvkU9+jIjuXliEV9Vw3rD8EB5T8usja+/
	Nr94D31QLQ6cLQy4b2FzvI6IY+76s+SOV58mORu25lXwpVLFDsUlyoW+dy3e6lR8xLP5XNc+iP4
	nQ/5xvJE/mWmKVBgHr7yoaRhxu2s7kUlJ216YZi+MFnA==
X-Received: by 2002:a05:620a:2a16:b0:93c:b5fd:f33f with SMTP id af79cd13be357-93f29d0ebc8mr897326485a.27.1792337547863;
        Sun, 18 Oct 2026 08:32:27 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-20.dlp.protect.broadcom.com. [144.49.247.20])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-93f1a1435cesm96513385a.8.2026.10.18.08.32.26
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Oct 2026 08:32:27 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-357e2bc3b1bso2345435eec.0
        for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 08:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1792337546; x=1792942346; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BkN9HRmKBgkqsLLM19jZtVX1xpsg2Nw7kLQilzGsDgE=;
        b=LZ30bb5iyO5ULt1FZg/A2y9wolX7n01xiYNPXoDmKl0pcoZk87HzT4vSIHOIIJCAiG
         FCMnLaMLqKze1D2dm92ulJxCdHSY/j8sbPP8j8cIPQ4nHHOAh0I2mVphCqenfaX9h6TU
         oTiTRu1/gybMyUsHKGaNqKbHnTXg93V9vTQIg=
X-Received: by 2002:a05:693c:41d2:10b0:35d:8c39:b314 with SMTP id 5a478bee46e88-361a3321149mr7374805eec.37.1792337545568;
        Sun, 18 Oct 2026 08:32:25 -0700 (PDT)
X-Received: by 2002:a05:693c:41d2:10b0:35d:8c39:b314 with SMTP id
 5a478bee46e88-361a3321149mr7374770eec.37.1792337544907; Sun, 18 Oct 2026
 08:32:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013200645.1346299-1-bhargava.marreddy@broadcom.com> <20261013200645.1346299-6-bhargava.marreddy@broadcom.com>
In-Reply-To: <20261013200645.1346299-6-bhargava.marreddy@broadcom.com>
From: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Date: Sun, 18 Oct 2026 21:02:10 +0530
X-Gm-Features: AclHuK_5UgFYKYuqdxa57YVtjw6IiRBUCkl3Ge06FFwAtah8hPtvgeV9oepM2Bg
Message-ID: <CANXQDtYRVg10b+kNyrNTmwXy-Dre7ZhSW_XsJK8Y1SqUR2128A@mail.gmail.com>
Subject: Re: [PATCH net-next v3 5/5] bnge: make NQ0 persistent across
 open/stop cycles
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	michael.chan@broadcom.com, pavan.chebbi@broadcom.com, 
	vsrama-krishna.nemani@broadcom.com, vikas.gupta@broadcom.com, 
	Dharmender Garg <dharmender.garg@broadcom.com>, 
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>, 
	Ramakrishna Koduri <ramakrishna.koduri@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000c0bf53065e1f1a93"

--000000000000c0bf53065e1f1a93
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

Source: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261013200645.=
1346299-1-bhargava.marreddy@broadcom.com

On Wed, Oct 14, 2026 at 1:38=E2=80=AFAM Bhargava Marreddy
<bhargava.marreddy@broadcom.com> wrote:
> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/n=
et/ethernet/broadcom/bnge/bnge_netdev.c
> index dc6cf3525034..c6649a2c5876 100644
> --- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
> @@ -1209,10 +1209,20 @@ static int bnge_init_ring_grps(struct bnge_net *b=
n)
>                 bn->grp_info[i].agg_fw_ring_id =3D INVALID_HW_RING_ID;
>                 bn->grp_info[i].nq_fw_ring_id =3D INVALID_HW_RING_ID;
>         }
> +       /* NQ0 stays allocated in FW across open/close */
> +       bn->grp_info[0].nq_fw_ring_id =3D
> +               (u16)bn->nq0->nq_ring.ring_struct.fw_ring_id;

Discovered by: gpt-6-astra, opus-5-5 =C2=B7 Ranked Medium by: gpt-6-astra

bnge_nq0_init() now allocates NQ0 in firmware and sets it as the async
event completion ring only once. After that, every open reuses the
probe-time fw_ring_id here, and bnge_nq0_resume() re-arms the cached NQ0
doorbell.

On the way back up, bnge_hwrm_if_change(bd, true) returns only rc and
does not check any response flags:

    if (up)
        req->flags =3D cpu_to_le32(FUNC_DRV_IF_CHANGE_REQ_FLAGS_UP);
    return bnge_hwrm_req_send(bd, req);

Suppose firmware resets or reclaims the function's NQ while the
interface is down. Would queue 0's completion ring then be allocated
against a stale nq_fw_ring_id? NQ0 doorbell writes would target a ring
firmware no longer owns, and async events would stop with no error.

The commit message acknowledges this ("Recreating NQ0 after a firmware
reset is not handled here"). Other probe-only firmware state would also
be stale in that case, such as the context memory from
bnge_alloc_ctx_mem() and the registration from
bnge_hwrm_func_drv_rgtr(). So the driver does not handle a firmware
reset while down today either.

Does firmware guarantee that it keeps NQ0 and the async event CR
configuration across FUNC_DRV_IF_CHANGE down/up?

> +
> +       rc =3D bnge_hwrm_set_async_event_cr(bd, nqr->ring_struct.fw_ring_=
id);
> +       if (rc) {
> +               bnge_err(bd, "Failed to set async event completion ring: =
%d\n",
> +                        rc);
> +               goto err_free_irq;
> +       }

The commit message says probe will "configure it as the async event
completion ring (a failure is only warned about, as before)". Does that
still match the code?

Here, if bnge_hwrm_set_async_event_cr() fails, the error is logged with
bnge_err() and the code jumps to err_free_irq. That tears NQ0 down and
returns rc. bnge_netdev_alloc() then treats the error as fatal:

    rc =3D bnge_nq0_init(bn);
    if (rc) {
        dev_err(bd->dev, "NQ0 init failed rc: %d\n", rc);
        goto err_free_port_stats;
    }

So register_netdev() is never called and probe fails.

Before this patch, bnge_hwrm_ring_alloc() only warned and kept going:

    if (!i) {
        rc =3D bnge_hwrm_set_async_event_cr(bd, ring->fw_ring_id);
        if (rc)
            netdev_warn(bn->netdev, "Failed to set async event
completion ring.\n");
    }

Before, a firmware rejection of this FUNC_CFG request still left a
working interface, just without async events. Now the port gets no
netdev at all.

Should this failure stay warn-only, as the commit message says? If it
is meant to be fatal at probe, could the commit message say so?

--000000000000c0bf53065e1f1a93
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
AQUAoIHHMC8GCSqGSIb3DQEJBDEiBCDySH10q1wKqLgrrroPNcuZ/T5gNEWnElujBt3hwc6+WzAY
BgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjEwMTgxNTMyMjZaMFwG
CSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYI
KoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCNdyFc
vu/kowo9LO3hh2SNf7C3I1eW/ujJPURv9Ofq/VJVoZhj0vnfDsHZnYkBw7hxioCVkWSlaxJKjgC8
CNSPnvFIf/phVXVyPxvuYYV7UtxehXGDpxHJlPJH9PXSn69wJjzMgGNykw5+4XOITpBNjAqexLvO
llkhCP9cgWLhTbIkfTSy9A/fr8PBV3haiLig1/IiaP76LMeDtaZnZ9pHMr3abZE1tO38ak2c7ek5
uCfkuoiCETbvDpl6MQh6Kv8AL0g6vBbm/TivNyfgCb5eqnZVPHkp8mV1R0rWN47uD1y7x6sgESTX
G1MfX3AbxVGle6c4UdgPrMgXe61Zbni3
--000000000000c0bf53065e1f1a93--
