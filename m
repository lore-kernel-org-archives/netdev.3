Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974D43C1F4F;
	Thu,  1 Oct 2026 09:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790845740; cv=none; b=CjoFCHNjBiWcjbDtzL7KEeGWUz9+l6deU9pDRD8D8vI4WIDw5kZW6t5mWPPBop21SlIh1hOkBVRIRsU2X9vXf/QxN6wMt7RePxUg0H6fV1HbsXV18M4ARMYLlv6YrRq5yiFL1PVxJe4GbUfvXcKQ/WJ0bVAqHxObIM8wxpFCRNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790845740; c=relaxed/simple;
	bh=Q2+LgNyRW/3p3H1yJDJgwMqsr+qBH8S/YbAOzw6yqQc=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BBTUvldpnAYQmJ3FminDA8jfDVO3gwDIHQxfnbcVovtt29JFyW4iDMOsgirADHZnIlTxIEr2WE2yJ4rGSMvi5kLHwlmcB+STERLJTOptVa1qM1Yf2XzU0vqjAnCeRRVicx8/nvWOlBeRn6OB5JhHjpfQrCKT32pzZm+OWBY3DaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Bp4qnF+R; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Bp4qnF+R"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:To:From:Subject:Message-ID:Sender:Reply-To:Cc:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vOCWgLjEH69TSme85I+So8LHyt09JsXacj3b4l+pZPw=; b=Bp4qnF+RWvZn8e7NwS/svt3HwI
	+Pe7zyt7eeSbSOIcvRJom3l2sbc13Rs5oTAFgHVpTtaEtScJ38jSlUxtxHh/OMYt54BBZ+SA5AI5Y
	il/mZY3TLncvY1+ly9hJmVvyykgINH2IpS8JY9qsPSfxOf8P1pd/Qhb3uGyRb9j152Jr/TVJ2O7I+
	4IlnCLr5Cnj3/bpZb+t2sKhK8TvbuF92ft4jwnJ/4IWTHjf/n5huEEbNAmkz6K1KbLp+lnsCqiOzB
	SsHJGHRjsD4N6I6hsPUmFReM+swQfRKvrbVt4FatVxxwVvS3VTcKmuc6eqTiEtV2nRNYOcsDiQFI3
	05jpkYkQ==;
Received: from 54-240-197-236.amazon.com ([54.240.197.236] helo=edge-m3-r3-161.e-iad51.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCCmX-00000006PPO-2xGC;
	Thu, 01 Oct 2026 09:08:49 +0000
Message-ID: <51e42946957ba615327c2c5aca203f639872ac6f.camel@infradead.org>
Subject: Re: [PATCH v4 2/4] pps: Drop the !NO_HZ_COMMON dependency from
 NTP_PPS
From: David Woodhouse <dwmw2@infradead.org>
To: Rodolfo Giometti <giometti@enneenne.com>, Richard Cochran	
 <richardcochran@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>, John Stultz
 <jstultz@google.com>, Thomas Gleixner <tglx@kernel.org>,  Stephen Boyd
 <sboyd@kernel.org>, Miroslav Lichvar <mlichvar@redhat.com>,
 linux-kernel@vger.kernel.org, 	netdev@vger.kernel.org, Alexander Gordeev
 <agordeev@linux.ibm.com>
Date: Thu, 01 Oct 2026 10:08:49 +0100
In-Reply-To: <fbc06405-c7a0-441e-af5c-be7d55e732b5@enneenne.com>
References: <20260829210041.40649-1-dwmw2@infradead.org>
	 <20260829210041.40649-3-dwmw2@infradead.org>
	 <f6e90a49-8c68-42e6-bdff-ea9b3ecbaf7b@enneenne.com>
	 <fc1ec38dbc3723f7aed73ebf3413e1d81c161228.camel@infradead.org>
	 <7098f5d2-043d-464a-82d9-a105e4000c02@enneenne.com>
	 <cb992b22907085c4ced8d9a35cd1c8836aad20ad.camel@infradead.org>
	 <decd5d05-1373-4ddc-95bc-46b73d6f6b99@enneenne.com>
	 <7f98cef0918465e8d6bc9e76d26afb8b12471773.camel@infradead.org>
	 <a174957f-f414-42c9-80f9-5d60f448e044@enneenne.com>
	 <37ad7bb611c0e79840dfdb5c3706be3430c34bb4.camel@infradead.org>
	 <fc473eab-c72e-4641-b617-8f22389c8f68@enneenne.com>
	 <6a529b5fe8c5bbb664748b85be011f5cf2e6c44d.camel@infradead.org>
	 <14280dde8487260f4c590d49a0297777b690660d.camel@infradead.org>
	 <fbc06405-c7a0-441e-af5c-be7d55e732b5@enneenne.com>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-EcVTOOJ26pc2n+oatFNV"
User-Agent: Evolution 3.62.0-0ubuntu1~ppa1~24.04 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html


--=-EcVTOOJ26pc2n+oatFNV
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2026-10-01 at 10:20 +0200, Rodolfo Giometti wrote:
> Hi David,
>=20
> On 30/09/2026 20:24, David Woodhouse wrote:
> > On Wed, 2026-09-30 at 15:05 +0100, David Woodhouse wrote:
> > > [...] But
> > > I don't think we're ever going to be allowed to do it that way in
> > > entry.S but the *hardware-captured* stamps will want the same handlin=
g,
> > > so I wanted to prototype it anyway.
>=20
> Hardware-captured stamps are something I'd really like to see in the PPS
> subsystem. When you get there, I think it should be its own series,
> discussed together with the raw counter export you mentioned on the
> 28th, since both change what a PPS driver hands to the core and what
> userspace gets back. As I said for the export, I'd prefer to agree on
> the interface first.

Yeah, I'm trying to split things up as much as I can for upstreaming
simple series one at a time, while also keeping the future/RFC parts in
the working tree to be sure that it *does* all come together as a
coherent whole in the end.

The hardware-captured stamps aren't even on my radar for actual
*typing* yet, as I haven't got the hardware yet. (Which is partly why I
was simulating it with the entry.S capture).

I think *exporting* the raw counter values is slightly orthogonal and
can happen first. Even software-captured clock values *do* have a
counter read that goes alongside them.

Right now, we have userspace trying to discipline the kernel's
CLOCK_REALTIME, varying as it does around the "ideal" time that the
kernel wants to report. Especially on tickless kernels.

Even today, userspace could discipline the *counter*, free of any
feedback loops, and then just tell the kernel the result.

That just needs us to (optionally) report the counter value alongside
the clock value for PTP and PPS timestamps. The former is what Arthur
is adding to the PTP userspace API in=20
https://lore.kernel.org/all/20260717065924.2556-1-akiyano@amazon.com/

Carrying the raw counter value (and csid) in the pps_event_time
snapshot inside the kernel is easy enough. I haven't yet looked at what
the userspace API should look like for PPS. There was a discussion
somewhere about how we convert kernel CSID enum values to userspace.
You may have opinions...
https://lore.kernel.org/all/1a5c0883140d470657b2cba24b964f5ce71b9a15.camel@=
infradead.org/

> > We don't actually do *any* filtering. Even pps_phase_filter_get() is
> > just using the first sample, with a comment:
> >=20
> > 	/* TODO: test various filters */
> >=20
> > Looking closer at the actual captures, even Mills's median-of-three
> > wouldn't save us here when two of the three pulses are outliers. We'd
> > want an ongoing frequency estimation.
> >=20
> > But that's definitely a problem for another day.
>=20
> Agreed, but I'm interested in it too. Your setup, with the per-pulse
> captures, looks like a good way to evaluate a filter, so if you or
> anyone else picks it up, please Cc me and I'll be glad to review it.

Yeah, this box just lurks on my desk waiting for a chance to do useful
things, so I'm happy to do test runs with any candidate fixes. I was
kind of writing this pattern off as an artefact of the test itself =E2=80=
=94 I
*deliberately* synced it to do its data collection right after a pulse
(trying to do its work *between* pulses, rather than interfering).

But I guess if the main system clock is tied to the PPS (because, er,
why were we here in the first place?) then *any* periodic work could
have the same kind of beat effect, lining up with 1 in N of the 256s
pps_shift periods and triggering that ADSR pattern. Not just my test
which was deliberately synced to a *pulse*.

FWIW I think I have enough data captured from the existing runs that I
can do retrospective "what if?" analysis of how filters *would have*
worked. Another benefit of capturing the raw counter not the feedback
loop :)


--=-EcVTOOJ26pc2n+oatFNV
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCE8Ew
ggWvMIIEl6ADAgECAhANkOKMSmGXhF5eMl0rsRhvMA0GCSqGSIb3DQEBDAUAMGUxCzAJBgNVBAYT
AlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xJDAi
BgNVBAMTG0RpZ2lDZXJ0IEFzc3VyZWQgSUQgUm9vdCBHMjAeFw0yNDAzMTMwMDAwMDBaFw0zNDAz
MTIyMzU5NTlaMGIxCzAJBgNVBAYTAlVTMRcwFQYDVQQKEw5EaWdpQ2VydCwgSW5jLjE6MDgGA1UE
AxMxRGlnaUNlcnQgQXNzdXJlZCBHMiBTTUlNRSBSU0E0MDk2IFNIQTM4NCAyMDI0IENBMTCCAiIw
DQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAOfSIeC0vv1xPQ+dgSxbIIrkaru6skAWJYaGFzmv
q4Kq+2wU2jxhcWlJg/JeP5jEkq/LM3pn5aaLao79j+XRmS7J1ZpJKUODJVoM4s9MQJhTMvo4qS5Z
S64g6QR7Obkz3I1Lr3aWeSBmDDEyzue+NKtuWZ1Cxy3RdXo/w5HgRc3l2AercOM3Gt1XonTzEtTb
Z/Hwc0Sn9Gz8RmGRK6Ka4hVDl8q/2l110KaV233Kh5etP0csXS8MIMdVRfRu3sc5hp13DG7lCKzK
72a2GEpI8Wpl26G6I1/LMzz/98T+FqjTqxsdquk7Cj7m2vKGLW1BorpQH7WFGPdJQXJe1hfbfiZA
CcVdCtl4nAacFacmsiArZBfX7AQGL7isvHUwwYFEtcApyGW4p2Lt+t8nvU0CANA6BHOpOz1xOP8W
mAESbUriIjyuTUf3fJ9oDNCurVqhASMJCDaWI3lYX/QAoiAzt6akqbbZxo2ujW7mGGqc0KxqE2cs
h2T79v7pC8aUtHBfwNrTR19GnZVxE0eQ7ViIQhR6mpSaUQFA9sG+cmD2G8TnCgYsLa0q8De6F61a
CBevQGHNzrbZ3JAMneveYg/Jy1XxQHDRcvrMfWKe0jjcWbdKYlaGVPm5V1ILwYz7Yv5ewo3NUrxI
GJiywe9qPhuJSDZs7VehTuI0FxGIsgKzVjgbAgMBAAGjggFcMIIBWDASBgNVHRMBAf8ECDAGAQH/
AgEAMB0GA1UdDgQWBBT3m6JO05fF9DQPQw6Bhc6RkzKv+TAfBgNVHSMEGDAWgBTOw0q5mVXyuNtg
v6l+vVa1lzan1jAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0lBBYwFAYIKwYBBQUHAwQGCCsGAQUFBwMC
MHkGCCsGAQUFBwEBBG0wazAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuZGlnaWNlcnQuY29tMEMG
CCsGAQUFBzAChjdodHRwOi8vY2FjZXJ0cy5kaWdpY2VydC5jb20vRGlnaUNlcnRBc3N1cmVkSURS
b290RzIuY3J0MEUGA1UdHwQ+MDwwOqA4oDaGNGh0dHA6Ly9jcmwzLmRpZ2ljZXJ0LmNvbS9EaWdp
Q2VydEFzc3VyZWRJRFJvb3RHMi5jcmwwEQYDVR0gBAowCDAGBgRVHSAAMA0GCSqGSIb3DQEBDAUA
A4IBAQA+b8Uw53sDspdZgukU+qzLyyHkcjlxGGhHlP+zrmDLKm1wEFvCRS2pili3Hy67i8N4N5NU
vw5Rg6kv3lxb9S9Rktxk43k+tvm68pl7OxQE55ZjVY87P0lUPGwEqOOwLLyH02ZQcsfq5p5LrOH9
0JvmvZ1yy73HS+VpDAqOlytE0NSvTIRqFFkKQGQwfjvtql9YflujuNNvJztjBaHKYZsnNSg+J38o
jYq4TP3pSg3UdVH0PncVjPQyqxC9xef5Xae92Kbkzol3x7Nel3A1bwAkalrDMspvTHvey6LfiBks
FIqviTnoy7fgjaRAJgHS+RXx/cmuRd3rUAclSVVrYu8RMIIHAzCCBOugAwIBAgIQAzUotrsybJHx
HTjKOIVdIDANBgkqhkiG9w0BAQsFADBiMQswCQYDVQQGEwJVUzEXMBUGA1UEChMORGlnaUNlcnQs
IEluYy4xOjA4BgNVBAMTMURpZ2lDZXJ0IEFzc3VyZWQgRzIgU01JTUUgUlNBNDA5NiBTSEEzODQg
MjAyNCBDQTEwHhcNMjYwNzE4MDAwMDAwWhcNMjgwMTA0MjM1OTU5WjAeMRwwGgYDVQQDDBNkd213
MkBpbmZyYWRlYWQub3JnMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEA2pYux73kdbYX
sWF8f1u6DJP91qcqaZetsyfPkZk0B+MmXmAEv0kVes5n15V2mbDThOnpoPFly0UugQO9JYqLfrtD
tKD5yL58fgrDB9Dw+LQikgrHafl6YSCds5AvUu/8hw2J6noKrcOLJpKlKn9Fl/4IB9Q3JIdLx5aa
EtTqMalIPqHFOlgrJ7s+aua8xbB8YQ9ahqYBXWRJNv3P/2b1DYtdrz1oqZPE3CcB8Pc6Gf2a1Tcm
6TAgtEx7Cf1BFcrsrMz7TWHmGQITieNb2r9UYWSc2Gp+GtYFNJCgT0JJXKUBIauPMKBLteYrL8Fo
ff/uY44dC/mDWjdCP/5x0qelPQjlBvWdHL5zvBTOj06rJ0m3HNI/hnIcDh0Qu2j9reb9rLVcdym6
bWmBM4uDEB8Zv9Ph0KTBFSy1IosyakuD1j1Os30EzjGfbi0EUXIvnOcYbTBAbM5UAzrxEHMhBvoX
Pvnx+OyvjJmc9tWxTX6AcSz+m40esbT17URBeZS18afgieiikm5TynlUYP1LciR3hSgGVzvGXnKO
02VDFR5itGWdRKZ2W5wIShNfWfhSa0D0K5UdIDt5Qc7sjzwK1Yb1sY5Tu0uA5mhIS82q1ov83uxB
sFkriNnhGv/M1NCDVLBiOMsHu73qUM+yKmgKLwF9Hfn9WI25glbAMI4S5r3hYzcCAwEAAaOCAfcw
ggHzMB8GA1UdIwQYMBaAFPebok7Tl8X0NA9DDoGFzpGTMq/5MB0GA1UdDgQWBBRcYhqbcGzn1jrT
JOZaB8O7qllDpzAwBgNVHREEKTAngRNkd213MkBpbmZyYWRlYWQub3JngRBkYXZpZEB3b29kaG91
LnNlMBQGA1UdIAQNMAswCQYHZ4EMAQUBAjAOBgNVHQ8BAf8EBAMCBeAwHQYDVR0lBBYwFAYIKwYB
BQUHAwIGCCsGAQUFBwMEMIGpBgNVHR8EgaEwgZ4wTaBLoEmGR2h0dHA6Ly9jcmwzLmRpZ2ljZXJ0
LmNvbS9EaWdpQ2VydEFzc3VyZWRHMlNNSU1FUlNBNDA5NlNIQTM4NDIwMjRDQTEuY3JsME2gS6BJ
hkdodHRwOi8vY3JsNC5kaWdpY2VydC5jb20vRGlnaUNlcnRBc3N1cmVkRzJTTUlNRVJTQTQwOTZT
SEEzODQyMDI0Q0ExLmNybDCBjQYIKwYBBQUHAQEEgYAwfjAkBggrBgEFBQcwAYYYaHR0cDovL29j
c3AuZGlnaWNlcnQuY29tMFYGCCsGAQUFBzAChkpodHRwOi8vY2FjZXJ0cy5kaWdpY2VydC5jb20v
RGlnaUNlcnRBc3N1cmVkRzJTTUlNRVJTQTQwOTZTSEEzODQyMDI0Q0ExLmNydDANBgkqhkiG9w0B
AQsFAAOCAgEAocabrh1cPd5s3vY5rnlBVQSTc7zs2ZWs67dAIltR+05WELrYClVzzUhMs/LOJPlr
EUo45UDDomXq38DxFepaPd9+iNLjXfn33EX/IG44j04lU/oF/Rg9VeQILkYLbCZ/x9wOjNHZc4SN
ydY7Dhvf/sT5aBz88u7D5+azZJ7Qf1U57wYseCH1Mt0nDrtr5y19IJ8D9xJJ33RFL6vfpHZBBAQ8
+3RqkKNxLoV2aFvQhxdhjNLDqTv3LjUIdicwPraN7JkxEu7CV2Lka7eRqJgkWL7SK0YmBjGpRafs
+icP/ON5RCCKTTb6VlX8eTG2sJJfsFhvJNCCt6xexbWzWtIrfP7NvPBvwBB737AyEGBZkS5aNizT
McURJGTv9UKvBh1LF/+tNhYtLvPCN7oecGzhCHht9jcwSkygTo3Y6YlK3QgOu+ncmiBbfeuwlLZ1
LxbYvG6hgNqXv7u6YyADbYajAQJXJ2OQen39pm3Q/AQSyLYG+B8lDglWsM8tYXPlEdrYJcksGK6F
nqIX6Bumn43rBooLJdiZp4WmfWdL2pxe+LxRDjprmqu1WprixDxULSTOKJZoqTlugs6y3Bc+if+s
gHnBBtz9WQ6MtPHkh7zONDAFIKcBmv8OqPQCx0F3Wv3OEybwMpXx0OsKgK8wLldaX1pXcMuyDgTL
Sqs0AV0OHUgwggcDMIIE66ADAgECAhADNSi2uzJskfEdOMo4hV0gMA0GCSqGSIb3DQEBCwUAMGIx
CzAJBgNVBAYTAlVTMRcwFQYDVQQKEw5EaWdpQ2VydCwgSW5jLjE6MDgGA1UEAxMxRGlnaUNlcnQg
QXNzdXJlZCBHMiBTTUlNRSBSU0E0MDk2IFNIQTM4NCAyMDI0IENBMTAeFw0yNjA3MTgwMDAwMDBa
Fw0yODAxMDQyMzU5NTlaMB4xHDAaBgNVBAMME2R3bXcyQGluZnJhZGVhZC5vcmcwggIiMA0GCSqG
SIb3DQEBAQUAA4ICDwAwggIKAoICAQDali7HveR1thexYXx/W7oMk/3Wpyppl62zJ8+RmTQH4yZe
YAS/SRV6zmfXlXaZsNOE6emg8WXLRS6BA70liot+u0O0oPnIvnx+CsMH0PD4tCKSCsdp+XphIJ2z
kC9S7/yHDYnqegqtw4smkqUqf0WX/ggH1Dckh0vHlpoS1OoxqUg+ocU6WCsnuz5q5rzFsHxhD1qG
pgFdZEk2/c//ZvUNi12vPWipk8TcJwHw9zoZ/ZrVNybpMCC0THsJ/UEVyuyszPtNYeYZAhOJ41va
v1RhZJzYan4a1gU0kKBPQklcpQEhq48woEu15isvwWh9/+5jjh0L+YNaN0I//nHSp6U9COUG9Z0c
vnO8FM6PTqsnSbcc0j+GchwOHRC7aP2t5v2stVx3KbptaYEzi4MQHxm/0+HQpMEVLLUiizJqS4PW
PU6zfQTOMZ9uLQRRci+c5xhtMEBszlQDOvEQcyEG+hc++fH47K+MmZz21bFNfoBxLP6bjR6xtPXt
REF5lLXxp+CJ6KKSblPKeVRg/UtyJHeFKAZXO8Zeco7TZUMVHmK0ZZ1EpnZbnAhKE19Z+FJrQPQr
lR0gO3lBzuyPPArVhvWxjlO7S4DmaEhLzarWi/ze7EGwWSuI2eEa/8zU0INUsGI4ywe7vepQz7Iq
aAovAX0d+f1YjbmCVsAwjhLmveFjNwIDAQABo4IB9zCCAfMwHwYDVR0jBBgwFoAU95uiTtOXxfQ0
D0MOgYXOkZMyr/kwHQYDVR0OBBYEFFxiGptwbOfWOtMk5loHw7uqWUOnMDAGA1UdEQQpMCeBE2R3
bXcyQGluZnJhZGVhZC5vcmeBEGRhdmlkQHdvb2Rob3Uuc2UwFAYDVR0gBA0wCzAJBgdngQwBBQEC
MA4GA1UdDwEB/wQEAwIF4DAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwgakGA1UdHwSB
oTCBnjBNoEugSYZHaHR0cDovL2NybDMuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0QXNzdXJlZEcyU01J
TUVSU0E0MDk2U0hBMzg0MjAyNENBMS5jcmwwTaBLoEmGR2h0dHA6Ly9jcmw0LmRpZ2ljZXJ0LmNv
bS9EaWdpQ2VydEFzc3VyZWRHMlNNSU1FUlNBNDA5NlNIQTM4NDIwMjRDQTEuY3JsMIGNBggrBgEF
BQcBAQSBgDB+MCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5kaWdpY2VydC5jb20wVgYIKwYBBQUH
MAKGSmh0dHA6Ly9jYWNlcnRzLmRpZ2ljZXJ0LmNvbS9EaWdpQ2VydEFzc3VyZWRHMlNNSU1FUlNB
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
83ArYk7wfOhIv6TFAtFZtG8AAAAAAAA=


--=-EcVTOOJ26pc2n+oatFNV--
