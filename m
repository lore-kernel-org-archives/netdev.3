Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793251940;
	b=QRA7E3cs8m5FXe7yOUCxBLk4W+mPFqJQRQ1u3KPTdAzLi+2efdA1qAK+093OoRGZEUxD
	 I2Zkks4WJqjBCGpXGElTJa82aeQnXc0aOZwyz1Kq3Asw2vuu9UfPbbsD0fC+MDCxrXu+5
	 hn7G/bN5jf7ARLfiLo36ieetxUO3T8gN79GfBUfqdVkimI2DcbigTmj4ScPULY8/gAUo8
	 x6Il9KGL5p+fVvE6FSmFL9TsoIP0VJ0bCZa2Y3K/c1vXdL7wc3k3N5B9rJFeY6BxmcGi1
	 weQav0u/K9WF7MmcdGNjVNGiwZ4kLsUN8QmaGoGvdlRBmCzXkXdU9y1vOM3+DVoHGaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793251940;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-DetectorID-Processed:
	 Content-Type;
	bh=vYVkR+Kknjm/5dxuHx9c239kyIB/EdS9AE0WDFhYSMo=;
	b=ZO1U5eMYHaa4ZhizMEP5Raj1HrI7MqrnWpqqRTltLuTm4pPR1BQZGFTv2oi5i6mw8pUu
	 i8ePk0f4UhyL7e2HdRlzI7OCQFbj2kPE26qZhyj9QfteO4612rkGE+qIxog3Y27kWxWeP
	 8Not+8j/1TWyN/7yf+nqec45NDJWYTfdlL58nG0vo73M4cS7A63QaXto4HbZzXCkpqfKr
	 sVcEAJmz7Sihat2u00bsgj2sCZ46SFry0EpEZmaWHCIydz0kNaHYNLAdyvCsO7enla7+y
	 iHdcKUg0oyuuaRnjYvc8u8ug/6MoVoSvI72qvMER+2Ky3mXvxQdyXUKfzZ/rt9OO1Dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=IZieETiH;
	arc=none smtp.remote-ip=209.85.216.100
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D283606A31A
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 05:32:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D283606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=IZieETiH
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-3ae6b4c669fso219939a91.0
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 22:32:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793251939; x=1793856739;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vYVkR+Kknjm/5dxuHx9c239kyIB/EdS9AE0WDFhYSMo=;
        b=wgUrRqK4Ug7qBliQs4fsc39kj3W6WxzRDtYIMl05Fq1wvXZV+0huECNMiy5A4OJhu1
         NU86992IZPiyVRWR+9Wt0+ewd8UtfISZxkI2OA85VqpJjZo93Y5vnbX4lFJYuBXiQw5W
         o5YZAWRcOB/2f+Ue0H0ijk2o7GXWHWl7OtlWipK6xg+U3GZtgKGKwNbQKiJ16WklQkAh
         IGODzv4IKB6be+osOjTdUTrsP/cUYDu0b/76snxe0CYtGNGc4l9f1p/mhgwwLRYfpRKU
         20X2uAELGPsX6NovPvRBbHkLz9M7d01uXzlzwukBN06cGlasuYgiG0EMeRS6NcVQl0ZE
         SEcw==
X-Forwarded-Encrypted: i=1; AKwUvByHd5c39hXTKeUX0L1c5p5JiLguqmlU/SqXkISzF1CX91FH4YRtWiPui9zVjOesqlsuWgMINWk=@vger.kernel.org
X-Gm-Message-State: AFq9FYIvAIH/PVyAOWnWI40K0oQSWTV5LSK/TCPNFPvEesGtfsq0SH47
	/eNpu2vnSvhlC9xL22LohQTF2HKeFdbJKQII7yG4XlzFJkjA0d3DC7Rgup556eVYRTH7ZAptxvZ
	9C/E5+LgGhUMqkv92ESkXB6xSAUVAPinwu0VVdIP0chZcfKL+7l2eEoXKPqYOJYBpDlu5qB0xC9
	LZ0s2pC8yZ9A5x18mrXDHddBWibeqmcvqD9lGKt2V5W8ZbT86qTrA81DHIbkuCGIZSvc6arCeng
	DiO51cl6XQ=
X-Gm-Gg: AYBFou0SyGbppN0n6z+DUZJ7wDYl8avIotB3yo088Xxbn9GgX9AZzELePoINkzIl8SS
	ebVnkun7ws6ED46wdUVFO1LEU4TC4jK5VWf6rlfOeB323SbXQkTnyESrr32ou/7W0I9PqYJyrx0
	zIyHOPREI24UXTMlRGag8XBpqMXshEuTQLkBp7yGnXTQRAFyrXl4CeYjWvwS8HKdvpGy3SrVR9M
	4ay2UvJQgGkKSxaeY5ci9KeLp0VaxWd/8GvCV8EH0ZsD/7oe8rtKLA7Cf5ow+MLjgntYtvgtBlq
	OHUMmU988AQt1DLmMaYpjyChzkBIfoitke7bSXP3ejrofmtvR30rKABP6czHwXSz4s4nLrX+oDV
	U7EXCjH7Dx5W9iyekILMgudFLn1Rsgzg+sWQ01epUm6zQwfr1bQ5fjI8ZQ+absPbc/0YOpH+TA8
	Iiy50nPq+xv8oyrD7XGzdteSWfew4ZrLFIS1s=
X-Received: by 2002:a17:90b:390f:b0:3ae:1593:c1b7 with SMTP id 98e67ed59e1d1-3ae6ed96440mr854761a91.42.1793251938259;
        Wed, 28 Oct 2026 22:32:18 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae6e803953sm1305025a91.4.2026.10.28.22.32.17
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Oct 2026 22:32:18 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c25edb54d22so203767466b.1
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 22:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793251936; x=1793856736; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vYVkR+Kknjm/5dxuHx9c239kyIB/EdS9AE0WDFhYSMo=;
        b=IZieETiH4QUAawHS/ICryCPomF7l7sMHv1gontBnoR0Lr0YuisT1sDGA04XZQV40Dq
         V1kGqb34fGgaUho85wqvx1J/g8qVGmxRR4VF5GJjV/7SU136JHcLMH/KOu0Vwh9hT+J1
         lUSf5i5v0k8BzOzcRVbSuSIRBeJV40lmtwssg=
X-Forwarded-Encrypted: i=1; AKwUvBy+eX2+zVi9VKCl1H4mlCWXv35g52tbZJvkAorC70kdR9vZCEm5pcR3mqVzgbutBeMdsqyKmg0=@vger.kernel.org
X-Received: by 2002:a17:906:6205:b0:c24:87e5:6491 with SMTP id a640c23a62f3a-c49bddadce7mr398518766b.2.1793251936347;
        Wed, 28 Oct 2026 22:32:16 -0700 (PDT)
X-Received: by 2002:a17:906:6205:b0:c24:87e5:6491 with SMTP id
 a640c23a62f3a-c49bddadce7mr398517666b.2.1793251935989; Wed, 28 Oct 2026
 22:32:15 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027234940.1267225-3-kuba@kernel.org> <179323156552.3134.8258354110964306785@kernel.org>
 <20261028175834.3cbddb98@kernel.org>
In-Reply-To: <20261028175834.3cbddb98@kernel.org>
From: Michael Chan <michael.chan@broadcom.com>
Date: Wed, 28 Oct 2026 22:32:03 -0700
X-Gm-Features: AclHuK-mPTPiWqQ-cReTxpOJVGZBHyevylGP1hyGlEDvNOVUlrxzOD3B_KoXa8s
Message-ID: <CACKFLikHuAJ4Dy-XyyvkCg_izD1V582MwBNX74iu350r2OBDsw@mail.gmail.com>
Subject: Re: [PATCH net 2/5] eth: bnxt: resize Rx head buffers when
 rx-copybreak changes
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev-bot+sashiko@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, 
	edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch, 
	horms@kernel.org, pavan.chebbi@broadcom.com, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, eddie.wai@broadcom.com, 
	prashant@broadcom.com, huangjw@broadcom.com, gospo@broadcom.com, 
	brett.creeley@amd.com, ap420073@gmail.com, joe@dama.to
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000ad53ff065ef4002f"

--000000000000ad53ff065ef4002f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 5:58=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 28 Oct 2026 23:52:45 +0000 netdev-bot+sashiko@kernel.org wrote:
> > - [High] The fix is incomplete.
>
> :S Maaayybeee?  I think the bot is over-focusing on the DMA warning hit
> in the commit msg. It's true that we may not cover all the corner cases
> for that DMA warning. But I deferred the DMA syncing fixes as mentioned
> in the cover letter.
>
> Here I was purely trying to fix the AFAICT obviously missing
> bnxt_set_ring_params() call after changing rx_copybreak.
>
> But if anyone disagrees we can just skip this patch when applying, and
> put it to the DMA sync series. I included it here because without it
> I couldn't test patch 5 without triggering the splat first.

No objection from me.  The head buffer sizing fix is more important
than the remaining DMA sync warning.

Reviewed-by: Michael Chan <michael.chan@broadcom.com>

--000000000000ad53ff065ef4002f
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
MjAyMwIMZh03KTi4m/vsqWZxMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCCSN6kG
MPMXXZU+k2928wIvrmItkMBynDH/oLpG5UoTYzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjEwMjkwNTMyMTZaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBBuLcm7DE6cpVShRMxp7PimaxXDWnzscyiN4TDRO7g
bEiXARthEEG6XWOBYjeJm+6yZWS8u1cU9ebiLxpRIfYsAorB3bd4o9ZZFnPwOGvagIzFrdykpQIr
gdnk/fjER+8i/Oy8ItjFi0WzeIHgqPAQ4NbFLBj9ENGq2aNt8Xk1vJqUx95bthgYBcSECpaFKQiO
y8EjDiqDDmN8nrbeMeUltOHE5rtgIsY6U9nW6slTM0aNvVB/OsR2tMKZIA16y+F2xvjscvzu+X7M
xwczh6tE6uB6cpEi5YQWYTeLak0hIBpIiuddm8h4q/w4GqG8p5LbrVdbq7DZtCvQsMRc3YLw
--000000000000ad53ff065ef4002f--
