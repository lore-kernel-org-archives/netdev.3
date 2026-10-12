Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E32F4BA1CD
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 17:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791824983; cv=pass; b=EPjVSRw8yvL9EAGdedQCJLwtz4u7rWhoIfUl9UDYWw1X4CIUIaI4kDaQtn+5HrzzW2/XmcEkv0HP70pkXWnznX/J40jszMdp4C0LwGWOznmOU1ZRxFlyLBmKk/Pfsg/7zBAPwRavVHkKFRZGvrHPyNjFG+itBRZmhqml5gTzIRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791824983; c=relaxed/simple;
	bh=Bga2Ltu6EQmf2urfEVGxn2C4c5NgRYsmXRD+/o7K+hY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AuOpagL0K1F1IFq8cbQ9sX6S3kZWYd/sTWCiXBwkyQ/I5Ff6XNicH9SBjMEzgkoSCM6fypWAdSr5LAv5c4V4GXF1hr/7jSAOY+1LBs9tI6qKkfpWOwv4+89eqfHsf666jUWIn2bxYl9aU6x3UQtaPnchst0KtfpxN96vpj/6mpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nY8EzBOL; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nY8EzBOL"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5bcdab9a82bso2348769e87.3
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 10:09:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791824980; cv=none;
        d=google.com; s=arc-20260327;
        b=RqbYAKUKuGk7Vhw2xejXnRRot56rKGWCkCTV5aXxi0qSLTOPMIXeb1dOd0whSM/yfB
         haZPZOt+IpWDEHYyIK4zkUTGC04FS5+cJOVw/VWvs1dqY8KcTq9Oa8OIf9zg03CRIVX8
         S5Br54wVQnThem5WUOiOfnFc9LQVE3HGvGGXZQFjSVFh8hagO/k3xBhu5P/nKIkS/8Yt
         i48iTit9CNbvwqJnjlkUaN7Pd+Z+/zNViS3H+M//yCNprxKueCy1oCHAj/yqnIeBhrkC
         XL8zJ7dD6EU6ZnTkt3P+450hhjzLP9rvViHq536KK77YM5QHE4dLHPkJeaGduhXlbOO3
         Oilw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=bkMm8aYcQbQqrMaSHF8neixFnN+L4NxB8QjkehNUjNw=;
        fh=GgdGMhx8/kCCp4yHpSu/013WbXucVu9nNv2DF6m1zdo=;
        b=kzZ1mFzzXtG/xavu03QtVaYusaKWktyLwZTX4c1MslCWY2uSPPeylNtINbHX9iYncf
         Hb8pl9qKIXWpSk6P4TvcY1vHtCkMMKS2Tm6kaLuBoTXubw1QLAQvf3WUSJRZTbjWHXWF
         u3EPSyfJ2+PoU9Z5HuNIWsCyyzhs5+f1PLKKFqzAaIl1yP27s+iRzjON0Slcy0elZOgk
         O3BiKHUgfJl9kB3FeIQtDT3do225lQVP9Fnhan+YLl7RCob+AKr/UiQNMQ1Vw8q6XUFo
         1+wmwWsYwTa6TAE9xuQ//9NzUiReCuUyqIV+brn/FZ3H2QFoMC6w2X34z91hxBDCr+9I
         OMlw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791824980; x=1792429780; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bkMm8aYcQbQqrMaSHF8neixFnN+L4NxB8QjkehNUjNw=;
        b=nY8EzBOLiT2hFb3F2o0gTLMcdEGMswsbSLc8dqXExKjIwl1HAdvcCH/KXxOEItWA0E
         BPltOy9TOf2nJxDiK3ad0hupZiYggxdUbpau+NyUIwJQNMNUiIm/BPOqYBD2rqG8sISf
         pkcTpdy0u9iA4H+N32ncIXUsVDTH88lnzQvZQxnQ2QC56fCtvwVh06rjIkNR103qRu00
         6iy1nlsSAi46O0WZOqRTqkhVc4IsladJxUgC+6BHPFHip1IKw+jSFL1ooM6BgDGUYAiM
         gk2bxxxuvIKKguobt48mpzIcYbQHvPCWayk0gqSyD0DKRDZUUtea19x+eSR6EJHFFL7H
         HJVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791824980; x=1792429780;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bkMm8aYcQbQqrMaSHF8neixFnN+L4NxB8QjkehNUjNw=;
        b=14qczJi50YLFYoJrnNpL6REnq5h4PLllQxjiMVrWV/duzrJm8wNa1y+BuXrE4Z51cB
         jlw2af7cVbn1MnaQgQNuzPp5Ix/2dik71uVm1ehW30QfKBzpgUtPDCVBV4k4GbTe9AU3
         YH9hZ1P+c/k8v9jHf1sYvU85wchi9gZO7puk+9sZkw9A8ZIj1hMj+4bBomjMU/FY0JdQ
         rH+0RN30w9lgJQqdJd5XS37QVi47dzQ3398/Io8nDMsohN3lnaXlU8FCGCHMHfJYPZF8
         1StsxeEGvT1i9WuptrRXv4qs2rfNeJQGc2t4VnIHKT09col7BMUlAVqE2VvgfVZngP0S
         aHyA==
X-Gm-Message-State: AFq9FYIFUJjUtVfgkC+wpZHIusTxapFTjDWHIlEJwlJCxVAhzh854CCv
	KgKAXMDOGnDtAsVw6ebWvyhOwAnenDmN2psGOVrb0sb550YkfVYSkhS+m8leed6ibT6oxsjE10K
	4BTFwMKgQ8j/Q6BcA7DxjEKl9O6HCvR4=
X-Gm-Gg: AYBFou3VqMxqx3RI5Bv37zU4oKz1dWOun0Zu/rq6HldwHl8i8ycvvidSQ4JNKHu+Fgp
	GCaCktUHeLgJ/qK6Z0lYexIdHw5r2dE8PzCHygzFKQIyz/NlCYExMz74kWcEco/b2fFmVpvXg+w
	kHNVKeEFdRsJqQOF2heyDKN91agLET1yMiE04eZtXNUkm9bV4X6cSuc0YvkfWj06Qy0PMQKdJN+
	wwx2dRSofOIVJ9QqTreUAzLSS2bCDx6J2cYpDTtLGQdlWgxD80ryJCFvGno6uIzX1S2rSEhc9VJ
	wmMKa+sgUD7dCyQFLQNM+e43WDIGS2/EmSHeEJ+6njrPYN1PlgCDzYyCmTB/0d3nDPBG2iXQFxF
	qd2gFGOXb/Up+
X-Received: by 2002:a05:6512:12cf:b0:5bc:d0fd:8c13 with SMTP id
 2adb3069b0e04-5bcde6c99b0mr3418795e87.30.1791824979769; Mon, 12 Oct 2026
 10:09:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPZ+gd9d1P+xDSrxxZkGJr32zjubP=KfQegeGkWykKGvEH0=oA@mail.gmail.com>
 <CAPZ+gd8TPNnvEDOv_H=fdvy2ysG63uBD0MvmEMjhkMa8i-y1NA@mail.gmail.com> <as0DO7n5SCr2j3Z2@lore-desk>
In-Reply-To: <as0DO7n5SCr2j3Z2@lore-desk>
From: =?UTF-8?B?6ZmI6ICA5piO?= <cc201008@gmail.com>
Date: Tue, 13 Oct 2026 01:09:26 +0800
X-Gm-Features: AclHuK-WJbTgomKmmJ6zTCF_Y4ETa2czq3ja0lgp2okGkARO_yROQyVwwAMJAx8
Message-ID: <CAPZ+gd_1JsNyhQbEAWiE1stom+T_jgvt4F2=tb68YoSvPCnFag@mail.gmail.com>
Subject: Re: [PATCH net] net: airoha: Keep UPDMEM egress MAC in sync for
 offloaded IPv6 flows
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, horms@kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Ooo,  the new patch should be a dedicated leaf lock inside
airoha_ppe_init_upd_mem().
--- a/drivers/net/ethernet/airoha/airoha_ppe.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe.c
@@ -416,6 +416,19 @@
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

@@ -1529,10 +1542,21 @@

 void airoha_ppe_init_upd_mem(struct airoha_gdm_dev *dev, const u8 *addr)
 {
+ static DEFINE_MUTEX(updmem_lock);
+
  struct airoha_gdm_port *port = dev->port;
  struct airoha_eth *eth = dev->eth;
  u32 val;

+ /*
+ * Routed IPv6 entries resolve the egress source MAC through the
+ * UPDMEM table indexed by smac_id; the ndo_open/ndo_set_mac_address
+ * writers hold flow_offload_mutex (QoS paths re-lock via
+ * airoha_set_macaddr()), so this lock also serializes the leaf
+ * against them.
+ */
+ mutex_lock(&updmem_lock);
+
  val = (addr[2] << 24) | (addr[3] << 16) | (addr[4] << 8) | addr[5];
  airoha_fe_wr(eth, REG_UPDMEM_DATA(0), val);
  airoha_fe_wr(eth, REG_UPDMEM_CTRL(0),
@@ -1545,6 +1569,8 @@
      FIELD_PREP(PPE_UPDMEM_ADDR_MASK, port->id) |
      FIELD_PREP(PPE_UPDMEM_OFFSET_MASK, 1) |
      PPE_UPDMEM_WR_MASK | PPE_UPDMEM_REQ_MASK);
+
+ mutex_unlock(&updmem_lock);
 }

 struct airoha_ppe_dev *airoha_ppe_get_dev(struct device *dev)
