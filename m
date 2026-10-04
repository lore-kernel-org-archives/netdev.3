Received: from mail-dy1-f228.google.com (mail-dy1-f228.google.com [74.125.82.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AEB453A39
	for <netdev@vger.kernel.org>; Sun,  4 Oct 2026 14:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791124278; cv=none; b=TqbiBcs6Ucg+5zi04Q8xchrVkbWXMz7f2X5Ru6VcLR4B2ErNtHLmfH39E+pUQKGfhRJytJDwwcuxO8HSHSaWeil73aScvRAkKzQlCBDDE+NKnh/Sv+8fcIH7ssFwvJXplUoxgKE6mdpOblQwPlY3i4YyuMsyqx40XIGI6BgqJnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791124278; c=relaxed/simple;
	bh=VjJECe4DutzIKd4SB52cjRGb8ySGcTVnlXDyTmDAV20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uRG/r5HqHBJPdUaWlk5FA7mtm5JJyO1rJIi3/m3dN8fAEwJ2dMnPkM1xyNwDwdBQirthYGZaDxel0mhOTaoHntH6DAB7fQG1Qg/zSZC6hGYboPeISTLfzfBx/0tLn2YAVo/P41lwzcHLZ0kEJFJ/2z12AzCrYH2H1RStbdaXRYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=YBEawOY3; arc=none smtp.client-ip=74.125.82.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YBEawOY3"
Received: by mail-dy1-f228.google.com with SMTP id 5a478bee46e88-33e6279a1d7so323955eec.1
        for <netdev@vger.kernel.org>; Sun, 04 Oct 2026 07:31:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791124275; x=1791729075;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=czfCLEtMgCgdXiNw2NI/p7zzD/6MuXkvdrb0OZ+QyC0=;
        b=FcsCN+RuNp/vd5yII2woELQTsBznLHocw3k8m8vY0vfWeFwnWV3SuuTfpXCx9LhLWq
         h6PQIdBx2LhXSh83806l4zsuwK6rSa3Ev2YZOghpU581s2kt5ofqRnOuGduEx6EZhl9k
         +VfendhLldu7YRkD7EgtF0TqX7on0Lvkb9WfFuSp+TB42wGZ8mbPpmMieBCdkXkgFYVe
         UQmOSrHN7rZijv4wwlXbEzO/Gzqc2W+7N94yDha6Vq2xkmbIvyaclPfUFfjkZFyIsXlV
         WphHi888ai9ZmpZuFPaS3nA655iYOpcffBGmuBxa5/C0P2O2T64N+EfpSciP20vdDQcI
         DPQw==
X-Forwarded-Encrypted: i=1; AKwUvBzEUdFAq9m6KMuvJDGtEdr5fYTcFIjz9nAV3cbpuLeMlp/+x4ZNxlJl/xmUsr2dvOVmGd4q0lk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ5qsafNdDq2HBoSQ6OujXFcrovtrad9ZyqbzAirN9XkuEuPJwg
	fijRUY2F06qGeAiKh+2iOaQ4/Q4nyLiyFPHnW2WlvDpVdmSOJeTmgIQc3WT07vaP401QwJo+frk
	h7oUM0I+GxqDzUVk7hhWVpaaO22HrK8bZOKRTZL2NIKubtCr9hbjNquzDkSwwCfLv+KxLPEQJLe
	QqD6imq+wi2yYX419C1NgIJrfRX/uIuQgNR5rmZG5G7BQM7A01fEx3LaSOCTV6VDOvi1z31D2Yp
	+4MiF6nkh/W/5ihww==
X-Gm-Gg: AYBFou0MbwxtsmW5jIrdI3KbgGKFn4Vrsib7wTGKP3D1o8W9ku6k6K7sAzaGYoUruls
	nZ+HGxxtO5NSFyjkge5PxVdCcXaKWcMN1/FP++OaGKxrRCw2qiqrWbuiwWIhX62isa0ESPu+KOH
	pri34JYCM6KgjXVNHHWGUUCMVHSa3PwK+dbYVmiZux4buqYgVXtUB0McUKzBUCV2jdiB9A1YPT4
	7P0UzeeTcD8gr/NToHspsg+qUtURAy59gog2fYRRe6rx1ywlKAHELr7xfE1s8yjenEcaKTeh1Ez
	Sg3LExVsCHXXy+okAAN29PzxLPCMVdxZLj2q/hpyYscGxWe3IT4UtVTjP8vNehPLul73vtcGzLw
	fJAb/RQxFCyi2XqWphvXEWOOuBsLX/WsFIOHJqeyS2wyHCt9pqsZkJIjO1Pc0R3v7OuVvIzHKy0
	jFxekpmanDWt6GOsWGlvHLUHhE9gdZDxYJ95CGDsauiR4B
X-Received: by 2002:a05:7300:80c6:b0:351:985:e716 with SMTP id 5a478bee46e88-35109953121mr12114340eec.13.1791124274213;
        Sun, 04 Oct 2026 07:31:14 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-351272d9593sm12149eec.29.2026.10.04.07.31.13
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Oct 2026 07:31:14 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-313d1015161so3096103eec.1
        for <netdev@vger.kernel.org>; Sun, 04 Oct 2026 07:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1791124272; x=1791729072; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=czfCLEtMgCgdXiNw2NI/p7zzD/6MuXkvdrb0OZ+QyC0=;
        b=YBEawOY3RjKvfXIh8r89MXcorWGNXkD7HV1w4BJhbZjyrOyeb3f+b/7emSdXYx2rdH
         f7OcVyZn1bW+bKnwEKZ6Z7tUWLicB6RBoWH1iuukbEdxpM0552bMkzsgv7diu5qfUg3z
         wU8mNkcBNp3Doul5UZ/QWp4oU7rELwlrduFNI=
X-Forwarded-Encrypted: i=1; AKwUvBwevI6tUe/wJ7rY3hMHa4on3ca4USphI34h2rThK0Da5n7x4tfBpEU4pBaVyYzzhgEYm+2d+fs=@vger.kernel.org
X-Received: by 2002:a05:693c:41cb:20b0:342:810b:9554 with SMTP id 5a478bee46e88-34f21854311mr10099469eec.32.1791124272027;
        Sun, 04 Oct 2026 07:31:12 -0700 (PDT)
X-Received: by 2002:a05:693c:41cb:20b0:342:810b:9554 with SMTP id
 5a478bee46e88-34f21854311mr10099428eec.32.1791124271336; Sun, 04 Oct 2026
 07:31:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922052904.59237-2-bhargava.marreddy@broadcom.com>
 <179026966721.2160803.3672240762098051468@kernel.org> <20260926184926.GC13925@horms.kernel.org>
In-Reply-To: <20260926184926.GC13925@horms.kernel.org>
From: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Date: Sun, 4 Oct 2026 20:00:57 +0530
X-Gm-Features: AclHuK9ovojThm6coEwtzF_5gjwZu6S5DTHHdY_M2n52MMUlvkcDOacKpPvGJNg
Message-ID: <CANXQDtYHw1j2rZkMqirXviYwReg696GUYOxOuYAHRmCqYONLow@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/6] bnge: Extract bnapi allocation and
 cleanup into helpers
To: Simon Horman <horms@kernel.org>
Cc: netdev-bot+sashiko@kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	michael.chan@broadcom.com, pavan.chebbi@broadcom.com, 
	vsrama-krishna.nemani@broadcom.com, vikas.gupta@broadcom.com, 
	dharmender.garg@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000004d914065d049ea6"

--00000000000004d914065d049ea6
Content-Type: text/plain; charset="UTF-8"

> > > diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
> > > index a4288f0258f87..c1810a3098883 100644
> > > --- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
> > > +++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
> > > @@ -825,6 +825,9 @@ static void bnge_free_tpa_info(struct bnge_net *bn)
> > >     struct bnge_dev *bd = bn->bd;
> > >     int i, j;
> > >
> > > +   if (!bn->rx_ring)
> > > +           return;
> > > +
>
> The check above appears to be purely defensive.
> I do not believe it can ever be true.
> If so, please remove it.

Hi Simon,

Ack, will fix in next version.

> > > @@ -1024,6 +1030,9 @@ static void bnge_free_tx_rings(struct bnge_net *bn)
> > >     struct bnge_dev *bd = bn->bd;
> > >     int i;
> > >
> > > +   if (!bn->tx_ring)
> > > +           return;
> > > +
> >
> > [Severity: Medium]
> > Are these three new NULL checks really just preparation, or do they fix a
> > reachable NULL pointer dereference that exists today?
>
> It seems to me that the two hunks above do fix a bug,
> can could manifest under memory pressure..
> And thus should be broken out as a separate patch for net.

Agreed, will send as a separate net fix.

> > >     bn->rx_ring = kzalloc_objs(struct bnge_rx_ring_info, bd->rx_nr_rings);
> > >     if (!bn->rx_ring)
> > >             goto err_free_core;
> >
> > This is the branch that reaches bnge_free_core() with both bn->rx_ring and
> > bn->tx_ring still NULL.
>
> I will add that they way that this code relies on unwind functions,
> such as bnge_free_core(), that can unwind from both a fully and partially
> initialised state is not the preferred approach.
>
> E.g. while having bnge_free_core() fully clean up state the taredown
> patch is fine, the probe path should have a goto ladder that unwinds
> incrementally based on where initialization failed.
>
> For a bug fix, a minimal approach, that adds some conditions, is probably
> best. But perhaps there are more cases than are covered by this discussion.
>

Thanks. I found no other cases in the helpers called from bnge_free_core().
I plan to send a goto-ladder fix for bnge_alloc_core() to net.

Thanks,
Bhargava Marreddy

--00000000000004d914065d049ea6
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
AQUAoIHHMC8GCSqGSIb3DQEJBDEiBCB4p8W6b9XqC2KfA9qd/wKUxky2uV3QEqhwSCGiOZY83zAY
BgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjEwMDQxNDMxMTJaMFwG
CSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYI
KoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAz90my
I55rZbpRVMBsWR0B/dxys5O3EeuqjCB6pCYTFe+5/grWbcKXK+zrQnr/XgbB2cAZuLFWkbw/SDYX
L6JidtQDiIF80xjGtcj+l5VJBdMw1LVzeU0mtadhNOpPaQV8+TUn2bRBIjU8nJqk9x5uOcuylkTN
TLEnQIIrSsik7NCQY2lbA3nPaKJqZUEHHu6pXhcLhjRYJSNVciKLr67zU+vp3gJ2xRVB+EnsxUvU
z9TpEITPgNKnaakiSkA5Aq/RtI1zgUgFUnEIG3TQvzrFUXdYSA80eFPn4tlmPL9a/K8i9rCej5sl
D+CN7JLgYUGwOpfuO5gcdhKsdsuPjs8K
--00000000000004d914065d049ea6--
