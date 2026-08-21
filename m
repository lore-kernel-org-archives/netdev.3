Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DC63B14B8
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 08:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787300386; cv=none; b=YGlxYsr0dPgE8Qs/g8lpXxtFVKH1XoN4Utf2xMFBWMts4N9ayCT43T0nnv+MerAnhFKBZIWUfiNs5Wtyg0UwDTnVxN+njn2xD30xbQZEYZIbcwP9JrLGI1Bl16XmPK6qiaAHDgx3freTHu7ObxoQqNPXbV9uMJzFlM61vB1Lf7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787300386; c=relaxed/simple;
	bh=rJf98OgAUEzgfDwyvaochi3BZbDjOoExMZpTPSUCtTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DRpP/Dgg/WxQ25RH3yXfe2U0UEOnyS/LNY8+w6YtcvmzFcLR5dhOmPTqqYOQ6nSQ91vUzSzvIlxL28r+PjZyhuoCDLQdQ3WhnX337MZXsVXd8ouLBqka54d1Mxd0U0f6Ri0NqY4ops+hoUf5x07LAN4uKjv98B/4haYqG84wts0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=BNPS84kj; arc=none smtp.client-ip=209.85.216.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BNPS84kj"
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-38511175ad3so656847a91.2
        for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 01:19:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787300384; x=1787905184;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rJf98OgAUEzgfDwyvaochi3BZbDjOoExMZpTPSUCtTU=;
        b=NoFjCJQAwEsxA4nDm+kYlwix8wmdGa7VDNR938vvG4t+l3iamTEOKiGokmy5Wu3GLz
         W8KrAdvLSsqV5vE8ioRuRX9pJBPgacj2yjaXfldb8UWqgXmdiIVxi4VIuXQYedwAFt+N
         +DkUzoOqm+M1hYQucuSAse/sCpYi0G+RKtD5DJt04ZgrKvjU3AkgzZeGHG26Yh9BEaGS
         /8ZgKMpXezk000mdnVus6j7kqDrikyOzSz7cumZvpLODI9iixNYw0jaiDf/v9CxCD0by
         M0KUILYZvNCcgDMHwQbtv6G7lwHn+gOFWS5LOF7aTx31OLr269mDu9EEknKuPc25OW5p
         8NWQ==
X-Forwarded-Encrypted: i=1; AHgh+RoIHKZQki+YBUFZ/yjSfTVxK4V/FKcYCNLr8ciUOJJoKdEdIj7bztw9qGgiNVRfI5Hzpm7Q6pk=@vger.kernel.org
X-Gm-Message-State: AFuF++nz4eh3a4hDkX+9iSl3NPZQiA1QlcF3tjfc4kVntRXbH/PrAbOY
	FFiY/3Ri6YHZPhte8npUJhqYiYgukSp6ydff4TsijE5JJONpol6VRG02CgEo563jsFzKZnHwLVy
	YKJjXFaAKKepL405ZPo7fETLuAI4WEceEXUQXp1BdVezmLChAVxcqMiUGz8oAYMb/INgJECN4X0
	gtJCb8cdl4ifHbuNewDxHR3dlhpRp9IcSPZjE1Tx1ycNBKrvBY0IxoHqSI3xf3/tiuuZPwc0QPj
	wVcZAKphdTY5BnD2fNLM1wT
X-Gm-Gg: AR+sD13k0o1XFHtEGn4NdSsnuywbCTA7tfTD2428LIBpuJcYLsFarb2DVXFKwSxWGCX
	ADjDWGHsXzu8DTS4zvVLMOtYsJCZvrOq8vmbr21psu0EEvvNC5LrCCh3OPDgz5cKE8QNb+xMxSl
	qmYvnPze1h5mT27jd4q1hG09xSDkaHQAIOgGylMDoOJ/7qz9aXaHJgjge1xuCwCmn2ljNMHH/x2
	7NdI3p9+ar5dLmidgiAL2he7VUHymYsg9EaL/r52LbUCCqqeSI5Zy5FUq7TvgE8jy9yu4HsGrMN
	59Ww46SWMIBr5M5irid50Y1mAn7V8zMhOlJN1a6SfpS4YxDa1x1Kv7vdIdKBaQx8R79bGwWachM
	cgWXWNjxWP7IrEGYGx70a4CHR3aWpsHxvHNxtP5FqKSiWCu6/ZJxpHRVqkMJ+IfsP3MxIBfZ0Wo
	UlDeQE5hhoAVvM4lvBREoXxGqOn9JHeQXaNKd64Z1i1Y0K+ajk
X-Received: by 2002:a17:90b:1c90:b0:393:19a3:4f1 with SMTP id 98e67ed59e1d1-395c351d788mr8372495a91.6.1787300383955;
        Fri, 21 Aug 2026 01:19:43 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-395c4cd5a83sm764956a91.11.2026.08.21.01.19.43
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Aug 2026 01:19:43 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8485d853b08so1202889b3a.1
        for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 01:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1787300382; x=1787905182; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rJf98OgAUEzgfDwyvaochi3BZbDjOoExMZpTPSUCtTU=;
        b=BNPS84kjDcSL6cu2SbZM+FQyUCZ6rhCii+KCinFrnvXmDTsIStOXMbYTWu91oXZnzM
         6zmSY++NbSPt8B+ynTvs/zi9z2YlB60FKzO1tknlM3g1CrIIuMtdms2yF3euUsHaZeD+
         NLpIlzRxdW0h+xXi5STWTHEfB0cpoWIDSHDLg=
X-Forwarded-Encrypted: i=1; AHgh+RrqcxcufRYORSTKM0u2YH/xjZmpYBannRtPDpM3hIhMh6Z3FwBlHDeIyV4SrKss9aHynMSdXnk=@vger.kernel.org
X-Received: by 2002:a05:6a00:14cc:b0:846:bc60:5bf7 with SMTP id d2e1a72fcca58-851f9ef273fmr7112630b3a.6.1787300382292;
        Fri, 21 Aug 2026 01:19:42 -0700 (PDT)
X-Received: by 2002:a05:6a00:14cc:b0:846:bc60:5bf7 with SMTP id
 d2e1a72fcca58-851f9ef273fmr7112576b3a.6.1787300381890; Fri, 21 Aug 2026
 01:19:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260821070512.3122442-1-edumazet@google.com>
In-Reply-To: <20260821070512.3122442-1-edumazet@google.com>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Fri, 21 Aug 2026 13:49:29 +0530
X-Gm-Features: AcwNN1U596RHx4CuHe6ROJZOj-LFeu6CdG8kOK37S_Nt9BPdTYvt_5tW4PbS384
Message-ID: <CAH-L+nMLCK=fkZ0HV65MSZOuWwYjCxADBpnYQtyqpuDwO+_s9Q@mail.gmail.com>
Subject: Re: [PATCH] RDMA/core: Fix use-after-free in ib_get_eth_speed()
To: Eric Dumazet <edumazet@google.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000069c84f06598a4c7f"

--00000000000069c84f06598a4c7f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2026 at 12:37=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> In ib_get_eth_speed(), dev_put(netdev) is called before inspecting
> rc and dereferencing netdev->name in pr_warn(). If dev_put() drops
> the final reference to netdev, netdev->name accesses freed memory.
>
> Move dev_put(netdev) after the warning block so netdev is kept
> alive while its name is read.
>
> Fixes: d41861942fc5 ("IB/core: Add generic function to extract IB speed f=
rom netdev")
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

--=20
Regards,
Kalesh AP

--00000000000069c84f06598a4c7f
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
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGtzCCBJ+g
AwIBAgIMEvVs5DNhf00RSyR0MA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI1MDYyMDEzNDI1N1oXDTI3MDYyMTEzNDI1N1owgfUxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzEYMBYGA1UEBBMPQW5ha2t1ciBQdXJheWlsMQ8wDQYDVQQqEwZLYWxlc2gxFjAUBgNVBAoT
DUJST0FEQ09NIElOQy4xLDAqBgNVBAMMI2thbGVzaC1hbmFra3VyLnB1cmF5aWxAYnJvYWRjb20u
Y29tMTIwMAYJKoZIhvcNAQkBFiNrYWxlc2gtYW5ha2t1ci5wdXJheWlsQGJyb2FkY29tLmNvbTCC
ASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAOG5Nf+oQkB79NOTXl/T/Ixz4F6jXeF0+Qnn
3JsEcyfkKD4bFwFz3ruqhN2XmFFaK0T8gjJ3ZX5J7miihNKl0Jxo5asbWsM4wCQLdq3/+QwN/xAm
+ZAt/5BgDoPqdN61YPyPs8KNAQ8zHt8iZA0InZgmNkDcHhnOJ38cszc1S0eSlOqFa4W9TiQXDRYT
NFREznPoL3aCNNbDPWAkAc+0/X1XdV1kt4D9jrei4RoDevg15euOaij9X7stUsj+IMgzCt2Fyp7+
CeElPmNQ0YOba2ws52no4x/sT5R2k3DTPisRieErWuQNhePfW2fZFFXYv7N2LMgfMi9hiLi2Q3eO
1jMCAwEAAaOCAecwggHjMA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcB
AQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQv
Z3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEFBQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2ln
bi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1UdIAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAy
ASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNv
bS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAyhjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29t
L2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwLgYDVR0RBCcwJYEja2FsZXNoLWFuYWtrdXIucHVyYXlp
bEBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYBBQUHAwQwHwYDVR0jBBgwFoAUACk2nlx6ug+v
LVAt26AjhRiwoJIwHQYDVR0OBBYEFJ/R8BNY0JEVQpirvzzFQFgflqtJMA0GCSqGSIb3DQEBCwUA
A4ICAQCLsxTSA9ERT90FGuX/UM2ZQboBpTPs7DwZPq12XIrkD58GkHWgWAYS2xL1yyvD7pEtN28N
8d4+o6IcPz7yPrfWUCCpAitaeSbu0QiZzIAZlFWNUaOXCgZmHam8Oc+Lp/+XJFrRLhNkzczcw3zT
cyViuRF/upsrQ3KY/kqimiQjR9BduvKiX/w/tMWDib1UhbVhXxuhuWMr8j8sja2/QR9fk670ViD9
amx7b5x595AulQfiDhcN0qxG4fr7L22Y/RYX8fCoBAGo0SF7IpxSukVsp6z5uZp5ggdNr2Cq88qk
if7GG/Oy1beosYD9I5S5dIRcP25oNbcJkbCb/GuvWegzGfxCCBuirb09mTSZRxaBmb1P6dANmPvh
PdqGqxfFrXagvwbO15DN46GarD9KiHa8QHyTtWghL3q+G6ZHlZUWnyS4YMacrx8Ngy0x7HR4dNdT
pqAqOOsOwDmQFBNRYomMdAaOXm6x6MFDnp51sIWVNGWK2u4le2VI6RJMzEqLzMZKL0vTW+HPqMaT
hWv2s5x6cJdLio1vP63rDxJS7vH++zMaY0Jcptrx6eAhzfcq+y/TkHJaZ4dWrtbof1yw3z5EpCvT
YDxV0XFQiCRLNKuZhkVvQ8dtmVhcpiT/mENrWKWOt0DwNEeC/3Fr1ruoyriggbnRmBQt1bC5uxfv
+CEHcDGCAlcwggJTAgEBMGIwUjELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYt
c2ExKDAmBgNVBAMTH0dsb2JhbFNpZ24gR0NDIFI2IFNNSU1FIENBIDIwMjMCDBL1bOQzYX9NEUsk
dDANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQg7Y/xcw8Dk6mtLbxSxZfwgajhq5OL
6nsiJ84Ywvw8zOQwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjYw
ODIxMDgxOTQyWjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcN
AQEBBQAEggEAJ5ae7+MK1HrJLi1pjo7IBQcE1B6k8kHzNIqR+4c5I8Juub/ouPQEvCdob6TEcvUi
fajYcQGv4C2yvQozdQz0NOsPWwc39f3FBS97162uDgBPxTyWDBu+pmMV9jy3p30KZIZQGodldTGA
X8bE3SR+BrRBvPaDZq1UaXmHdvU7n6a57AH1j6GG5oN+QThUTrY+s0E4SWn3D99Ydo9Z3Bgxt/jt
r8xdpEu8lKc+xq/UTjaL0PBP0UpdKAJD/GS6mcMmExgVVx81ppnZoWYStMdWpw1KZ+ZqoIpGgTMP
SF443hwQgktaOBQoui0D8dYt7zE5W1Psw9Fi0ymoGJvQIAR0jw==
--00000000000069c84f06598a4c7f--
