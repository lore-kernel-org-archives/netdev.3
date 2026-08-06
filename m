Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01273CB8F1
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 07:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786001495; cv=none; b=k18RfqbigM2EZfXgGxCXIdS1/G+DzENYmIBAkuhhTSIUh9AO1+MhiEuuIyWjljdGMQhH/N3vOqr00ylJM85NI8D+swCmsFvL0JF1IvNL1vWWI7OCNx134YSKkwveJsRVI2QunqqFL+ESeOsyRQ8NiaE+6S8IugN2+3cc7JuD/jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786001495; c=relaxed/simple;
	bh=h/28hW+aLZCVn/rYJAAjPMDlQtD25+OgSFqcgQatD3g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bw7962Ej+qfMYofgI8p8G/EcgRAJbh6k9JPniD401DVtq7lwUoiOF7DOrd6FhAQjUvxdkYmkxiWegBEb3eOZ/fr8/FaeQSL2ozYw0k2Osc67HkzJRdIGugITa9+YIyzgwEgsir1bE29OS/nVspGGiooY8XUcloL8TzyA9geGCVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yg64C0kU; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yg64C0kU"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4980dc26022so17176135e9.1
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 00:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786001489; x=1786606289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aotJrnxBGSGoTO/cMveKNNxTRn93HwEGoid/iEuKyAU=;
        b=Yg64C0kUT57VVQZScncI36VuQdcQixrbJvjyu0hB8CESa12rss1P3iPmTuVQuJL3Zz
         e1fmdHI6WOuRSBSLpL9FbGNYoHPfWfHW3UOWEDiZNaMO/on/mnyxR0WDLM/V81NG7Kw5
         0zLkR6bw5Csr7i/TeH9rt/R7XXxgdG05MckQxjvcCHnF/74ubJjl55cypfvRRSCfU224
         KCxBpWBVKdYTNoe7p+SWKF0wRnEbpzF1LzuNqGE8nzDzP84+9ztVSYMSoZioFGE9j7k7
         ODdqE5p5jrdGY9XcA8w1qvydDsleAj26f3xSc1PSiTo2MbaOJlpdBRTM2hCGA+CaEiE+
         8o4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786001489; x=1786606289;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aotJrnxBGSGoTO/cMveKNNxTRn93HwEGoid/iEuKyAU=;
        b=rhkCCbYAZjDwH+tEJ4AZF135PcIAaAv66R6Nkgi6OWNvbili42dnlnRhtGSDqes91O
         MSy5J4LCKdVS46NN0CJQhtnjfTomxkv+/iMwFDzUN6EfUqUVNVU7D5h5GUxZ+5/bAoYp
         Q0XvOFD1/5ZFWO7VTqCzs9Pz2DWsyFsZ6uwnDWPEgeoqygFHFCPyda7jvs1au/SCJwS8
         sC0hTRhY4cBPRo0wGZ6VDFH2yg2+XB5XvOACX5Ve/6ZT3UWZ8H58rvPGg9NPGZWjQI2y
         9/IbJBubv4n0RTl95Y1uQ6dfkoHlfynolrkkzlXZqBATtTGT+dfRp1vKtNrpwr7YA/IY
         +Hhg==
X-Forwarded-Encrypted: i=1; AHgh+RpFf+zE6dEx/ZvdsCmvosIka664GtjvxsdfY+gH2UggXlRcwf4JwfnYnELPF3r3YtCcmg4WCxI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqNWGe9Hxe/UVS0ws8+MCkryLAdrqcqBxZBSgU+xm5HZ331z3g
	Zki1oczJkIeAKUnp/5ai0TlzgjtvvpI+Vmbj79VkVHa9xCWPM0n+VdU8dCUh+ZwW
X-Gm-Gg: AR+sD11HDyVHt5w8dMbF5gxWkgrCAD8I0ZTs24eBKUzmong9yeH+TnlvM8Ygxaa1kcA
	lULkw0SNmTPjspG8kteQkjr8PxBlHZttQHtHDDLLGbPehxdylJ6BbfkdYHvFByHyUug5JxpMf/0
	Xc8mzzaUZ6yW6Q1X3f6B0j2yuHnJSn9z6J2Ikh5cGEpdNdex5jVhC7Is61DGtTaqvWKANeiDhBb
	Z6aG7/sbZD4u4VLZm8YozU36Eeen1pTGYnGU7chrQn+hIoX0UQJz9Kc7Sy8hHGw9+KbU41nBYyp
	pktt9H81vZb4Yw5H6he5L6RxXjG7rScbQCBKYduef9knklIBwh/BTxPRWL3XobGpyLYJcIYj+z9
	kbP/WDgXqYGVmcLRmnL8ZPDSoq7IiJuKaBSgWoaV8qcKG38HlwX9nO95qdKqxAYh3oPnpR3Yydq
	vd9jNJ0scGY6gKA3yng/ajukz9Z3JoS295g9XSW4jsqIGtQx8ZQYjMn005+YqOiw==
X-Received: by 2002:a05:600c:34d1:b0:498:1595:be7b with SMTP id 5b1f17b1804b1-4994e794ee7mr182173735e9.4.1786001488744;
        Thu, 06 Aug 2026 00:31:28 -0700 (PDT)
Received: from SVR.localdomain ([86.106.74.249])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994e52d819sm79075085e9.1.2026.08.06.00.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 00:31:28 -0700 (PDT)
Sender: Semih Baskan <strstgs@gmail.com>
From: Semih Baskan <strst.gs@gmail.com>
To: florian.fainelli@broadcom.com,
	jonas.gorski@gmail.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: vladimir.oltean@nxp.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 0/2] net: dsa: b53: fix 8021q uppers on standalone ports
Date: Thu,  6 Aug 2026 10:31:17 +0300
Message-ID: <20260806073119.387-1-strst.gs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since v5.15, a standalone port on a b53 switch cannot receive its own
tagged traffic: the switch VID lookup is always active, an 8021q
upper's VID never reaches the VLAN table, and every tagged frame
resolves to an empty member set and is discarded. The common victim is
a VLAN-tagged PPPoE WAN, where the PADI goes out and the tagged PADO
never reaches the CPU.

My first attempt disabled the VLAN table while not filtering:

  https://lore.kernel.org/all/20260805072641.402-1-strst.gs@gmail.com/

Jonas pointed out that this moves the ARL to shared VLAN learning and
desynchronizes the hardware table from the bridge fdb, and I withdrew
it. I then measured the alternatives on an RT-N18U (BCM53011 rev 5),
with the outbound direction of the same link as a positive control on
every run:

  - With the table enabled, no ingress VID check setting delivers the
    frame: VC4_NO_ING_VID_CHK, VC4_ING_VID_VIO_FWD and
    VC4_ING_VID_VIO_TO_IMP all give 0, and clearing VC0_DROP_VID_MISS
    changes nothing. The frame does not die at ingress admission, it
    dies when forwarding resolves the VID against an empty member set.
  - With the table disabled, a static fdb entry with VID 100 is lost
    from the hardware ARL no matter how the driver drives the ARL
    registers: keeping ARLTBL_IVL_SVL_SELECT at IVL does not preserve
    it, and neither does additionally keeping the VID learning bits in
    VLAN_CTRL0 set.

So on this hardware, delivering the frame and keeping VID-keyed ARL
entries are mutually exclusive unless the VID is in the table. This
series therefore programs the table, narrowed to what is actually
needed: a standalone port only needs the VIDs its 8021q uppers use,
which is one table write per upper instead of entries for all 4096
VIDs.

I tried to keep the fix inside b53, but the driver cannot solve this
alone: without NETIF_F_HW_VLAN_CTAG_FILTER the 8021q layer never calls
.ndo_vlan_rx_add_vid, so the VIDs never reach the driver, and DSA
manages that feature bit. The one existing way to get it,
ds->needs_standalone_vlan_filtering, does not work here. It was
measured insufficient, because f089652b6b16 makes .port_vlan_add skip
the hardware write while not filtering, and its other effect is one
b53 cannot take: with vlan_filtering_is_global, the forced
vlan_filtering=1 in dsa_port_reset_vlan_filtering() would flip the
whole switch into VLAN filtering when any port leaves a VLAN-unaware
bridge. hellcreek relies on exactly those semantics, so patch 1 adds a
narrower opt-in that only delivers the VIDs and leaves vlan_filtering
alone, and patch 2 uses it in b53 and programs entries that carry
standalone members, masked so bridge VLANs stay without effect while
not filtering.

Tested on the RT-N18U: the standalone upper receives 7 of 7 probe
frames with vlan_filtering staying 0, the static fdb entry with a VID
now survives a vlan_filtering toggle since the table and the ARL mode
are never touched, uppers keep working across bridge join and leave
and across a vlan_filtering toggle including on ports that were
bridged while the toggle happened, deleting an upper or bridging its
port verifiably stops delivery of that VID to the CPU, and the PPPoE
session from the original report establishes. 802.1ad uppers keep
working as software VLANs, since this switch does not parse 0x88a8,
and stacked QinQ over an offloaded upper works too.

Semih Baskan (2):
  net: dsa: let drivers offload 8021q uppers on standalone ports
  net: dsa: b53: offload 8021q uppers on standalone ports

 drivers/net/dsa/b53/b53_common.c | 118 ++++++++++++++++++++++++++-----
 include/net/dsa.h                |   3 +
 net/dsa/port.c                   |  21 ++++--
 net/dsa/user.c                   |   4 +-
 4 files changed, 120 insertions(+), 26 deletions(-)

