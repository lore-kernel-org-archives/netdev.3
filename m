Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794590030;
	b=PeHrGhhFnzznDmwd5Ul+7t+rUROdeDDMoiFfJEwFsrB9TCAzISb3KKMDpJSNmOBKHR1q
	 CUHiyaCVgxWUstlLcL79EjQZh/kQcDkOAKc+buwZE5GIwJyKXsajLi04rFWXX4MJKlsTK
	 v0IHj4L2GqnrtHbVIKhAN4CkbfYeGQacSuWrjSAoLAaEI02PbuxuNhanSjCf4eKX6oadc
	 zO5lHntqxr2Nrc9Eg2aDrl/alV4Jc913oL8sciaV8aR795qPQzHtG+Ya/gkczhd4fHCFW
	 vg3uM6Fnmxiy+AletTuziQGGvu+dusIBdyzvXNF8D17RPvOFevVShZVubTt93I5EIyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794590030;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=qCcEEZhb+6X/eOhEZOJf7Q7PZICUyrmwcXum+u7HmKU=;
	b=KD8B0rnjRX19G4npf0SMDV2qxI+LeIroaSJYkVKNwo3Jq6nCuRMe9zsurCi61+O/RiHj
	 ejnzdPhlg0JdShEIRha5L8ce/G2/iBwf4X8Pwaid7swXb3RDFU7kcrMUDH0/qIZAsHGPx
	 NYijBsuIqLNdjNJL44cotCxwB9R7ozIqC3yaOSrKfsUW947Y2NJHfcHzcNFPm/UQ2cSGg
	 MH+7UIEMNfcaBQhqBJqnDJmolfS5T/SksP1YNozZjLhMbsoTKihFpWZGqcMAAXTGTce3I
	 atvdALthYuGO3Quj+j99jUtLcxM+nDzlvON46HBv+b4707ySx/jnfje/5DJqFWZaGDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="CKD/anro";
	arc=none smtp.remote-ip=209.85.160.42
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC4960A3806
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 17:13:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DC4960A3806
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CKD/anro
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-4aff682aadeso813448fac.3
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 09:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794590029; x=1795194829; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qCcEEZhb+6X/eOhEZOJf7Q7PZICUyrmwcXum+u7HmKU=;
        b=CKD/anrooXAdTesQ5AHoN/+Wi6tR8Oawe0LHd6426sI1K2mO4CfKcooXALBiCwfMi0
         7fatyoeP+ALyXYlyV2F9x97jo69fNpLAEWOGnlE1fxsenB/CgAebftVlrjVJEa3ViFpj
         x3Wtb7Ljq9WbosO4KRE4+Isi1ODihnJ7AfxWJQ+rxmZAlgIP61PgjC/YpANd96DDhn0O
         JnPiBYxvy5mLS2Voj4kpE+YypdsC32S0RQbqEU/SIp/V7I8eAuQaG7+57/tmXggzGtbU
         ZzVD+uJZTVu4s4uyGeISbxipdpjB2Ph3ZHDLtyuvZqAp/B12qB3WeRaWTIxj5sT46f9b
         tXBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794590029; x=1795194829;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qCcEEZhb+6X/eOhEZOJf7Q7PZICUyrmwcXum+u7HmKU=;
        b=fprTPWE8AXEqTMV6HvbjyODYJf1/+gVW5KpuvGfKPq70GWGMJWEmvvIDy8U+ZruiQq
         V6h3lY+5wFh9B3DsexuVcExs9fUCfr6YLbz3fHTHRK2JxTIZ4Fe5SEibcYk6oCzcc2cc
         HTY92hwKjarX9loC+MzB94duB9CwS5ZAz97fgHy+PraLjhq9FMZrL+7sT/01xND5zQkJ
         sNRRNHcZPfTndGT2alMT8kDHwWophvSnQwnJlNqqxMGp6e2GaLt9WYx145m4WVf9ZIDJ
         pka1WoPoltuFyVA2V7QI+u0rMeC+5WZQS+qMgYlr0CFf/Oc6SiXrAI2bQzCzNRUdHlGR
         7v5A==
X-Forwarded-Encrypted: i=1; AL+hErE0Ti4V+WYrlYdeyuEdIs5xG14bNjtIeYI7M1sG747y7rdOD2ffMc9fmzOwvL+E1f0khiyV0qU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/d1ZLec0X8PXYs2j72UOSFi6YM/2cV0mhJXsRLUsD8EImRLwx7
	hjmerFdpKggD+5qSZCiv9Ywo46TPV7AEg3lcOkeyv/37pFxl6sreOcboQhBac9Sc
X-Gm-Gg: AYBFou0sM6qxktWkk0X/KQ2ykdN2M1XNiavM46AAcFnsL9CW40Fl5/QjRLnipk6m7jL
	HXYGXDqaskGriT5ci1IMb0B8BAKejELVadLFoyM89wS6+Z00GlbRy57j1qzBHpeD7nQVv5/3fmt
	dpVHz3oYTSSMkfplEYzNqsUETZaQwPTimKyboy1ZL998y8Psc/OaXd/mIcJ/ZfmgdAWl69CZ50Y
	0Tyj/TEXCjj0hJp+BEF7sCBFG7GJccT9ufQHhWVXpqtrM1EYjXg4MLXQL6/DDhWA8eJGiR7Ov2h
	7CW+UX2fo+RqTJ485Gz+rwPnHiZFOUxbUknOlZOXK0mP3d00iFqfCZ2NjVuUwNcAdro10+9sQtn
	4LPJU3qJIqbjeGGcbxZGoWvUGjTC/7xuARxb3vJexBzKRIMgIfh8/CoPBJ5iXoQmUUtDtAoTqTO
	oxAlnh0jJmWumaQi+2veIRnjIbAGY0YZBO68c7ruTHS60zWoU5yGFJeMAsw8or2nIDolk8JyGEa
	Boo/qMnmSROGZGTPbrT2oJVld+1itmSSGU3WkFhDMIpZGxumUi+bceoetRPVvkfCTMqeUq2IhWB
	CSXX0nwqbmqUXxPOrWtuI3GN+pDhYTvPEu9PKV5ZceLtrODaD8DwY5ihX1NyiAptc7PuWmjwjz4
	sUW6uFees9+v0g7xqelt4jnILTZTvreBqgTeUhIJllYgq7H/YgUA/Sq865ClC+zxhodDQ1PYNuv
	cI160qGKfZUqzUpBzuTJEgvBS/xLv8N5l0v1pa0p9HoFvpJ8OUiFNo
X-Received: by 2002:a05:6808:4f25:b0:4c3:9892:96fe with SMTP id 5614622812f47-56e605b4ec0mr2987668b6e.3.1794590029081;
        Fri, 13 Nov 2026 09:13:49 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56e7044690dsm2565805b6e.9.2026.11.13.09.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 09:13:48 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 13 Nov 2026 10:12:05 -0700
Subject: [PATCH net-next v4 1/3] ethtool: add PHY receive frame and byte
 totals
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-submit-acx00-phy-stats-v1-v4-1-986b8a4a1871@gmail.com>
References: <20261113-submit-acx00-phy-stats-v1-v4-0-986b8a4a1871@gmail.com>
In-Reply-To: <20261113-submit-acx00-phy-stats-v1-v4-0-986b8a4a1871@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

The generic PHY receive packet and byte counters describe successfully
received traffic. Some PHYs instead count all received frames and bytes,
including frames with errors. A frame error count cannot recover the
number of successfully received bytes because damaged frames have
different lengths.

Add optional receive-total counters to ethtool_phy_stats and the phydev
statistics group. Count frame bytes including the Ethernet header, padding
and FCS, and excluding the preamble and start frame delimiter. These
counters describe reception at the PHY, before MAC or host filtering.
Clarify the same byte boundaries for the successful-only receive counter.

Append the new attributes so existing statistic IDs and their meanings
remain unchanged. Publish the names through the existing statistics string
set, and retain the unset-counter convention so drivers can report either
set of counters independently. Correct the documented group name to
phydev, matching the existing name exported by the kernel.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 Documentation/networking/ethtool-netlink.rst | 16 +++++++++++++++-
 include/linux/ethtool.h                      | 10 +++++++++-
 include/uapi/linux/ethtool_netlink.h         |  2 ++
 net/ethtool/stats.c                          |  8 +++++++-
 4 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index eba226c79ec3..40dd454d4ad3 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -1665,7 +1665,7 @@ the ``ETHTOOL_A_STATS_GROUPS`` bitset. Currently defined values are:
  ETHTOOL_STATS_ETH_PHY  eth-phy  Basic IEEE 802.3 PHY statistics (30.3.2.1.*)
  ETHTOOL_STATS_ETH_CTRL eth-ctrl Basic IEEE 802.3 MAC Ctrl statistics (30.3.3.*)
  ETHTOOL_STATS_RMON     rmon     RMON (RFC 2819) statistics
- ETHTOOL_STATS_PHY      phy      Additional PHY statistics, not defined by IEEE
+ ETHTOOL_STATS_PHY      phydev   Additional PHY statistics, not defined by IEEE
  ====================== ======== ===============================================
 
 Each group should have a corresponding ``ETHTOOL_A_STATS_GRP`` in the reply.
@@ -1683,6 +1683,20 @@ by ``ETHTOOL_A_STATS_GRP_SS_ID``. Complex statistics (such as RMON histogram
 entries) are also listed inside ``ETHTOOL_A_STATS_GRP`` and do not have
 a string defined in the string set.
 
+The ``phydev`` group provides separate counters for successfully received
+traffic and total received traffic. ``ETHTOOL_A_STATS_PHY_RX_PKTS``
+(``RxFrames``) and ``ETHTOOL_A_STATS_PHY_RX_BYTES`` (``RxOctets``) count
+successfully received frames and bytes. ``ETHTOOL_A_STATS_PHY_RX_PKTS_TOTAL``
+(``RxFramesTotal``) and ``ETHTOOL_A_STATS_PHY_RX_BYTES_TOTAL`` (``RxOctetsTotal``)
+include frames with errors. Both byte counters include the Ethernet header,
+padding and FCS, but exclude the preamble and start frame delimiter. These
+totals describe reception at the PHY, independently of subsequent filtering
+or drops at the MAC or host.
+
+Each counter is optional. Drivers leave unsupported counters at
+``ETHTOOL_STAT_NOT_SET``, and the kernel omits them from the reply. A PHY can
+report total received traffic even when it cannot separate successful traffic.
+
 RMON "histogram" counters count number of packets within given size range.
 Because RFC does not specify the ranges beyond the standard 1518 MTU devices
 differ in definition of buckets. For this reason the definition of packet ranges
diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index c3a41fbd5426..f3e0fac8fdfd 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -481,11 +481,17 @@ struct ethtool_eth_phy_stats {
 /**
  * struct ethtool_phy_stats - PHY-level statistics counters
  * @rx_packets: Total successfully received frames
- * @rx_bytes: Total successfully received bytes
+ * @rx_bytes: Total successfully received frame bytes. Includes the Ethernet
+ *	header, padding and FCS, but excludes the preamble and start frame
+ *	delimiter.
  * @rx_errors: Total received frames with errors (e.g., CRC errors)
  * @tx_packets: Total successfully transmitted frames
  * @tx_bytes: Total successfully transmitted bytes
  * @tx_errors: Total transmitted frames with errors
+ * @rx_packets_total: Total received frames, including frames with errors
+ * @rx_bytes_total: Total received frame bytes, including frames with errors.
+ *	Includes the Ethernet header, padding and FCS, but excludes the preamble
+ *	and start frame delimiter.
  *
  * This structure provides a standardized interface for reporting
  * PHY-level statistics counters. It is designed to expose statistics
@@ -499,6 +505,8 @@ struct ethtool_phy_stats {
 	u64 tx_packets;
 	u64 tx_bytes;
 	u64 tx_errors;
+	u64 rx_packets_total;
+	u64 rx_bytes_total;
 };
 
 /* Basic IEEE 802.3 MAC Ctrl statistics (30.3.3.*), not otherwise exposed
diff --git a/include/uapi/linux/ethtool_netlink.h b/include/uapi/linux/ethtool_netlink.h
index fa5d645140a4..db26cff28f12 100644
--- a/include/uapi/linux/ethtool_netlink.h
+++ b/include/uapi/linux/ethtool_netlink.h
@@ -202,6 +202,8 @@ enum {
 	ETHTOOL_A_STATS_PHY_TX_PKTS,
 	ETHTOOL_A_STATS_PHY_TX_BYTES,
 	ETHTOOL_A_STATS_PHY_TX_ERRORS,
+	ETHTOOL_A_STATS_PHY_RX_PKTS_TOTAL,
+	ETHTOOL_A_STATS_PHY_RX_BYTES_TOTAL,
 
 	/* add new constants above here */
 	__ETHTOOL_A_STATS_PHY_CNT,
diff --git a/net/ethtool/stats.c b/net/ethtool/stats.c
index 9b0d8cb07675..b4c4bdd8fc4b 100644
--- a/net/ethtool/stats.c
+++ b/net/ethtool/stats.c
@@ -88,6 +88,8 @@ const char stats_phy_names[__ETHTOOL_A_STATS_PHY_CNT][ETH_GSTRING_LEN] = {
 	[ETHTOOL_A_STATS_PHY_TX_PKTS]		= "TxFrames",
 	[ETHTOOL_A_STATS_PHY_TX_BYTES]		= "TxOctets",
 	[ETHTOOL_A_STATS_PHY_TX_ERRORS]		= "TxErrors",
+	[ETHTOOL_A_STATS_PHY_RX_PKTS_TOTAL]	= "RxFramesTotal",
+	[ETHTOOL_A_STATS_PHY_RX_BYTES_TOTAL]	= "RxOctetsTotal",
 };
 
 const struct nla_policy ethnl_stats_get_policy[ETHTOOL_A_STATS_SRC + 1] = {
@@ -295,7 +297,11 @@ static int stats_put_phydev_stats(struct sk_buff *skb,
 	    stat_put(skb, ETHTOOL_A_STATS_PHY_TX_BYTES,
 		     data->phydev_stats.tx_bytes) ||
 	    stat_put(skb, ETHTOOL_A_STATS_PHY_TX_ERRORS,
-		     data->phydev_stats.tx_errors))
+		     data->phydev_stats.tx_errors) ||
+	    stat_put(skb, ETHTOOL_A_STATS_PHY_RX_PKTS_TOTAL,
+		     data->phydev_stats.rx_packets_total) ||
+	    stat_put(skb, ETHTOOL_A_STATS_PHY_RX_BYTES_TOTAL,
+		     data->phydev_stats.rx_bytes_total))
 		return -EMSGSIZE;
 	return 0;
 }

-- 
2.53.0

