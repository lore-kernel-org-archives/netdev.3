Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AAE397338
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 18:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787252400; cv=none; b=lqGiKSpUwSD49xzfG9yfIFy8fPmTDhyphhxZ+hB5SqQ9VD9jEqP8zDw8BMVN6Lisdsiu+Zf/rwEn1AbtiVS4ZQBjn7H/1g4N9siTtonBaUaEBtZm32+MTWIt6iedBDEC9yX8dBmADb1XlARaWdeKpIL0BqGWYlz8/yfTYtAIRpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787252400; c=relaxed/simple;
	bh=egOgpKc1Xl7Mmrj2Mr1CLgz9ImXUSqh4HLfRg5oz2/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gmb8F4r8bWWizE46OgBHTZ4QNZ+SwMG7YdePqw1XYfKWbd8pFJZiZhsrKreD+F7chZu8+A3+HuYpODqh5d7a5WcWwwZnKv86dNKlslVU6hRjTPDf8lj9yzKfuncbKtQCmhUFMokiyg4T390GkTenhfHPZrHfqqGvuMJcn+Fe7q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Zbzg6PI1; arc=none smtp.client-ip=209.85.216.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Zbzg6PI1"
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso148897a91.3
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 11:59:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787252398; x=1787857198;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UK4ZY3nlAnXy2XHc8P1hUEu4txMt3HrG13VktAhXsVU=;
        b=lAiht9ATw9NsT7te+ALEIGwkVTLE0VIgUTmZROaONC++DITBc5KedRpMnJVYllGWp0
         auKkfKQM/XvpmgAmCojDJIG3IUaOtMr+1+hheQNVgxzYSHQyyExn97MoQt6ab8xTtXeB
         nyDXXjlwgjfgHhCKPYYKnlDNx9WJkGokmyx0qfmGnY7j8wjhq3NmTLLRtNLe6dsiSzCW
         vxl91+JOrsWtOtasA7MS9pWCTaGkmw2+84Vuz71LKHxdkqwSMTYs44cLfhUCXqk3a9i+
         JeKVjB1vXlBcWFerOYSQvfXz5TMaeSTnFh657v4slW3gxrRujoOFQDmUat/BUCBpbPDw
         TzUg==
X-Forwarded-Encrypted: i=1; AHgh+RrNXlaXzKBke3gtjtBauL8Oj1Oxf578nU0DRvy4PkbcFwIo087VLTJNojmuBh/BNOgiplZNGws=@vger.kernel.org
X-Gm-Message-State: AFuF++mieO84VtNxxlS2NCzqwiR4/3HMysOA8Q+rLtNVsJlz5UkWf1vf
	xJ5f/O1Eksb+PPMpGIgCPiUnc0RgOk9QSZ+XxUpAuPYN+mvTfMn2RpQE2e+ZW8keBiiYhLDGypo
	hYXBdYw6iQwaJYoJParD+rizxyfC8Yeyk0Z6jIlAB4MUMKjmNTO7FEDXWVhBvmUSl9bbS1DRc4b
	VhApQIlqestwK9z+fkCrYyicbXiWERAYHSvZZNpiRkP8rnU/8d0sBNUDr5LfQ/X0sNN/JMbOIq7
	9LPggBrSMc=
X-Gm-Gg: AR+sD10AGZmvMu0qXIBZXzXqhOaf6EndEhkXHJNMz7iMQ0RgQwvEpRIQqRpoDrfiugr
	KoUzxXvpMqjzy8/GqAmeJTG34yRmqUl1qNhUt01+a1QVYGGranDA1WemtV30aM+jLgVoN2ngOcv
	2VaXlP+Tg++NXE5DfjPC9Ao3Bsf/zXs5oCYtSyXu7e+0Dc2gGP9wecAVfb98wiIuPjmYYW9zS2b
	EPoAxSv8cCfAp0V34dM034e8/54jnjWn5B8vShN7jrkGWaYJirDvhtJvKH+LQKUT/ylJgBac3su
	1CnYHdBuJ2tD6saHQJCIFCM/cIgOv4ibbqcA85LqUokc6YbzHJEGzTayVILOaccL1+8U8MBgIyr
	5l4TuRXhTWjvlVDUHCETlniJLD3ZwPEB/t2qQ05gYU6uVTtlycaxue1xeJSoGBomHy4z/hY3IMY
	k7OnbI/PtcF/LHB/QWDgrGvVhfoSccz1aztPs=
X-Received: by 2002:a17:90a:e7c2:b0:38e:4f41:83df with SMTP id 98e67ed59e1d1-395c3a959b2mr980816a91.15.1787252397897;
        Thu, 20 Aug 2026 11:59:57 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-395c469734dsm15847a91.5.2026.08.20.11.59.57
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Aug 2026 11:59:57 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-698a99b6140so206439a12.1
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 11:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1787252395; x=1787857195; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UK4ZY3nlAnXy2XHc8P1hUEu4txMt3HrG13VktAhXsVU=;
        b=Zbzg6PI1Bl2O6OyCJIMXItcLwzCuyZwIC9re/LGdWq0lpv158FeDamCrjIBvD07rI4
         /OGb5Y/c1Gjnvl4ymd/Eim2suRAJQvJS9XCRFJXdg1sqHexqwjGfT3UuCQ2i8iSvByQh
         P2vbSySWZjnYh7y9GYCwq5Nph5eRG3AdHYl8E=
X-Forwarded-Encrypted: i=1; AHgh+Rq5BtDSV6spu/nUSmhLOoMMXP8tv1aSwWuZ21g08/Qs7S8lwIKLVNjBrC2U8Gc+xLzKYD7Xk84=@vger.kernel.org
X-Received: by 2002:a05:6402:5406:b0:698:c13e:179a with SMTP id 4fb4d7f45d1cf-6a42f1bcdb3mr687289a12.10.1787252395678;
        Thu, 20 Aug 2026 11:59:55 -0700 (PDT)
X-Received: by 2002:a05:6402:5406:b0:698:c13e:179a with SMTP id
 4fb4d7f45d1cf-6a42f1bcdb3mr687265a12.10.1787252395260; Thu, 20 Aug 2026
 11:59:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818141556.64303-1-thwalsh@redhat.com> <CALs4sv1zb7OemFcKRceoO49F8yPSOdZWSkomvU=mGmReR74=BA@mail.gmail.com>
 <20260820103950.5dfa2969@kernel.org> <CAD+aA83e_HP=Z0pXpcxW5j+TUXdgP3Dx8_LGxrMjdVwtERRCtg@mail.gmail.com>
 <20260820111557.49f658a4@kernel.org> <CAD+aA82ONaO+oNuX448ruJdLJ+ySvsnNwyCLYGGyDZfOA6U6cQ@mail.gmail.com>
In-Reply-To: <CAD+aA82ONaO+oNuX448ruJdLJ+ySvsnNwyCLYGGyDZfOA6U6cQ@mail.gmail.com>
From: Michael Chan <michael.chan@broadcom.com>
Date: Thu, 20 Aug 2026 11:59:42 -0700
X-Gm-Features: AcwNN1XHqG-eVHKpQvwhNfS9I4pFdE_nrl6HfwXmd3w60Gau3cHBcN_lcHd_oq8
Message-ID: <CACKFLi=WPCW=G8nyFbZnRf2yFxrc6Qao4HnsQf3J10JG8rwQnw@mail.gmail.com>
Subject: Re: [PATCH net] bnxt_en: Gate TPH enablement behind
 BNXT_SUPPORTS_QUEUE_API check
To: Thomas Walsh <thwalsh@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Pavan Chebbi <pavan.chebbi@broadcom.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Michal Schmidt <mschmidt@redhat.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000002ed1d206597f200b"

--0000000000002ed1d206597f200b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 11:30=E2=80=AFAM Thomas Walsh <thwalsh@redhat.com> =
wrote:
>
> On Thu, Aug 20, 2026 at 2:16=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Thu, 20 Aug 2026 13:55:57 -0400 Thomas Walsh wrote:
> > > In this particular situation, the customer had very recently upgraded=
 their
> > > firmware. "RX queue restart failed: err=3D-95" messages were still ob=
served.
> >
> > Would you be able to share the NIC and the FW version?
>
> NIC is BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
> [14e4:16d7]
> FW version shared with us was 238.1.138.6 upgraded from 236.1.167.0

This NIC does not support queue management.  I think it also doesn't
support TPH, but I need to check and confirm.

--0000000000002ed1d206597f200b
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
MjAyMwIMZh03KTi4m/vsqWZxMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCDNDl+E
znQSZfmSCkEEZbU/dhMFp9qYHnC37aSKcVowCTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjA4MjAxODU5NTVaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAkei4N+zfhg/EQyXhEWkj/ZZTsd6WOvNeWtqWCq+Yv
bfVCE5ZH5S9rq7css9cRFm5in90A/SSTBoBwNmnBUYU3pNvQr1tcEPhSEw8VOgzwXc+oPVi2rwrp
OrBCXKGlLgCwNgQbBy93UMAP/21T2xmD1uzl2wGlUKpNG/zc8Aa3Puek+DFTkq1G810cKg+4P2F4
essIKZgHKVyxr6gJPVyvf4/n691IrytiHuXwbXvg1Zk5pvwR/sgqObx6IukcxeBtXkfXaT/MPX7o
x2PXVkiZmCxvLX6Zp216VVTtiK5bVkAHZ3Hks0vfO/w7+ZJ0nMkIuvrC0lzNSPx0MUz3OcFT
--0000000000002ed1d206597f200b--
