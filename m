Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.119
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794060393;
	b=hByVhxjGBuMauh056syvz7RLhrx/KtmsFPZbW2davhLzG7XBYmf02q3Bse5VTFOC7GjO
	 eQt22NbuHt+Zd/Ks3sZV6gHkypjLfaDGStTpG9KJ4e61aDNOo0PljFIpd8oOJlCYEnzBi
	 EHx28h8eiFc1yoEYJNXpXqrTJTGvXJka0y9+XdMEL8OiT7tG5oWiP2mojv9ZC2QNqxZhV
	 6DNHj4m5YL4SwGjbq8pN6HIJaKeRaigBvFoFYcMF98PmXPacElAgKNB0gXtHpvh+WCGwu
	 pVT+U+38oMK4+dxbWx4GmvhZQ5jQZboJHAEZ3s9a+9P3exWmx2Eg+rPTEFR2vMI3veg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794060393;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type;
	bh=uHuPMmxtakQOLPdxtT12nV3cnYI7LfwJjOVqp2rwr7w=;
	b=Epp2pLnnnZCMETAzMceZAjS5hnLDTJzlcmJvIPZSN4g8HKRDdiE0p+aseB2J6WKZ6oBE
	 z/xXvSbqz5oP+5JpLNjBOP4gv0NMbFuygIpHq/WX7N5Y/xJFKfvhKuWeAyP5hLmKKGNl2
	 xcwgK7DjuXeYp89oAclFAw64zpR7ZH0N6XISSDkYtS0av05YMfJUGQNYRZ7UjRjCvnhWf
	 mTQEJwWXE872QRPThHQGdfubxg87EyYP2uIoOKmxTFDmKSrz3dB1smY+UFrvIVSZ45Axh
	 LYfFdCY2qkvgTTpnxlEdW8d5fQ8gnv9rhIFIp/NfDRmAeZ8pfSdw9NOK3lksc5csSnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=protonmail.com;
	spf=pass smtp.mailfrom=protonmail.com;
	dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=imxV8DPC;
	arc=none smtp.remote-ip=79.135.106.119
Received: from mail-106119.protonmail.ch (mail-106119.protonmail.ch [79.135.106.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F899606A333;
	Sat,  7 Nov 2026 14:06:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F899606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=imxV8DPC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1794060390; x=1794319590;
	bh=uHuPMmxtakQOLPdxtT12nV3cnYI7LfwJjOVqp2rwr7w=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=imxV8DPCU1e1+6sjVJKEJJINC+AYNGDkvSMxuusEhnuL1EposvHAORGKE1XSwW7OX
	 qM3V0F47Vj1mjAFA34cY5QAUmiDYd9QNqgwWylZfZP2s7CsTh60cMpBcuRwHxDLu5E
	 qq0ii6Q8bUNvd48M7nirHShBbetBTBeZWgFf/vMCZd5COsbgstPUU203m6aqnlCzU3
	 ZleAIT0AbblL/Q66+0jhazBIDReHj9PlZAaJULutUKRok9TarnhXImKu82zTuN+gXD
	 YlRprgEwYnplKQM+BW/09oWimYbk78fAE6i/JRIOcOguNGskf8alTXfqkT5z5/HV5s
	 dudDNvuui9tPA==
Date: Sat, 07 Nov 2026 14:06:24 +0000
To: Oliver Neukum <oliver@neukum.org>, netdev@vger.kernel.org
From: Ryan Prinz <rc4d5a@protonmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, rc4d5a@protonmail.com
Subject: [PATCH] net: usb: cdc_ncm: fix out-of-bounds read of chained NDP32 offset
Message-ID: <20261107140432.647365-1-rc4d5a@protonmail.com>
Feedback-ID: 190731814:user:proton
X-Pm-Message-ID: 7a32d0583cf51430320d0ea36759a1de7d5828ba
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------0069204657d9df8cf4194503c90bb3fa2463289ee31cd304c80a0972fb84c9ce"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------0069204657d9df8cf4194503c90bb3fa2463289ee31cd304c80a0972fb84c9ce
Content-Type: multipart/mixed;
 boundary=2a1cb552390cbfe7fd100b88c3ace6355fd4256b41310b91c8759db253cb
From: Ryan Prinz <rc4d5a@protonmail.com>
To: Oliver Neukum <oliver@neukum.org>,
	netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rc4d5a@protonmail.com
Subject: [PATCH] net: usb: cdc_ncm: fix out-of-bounds read of chained NDP32 offset
Date: Sat,  7 Nov 2026 15:04:32 +0100
Message-ID: <20261107140432.647365-1-rc4d5a@protonmail.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0

--2a1cb552390cbfe7fd100b88c3ace6355fd4256b41310b91c8759db253cb
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The NDP offset read from dwNextNdpIndex on the 32-bit NTB (NDP32)
path is not checked for a negative value before use. A
device-supplied dwNextNdpIndex in the 0xFFFFFFF0-0xFFFFFFFF range
sign-converts to a small negative int, bypassing the bounds check in
cdc_ncm_rx_verify_ndp32() via size_t wraparound, causing an
out-of-bounds read of up to 16 bytes before the skb's data buffer.

Fixes: 0fa81b304a79 ("cdc_ncm: Implement the 32-bit version of NCM Transfer Block")
Signed-off-by: Ryan Prinz <rc4d5a@protonmail.com>
---
Reproduced by calling cdc_ncm_rx_fixup() directly from a small
out-of-tree test module with a hand-crafted NTB. With memory-sanitizer
instrumentation enabled to pinpoint the vulnerability:

    BUG: KASAN: slab-out-of-bounds in cdc_ncm_rx_verify_ndp32+0x11e/0x130 [cdc_ncm]
    Read of size 2 at addr ffff88800fcd2a34 by task insmod/367
     cdc_ncm_rx_verify_ndp32+0x11e/0x130 [cdc_ncm]
     cdc_ncm_rx_fixup+0x7a3/0xed0 [cdc_ncm]

Scope/impact:
- Triggerin
g the 32-bit NTB (NDP32) path requires the host driver to
  set CDC_NCM_FLAG_PREFER_NTB32 for the device. The only driver that
  does so unconditionally is huawei_cdc_ncm.c, for Huawei mobile
  broadband hardware. Local/physical-USB-attachment or
  compromised-device-firmware attack surface, not remote.
- Reachable offset range is -1 to -16, bounded by
  sizeof(struct usb_cdc_ncm_ndp32); the subsequent dpe32 array read
  always lands back inside the legitimate buffer, so this doesn't
  escalate into a larger OOB excursion.
- No out-of-bounds write found, and the leaked bytes only feed a
  signature-match comparison. There is no path found for them to
  reach a delivered packet or the device/attacker.

Given the local-only trigger and lack of a confirmed write primitive
or crash, my read is this doesn't need security@kernel.org handling,
but happy to redirect there if you think otherwise.

AI Disclosure: An AI assistant (Claude) was used to assist with the
analysis and
 testing. I have verified the vulnerability, the fix,
and the test results myself and take responsibility for this
contribution, per Documentation/process/coding-assistants.rst.

 drivers/net/usb/cdc_ncm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/usb/cdc_ncm.c b/drivers/net/usb/cdc_ncm.c
index 19db5a668..f5c8a6070 100644
--- a/drivers/net/usb/cdc_ncm.c
+++ b/drivers/net/usb/cdc_ncm.c
@@ -1838,6 +1838,9 @@ int cdc_ncm_rx_fixup(struct usbnet *dev, struct sk_buff *skb_in)
 	else
 		ndpoffset = le32_to_cpu(ndp.ndp32->dwNextNdpIndex);
 
+	if (ndpoffset < 0)
+		goto error;
+
 	if (ndpoffset && loopcount--)
 		goto next_ndp;
 
-- 
2.51.2

--2a1cb552390cbfe7fd100b88c3ace6355fd4256b41310b91c8759db253cb
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - rc4d5a@protonmail.com
 - 0xE775BF83.asc"; name="publickey - rc4d5a@protonmail.com -
 0xE775BF83.asc"
Content-Type: application/pgp-keys; filename="publickey -
 rc4d5a@protonmail.com - 0xE775BF83.asc"; name="publickey -
 rc4d5a@protonmail.com - 0xE775BF83.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCkNvbW1lbnQ6IGh0dHBzOi8vZ29w
ZW5wZ3Aub3JnClZlcnNpb246IEdvcGVuUEdQIDIuMTAuMAoKeGpNRWFkRFpyUllKS3dZQkJBSGFS
dzhCQVFkQTFpeGV6cng0ZTBFNWJGcjV6UU8xMitlb20vdWZnUVFTS05jQwpHU1ZjUzlqTkxYSmpO
R1ExWVVCd2NtOTBiMjV0WVdsc0xtTnZiU0E4Y21NMFpEVmhRSEJ5YjNSdmJtMWhhV3d1ClkyOXRQ
c0xBRVFRVEZnb0Fnd1dDYWREWnJRTUxDUWNKRUFVYktZOW5tekdRUlJRQUFBQUFBQndBSUhOaGJI
UkEKYm05MFlYUnBiMjV6TG05d1pXNXdaM0JxY3k1dmNtY21EdVNNSm1tcTJWVDN2aFkzY0JzRDFS
YUVsZGE2dDdpTwo1S21uZXZwYXhRTVZDZ2dFRmdBQ0FRSVpBUUtiQXdJZUFSWWhCT2QxdjRPUWRH
ZGFobnFvR0FVYktZOW5tekdRCkFBQmFDUUVBdWxVaElDbmFPSU9DT1d4T3pldUNUZ0dUVGkxM1k4
WjdVL3pYaER1bmFpa0EvaUJRRVBZOEx5NisKU2RZUnZzekQwcHBsS0M0elB2WkhqRDZaMEo4U2Ir
RUh6amdFYWREWnJSSUtLd1lCQkFHWFZRRUZBUUVIUUNwbApBSFVLZXNpb25QaGlBVnBvL3dDUFdt
MnR3SGtpL0tmaUpHQVdlckIxQXdFSUI4SytCQmdXQ2dCd0JZSnAwTm10CkNSQUZHeW1QWjVzeGtF
VVVBQUFBQUFBY0FDQnpZV3gwUUc1dmRHRjBhVzl1Y3k1dmNHVnVjR2R3YW5NdWIzSm4KNlJuS0R5
WjJlV1BjOSs3NEJIR3VPM1E1VGVuWFZ6bWRrRjQ3L1lYQUxFOENtd3dXSVFUbmRiK0RrSFJuV29a
NgpxQmdGR3ltUFo1c3hrQUFBN1RzQS8zRy9hUE9NeGE2MDZxdlh2U3lUOURDNTJCa294ZmlNMk5N
SFpHK0QwSnVGCkFQMFhXbGRlbEVvTFY1bWNRbXFIVThqMVp2ZzRtT1hWL2owYytPWmRheVhUQnc9
PQo9VnZDNAotLS0tLUVORCBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0t
--2a1cb552390cbfe7fd100b88c3ace6355fd4256b41310b91c8759db253cb--

--------0069204657d9df8cf4194503c90bb3fa2463289ee31cd304c80a0972fb84c9ce
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wqsEARYIAF0FgmrvMF8JEAUbKY9nmzGQNRQAAAAAABwAEHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmdhXGWCgxzq10VV91y58/b5FiEE53W/g5B0Z1qG
eqgYBRspj2ebMZAAAO5oAQCOHUtK1WOHhLTKNRwTLk+mlWprKqCJd/M7LfES
oH7BrAEA9HcqXNoc6tzllJ3KUZjsjXwdNyaL+FikezMp1JQHjQU=
=lGeW
-----END PGP SIGNATURE-----


--------0069204657d9df8cf4194503c90bb3fa2463289ee31cd304c80a0972fb84c9ce--

