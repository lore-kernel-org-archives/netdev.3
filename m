Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0332429037
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 05:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790142669; cv=none; b=JPB1xmE76rnA1lwFTiqTcuSKPdh2sA5cL2ZzMTwbWzxqM4BTgJbvIgEQ+++/cgFhR/uLLyfy7a6KPLI2EJas2VwFYWFrFPyDHAGBeVvM5rnAhDQHHN72wf3+AaH11hDH9nox0/ZAWvueb6Eba0GHCo/dshq9wMjRVfi/2i83pfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790142669; c=relaxed/simple;
	bh=MJCci9bmgn4/H7Z9mCQ+M0HBqVzZk2yh/INN5lP/GFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uH8T2JhUw3U2Ekn8mdMQGVb/UXUa+0I+2SV3SBrhy4xTjZay7q9te7uScwnzqkebvnvc3+4kR7Y4olB5YdCgGOtrz4DbtJ4GlGRgUCfX04LbVNRt2lOihrGrmVqA0ePawlff1a+Sh0U4gKHg3JuCq+nhBU4psBnKDxRPYApPbUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BSXot2Av; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSXot2Av"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cebad4afso353209a12.0
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 22:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790142667; x=1790747467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8I4xevnwT3ppSAEaRbNTpjJDMceK72lG36tesANdB7I=;
        b=BSXot2Av6LecvFd6FG+QE1ubg6czSc8CI3Fj9qdcSUxPhvYQ6sfR1hGVH6OBXZd4XL
         epTJ4ihtvLF/RAzNMDTiiqgzQBpOM7zu2wPbfZSFC2kR8ssfLW2j4YbR5eiFyyQ8HlFD
         jsedSJSN71B+escyYjd2MLjx6Z99L5cKcofJjJqlO/hD4isenL5v2LENi21DfkriBCRd
         rtwEAKC9OVPV3a/1jy6YSQ0/EKPDuV0La10U2jFL7pFnW+mq5EkTZ+mlqXvCjMpg2nBS
         tq2K4kzoZZhJgARXswxfwtDTNlD0BiiGOGvjk/HnJV14skEy9KF4aCJ6tGJODtRRhsdX
         rWPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790142667; x=1790747467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8I4xevnwT3ppSAEaRbNTpjJDMceK72lG36tesANdB7I=;
        b=fhi83xiboEbhF+HWYIgnS2OQliAODZ7ggfYm0UtqiuPgWQoNansdtoRyz5+2W+qSMS
         74/GPGGx4eDcR+PtP6cSYJ4EO3yL3IdZ0h16AfDxDJoT0ddnBFY0MrcpRZXU0+0ZbIk3
         E1HFKk+rvM+nsfcShZjp8jiR5kasmB3MunkF/8JPGWDz4Ddw3DtvhLI0V0sXo769GdXy
         6DQolikBeB6k1sJwQU0GRP1SDU67qxPUJOOCLqMsB92IbUCiT5s2U2Kr93kr/coP2ljK
         ToddohhC1fcZAS/Sg9rvaWr06YcIKf6E/17QBB9wJ/jZpyAO4uFSR3F4JW0JxX18+vJ/
         1v8A==
X-Gm-Message-State: AFuF++mWVhN5nQ+O04fjk0GaR5dFk2i7TrTlCumnNVh4xYlvZuxP48nN
	H2AzHl7mnx2R39fyX+8EGLY7n3aRTgKQMd/Y9qzDxeAr05zDx3H0YuJFymWuW2f2
X-Gm-Gg: AYBFou0M/c5Y7Bx5IxkBFKN7+yGySkx+S/OV1HXcypQx3v0k08y7wtcFOMxKKli2gCP
	hcAqQx+YdsYkXyY8WqGCAC9Y/NZ0yOWt//MaVSh1vLQUQgn6UOUKM+CeX1FR3WIuX0hh0QaHqNF
	3fTseMz/1qoYysxit6dyRfhjFlNwh65PbSPQmZyx8AjN8R2yvB+w9OgJ656A1howGvGk3HXiOdg
	Mp/AY9k0HrpuYPctQS4SAI/+Cfsl4deuNrO+dIcyolZWyfM2nQ/AHEZzLGr2t9BmDKbVTGt7H2W
	wv8EMLGWivmovSSWyo4bOELw5gUxmY10g74Xv/sk/8KQAc5r1W5wuWO3eDhXloxSUKpi4SU+hEP
	4AjURp5hxvql4Hqdc9L/Ls6o3j75slrrkqCMrk2Q+cJLff4ABZ0AEXO7RpG8JYuphZVj+C9Sebz
	eccYWnUaptnvRitshjxs8cRjc1iw6k9rRcN+aKWzfIQRhcvH4Jp70/VXNAA/XobZY/pq8jIX2sd
	8yZYoMSpDl1mBjp5Vn46kaSvvELcYbNZLLNRczYNGXGhzGkyEMj3fM=
X-Received: by 2002:a05:6a21:ed0a:b0:3dd:a197:cf27 with SMTP id adf61e73a8af0-3ddf828a55fmr1675049637.75.1790142667003;
        Tue, 22 Sep 2026 22:51:07 -0700 (PDT)
Received: from abs.sf.dndws.com ([50.35.86.68])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87d1dffd6ddsm691486b3a.48.2026.09.22.22.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 22:51:06 -0700 (PDT)
From: Tao Gong <gongtao0607@gmail.com>
To: netdev@vger.kernel.org
Cc: "Chester A . Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	=?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Tao Gong <gongtao0607@gmail.com>
Subject: [PATCH net v2 1/2] net: dsa: mt7530: use consistent egress tag for trapped link-local frames
Date: Wed, 23 Sep 2026 05:51:02 +0000
Message-ID: <20260923055103.949540-2-gongtao0607@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923055103.949540-1-gongtao0607@gmail.com>
References: <20260923055103.949540-1-gongtao0607@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 3ac85bcfd404 ("net: dsa: mt7530: preserve VLAN tags on trapped
link-local frames") changed the egress VLAN tag attribute for trapped
link-local frames in BPC, RGAC1, and RGAC2 from MT7530_VLAN_EG_UNTAGGED
to MT7530_VLAN_EG_DISABLED, with the intention of passing frames
through without VLAN tag modification.

However, in MT7530 hardware, MT7530_VLAN_EG_DISABLED disables the
protocol-level egress tagging override, causing trapped frames to
fall back to the egress port's active VLAN table (VAWD2) rule. When a
bridge with VLAN filtering is active, the CPU port is configured with
stack mode, causing the switch to insert a VLAN tag into incoming
untagged BPDUs (01:80:C2:00:00:00) and other link-local frames before
delivering them to the CPU conduit.

Because BPDUs arrive at the CPU with a VLAN tag (EtherType 0x8100
at offset 12 instead of 802.3 length <= 1500), userspace STP daemons
(such as ustpd) and the kernel bridge drop or ignore them, breaking
STP convergence.

Use MT7530_VLAN_EG_CONSISTENT instead. This instructs the hardware to
keep egress tagging consistent with the ingress wire format: frames
received untagged on the wire remain untagged when forwarded to the
CPU, while VLAN-tagged frames preserve their original VLAN tag.

Fixes: 3ac85bcfd404 ("net: dsa: mt7530: preserve VLAN tags on trapped link-local frames")
Signed-off-by: Tao Gong <gongtao0607@gmail.com>
---
 drivers/net/dsa/mt7530.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 3e61eb3c2b1e..20bb07fac0f7 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -1309,39 +1309,39 @@ static void
 mt753x_trap_frames(struct mt7530_priv *priv)
 {
 	/* Trap 802.1X PAE frames and BPDUs to the CPU port(s) and egress
-	 * them with the EG_TAG attribute set to disabled (system default)
-	 * so that any VLAN tags in the frame are not modified by the
-	 * switch egress VLAN tag processing. This preserves VLAN tags
-	 * for reception on VLAN sub-interfaces.
+	 * them with the EG_TAG attribute set to consistent so that any
+	 * VLAN tags in the frame are not modified by the switch egress
+	 * VLAN tag processing. This preserves VLAN tags for reception
+	 * on VLAN sub-interfaces.
 	 */
 	mt7530_rmw(priv, MT753X_BPC,
 		   PAE_BPDU_FR | PAE_EG_TAG_MASK | PAE_PORT_FW_MASK |
 			   BPDU_EG_TAG_MASK | BPDU_PORT_FW_MASK,
-		   PAE_BPDU_FR | PAE_EG_TAG(MT7530_VLAN_EG_DISABLED) |
+		   PAE_BPDU_FR | PAE_EG_TAG(MT7530_VLAN_EG_CONSISTENT) |
 			   PAE_PORT_FW(TO_CPU_FW_CPU_ONLY) |
-			   BPDU_EG_TAG(MT7530_VLAN_EG_DISABLED) |
+			   BPDU_EG_TAG(MT7530_VLAN_EG_CONSISTENT) |
 			   TO_CPU_FW_CPU_ONLY);
 
 	/* Trap frames with :01 and :02 MAC DAs to the CPU port(s) and
-	 * egress them with EG_TAG disabled.
+	 * egress them with EG_TAG consistent.
 	 */
 	mt7530_rmw(priv, MT753X_RGAC1,
 		   R02_BPDU_FR | R02_EG_TAG_MASK | R02_PORT_FW_MASK |
 			   R01_BPDU_FR | R01_EG_TAG_MASK | R01_PORT_FW_MASK,
-		   R02_BPDU_FR | R02_EG_TAG(MT7530_VLAN_EG_DISABLED) |
+		   R02_BPDU_FR | R02_EG_TAG(MT7530_VLAN_EG_CONSISTENT) |
 			   R02_PORT_FW(TO_CPU_FW_CPU_ONLY) | R01_BPDU_FR |
-			   R01_EG_TAG(MT7530_VLAN_EG_DISABLED) |
+			   R01_EG_TAG(MT7530_VLAN_EG_CONSISTENT) |
 			   TO_CPU_FW_CPU_ONLY);
 
 	/* Trap frames with :03 and :0E MAC DAs to the CPU port(s) and
-	 * egress them with EG_TAG disabled.
+	 * egress them with EG_TAG consistent.
 	 */
 	mt7530_rmw(priv, MT753X_RGAC2,
 		   R0E_BPDU_FR | R0E_EG_TAG_MASK | R0E_PORT_FW_MASK |
 			   R03_BPDU_FR | R03_EG_TAG_MASK | R03_PORT_FW_MASK,
-		   R0E_BPDU_FR | R0E_EG_TAG(MT7530_VLAN_EG_DISABLED) |
+		   R0E_BPDU_FR | R0E_EG_TAG(MT7530_VLAN_EG_CONSISTENT) |
 			   R0E_PORT_FW(TO_CPU_FW_CPU_ONLY) | R03_BPDU_FR |
-			   R03_EG_TAG(MT7530_VLAN_EG_DISABLED) |
+			   R03_EG_TAG(MT7530_VLAN_EG_CONSISTENT) |
 			   TO_CPU_FW_CPU_ONLY);
 }
 
-- 
2.55.0

