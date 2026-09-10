Received: from mail-vk1-f228.google.com (mail-vk1-f228.google.com [209.85.221.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAC1248896
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 06:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789020168; cv=none; b=kb7y0LdfT8dMO5fc2KRe4SKdhD9See2T8GKyiQ09vs6OJQ+WctHnwWzclV6BUsyDgw+kDbRP4bbnz2Txx3eX2NQgLx6rSMo318nCL2W9oa9kToFtlDokKrKuJFjdLq7Q5Gkyz9ki4h/H5nKvcn4BepjBe9kgc+/657JaabUjq1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789020168; c=relaxed/simple;
	bh=0YHloE7svtZlmRGSKWFuw5alivCwihlDu9Yc0DswWQU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lHrwMxCcYkcYV6Exek6v0nRV3JDt04Ce0XAGvoLo+mW54PG86bc9tA8e7hpA2RF4KHirKPvtjXbL1AQLKUt7VyFwm/5aRjGZMQO6gciHOpaIWVeJlOl07gpgyHnLI06UPGcviOAFsXEKLHW4ZURDSbExs3BOMY/zhB/ZxvbRu7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LHdQgwpq; arc=none smtp.client-ip=209.85.221.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LHdQgwpq"
Received: by mail-vk1-f228.google.com with SMTP id 71dfb90a1353d-5c675de8e1dso3296066e0c.2
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 23:02:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789020165; x=1789624965;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YEP7J7SZ8FqO6ztLNzp7ZbvQoT2/Hai2+876ogdae5I=;
        b=rN3JjIwhzS2ynI6f2RPzGhNwv6FlhHWTzqKdwgt8sS+C1jdLmRUjtCTMAyn983SZoO
         p7hKeHQ/rAjvJC4zGYqbeNhZ69ZnmU7d2cOgNRAN3DpG7XjeDTepR1ajCyAJK8SGnKFP
         YNw2WGfE6qa2TCg+VmR3STpn7ZMBg3mq/Al4cfIl4e3COKl7JaecXmuZbAnWMKGPCIWG
         jCn2sr39clilo1ovih8l3QeksGxRNnXU9ShpyMM3kOreoYcvdeyILUX7VLpVSgaCnccI
         oT8SLEgLUAi0GE27GPVixNijgUdcJi/Mo1rzCafKyw93bqBH1+Q2m1rqahQIzUH6cRdv
         hqiw==
X-Forwarded-Encrypted: i=1; AKwUvByj4QZxaGHrQee/yyj4eiUESWl2O3kHZR1cdgUvdPPo4nbWbBYH/CBS/QBNPL1Cm4f0MWVdT7Q=@vger.kernel.org
X-Gm-Message-State: AFuF++kizKohG19GjeUkhuN2H3sf+STnWd0OWNB+fjR36VlmySE/I1WU
	lVDFbiakXUTuGlZCEoHHZQ2AsyzbLWd+omYQPkI916oVxVuHBA3OvRbsSBAa4ZRWBPMg9kQ6IBQ
	wWM4/Y55XqmWS3JIigz6i65m7WB23kxNsrggSA0GxK/gD7QUkrmnlkZY6OBWGwEpHHQaPg4LfM6
	1+9RoyjTXE8kxQB6roe+hTxtc/G/5FDsFND1tnXzqD9LjWaWED+4K0m0s3T40Vxar7B2dPjwbJ3
	Dst9H4kdjY=
X-Gm-Gg: AYBFou0VhfPZzmepZrhA6mTkEDprS0Pxqb1PuWt8R88ZIVb+qgU7cpSyPGDnVMAjOj/
	jQKGTw9RGmdtiTVds4k6AQMLXUx7lMeffaCc2r/DnA45gN2ZUjHkyy9YgDT0iGFx1P45nmrbF3h
	AwopWkjS8MmNCs3p76RUeO/smFfk/W60xx69Yy/lY5Z/aoCJZ0OLlgbAFlp3TMOaDy0RgIPtdbZ
	m/f7GWG0/hW/FzJKfDMR+3VQVSY1KorBLeFpWkW33gprqoyXUkZEJoUDaHu36fS3+Ncorr3iGgO
	hxdabAAmjwoAfsKJWjBMOa2yz4DkWyiWm2jAxmOkOAB5G6HzL2pPyg8+csubP03JkFAm4M8CJIf
	s75ssOcv1xeHwY3wOpKgZ2CwZfvSrHIg/G1SA6l+ADws82JLZ89IbT8JP7ViR+aY/CkpSKECxUE
	Wm9cQW07fkJwpaNqC+kJ5Tg3Uy0zAA0mO6
X-Received: by 2002:a05:6122:4689:b0:5bd:81fc:ebe9 with SMTP id 71dfb90a1353d-5c7ed087c0cmr21633187e0c.0.1789020165416;
        Wed, 09 Sep 2026 23:02:45 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id a1e0cc1a2514c-98099ee5672sm5499442241.1.2026.09.09.23.02.45
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Sep 2026 23:02:45 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8623e5d4279so8095570b3a.1
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 23:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1789020164; x=1789624964; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YEP7J7SZ8FqO6ztLNzp7ZbvQoT2/Hai2+876ogdae5I=;
        b=LHdQgwpqPii5c/qwyDszLUm3HdUmitfCDr51PddqKh6+Wz3OiTMewQm7plDJNlXyL3
         vU3/kjd6OnNz5mnSBm9t+HZxMcMcjGSPNyF0ONdlq82CiSVFnbKOi2I0WDF0bS/fvoQm
         OzL3CYPmSRyLLP0tsu6zwiJre5pjeuSRedCTY=
X-Forwarded-Encrypted: i=1; AKwUvBwNPuHbPeTtJQ4cP1141ihkTXMkxPlwQuzuDgPa63r51rVbiTpOGhagvyrIa4FN67YxxbVlVjA=@vger.kernel.org
X-Received: by 2002:a05:6a00:9514:b0:852:131f:b9d2 with SMTP id d2e1a72fcca58-861677b2704mr51888318b3a.2.1789020163736;
        Wed, 09 Sep 2026 23:02:43 -0700 (PDT)
X-Received: by 2002:a05:6a00:9514:b0:852:131f:b9d2 with SMTP id
 d2e1a72fcca58-861677b2704mr51888260b3a.2.1789020163118; Wed, 09 Sep 2026
 23:02:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903233255.GA4109366@visor> <20260909191751.651aa5c4@kernel.org>
 <20260910052913.GA17934@visor>
In-Reply-To: <20260910052913.GA17934@visor>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Thu, 10 Sep 2026 11:32:30 +0530
X-Gm-Features: AcwNN1XF0ugmxeGhUKoN0r1JYrF5JG2qU34AvnuTyCBTEB0a3xknHGc8mXxE7z0
Message-ID: <CALs4sv1kuJ+wLQkgrg9nHagM6X5dKkPdi5AJw=sc027JPERTXw@mail.gmail.com>
Subject: Re: [PATCH net] tg3: check NVRAM and control register if SRAM has the
 placeholder MAC address
To: Ivan Delalande <colona@arista.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Michael Chan <michael.chan@broadcom.com>, netdev@vger.kernel.org, 
	Vincent MORVAN <vinc@42.fr>, Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000067e4d1065b1ab79e"

--00000000000067e4d1065b1ab79e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 11:01=E2=80=AFAM Ivan Delalande <colona@arista.com>=
 wrote:
>
> On Wed, Sep 09, 2026 at 07:17:51PM -0700, Jakub Kicinski wrote:
> > On Thu, 3 Sep 2026 16:32:55 -0700 Ivan Delalande wrote:
> > > Some of the tg3 NICs we use (BCM57762) reset the SRAM MAC address to =
the
> > > placeholder address on link flaps, tg3_chip_reset, etc. We've typical=
ly
> > > fixed it from userspace, but since e4c00ba7274b ("tg3: replace
> > > placeholder MAC address with device property") was merged, tg3 just
> > > fails probe as we don't have a way to get it through the generic
> > > device_get_mac_address infrastructure on our systems.
> > >
> > > Since that commit effectively made the placeholder address invalid,
> > > include this check in the earlier `addr_ok` expression, so we proceed
> > > with the NVRAM and control register fallback to find a valid MAC.
> >
> > If there are so many cases with known-broken MAC addresses with tg3
> > shouldnt we do something like:
>
> I think we could work with this on our systems, though it would be best
> if the driver also checked the control register when SRAM is invalid or
> the default MAC.
>
> I was testing a slightly more extensive v2 based on Sashiko's comments
> as I agree tg3_get_device_address() is pretty awkard in its current
> version. But I don't have access to enough different tg3 NICs or
> Broadcom internal docs for a confident rewrite, so I was hoping Pavan
> and Michael could chime in on all of this (should we just check SRAM,
> NVRAM, control register, and device_get_mac_address in sequence and take
> the first valid non-placeholder address? should device_get_mac_address
> take priority over any of the other sources? should this be controlled
> or overridable through module parameters?).

IMO Jakub's suggestion fixes your issue with 0 side effects. Changing
the priority or the order is an unnecessary change in behaviour..

>
> Thanks,
>
> > --- a/drivers/net/ethernet/broadcom/tg3.c
> > +++ b/drivers/net/ethernet/broadcom/tg3.c
> > @@ -17914,12 +17914,13 @@ static int tg3_init_one(struct pci_dev *pdev,
> >         }
> >
> >         err =3D tg3_get_device_address(tp, addr);
> > -       if (err) {
> > -               dev_err(&pdev->dev,
> > -                       "Could not obtain valid ethernet address, abort=
ing\n");
> > -               goto err_out_apeunmap;
> > +       if (!err) {
> > +               eth_hw_addr_set(dev, addr);
> > +       } else {
> > +               dev_warn(&pdev->dev,
> > +                        "Could not obtain valid ethernet address, usin=
g a random address\n");
> > +               eth_hw_addr_random(dev);
> >         }
> > -       eth_hw_addr_set(dev, addr);
> >
> >         intmbx =3D MAILBOX_INTERRUPT_0 + TG3_64BIT_REG_LOW;
> >         rcvmbx =3D MAILBOX_RCVRET_CON_IDX_0 + TG3_64BIT_REG_LOW;
> >
> > ?
>
> --
> Ivan Delalande - Arista Networks

--00000000000067e4d1065b1ab79e
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
MjAyMwIMClwVCDIzIfrgd31IMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCADTQFf
0rB7tntem7lGyZySVJ8BqyDBQlBkTtyFZYiIGDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjA5MTAwNjAyNDRaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBflVp1j0uldzIdCZr+8ks5g9gEzabKCxgRaK5Pqce8
20KBxWlLcyMtBdy6cR+rmiW4k2zYFnKXjRbQUKvxbXFNWrG7PA6+Tci6mPf4nR+mBbrX2P5H7gW3
3KZLexouyrcSOXMdoH5ZHc060zVKWzzSED3cAOVcEqvkm7D9VYSEkLyHid3LNiyeEltTkYO49Tlc
2UXwgQBlG5wL6bm77USxHh3AzVk6HL4fOm3lV3ASBKdAXhVoioQA6QHtKV5yLzTUazwos7NdtCDG
waaCDxUFBRE1HBr6DF+R/F2bMvAY6nY0/aI9QJmIV4rkmEZDPJewTKVgVtBiYep3+DWgL8tO
--00000000000067e4d1065b1ab79e--
