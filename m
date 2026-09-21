Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7303AC0CD
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 07:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789976526; cv=none; b=K8Tiy4S6eDJJ7Up3GWSnfnIvTQec0R3TZ+91QVEPGavWWXWw46sCqrG1OZ7wt0X8TDxdy+jlEL4dhm1zU3c/S89z07pAPWAR8RpAHoX7UL64F+Eh/49kUUL1N6vZSZ6otnu2NESuMrIReRiOKVbT0Q4Zyf2hCxleaTktLcMv8Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789976526; c=relaxed/simple;
	bh=qC+plKl4jaMAeMv9KFQI5KK5xUjHAIEAMcvOG4NG30k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QFFYWE8lUBXruu9Cq9Z91iKH/5UVW8SG+vef1PXvMd/G7era3zJz3p8hQoX7k1nGHy6Yrtz/GgvJY5xKR6BGB5E4QoG755gjCukQmngOeX+/XUsAfvd9kPsSTtm0m983AWu1baBLkpVrT5SlZHHVjD/DqjzjAhe4g8Pbj0wmlbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ce1d50Q9; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ce1d50Q9"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc4cacd3409so3029777a12.2
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 00:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789976525; x=1790581325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m7NI7dmw05ci1upj6wN18SfkuMFDavLQgdb5foGE0c0=;
        b=ce1d50Q9AfpHujUEdquNoKI6t0v7FvRD/V5yk+InTyQdtlDdyoZp0LJ5xepBSQzNnv
         uweDpswcar79ScXJRJ8V3hnY5QM1MUm2F8KS1mjOWqbEImRhuDPT7UDh19/3o7kGa1o7
         h3DEd/uidMyUrqYkjttopiSJrA5znJlHZFlVNqLHrQfMqLglIAJCCwGmnFpBuLEnzFhS
         ZtztnO091WKMAKdUkxcPBbN+HrU+5//JNx4YUdh03JF3BqkXc9AMyeVCdhyeBC8pD6t2
         JVt6R0yv6kDkNOTA5kMAxmpZv3Msp6uMRS1BMlaETFPvXtlbOzoxVxxcQavZPia4gN0u
         XnqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789976525; x=1790581325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=m7NI7dmw05ci1upj6wN18SfkuMFDavLQgdb5foGE0c0=;
        b=wZ88DtMTr8rVlceCVeblkQAKwQ000SnyguV+0awWg9aGwDIDIxXufqthD97RMRcpbl
         cuvzJGfylotWZ0cO9O3+KHTgbxVIGvZDGiqPLyiUFvPvCEsJmVKoNaJTEqkbFJMSfZDs
         CZvsvD5mbpyFRxijCQyZ3dBQDgt5AI2S0SCv05YdIK2lif4FUNjiQCrQLMfeB3Pj4XeG
         PmtvArJZ35hWkv+Vrgg6+lejUkxerBtU0BLTO0LmeIOhLzKQLrNRPu7PEDluOAGVOqGw
         sXf2UXe6ATdYjlF90VudzsSkMiCdVdBDCmUNh46S94qApCH1CJ5NhrFDRoAO/T4BCaq+
         vRjg==
X-Forwarded-Encrypted: i=1; AKwUvBxAIeM4cO+t/Obic8AKudVOYRJiSJWSSIH8sUYHbdoIfFBBLHFgNF0+4wNcwT6UNIsnzv3J1e8=@vger.kernel.org
X-Gm-Message-State: AFuF++mhPZF4Xfg9vEay8tt2N4a40DYYZpms86nETEExrhi/x1ZvIpkd
	mPAh31Cgg1SvqDVl6VDiCLRB1OeG6DCMMfmPY86IR9RHI/Q083dXNnlJ
X-Gm-Gg: AYBFou1mRzJo3aGuHry35kcOXk6zJWLHxTMNTOio7KfrKjxzVeSC+qOs44mssm9olH1
	6e0KNclXgCBOLRgtRx28btz6F2dcM8Un0JuCv/K4BW8UZkIaYhSN52aydQXYye8F5Ak6FCwuXgA
	4gTtnOokAQThRq4iz3irGcle1COQiFaQqhQMYUZYoitq6HKCfyx0KP9K6dmxTGMO8xlYm6bkqDN
	+4J68khk6z+AoKwyJBZkHf2FJ3IxjYuY7ALZ/KYtm3L9PagQYZs45299hya6p5HL9vUYvA8+Rro
	+3XcOeRrtdTKn7GeGnNf8RT59dMm5VDJ2kOKvFai7XxubEiu4uThLB52bQdYIdyh9jdRHijOozb
	tmib5W1Ilj7iiteU1kYNBf2lcC1EGDF3rBWRx0y/nw7cIx2TaxkCrV6CDWs4cgRJf7ZsCvg5YEN
	9Cr7oJFhg9K1Uj96PAB17F2T6GWeLtOiEaeu5fJF5cJMr2pF7eB6dOlpfcPwuLMH/iI1dqSF3W6
	RE2v352fNYzaAqVx/uwCOAOnkxoEvVz9/tsYxxWERCUC4Cq26lc5miBLoZCa0WUzXEsxRoX5MWq
	j+tkdzocIg==
X-Received: by 2002:a17:90b:37cb:b0:39e:6c69:9b9a with SMTP id 98e67ed59e1d1-39e6c69b2eamr10004502a91.63.1789976524658;
        Mon, 21 Sep 2026 00:42:04 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6c6dd585sm12396602a91.0.2026.09.21.00.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 00:42:04 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Alexander Aring <alex.aring@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>
Cc: linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hui Peng <benquike@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2 1/2] mac802154: rx: fix skb leak in beacon and mac_cmd rx paths
Date: Mon, 21 Sep 2026 07:42:01 +0000
Message-ID: <20260921074202.2289040-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <20260919213636.3316565-1-benquike@gmail.com>
References: <20260919213636.3316565-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In __ieee802154_rx_handle_packet(), skb_clone() already creates a new
skb with an initial reference count of 1 before passing it to
ieee802154_subif_frame(). When handling IEEE802154_FC_TYPE_BEACON and
IEEE802154_FC_TYPE_MAC_CMD frames, ieee802154_subif_frame() calls
skb_get(skb) to increment the reference count to 2 before queueing the
work item, and then returns NET_RX_SUCCESS without freeing the skb.
When mac802154_rx_beacon_worker() or mac802154_rx_mac_cmd_worker()
eventually calls kfree_skb(), the reference count only drops to 1,
leaking the cloned skb on every beacon and MAC command frame received.

Remove the redundant skb_get(skb) calls so the worker consumes the
reference from skb_clone().

Tested in QEMU with mac802154_hwsim by transmitting 2000 IEEE 802.15.4
beacon and MAC command frames across two linked hwsim virtual radios,
reducing the SUnreclaim slab delta from +680 kB on the unfixed kernel
to -80 kB (0 leaked skbs) on the fixed kernel.

Fixes: 57588c71177f ("mac802154: Handle passive scanning")
Fixes: d021d218f6d9 ("mac802154: Handle received BEACON_REQ")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v2:
- Split the beacon/mac_cmd skb leak fix and the IEEE802154_HW_RX_OMIT_CKSUM
  tailroom expansion into a two-patch series as suggested by Miquel Raynal.

 net/mac802154/rx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mac802154/rx.c b/net/mac802154/rx.c
index 19b5382..ad602d2 100644
--- a/net/mac802154/rx.c
+++ b/net/mac802154/rx.c
@@ -287,7 +287,7 @@ ieee802154_subif_frame(struct ieee802154_sub_if_data *sdata,
 		if (!mac_pkt)
 			goto fail;
 
-		mac_pkt->skb = skb_get(skb);
+		mac_pkt->skb = skb;
 		mac_pkt->sdata = sdata;
 		mac_pkt->page = sdata->local->scan_page;
 		mac_pkt->channel = sdata->local->scan_channel;
@@ -304,7 +304,7 @@ ieee802154_subif_frame(struct ieee802154_sub_if_data *sdata,
 		if (!mac_pkt)
 			goto fail;
 
-		mac_pkt->skb = skb_get(skb);
+		mac_pkt->skb = skb;
 		mac_pkt->sdata = sdata;
 		netdev_hold(sdata->dev, &mac_pkt->dev_tracker, GFP_ATOMIC);
 		spin_lock(&sdata->local->rx_lock);
-- 
2.47.3
