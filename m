Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794282628;
	b=irSG0hSd2qWd9savdrLLIaTueTXxR6pgmw0P/n4c1Egw+itlDqCCtpwE+EK4Eg5gqTyK
	 RkJ191hHO8srDy3Wft3yN2WHFQQQJ++PB1HR6oZR6VFK4kfLTJkvyR5hUDMnmfmz1DIYA
	 SCKS1PjyfV8zIj2qie/qpULWyuOg2UUStay4a5XwPXGrR1mcnbF0TPAkQOnU4agsx2Dtz
	 ESM1n2IqbUywtnL6bI/ZhZzEINhS8V8I7G1rU0KSveTcZ2RBDeRwtiMkwROSPsTj9tpxV
	 c7TsvrbLwntzB1yRkvROt3/JxTZcdOR+V2cULP4tQG6bV4GWCln4cgzetxJlm95Yw9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794282628;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=EHdvQZ18BcX/XBcDaD6cKWB/M8/vhPYw3yGXazOgxS8=;
	b=kz5LFRrI0Vu1iQdb/qqycoBEbOJswcHBHh9KtCmDZ+TVUVEklk94EM5fJmjkvFmz+j22
	 mqAn7OD5UNOsLaVulvS1hCvI4QNh/pegQAjslj4eDzhuTJYlER5w/Pbaz+55r9w8vcvtv
	 86zMuVXNYn8g48Zwa1U7BFToXFwaDCWJeMkbAEbHW5VZldJTPP+Xxbb9NT8jRp0zEo0wV
	 mFYakiqDkr3CVGDtaj6euqZV/7fW1xXxq+zTppSgK1H13qrehZwAm2cxUjnZ4CdT8vMWI
	 zs+dvS7UyAdXPPJvOnDCWAGs+HOHGuNVvCYvuT10JVDwY7cqMkpGNlHdu0zqTskA6lQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Mm2y8T+R;
	arc=none smtp.remote-ip=209.85.219.99
Received: from mail-qv1-f99.google.com (mail-qv1-f99.google.com [209.85.219.99])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F8D606A31C
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 03:50:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01F8D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Mm2y8T+R
Received: by mail-qv1-f99.google.com with SMTP id 6a1803df08f44-91ecd81cd67so14924816d6.2
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 19:50:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794282627; x=1794887427;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EHdvQZ18BcX/XBcDaD6cKWB/M8/vhPYw3yGXazOgxS8=;
        b=ZBO5odT6jg3NecnKMPxjeeaZEQInU2DBSBotGAkFF8UIJkpCQ14HK9wTxEGEAPo6sF
         7JjqCx/MIZx4mlfVtkZz5jfc17Qg2FWx4y/hO4oMFB1KXxCZP7XHm7qjM1rVhOGAy++A
         oXOZnc6uK5P/ieDXbrQrZl0WDXV7tQv5lSMtiHQrGGWNIMFgZiYs/+kkGdnVaCGXG5yJ
         AJAJZujQodzD3QrDcCjgEgZGzw+t86AMxiXcg72ewGhS1J9oyYVNUsBqgfmVEnGd2iPD
         qjg5ycQ55QX38GXy1QTUg6oIDltUZx5fzQI5wvbGJ8m2F2KA6kT1qdRbcq3N2icioqne
         dkLA==
X-Gm-Message-State: APuU4Z8kcyT181hTGMKoWChzdIYVyeUL4qLZwOxC+5Obt4Azc9ycR1Vd
	/+vL6CRxMRLih/xugpbjJsWCRFtrxebh8EbXnA3ahCQMsQ3yeFC8hCJggoCmyGrL1h2qeLj7bdj
	YMgyJvKpCevjz1MBOHkH9qWJhVJ9t3OXlqnTFaFBqAVDMX/IsBPcAwH3co5qZyMled9bsXq96o+
	vpJb4Tgr7y3OYrBczpn/cWHyjX4ApRMhhkooEZb+blr0+egT2LhYpDopgS+0TgFIpXTmfhIiv56
	s0kx1C94UziNJk3
X-Gm-Gg: AYBFou1D3XaZmS/3LEao4t9UfKKafVmfFcX0JdEYbKJ+yXNjabD9CJiEHxVa9/rKgXG
	klxPpoTI0jtghK7shv0Hd48gLTS86vVUmAllIzYSTtLS4e+A5hz45Cf8k5VPH5m7i/MUeYOnicx
	BoUSU6MGOjXGEzvBAvrXpgbKUG5ajfIvfHQwgsA1L6X/yoVxVgJ4Pkka8Ov7KJmnPOuw+94q9hB
	Sy9JIGTdnCEaJu8NdqhRAFf+VUKrHsAPFcrHNFYVEFyOd4efU2H2Z4PrJJimIJwwcQ8CLOp7vWS
	UiikJMy8n6N9hr9vznb2ZcQMQTX2M6RHNgYfWwLLQ3+CPeIgucpBJycg8pLThoXbFWqGRgA2qZE
	KmNZDVcgm5uFGKpPnQsrL0zjE4PUdAgQg3mCmsyUolIqJVc6jI04bNYszMr8AL6yvNPT1NKYSQs
	zVqrK8LJfc5GMapcQhYY6RYEB2MYvxsmMkmtwZRcrV
X-Received: by 2002:a05:620a:2a14:b0:945:e356:42e3 with SMTP id af79cd13be357-9479f36606amr244664985a.73.1794282626805;
        Mon, 09 Nov 2026 19:50:26 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-9479efe3ae1sm15693985a.13.2026.11.09.19.50.26
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Nov 2026 19:50:26 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5363b06bcb2so35071161cf.2
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 19:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794282626; x=1794887426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EHdvQZ18BcX/XBcDaD6cKWB/M8/vhPYw3yGXazOgxS8=;
        b=Mm2y8T+RanHzClp4si5idFDdJIiflrORUrVFzdAGIIhEywFD5jAP+m6A79rCyNv4ma
         ryNWxD7oC/vfcub/wrm6k73OF84iM6BmHc5/erWhbv2KyHmBLAwkP+rINyN+v7xCE4Lj
         On/IVAqdJ0GkjYV0NhsnWeGzF6QhCUq9NG+Tc=
X-Received: by 2002:a05:622a:2587:b0:533:4da1:b5d1 with SMTP id d75a77b69052e-555292bc4f5mr22485711cf.23.1794282625976;
        Mon, 09 Nov 2026 19:50:25 -0800 (PST)
X-Received: by 2002:a05:622a:2587:b0:533:4da1:b5d1 with SMTP id d75a77b69052e-555292bc4f5mr22485461cf.23.1794282625414;
        Mon, 09 Nov 2026 19:50:25 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5550af612dfsm13740951cf.8.2026.11.09.19.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 19:50:24 -0800 (PST)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v4 0/8] net: dsa: b53: Preliminary fixes
Date: Mon,  9 Nov 2026 19:50:10 -0800
Message-ID: <20261110035018.2169370-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

This patch series contains fixes to issues reported by Sashiko on the
b53 PCS bug fixes being submitted, and then some more that came from
code review and testing.

Except for issue #2, all of the other issues did trigger in testing and
needed to be corrected.

Changes in v4:

- Return success when deleting an ARL entry that does not exist per
  Sashiko's review
- Restrict the 2 Gbps override bit to BCM5301x and BCM58xx
- Restore mirror configuration on resume, moving mirror initialization into the reference-counting patch
- Propagate SF2 setup errors on resume and disable the clock on failure when WoL is inactive
- Add a patch fixing BCM5325/BCM5365 mirror port encoding, including CPU port bitmap translation

Changes in v3:

- patch 2: added Daniel's R-b tag
- patch 3: mention in the commit message that deleting an absent entry
  now returns -ENOENT, including when the lookup runs out of space
- patch 4: document that the patch also fixes the clear of the capture
  port field in b53_mirror_del()
- patch 6: reference count the mirror source bits per port and
  direction, ignoring deletions without a matching reference
- patch 7: new, harden mirror register programming:
  - reset the mirror capture and source control registers at setup for
    b53 and bcm_sf2, since not all switches are reset
  - check and propagate all mirror register read/write errors, only
    taking a source reference once hardware programming succeeded
  - use the source masks rather than MIRROR_EN to decide whether the
    destination is occupied, and write the destination before the source
- log failures in b53_mirror_del() since it cannot return an error
- patch 8: new, fix the mirror capture port encoding on BCM5325 and
  BCM5365, which use an 11-bit bitmap (CPU port at bit 8) instead of a
  port ID, and translate the CPU port in the ingress/egress source
  masks as well (verified against the BCM5325E, BCM5325M and BCM5365P
  datasheets)

Changes in v2:

- collected Jonas' R-b tags
- corrected logic in patch #3 to propagate -ENOENT, memset after the
  debug print, translate -ENOSPC to -ENOENT when deleting

Florian Fainelli (8):
  net: dsa: b53: initialize the jumbo frame size register offset
  net: dsa: b53: fix the SRAB grant timeout check
  net: dsa: b53: clear stale state when creating an ARL entry
  net: dsa: b53: reject conflicting mirror destinations
  net: dsa: b53: use the correct override register 2 Gbps bit
  net: dsa: b53: reference count shared mirror source bits
  net: dsa: b53: harden mirror register programming
  net: dsa: b53: fix mirror port encoding on BCM5325 and BCM5365

 drivers/net/dsa/b53/b53_common.c | 209 +++++++++++++++++++++++++------
 drivers/net/dsa/b53/b53_priv.h   |   4 +
 drivers/net/dsa/b53/b53_regs.h   |   1 +
 drivers/net/dsa/b53/b53_srab.c   |   2 +-
 drivers/net/dsa/bcm_sf2.c        |  10 +-
 5 files changed, 183 insertions(+), 43 deletions(-)

-- 
2.53.0

