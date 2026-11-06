Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793977353;
	b=t/h5ddFExeFtD8XfhUY1H0DodKmzQxSyIhK6oXnoolgUGaB1d9log+HQ3C56/roexfkh
	 NO6SuTBcEYYpBleFo5Yo0aHFxOaeaFAqV9AwCcm3/hP89WT71Ni4jFZMF39m8h4ootLL5
	 GByXuRERXSiySRWVzo0Prr2yYz60c+y5fzwwVLTeaj+M4JtKVSlC2RHq+XmW6OP1a21YN
	 4qeUClTmgp3fP5RerpRbFe15CKEi04jo2OJQaB8SGU2GlWomBocdNcHanfl+h/QHl7ako
	 4HCxaIM13yhfmqYJtGpZnpg6cu3kyYpQobp5nSHl0MU+o8ORaouSqAM3klt1MsH2nGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793977353;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ivDi103aMzN/RYAG1NnirSPo+83ZQbk6RdxH4xYelZQ=;
	b=pmrH1Of3/TO1mVhhTRLGg5kxvikZtkde+KF9wzjPa2lG0FXJ7UCCChzzMMuK2UtsnC4k
	 /Gordx3FSBcUNqarOBYU+fRmbvfb6+J6MQOhmeojeqMLdJb16hj2h1ZcOHRiIE/RRt4Zk
	 C5lFkbNT//kqxoH5V6bllBdfqZiPDaq99xCJX6vx1OFmKKHJv5OXR2FgWSdCWVOgjYunw
	 i8pgN7zYi0CJKm+EtTqRj9ZBh4miVukjAJsu5bFcQD+OOButyCm0+XJQJ4bBUtot4zJFU
	 HlYitn8eIQkvkPamh/CkkK+MXbyMh+/KFsqtvP+R6OCSlhxCKF1zGLkEYW7VvhjrnaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dOpCm78M;
	arc=none smtp.remote-ip=209.85.218.42
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8341606EEAD
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 15:02:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8341606EEAD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dOpCm78M
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c4ced671398so89008366b.3
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 07:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793977351; x=1794582151; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ivDi103aMzN/RYAG1NnirSPo+83ZQbk6RdxH4xYelZQ=;
        b=dOpCm78M/VPxYuZmJ+Uwj1dorCYRDFb/sSDieAzjFqTTCFx/gDjqfCuioUbQ7MTO1L
         BYTyKhF3MRsF/FMOlQm5MAspqwSw6RiiVC4oe8sRP86Oui7/HyDVPy9a0nzAoViHynmB
         R92Ne2/IbwWMQRXOiaePiFSN/VT9QL7l/WB1urcbvl2suxX/9nS0wAPpRM6V5mtr1nWA
         MzD4BCwVp8Lc0Iep/uYWLwFhuqFAIgemof2I3CLPsJQYf+ETpsKsQXJZDbJOXe/AIl9l
         wjmSgCTqhLYlz/3ZenbtlD/+Pu1rPpl686A+2T3mfGi+KHJr50Tjo4fGLKzzCgcLaR84
         gYfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793977351; x=1794582151;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ivDi103aMzN/RYAG1NnirSPo+83ZQbk6RdxH4xYelZQ=;
        b=GD6KSpJB87+igAD2jXZJP8lVnJ4t8oxoxmSRaPrRdBZubP+q/ozhCEB8gp93ltoab9
         LA+tjz9RwTcoDQeFHM+AfE/3lyHGWX76IySswqcAr5EL2UUKRp7xguc9k54OTTIikzpL
         aUA9uS0tJ/vBuY/Wu3FiM04ovUzKtwZWWvzWK0TahHSr9WCiao24iPE7zCpdz6n50p1N
         BDhhxAsThu+pLfTuryRen1UDZe/CUOQDjV7PMIyoWrRgkPcku7anH6Nu8AFrH82SZdtb
         NuIUZAbwteVW73wlInI5DF1URC/iYD957Ic4r1cWTR/ro8D8qYI9yxzUGIB3rYL7IPyJ
         ywJw==
X-Gm-Message-State: APuU4Z/Vw/s/KTAMPcO13FjTv70fOb4jYXtGPmJBL3hP4/X0HREeXDfb
	5HAPzAZi803YXptPpxVNI778W7+5OS9xLXe25qH0jXV771CxVDmNUm6hmP2Oefk4
X-Gm-Gg: AYBFou0MG7W9kaNnpgT1nvkPp3py4+/vTCgecbw7gLkJYmPc1y1t/Ys7xWqvuAlwf+O
	rpffYR2knOY96WVrh4FT0wJD+HHmQfofO3YV5J/cHOlK27En+yiZbAI/Pm/ONR/BHdBaRIeGTkb
	8S+rE8pZN/kceiZIQiMF/9SOpQWNyxLeVDQbFh0lVpdYNYMz4aBAr8qTg8i2mKzAdSZkFuuA716
	EBEXYhhT4Pswq8FFWPW50nFH2NMjZsJ/rV4ffbL3UZvB5x2gkYz8ZgRB1jBrGDWTTgGejy83ATm
	CH4wGrwZdMrlJkDcM4Kb7GEg94KQ6PtiSsq3RXKDEt4SX07AkBZOKZMlezdHjnkXdxANP3Hbujw
	o5dZMS4BQmSZHsk+e9VGUYVqAFsQBhwuHXldrc1BPE3+LP70YFCfIR6d72TtMcBM5XeFGzH2fW4
	w7J7JZFBHnvhVOiR4LUP/C2fORdboyLGJnkw9HQSI4vTUBWzes3Bndned2tYkyrLcrQNjO6ElAr
	uYypUPXsjmBjl4GzOzF8F1NEsZn8cVB70ANVF5ewYjyxeTA4EPM1mol0MIYiJbkLqSnCYi5Tfvo
	14yIcUY6H8HpOADuvTyhTVs/wMqe/rjjZsQRATEPN72Mte3Fo1wF7HRJ78VKHZp9Z2dHr6+pAWZ
	Km/bH41nv5idcicdCXiANCGwuGfeRwlsujS84yQ2D7WUn1JRCDwco1bbykjH5N7/ba4+8AjR55q
	by
X-Received: by 2002:a17:906:dc8b:b0:c49:cdc8:10cf with SMTP id a640c23a62f3a-c4d35531e7fmr229620166b.40.1793977350879;
        Fri, 06 Nov 2026 07:02:30 -0800 (PST)
Received: from desktop.home.arpa (2a02-1810-1e16-ac80-898e-1938-27eb-b890.ip6.access.telenet.be. [2a02:1810:1e16:ac80:898e:1938:27eb:b890])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d356a2ee4sm84905766b.60.2026.11.06.07.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 07:02:30 -0800 (PST)
From: Stijn Cleynhens <stijncleynhens@gmail.com>
To: netdev@vger.kernel.org
Cc: Linus Walleij <linusw@kernel.org>,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	=?UTF-8?q?Alvin=20=C5=A0ipraga?= <alvin.sipraga@analog.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Mieczyslaw Nalewaj <namiltd@yahoo.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 0/2] net: dsa: realtek: rtl8365mb: fix FDB lookups in VLAN-unaware bridges
Date: Fri,  6 Nov 2026 16:02:23 +0100
Message-ID: <20261106150225.3700205-1-stijncleynhens@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In a VLAN-unaware bridge, DSA installs FDB and MDB entries with VID 0,
but the switch classifies untagged frames to the bridge PVID and looks up
VID 0 by FID, while the driver installs IVL entries. Nothing matches, so
a station that roams from behind a user port to behind the CPU port (a
Wi-Fi client moving between access points) stays unreachable until the
learned entry ages out.

Patch 1 makes VID 0 use IVL; patch 2 depends on it. Patch 2 keeps the
neutral PVID (VID 0) on ports of a VLAN-unaware bridge and only programs
the bridge PVID while the port filters VLANs. Tagged frames in a
VLAN-unaware bridge are not covered, see patch 2.

Tested on OpenWrt's 6.18 kernel, which carries the rtl8365mb backports up
to v7.4; the code these patches touch is the same as in net. A station
learned behind the uplink that moves behind the CPU port answers 10/10
pings, its learned entry replaced by the CPU one, with VLAN filtering
switched off at runtime: on an RTL8367S (TP-Link Deco X50-Outdoor), and
on an RTL8367S-VB (Deco X50-PoE, with the family D series applied and a
family D branch in rtl8365mb_vlan_pvid_port_commit()), where it also
passes with VLAN filtering on. Before these patches the RTL8367S
answered 0/10. Both patches build without warnings with W=1 C=1.

Note for Mieczyslaw's RTL8367S-VB series in net-next (v8): patch 2
replaces rtl8365mb_vlan_pvid_port_set() and
rtl8365mb_vlan_pvid_port_clear() with rtl8365mb_vlan_pvid_port_commit(),
which gets the target VID (0 for the neutral PVID) and the filtering
state. The family D paths that series adds to set and clear become one
branch there that writes the PVID register and the frame filter from
those two inputs. Happy to send that as a follow-up once both are in.

Changes in v2:
- Patch 1: add Alvin's Reviewed-by.
- Patch 2: replace rtl8365mb_vlan_pvid_port_set() and
  rtl8365mb_vlan_pvid_port_clear() with rtl8365mb_vlan_pvid_port_commit(),
  which is now the only place that sets the frame filter;
  rtl8365mb_port_vlan_filtering() no longer does (Alvin).
- Patch 2: one variable per declaration and an explicit else (Alvin).
- Patch 2: commit message: say what "the VID of the bridge entries" is
  and that the per-bridge EFID keeps lookups local (Alvin).
- v1: https://lore.kernel.org/netdev/20261104082514.2139278-1-stijncleynhens@gmail.com/

Stijn Cleynhens (2):
  net: dsa: realtek: rtl8365mb: use IVL in VLAN 0
  net: dsa: realtek: rtl8365mb: keep the neutral PVID in VLAN-unaware
    bridges

 drivers/net/dsa/realtek/rtl8365mb_main.c | 157 ++++++++-------
 drivers/net/dsa/realtek/rtl8365mb_vlan.c | 233 ++++++++++-------------
 drivers/net/dsa/realtek/rtl8365mb_vlan.h |   7 +-
 3 files changed, 191 insertions(+), 206 deletions(-)


base-commit: 787268686c64be60023743b527645a907e38ccca
-- 
2.56.0

