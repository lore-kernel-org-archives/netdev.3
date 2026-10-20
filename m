Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792489460;
	b=rv7/Z+ohetGjCJ+vQtPnwfB8Y+RVhoGrB42ppK5wLrO5gVldQP15nYgOPPJgqagXiUqo
	 30DA7FJQU5f+54BAdmGU2KQwPKPRvva0Zsrq0dIGKFwGpMlGIfYJPOnDPYnkhYQOVl3c3
	 wIp2OzrLQrwSlkyGdVy48rIiynGRVqEqUKX6dGjDHLB8KAdBlHz70+OMCULoM4BcLsZvQ
	 HT4bC8F0421BXjgiZSipkfRJenpeakIUNxENpsaoFBEp+3vDaQjRiGOfMa58QERUnIiU1
	 Nx9NJbzvxV7D8qggUYbQycSHPvjJa4lzNVuEV4s/nSgEvjWsD+3lTg120xUc6k4ebXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792489460;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-DetectorID-Processed:
	 Content-Type;
	bh=eJyDh2x5ddLRnVEBh2oCJ9oBzEQ9TIItSnoDB7oFRQQ=;
	b=YUH1hvZwqSMd6gHLK9Vu+SdVgUQa5Racks+2YRfUGpa482+ls7l68nhwedB+qLVk+RXN
	 ZXiYr5MbSRwVMJgoBoVLTt7gHT5ryPKke4QdxeOaFFPo1LnEwwVVSrv2V1f5ZrbltorEo
	 TdaT1ZkJ/v1kk1URY+EdErt9nbDzIhiSrWgy89Z6pFnpUUvRG0ZTSdNrLGLb+cU5xtjbb
	 ZKaP6tb2x6Kn3IUmo+JNZDd1qs9KLb4hz86TKgSb3hykzqrO6cPi0uTP/NGEIlqHqX11j
	 7XXuza/YZiWkDYcz7j6yKLzgG++dz9TZzjqDIOkbxn2mlCc2TXRE/+sSU4ekYwixBYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=LTQOFIVW;
	arc=none smtp.remote-ip=209.85.215.225
Received: from mail-pg1-f225.google.com (mail-pg1-f225.google.com [209.85.215.225])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8237606A319
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 09:44:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8237606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=LTQOFIVW
Received: by mail-pg1-f225.google.com with SMTP id 41be03b00d2f7-cc4c02ddd62so1470448a12.0
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 02:44:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792489459; x=1793094259;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eJyDh2x5ddLRnVEBh2oCJ9oBzEQ9TIItSnoDB7oFRQQ=;
        b=T/5l9cw8jD5FdL3B/Xxo+VvP1NhCpI7X+YvwFUsDwORnPbTikOMA1wImS+PVXVuOBN
         oqR8YdwU4n6tFCUPTd+Z85ivCdxEnQ/J23yq3dve6nDBFLrg51fWsAhFg2V4eAc0noC8
         sOZn5f+ax3SQ/MDkuZPlH1lVu2AeUYrztUXC+1pmenaNWYHJVhma9MySawq8/F7sgv1A
         OTEvxhSTbnjU3Oz6fCpHEDSbAZQ3X1llEqcoW6Pr/dHihmBazRxqW72BzdMXjWStnqVb
         lwxL2mQicdAOLK3Q9zVMUeAWTOEtXoDKN0kJ3s65pPQuaJvxLHzzkB9K+vKINj0m4QQ6
         fHDw==
X-Forwarded-Encrypted: i=1; AKwUvBwEIa7eNX+XEVCM+dsrpmMwDWWPn4MqNyhKVwzVBIBIRHFpVBOsBJ8gYE3NuQYxljKdxFE9/FY=@vger.kernel.org
X-Gm-Message-State: AFq9FYI2lpxTPeH7JtrQbNZ/QoNvY3BWDIYXsYnlYScH24MmOKr/WdOh
	KkSA7BannlkZLzE7ZIcR686FB+fNEzPUjG46Vhaw1WRR/nPNpZ/x8RzuR1UDf5fLZx8rOtTPvOb
	hwOLOBqP61JjDegYQk8nyWLbCCBsQ6D2jJ42U37CYp0DRStn96x/gjm4FD2ygnC1pKzyuaCnixe
	TdMyvSf+0FEQnXBu1eqeSt+rwCJj9FzN5NQg5oVzmaV+Xp3dMwXzp77qYNCoO2LL3K8ulfcGIR0
	XzWle7ndJc=
X-Gm-Gg: AYBFou0aD7U9xz5JS8b81a/bXgcbWgmHYqxytFASsFVnYtIusyHrNX6A2MqQF5UpVqC
	7Rc1lL/0fXngHy9hXpu3RprCQXd7dJy+DmHAeh+wixNCukXPYhfkLrk5emhcO35tixNqt6eC+SO
	LYlzWMAV2aqoiP+9VPJM8/b+JYwIWcD70wjjd0Ee/mGzuTXd6JPK8QAP53cxYqLirbcWXFVuOge
	snO0tSYmjXm7QRjsJCleDM3CQNRGvbnD/MZoKuXXWJJOOx1yrZ57GFAyBmVTihYiHF+SO0b5dvW
	k55NW4UlvHnbbt/9x23FzI7/kcyoWM11RSu33+eZXpJDfLzK7WDknrCnioBTq3inLfnsZ5a2sxM
	CvwXLtnzjqB9ylzXiHdHiTjndQqVOIDIZ578xFLe3D1ip0vV00zamTubtGJo17h01v8O6RokPxE
	BI+z/4jr9/SeCZdeLG+NINapSH2c5mknr3t4hEVg==
X-Received: by 2002:a17:90b:1d05:b0:3ac:9ed8:f319 with SMTP id 98e67ed59e1d1-3acee98e7f4mr8120520a91.2.1792489458984;
        Tue, 20 Oct 2026 02:44:18 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3acd3d2b819sm2827614a91.3.2026.10.20.02.44.18
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Oct 2026 02:44:18 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c44903d6927so207989266b.3
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 02:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1792489457; x=1793094257; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eJyDh2x5ddLRnVEBh2oCJ9oBzEQ9TIItSnoDB7oFRQQ=;
        b=LTQOFIVWCVC89HrT17vs+thSMG8s9nbsEYHrd1J+7n3h/XMqUn/tEwmqm5s7WiKuSC
         0u8llPjdPaSzhQ7EaiqH9UoGCJ1YRdLCz+ySLcNdi++2pH522D2JbIXIkUWIknkBAPb0
         Y+Q0Wsq3pYGl78cmm+K6t/hd46K6HXjPKr9fc=
X-Forwarded-Encrypted: i=1; AKwUvBxKCIIS8KmD2Ev8+LL3zczYALyYnHzacimF7KfbZZhHN8u1OB5n/RAu9EmeWpe1/A0VZUj0ulY=@vger.kernel.org
X-Received: by 2002:a17:907:9341:b0:c37:8c7c:a840 with SMTP id a640c23a62f3a-c419da4929bmr759996166b.18.1792489456871;
        Tue, 20 Oct 2026 02:44:16 -0700 (PDT)
X-Received: by 2002:a17:907:9341:b0:c37:8c7c:a840 with SMTP id
 a640c23a62f3a-c419da4929bmr759994866b.18.1792489456485; Tue, 20 Oct 2026
 02:44:16 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261016064427.496944-9-michael.chan@broadcom.com> <179248113613.3135.941378516751494969@kernel.org>
In-Reply-To: <179248113613.3135.941378516751494969@kernel.org>
From: Michael Chan <michael.chan@broadcom.com>
Date: Tue, 20 Oct 2026 02:44:03 -0700
X-Gm-Features: AclHuK-zcIWc6rtKOAJoVJUIx8vizVsF3zHWWkXNT7wkxmzSwinCd6acrQBghJw
Message-ID: <CACKFLi=CTz=MnmfmjimKS1uicr3RzcfyNDu9Ggv1O0QTe6tfJQ@mail.gmail.com>
Subject: Re: [PATCH net-next v4 8/8] bnxt_en: Fix ring accounting and
 validation when rings are constrained
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch, 
	pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000005bcc12065e427939"

--0000000000005bcc12065e427939
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 12:25=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wr=
ote:

> >       /* Trim rings based upon num of vectors allocated */
> >       rc =3D bnxt_trim_rings(bp, &bp->rx_nr_rings, &bp->tx_nr_rings,
> >                            total_vecs - ulp_msix, min =3D=3D 1);
> >       if (rc)
> >               goto msix_setup_exit;
> >
> > -     tx_cp =3D bnxt_num_tx_to_cp(bp, bp->tx_nr_rings, bp->tx_nr_rings_=
xdp,
> > -                               bp->rx_nr_rings);
> > -     bp->cp_nr_rings =3D (min =3D=3D 1) ?
> > -                       max_t(int, tx_cp, bp->rx_nr_rings) :
> > -                       tx_cp + bp->rx_nr_rings;
> > +     min_tx =3D bp->tx_nr_rings_xdp ? tcs + 1 : tcs;
> > +     if (bp->tx_nr_rings < min_tx) {
> > +             netdev_err(bp->dev, "Not enough MSI-X to satisfy min. TX =
rings\n");
> > +             rc =3D -ENOMEM;
> > +             goto msix_setup_exit_restore;
> > +     }
>
> [Severity: Medium]
> Does this check also reject the driver's own "rings not reserved yet"
> state, where bp->tx_nr_rings is 0?
>
Yes, also valid.  Some VFs may not have any rings reserved at this
point.  The if statement needs to be modified to allow these VFs to
proceed.

pw-bot: cr

--0000000000005bcc12065e427939
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
MjAyMwIMZh03KTi4m/vsqWZxMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCDJaZXK
aC8IEPnCc1ZA2cBgOPHkcKVvfKtSYflZTNi0+zAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjEwMjAwOTQ0MTdaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQB45p7le2JWHqHo0rsZhu/XWoXqQcOx+dxQSgVaKTtc
5AYF6q8lM6e8gmWZFSE2V2RsFoO4IFyGbkrSZP1EX8n9gwIXvB0GNLRuN6oA2SAOi99rlZvoVL2g
UmncwO3PR35O7aDnIkDwlkTPJm/ANtWpVW5dJKKNefh/Nh4REAfDxBXyUHrGcdyTTbzR92ksTdvs
ro7i6j17/Ue7Q/00dvDjWvvI+N8u37t3tHaEELG0MGUoXgiE1VwiZU5jy11dYWKM5EiF1p/n9f8/
oPsShs8txdzr6oU2NtRs8J+1mD3OT+jNeaQEk13GrQUqIX1oUlxgqwwYFdXSgeHRgU2alPAx
--0000000000005bcc12065e427939--
