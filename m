Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792488906;
	b=JbpErknZokn0RCmBsriNuJJyvrXIz4fbdBbNX0YAWkrAdO4BPkXUwzRu0KCuHhfzuXTg
	 uH14cjldB6wvIz8zcGPLCvp1boDRDn1gKzHMuOFzsl5Czwmby/B/2sMrtkjCL2iVDdBqQ
	 bHONGaeQWAntHM1SOJMB8F6SbVkjbeUHwUFPaYL/Zy1O8kORmfq8iAFleMwzG2Vhq7uDt
	 jmP0mJusj8ScIr3uPoceIS39hGIydaP3ADZi18k0WF3iqhX0RIFqDVbk6NpUxCZSfA5+q
	 5W/M5COW92zk4msPyS8nm6qrEQbZWfvs3Ff5da/kKtffxXXI2StRX4wrDp52u4K0h2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792488906;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-DetectorID-Processed:
	 Content-Type;
	bh=eXmLiq+ywx5OhxBOPpCzHzlfBLI4xJ0X80HU0VZqwSI=;
	b=uC/C3UXmgUK1Y6Pa+xhfPhFqwVzZmXigGj7aaEgw5QI/h0jcfrfFTZmDDCn07gGw5NRM
	 k67MtNU/hpo2cAfUobHHdC90c4ibF9UYeLjnhpYfQ+FkJWcOIZqF5LtL0k+tdHu12PYM0
	 xE/y21QuV/GDj1S+XAsqzma36lGDSyBFKoum9nvG5RymjaPy93PO42ekmR415rO3m6jt3
	 6CBmegHjpg4Ktmc76Vip6w282Rkpo0CYnyitfgWnKaiszI72kg0O6rtoi/xv9a+LRX6Za
	 oA1tAE68I8IwHOF407rxerqouNdYUH3d00su7VNuzqddZCYtQg0x6th/dIfBjpaohZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=g6zr0glg;
	arc=none smtp.remote-ip=209.85.215.227
Received: from mail-pg1-f227.google.com (mail-pg1-f227.google.com [209.85.215.227])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412A5606A31C
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 09:35:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 412A5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=g6zr0glg
Received: by mail-pg1-f227.google.com with SMTP id 41be03b00d2f7-ccce6d9abfeso2074445a12.1
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 02:35:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792488905; x=1793093705;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eXmLiq+ywx5OhxBOPpCzHzlfBLI4xJ0X80HU0VZqwSI=;
        b=Pt82TAWmJ4Vvb5fDknDV3mBNjkdHGx4gQNKkxwpe/jA2swzzqEGuwEHek2/WRwKfcr
         hpIlOvkp+5dg+wPhBgBbGTYnohOC9h7Lc3INlISoW8N0cQsktZw7I2sOvWAyS0CY+gWd
         yFJeRa07yLZGOJVOxttqJlPp05u1nlq0PpfF/+1/KHBKMP9zwx4HuHBVExzVziYPXV1u
         zXiX4gdITAXf2hXIP4XFWqMjj36Jjqzo067Rbm9Nr5WrIrPZsZmDNZyp3x/wldF81wgi
         odNtW3lMumSz7YAAF7Mb4HI7MKjdsFTXJ7dH971uwlMbOuBFdHimZU7QotjOc9t3uX/k
         9RFQ==
X-Forwarded-Encrypted: i=1; AKwUvBwE4/AvUYlzNbwypk6W33bat17TxxdZCEe86m2n+9JHKeZz4jeWO8rq9XxV1r9MCrq0MjfKrf4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJUAdPdO82HGT/lQgQ3BeRkVpk8UbldBJMRIg0erEcp0Z1ORygy
	BI8K+NpOH8jfPtKDJvFsS15Y6Ee4gfWua+asEgSOHRJNPEX8g6Lvh0qr51fV1YqnMe7FuEarRzK
	oIzcyhjQzN7uRygDUQqDEnpqlwDGks3htANzKOKUOJTCIfrXlIOxYGBJ5GQvoGODNKw5f49xY9C
	RDyACs68vPqQnAVQqRwlxDyc93KE0MRBGY2unBKK4kYuQ+e+8AHys6WaNPnKcgTO6eTbN+xxqIz
	xiCEIt+8dY=
X-Gm-Gg: AYBFou0Y18GwFJmz4/fDgfboCg7iBmOD+A2lVjqHnw8nUnJPu7i3kgZZtBkFYvftooo
	/+54frv7UX2BKyiIlWjN4hJYC3sRvtP0sDLbyZ1c+ibT0ZhBMIRJ6/1Z9eui6PKWsfww7hlEZcc
	S82hypVepi6LiEH4AjRIsZEtZbIO5qF5L8GVAOeqqbRhSZjwYI41e54/6udnf/w1e3bxWeOAR+i
	ucqf4g3wYjNbxx54KXeUE1fVdEm1FlDdl7jmCCZGuYiU7LBR3EAe34B/GtNEMzFJk8u8/g6hA4t
	MlmIb1QquqdCC9yuyyx/xBTvHOVW+mjVhclCZH4R6aISoIiigQ2OPIjbyXjZmNWH06Imly8pH8s
	jJ7xvLhfQrh1q//F92z2/9PWqJCqk4XgIc+M8Wu1FjtI94XBFlk3cSWUACdMa75DqWA8oBhNIek
	kAkvt+dvz4UOp2vsTgwKsIyVT66/aR4sMMRwI=
X-Received: by 2002:a17:90b:2ccb:b0:3ab:884b:65a8 with SMTP id 98e67ed59e1d1-3acef17932fmr8378368a91.26.1792488905438;
        Tue, 20 Oct 2026 02:35:05 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-20.dlp.protect.broadcom.com. [144.49.247.20])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ad5d6c8186sm1549817a91.8.2026.10.20.02.35.04
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Oct 2026 02:35:05 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c41e4057335so314533066b.2
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 02:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1792488903; x=1793093703; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eXmLiq+ywx5OhxBOPpCzHzlfBLI4xJ0X80HU0VZqwSI=;
        b=g6zr0glgATeHtnHOhdmLLne+gSp2st/RIWVzakz6cMOgajX0yq7xAju0+yf5hEkzwp
         PPM35I3H95Mry4hKruVzBr0SEx+3x5yR+QZmuou2EsZNy1QOFvR2XOooknO0Y5YXbx/V
         ChX5ACAADrXtdW8nlyYNWZqIKVZX+q+LPl5m4=
X-Forwarded-Encrypted: i=1; AKwUvBz+k4K8dRn0rA3hw7BFsHqXsQtt5MEn7KGHwnKq5/TfvcTKfzdwSEIW0sGaGcMCqbVx2xbvYRQ=@vger.kernel.org
X-Received: by 2002:a17:907:9341:b0:c41:26b8:c49d with SMTP id a640c23a62f3a-c419f9088c8mr772241866b.38.1792488903335;
        Tue, 20 Oct 2026 02:35:03 -0700 (PDT)
X-Received: by 2002:a17:907:9341:b0:c41:26b8:c49d with SMTP id
 a640c23a62f3a-c419f9088c8mr772240466b.38.1792488902854; Tue, 20 Oct 2026
 02:35:02 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261016064427.496944-2-michael.chan@broadcom.com> <179248113377.3135.17092310026954460125@kernel.org>
In-Reply-To: <179248113377.3135.17092310026954460125@kernel.org>
From: Michael Chan <michael.chan@broadcom.com>
Date: Tue, 20 Oct 2026 02:34:50 -0700
X-Gm-Features: AclHuK_UXLJWppVGyHlPsJcMDMl_fdrU-VpmoUF3M1bgTLOpn-U6A37Tl0OmfYw
Message-ID: <CACKFLikuKASF44QXqx0=mdaNN58fTbpf_Wf0OwOVWNAMHcmF6A@mail.gmail.com>
Subject: Re: [PATCH net-next v4 1/8] bnxt_en: Clear bp->total_irqs when
 disabling IRQs
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch, 
	pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000005d2eac065e425853"

--0000000000005d2eac065e425853
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 12:25=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wr=
ote:

> > @@ -17755,7 +17766,7 @@ static void bnxt_io_resume(struct pci_dev *pdev=
)
> >                       err =3D bnxt_open(netdev);
> >               } else {
> >                       err =3D bnxt_reserve_rings(bp, true);
> > -                     if (!err)
> > +                     if (!err && !bp->irq_tbl)
> >                               err =3D bnxt_init_int_mode(bp);
> >               }
> >       }
>
> [Severity: Medium]
> Can bp->irq_tbl still be NULL here while err is 0?
>
> bnxt_init_int_mode() returns success without allocating the table when
> total_vecs is 0:
>
>         total_vecs =3D bnxt_get_num_msix(bp);
>         max =3D bnxt_get_max_func_irqs(bp);
>         if (total_vecs > max)
>                 total_vecs =3D max;
>
>         if (!total_vecs)
>                 return 0;
>
> bnxt_get_max_func_irqs() is derived from max_irqs and max_nqs or
> max_cp_rings. bnxt_hwrm_func_qcaps() re-reads those values from FW at
> the start of bnxt_io_resume(), and nothing enforces a lower bound. Both
> bnxt_reserve_rings() (the irq_cleared branch) and the bnxt_init_int_mode(=
)
> call above can return 0 in this case. The same is true on legacy RM,
> where bnxt_reserve_rings() returns early.
>
> With the netdev down, err then stays 0, and bnxt_io_resume() calls
> bnxt_ulp_start(). Take a registered RDMA ULP with
> BNXT_EN_FLAG_ULP_STOPPED set and a non-zero msix_requested:
>
> bnxt_ulp_start()
>     if (edev->ulp_tbl->msix_requested)
>         bnxt_fill_msix_vecs(bp, edev->msix_entries);
>
> bnxt_fill_msix_vecs() then reads bp->irq_tbl[i].vector while bp->irq_tbl
> is NULL.
>
> This patch adds a "!err && bp->irq_tbl" guard to bnxt_ulp_irq_restart()
> for the same state. Should bnxt_ulp_start(), or this check in
> bnxt_io_resume(), get a matching bp->irq_tbl check?
>
Yes, it is valid.  bnxt_ulp_start() needs the same bp->irq_tbl check.

pw-bot: cr

--0000000000005d2eac065e425853
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
MjAyMwIMZh03KTi4m/vsqWZxMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCCxOhmj
56QShDO4SU0VcKsMb4sskSDkX+4fVtg93+fD8zAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjEwMjAwOTM1MDNaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQA6c8B+CmFeGxnCEhZhRcEBWivmP/ptOpGZuYolbxJC
zNo8KKMaUjBMbcOGr6med10aB+FlBw0mGNrN4Cu33iW/zSxH9wy9sO3LxIuwS42UfEJG5kUajIvd
EnSzPcbZxc1dBRJrIKRblE43aozPccqk6zX3786o87eO3OcDAX1DZJddJn/QiQMqEiYqQSgyUvLL
VHNBugHZRPWRmYGNl1QkE0yjPnZQMZP+mjsB9lfXVSSBPJGIfMt6autEwpV38z4yFhzAiYUWF5pN
SM9gQghtSTYEAiJ7T2rYVutappuyjmvKG7rDUxgXs3YUOo1OoGucPaQvick5u90Yaace0IQw
--0000000000005d2eac065e425853--
