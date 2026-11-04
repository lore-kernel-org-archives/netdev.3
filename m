Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793816485;
	b=Wu91mVgaNHV9ZKI8Ap+1eXGKZMQHOHO4nznljj9yEYmu/PiTsUW6KTqH1SuDQu/itGSi
	 or6sxfx0RKJz+JeFRUfkbj02mu6rDmHjaorQ+ut6vN2rKwPS0x7utkCexUpi6egfQWLv8
	 uSosRIZMkzbfBaiIekeoMyrsupGYIwugw3X7igELfrO/f93iW9hnfkT+WfufiTIUsHrOp
	 lRYYIvBICbVLu2qhNttbh04jX2pmbco8StoK5PAm9I1IEJWpLFzqn8Blzq65qEsbRBVnb
	 1PMBEpnQd9mAMxXDuuSoCXAW2c/5aA8QvX/oX4hhblPSbleBezRGDlJiA3LEpqselqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793816485;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Mky9j+WOnq3WliGY/AldJ7Jn18rgTtc7t2LkEe9tf5Y=;
	b=EegyZ2sMJUai5p5OuDURsWsAnu6Rx7zaOoSFRkxs5sVy0uiyMor8nMspJV80DwoBCx80
	 ah77CvXZOSBWNMJqMh0pPSZPaSMAIVz1co+sLQ2ff04vOJwuM3pk1myW8MXS/dupb7jee
	 vo56MD7sTBQK3WuoEKhh4E8rVjdhV6QPvcgg5SMmrPo8NRhwh/vizB5hllU1z32p3cL/i
	 dgPRUln6hL2ARN7GBmtd12Qk+7ED4lW2ezQ9SviR85PF776mz6xRqmpKRafYIWjFsnKiT
	 Jc9yR83cFqnWBy68b1CrsZVAhjlEGQFa6QFWPXuMEvR6lBcmFU9EEwyHQFv0Og2UVGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=el7ZrjEl;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9BE60A3806
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 18:21:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE9BE60A3806
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=el7ZrjEl
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48bbb06e746so679612f8f.3
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 10:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793816483; x=1794421283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mky9j+WOnq3WliGY/AldJ7Jn18rgTtc7t2LkEe9tf5Y=;
        b=el7ZrjElkjGEwbcTxvHJbqH+Z5l0fG1MWnuGf50FD/jKywrXSo/L9eO78LgbLa8l+H
         3/T2X05Y5sNOBDN3JakoeF9hmmn9JaguzMNoD7zt/hfAqDYdjOLXnA3fFWNJjxHCUW9j
         W7dobHmaZyxd43ulo69mZESUlQmXEX7YAUIkZPz5ZcaIxJnilWF5MHV/NPhZAN86U8Y1
         eMJRfZXerQecCDq8nQ4eqSaXWP4GCeVRhrurAyj8monLRW/CHUHRqIXmh6AC7dQfYeot
         EE2edhN3LiQadpPN4WyJY2573sF2XuRDDirnfVHyz0cw4aDnK+a4hv5g8UwYMQMGykgr
         tGGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793816483; x=1794421283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Mky9j+WOnq3WliGY/AldJ7Jn18rgTtc7t2LkEe9tf5Y=;
        b=fKupknywCAkPa6dwjpJxmd6aZTKiczRAiYYEMbgnkv5Js/Av51w9i/+j8+OYqqZrxy
         SJupk2DjCAaDgLbxW0g5HnZqAAvc7Unjtwk/gBIVF73t8QW1uzXSO38ye5/9zFgHC/5L
         FnmNZauEhejIvUX3IJjyDsZSLscST1O77Rj2y/hEnV7OS7A1irCS7R9cT0KDnjljDFIb
         wpuvvwXfHWoYQniai6ERoNgVfd8VDEx7j9bD2YRrTkTlzmw3N+CIAbsL/jqpHtjLBSqS
         zCMrBQEA7V1HxyDwmhFM3MBt+ehqMchitgHdLFmRq9EAkBdcxTi0+/lW/UmLgXcnySc4
         IbYQ==
X-Forwarded-Encrypted: i=1; AKwUvByUWxXoAW/ERJXqI24TKAqwEWulUICnTwAb9T08D0Q0yk7ewxUW+3Q6UmpiEqGllCdt0xtemNQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+AcmXdWxA+rGkLIewN8DGvE3I7HT0/a0164Dr7nEvDUtJoYb19
	d7xYC+mwHGSiKvS1x8v9d3Sx8lm9rGS/fntDKyb3aV7Bp98Vq/6nF5Y7
X-Gm-Gg: AYBFou0uFb3WoO55OiFFVbQ8RpwoxHzzKtdV17aKMizvyqfuMZGBotc7k9YGNTV0hnY
	as+9FoBow/v1DtQuZChifCPpjfw8sB60G8LwjlhpFKxA2ZohBoVn9k2+7fAPVb4iwh2dLHuSU13
	U2LT3b4eY66ZKyg+nhbcqH8Dm9bfue6YAU+w2HPZC3rsd895ZRr8ukk+8G8IOULelPRzHHZe55M
	FpvxZGuyyi1s94mvdVQuPKsNU5t6Iwttf3QivYm5gFLpRSR9mjuowFQ3ri3Ecvv/dQjSRxXY7KR
	nS/xk5NhXOto8WJlr56Pj+7dnqOzazl4Xv7hqWc+VRbBDRwPSpkkQqbzl5SwHYhsv3yjgpE5fQ4
	or2voKrC02rf+ZBznDBXT5yKqGTJH5r0gzSnjJBmThrFxGvpCwesafiGRLEqULJGbTNk90dXpMA
	x0ssxqbSXuwjkpfM0CSWt7BAjopRKhD8nzGFpY9PHHCEPedVQZkH8t5r3uvb5S18JruGkDbqQJn
	QZsPluUEyIrI0y8V3Dhdua2yFZE6xFwj6vUhCT39BnvqcN/Dlu63Vv/ICuWnTGM4+jzeHUVdetx
	E1NNnq78N339nFqV04prdxT3VQR1mMjDhZelko2cr3NrSMq+OVWEKJ1FHVOocABhfghmaTUgOd1
	8/dnUbmRFC1YKajDS7N2KdVkBGIVTRcMxjLiz3yQFWvkB6R0ZRJPTZjqui28=
X-Received: by 2002:a05:6000:4a19:b0:488:8bc1:a2eb with SMTP id ffacd0b85a97d-48e6e308b00mr36775005f8f.39.1793816483116;
        Wed, 04 Nov 2026 10:21:23 -0800 (PST)
Received: from iku.lan ([2a00:23c8:254f:fd01:b079:a2f1:caf7:b446])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fed0844e2sm4073202f8f.28.2026.11.04.10.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:21:22 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@linux.dev>,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Russell King <linux@armlinux.org.uk>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH net-next v4 12/14] net: dsa: rzn1-a5psw: Add fixed frame length workaround for management port
Date: Wed,  4 Nov 2026 18:21:00 +0000
Message-ID: <20261104182105.1102555-13-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104182105.1102555-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261104182105.1102555-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

The ETHSW IP used in SoCs such as RZ/T2H and RZ/N2H has a hardware issue
where the internal mgmt_tag_vld signal is asserted as a level instead of
a single-cycle pulse. This causes the frame length counter on the
management (CPU) port to over-increment, so valid frames are falsely
detected as oversized and dropped.

The recommended workaround is to program the maximum frame length
register (FRM_LENGTH) of the management port with a fixed, large value.

Add a management_port_fixed_frame_len member to struct a5psw_of_data to
hold the SoC-specific value. When it is set, program A5PSW_FRM_LENGTH
for the CPU port with this value in a5psw_setup(), and skip updating
FRM_LENGTH for the CPU port in a5psw_port_change_mtu() so that MTU
changes do not override the workaround.

No functional change for existing SoCs, which leave the value unset.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v3->v4:
- No change

v2->v3:
- Marked of_data as const pointer to avoid build warning

v1->v2:
- Added info about the IP issue and the workaround.
- Updated commit message
---
 drivers/net/dsa/rzn1_a5psw.c | 18 +++++++++++++++++-
 drivers/net/dsa/rzn1_a5psw.h |  3 +++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/rzn1_a5psw.c b/drivers/net/dsa/rzn1_a5psw.c
index f8fe6f3b8e12..f3eb8646dea5 100644
--- a/drivers/net/dsa/rzn1_a5psw.c
+++ b/drivers/net/dsa/rzn1_a5psw.c
@@ -209,8 +209,13 @@ static int a5psw_port_enable(struct dsa_switch *ds, int port,
 static int a5psw_port_change_mtu(struct dsa_switch *ds, int port, int new_mtu)
 {
 	struct a5psw *a5psw = ds->priv;
+	const struct a5psw_of_data *of_data = a5psw->of_data;
+
+	if (dsa_is_cpu_port(ds, port) && of_data->management_port_fixed_frame_len)
+		return 0;
 
 	new_mtu += ETH_HLEN + A5PSW_EXTRA_MTU_LEN + ETH_FCS_LEN;
+
 	a5psw_reg_writel(a5psw, A5PSW_FRM_LENGTH(port), new_mtu);
 
 	return 0;
@@ -990,8 +995,19 @@ static int a5psw_setup(struct dsa_switch *ds)
 		if (dsa_port_is_unused(dp))
 			continue;
 
-		/* Enable egress flooding and learning for CPU port */
 		if (dsa_port_is_cpu(dp)) {
+			/*
+			 * Workaround for ETHSW IP issue, mgmt_tag_vld is asserted as a level
+			 * instead of a single-cycle pulse, causing the frame length counter
+			 * to over-increment and trigger false oversize frame drops.
+			 * The recommended workaround is to set the maximum frame
+			 * length on the management port.
+			 */
+			if (a5psw->of_data->management_port_fixed_frame_len)
+				a5psw_reg_writel(a5psw, A5PSW_FRM_LENGTH(port),
+						 a5psw->of_data->management_port_fixed_frame_len);
+
+			/* Enable egress flooding and learning for CPU port */
 			a5psw_flooding_set_resolution(a5psw, port, true);
 			a5psw_port_learning_set(a5psw, port, true);
 		}
diff --git a/drivers/net/dsa/rzn1_a5psw.h b/drivers/net/dsa/rzn1_a5psw.h
index e952afd95dca..5bec33b23079 100644
--- a/drivers/net/dsa/rzn1_a5psw.h
+++ b/drivers/net/dsa/rzn1_a5psw.h
@@ -237,12 +237,15 @@ union lk_data {
  * @npcs: Number of PCS connected to the switch
  * @cpu_port: CPU port number
  * @tag_proto: DSA tag protocol used by the switch
+ * @management_port_fixed_frame_len: Fixed frame length for the management
+ *   port to account for the HW issue.
  */
 struct a5psw_of_data {
 	unsigned int nports;
 	unsigned int npcs;
 	unsigned int cpu_port;
 	enum dsa_tag_protocol tag_proto;
+	unsigned int management_port_fixed_frame_len;
 };
 
 /**
-- 
2.56.0

