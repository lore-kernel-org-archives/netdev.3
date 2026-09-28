Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540FB3655FF;
	Mon, 28 Sep 2026 12:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790600367; cv=none; b=He2ooitALQ2fl+KeGtk5hPsYj+0VMWUVWAVk+82kKvHJNYv4bPATJg6VbD1qNxnmtlUt96JKMRH5CiiAB4YUX3M3BpNhIPYBVIzcwlLoKfsuUUBSZIjaD+MNOOK+OtCOm/wYBqCgn1DE3+7PzZLhYkBMpXUa1MC7Vz074JiUBo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790600367; c=relaxed/simple;
	bh=RGDnCrdHWJo+pEBGV1jWJDwkafZeAA1DD8n5tMYtBGI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qE/aAa4ZvQxorSdWcRd9rhgfG/rTB3qusXsnevBSOapH9VCq0UbU67rgpP+X7+u8dvVdHZUZoEgO9tze/gHPIxHSIGs11M2/HqdVxCiHBZ9taPPaQoyDR3Xq1HjrVymf931weBJ+bsd7/THo+NNt21WsHDdgRnbJTxh/MmnoJqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Rgvu4hWU; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Rgvu4hWU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:To:From:Subject:Message-ID:Sender:Reply-To:Cc:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RGDnCrdHWJo+pEBGV1jWJDwkafZeAA1DD8n5tMYtBGI=; b=Rgvu4hWUtjuMYYhJrscusiyO7+
	NCSIl6WKd8IFcV+eQT5xelbG2h4+XD3vMFPIZJbeoEHYTSA83cBKsPXmnJvlL0whkDAD9TRjJklAA
	7vMUMIlMMC3g+g2xc12U+qQWyQOPzjFQqxwfuo8Ojux4sKjkx4Ep6WvMs+C48uzEpVBLijzDte2jm
	hqgIayA/TzEzhzvlVZptP9havwo8ilFU0emAXIsGc/88UcbgJYXVik8x2b08n+/WUIVSU/e3D6RQ4
	S++1CFpK+k5PVp/DBjCEMeU3UtaOp1uC+s3IsFrNJDmAIaI+Jc3+513MUw6c9FZxEhhSCIZ+ct1bH
	WfE+KnWA==;
Received: from 54-240-197-235.amazon.com ([54.240.197.235] helo=edge-m3-r2-132.e-iad51.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBAwr-00000006liu-3Y09;
	Mon, 28 Sep 2026 12:59:14 +0000
Message-ID: <aa9a0ec325a0cff908d19542b71b780424a4af30.camel@infradead.org>
Subject: Re: [PATCH v4 3/4] pps: Always use ktime_get_snapshot_id() for
 pps_get_ts()
From: David Woodhouse <dwmw2@infradead.org>
To: Rodolfo Giometti <giometti@enneenne.com>, Richard Cochran	
 <richardcochran@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>, John Stultz
 <jstultz@google.com>, Thomas Gleixner <tglx@kernel.org>,  Stephen Boyd
 <sboyd@kernel.org>, Miroslav Lichvar <mlichvar@redhat.com>,
 linux-kernel@vger.kernel.org, 	netdev@vger.kernel.org, Alexander Gordeev
 <agordeev@linux.ibm.com>
Date: Mon, 28 Sep 2026 13:59:12 +0100
In-Reply-To: <4afec82e-9e3d-4615-9657-7d467d8dc3e7@enneenne.com>
References: <20260829210041.40649-1-dwmw2@infradead.org>
	 <20260829210041.40649-4-dwmw2@infradead.org>
	 <920a2d70-c1ec-452b-8fc4-aebf1f6af412@enneenne.com>
	 <d1af17dff1d6f181d74edd3b6358398469d61917.camel@infradead.org>
	 <4afec82e-9e3d-4615-9657-7d467d8dc3e7@enneenne.com>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-21G5AumZjtAr1ycSPf0G"
User-Agent: Evolution 3.62.0-0ubuntu1~ppa1~24.04 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html


--=-21G5AumZjtAr1ycSPf0G
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-09-28 at 09:58 +0200, Rodolfo Giometti wrote:
> On Sat, 2026-09-26 at 21:38 +0100, David Woodhouse wrote:
> > So yes, the specific code path you're looking at *does* get slightly
> > longer (50ns to the counter read instead of 30ns).
> [...]
> > However, they are *entirely* in the noise, as there's about 600 ns of
> > hardware and 2-4 *microseconds* of software latency before we even get
> > there.
>=20
> Thanks for measuring it, and on real hardware with a real edge. That
> answers my concern: ~20 ns of constant cost against microseconds of
> latency upstream of the handler is not something PPS can see, and
> trading it for the removal of a non-constant error is the right
> trade. It is arm64 rather than the 32-bit board I asked about, but I
> accept the argument holds there too, since the software latency only
> gets larger.
>=20
> There is still one thing I want to be sure we agree on, about what
> ts_real means for userspace.
>=20
> Today, without CONFIG_NTP_PPS, ts_real comes from ktime_get_real_ts64(),
> which is the same value userspace reads with
> clock_gettime(CLOCK_REALTIME). A PPS timestamp and a clock_gettime()
> reading are identical by construction: both are the sanitized clock.
> With CONFIG_NTP_PPS the same held so far, since ktime_get_snapshot_id()
> also returned the sanitized value.
>=20
> After 1/4 and this patch that is no longer true. Your 1/4 says it
> explicitly: callers of ktime_get_snapshot_id() now receive the ideal
> time, "not the sanitized version provided to gettimeofday()". So ts_real
> becomes the ideal line, while clock_gettime(CLOCK_REALTIME) keeps
> returning the sanitized one, and the two differ by ntp_error at the
> instant of the edge.
>=20
> For hardpps this is clearly what we want, and your 1/4 and 2/4 make
> that case. For userspace I am less sure. chrony and ntpd compare PPS
> timestamps against other sources whose timestamps come from
> clock_gettime(), i.e. from the sanitized clock, so after this series
> the two would be referenced to different lines, ntp_error apart.
> Miroslav, is that something chrony would notice? And David, how large
> can that difference get in practice? Your 1/4 says the divergence can
> span many ticks under NO_HZ.

Theoretically, absent other bugs (qv), ntp_error should rarely be more
than a few tens of nanoseconds and even that is the extreme case.

It swings slightly positive and negative as the reported CLOCK_REALTIME
goes slightly behind, and ahead of, the ideal time.

This happens because of the integer quantisation of the counter period.
The kernel spends a while running with the base 'mult' and getting
behind, and then switches to 'mult+1' to catch up. On a *tickful*
kernel, it flips between them as soon as ntp_error goes
positive/negative each tick.

On the board I'm testing with, that =C2=B11 difference equates to about
0.745ns/s. Right now, its "ideal" mult calibrated against the PPS
signal is about in the middle (1342189164.4992), so that means it has a
choice of running 0.372ns/s slow, or 0.373ns/s fast. Worst case, the
value could come out very close to an integer, and the =C2=B11 choices coul=
d
approximate the full 0.745 in one direction, and almost negligible in
the other.

So on a *tickless* kernel when it doesn't course correct every tick, it
could get set to gain 0.745ns/s and then go to sleep for, say, ten
minutes, and accumulate... half a microsecond.

I don't think ten minutes is really that realistic, of course. And in
practice I definitely can't make nohz_full actually contribute a
meaningful amount to ntp_error while *also* waking it up every second
(or even every 5 seconds) to process a pulse.=20

However, I *have* seen (and fixed) the tick_length changes at chrony
startup introducing 83=C2=B5s into ntp_error, which would take *days* to
drain through the normal =C2=B11 dithering, and would screw up the actual
frequency settings while it was draining.

I've pushed out my current WIP to my timekeeping branch=C2=B9. The fix for
the 83=C2=B5s ntp_error is the first=C2=B2 in the series =E2=80=94 "timekee=
ping: Allow
tick_length changes to apply mid-tick".

> Since the main users of ts_real are chrony and ntpd, not the kernel,
> I would like an Acked-by from their maintainers before I ack this
> patch. They are the ones who will have to live with the new semantics,
> so they should know what is coming and agree with it.

Absolutely. I've called this out explicitly in the patch which makes
ktime_get_snapshot_id() do that correction. That's the second patch=C2=B3 i=
n
my branch =E2=80=94 "timekeeping: Apply extrapolated ntp_error to clock
snapshots".

I wonder if we should switch PPS to using ktime_get_snapshot_id() in an
*earlier* patch, which wouldn't then include the behavioural change.
Then the note in the 'Apply extrapolated error' patch can then cover
PPS and we consider them all together.

The PPS change does stand alone anyway =E2=80=94 regardless of the snapshot
*corrections*, I want PPS using snapshots so that it can report the
actual *counter* values to userspace, like PTP is going to be able to.
Then userspace can choose to discipline the actual *counter* without
worrying about the feedback loop of the kernel's own timekeeping at
all.

=C2=B9 https://git.infradead.org/?p=3Dusers/dwmw2/linux.git;a=3Dshortlog;h=
=3Drefs/heads/timekeeping
=C2=B2 https://git.infradead.org/?p=3Dusers/dwmw2/linux.git;a=3Dcommitdiff;=
h=3D3ff34be9c943
=C2=B3 https://git.infradead.org/?p=3Dusers/dwmw2/linux.git;a=3Dcommitdiff;=
h=3Dbac732b0bf23

> So for v5 please put this in the commit message, not only in the
> thread: why ktime_get_real_ts64() is inaccurate (the quantisation of
> the multiplier), that ts_real is now the ideal NTP-disciplined time
> rather than what clock_gettime() returns, the order of magnitude of
> the difference, and a short summary of the latency numbers above.
> Whoever runs git blame on pps_get_ts() in a few years should not have
> to find this thread.

Ack. I discussed the order of magnitude above. Let's see how my
proposed optimisations land, and I'll update the comments on latency
too.

For the "ts_real is suddenly something different" aspect,=C2=A0I'll defer t=
o
Miroslav et al but I do believe that this is either in the noise at
most levels of precision, or a *correction* where it's even noticeable.

The use cases which consume a snapshot are the ones which return a
tuple of that timestamp against something simultaneous =E2=80=94 either the=
 raw
counter value, a PPS pulse which is known to be at the top of a second,
a PTP reading from an external clock. (Worst case, PTP sandwiches two
local timestamps around an external clock reading).

Those use cases run within an actual system call (not vDSO), and are
never about the time "now", per se =E2=80=94 they're all about the pairing.

They shouldn't be compared directly with a clock_gettime() where
userspace... is preempted and... calls into the vDSO to get the time...
is preempted again and... eventually does something with that timestamp
which it considers to be current, or worse paired with whatever happens
before or after it.

So I'm not too worried about the fact that the two different mechanisms
return time in a *slightly* different form, because the normal
userspace path chooses speed and monotonicity over accuracy.

--=-21G5AumZjtAr1ycSPf0G
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
Q/RRuduOCmcPKC5b3u0Sq24AAAAAAAA=


--=-21G5AumZjtAr1ycSPf0G--
