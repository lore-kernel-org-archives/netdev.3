Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792666680;
	b=LuFpLquCJm2KZEZPvgttLyWWsv1HDMwy4G8d0Iu/iwFCe9mECAXGB//H59z5RqO68SmY
	 9AZWx+J8w1P68nQMw6xGSrt8jDzXaybnuAHuUt6O0BAv29+VZ72sYIlGzm2hpE54UxZ9g
	 6jsXAPYJNzXm1ZQJts6VFM7HPDEpwqfw3DqFlKcRP2CBnBV5PiPPCTXwEv+vZGMMCsPza
	 I7ku2EZKIHwoDmsADbU/A9M/naxYoXuwn6gLbLLCl4OF4bEaM5286+mWctGiU93Sj8rY0
	 1NsyZ2fMsty6cBijCLJWB31JN29DD3JHkVAM29Afgo/UATiZQ39rrqb0II9F4fCbibg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792666680;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-DetectorID-Processed:
	 Content-Type;
	bh=6UCkFEkXTLUEfGAmMgzAmHMUTU+mZBxQ26AZCtZAhO8=;
	b=d0XnMJ4jaiIiKQWDGrlKVv314yOTu1oT6BNEyjnR7js35nQPzYhv7lKMVNmNtEpRtHbo
	 FWb33lAGlO6ybj4gKyfuNpob4a39UH75S0vcpmnRSZkBvcDW3gIjTap4aJ++26mBhLxiT
	 wtHkbya8QLtfhIb/7NdTPgDwO8WAq1l6qGPJ2bKNmGheg/3HP1GecXlpfWlNKTHOd2jq4
	 u+vnt5V+CuqxSsZB6bzzdANRbj4ekCLORf0IBRw47TDnjMsxXhHwk/7VUOJPmZ0IioZMI
	 KWcpdELBe7yN6eiRPtDc9Ba1MJb0L48qSkdiaMxZ3IT4kn5VLGBMOjj899thNLhGRZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=HjppLJrz;
	arc=none smtp.remote-ip=209.85.216.98
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DFC606A319
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 10:57:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26DFC606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=HjppLJrz
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-3a4cdc9025bso1015965a91.0
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 03:57:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792666679; x=1793271479;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6UCkFEkXTLUEfGAmMgzAmHMUTU+mZBxQ26AZCtZAhO8=;
        b=SkhNgtMbp+JeYja0KNSsy3RcMFRlusDATovoeNllxy6hbXY+18Gc0Y8sv4k3xjsjzS
         5o2RkMoJdEj62ssAA2Vl36WIdT+TEe4yAkpCha6gN6JJ87zKYnXo9GrCiuckSTS7MjXI
         975zV+c2I5QhggFqNlJawK+jCX+KllZJJvaElC8hIGJUEzzPF1GGf0cDcHwbPEobtM6T
         2GdrW7fGESeMBlA1KBEG3sgB2VVA8Uq9I9j34Zn/LI8C0HHz80RqEGrnJXBpsUlEVtin
         flWOOCBGCONGCErHYBj0dPfOJ/ViNiMXWJFjIAk8xFC7WflwcymQOafDoAo034+1uc9Z
         zdHQ==
X-Forwarded-Encrypted: i=1; AKwUvBxGmtWJFdRnI2KYP+OBdWGBxzNz8rAZB+DVpNN4aRb///pIzmNi5JrdRDXebzCBSK5tdlO1fYY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJrVEGCjXlg6pSC+P/UHmmrVZKwkOVpC8Uiih/Ko83DegdkHyDh
	+d29a9BeHOrkrzTx+whFdodXTBIoOTb697R+XS6La3GsnAfFVrm4tPbKCXugeRV8Dul8e4Lg9FL
	lKDYv86TVszVRlrF2OW8C4yYwFpXfXyvhsIAcMwbAYzccwP8lMt5LwL6lxAdU78ntVqBVXXVXB9
	H23ajbOh/QaK96J7JlVzCBe1GD7Rb5uRlsCWMbeiX7w5MOTxko+eArBZj4DQPvcG0yMypXhBO/1
	vEVmFduDmOdEQEJAaty
X-Gm-Gg: AYBFou1S8o0KfLIf3or1JcPBVdjqcMDDT0Bi7aChYzFfwqGO0ELVqWN3+SbHTza0w5j
	h8L2qsGeFLiS2qfcnqu6gnkO6k1zKPwxI19KhaG7xb84H65DGaWuVHB5ilpKyCv5QT+/4zeieVI
	cC2OW7/JPgrElpgn6nAsALKri6szGLxCVO4u+F26a7H6n30PTMguJuAQIuX+o13lq17786raLkG
	oMk35+5qgUHDj1Tzht+oqgvdtdicjqtzEICaPSjFPK7aU2JSJGISyfVE4BSzYsRZWdk7LwgAr50
	/me7FrQtPHbT20nrhDmo/8sG1kUZo/L9eDyFyYNQJxPALMEYd5D5TbBrRmdk0hm3owOTzeMUW5H
	5SPKo6iY0SxBs2CLcc0OoaI+oxdaFlqRhods7SyddcLMhZxzGVbtuQHBeXEqn8l2atljwSSM23+
	xSAshIUwW9mCkIhj98fumzTyS/fD0N2kQBlc8EqzwUdbpl
X-Received: by 2002:a17:90b:4b03:b0:3ab:be66:ddb6 with SMTP id 98e67ed59e1d1-3ad86e97e7cmr3300693a91.20.1792666679296;
        Thu, 22 Oct 2026 03:57:59 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ada4897b9dsm1861853a91.4.2026.10.22.03.57.58
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Oct 2026 03:57:59 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-91bebff9fcaso59529556d6.2
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 03:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1792666678; x=1793271478; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6UCkFEkXTLUEfGAmMgzAmHMUTU+mZBxQ26AZCtZAhO8=;
        b=HjppLJrzq2XBBE/bHS5ej6hZek747pqjRv55HhTu0uiU7k54D/HK+lWvKs9BnDLDgZ
         sArnkuzZjWdjJWh5ET5vJRJ55Z84NZaFkyCZbOh3Ylgc7FjtYfAgRcWkUYEbcj4E+RN+
         LlcQznv0N0N3AS7N8xrgutq4st53sJfvUeNy4=
X-Forwarded-Encrypted: i=1; AKwUvByvlgc136c5jZXZTtf2hyZ/t37FRbp5gEtYs7pzppwSvCwgtfxEqL/c/kZ3cUiGHkTxvVEAs1w=@vger.kernel.org
X-Received: by 2002:a05:6214:240d:b0:91b:88fe:a426 with SMTP id 6a1803df08f44-91c12d0ee58mr85783546d6.0.1792666678256;
        Thu, 22 Oct 2026 03:57:58 -0700 (PDT)
X-Received: by 2002:a05:6214:240d:b0:91b:88fe:a426 with SMTP id
 6a1803df08f44-91c12d0ee58mr85783346d6.0.1792666677848; Thu, 22 Oct 2026
 03:57:57 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261013200645.1346299-1-bhargava.marreddy@broadcom.com>
 <20261013200645.1346299-6-bhargava.marreddy@broadcom.com> <20261020133444.3395670e@kernel.org>
In-Reply-To: <20261020133444.3395670e@kernel.org>
From: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Date: Thu, 22 Oct 2026 16:27:42 +0530
X-Gm-Features: AclHuK_1ADCzYaY-bBjBi7InV9ZMeLTyQoUUQ1qHXyKyg0wNZw8xN8kzIoelU3c
Message-ID: <CANXQDtYjxskxm11cGVV4QbnTjwStwJ5ot-5Kg+P+z5L0pOL5Cw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 5/5] bnge: make NQ0 persistent across
 open/stop cycles
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, michael.chan@broadcom.com, 
	pavan.chebbi@broadcom.com, vsrama-krishna.nemani@broadcom.com, 
	vikas.gupta@broadcom.com, Dharmender Garg <dharmender.garg@broadcom.com>, 
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>, 
	Ramakrishna Koduri <ramakrishna.koduri@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000945efd065e6bbcd3"

--000000000000945efd065e6bbcd3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jakub,

Thanks for the feedback.

On Wed, Oct 21, 2026 at 2:04=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 14 Oct 2026 01:36:45 +0530 Bhargava Marreddy wrote:
> > NQ0's NAPI keeps running while the interface is down
>
> Sounds like abuse of netdev infra. Creative reuse of this sort makes it
> extremely painful to add stack-level features.

Understood. I agree NAPI shouldn't outlive the open state.

For context: NQ0 differs from the other NQs. Besides Rx/Tx, it also
handles firmware async events and HWRM completions (and MPC/PSP soon).
I kept NAPI running while down so these non-datapath events are still
serviced, independent of the netdev state.

A dedicated async-only vector would cost one MSI-X per PF/VF, taking
it away from Rx/Tx queues, which I'd like to avoid.

What I propose for v4:

1. NAPI for NQ0 is added in ndo_open and deleted in ndo_stop, like
   every other NQ.
2. NQ0's IRQ stays requested across open/stop:
   - When netdev is UP: The IRQ handler schedules NAPI, which handles
     Rx/Tx, async (including link), and HWRM events.
   - When netdev is DOWN: There is no NAPI instance. The IRQ handler
     queues a work item that handles async and HWRM events.
3. Mode switches happen only in open/stop, so only one context
   consumes NQ0 at a time:
   - open: quiesce the IRQ, flush the work item, then enable NAPI.
   - stop: disable NAPI, then allow the work item again.

That way no NAPI context exists outside open/stop, and the vector is
still shared between async events and the datapath.

Would this be acceptable, or do you see a problem with it? If you'd
prefer something different (e.g. a dedicated vector despite the cost),
I'm happy to go that way.

I'll hold off on v4 until we agree on the direction.

Thanks,
Bhargava, Marreddy

--000000000000945efd065e6bbcd3
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
AQUAoIHHMC8GCSqGSIb3DQEJBDEiBCAK33MGnEVmxKdX3ZUlRUBsoxjAIx9c39tLBrkorxvVHTAY
BgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjEwMjIxMDU3NThaMFwG
CSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYI
KoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBrCBIB
9orSKHMsdqahq+Sf4vhLDWdvuVB/2AAt6fR5P2eKOEfNjHlDIFL8XOt4SpkYVMHQJVglC/2VNHRL
wC577MNOZqXGGRNXDqLVyIYXXQLrUhb626c8BQfcgj9cqbnE7KW6zF3d7upvdXtHHQFtkOUW+y6C
IjpELSrHRbC9Ep+VlsxDUOEZMfLhtpS198+may2GJXWj5X0ToDH2MeDr8TH8QnkgNrlFbZemlrAR
jp+MIdE3s0V1JfbgzVuwXpn8GAyGe8hJRNNq6rnHamrI9ti3lkOmkedH1xWLncXyRnXLi52BJbNK
WWHzAB3GwYWnbTqs3PV4VGdgiM9EI0aN
--000000000000945efd065e6bbcd3--
