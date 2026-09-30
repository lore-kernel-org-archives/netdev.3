Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75BC234964;
	Wed, 30 Sep 2026 01:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790731721; cv=none; b=S/ywPgOk1GyzbGWhIwBCgZe4VsggWvXide5qeGdFTMkidrDA2/WxX2ZXmeVuMZqaHlYROmSA4knlL3bTUU0ZZF+OkSjyib6PJqIFetnlO5uteKFrtxVxUnKi+q5oSpiAppwpYH1yQ8wDdZJI16ZNwcTBBp9WHkeaiToo35dL9g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790731721; c=relaxed/simple;
	bh=wPshhzmmwm0hoDO9j2HFW7ILHE4fBBbzs8MLMm4njO4=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=soHpHSmt30iTVqCRer4rEVOo2TeYurH983JTtMKfYZ40RFqW+YZUL3sq6lQOUPmLxlssqNJI/mK13LgnvqoJGlrp+Svs6h6BRw4PoxQ1FpsOtZ182o75kqwE2XQeZqR6lyQ4QeuZ1wreCHupoba3mZHmf5bOFkriyvQTSDXuXLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wY5p2loY; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wY5p2loY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:To:From:Subject:Message-ID:Sender:Reply-To:Cc:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Rb2LP0Obl55X6dCdMQaw+TiBhDxt3/nhzPA7LPgyqYE=; b=wY5p2loYocFzQrhrBkNOT36pxJ
	iin8SrdrO7XSAxeNInSX8ljg8FEmW5MjYUobeWR13Rj1p0H0kr8nxFItpCyyQ1I6hKgN4KuZPWbxU
	rRGEX8DxREPUsLYjaSIGEI4MsEvDlIEyw9bAf96W1TiEn6DAjkZYuiU/XSe6Nf2GtkSnKESQ65zpn
	IjEsNXvSVLlLU2XLhYkDWfSCWb91yWZkM2yiyG3oyzRVyQDcWBiLDymdEvychfVMhfcL1lTfVxT7a
	x9a8jtn1k3k4UfRfB9YK+wLmCLOjUh+F/yI7LgbBDKd1luja6q+pgVRawAHEMyJDU6cViYkjjlSH4
	cEMWoKRQ==;
Received: from 54-240-197-238.amazon.com ([54.240.197.238] helo=u09cd745991455d.ant.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBj7X-00000004ZIR-08C6;
	Wed, 30 Sep 2026 01:28:31 +0000
Message-ID: <3f15c68bce92c57821fba53c80aed7fce13cf8c0.camel@infradead.org>
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
Date: Wed, 30 Sep 2026 02:28:30 +0100
In-Reply-To: <a174957f-f414-42c9-80f9-5d60f448e044@enneenne.com>
References: <20260829210041.40649-1-dwmw2@infradead.org>
	 <20260829210041.40649-3-dwmw2@infradead.org>
	 <f6e90a49-8c68-42e6-bdff-ea9b3ecbaf7b@enneenne.com>
	 <fc1ec38dbc3723f7aed73ebf3413e1d81c161228.camel@infradead.org>
	 <7098f5d2-043d-464a-82d9-a105e4000c02@enneenne.com>
	 <cb992b22907085c4ced8d9a35cd1c8836aad20ad.camel@infradead.org>
	 <decd5d05-1373-4ddc-95bc-46b73d6f6b99@enneenne.com>
	 <7f98cef0918465e8d6bc9e76d26afb8b12471773.camel@infradead.org>
	 <a174957f-f414-42c9-80f9-5d60f448e044@enneenne.com>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-cVyiRrUrY7XOv4v+ip/X"
User-Agent: Evolution 3.62.0-0ubuntu1~ppa1~24.04 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html


--=-cVyiRrUrY7XOv4v+ip/X
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2026-09-29 at 13:48 +0200, Rodolfo Giometti wrote:
> Hi David,
>=20
> On 29/09/2026 11:32, David Woodhouse wrote:
> > When second_overflow() is delivering skew, timekeeping_max_deferment()
> > should trigger a wakeup at the end of the second to ensure that the
> > skew gets recalculated =E2=80=94 rather than leaving it active indefini=
tely.
>=20
> Please put this fix in the series before 2/4, as for the tick_length
> one.
>=20
> > So the results at https://david.woodhou.se/ntptest-r64/tickless/=C2=A0n=
eed
> > to be redone, but you can take a look and shout if you want me to
> > change what I'm capturing or how I'm doing it.
>=20
> What you capture is fine for me: the adjtimex state (offset, jitter,
> stabil, errcnt) plus the per-pulse phase are what I wanted to see.
>=20
> Two questions for the rerun:
>=20
> - wouldn't it be better to also have the tickful baseline with the same
> =C2=A0=C2=A0 board, the same GPS and the same pulse period, so the number=
s can be
> =C2=A0=C2=A0 compared directly?
>=20
> - since typical PPS sources deliver 1 Hz, don't you think it would be
> =C2=A0=C2=A0 better to also do one run with the timepulse at 1 Hz?

Ok, I have the series in the shape I want to test it now. I got caught
up in more side quests around minimising ntp_error, which aren't
*strictly* around hardpps or snapshots at all but it was annoying me.

https://git.infradead.org/?p=3Dusers/dwmw2/linux.git;a=3Dshortlog;h=3Drefs/=
heads/timekeeping
now has:

 =E2=80=A2 timekeeping: Allow tick_length changes to apply mid-tick
   (reduce a fairly gratuitous cause of ntp_error accumulation, when
    we *account* for a rate change before it actually takes effect)

 =E2=80=A2 timekeeping: Apply extrapolated ntp_error to clock snapshots
   (you know this one; as discussed maybe it'll shift to later)

 =E2=80=A2 timekeeping: Bound idle sleep while a phase slew is in flight
   (even standard adjtime() was hosed for tickless and would keep
    applying 500=C2=B5s/s skew the whole time the system slept)

 =E2=80=A2 timekeeping: Reinstate proportional correction of ntp_error
   (because once I fix the above, we *can*)

 =E2=80=A2 ntp: Recalculate skew_delta when the phase offset changes
   (another gratuitous cause of ntp_error accumulation. If time_offset
    goes away *while* we're skewing towards it, the continued skew
    for the rest of the second is unwanted and goes to ntp_error.
    Just... stop skewing!)

 =E2=80=A2 arm64: Support inlined clocksource reads for the arch counter
   (this seems like an oversight)

 =E2=80=A2 timekeeping: Read the counter as early as possible in ktime_get_=
snapshot_id()
   (as I said, those 20ns are in the noise... but you can have them
    back anyway)

 =E2=80=A2 pps: Drop the !NO_HZ_COMMON dependency from NTP_PPS
   (Really, it isn't needed. This is working)

 =E2=80=A2 pps: Always use ktime_get_snapshot_id() for pps_get_ts()
   (I think I mostly eliminated ntp_error as a significant source of
    discrepancies now, but this is still the right thing to do for
    precision)

And then we get into the get/set reference stuff for vmclock which is a
different RFC series of its own, and mostly comes along for the ride as
I rewrite the underlying timekeeping branch, although I do plan to redo
the "no independent reference" vmclock unit test.

 =E2=80=A2 timekeeping: Add absolute reference for feed-forward clock disci=
pline
 =E2=80=A2 ptp_vmclock: Feed reference to timekeeping for feed-forward disc=
ipline
 =E2=80=A2 kernel/time: Add /dev/vmclock_host miscdev
 =E2=80=A2 [DO NOT MERGE] ptp: ptp_vmclock: Add simulated 1PPS support
 =E2=80=A2 [TEST HACKS] bench instrumentation for R64 PPS soak

The tests are now running on the BPi-R64.

First, full nohz idle with 5s pulses. It was idle for 3,4,5 seconds at
a time, converged within the first minute, ntp_error remained in double
digit nanoseconds, PPS pulses landing on average within =C2=B1150ns of the
second, with occasional 4-6=C2=B5s interrupt latency excursions. The
adjtimex jitter estimation mostly sat at 0-5ns once converged.
https://david.woodhou.se/ntptest-r64/tickless-5s/

Same nohz idle setup with 1s pulses, ntp_error unsurprisingly much
lower, pulse phase also much tighter. Possibly due to not entering
lower power states?
https://david.woodhou.se/ntptest-r64/tickless-1hz/

I don't much like the shape of the frequency charts. There's that weird
pattern every 256s on the tickless-5s one which reminds me of the ADSR
waveform on a 1980s SID sound chip, and a similar shape with a period
of about half an hour in the 1Hz test. But I don't think that's related
to the *tickless* part at all. My friend has theories but it's far too
late for me to properly follow and sanity-check them tonight.

Running the tickful 1hz test now...



--=-cVyiRrUrY7XOv4v+ip/X
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
AggbkLXdw/6223Fu/5okFm4AAAAAAAA=


--=-cVyiRrUrY7XOv4v+ip/X--
