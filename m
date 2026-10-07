Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9779C414DE0
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 21:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791408042; cv=none; b=Vh8Iy9CpTL/XA7cjLgB91BWIWKOAFkpLqG7Hwk1ukG7KA8UxwUzXIaeMOy9pgubP59Ig5NN2mIj5HG0FRok7gArP1wC2g3zqDsnbkICpwjrh0lkaHiafGYHUPiI8trAIGb0HNbw0YS0Uo2xa+84CBsi8KOmno45gSKYwAjtgnoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791408042; c=relaxed/simple;
	bh=bYvCqHTYT1MZXEmJmGcTNKDUcvGCDetW4U8tQz5qXvQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tOY5OzE1pJWhSlZ+RXwhTQ96VL3S756EX2iIUslIyzlaODo3cwlsq/RnAuN9uaDC9uiiSkeZxydcW1zAHsYMPtSSvsMqTw6Vg81QKHiy9TUZT1jm4vJoks8Vxv3pFj70jTSk8g0pMtnFlr7Rr1OSM0jfypd8WNOpRIRiPioAWgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hiLa9bQj; arc=none smtp.client-ip=209.85.216.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hiLa9bQj"
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-3a88d1d911dso1321004a91.3
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 14:20:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791408040; x=1792012840;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VCdOYCC8KB5qN2gg5ntHBze0GLpg1Mnz+LR1e/lNexM=;
        b=iF4YgQ0ASq/+QbHTTTLUDQ+bNTuKZ2Ujr49UOHZtqdOqxI8Ee7VzTpHDb5vzdDPMpR
         bllrdPtmPFlEXpJLaFKRLII+D4vZ75Z5cxy00tx14kCdxHIT4KBvsybHsiU53zlzJie3
         76GfSYLQZRwZSpuJnO+PlFtxs0uu55bgZqXu6qCuuo0Isy9R1OPOQlZH8mhHQLv9laTZ
         S/GvTDWB4IQSb2pYkpV5a2CLBbyxtxVZLIA3a0dN47wYThJhokVV3bUcRHXh/B58BjPk
         kaV0bsaQ0w/EXL+97nkGpZpbAVH9w+9FdhwdzzjL5pwWLSoEurwtpjlIufWwtatY1E3M
         +Oxg==
X-Forwarded-Encrypted: i=1; AKwUvBwpCZqFZ5hZcOHVS6dTlufFb7ligmW+Eu1H0Ln8tDT1+enmy2LeTJVDPfpr42c1fzRjFR2T00U=@vger.kernel.org
X-Gm-Message-State: AFq9FYLVNA9KPjeZlrrSMgEACK7JAuObJRb67pBQ3Mb6nZPiHniukjAA
	27BFBUNfQ8PJvzwHj8juOD8V12kDTdbfLw1cUDUoZEeoUqTNKEFQxVqvRRkAM3L60exPafYppZZ
	b8tExUgV09p34W08FAYFnCdX+l1PiYZQWzsuhNDV67YqXDf+k7CWxh5eoR12UD7TmaEpP4qRgyt
	/cPCyTOG7g/f56BkueT0rqLEqqzFhR9fAGoq5jVizTZaJtNCd6GpeMpCCQ0xle72UtTvpZoQvsz
	njnb58IYbg=
X-Gm-Gg: AYBFou2H+IiXEA/vyIF06+M9NJWharLu8K3bYzj4h6n+szSBRVy4YF0pnUDnSQUzA3V
	q0xX/tIdl2ybj+F+yrjGFcnu7Fsned8rXS1J7MsXEytGE7gGOHbaDu+KvRsuxSOSRuQyLVztbu7
	HziJyQR5XvkE3t1de4JM9fsVAqWy4q4T7bTVD0LgSrgVPLdASR46ZJWtJaaZGdcBTblv9DVb8pY
	rvx45PS0Ndvb8SXNjtci35TQOwg0acw02n1l+qLyyNhqvEz9gV9DKib7aGDFFCDQNRb16U4taff
	anigulqEULlrZfarHR/Pkzjhgh5WevTNo4FMC1CNHTDQl3/2qzZ7RWvMUohQk5fOiNIal2h7fQN
	5qHjI4dZPlHfwGhk+JV1kz20Mhmc0/G6cFEayu5tLeaJPLx1B4Yrl+Q/EBrqnLYEPU14m8f9EQn
	WLWHVL/7qmQzQGqmqr8K32Q8DE2tqlxmERUMLANQ==
X-Received: by 2002:a17:90a:e7cf:b0:3a7:909d:a0a8 with SMTP id 98e67ed59e1d1-3a8a1d0b3efmr2834552a91.65.1791408039691;
        Wed, 07 Oct 2026 14:20:39 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3a9f1aa492asm337438a91.2.2026.10.07.14.20.39
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Oct 2026 14:20:39 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c29466736e3so466777766b.2
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 14:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1791408038; x=1792012838; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VCdOYCC8KB5qN2gg5ntHBze0GLpg1Mnz+LR1e/lNexM=;
        b=hiLa9bQjgrrGyehvzq3l+9Kz0W8fKNk7M409jSvKS6eFvrSeRhP4zpiAP2nmcKduXI
         qIE2EuUnlC9h536GTyz0B7xvAIYxhGsnBwIg33tAJUjI8f+eeaRfKIBXcmdQbLV9uLv/
         2zx5lbagzMCtsbikGQrnCF01xuYKnm4isHbHc=
X-Forwarded-Encrypted: i=1; AKwUvByj5xYBCjyTBaReOAMz0h9NBykOUWJyp4uohCvIIKorlvRmKEH0nvOtGvjHy2JBduu2q6P/Gjw=@vger.kernel.org
X-Received: by 2002:a17:906:ba8f:b0:c26:1648:a072 with SMTP id a640c23a62f3a-c317c0d8ffcmr345145766b.45.1791408037831;
        Wed, 07 Oct 2026 14:20:37 -0700 (PDT)
X-Received: by 2002:a17:906:ba8f:b0:c26:1648:a072 with SMTP id
 a640c23a62f3a-c317c0d8ffcmr345144966b.45.1791408037476; Wed, 07 Oct 2026
 14:20:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261005204246.3822563-3-michael.chan@broadcom.com> <179140588802.434549.7437964489574338925@kernel.org>
In-Reply-To: <179140588802.434549.7437964489574338925@kernel.org>
From: Michael Chan <michael.chan@broadcom.com>
Date: Wed, 7 Oct 2026 14:20:23 -0700
X-Gm-Features: AclHuK8mUpmQA7ga8MdQ5EcPLrYLDUDH64a3-q3rPYHcLZC242zmQSJLhy0yIUs
Message-ID: <CACKFLim2zp+ON-f7Wu3N0QE-mhoqwzsEXG+Y5QmO7MdCHiDH5A@mail.gmail.com>
Subject: Re: [PATCH net v3 2/3] bnxt_en: Fix driver init in kdump kernel
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch, 
	pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com, joe@dama.to, 
	kalesh-anakkur.purayil@broadcom.com, scott.branden@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000c116c8065d46af84"

--000000000000c116c8065d46af84
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 7, 2026 at 1:44=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wrot=
e:

> > +static int bnxt_kdump_reset(struct pci_dev *pdev)
> > +{
> > +     int rc, i;
> > +     u16 cmd;
> > +
> > +     pci_read_config_word(pdev, PCI_COMMAND, &cmd);
> > +     cmd &=3D ~(PCI_COMMAND_MASTER | PCI_COMMAND_MEMORY);
> > +     pci_write_config_word(pdev, PCI_COMMAND, cmd);
> > +
> > +     if (pci_save_state(pdev))
> > +             dev_warn(&pdev->dev, "Failed to save PCI state, PCI resto=
re may be incomplete\n");
> > +
> > +     rc =3D pcie_flr(pdev);
> > +     if (rc)
> > +             dev_warn(&pdev->dev, "pcie_flr() failed (rc: %d), trying =
to continue\n",
> > +                      rc);
> > +
> > +     /* In case device is not returning CRS, wait 5 seconds longer */
> > +     for (i =3D 0; i < 50; i++) {
> > +             pci_read_config_word(pdev, PCI_COMMAND, &cmd);
> > +             if (!PCI_POSSIBLE_ERROR(cmd))
> > +                     break;
> > +             msleep(100);
> > +     }
> > +     if (PCI_POSSIBLE_ERROR(cmd)) {
> > +             dev_err(&pdev->dev, "PCI config space inaccessible after =
FLR, aborting\n");
> > +             return -ENODEV;
> > +     }
> > +
> > +     bnxt_clear_bars(pdev);
> > +     pci_restore_state(pdev);
> > +     return 0;
>
> [Severity: Medium]
> What happens in bnxt_kdump_reset() if the function is not answering confi=
g
> reads when the kdump kernel probes it? One example is a chip reset that i=
s
> still running.
>
> The first PCI_COMMAND read at the top of the function is not checked with
> PCI_POSSIBLE_ERROR().

At this point, the kdump kernel has just re-enumerated our device and
successfully read at least the PCI vendor and device IDs.  We really
don't expect any problems at this point, so we don't check
PCI_POSSIBLE_ERROR().

On the hand, after FLR, it is prudent to check PCI_POSSIBLE_ERROR()
and that's why it is only done after calling pcie_flr().

So I am pushing back on this.  Thanks.

--000000000000c116c8065d46af84
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
MjAyMwIMZh03KTi4m/vsqWZxMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCC8thFi
BV/aWz3tsR7yCrH4ebYUuIPPmC467E8gJuyGHTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjEwMDcyMTIwMzhaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCHtAYeSZa1p/6YXMpHSQPcxffsHgu8642ZCyOWdMQ4
nwPqyQZStXPedoSEXHHImn1r+Nxj+Z0pDtbtl4omQSr19x+KtUTglgYXxguVvtPcgd3P4PXd6QZX
aiVtNQ17yibghs40OWEud+Jg2IHOMOti0u+1SmVkg/loT6htlaq8UfX7G3y+253Jj2Lu8eZO1+uQ
vEazdvnCtxM+ix++1RM0JMnhnTFNTYpcTkn7HGRVsIeoQG+hNniVCZU/BQgmeDBpE1Pr6ugYkeTC
9BCQctV+mZ866IFfCCA5FA6yiUJRjSHoBRTkoiw2uFKM9nV3tvPhUWkmWgeK16jvIJoKoLAA
--000000000000c116c8065d46af84--
