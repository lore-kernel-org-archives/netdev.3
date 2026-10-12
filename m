Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE44431A51
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 07:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791789062; cv=pass; b=J9WYd+N+mHhCxEaMlOT6SI2+8GaMDU0gQ1oQUMcol7rIcOyXkAlwaPzMU03WFgDjoAw9yxIQcTGeMmk7epCz6S6o8r/S0tXX9TXXWg+YSyEOMHeosTF6Ny0BOvmhGREw2+sWaMfj4PWtFLgqw1UEpO+KJqYoTyEPtsAK4ymOZmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791789062; c=relaxed/simple;
	bh=PC8D8DHXuvHBfrK9enAy6y2ARRnFH6LXThA9ycvKtWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uvOHgQPSrKS29scGy5tyLyJpRnzQ9rdFVHueGDab2pXi3DFq28Tg81Ps7kyz5KfboiZmcJOEn5ku2jhStfmBtXpQNuMxv9u4rupK1D5JVdKH373TZQUoXh6hT5yfK9EXlr5NYv0FESUHbIl726BRVaXFqwOe6iZQLMWQbimxPZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k1NO0pDj; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1NO0pDj"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5bccecba199so977348e87.1
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 00:11:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791789059; cv=none;
        d=google.com; s=arc-20260327;
        b=ONm/qqiYnQMbU8kUqIS4UfcHN6I97J2CZtA+9fFMSkdClF0DAJVcsmRKpD013MFsZ6
         y+K9zv0WGZj11irMkmnPoaxx0B1upwAn3YfubKxGPEDUiaZerLXe80jKwC8pF4SBtEWd
         B7fzniXFmJBl6l/rKvvAQXzy5Gj1XGGZCi94oTPeqYHCsJX82/ZdpbmzZA+VGODidf2W
         VnveoYDWh0xdimTnorKok2BfRf3ubte6QgtRdoFZiVBnudkf1+y/y2ymV7ESPTB5TTAI
         ZCMYEuzyGDeTXGs51M+5XDrUMxX8RAcFKyzeQUEQrvEn50CeFse3+bupqFX56TdmnABp
         /j7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=PKxPJeHaul4WGcorf+peGk6s2c2jregG736LW2nonAg=;
        fh=3J6DmbxdyYzuvimhy57IL48bv8AHv9jOZc1s4q9YbQU=;
        b=hc/kE/koOlXk1Qcmttg8++Nnl0LfaIa+xs0b/8ThWFawuSiRRYK/8Mqqh8qUiMcnLE
         +uu88EVJcUtrB/TyVMDa7xq6wQrOSHaZKCNjUlsF0KnSyujChheytthlWwmpfPzdjmm4
         Xw1s6VRxPT4r5xnT8R61HLD69w90n9GFXIJFknQikWkiBrQ0F9tRGqgHDzLbOtrpd9DK
         kU07VKR4U/zUpCz57cImuuvESLwhXJkuSxe5dBqzQ1x1DUfyk51FKbd3rY+4ea8cbD/J
         4W0CPWjRdLvP1qx2bNzKXLQpkioOIf72RseF8jryTcYPz/ZBQGZyqn9zfClwbRgNiwOl
         LGPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791789059; x=1792393859; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PKxPJeHaul4WGcorf+peGk6s2c2jregG736LW2nonAg=;
        b=k1NO0pDjM6jAtmlJRpW1/gbBqqWpDBR9s7PpQmv02fFkBj5b/ChZJoDQS6/H7phrur
         GAaCAVv5ThB7kclYIUt0hYBSTjmakw0BIR6/v9MxPM7GoxiAv4KctcbVCVWlUtMDw7OP
         2UY1GUf57TyiwIrjkVSKAjyeR8jhbvuw5swMdTdQTNZZyBy9YgUnf+l8iNk7YJZtSppD
         Bln4k84ReAVXHsZn+Wv0CaQkyBczxGCM97xL0xoMMKYSAr9Gv1t/f1cvdMiycv28Eycy
         DeSRwmHLolBjyjnktlxP5XiaGPd1uwtGcPumr1NgpF3xSUrCajz2dL9SEbX4oEgEkUs9
         jrMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791789059; x=1792393859;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PKxPJeHaul4WGcorf+peGk6s2c2jregG736LW2nonAg=;
        b=aMXTOM0g/zyYtztPQWLj4zjjUA9xv6vo5A68bVx2FM1IvEC1T95yUuVQj/96I+E+fl
         MHv6r9RFktqYmaVQ/kvvJW8uKMcJu7GkXXwbTYBtg/zy35InRKCSHmSSWNyzR2rgrXMv
         6ZFn+2RT6knT9cyyFNesLSb7MlwtlSl9Myyi+vDRb8AK60agiJPF8VtdTuqEPsNN3I84
         dOJgWa+yZZMQS4wSp4bs/V2s51U31ffLEjZr58VbKmRXCZDDpw6anQ/AdMlP9NbCxWHE
         3jJRQZYX/I0aMXeEaOc0gMrnMCbF6qD2H5njeuQ0ZG7q420f0aD3uNyijUgwK3T2VlEU
         SPyw==
X-Gm-Message-State: AFq9FYJdwNesSGqPl5QW6mcR9PsFojo8IjJ09hneEjyyQ2IgMT/rHOhG
	5Kqpq+ElzXIbLTD72H6vXfWDDnDqFvkA4+Xj2Bbakc3x0pgSTcNXYBow/BiApd1Js9P8D3KOzO5
	ONApNmsjTkmhBHwPaysl/pbfaW0HUwaE4Ky6QTwCsGA==
X-Gm-Gg: AYBFou0KIQ4xC6nqlYp4gRmojifnkNwASENDEAikkLg3+/EUEhdFeCmBN3nvGg7TF/9
	BXOB8s5d6NYtjFWIaCuofiUt/81NgI5jIe1a3SrK36r3ifrMUDhlUVra+smYC63jHJ3lt3HMawr
	Rz6wj3H4IcTrp/xKFYnkxWSUOtNgMQe5I26Dq+rfCUO+iheP6YkTF/F53Bsibym2oFKyG4LOwS2
	waNzNTyoHWtLOr0V8UNdXU3szJ1sxoGTaKmmRexTAk9FWiyJ+PvgpHa4dmEZc4iDWAyxwDAWBRE
	fPT/S9GNE7EIRaetLoIVsZ8Gn7PJ6J5IhBBP2SoOQRF/hkRd3g3lptIvM7hir2MrcQ==
X-Received: by 2002:a05:6512:3f1d:b0:5b8:e4d0:9040 with SMTP id
 2adb3069b0e04-5bcde6bd1e9mr3313023e87.11.1791789058754; Mon, 12 Oct 2026
 00:10:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPZ+gd9d1P+xDSrxxZkGJr32zjubP=KfQegeGkWykKGvEH0=oA@mail.gmail.com>
In-Reply-To: <CAPZ+gd9d1P+xDSrxxZkGJr32zjubP=KfQegeGkWykKGvEH0=oA@mail.gmail.com>
From: =?UTF-8?B?6ZmI6ICA5piO?= <cc201008@gmail.com>
Date: Mon, 12 Oct 2026 15:10:46 +0800
X-Gm-Features: AclHuK9zqsCSqKaZL-No2oYZGnFlUiG1tvJRKnc3YYARIdJB75fdIO839OkOa6U
Message-ID: <CAPZ+gd8TPNnvEDOv_H=fdvy2ysG63uBD0MvmEMjhkMa8i-y1NA@mail.gmail.com>
Subject: [PATCH net] net: airoha: Keep UPDMEM egress MAC in sync for offloaded
 IPv6 flows
To: netdev@vger.kernel.org
Cc: lorenzo@kernel.org, horms@kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

PPE routed IPv6 FOE entries do not carry the egress source MAC inline;
they store an SMAC id and the hardware resolves the address through the
UPDMEM table, which airoha_ppe_init_upd_mem() only programs with the GDM
port own dev_addr at probe time.

The netdev the flow actually egresses can legally carry a different
address: on PON setups the authentication MAC belongs to the pon device
while each service VLAN routes with its own address, so offloaded IPv6
frames left the port with a stale source MAC and were silently dropped
upstream. IPv4 was unaffected since HNAPT entries embed the MAC inline,
which made the failure hard to diagnose: TCP handshake and TLS completed
over the slow path and the transfer stalled exactly when the flow got
offloaded.

Before writing smac_id for routed IPv6 entries, program the UPDMEM slot
with the source address of this flow.

airoha_set_macaddr() writes the same slot from the ndo_open and
ndo_set_mac_address paths: take flow_offload_mutex there too so the two
UPDMEM writers cannot interleave their two-step DATA/CTRL sequence and
leave a stale address behind.

Tested on a Nokia XG-040G-MD (AN7581, GPON WAN, PPPoE over a service
VLAN carrying its own MAC address): IPv6 HTTPS transfers went from
stalling at the 15 s curl cap with partial bytes to completing at line
rate with hardware offloading enabled, matching IPv4 throughput.

Fixes: 00a7678310fe3 ("net: airoha: Introduce flowtable offload support")
Signed-off-by: Yaoming Chen <cc201008@gmail.com>
---
 drivers/net/ethernet/airoha/airoha_eth.c  |  8 ++++++++
 drivers/net/ethernet/airoha/airoha_ppe.c | 13 +++++++++++++
 2 files changed, 21 insertions(+)

--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -138,7 +138,15 @@ airoha_set_macaddr(struct airoha_gdm_dev *dev,
  airoha_fe_wr(eth, REG_FE_MAC_LMIN(reg), lmin);
  airoha_fe_wr(eth, REG_FE_MAC_LMAX(reg), lmax);

+ /*
+ * Serialize with the flowtable offload path: both writers program the
+ * same UPDMEM slot with a two-step DATA/CTRL sequence and concurrent
+ * updates would interleave, leaving a stale source MAC under already
+ * bound IPv6 entries.
+ */
+ mutex_lock(&flow_offload_mutex);
  airoha_ppe_init_upd_mem(dev, addr);
+ mutex_unlock(&flow_offload_mutex);

  return 0;
 }

--- a/drivers/net/ethernet/airoha/airoha_ppe.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe.c
@@ -414,6 +414,19 @@ airoha_ppe_foe_entry_prepare(struct airoha_eth *eth,
   dsa_port);

  smac_id = port->id;
+ /*
+ * Routed IPv6 entries resolve the egress source MAC
+ * through the UPDMEM table indexed by smac_id. The
+ * egress netdev can legally carry a different address
+ * than the GDM port itself: on PON setups the
+ * authentication MAC lives on the pon device while
+ * each service VLAN routes with its own address. Keep
+ * the table entry in sync with the source address this
+ * flow is actually going to use.
+ */
+ if (type >= PPE_PKT_TYPE_IPV6_ROUTE_3T)
+ airoha_ppe_init_upd_mem(dev,
+ data->eth.h_source);
  }
  }
