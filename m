Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793444298;
	b=tATDiptUFGSyiKkHnZAO0ylFvPDjZ7gAYegrJB/SIG5GdOtmUlckSFWfAnyzWFrrhAqZ
	 KKtPFnEdSP2u5llveWt3HHjJTBqAf/GMprx/b/GF2IsR+9WBSMzMO/Ae3AFn5Ds5qG2PH
	 /Jm/9yoCNDQQiw+7cwo5DNqc872TEBaOfw8elMepK4PgEe9DzIc4OgzrWsYPFcI10dzCT
	 yYDXAR3R5xCr/kPzjJd4heDR1G3B/GqbroSabRl5fbcFkrI95g8d5LQir+/cXN3XC48vP
	 3LTBhxUCuS0xAz0DyG5g6ZfkTO7owV1ljf7kYpmaO0/YNhyVT0WhVoqFuIRwlBKtx2A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793444298;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Content-Type;
	bh=pQdgwGwX3UbTjniYm5PHDppiBqFG7tm5q1sllUN72/o=;
	b=0dzh9IuL6MU2anUpLgcjCpFSGnjTp1Jyg7CUm4WCM0JNcTSpzHQC4QDEG6QuC5xUmQzt
	 rRoHIIsgLAz1de0G2sPAHOVbFa0W0LqXkRVzNqU7bmqtAkXz4gotj8RUN3DY0Byex3xSS
	 MgS0YMS6K7xFM/dQp33cf3/LVRFquZHBPh3uuck+juD9x2vGg98iDNkt/JDWKwn4dvH3n
	 wKT+2oQu4gp+V1viHUDHF9y9IGPZi4DtSqc0xRXnlgYZVmOfCqASurDb7OVybucndaM8F
	 NS2EsZsa7gqrDRNLs2DobNS+qgaeHr4zCgI+wgPI5mqm4+SA7oLKe3PwBVk2HwEfXrw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ljPtd3Ub;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF7B606A31A
	for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 10:58:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BF7B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ljPtd3Ub
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6b1aa27963eso4521188a12.1
        for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 03:58:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793444297; cv=none;
        d=google.com; s=arc-20260327;
        b=SKL8bDjWgieT3iXehEd1RQPTdM8r8YODaU8QrHTfH01gFWhMsCOXf90vD/zHhFGNks
         G5vcDQFJ3oq0VoXF3+zcth9zF7aIAbvnety+aeN3jrh+Udh0yxX96PF1LOenWbadpOGV
         OD/0kLDK1y6Do+U8lx/BLIE/+/Gvu3hhc3tm/yfhJgOB+BLe6wJNSUEMvn+ntURlyzWm
         NrGi2NYUV8EnY7/b8D9/bedfYR1u4OhnxNNKgkjWZ4LQgV2QzzxET+fcX4JQnJ4vLDLV
         7y8R3IjgUmBK0iR35xB5MD/HDvI/eBik+S0ZWaCFRLtxu1BcPE8H8x4kmXZrGBYihse4
         Coqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=pQdgwGwX3UbTjniYm5PHDppiBqFG7tm5q1sllUN72/o=;
        fh=8HR9hIcv0rWc29f3Jcpv07SCxca9nCBzuIuvfNO51WQ=;
        b=NGda+FgJ8mom+3D8kU5TqN3kdUmDW3cKZIANib3zZ+V4ME4QNhlNds1QAoJAwVd7Bx
         pUv7XdcywYkxbKZprE5mTuGwITqkH0utWVBn33oi3JIYOXRoalJihVK9jpjuvn3k46xP
         milhwSZTJ6q7WFAAMAqohMjZ/l1Zyu3++KZrftEcqDmKjhDGAakRERCz3mSmVCj5sXoN
         Z/NGBtWD8/B2QETB3dwcoomofKXDnPA8Z3xNsunTl/t3a17vXSVyhSCf2l18vsM3lOxf
         tFepcoJQdQd3U2QogODzYeLOEQez8k7p9LzNHnwpNQAlGcG+q/gAZFUAqTMIChBXL9hx
         0QYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793444297; x=1794049097; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=pQdgwGwX3UbTjniYm5PHDppiBqFG7tm5q1sllUN72/o=;
        b=ljPtd3UbiRLvcNG3R3UBSoxOxXI9TcShlLTOifevRCixL72nD6cR724sU3vIw8XDVt
         Jd1O7aWSy4TES3pUh3x0PnT5AgbpHmjWIRi9XKatdpTF46CLcrALAj48syve0a789K/5
         5euGqlzFBe7AcUDufCuW8QrsTsLgoYonXissEiT4R0uCseVRQBKMF41Dngbit9/xnwuQ
         ftrcRBikEHqQKMR5GcdaC0Sr05kI5MHgLUY5hv1UNcCV7JzPFiw3x6Mn+w3V4O+8igWb
         kJLmGhLosjd3XUrC2xM0QhHoTGaoph0rRN0SdMb98vsgPyhBCUoMPSoQl1xGBJL13ZzG
         hk+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793444297; x=1794049097;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pQdgwGwX3UbTjniYm5PHDppiBqFG7tm5q1sllUN72/o=;
        b=sTn0nmGBakpiVnm8n/PD5Ym0nDqhEJbOkMncsSvMkZqjrer3YDFhCBdU3BTNgSMyma
         vuGWG6f2aN+VrWeMNJjR5/GrCALFUajlp3qWs8NhIKUNxGDGU01mrCnvL7pgBWAjrtk6
         xcC7sznW7+Y4ZP5JVoU1AWaDUWed19MYtcf8ZvI0NHILfW9pNEvTcP4JPNBh0lwsJelv
         1ezwNMIdxV8g3RSMeQSKG6og8U8Hudnb+bCA0XZnPO8u57/cZfab14yHRsZmlbbvzYfp
         qS/GRRknb3ComVrFnXNV5x1kwlaJALIEofFlBd4BIr16w4yxfb28xCsk7IA1pD9W6Jmy
         sD/A==
X-Gm-Message-State: AFq9FYIiPQApDbIO6ZG6+vUe3tjjP4ZAHSz+UUy3NsJmjhGL6xsX9U+7
	suf/RITa/b70UwcglZmO5OZ3o3cEgcaG7emGBvmbcaD1rTa+xlhFrpHkYtdax0RHlX7lHi5x+Oq
	ER32dEPtdVM8yrtC4Ghvs0m7NlruRd3VesAe9
X-Gm-Gg: AYBFou0wFu1v6RkgsZmHQlHbpic4bBeLu/w+3/E2Z3/ADtBtvvmcvGmVyX2HlBNZdZY
	qZqPyYcxG9+CiCmykvlUPUK0p8QjmZ4+JuHtsp9Ra0Ppioku4DkyaqEfM0rtFxD637k8NOwOjRa
	vWn5mtezT/dRzk6GGx0mza9VN2WtBAkF/6wR2vQ0tuZJjkhNGaHuPV4AIQT+BkIIfpBcf1+qJDp
	tomgjAbyCZrRrtwmkDOHMAD8PDQXW9yoNrhQY/OULpd53EX6q5DKVoKfVpqfdvfpDhtWwcjJdDX
	cBAUzsFIDM3ROyMMYi74AWJfmvXTdaME3BZ+wBFehfMpXLTJvBTOYTprzLu+rPGnFrLpOgqfIiH
	JdB3yVMAaGRR8sjEp3im2b+syVbLYgvYkdVvc8EUU0A3bwYtDJ2VbNPg3SeSelROtb/bvxc0=
X-Received: by 2002:a17:907:f495:b0:c29:4b57:503e with SMTP id
 a640c23a62f3a-c4ca7953a29mr405328266b.1.1793444296370; Sat, 31 Oct 2026
 03:58:16 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Maholi Tumanggor <maholitumanggor@gmail.com>
Date: Sat, 31 Oct 2026 17:58:04 +0700
X-Gm-Features: AclHuK9DH_UCctbwhtp8l1cWtFttRQl0hWmXfkGoOI68eGa9m2ROh863f-sUCgU
Message-ID: <CAELScTboG_Bqn1hpM3855oYpM=io3sW-zMWs2AHkH6T0bpx7BQ@mail.gmail.com>
Subject: [SECURITY] net/ncsi: Fix heap OOB write in ncsi_rsp_handler_gp() MAC
 filter loop
To: netdev@vger.kernel.org, sam@mendozajonas.com, eajames@linux.ibm.com, 
	linux-kernel@vger.kernel.org, paulfertser@gmail.com
Content-Type: multipart/mixed; boundary="00000000000035f1cf065f20ca18"

--00000000000035f1cf065f20ca18
Content-Type: text/plain; charset="UTF-8"

Hi,

I found a heap out-of-bounds write vulnerability in the NCSI response
handler for the Get Parameters (GP) command.

== ROOT CAUSE ==

ncsi_rsp_handler_gc() allocates nc->mac_filter.addrs based on counts
from the GC response:

  size = (rsp->uc_cnt + rsp->mc_cnt + rsp->mixed_cnt) * ETH_ALEN;
  nc->mac_filter.addrs = kzalloc(size, GFP_ATOMIC);

Later, ncsi_rsp_handler_gp() loops using mac_cnt from the GP response:

  for (i = 0; i < rsp->mac_cnt; i++, pdata += 6)
      memcpy(&ncmf->addrs[i * ETH_ALEN], pdata, ETH_ALEN);

rsp->mac_cnt is a u8 read directly from a network packet (attacker-
controlled in a compromised BMC scenario). There is no check that.LKJ
mac_cnt does not exceed the count used for the original allocation.
This results in a heap buffer overflow with write data controlled by
the network packet content.

== AFFECTED FILE ==

  drivers/net/ncsi/ncsi-rsp.c, lines 886-892

== REPRODUCTION ==

Confirmed via fortify_panic() on kernel 6.8.0-147-generic
(Ubuntu 24.04, CONFIG_FORTIFY_SOURCE=y) using a kernel module that
reproduces the same allocation pattern.

Crash log excerpt:
  [  314.323325] RIP: 0010:fortify_panic+0x13/0x20
  [  314.321952] Modules linked in: ncsi_validator(OE+) ...
  [  314.206937] NCSI-VALIDATOR: VULN-1: alokasi 6 bytes, GP klaim 10
MAC (60 bytes)

== FIX ==

Add a bounds check before the MAC filter loop in ncsi_rsp_handler_gp():

--- a/drivers/net/ncsi/ncsi-rsp.c
+++ b/drivers/net/ncsi/ncsi-rsp.c
@@ -858,6 +858,17 @@ static int ncsi_rsp_handler_gp(struct ncsi_request *nr)
        if (!nc)
                return -ENODEV;

+       /* Validate mac_cnt from GP response against the buffer size
+        * allocated in ncsi_rsp_handler_gc() based on the GC response.
+        * mac_cnt is u8 from a network packet; exceeding the allocation
+        * count causes a heap buffer overflow. Also cap at 64 to prevent
+        * set_bit()/clear_bit() writing past the u64 bitmap field.
+        */
+       if (rsp->mac_cnt > nc->mac_filter.n_uc + nc->mac_filter.n_mc +
+                          nc->mac_filter.n_mixed ||
+           rsp->mac_cnt > 64) {
+               netdev_err(ndp->ndev.dev,
+                          "NCSI: GP mac_cnt %u exceeds allocated size\n",
+                          rsp->mac_cnt);
+               return -EINVAL;
+       }
+
        /* Modes with explicit enabled indications */
        if (ntohl(rsp->valid_modes) & 0x1) {

Regards,
Maholi Tumanggor

--00000000000035f1cf065f20ca18
Content-Type: text/plain; charset="US-ASCII"; name="ncsi_crash_evidence_20261031_030827.txt"
Content-Disposition: attachment; 
	filename="ncsi_crash_evidence_20261031_030827.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_mvwa267s1>
X-Attachment-Id: f_mvwa267s1

WyAgMzE0LjIwNjMwMl0gbmNzaV92YWxpZGF0b3I6IGxvYWRpbmcgb3V0LW9mLXRyZWUgbW9kdWxl
IHRhaW50cyBrZXJuZWwuClsgIDMxNC4yMDYzMjFdIG5jc2lfdmFsaWRhdG9yOiBtb2R1bGUgdmVy
aWZpY2F0aW9uIGZhaWxlZDogc2lnbmF0dXJlIGFuZC9vciByZXF1aXJlZCBrZXkgbWlzc2luZyAt
IHRhaW50aW5nIGtlcm5lbApbICAzMTQuMjA2ODUwXSBOQ1NJLVZBTElEQVRPUjogPT09IE5DU0kg
VnVsbmVyYWJpbGl0eSBWYWxpZGF0b3IgU1RBUlQgPT09ClsgIDMxNC4yMDY5MzddIE5DU0ktVkFM
SURBVE9SOiBWVUxOLTE6IGFsb2thc2kgNiBieXRlcywgR1Aga2xhaW0gMTAgTUFDICg2MCBieXRl
cykKWyAgMzE0LjIxMDU2M10gZGV0ZWN0ZWQgYnVmZmVyIG92ZXJmbG93IGluIG1lbWNweQpbICAz
MTQuMjEyMDMxXSAtLS0tLS0tLS0tLS1bIGN1dCBoZXJlIF0tLS0tLS0tLS0tLS0KWyAgMzE0LjIx
MjA0M10ga2VybmVsIEJVRyBhdCBsaWIvc3RyaW5nX2hlbHBlcnMuYzoxMDQ4IQpbICAzMTQuMjEy
MTE4XSBpbnZhbGlkIG9wY29kZTogMDAwMCBbIzFdIFBSRUVNUFQgU01QIE5PUFRJClsgIDMxNC4y
MTIxNTldIENQVTogMCBQSUQ6IDE1NTcgQ29tbTogaW5zbW9kIFRhaW50ZWQ6IEcgICAgICAgICAg
IE9FICAgICAgNi44LjAtMTQ3LWdlbmVyaWMgIzE0Ny1VYnVudHUKWyAgMzE0LjIxMjIxMV0gSGFy
ZHdhcmUgbmFtZTogaW5ub3RlayBHbWJIIFZpcnR1YWxCb3gvVmlydHVhbEJveCwgQklPUyBWaXJ0
dWFsQm94IDEyLzAxLzIwMDYKWyAgMzE0LjIxNDIyMF0gUklQOiAwMDEwOmZvcnRpZnlfcGFuaWMr
MHgxMy8weDIwClsgIDMxNC4yMTU0MjhdIENvZGU6IDAwIDY2IDBmIDFmIDQ0IDAwIDAwIDkwIDkw
IDkwIDkwIDkwIDkwIDkwIDkwIDkwIDkwIDkwIDkwIDkwIDkwIDkwIDkwIDU1IDQ4IDg5IGZlIDQ4
IGM3IGM3IGY4IGU4IGFiIDkyIDQ4IDg5IGU1IGU4IDNkIDY4IDkzIGZmIDwwZj4gMGIgOTAgNjYg
MmUgMGYgMWYgODQgMDAgMDAgMDAgMDAgMDAgOTAgOTAgOTAgOTAgOTAgOTAgOTAgOTAgOTAKWyAg
MzE0LjIxODI5M10gUlNQOiAwMDE4OmZmZmZjOWY5ODA4YWY3OTggRUZMQUdTOiAwMDAxMDI0Ngpb
ICAzMTQuMjE5NTM1XSBSQVg6IDAwMDAwMDAwMDAwMDAwMjIgUkJYOiBmZmZmZmZmZmMwYzBjMDEw
IFJDWDogMDAwMDAwMDAwMDAwMDAwMApbICAzMTQuMjIwODI0XSBSRFg6IDAwMDAwMDAwMDAwMDAw
MDAgUlNJOiAwMDAwMDAwMDAwMDAwMDAwIFJESTogMDAwMDAwMDAwMDAwMDAwMApbICAzMTQuMjIy
MDExXSBSQlA6IGZmZmZjOWY5ODA4YWY3OTggUjA4OiAwMDAwMDAwMDAwMDAwMDAwIFIwOTogMDAw
MDAwMDAwMDAwMDAwMApbICAzMTQuMjIzMTY3XSBSMTA6IDAwMDAwMDAwMDAwMDAwMDAgUjExOiAw
MDAwMDAwMDAwMDAwMDAwIFIxMjogMDAwMDAwMDAwMDAwMDAwMApbICAzMTQuMjI0NjA2XSBSMTM6
IDAwMDAwMDAwMDAwMDAwMDAgUjE0OiBmZmZmYzlmOTgwOGFmODEwIFIxNTogZmZmZmZmZmZjMGMw
ODBjMApbICAzMTQuMjI1ODI2XSBGUzogIDAwMDA3OGQ1YTY0MGYwODAoMDAwMCkgR1M6ZmZmZjg5
Y2JmZGMwMDAwMCgwMDAwKSBrbmxHUzowMDAwMDAwMDAwMDAwMDAwClsgIDMxNC4yMjcxMjNdIENT
OiAgMDAxMCBEUzogMDAwMCBFUzogMDAwMCBDUjA6IDAwMDAwMDAwODAwNTAwMzMKWyAgMzE0LjIy
ODQyN10gQ1IyOiAwMDAwNjM2NTNkMjY3Nzc4IENSMzogMDAwMDAwMDAwNDVhMDAwMCBDUjQ6IDAw
MDAwMDAwMDAwNTA2ZjAKWyAgMzE0LjIyOTYyMV0gQ2FsbCBUcmFjZToKWyAgMzE0LjIzMTA0MF0g
IDxUQVNLPgpbICAzMTQuMjMyMjUxXSAgbmNzaV92YWxpZGF0b3JfaW5pdCsweGVmLzB4ZmYwIFtu
Y3NpX3ZhbGlkYXRvcl0KWyAgMzE0LjIzMzYzOF0gIGRvX29uZV9pbml0Y2FsbCsweDVlLzB4MzQw
ClsgIDMxNC4yMzUwOTldICBkb19pbml0X21vZHVsZSsweDk3LzB4MjkwClsgIDMxNC4yMzYzMjBd
ICBsb2FkX21vZHVsZSsweGI1Zi8weGNhMApbICAzMTQuMjM3Njg4XSAgPyBzcnNvX3JldHVybl90
aHVuaysweDUvMHg1ZgpbICAzMTQuMjM5MzgzXSAgPyBzZWN1cml0eV9rZXJuZWxfcG9zdF9yZWFk
X2ZpbGUrMHg3NS8weDkwClsgIDMxNC4yNDA5MzhdICBpbml0X21vZHVsZV9mcm9tX2ZpbGUrMHg5
Ni8weDEwMApbICAzMTQuMjQyMjgwXSAgPyBpbml0X21vZHVsZV9mcm9tX2ZpbGUrMHg5Ni8weDEw
MApbICAzMTQuMjQzNjQ1XSAgaWRlbXBvdGVudF9pbml0X21vZHVsZSsweDExYy8weDMxMApbICAz
MTQuMjQ1MDQ3XSAgX194NjRfc3lzX2Zpbml0X21vZHVsZSsweDY0LzB4ZDAKWyAgMzE0LjI0NjIx
NF0gIHg2NF9zeXNfY2FsbCsweDIwMTkvMHgyNWEwClsgIDMxNC4yNDc2MTBdICBkb19zeXNjYWxs
XzY0KzB4ODcvMHgxODAKWyAgMzE0LjI0OTIwNV0gID8gc3Jzb19yZXR1cm5fdGh1bmsrMHg1LzB4
NWYKWyAgMzE0LjI1MDQ5NV0gID8gZXh0NF9sbHNlZWsrMHhjMy8weDEzMApbICAzMTQuMjUxNzk2
XSAgPyBzcnNvX3JldHVybl90aHVuaysweDUvMHg1ZgpbICAzMTQuMjUzMjQ0XSAgPyBrc3lzX2xz
ZWVrKzB4ODAvMHhkMApbICAzMTQuMjU0NjE2XSAgPyBzcnNvX3JldHVybl90aHVuaysweDUvMHg1
ZgpbICAzMTQuMjU1ODkxXSAgPyBhcmNoX2V4aXRfdG9fdXNlcl9tb2RlX3ByZXBhcmUuaXNyYS4w
KzB4MWEvMHhlMApbICAzMTQuMjU3MjAxXSAgPyBzcnNvX3JldHVybl90aHVuaysweDUvMHg1Zgpb
ICAzMTQuMjU4NDk2XSAgPyBzeXNjYWxsX2V4aXRfdG9fdXNlcl9tb2RlKzB4NDMvMHgxZTAKWyAg
MzE0LjI2MDI5N10gID8gc3Jzb19yZXR1cm5fdGh1bmsrMHg1LzB4NWYKWyAgMzE0LjI2MTYxOV0g
ID8gZG9fc3lzY2FsbF82NCsweDk0LzB4MTgwClsgIDMxNC4yNjI5MDNdICA/IHNyc29fcmV0dXJu
X3RodW5rKzB4NS8weDVmClsgIDMxNC4yNjQzNzFdICA/IHZmc19yZWFkKzB4Mjc4LzB4M2EwClsg
IDMxNC4yNjU3NTRdICA/IHNyc29fcmV0dXJuX3RodW5rKzB4NS8weDVmClsgIDMxNC4yNjY5NzRd
ICA/IGtzeXNfcmVhZCsweDczLzB4MTAwClsgIDMxNC4yNjgxOTldICA/IHNyc29fcmV0dXJuX3Ro
dW5rKzB4NS8weDVmClsgIDMxNC4yNjk0NDJdICA/IGFyY2hfZXhpdF90b191c2VyX21vZGVfcHJl
cGFyZS5pc3JhLjArMHgxYS8weGUwClsgIDMxNC4yNzA5OTBdICA/IHNyc29fcmV0dXJuX3RodW5r
KzB4NS8weDVmClsgIDMxNC4yNzIzMjBdICA/IHN5c2NhbGxfZXhpdF90b191c2VyX21vZGUrMHg0
My8weDFlMApbICAzMTQuMjczNjUxXSAgPyBzcnNvX3JldHVybl90aHVuaysweDUvMHg1ZgpbICAz
MTQuMjc1MjczXSAgPyBkb19zeXNjYWxsXzY0KzB4OTQvMHgxODAKWyAgMzE0LjI3NjQ0N10gID8g
c3Jzb19yZXR1cm5fdGh1bmsrMHg1LzB4NWYKWyAgMzE0LjI3Nzg2Nl0gID8gX19kb19zeXNfbmV3
ZnN0YXRhdCsweDUzLzB4OTAKWyAgMzE0LjI3OTE0OV0gID8gc3Jzb19yZXR1cm5fdGh1bmsrMHg1
LzB4NWYKWyAgMzE0LjI4MDYxMF0gID8gYXJjaF9leGl0X3RvX3VzZXJfbW9kZV9wcmVwYXJlLmlz
cmEuMCsweDFhLzB4ZTAKWyAgMzE0LjI4MTgyOV0gID8gc3Jzb19yZXR1cm5fdGh1bmsrMHg1LzB4
NWYKWyAgMzE0LjI4Mjk1Nl0gID8gc3lzY2FsbF9leGl0X3RvX3VzZXJfbW9kZSsweDQzLzB4MWUw
ClsgIDMxNC4yODQzMjddICA/IHNyc29fcmV0dXJuX3RodW5rKzB4NS8weDVmClsgIDMxNC4yODU4
NzJdICA/IGRvX3N5c2NhbGxfNjQrMHg5NC8weDE4MApbICAzMTQuMjg3MDQwXSAgPyBzcnNvX3Jl
dHVybl90aHVuaysweDUvMHg1ZgpbICAzMTQuMjg4Mjk2XSAgPyBhcmNoX2V4aXRfdG9fdXNlcl9t
b2RlX3ByZXBhcmUuaXNyYS4wKzB4MWEvMHhlMApbICAzMTQuMjg5NTUxXSAgPyBzcnNvX3JldHVy
bl90aHVuaysweDUvMHg1ZgpbICAzMTQuMjkwNjk3XSAgPyBpcnFlbnRyeV9leGl0X3RvX3VzZXJf
bW9kZSsweDM4LzB4MWUwClsgIDMxNC4yOTE4NjVdICA/IHNyc29fcmV0dXJuX3RodW5rKzB4NS8w
eDVmClsgIDMxNC4yOTMxMjJdICA/IGlycWVudHJ5X2V4aXQrMHg0My8weDUwClsgIDMxNC4yOTQz
NTddICA/IHNyc29fcmV0dXJuX3RodW5rKzB4NS8weDVmClsgIDMxNC4yOTYxNTBdICA/IGV4Y19w
YWdlX2ZhdWx0KzB4OTQvMHgxYjAKWyAgMzE0LjI5NzI5MF0gIGVudHJ5X1NZU0NBTExfNjRfYWZ0
ZXJfaHdmcmFtZSsweDc4LzB4ODAKWyAgMzE0LjI5ODQ4MV0gUklQOiAwMDMzOjB4NzhkNWE1YjI3
NTJkClsgIDMxNC4zMDAwMThdIENvZGU6IGZmIGMzIDY2IDJlIDBmIDFmIDg0IDAwIDAwIDAwIDAw
IDAwIDkwIGYzIDBmIDFlIGZhIDQ4IDg5IGY4IDQ4IDg5IGY3IDQ4IDg5IGQ2IDQ4IDg5IGNhIDRk
IDg5IGMyIDRkIDg5IGM4IDRjIDhiIDRjIDI0IDA4IDBmIDA1IDw0OD4gM2QgMDEgZjAgZmYgZmYg
NzMgMDEgYzMgNDggOGIgMGQgYmIgYzggMGQgMDAgZjcgZDggNjQgODkgMDEgNDgKWyAgMzE0LjMw
NDE4N10gUlNQOiAwMDJiOjAwMDA3ZmZmMWFlMDdmNTggRUZMQUdTOiAwMDAwMDI0NiBPUklHX1JB
WDogMDAwMDAwMDAwMDAwMDEzOQpbICAzMTQuMzA1NDQ3XSBSQVg6IGZmZmZmZmZmZmZmZmZmZGEg
UkJYOiAwMDAwNjM2NTNkMjYzNzQwIFJDWDogMDAwMDc4ZDVhNWIyNzUyZApbICAzMTQuMzA2NzAz
XSBSRFg6IDAwMDAwMDAwMDAwMDAwMDAgUlNJOiAwMDAwNjM2NTFiODAwZTUyIFJESTogMDAwMDAw
MDAwMDAwMDAwMwpbICAzMTQuMzA3NzUwXSBSQlA6IDAwMDA3ZmZmMWFlMDgwMTAgUjA4OiAwMDAw
MDAwMDAwMDAwMDQwIFIwOTogMDAwMDYzNjUxYjgwMTBiMApbICAzMTQuMzA4OTk4XSBSMTA6IDAw
MDA3OGQ1YTVjMDRiMjAgUjExOiAwMDAwMDAwMDAwMDAwMjQ2IFIxMjogMDAwMDYzNjUxYjgwMGU1
MgpbICAzMTQuMzEwMzc3XSBSMTM6IDAwMDAwMDAwMDAwMDAwMDAgUjE0OiAwMDAwNjM2NTNkMjYz
NzAwIFIxNTogMDAwMDAwMDAwMDAwMDAwMApbICAzMTQuMzExNTc2XSAgPC9UQVNLPgpbICAzMTQu
MzEyNzkwXSBNb2R1bGVzIGxpbmtlZCBpbjogbmNzaV92YWxpZGF0b3IoT0UrKSBpbnRlbF9yYXBs
X21zciBzbmRfaW50ZWw4eDAgc25kX2FjOTdfY29kZWMgYWM5N19idXMgaW50ZWxfcmFwbF9jb21t
b24gc25kX3BjbSBzbmRfdGltZXIgdm13Z2Z4IGRybV90dG1faGVscGVyIGkyY19waWl4NCBzbmQg
dHRtIHNvdW5kY29yZSBxcnRyIHZib3hndWVzdCBqb3lkZXYgaW5wdXRfbGVkcyBtYWNfaGlkIHNl
cmlvX3JhdyBjZmc4MDIxMSBiaW5mbXRfbWlzYyBzY2hfZnFfY29kZWwgZG1fbXVsdGlwYXRoIG1z
ciBlZmlfcHN0b3JlIG5mbmV0bGluayBkbWlfc3lzZnMgaXBfdGFibGVzIHhfdGFibGVzIGF1dG9m
czQgYnRyZnMgYmxha2UyYl9nZW5lcmljIHJhaWQxMCByYWlkNDU2IGFzeW5jX3JhaWQ2X3JlY292
IGFzeW5jX21lbWNweSBhc3luY19wcSBhc3luY194b3IgYXN5bmNfdHggeG9yIHJhaWQ2X3BxIGxp
YmNyYzMyYyByYWlkMSByYWlkMCBjcmN0MTBkaWZfcGNsbXVsIGNyYzMyX3BjbG11bCBwb2x5dmFs
X2NsbXVsbmkgaGlkX2dlbmVyaWMgYWhjaSBwb2x5dmFsX2dlbmVyaWMgZ2hhc2hfY2xtdWxuaV9p
bnRlbCB1c2JoaWQgaGlkIHNoYTI1Nl9zc3NlMyBlMTAwMCB2Z2ExNmZiIGxpYmFoY2kgdmdhc3Rh
dGUgc2hhMV9zc3NlMyBwc21vdXNlIHBhdGFfYWNwaSB2aWRlbyB3bWkgYWVzbmlfaW50ZWwgY3J5
cHRvX3NpbWQgY3J5cHRkClsgIDMxNC4zMjE5NTJdIC0tLVsgZW5kIHRyYWNlIDAwMDAwMDAwMDAw
MDAwMDAgXS0tLQpbICAzMTQuMzIzMzI1XSBSSVA6IDAwMTA6Zm9ydGlmeV9wYW5pYysweDEzLzB4
MjAKWyAgMzE0LjMyNDg0MF0gQ29kZTogMDAgNjYgMGYgMWYgNDQgMDAgMDAgOTAgOTAgOTAgOTAg
OTAgOTAgOTAgOTAgOTAgOTAgOTAgOTAgOTAgOTAgOTAgOTAgNTUgNDggODkgZmUgNDggYzcgYzcg
ZjggZTggYWIgOTIgNDggODkgZTUgZTggM2QgNjggOTMgZmYgPDBmPiAwYiA5MCA2NiAyZSAwZiAx
ZiA4NCAwMCAwMCAwMCAwMCAwMCA5MCA5MCA5MCA5MCA5MCA5MCA5MCA5MCA5MApbICAzMTQuMzI3
OTgwXSBSU1A6IDAwMTg6ZmZmZmM5Zjk4MDhhZjc5OCBFRkxBR1M6IDAwMDEwMjQ2ClsgIDMxNC4z
Mjk2NDJdIFJBWDogMDAwMDAwMDAwMDAwMDAyMiBSQlg6IGZmZmZmZmZmYzBjMGMwMTAgUkNYOiAw
MDAwMDAwMDAwMDAwMDAwClsgIDMxNC4zMzE0MTZdIFJEWDogMDAwMDAwMDAwMDAwMDAwMCBSU0k6
IDAwMDAwMDAwMDAwMDAwMDAgUkRJOiAwMDAwMDAwMDAwMDAwMDAwClsgIDMxNC4zMzcxNjZdIFJC
UDogZmZmZmM5Zjk4MDhhZjc5OCBSMDg6IDAwMDAwMDAwMDAwMDAwMDAgUjA5OiAwMDAwMDAwMDAw
MDAwMDAwClsgIDMxNC4zMzg3MDVdIFIxMDogMDAwMDAwMDAwMDAwMDAwMCBSMTE6IDAwMDAwMDAw
MDAwMDAwMDAgUjEyOiAwMDAwMDAwMDAwMDAwMDAwClsgIDMxNC4zNDA0MjJdIFIxMzogMDAwMDAw
MDAwMDAwMDAwMCBSMTQ6IGZmZmZjOWY5ODA4YWY4MTAgUjE1OiBmZmZmZmZmZmMwYzA4MGMwClsg
IDMxNC4zNDIwNTddIEZTOiAgMDAwMDc4ZDVhNjQwZjA4MCgwMDAwKSBHUzpmZmZmODljYmZkYzAw
MDAwKDAwMDApIGtubEdTOjAwMDAwMDAwMDAwMDAwMDAKWyAgMzE0LjM0ODA4N10gQ1M6ICAwMDEw
IERTOiAwMDAwIEVTOiAwMDAwIENSMDogMDAwMDAwMDA4MDA1MDAzMwpbICAzMTQuMzQ5ODM3XSBD
UjI6IDAwMDA2MzY1M2QyNjc3NzggQ1IzOiAwMDAwMDAwMDA0NWEwMDAwIENSNDogMDAwMDAwMDAw
MDA1MDZmMApbICAzNTYuNjkwMDM3XSB3b3JrcXVldWU6IGRybV9mYl9oZWxwZXJfZGFtYWdlX3dv
cmsgaG9nZ2VkIENQVSBmb3IgPjEwMDAwdXMgMzIgdGltZXMsIGNvbnNpZGVyIHN3aXRjaGluZyB0
byBXUV9VTkJPVU5ECg==
--00000000000035f1cf065f20ca18
Content-Type: application/octet-stream; 
	name="0001-ncsi-fix-mac-oob-write-in-gp-handler.patch"
Content-Disposition: attachment; 
	filename="0001-ncsi-fix-mac-oob-write-in-gp-handler.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mvwaashm1>
X-Attachment-Id: f_mvwaashm1

RnJvbSAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNYWhvbGkgVHVtYW5nZ29yIDxtYWhvbGl0dW1hbmdnb3JAZ21h
aWwuY29tPgpEYXRlOiBGcmksIDMxIE9jdCAyMDI2IDAwOjAwOjAwICswMDAwClN1YmplY3Q6IFtQ
QVRDSF0gbmV0L25jc2k6IEZpeCBoZWFwIE9PQiB3cml0ZSBpbiBuY3NpX3JzcF9oYW5kbGVyX2dw
KCkKCm5jc2lfcnNwX2hhbmRsZXJfZ2MoKSBhbGxvY2F0ZXMgbmMtPm1hY19maWx0ZXIuYWRkcnMg
YmFzZWQgb24gdGhlCk1BQyBhZGRyZXNzIGNvdW50cyBmcm9tIHRoZSBHQyByZXNwb25zZToKCiAg
c2l6ZSA9IChyc3AtPnVjX2NudCArIHJzcC0+bWNfY250ICsgcnNwLT5taXhlZF9jbnQpICogRVRI
X0FMRU47CiAgbmMtPm1hY19maWx0ZXIuYWRkcnMgPSBremFsbG9jKHNpemUsIEdGUF9BVE9NSUMp
OwoKTGF0ZXIsIG5jc2lfcnNwX2hhbmRsZXJfZ3AoKSBsb29wcyB1c2luZyBtYWNfY250IGZyb20g
dGhlIEdQIHJlc3BvbnNlCnBhY2tldCB3aXRoIG5vIGJvdW5kcyBjaGVjazoKCiAgZm9yIChpID0g
MDsgaSA8IHJzcC0+bWFjX2NudDsgaSsrLCBwZGF0YSArPSA2KQogICAgICBtZW1jcHkoJm5jbWYt
PmFkZHJzW2kgKiBFVEhfQUxFTl0sIHBkYXRhLCBFVEhfQUxFTik7Cgpyc3AtPm1hY19jbnQgaXMg
YSB1OCByZWFkIGRpcmVjdGx5IGZyb20gYSBuZXR3b3JrIHBhY2tldC4gSWYgdGhlIEdQCnJlc3Bv
bnNlIGNsYWltcyBhIG1hY19jbnQgbGFyZ2VyIHRoYW4gdGhlIGNvdW50IHVzZWQgaW4gdGhlIEdD
CnJlc3BvbnNlLCB0aGUgbWVtY3B5KCkgd3JpdGVzIHBhc3QgdGhlIGVuZCBvZiB0aGUgYWxsb2Nh
dGVkIGJ1ZmZlciwKY2F1c2luZyBhIGhlYXAgb3V0LW9mLWJvdW5kcyB3cml0ZS4KCkFkZGl0aW9u
YWxseSwgbWFjX2NudCBjYW4gZXhjZWVkIDY0LCBjYXVzaW5nIHNldF9iaXQoKS9jbGVhcl9iaXQo
KQp0byB3cml0ZSBwYXN0IHRoZSA2NC1iaXQgbmMtPm1hY19maWx0ZXIuYml0bWFwIGZpZWxkLCBh
bmQgdGhlIHNoaWZ0CmV4cHJlc3Npb24gKDB4MSA8PCBpKSBpcyB1bmRlZmluZWQgYmVoYXZpb3Vy
IGluIEMgd2hlbiBpID49IDMyLgoKQ29uZmlybWVkIHZpYSBmb3J0aWZ5X3BhbmljKCkgb24ga2Vy
bmVsIDYuOC4wLTE0Ny1nZW5lcmljCihVYnVudHUgMjQuMDQsIENPTkZJR19GT1JUSUZZX1NPVVJD
RT15KS4KClJlcG9ydGVkLWJ5OiBNYWhvbGkgVHVtYW5nZ29yIDxtYWhvbGl0dW1hbmdnb3JAZ21h
aWwuY29tPgpTaWduZWQtb2ZmLWJ5OiBNYWhvbGkgVHVtYW5nZ29yIDxtYWhvbGl0dW1hbmdnb3JA
Z21haWwuY29tPgotLS0KIG5ldC9uY3NpL25jc2ktcnNwLmMgfCAyMCArKysrKysrKysrKysrKysr
KysrKwogMSBmaWxlIGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9uZXQv
bmNzaS9uY3NpLXJzcC5jIGIvbmV0L25jc2kvbmNzaS1yc3AuYwppbmRleCB4eHh4eHh4Li54eHh4
eHh4IDEwMDY0NAotLS0gYS9uZXQvbmNzaS9uY3NpLXJzcC5jCisrKyBiL25ldC9uY3NpL25jc2kt
cnNwLmMKQEAgLTg1OSw2ICs4NTksMjYgQEAgc3RhdGljIGludCBuY3NpX3JzcF9oYW5kbGVyX2dw
KHN0cnVjdCBuY3NpX3JlcXVlc3QgKm5yKQogCWlmICghbmMpCiAJCXJldHVybiAtRU5PREVWOwog
CisJLyogVmFsaWRhdGUgbWFjX2NudCBmcm9tIHRoZSBHUCByZXNwb25zZSBwYWNrZXQgYWdhaW5z
dCB0aGUgYnVmZmVyCisJICogc2l6ZSBhbGxvY2F0ZWQgaW4gbmNzaV9yc3BfaGFuZGxlcl9nYygp
IGJhc2VkIG9uIHRoZSBHQyByZXNwb25zZS4KKwkgKgorCSAqIG1hY19jbnQgaXMgYSB1OCByZWFk
IGZyb20gYSBuZXR3b3JrIHBhY2tldC4gV2l0aG91dCB0aGlzIGNoZWNrLAorCSAqIGEgR1AgcmVz
cG9uc2Ugd2l0aCBtYWNfY250IGdyZWF0ZXIgdGhhbiBuX3VjK25fbWMrbl9taXhlZCBjYXVzZXMK
KwkgKiBtZW1jcHkoKSB0byB3cml0ZSBwYXN0IHRoZSBlbmQgb2YgbmMtPm1hY19maWx0ZXIuYWRk
cnMuCisJICoKKwkgKiBBbHNvIGNhcCBhdCA2NDogc2V0X2JpdCgpL2NsZWFyX2JpdCgpIG9uIHRo
ZSB1NjQgYml0bWFwIGZpZWxkCisJICogd3JpdGUgb3V0IG9mIGJvdW5kcyB3aGVuIGkgPj0gNjQs
IGFuZCAoMHgxIDw8IGkpIGlzIHVuZGVmaW5lZAorCSAqIGJlaGF2aW91ciBpbiBDIHdoZW4gaSA+
PSAzMi4KKwkgKi8KKwlpZiAocnNwLT5tYWNfY250ID4gbmMtPm1hY19maWx0ZXIubl91YyArIG5j
LT5tYWNfZmlsdGVyLm5fbWMgKworCQkJICAgbmMtPm1hY19maWx0ZXIubl9taXhlZCkgeworCQlu
ZXRkZXZfZXJyKG5kcC0+bmRldi5kZXYsCisJCQkgICAiTkNTSTogR1AgbWFjX2NudCAoJXUpIGV4
Y2VlZHMgR0MgYWxsb2NhdGlvbiAiCisJCQkgICAiKCV1IHVjICsgJXUgbWMgKyAldSBtaXhlZClc
biIsCisJCQkgICByc3AtPm1hY19jbnQsIG5jLT5tYWNfZmlsdGVyLm5fdWMsCisJCQkgICBuYy0+
bWFjX2ZpbHRlci5uX21jLCBuYy0+bWFjX2ZpbHRlci5uX21peGVkKTsKKwkJcmV0dXJuIC1FSU5W
QUw7CisJfQorCWlmIChyc3AtPm1hY19jbnQgPiA2NCkgeworCQluZXRkZXZfZXJyKG5kcC0+bmRl
di5kZXYsCisJCQkgICAiTkNTSTogR1AgbWFjX2NudCAoJXUpIGV4Y2VlZHMgYml0bWFwIHNpemUg
KDY0KVxuIiwKKwkJCSAgIHJzcC0+bWFjX2NudCk7CisJCXJldHVybiAtRUlOVkFMOworCX0KKwog
CS8qIE1vZGVzIHdpdGggZXhwbGljaXQgZW5hYmxlZCBpbmRpY2F0aW9ucyAqLwogCWlmIChudG9o
bChyc3AtPnZhbGlkX21vZGVzKSAmIDB4MSkgewkvKiBCQyBmaWx0ZXIgbW9kZSAqLwotLSAKMi40
My4wCg==
--00000000000035f1cf065f20ca18--
