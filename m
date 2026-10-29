Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793298611;
	b=eOGh5FnOl9yZMPjV4n1PDYGo4BcUSM5m/gRykQJY9KOcFlmB8qrNcyXkl2QrBileXhE/
	 7x17yd3m1+5EAkm3xm8UAHaZ36sxyNR2m6k09E4Aurtc7HvasIRKKXAVfGU64qTL6VI/Q
	 9cFA9xXkqGP1aHuqBXXgJYN/c8RyMGqWFrYcOhaqise04Wz60ITWBvV/eRAyc7RCDmK0o
	 MeEgigfPq2qoibR3+EG1x42fNY6p+GUpKeCQGWNNo+NZLtRyoihNGThYJSGe/a8vfmohH
	 6BD0MyZbN6RmuOW8CrmVEHNjmnOciYLoM0Y/1O/X4foWx76xeukAAiThxGdg264H1wA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793298611;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-DetectorID-Processed:
	 Content-Type;
	bh=qUL7pn0+rS2qWfo+BeRwh94yOenmogJcLH3gr9yuGjE=;
	b=3f4wOS5mpeqO8DOU/2fF47NExtebvoZ/BciUI0+dy4pcmruIKOlcr4UIp8iM/G8ubW7C
	 I9SPQVqOvOpItSSy2qW1prrpMNiAH/NhzDGDkBeZTxuCZDMnUZPhopNxh/oV7JP6+r8il
	 iaPgkA4OucrCZPld4WD8iU035nifZ1NC8Sz1DnmmwemLX3/lytvYYF5zhRd5jody/DuSs
	 m/v0gR2gZIM2NoBNfrqIc3hJW4KscUcpixpKdGBx+VCG4dpHZFN60sv3bxs6sU3O9OgBb
	 a7UJcbnDTMAc7aRFFOScUZo+FYrdUULuC73qjQ1/upcqhjIb6W0fydA6IZLFRUyAPTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Pf0v8CBA;
	arc=none smtp.remote-ip=209.85.160.98
Received: from mail-oa1-f98.google.com (mail-oa1-f98.google.com [209.85.160.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B6B606A31C
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 18:30:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77B6B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Pf0v8CBA
Received: by mail-oa1-f98.google.com with SMTP id 586e51a60fabf-490d838b425so1448617fac.3
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 11:30:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793298610; x=1793903410;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qUL7pn0+rS2qWfo+BeRwh94yOenmogJcLH3gr9yuGjE=;
        b=AiWI48/WN3lEwTc1+MXpeMeaLLneIbNtW0sR4yV+/z7+592xOYTXA+FhlmQ0fcBqGp
         fJseuiotmF9363B4NVKhcTBsdAfU3PHCV0+bQ7R27qC7QmVAWH/vKksoCrx3qpIuh1BK
         3o5utsY6h53u9gZ2HWOLygnfR8kRoJsyRij33FwokVQ5iH9qoRyXTrj8+ZYtRH5iu5r3
         vkFk5n15PAJXxT8HaLPGMFoSu1lcF9CcoNnAlLFHYfuKAD2M3CDNb++X/hXDW83oMjdQ
         PV+D6C0zkU416wBmaJ0mXSRvaRGXPAuNRcLAr2i/RW1ckJMi7e9ooJm9NHX99o9u83r5
         +9HA==
X-Forwarded-Encrypted: i=1; AKwUvBxcbkNbhj7AGISMDcMxa5JKpHYibobi5D0opyozHT1GPmtp7yNxFjglG6fuevF7TjfJ7X/z6Ts=@vger.kernel.org
X-Gm-Message-State: AFq9FYJWxBVI8Vn2/KY80XWtrwQAtVS83eJYze1kTUEVF4NBe/hIF+/9
	OyQqUPyu4Mc96KJ1oGh4609+XFVdKFuCcP5GWVDUFUzJBgQIsehtdc+dWhUltPakFCuqGbUADTc
	4YKzNl5RY0YE7+xuou2W3giqRUW3USCbP4h7jnu4+Uw2e2vy6isMFfUPSL4CMV62GmB3BvP0rCQ
	zMhAYkPN++ABFpYaOLeU2warieWZor0eGWSpm9h+eOZv12CmJCtieML8wuYyf2gL327Ohf/g3fM
	yfrqVvjsOLV5BWy9A==
X-Gm-Gg: AYBFou3xjsHjalGcwlyMXbfnkfRORgAlyCgA2CrATFd9JgCTznpSt3LxXMVYxm+6JkA
	zDPS0yt7mnis2etZl8woE3oJhwjqmZBVSdoMswku4D/1nOw9I33AUplvv4OzLoE/8DSlGF4FX/r
	DNU70D2ddHCcyE+JfflEVYMffj4CDWkoGg5aX1nqfO7Iba2uC9AQenGmQwlJKEq8CkFTnRxVbMV
	yp+7NkrUH/gQ6Jx7b8K6Qmtjm9b5H0b7lQzqhL6yJlPsLVkxWjm2yH67EHyTdesRrixEzbUUsIF
	QptkO2DmCyuMpYIO1fZ9V9FKYCxYVAWQcBBvm9OliEflRWWVOb7TLStjmvlNr+TvWoqlORv6/Eb
	m5k5z4RyQP6099p68GD7zIphm/4n8ui9pbURz81B2a3v1pURGY4f/koTay2jubrLaGsLY547jGG
	BqySExun7vJ1XEi7razA1U9J6iQu6bmutWJ0NWOkiNWg==
X-Received: by 2002:a05:6870:b017:b0:4a7:41a2:c208 with SMTP id 586e51a60fabf-4a8bb8174f0mr4758307fac.8.1793298609722;
        Thu, 29 Oct 2026 11:30:09 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-4a904a0f995sm1353fac.29.2026.10.29.11.30.08
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Oct 2026 11:30:09 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48c430f0f01so1988085f8f.1
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 11:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793298607; x=1793903407; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qUL7pn0+rS2qWfo+BeRwh94yOenmogJcLH3gr9yuGjE=;
        b=Pf0v8CBAd7YQ/Rs1qtgVOzM76Ee+JaSmg/eOI9yyymrRgSA+UdEp/92lJqcX237kNm
         erO8Duqp1o5vPCjf29XNvqFx1h6ymqNf90bAMSmUl+PUk6R4Btqs3z2XZSmjpa/MGh7d
         3nxrA3JAEg907LdG94VvmPtyorqibK9ni7Qgw=
X-Forwarded-Encrypted: i=1; AKwUvBz0FWUdMg8vMk5KPC64kntY/DHDoy/Dy4XoC9MO2UCRaZaFdT0AtHMwydclWtC/9ij9SF57/Ho=@vger.kernel.org
X-Received: by 2002:a05:6000:2c03:b0:48e:3ebc:d242 with SMTP id ffacd0b85a97d-48e6e4ff743mr426818f8f.37.1793298607039;
        Thu, 29 Oct 2026 11:30:07 -0700 (PDT)
X-Received: by 2002:a05:6000:2c03:b0:48e:3ebc:d242 with SMTP id
 ffacd0b85a97d-48e6e4ff743mr426790f8f.37.1793298606574; Thu, 29 Oct 2026
 11:30:06 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027234940.1267225-1-kuba@kernel.org> <20261027234940.1267225-5-kuba@kernel.org>
 <CACKFLi=CdfiSR5ZGy2LmRV7NzNU82g5V7W=2_A9+Hct6fXj5rg@mail.gmail.com>
In-Reply-To: <CACKFLi=CdfiSR5ZGy2LmRV7NzNU82g5V7W=2_A9+Hct6fXj5rg@mail.gmail.com>
From: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Date: Thu, 29 Oct 2026 14:29:53 -0400
X-Gm-Features: AclHuK-kP8mP8w16_atom8DORl7Jc5IanSJFquxt8q8j87VYYieZSqpfcKzopKo
Message-ID: <CACDg6nV-8B1u6YrySxSD0jLbBDpwsGkCZdnGJ24PM+bwS0j7eA@mail.gmail.com>
Subject: Re: [PATCH net 4/5] eth: bnxt: free XDP frags when xdp_do_redirect() fails
To: Michael Chan <michael.chan@broadcom.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, netdev@vger.kernel.org, 
	edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch, 
	horms@kernel.org, pavan.chebbi@broadcom.com, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, eddie.wai@broadcom.com, 
	brett.creeley@amd.com, ap420073@gmail.com, joe@dama.to
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000785aed065efedebe"

--000000000000785aed065efedebe
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 1:50=E2=80=AFAM Michael Chan <michael.chan@broadcom=
.com> wrote:
>
> On Tue, Oct 27, 2026 at 4:49=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > When xdp_do_redirect() fails bnxt_rx_xdp() recycles the head page but
> > not the frags of a multi-buffer frame. Their agg ring slots have
> > already been refilled, so the pages leak, and the page pool can't be
> > destroyed until they are returned, which will never happen. Redirect
> > to an AF_XDP socket in copy mode fails this way with -ENOMEM whenever
> > the socket's fill ring runs out of buffers.
> > A socket bound without XDP_USE_SG also fails with -ENOSPC for every
> > frame that doesn't fit in a single chunk.
> >
> Note that in the opposite direction of XDP_REDIRECT to bnxt, it will
> not transmit multi-buffer packets.  Only the head buffer will be
> transmitted but the whole buffer should be freed correctly.  Andy, can
> you confirm and maybe provide some history on this?
>

I don't recall that being the case, but you may be correct.  I looked
back at the multibuffer that I added in v5.19 and I was explicit in
the changelog about adding support for XDP_TX and XDP_DROP actions.

--000000000000785aed065efedebe
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
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGozCCBIug
AwIBAgIMLAiVyur+1MRjdDgxMA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI1MDYyMDEzNDMwNVoXDTI3MDYyMTEzNDMwNVowgeYxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzETMBEGA1UEBBMKR29zcG9kYXJlazEPMA0GA1UEKhMGQW5kcmV3MRYwFAYDVQQKEw1CUk9B
RENPTSBJTkMuMScwJQYDVQQDDB5hbmRyZXcuZ29zcG9kYXJla0Bicm9hZGNvbS5jb20xLTArBgkq
hkiG9w0BCQEWHmFuZHJldy5nb3Nwb2RhcmVrQGJyb2FkY29tLmNvbTCCASIwDQYJKoZIhvcNAQEB
BQADggEPADCCAQoCggEBAOP/A/G3pTTF6D8/BCAHpxJpQjOueWirQLqbjFWJTHsh6ADFdvKs+izD
0snfZopX+ZSMfR+NKl12zoJaZy/HTGiXvyeLACXBAP5i8J+smf3H0UZo+ztl9s/CLIxDfjquoQYV
UHAKWXC5euJvZ4N4/n2E35/OV6VV3JeKQHAiSOXhljrejDS6Wk96WYaQKawDm0jYH6OoXDnR/CMn
3bcNBRgaGW5VtJUP5jpTLrsQFC25kFf6fA5/HWLsVdOwkBWic80s6HCG0ROnFWnbLPL49NGItRmc
Cndhx/wUdeIk/qDpB3NiaC0IsvVNnZLIIbEl5kBojwkZV0jD/VicntRDJ78CAwEAAaOCAeIwggHe
MA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEF
BQcwAoY6aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2Ey
MDIzLmNydDA5BggrBgEFBQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNt
aW1lY2EyMDIzMGUGA1UdIAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoD
AjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBB
BgNVHR8EOjA4MDagNKAyhjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNh
MjAyMy5jcmwwKQYDVR0RBCIwIIEeYW5kcmV3Lmdvc3BvZGFyZWtAYnJvYWRjb20uY29tMBMGA1Ud
JQQMMAoGCCsGAQUFBwMEMB8GA1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQW
BBTQMVctYYJaUBLeJgZz6cT67l9WmjANBgkqhkiG9w0BAQsFAAOCAgEARE5k774M2TzT1K6LUDrm
HBHxHxe8rQpJrB59lyOANT2BjSITyUXPC/Up9ExGhYbioibOJALdaBhATnMgqw03EJLpr7Sy/mY9
g/LlaPMSHU0vcuhuU15DAwQfJ9Liw4K9AmTo0MnPKgiSDLWT8yuphPFiXATg1x8+K1b/KEt8t3Cx
3pY6cGPUH4iJXz801q7ka38emkBlMKS4i7eWgwCSHR/9c7JvlrVYT5+wqYCbmPasbv3jNS0MfEdY
qNLhtJABTy1ePhWmAzFMlbexVyN3FeWCOtxrnnD6tFhYt9dMX2kSvti9voE1cPJfyHj7IhvHVlUc
aBR5GY5F9netDgPvbqg1YpqYZwxblN6i91QhywTGSydHpbgJAmVEEp9rKvGJirwRjORPt0wXb3b6
6BzJD4dFfmqoXVKRl6WHOOICEKWVcD0OnPRdCJEXiSW6y1xobGpElvWmB7lGIE+W9V/Efv17PdJa
/u6hPkFWZBhzmFzEWDSaWvsfJpk3Jb+8oHhOk0IERLc4VLhPNhyMOQq+aL30GjEej1lqr79p5a70
/+WaRxxlypFBMj2V0384P2ACDsYAayPdKSx5aoEJWmW2cc/xR0LxENIsNWeqUBvEjcA6Qud56l66
dGBNtVCEGdHfKttDlWel93rPRa77UmnqEt+6YNFCXnuhaSUJGOA0yxQxggJXMIICUwIBATBiMFIx
CzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxT
aWduIEdDQyBSNiBTTUlNRSBDQSAyMDIzAgwsCJXK6v7UxGN0ODEwDQYJYIZIAWUDBAIBBQCggccw
LwYJKoZIhvcNAQkEMSIEIJPyjKb0tRo6tpdfpJv0S2XHWHSgLeXvuGjMgB+E6jbFMBgGCSqGSIb3
DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MTAyOTE4MzAwN1owXAYJKoZIhvcN
AQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0D
BzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBALublhPi8xBFKMfe
40Xh+VNo6/AGQToeObtYQAQQWuu8fZ5oMykJudVp4/atIP86S5a6Re2ijNcsaxQX2/SJR3iHpdjN
jmXpN5Ngddl5qYVsM4e/M4MzFh77RqMOW0T2ljYDKY3BG2OZbGaqNVHgrI+vNvg3CBYsH1ioY4/3
SPggbq7UghXo6N+4QrMbXfQsGv8vjwIQuDW0Es8ZQ8Iv1E5d2TAmOwKp9DZoyYrADOJQZ+ROQ88E
fT1SJy9YrYBOp8QdrJ0YYZQY56FiOjEiWYPU6kb/IaQbx2hWjHipkyzc9NkSC3PVxYrX8CZ8jsCk
DjSLAJl7JbDIYxC9+7wSiVI=
--000000000000785aed065efedebe--
