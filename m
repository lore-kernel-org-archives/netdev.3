Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com [74.125.228.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB1D3B2D39
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 15:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790523377; cv=none; b=jGUstwqPIF5+RWp6x4IZdIDR2mpB+pOtMHkwjwPWsYuFwt61rGIcx/HGrKpWxOoiTIsIlXTB3tVlqtR+pxT1ZJ/VfoKeNbnsPpNhfBUTHocvTiEL7yg5Nj6ZGp1ciqceqZ9CkwvfihLyh5NmjKB63Q4Ph8R7sV0dWEmo0B/UTmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790523377; c=relaxed/simple;
	bh=dafvT+8i4y0bU9hQ9upGpm/t4DGzU+AITVviEAgTY/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P/TRRPxPzolahIGZ62HwzP60WLrwB0FLJI3mrfZ6w9y9+O1hUOyywj69QorOVRvupX8S9lHts2imNPw04eZTbTlaH5YewtOyszwVSHNjEk9jFFbcoDOU0RTD+8t25KjFED+gEAEuX7aws2+GLYP5DLPbaVboD9KYmQVGgUJ/npc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M2VHMwBJ; arc=none smtp.client-ip=74.125.228.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2VHMwBJ"
Received: by mail-ej2-f43.google.com with SMTP id a640c23a62f3a-c2a9edfc851so268459966b.0
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 08:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790523373; x=1791128173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9DyS1uA/5WR71Bye02IzLOSjpO+4bbdwbymAUdLccjY=;
        b=M2VHMwBJCxMecAMGaLZ0faZtfA8ZVRJGCLq6apBZbkNoaliriku0s7hOj2v98r675w
         xXcLC9EUAaBOFOipClqiXthQJxvS+1emN0sIKRAfnXJqlfzfWSZHIZH33eXWOqZT37Fu
         YfHhbg2gocZXi/ZGpVIfsZbnfLOWGxCpmI24arAIWGGk+2Et5JMmzWsuYyfqGl3VnBad
         sUAx7hnr4Dyd0S/8tJnJ/kbqHdY9I5+nwM4FOycOrTxH4uIH8U4AcbfO1PKhKz/puLJH
         c0wdnLwbv7ZjwfSNxjOCrExvHMr9/b75vCxuCQ8yYb02/uwwUdoZO6AH4cYY7u0s/0sJ
         Nmiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790523373; x=1791128173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9DyS1uA/5WR71Bye02IzLOSjpO+4bbdwbymAUdLccjY=;
        b=wMZHc5nc0d8pUH7xlr7Uz1U6qi/hvPftDYUc6babj0Gy5VQv22Zw3EIGaQIzu199N2
         nC4I/byKtPYQ0/HYgbrQjeMCw0SImG7J2khepPrQ3af5bu9DCcIoWgl37vuj0N7b6cYg
         5U6ijFv6kau5KaTvzHKq/fa6pnB6FJ/0P/38kikSgosnA0mRnRyn3zAJB4Ztd//qNgIr
         Jb1luIYsmnbowe5kwkZh21GxUp9q06jSUrmM52sgPmnaiNOdDn4aAf4b4vkj/gkwAOIc
         Zb9D6l5U2iw3s/DL+8ssVlVnw/F2csL2KUuI3X4nCUUT1WQHPZ2PDTpEEYJ+/IbqfoS2
         OujQ==
X-Gm-Message-State: AFuF++lsfZVILJHDqTExeBs3KTI4vT3aCg+62uM1PazwFY+4fPFhsCak
	dqHPISVPNCqpewX6As2S0I/mc67mG68Fib1FtvcSJhrx30GtgSi8y7Ja
X-Gm-Gg: AYBFou35OcV2z16ias1nooGvH7PY6mVQKN+Pl983oIiU8BlMI0iHrhveEEL2NkQzJNH
	PaAH0ft5T1xDNbzy4yGzCNMh6G2yFf7Mz8F2r6F2zbe6ngNtwQIONaAORwkiVCbfdf/wbJDd1Pw
	iQ6OP6I0Bl1inyXAdwXxgC7P+vFboJ+mz2GB/VQ4HJZt/cQxjUUJBMoe0EuzVr35R3wUMHlBZY2
	vjdORQtZRYIbIiDouiyUq795CKx1WghEs/hFDRk8YavL05qAozQenXmJR6MI+WYUOnVhsF+EbE9
	RhkV6SgCbfRI0UhDhDZhKykzF9x4nKykwQf2tP5Nw4kK5324zML6gloSfdweqa/XTVj7a58UrSV
	D3AGw5ooiZKwHPll8M37V36+nYH7Cd7WoyEdHs4LL08p1WK3Odq0EwE7MtnEmjJg8QHxIC9OywA
	O3EH8aJGOVeRZLse0EyFFFskQczZ35jwKBhw3fg3hTO3Ee9ATE+O8V8RSnFglIcdepq+udthycJ
	Mjh4pZkv3t5W7p8Pw+xE3KeGIxwduM9lQ0SXZ8KaQqHZwJ4WC8TC5U4
X-Received: by 2002:a17:907:9691:b0:c25:ee92:2d0d with SMTP id a640c23a62f3a-c2ae97a1113mr580454566b.9.1790523373209;
        Sun, 27 Sep 2026 08:36:13 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa1:165c:44c1:e5d5:dfb4:8450:1cdb])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2ae7587edesm347465866b.34.2026.09.27.08.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 08:36:12 -0700 (PDT)
From: Yongzhao Chen <yongzhao.derek@gmail.com>
To: Ziyang Huang <hzyitc@outlook.com>
Cc: netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [RFC PATCH net-next v3 4/5] net: dsa: qca8k: flag QCA8337 internal CPU PHYs for SmartSpeed
Date: Sun, 27 Sep 2026 17:35:58 +0200
Message-ID: <20260927153558.2299-1-yongzhao.derek@gmail.com>
X-Mailer: git-send-email 2.45.2.windows.1
In-Reply-To: <SEYPR01MB58827E0D18ACC93AF98A4109C98E2@SEYPR01MB5882.apcprd01.prod.exchangelabs.com>
References: <20260923215858.1653-1-yongzhao.derek@gmail.com> <20260923215858.1653-5-yongzhao.derek@gmail.com> <SEYPR01MB58827E0D18ACC93AF98A4109C98E2@SEYPR01MB5882.apcprd01.prod.exchangelabs.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Ziyang,=0D
=0D
> Have you correct the DAC settings of the IPQ5018 PHY ?=0D
=0D
Thank you for pointing this out. It turned out that the DAC values were=0D
not being applied on my board.=0D
=0D
The OpenWrt DTS for this board sets qcom,dac-preset-short-cable, but=0D
ipq5018_config_init() passes the unshifted value 0x10 to=0D
phy_modify_mmd() and at803x_debug_reg_mask() while the mask is=0D
GENMASK(15, 8). As a result, the high byte is cleared instead of being=0D
set to 0x10, and bit 4 of the low byte is set. The same code is in=0D
net-next today. All my earlier A/B runs, including the ones I reported=0D
to Andrew, were done with this code. I will send the DAC fix as a=0D
separate patch.=0D
=0D
With both writes changed to FIELD_PREP(IPQ5018_PHY_DAC_MASK, 0x10), I=0D
repeated the A/B on the same board: six alternating warm boots with=0D
identical kernel and rootfs contents. The only difference between the=0D
two groups was whether SmartSpeed on the QCA8337 CPU PHY was left=0D
enabled or disabled before its initial reset. I kept 0x10 and did not=0D
try other values, given your warning. In all six boots the read-back=0D
after the write was MDAC 0x6868 -> 0x1068 and EDAC 0x7800 -> 0x1000,=0D
so the high byte was 0x10 and the low byte was preserved.=0D
=0D
The result was the same as before:=0D
=0D
- SmartSpeed left enabled: failed 3/3. PHY4's CTRL1000 read 0x0400,=0D
  register 0x11 read 0x1030, and the CPU link did not come up.=0D
- SmartSpeed disabled: 3/3 came up at 1 Gb/s.=0D
=0D
So correcting the DAC values alone did not avoid the failure in this=0D
setup. I don't think this rules the DAC out yet, though, because of the=0D
ordering. In these boots the QCA8337 CPU PHY (PHY4) was reset at about=0D
2.3 s, while the IPQ5018 PHY's config_init(), which writes the DAC=0D
values, ran at about 40 s. For roughly 38 s PHY4 may have been=0D
negotiating with an IPQ5018 PHY that still had its reset-default DAC=0D
values. I have not yet measured when PHY4 first drops its 1000BASE-T=0D
advertisement relative to the DAC write.=0D
=0D
Do you know whether the vendor code has an ordering requirement here,=0D
for example setting the IPQ5018 DAC before the switch-side PHY starts=0D
autonegotiation, or restarting the link after the DAC has been set?=0D
Any pointer would be much appreciated.=0D
=0D
Thanks,=0D
Yongzhao Chen=0D
