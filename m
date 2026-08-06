Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CF94D98E6
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 20:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786047369; cv=none; b=iFghS8VSr5EDIWBAEHYNubeM7TD79hKP66QThN4TtirMm1l7VDUHavnQBdloj3SmW9qCZG9hQ3hRK4UlSNPkWL0EePmteDgnllbxMnqY1Lki8v/ruq86P5UAnZ1Q9lHXwSYnjc7x8bCaWbdIsz9rwYz898S8iEc5px76j4Bl9Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786047369; c=relaxed/simple;
	bh=GZI4nrYHNq8Xa4aRpiyvrzhAYyI/ftmTidL+RQlR/B4=;
	h=Message-ID:Date:MIME-Version:Subject:References:To:Cc:From:
	 In-Reply-To:Content-Type; b=tLhdm7oy1BWHfF0I3ehHFB8gW8aq/njk4J/Wd/BfcltONG/2AF5KtFBUlLs3rb3Fj6XJ1E3DauSCl1hn1OgETh/32cdS5pQta4Cot0ETUbsqeZE+I27v5leGvHCiKSHRbWXcJihsA9sAck6aNqdckolb0azWPklnrYOJ5clc2cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qb+t+DmV; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qb+t+DmV"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51bfad59921so18255521cf.0
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 13:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786047342; x=1786652142; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:cc:to
         :references:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=YYcgAl66uCabfKg5ySkcUCcPjzhlRyzOokGNje49xxc=;
        b=Qb+t+DmVYimGAMPn5FuES+mWbQeZcj5gwYA8RDwlnBrCt6sqZgpxyyrpTHn82TPv46
         MW+omIZIc4D8b+fNRJt4xYpoac/LSZ1kTaccwJMP7fKEtfRvYqTvPV/C+nhD4Sf/J+w2
         f3VZn+poq4mXXmoSQbBfH1fwSdkPc0JyseFW1Bm0Jc1hKw/kPnOVGTvpqqnJ7lc1YlNQ
         WsK89snkI+y+eAbSUvI9Vlc4YGOjxb97qGGfT9Ysopz5A3IJFsePlXZUS+UiSI466ViF
         BBm4fhZzlUlVggkYqks7XGlHx59qdzIwnYl3KX1TxPiRNnExfJ50+QBDdhvkvDTdDru1
         lYjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786047342; x=1786652142;
        h=content-transfer-encoding:content-type:in-reply-to:from:cc:to
         :references:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YYcgAl66uCabfKg5ySkcUCcPjzhlRyzOokGNje49xxc=;
        b=bUQLwXyxFdF5km6/Pd2LX075vZmR0vBoS0nNUo5BQ7fMX3Pn8dlu8PDjkblkff8q3i
         5WJVTglJLNDPQP//ofGn8PN4LkKESffqGY/yn+NSU5lulGtSZyjd7UB3mfocZinL48a5
         TXtXyQBrUtnGkUlKJ0C5japGO6WbNzEWG+0lT0xcfRPS/N4O8FoMyU+YLILJ/m1rvZLt
         YV1wnb37OOOd5d9kOj6xDBAwBIaFjjSJdFcu35jcoluounZbzDvAa2qUGWxIckKjBpMq
         MG12ksq2rnA+zsX4I1AWgAi/zxjd5g1JfIbVBSFtEoXrrzDWuy2b8EojbUFOL49G11rW
         jEzQ==
X-Gm-Message-State: AOJu0YwegMoR3kxKfQHRKHyw90D1BNyKaOK9oiHkTyxfdAqX8VvZzTyv
	l4c6jBjMxGEZs5psurnYtD3NmSXf4M2Xw1yue3CS22nRU7dE0cVE3uKd52bMebx8
X-Gm-Gg: AR+sD10XlqtdyLbDTywbmWknVO+vUPB8UYB/DEIYa7qVSbgqCWgBQhDe/U6Fq8XbYVO
	2+DFHJlOWIRD5K769H2Y1TusJqH1oH19dmEm10o4VqS8JlLwBm1KnJz4+rvYmwoFJmYAR6bMuGp
	SyfIVv5Q6oIoW41XBHFMKkU6isJNskN976M8gVgHARoYGGAuQJku4N1/PuQ8bT0YF2w4FofG72Z
	Vt2H2il76EXWShgW3fd4tLIpK7O2Ck3r5ajrFoXJkAAdPZtxPxuQhOVMmUUOE/E+UX8tUOlRqiq
	wL5UiwstWsXIxJJFoY33P1OfxvTvWqsLhVNKLhVWTCMNIrSfwKW2ClFxj4b69hl4gRqP4jLi/6l
	p9n1QYMja5p4tLyWFEk37fuWZUi/JPfqpvq4pBTyyjdRnFSgOAHzpBNIm17jbmQEJ3W+zuwR1Rv
	E8HC8CCK3ZlXUFM+r0btccxv/sg8RJ/zF2bMpG2CY1rjDHt21pQCP4HiT7Y4NaJRxRAhcXABE/p
	81xk7U1lVpM33rj+cl+l4osPV73XAxzBwMxhPrljCmfxSr2yclg3BvlFFLv1HfKqd5L+mW5g9ud
	g4K3EnpoNcu2YU5/tgOeiNc8w57f7KIQyW+/Czw=
X-Received: by 2002:a05:622a:1f8b:b0:51c:2135:b00a with SMTP id d75a77b69052e-52ce621ad2cmr201941041cf.40.1786047341780;
        Thu, 06 Aug 2026 13:15:41 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f39:2600:45fe:22de:25c3:95d0? (p200300ea8f39260045fe22de25c395d0.dip0.t-ipconnect.de. [2003:ea:8f39:2600:45fe:22de:25c3:95d0])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52ce9a10167sm42720641cf.12.2026.08.06.13.15.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 13:15:40 -0700 (PDT)
Message-ID: <6c77cd19-f2a3-4193-b2a0-057289a9390c@gmail.com>
Date: Thu, 6 Aug 2026 22:15:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Fwd: [REGRESSION] r8169: System freeze on kernel 7.0 with RTL8111H
 (rev 16 / RTL8168H_1) during ASPM / L1 transition
References: <CAM2H0r_cASCBAftiXBXQt5CJO_QW0X1SPf5-5KG7aLwW_FXZkA@mail.gmail.com>
To: javen <javen_xu@realsil.com.cn>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <CAM2H0r_cASCBAftiXBXQt5CJO_QW0X1SPf5-5KG7aLwW_FXZkA@mail.gmail.com>
X-Forwarded-Message-Id: <CAM2H0r_cASCBAftiXBXQt5CJO_QW0X1SPf5-5KG7aLwW_FXZkA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

-------- Forwarded Message --------
Subject: 	Re: [REGRESSION] r8169: System freeze on kernel 7.0 with RTL8111H (rev 16 / RTL8168H_1) during ASPM / L1 transition
Date: 	Thu, 6 Aug 2026 21:45:28 +0200
From: 	Thomas Wilms <wilmsthomas@gmail.com>
To: 	Heiner Kallweit <hkallweit1@gmail.com>



Hallo Heiner,

ich möchte ein Problem mit dem |r8169|-Treiber melden, das nach dem Commit |9ab94a32af704fa9c873094283ae8744a07baf25| (/r8169: enable LTR support/) aufgetreten ist.

*System-Konfiguration:*

  *

    *NIC:* Realtek Semiconductor Co., Ltd. RTL8111/8168/8211/8411 PCI Express Gigabit Ethernet Controller (rev 16)

  *

    *Subsystem:* Gigabyte Technology Co., Ltd Onboard Ethernet Mainboard B560M DS3H V2 Bios F12d

*Fehlerbeschreibung:* Seit dem besagten Commit fällt die Netzwerkkarte im laufenden Betrieb oder kurz nach dem Booten komplett aus. Der Browser liefert Verbindungsfehler („Server nicht gefunden“) und das Interface reagiert nicht mehr.

Eine Analyse via |lspci -vv| wies im Fehlerfall ein komplettes Absterben des PCI-Headers auf (|!!! Unknown header type 7f|), was darauf hindeutet, dass der NIC-Chip durch den tiefen Schlafzustand abgestürzt ist und nicht mehr auf den PCI-Bus antwortet.

*Ursachenanalyse:* Durch ein |git bisect| konnte der Commit |9ab94a32af704fa9c873094283ae8744a07baf25| eindeutig als Auslöser identifiziert werden.

Durch das Freischalten von LTR (Latency Tolerance Reporting) auf RTL8168-Revisionen kommt es im Zusammenspiel mit ASPM L1/L1.1/L1.2 zu einem Fehlverhalten der Hardware.

*Workaround & Bestätigung:* Wenn ich LTR manuell über das PCIe Device Control 2 Register (|DevCtl2|) ausschalte (Setzen des Bits von |LTR+| auf |LTR-| via |setpci 02:00.0 98.w=0000|), läuft die Netzwerkverbindung wieder absolut stabil. ASPM selbst (|LnkCtl: ASPM L1 Enabled|) kann dabei voll aktiv bleiben, ohne dass es zu Abbrüchen kommt.

Workaround bei mir:

sudo cat /etc/udev/rules.d/99-realtek-aspm.rules
ACTION=="add", SUBSYSTEM=="pci", KERNELS=="0000:02:00.0", ATTR{power/control}="auto", ATTR{link/l1_aspm}="1", ATTR{link/l1_1_aspm}="1", ATTR{link/l1_2_aspm}="1", RUN+="/usr/bin/setpci -s 02:00.0 98.w=0000"

Es scheint daher, als müsste für bestimmte RTL8111/8168-Revisionen (mindestens rev 16) ein Quirks-Eintrag ergänzt oder LTR treiberseitig wieder maskiert werden.

lspci | grep -i ethernet  liefert:
02:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168/8211/8411 PCI Express Gigabit Ethernet Controller (rev 16)


git bisect log
# bad: [3cb1fb7a56d2fd8011f5282bc170c0d23dc1f4b5] Linux 7.0.1
# good: [b9dbb4576bc8c69e87b4ca4caa2fb1c0db47d722] Linux 6.19.14
git bisect start 'v7.0.1' 'v6.19.14' '--' 'drivers/net/ethernet/realtek/' 'drivers/pci/pcie/'
# good: [05f7e89ab9731565d8a62e3b5d1ec206485eeb0b] Linux 6.19
git bisect good 05f7e89ab9731565d8a62e3b5d1ec206485eeb0b
# good: [1c2b4a4c2bcb950f182eeeb33d94b565607608cf] Merge tag 'pci-v7.0-changes' of git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci <http://git.kernel.org/pub/scm/linux/kernel/git/pci/pci>
git bisect good 1c2b4a4c2bcb950f182eeeb33d94b565607608cf
# bad: [37a93dd5c49b5fda807fd204edf2547c3493319c] Merge tag 'net-next-7.0' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next <http://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next>
git bisect bad 37a93dd5c49b5fda807fd204edf2547c3493319c
# bad: [b00a7b3a612925faa7362f5c61065e3e5f393fff] net: atp: drop ancient parallel-port Ethernet driver
git bisect bad b00a7b3a612925faa7362f5c61065e3e5f393fff
# good: [3259d2cf94276d92bb49b782d3e138703208e353] r8169: add DASH support for RTL8127AP
git bisect good 3259d2cf94276d92bb49b782d3e138703208e353
# bad: [9ab94a32af704fa9c873094283ae8744a07baf25] r8169: enable LTR support
git bisect bad 9ab94a32af704fa9c873094283ae8744a07baf25
# first bad commit: [9ab94a32af704fa9c873094283ae8744a07baf25] r8169: enable LTR support



Viele Grüße

Thomas Wilms

p.s.: Ich hoffe es hilft Dir weiter, einen ganzen Tag hab ich mich damit abgemüht...



Am Fr., 31. Juli 2026 um 18:04 Uhr schrieb Heiner Kallweit <hkallweit1@gmail.com <mailto:hkallweit1@gmail.com>>:

    On 31.07.2026 11:13, Thomas Wilms wrote:
    > Hi Heiner,
    >
    > I am writing to report a system freeze regression with the r8169 driver on a Realtek RTL8111H (rev 16) ethernet chip.
    >
    > Hardware & Environment:
    > - NIC: Realtek Semiconductor Co., Ltd. RTL8111/8168/8211/8411 PCI Express Gigabit Ethernet Controller (rev 16)
    > - Subsystem: Gigabyte Technology Co., Ltd Onboard Ethernet
    > - Mainboard: Gigabyte B560M DSH3 V2
    > - Chip version: RTL8168H_1 / Revision 16 (XID 54100000)
    >
    > Observed Behavior:
    > - Kernel 6.14: Completely stable. Reaches Package C10 successfully using a custom udev rule to enable L1 ASPM:
    >   ACTION=="add", SUBSYSTEM=="pci", KERNELS=="0000:02:00.0", DRIVER=="r8169", ATTR{link/l1_aspm}="1", ATTR{power/control}="auto"
    > - Kernel 7.0 (Mainline): The network connection freezes / locks up shortly after boot or during ASPM/power state transitions with the same setup.
    >
    > lspci -vv snippet for the device:
    > 02:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168/8211/8411 PCI Express Gigabit Ethernet Controller (rev 16)
    >         LnkCap: Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s unlimited, L1 <64us
    >         LnkCtl: ASPM L1 Enabled; RCB 64 bytes, Disabled- CommClk+
    >         Capabilities: [178 v1] L1 PM Substates
    >
    > It seems that changes between 6.14 and 7.0 regarding L1 PM substates, clock gating (CLKREQ#), or L1 exit latency timing introduce a PCI bus lockup on this specific revision.
    >
    > Please let me know if you need specific dmesg logs, ftrace output, or if you'd like me to test a patch or run a git bisect between 6.14 and 7.0.
    >
    > Best regards,
    > Thomas
    >
    > p.s.: Hallo nochmal, hab das mit Chatgpt erstellt, sorry. Mit Kernel 7.0 ist jedenfals ASPM L1 nicht stabil, mit 6.14 schon. Vielleicht hilft Dir die Info ja weiter.

    Root cause can be in several places, incl. PCI core changes. Therefore indeed it would be best if you can
    bisect between last know good and first known bad kernel version. Should be kernels w/o downstream changes, ideally mainline kernels.

Hi Javen,
this is one more report mentioning a problem after "r8169: enable LTR support"
first bad commit: [9ab94a32af704fa9c873094283ae8744a07baf25] r8169: enable LTR support
