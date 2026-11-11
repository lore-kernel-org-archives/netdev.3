Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=141.14.17.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794358373;
	b=10yxGaLrOse4bENdIYVnslWjWw5cxSt3gaEc1Vye7qi9pjcm2TqPlUzfQj0L0M3h8+zA
	 5gOzULZE7S1ugcJGLgSxyee4i+EBMOoXlT9FVW7bRQMcTLIDq+6eAKlHnPuWcJcB6VwFx
	 c2FopQ27SVUCpn0P5jr89i8A8htpFUSJIVXHYiuGUidT2y4f3Gy0mfHBUDk7TYfJac18A
	 9v9q8h5sGvJBL53xp5UDohi9E2weFoHPso5OdQMb7ekU7uIKeCVxooTAk/4WjJ6Mv8G1P
	 ezAI5qCYhazKswexmnmlxX5Z9vHb4UV2KdjSBqUnDUNdYPWWkYdQQJKCDEM1xphAvoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794358373;
	h=DMARC-Filter:Received:Content-Type:Message-ID:Date:MIME-Version:
	 User-Agent:Content-Language:To:Cc:From:Subject:DKIM-Signature;
	bh=QVEMt+HYEI4BVQvtwvGVs0ryoeQ+4WXnggXDfCpqQYM=;
	b=2/TvqoHMhwBMTMWB7d9/Al6/9JMqm0H1WsW4MKbCwMbxQnnJmwIDLa985t8IRQNIdTtk
	 XKbDSWeFWRm0tzDbB2j1UUQu+U8r+mDqHg+M7BEN2BcXpug4ROWLtEuKg1NAJ/IwSXuTZ
	 0NtUW70YEaXdNZHphRSajrEcGbdp7xfLeKOpYAnLOHg57k80WwWZoWjGq2mQF76B9DJLA
	 sOkj7I1Hc2gXTbldgW31FKolY3SNU9vqzo6eomkHMQQkcrF21kcf4/s12WbiCK+Yjoo4+
	 PJVQsjwDboiTFcHjfYkeQty6Haa/IKcl1mdugPcg/tC4NVu7baXuwWnseOrrNIcIa4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=molgen.mpg.de;
	spf=pass smtp.mailfrom=molgen.mpg.de;
	dkim=pass header.d=molgen.mpg.de header.i=@molgen.mpg.de header.a=rsa-sha256 header.s=20260906 header.b=EleUomX5;
	arc=none smtp.remote-ip=141.14.17.11
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECF6606A31C;
	Wed, 11 Nov 2026 00:52:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1ECF6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=molgen.mpg.de header.i=@molgen.mpg.de header.a=rsa-sha256 header.s=20260906 header.b=EleUomX5
Received: from [192.168.0.32] (ip-095-090-243-046.vkd79.pools.vodafone-ip.de [95.90.243.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 950094C2C90B4B;
	Wed, 11 Nov 2026 01:52:35 +0100 (CET)
Content-Type: multipart/mixed; boundary="------------21EOPq6sspZNCb0LjSJz0DdR"
Message-ID: <fba64030-4f1e-4158-ae39-bc072bc5751d@molgen.mpg.de>
Date: Wed, 11 Nov 2026 01:52:34 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Hayes Wang <hayeswang@realtek.com>
Cc: Chih Kai Hsu <hsu.chih.kai@realtek.com>,
 Birger Koblitz <mail@birger-koblitz.de>, netdev@vger.kernel.org,
 linux-usb@vger.kernel.org
From: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: r8152: RTL8153 never runtime suspends with link up on a network with
 broadcast traffic
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=molgen.mpg.de; s=20260906; 
	t=1794358355; 
	h=from:from:subject:date:message-id:mime-version:content-type:content-transfer-encoding; 
	bh=QVEMt+HYEI4BVQvtwvGVs0ryoeQ+4WXnggXDfCpqQYM=; 
	b=EleUomX54/L90emFdnEDx+BcdycWSJzuDmyL0UIGUkQhd09MTveJGTPsTKUeVMrpX12vItndY55u
	4Dwtzbk3q3jY+oEoyzOyLFzI8FITXkjSGkFDJUdanlxwGBx8MFeldJcWXqDiTtdhwraASUnhwYQ82x
	JI8WFCpIM+NrCKGkKrjHfWtMTCJpV6fi1EKQjBQ7NJIMOlsRa0OgjFQZnsL1e62BsgCoJOUwchMENw
	qK0ZBZ+MGTan3xp7AbvS78hB1at++5tYUiCw7k8eZukANaHwZz8fmemON/NKAGfZskWtmO6VWwggmf
	7BeYrcZYtwBtnC612QEqMz4CWTMv8E1g==

This is a multi-part message in MIME format.
--------------21EOPq6sspZNCb0LjSJz0DdR
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Hayes, dear Linux folks,


On a Dell XPS 13 9310 with a VIA Labs USB-C hub plugged in that has an 
RTL8153 (0bda:8153, bcdDevice 30.00, firmware rtl8153a-4 v3 06/12/25), 
the adapter never runtime suspends while the link is up, even with 
power/control set to auto. The hub and the Thunderbolt xHCI controller 
00:0d.0 therefore stay in D0, and the package does not go deeper than 
PC8. I would like to ask how you would want this solved before sending a 
patch.

AI disclaimer: claude-fable-5.2 analyzed and measured this on the laptop 
and drafted this message; I reviewed it.

With Linux 7.3.3 (Debian 7.3.3-1), link up at 1000 Mb/s, 
power/control=auto and autosuspend_delay_ms=2000, 60 s apart:

     2-1.1.3: active susp=0 act=140886
     2-1.1.3: active susp=0 act=201150

     $ sudo turbostat --quiet --Summary --show 
Pkg%pc2,Pkg%pc3,Pkg%pc8,Pkg%pc9,Pk%pc10,SYS%LPI,PkgWatt --interval 30 
--num_iterations 1
     Pkg%pc2 Pkg%pc3 Pkg%pc8 Pkg%pc9 Pk%pc10 SYS%LPI PkgWatt
       14.26    9.19   71.33    0.00    0.00    0.00    0.84

The cause is traffic that is not addressed to the station. In a 30 s 
capture of inbound frames on our institute network, 816 of 824 frames 
are broadcast (688, mostly ARP) or multicast (128), and 7 are addressed 
to the station. read_bulk_callback() calls usb_mark_last_busy() for 
every completed receive URB, so the autosuspend delay never elapses. If 
the device did suspend, rtl_runtime_suspend_enable() arms WAKE_ANY, so 
the next broadcast frame would wake it again.

As an experiment, I added a module parameter (patch attached, against 
Linus’ master fa4ad798f6f6; tested as an out-of-tree build of the v7.3.3 
driver). When set, only frames with a unicast destination address call 
usb_mark_last_busy(), and runtime suspend arms WAKE_PHY | WAKE_MAGIC | 
WAKE_UCAST instead of WAKE_ANY. With it, the adapter is suspended for 
27.5 s of a 30 s interval:

     2-1.1.3: suspended susp=130671 act=534403
     2-1.1.3: suspended susp=158210 act=536981

and, with runtime PM also enabled for the other devices in the hub, the 
xHCI controller reaches D3 and the package PC10:

     Pkg%pc2 Pkg%pc3 Pkg%pc8 Pkg%pc9 Pk%pc10 SYS%LPI PkgWatt
       13.40    7.53   15.40    1.39   59.08   56.32    0.84

A ping from another subnet still wakes the device. In three attempts, 
the first echo request was answered once, after 78 ms, and lost twice.

The experiment has an obvious cost: broadcast and multicast frames are 
lost while the device is suspended. That includes ARP requests and IPv6 
neighbour solicitations for the station’s own addresses, so a peer 
without a neighbour entry cannot reach the station until it transmits or 
receives a unicast frame.

My questions:

1.  Do the RTL8153 and its successors support ARP and neighbour 
solicitation offload, or wake patterns, while selectively suspended? 
With that, the driver could program the addresses of the interface 
before suspending and keep answering for them, similar to what Wi-Fi 
drivers do with the ARP address list from mac80211. No new switch and no 
loss of reachability would be needed. If the hardware can do it, could 
Realtek add it or share the register description?

2.  If the hardware cannot do it, would you accept a per-device switch 
for the behaviour of the experiment, off by default? A module parameter 
is surely the wrong interface. A private flag (ethtool --set-priv-flags) 
would need no new uAPI, and userspace that knows the network 
configuration (systemd-udevd .link files, NetworkManager) could set it. 
Or do you see a generic interface for a "runtime wake filter", as other 
drivers that runtime suspend with the link up would have the same problem?

3.  Is losing the first frame that wakes the device expected, or should 
it be delivered after the resume?

4.  Is power/control=on by default intended for these adapters? I did 
not find 0bda:8153 in the autosuspend lists of systemd’s hwdb [1] either.


Kind regards,

Paul


[1]: https://github.com/systemd/systemd/tree/main/hwdb.d
--------------21EOPq6sspZNCb0LjSJz0DdR
Content-Type: text/x-patch; charset=UTF-8;
 name="r8152-runtime-suspend-broadcast.diff"
Content-Disposition: attachment;
 filename="r8152-runtime-suspend-broadcast.diff"
Content-Transfer-Encoding: base64

LS0tCiBkcml2ZXJzL25ldC91c2IvcjgxNTIuYyB8IDIyICsrKysrKysrKysrKysrKysrKysr
LS0KIDEgZmlsZSBjaGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoK
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3VzYi9yODE1Mi5jIGIvZHJpdmVycy9uZXQvdXNi
L3I4MTUyLmMKaW5kZXggZDNiYjdlZTljOWJmMy4uMzljNTg2ZGM3ZDBjZiAxMDA2NDQKLS0t
IGEvZHJpdmVycy9uZXQvdXNiL3I4MTUyLmMKKysrIGIvZHJpdmVycy9uZXQvdXNiL3I4MTUy
LmMKQEAgLTgwMiw2ICs4MDIsMTcgQEAgZW51bSBydGw4MTUyX2ZsYWdzIHsKICNkZWZpbmUg
REVWSUNFX0lEX1RISU5LUEFEX1VTQl9DX0RPQ0tfR0VOMwkJMHgzMDYyCiAjZGVmaW5lIERF
VklDRV9JRF9USElOS1BBRF9IWUJSSURfVVNCX0NfRE9DSwkJMHhhMzU5CiAKKy8qIFdoaWxl
IHJ1bnRpbWUgc3VzcGVuZGVkLCB3YWtlIG9ubHkgZm9yIGxpbmsgY2hhbmdlcywgbWFnaWMg
cGFja2V0cyBhbmQKKyAqIGZyYW1lcyBhZGRyZXNzZWQgdG8gdGhpcyBzdGF0aW9uLiBCcm9h
ZGNhc3QgYW5kIG11bHRpY2FzdCBmcmFtZXMgdGhlbgorICogbmVpdGhlciB3YWtlIHRoZSBk
ZXZpY2Ugbm9yIHBvc3Rwb25lIGF1dG9zdXNwZW5kLCBzbyB0aGV5IGFyZSBsb3N0IHdoaWxl
CisgKiB0aGUgZGV2aWNlIGlzIHN1c3BlbmRlZCwgaW5jbHVkaW5nIEFSUCByZXF1ZXN0cyBh
bmQgSVB2NiBuZWlnaGJvdXIKKyAqIHNvbGljaXRhdGlvbnMgZm9yIHRoZSBhZGRyZXNzZXMg
b2YgdGhpcyBzdGF0aW9uLgorICovCitzdGF0aWMgYm9vbCBydW50aW1lX3dha2VfdW5pY2Fz
dF9vbmx5OworbW9kdWxlX3BhcmFtKHJ1bnRpbWVfd2FrZV91bmljYXN0X29ubHksIGJvb2ws
IDA2NDQpOworTU9EVUxFX1BBUk1fREVTQyhydW50aW1lX3dha2VfdW5pY2FzdF9vbmx5LAor
CQkgIklnbm9yZSBicm9hZGNhc3QgYW5kIG11bHRpY2FzdCBmcmFtZXMgZm9yIHJ1bnRpbWUg
UE0gKGRlZmF1bHQ6IE4pIik7CisKIHN0cnVjdCB0YWxseV9jb3VudGVyIHsKIAlfX2xlNjQJ
dHhfcGFja2V0czsKIAlfX2xlNjQJcnhfcGFja2V0czsKQEAgLTIxOTIsNyArMjIwMyw4IEBA
IHN0YXRpYyB2b2lkIHJlYWRfYnVsa19jYWxsYmFjayhzdHJ1Y3QgdXJiICp1cmIpCiAJaWYg
KCFuZXRpZl9jYXJyaWVyX29rKG5ldGRldikpCiAJCXJldHVybjsKIAotCXVzYl9tYXJrX2xh
c3RfYnVzeSh0cC0+dWRldik7CisJaWYgKCFydW50aW1lX3dha2VfdW5pY2FzdF9vbmx5KQor
CQl1c2JfbWFya19sYXN0X2J1c3kodHAtPnVkZXYpOwogCiAJc3dpdGNoIChzdGF0dXMpIHsK
IAljYXNlIDA6CkBAIC0zMDY4LDYgKzMwODAsMTAgQEAgc3RhdGljIGludCByeF9ib3R0b20o
c3RydWN0IHI4MTUyICp0cCwgaW50IGJ1ZGdldCkKIAkJCXNrYi0+aXBfc3VtbWVkID0gdHAt
PmRlc2Nfb3BzLnJ4X2NzdW0odHAsIHJ4X2Rlc2MpOwogCQkJdHAtPnJ4X2Rlc2Mudmxhbl90
YWcocnhfZGVzYywgc2tiKTsKIAorCQkJaWYgKHJ1bnRpbWVfd2FrZV91bmljYXN0X29ubHkg
JiYKKwkJCSAgICAhaXNfbXVsdGljYXN0X2V0aGVyX2FkZHIocnhfZGF0YSkpCisJCQkJdXNi
X21hcmtfbGFzdF9idXN5KHRwLT51ZGV2KTsKKwogCQkJaWYgKHVzZV9mcmFncykgewogCQkJ
CWlmIChyeF9mcmFnX2hlYWRfc3opIHsKIAkJCQkJbWVtY3B5KHNrYi0+ZGF0YSwgcnhfZGF0
YSwKQEAgLTM4NDEsNiArMzg1Nyw3IEBAIHN0YXRpYyBpbnQgcnRsODE1Ml9zZXRfZmVhdHVy
ZXMoc3RydWN0IG5ldF9kZXZpY2UgKmRldiwKIH0KIAogI2RlZmluZSBXQUtFX0FOWSAoV0FL
RV9QSFkgfCBXQUtFX01BR0lDIHwgV0FLRV9VQ0FTVCB8IFdBS0VfQkNBU1QgfCBXQUtFX01D
QVNUKQorI2RlZmluZSBXQUtFX1JVTlRJTUVfVU5JQ0FTVCAoV0FLRV9QSFkgfCBXQUtFX01B
R0lDIHwgV0FLRV9VQ0FTVCkKIAogc3RhdGljIHUzMiBfX3J0bF9nZXRfd29sKHN0cnVjdCBy
ODE1MiAqdHApCiB7CkBAIC00MzQ2LDcgKzQzNjMsOCBAQCBzdGF0aWMgYm9vbCBydGxfY2Fu
X3dha2V1cChzdHJ1Y3QgcjgxNTIgKnRwKQogc3RhdGljIHZvaWQgcnRsX3J1bnRpbWVfc3Vz
cGVuZF9lbmFibGUoc3RydWN0IHI4MTUyICp0cCwgYm9vbCBlbmFibGUpCiB7CiAJaWYgKGVu
YWJsZSkgewotCQlfX3J0bF9zZXRfd29sKHRwLCBXQUtFX0FOWSk7CisJCV9fcnRsX3NldF93
b2wodHAsIHJ1bnRpbWVfd2FrZV91bmljYXN0X29ubHkgPworCQkJICAgICAgV0FLRV9SVU5U
SU1FX1VOSUNBU1QgOiBXQUtFX0FOWSk7CiAKIAkJb2NwX3dyaXRlX2J5dGUodHAsIE1DVV9U
WVBFX1BMQSwgUExBX0NSV0VDUiwgQ1JXRUNSX0NPTkZJRyk7CiAK

--------------21EOPq6sspZNCb0LjSJz0DdR--
