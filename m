Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8BC4CE695
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 09:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790846805; cv=none; b=p1V89FoxqpZ6YK+Y0YJZFNT7gpiBj+8FxUrEFp3bIFD/FFBRH2alxKF3QgHOU342lL4O8CEy44+CY2pElfbfkJZqDeuPgndLB7z9LiyPeK6lMJVRNAkDOIT15HI0QxG9Pxqcjx4xxfmofRy2EGvtB0CWfIOnF535vlXy8FEIeYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790846805; c=relaxed/simple;
	bh=yBVAoq0jTSkSFQCrqkmkwO6ie87eIpuerCPQJYR1ZX0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SL1zgDNwcDJ7w4aJhzJVRfKa6ykPfDeJEAZ9Tt7bWvpLa4tj1YzkZWqhR+rx0v4KaceI1ActYe+tEBOe/mx74gchT7Mc7/bpkUGDhsxGDB+kiatQq7tqFQcA+a0Al0pvY2MPf27aUXU4JNkypdrMTxgd6FOwdSe3bhoq6QVT0+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GkagEAG9; arc=none smtp.client-ip=209.85.216.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GkagEAG9"
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-38e42560ebcso1851609a91.1
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 02:26:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790846800; x=1791451600;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fc2NS6J5eXAJjnLX4krg7aXdujCwKXSpflOw4GcNE7g=;
        b=jX33c3YaQ+Vav5LZGPvf4iwJVpKZBj9dV4rw4BmT/+IhyQfDw5LmaiVw14JbQCMrqS
         oS64T72LFmqNlklG6P969KEJbVQdFLI+lXTDhTY30yxd0an31dGZwJ9xzmScp3oPWAoL
         Jw9sCmaOAQz0+mkaDOSQlhlesXedLdstCT4OBvRMF3SQPIULRZiitaJpkuVygvkTE4Lz
         wZiyAgfX38m/pFUWSGe2PPirzJJr2bmojcGl6O3HCHs+WuSlmXz3DGqciCcMjaPyb8+k
         0i+ZxwnHUoS5gV7t7mAIcSzFIb6Coisoqj/Cs/QYseW5Um2ntpYRYSFp1DhGYP75tRhR
         brfA==
X-Forwarded-Encrypted: i=1; AKwUvBz7bZ8hfmUtc1JyV7ajF/17W25cuXqvTwAGQuBjW3KnCjURflJwxMwcMmwIV1dUwqkhOrc2yOQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKtujOonRjkdJW3Mx1pvcs3RpESEV3tauEF/GTY6tlhb2yFQWLX
	RBQy2SXMyjGxo8PooVzh2NIVTbf+KGplRnf4So0xR9r+pJe2/qfD3oBu+UCRulPg/XlCgjT5qpE
	KQqAf5j/EKeDaj4vHERV3qqHu+M3H/fF2hGoMfS42Hipo8GZCrorCH/EkBvwBz9QatqqaWW3pg+
	CkJ+2O4IyAbwD/OWrzD1xRgyEkEaK2hRj4jU9kSDZjfO0u7P5Cj+jRxxc4mJxrg5w4UP0RmFrFh
	sdkAvX/sLQ=
X-Gm-Gg: AYBFou0hB6Hqqc/bCZqNyvsiS8RZXODlp4NSnP8mupMTT/v33TwcfPgoBKHbFsLOePv
	uX/1KYt5V3zi1nPgPC1LqwoUAK1LoFIpS6+e2M/RyIY7rcvE5+tfmfpHEW97dJIyL4CTrSh8g5u
	jlG8KcDWkigolben0j0orEXrj2RvgVcYMGzPsfb2S088ymL8IIY9JpFwHYu1Kk2XwiWYMh5wyh1
	UMMcomRkwWOoL2RMQSPzvasYQHoCvSVyZaCs1cub2RkRT2i4RlhG8RmXHqgM+dOjf6GCRDBfgo2
	ud2m4ETvJcA021kgDWUUY58UzjytUS0a5uAfohpLS1KSmIz9NWH6tsbUzUdrMMCQBT5osftvygi
	fX6u2o25BIzyPP4O3I6TXjx7SglfdcdzL60VyuFpu1oz0qVEfBLVdLWhXao8LG/Wt54jwGgmyA1
	nJVc3aBKe7K8pdP/QuCQbJkkZ6jC56nLI3XGje/g==
X-Received: by 2002:a17:90b:4a84:b0:39e:6c69:f480 with SMTP id 98e67ed59e1d1-3a4f7b3deb7mr1529482a91.63.1790846799900;
        Thu, 01 Oct 2026 02:26:39 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3a4f468c49bsm1178487a91.4.2026.10.01.02.26.39
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Oct 2026 02:26:39 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8710450f731so4436520b3a.0
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 02:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1790846798; x=1791451598; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fc2NS6J5eXAJjnLX4krg7aXdujCwKXSpflOw4GcNE7g=;
        b=GkagEAG9xurlSreAtz/ZAi5Jf7mMa2bOJ51COVl7YvZxrbLiYXx5L5DrWDrk87mtHW
         JUzv/J0JOBH1166x5mU1UeTTC0jaxP6VWX5QQ3JFk2qQclEHejE1PVmJkzNf+QLS/VqO
         hZ/HybB+MJhYB/FM9cL3kBipTYZNjJDcGAkBg=
X-Forwarded-Encrypted: i=1; AKwUvBwEBdXCL78rc3yS7I1zGMM60vmcU0tDYkeW+f7Sr8nNVv6b/Fq5uacuf3qzHeFWDils1ayO3ZU=@vger.kernel.org
X-Received: by 2002:a05:6a00:1248:b0:880:5bfe:b0c2 with SMTP id d2e1a72fcca58-8874fab536bmr3380617b3a.58.1790846797956;
        Thu, 01 Oct 2026 02:26:37 -0700 (PDT)
X-Received: by 2002:a05:6a00:1248:b0:880:5bfe:b0c2 with SMTP id
 d2e1a72fcca58-8874fab536bmr3380601b3a.58.1790846797469; Thu, 01 Oct 2026
 02:26:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928041712.3467803-10-michael.chan@broadcom.com> <179081651865.434549.15031496035757252020@kernel.org>
In-Reply-To: <179081651865.434549.15031496035757252020@kernel.org>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Thu, 1 Oct 2026 14:56:25 +0530
X-Gm-Features: AclHuK9DURye5f7HDsT_QYeOLoL_jpMHjeHRYNFOk_91fNAJfABXJIpU_bGuFu4
Message-ID: <CALs4sv0C-tSa2T8mFOK5kPaB3xTDtOt4+T5M0ioK3cwDGJ0tAg@mail.gmail.com>
Subject: Re: [PATCH net v2 9/9] bnxt_en: Re-write the BARs following any type
 of PCIe errors
To: netdev-bot+sashiko@kernel.org
Cc: michael.chan@broadcom.com, davem@davemloft.net, netdev@vger.kernel.org, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, andrew.gospodarek@broadcom.com, joe@dama.to, 
	kalesh-anakkur.purayil@broadcom.com, scott.branden@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000004311e1065cc403a2"

--0000000000004311e1065cc403a2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> [Severity: High]
> Can enable_cnt still go unbalanced when bnxt_io_error_detected() took
> its abort path?

<-->

> Does the pci_is_enabled() check cover this case?
>

Agree with this. I will fix the possible imbalance in enable_cnt.

> Before this patch, the BARs were never touched on this path, because
> BNXT_STATE_PCI_CHANNEL_IO_FROZEN was only set after the abort check. Now
> the decode-off, bnxt_clear_bars() and pci_restore_state() sequence also
> runs here. bnxt_fw_reset_task() may be doing bar0 MMIO at the same time
> in POLL_FW_DOWN, RESET_FW or POLL_FW (bnxt_fw_health_readl(),
> bnxt_reset_all(), bnxt_hwrm_poll()).
>
> Could those accesses get all-ones or UR responses, and confuse the
> health status checks or raise a new AER event?
>
> The worker's pci_enable_device() might also land between clearing
> PCI_COMMAND_MEMORY and pci_restore_state(). If so, do_pci_enable_device()
> would turn memory decode back on while the BARs are zero, which is the
> case the commit message says this avoids:
>
>   "Disable memory decode and bus mastering before rewriting the BARs so
>   the device doesn't decode a half-updated address"
>
> The worker's unlocked pci_set_master() read-modify-write of PCI_COMMAND
> could also overwrite the update made here.
>
> Some of this is not new with this patch. On this path slot_reset already
> sent HWRM_FUNC_RESET, called bnxt_clear_int_mode(), and cleared
> BNXT_STATE_IN_FW_RESET even though it never acquired that bit.
>
> Would it be better to record the abort in bnxt_io_error_detected()?
> bnxt_io_slot_reset() could then return PCI_ERS_RESULT_DISCONNECT in that
> case, or serialize with or cancel bnxt_fw_reset_task(), instead of
> relying on the pci_is_enabled() check.

The FW reset handling and the PCIe errors handling paths are not
synchronized 100% even before this patch.
So I would treat these issues as pre-existing and fixing them requires
additional, lengthier changes..
I would like this to be treated as a separate issue and will try to
address thru separate series

>
> > +             dev_err(&pdev->dev,
> > +                     "Cannot re-enable PCI device after reset.\n");
> > +             pci_read_config_word(pdev, PCI_COMMAND, &cmd);
> > +             if (!PCI_POSSIBLE_ERROR(cmd)) {
> > +                     cmd &=3D ~(PCI_COMMAND_MASTER | PCI_COMMAND_MEMOR=
Y);
> > +                     pci_write_config_word(pdev, PCI_COMMAND, cmd);
> >               }
> > +             goto reset_exit;
> > +     }
> > +     pci_set_master(pdev);
>
> [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20260928041712.3467803-1-michael.chan%40broadcom.com

--0000000000004311e1065cc403a2
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
MjAyMwIMClwVCDIzIfrgd31IMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCClBu0D
sdz5yWs2cj+Wt1JfRu1CTCGorKW5ZZiEbLBv/jAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjEwMDEwOTI2MzhaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBrsMGfaazR1z/dtqc2TDQKf6Ezdlls7RMK1/AELES9
ELUNKkP6W6J0dr6coWLlYIKbVF07oOZaje2QyYi+8fSEDY8c7/T4V5wT323oKjnatczgFbeFd234
t9g43fcVwyKgjKeIcMUMfk+Io/jTY62f1KfzI0YVPe8hvq6hFVv8vkUIY0Lur8D/sL9pgxQcH+RL
i/iCS70+zG1StrurT6iLL6dOJstEM4lVoxZIHESFWwp903Lq8Sn59QtgYuTf0jIsFPhgIuxM5Q5j
qf55WPyCwu11Oez6avodcJeqVdi2IbI7CUWefr8gKCaULz3PilxKLYxByP1AtOniKNQeGN5i
--0000000000004311e1065cc403a2--
