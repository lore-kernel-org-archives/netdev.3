Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794269468;
	b=NR8gpACTp1SwPHyBqisUjbLWuwxwpdBTBSHwDfsQTVuBz7ZMMOpE8P95MweqEmQBe+iL
	 ZwXsCUMrJm1hLgjum0cBnTXbH95qnzPR8QWy95rvbM/RoUD2WQ7+Rl/F9ZeND6qQsB7Di
	 6fwKRcZn5XLwOvXNHt1giR13KBEd31L4bxzYAPdlvIN188QTcL5foEhb7UdXMhOEUeSqN
	 ty++fTvCcMknA6sHhEc6vXILwbLSt8nDKW6w5GnkVzAHQXYLy7iofp+K2Mx0TCyVJhaCk
	 9Q8U2BN636+HP2363NbyvQ/pptLUlsOR0fWg3vKStm17ozEILk4UFVnTUa9O5mlR5wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794269468;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-DetectorID-Processed:
	 Content-Type;
	bh=Djlypo47XRTCT9yliDmycKC6ST9gkhw0cw6qus46XGU=;
	b=aaDYKkKp+N0awV69drPuKVmI40tFOLHr8RVBr/X/7n5GEWSKVqPOHDaDat+27rRBJlRp
	 7RaxNeiTtZzZ6/UVkdRdxQ3pMYhdgGXV7EvErFHgXvDTxoEOzqgnsRPcaI5d/aEt4jEj7
	 wd79t41xlGN1eJjP/FABYFQjjYxl7B+TbB3rs43sJ1h981kkTE2h5hdboOnVIYDfyH5og
	 9itdyO5S0Qys1Ov7YVVV6MJ3LS7fW3EC6KQQE/PVT+ur0rneGHPYcvRl5WxVuePiDNcD0
	 g0MPjLt9QJxA8wMwUsBbd4PlkUGzm2yQfXcWo7gkUmQxjOGZuFP2poagpgmVqnUXhrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=ENM6A04o;
	arc=none smtp.remote-ip=209.85.215.227
Received: from mail-pg1-f227.google.com (mail-pg1-f227.google.com [209.85.215.227])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CEB606A32A
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 00:11:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8CEB606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=ENM6A04o
Received: by mail-pg1-f227.google.com with SMTP id 41be03b00d2f7-cc4be0e5351so645700a12.0
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 16:11:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794269467; x=1794874267;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Djlypo47XRTCT9yliDmycKC6ST9gkhw0cw6qus46XGU=;
        b=EAtSc9VbcYpyQ1G0/0Y0/MGhxI0RWQUssdmW39HbjVEpIakapK1ocWcawQwUQH0A7+
         sylsuyLWBd+efBpZvnJc8H0Eu/E3T/DPDO7NwkENl/+3ECIxFwJLPPnAjCAesMaeuGUh
         T+USnmyoyBegJucF6Y4z5sKRR4qr/U2VdjrHDGgUgVc7taou/Xn9SWNqsDDVM+ig+VfI
         /9b+vasT7o7W8pgC+4pjM5aUUDO9YHULwjU1duE/b1LlkiocOZD9Eu1tzJCeam7eVP6Z
         9UlklbQuckWRR6er6uQPZXddDSJJgHKcRVYgH+sK7TehdylY1QGaoTYINrBep3+JhYba
         cqFQ==
X-Forwarded-Encrypted: i=1; AL+hErGR5qeV6znoKHjUHfIKstk+c9d/rgYYDni3Yywa/+mh40MIWfaCOg8Dgvw4gv8ddr+zWngjj3Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z/HsyRhxbI2WM3pBLjC5IVM7bu4xLdTjHb8/FzqwaPimpZu48/T
	YbfQVSebLJrtIJDfpBGqA7cuaz8B8pl1b2SnFoQiK8rZwJvX1Ifkt4UTicf2S2Ku17hMFn7w2wM
	P0VWCiBiaC/X76czNsPaXIL0C7ZKq+7SDPxf0MRDi/w/TdcSr3Gfw89hP31AKU9B0Qz1jPNqTT/
	u6JBi0cuNOXL0DA2uOXS5wp029JRs1lzAaUV9mWYfcb4RTwSFHtalO72+Pw/xddu1ICGO9ShP4s
	0tETK/VT8KY
X-Gm-Gg: AYBFou2fXFOFYUrAy0rjlYcT4LdmA93SLyeuDFrk/IY7qhutRKctpzcM9Ib0onS7Nen
	/Z87BhRhJ6nP4QEBjg43b10gLJVFQSuyWbATeU3ulrmEFQghxEY0E+f03srHk/JVfLNiOuWndmM
	X+UspuLds1j8OYGiIWYRhp0CTZJ4R12JbbplkJhg0l0WE/0xVoHts7PNaDtKYzyIpxNoJkQ6rRR
	yK/QGvhICBp85Woe+qhqc+Xk0+UHIPbyRJZeMbkMEBQ4WuApW8Bp9FLRwARNiDAL5S3gfcNH5nT
	qzYIsZfPPzBkCzJyh5F0iHSIbQ24gcVbfmoCMrKAdmivD+MvDXrYcefQGDi9Kh+bAQdNIde5EdY
	H9mmY2AylzGh+cVqojRvfwi9S+YP5ROjO2leS9KscreXhwOE9P55M/ccBmQqyL13NW1BGk24flT
	YyT2hTvbH9IpxCj0/WU4OABmZvwtCPPAEWgfGb
X-Received: by 2002:a17:90b:50:b0:3b0:968f:fdee with SMTP id 98e67ed59e1d1-3b166ce9325mr1179231a91.55.1794269466839;
        Mon, 09 Nov 2026 16:11:06 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-22.dlp.protect.broadcom.com. [144.49.247.22])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b166f5328fsm729669a91.1.2026.11.09.16.11.06
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Nov 2026 16:11:06 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-67c2c2c4e0eso1888271d50.2
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 16:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794269465; x=1794874265; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Djlypo47XRTCT9yliDmycKC6ST9gkhw0cw6qus46XGU=;
        b=ENM6A04oMU+em1XgvzIXYS8K10SsgWn40rragmoJm2lHUJZ2yVBQSCcPa8rXFoFuXP
         kAUkHj6vLfVwju+Od5cXneHOhSLruYOCw1m4wNkiETOAmb2UzXWSdJdTS89ImWwK4OTF
         i86rUd0JLKU3tX0QCL8nKSIK0xiwJFD3WjnmQ=
X-Forwarded-Encrypted: i=1; AL+hErF/ZxrzOwrx9rFd/a2sndlHhHuE3eEInrsnokEhATz7e1i8XyO0aVOQW4EFJe+kaWnRbHjnvkU=@vger.kernel.org
X-Received: by 2002:a05:690e:14c7:b0:679:ba28:1279 with SMTP id 956f58d0204a3-67c565eca3cmr629771d50.10.1794269465519;
        Mon, 09 Nov 2026 16:11:05 -0800 (PST)
X-Received: by 2002:a05:690e:14c7:b0:679:ba28:1279 with SMTP id
 956f58d0204a3-67c565eca3cmr629758d50.10.1794269464996; Mon, 09 Nov 2026
 16:11:04 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109231739.2561930-1-kudzo51@gmail.com> <db90cf8c-191f-4576-8b19-00b1b92c47e2@broadcom.com>
 <CAM0KYu0_fH6Z0RUGCG7swSPRQNnsMfL5m3EvRscfPf2ZBXvwOQ@mail.gmail.com>
In-Reply-To: <CAM0KYu0_fH6Z0RUGCG7swSPRQNnsMfL5m3EvRscfPf2ZBXvwOQ@mail.gmail.com>
From: William Zhang <william.zhang@broadcom.com>
Date: Mon, 9 Nov 2026 16:10:52 -0800
X-Gm-Features: AclHuK9Rv4bOFUvgt0ZIg3iOSX8VRBkwgubUoZWabTpfU7gb_XdkQHv0kdkX5a8
Message-ID: <CAHi4H7GcoXkAWESE9hsbJK5frAMsX3FNya7EWdWn9yC4E02izw@mail.gmail.com>
Subject: Re: BCM4908 Ethernet and 2.5G WAN: upstreaming plan and two questions
To: Mlody12 mlody12 <kudzo51@gmail.com>, Anil Chaudhary <anil.chaudhary@broadcom.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, netdev@vger.kernel.org, 
	Jonas Gorski <jonas.gorski@gmail.com>, Doug Berger <opendmb@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>, 
	bcm-kernel-feedback-list@broadcom.com, Justin Chen <justin.chen@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000026d4a2065fe0eac4"

--00000000000026d4a2065fe0eac4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+Anil Chaudhary

On Mon, Nov 9, 2026 at 3:55=E2=80=AFPM Mlody12 mlody12 <kudzo51@gmail.com> =
wrote:
>
> Hi Florian,
>
> Thanks for the quick reply, that clears up both questions.
>
> I'll send the bcm4908_enet fixes to net as a series of seven patches,
> and the SF2 flow control thresholds as a separate fix.
>
> I'll hold off on my Clause 45 change to mdio-bcm-unimac for now. Would
> it be possible to get a preview of your patch before it's posted? I
> could test it on the AX6000 and AX11000 (BCM4908, with the BCM54991E
> on the external MDIO bus) and compare it with my implementation. If
> anything is missing, I could prepare a patch on top. We could then
> send them together in one series, if that works for you.
>
> If sharing it beforehand isn't possible, please Cc me when it's posted.
>
> For the SerDes, I'll work on a phylink_pcs implementation in bcm_sf2
> alongside the crossbar handling and send it for review.
>
> I'll also prepare a separate net-next patch to make Clause 45 PHY
> creation from an explicit Device Tree ID consistent with Clause 22.
> I'll send that first so the WAN series can build on it.
>
> Thanks again,
> Kordian Kordian Chmielewski (mlody1212)

--00000000000026d4a2065fe0eac4
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
PRi27wH/XHTDMdyL0Org+kxniXue6MSNJvcQwaLO/UQrmgTygBlVGa+Qg9ZFfS00xvuqeYH7tImO
48WiXeu9rgn5KTH0IWP1+R74KIgxJQ+65la+caZvxwC9V3ik5p/LOGA2qS4GEjGuaYF8QKhRTR4h
/QBSktqZLbzVxpjJXrqFTA2BLlYRp9hPhqNxbn46WuLufpMWhFtjUoQi/8fRRWRsMAY0o1J0f+kB
6EI8FoxPTOpvuLRonqHIWMHk5YRnDdqJ3G5Oc8zmV+UCAwEAAaOCAd4wggHaMA4GA1UdDwEB/wQE
AwIFoDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDov
L3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5Bggr
BgEFBQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUG
A1UdIAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUF
BwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDag
NKAyhjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwJQYD
VR0RBB4wHIEad2lsbGlhbS56aGFuZ0Bicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYBBQUHAwQw
HwYDVR0jBBgwFoAUACk2nlx6ug+vLVAt26AjhRiwoJIwHQYDVR0OBBYEFHjI7pbQZurVKsSRE/a9
7gUEyVCkMA0GCSqGSIb3DQEBCwUAA4ICAQCFA4fU1GnG8sY7kyUXp5tle+VeWveoWb272jPauU5R
w+udkhVXmnR0Kg7RgkCD00PLTKHNRyegXXDMArs3N9NhO3s9eSp9KjDh+h3WuQWCJH3QBHLGW0qE
fyV87wUtBIy/QsHwO4S8OlOZiXECR7V1EGIF6t3s0W+3UzgYeHL+Ttuhda+2wIVY0EbS0eNH9Vob
4YG17VTBBe7hyobXFpd9d1JGENFzIWncPUshOE0Wv7KlkrRc6aBOpL4p5xO1pHi9h9w8utyHkMoV
nefXixkn5YVHnuV/jbSF/IM4Mlqt0E+n/TRp2c0eR+1AauZKENV2syNBo4aMa0BkmikBjLSnDjt/
TYQdwHNWdV495n71idvueWwTFUhUsnudYcnh42eZENopBOYjVu2WhsffyrNz0hsuR85LriqSuBbf
drd9DMo3DgtfJ7hh4sEAhSw/x/Br86rfLBftZMU02htlnkOI9Tp1QuDsr9+MsqY6AjKeXAy67m7H
TVAZ9uyO9N20yU0p7igESOWKR1ccL1TPA1jrSHK18Y75ot5199FNWeE/UKoDKSML39iPZho9XPh/
/RlsfRFiVOPrI5Gwi4YfIfi0jjEWf310/CYEmA5jrp5gUQSdo/+FgfXLKDFiEHCf5b3B1l70r6bR
WkDCNNacYJWZtSp87i6jmw+l5xx7OkEJ9DGCAlcwggJTAgEBMGIwUjELMAkGA1UEBhMCQkUxGTAX
BgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKDAmBgNVBAMTH0dsb2JhbFNpZ24gR0NDIFI2IFNNSU1F
IENBIDIwMjMCDD2ooFIye/WiO3KgZTANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQg
PbSKZvEPSWZDZ984ASDQLZO50vDmuQor+ZHPZB9yR5swGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEH
ATAcBgkqhkiG9w0BCQUxDxcNMjYxMTEwMDAxMTA1WjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFl
AwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEATFvGX1feJ9Avg+nPBudmwpkhFOrR5fh3mQfo
7qO05BPug3sRuxvUtSMaYiwhqhHhceDRcGCXQ4y8vKVfiQHiQPvhY9lly/ia7Uu6g7o99H7IJ/mr
VVYxXLCjUIjcCw57yaF/0Tc8RRXxCixGLVspHaFH7N/NN8u7rHUtogbL/rm7lTnWfxQiYxX9xiaz
ovtz+XK0wwS//JBN/Hv8Za/IXKAef8Cbtma5eWQfhImkCUE3IDA/OLO52TCpobpd/1y9ovYaKKxX
gHvenLXJ6WUZtGnJ4gTehi/jQXGcsb5vm6ekzH1M4VhWSSrMpm215pqvFpb5F1W5/c02ga7HEnNN
ig==
--00000000000026d4a2065fe0eac4--
