Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045F2364941
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 04:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788840054; cv=none; b=u74GD1iv7xwAhiTbDo2aY21b8odEzyclxRHowCYXvWpz6rq7xiyklvatVGKxeohAfa52ZirgLcdcnOApDzuUpF3tFSFDsPEMVSWQ+prSShAhIiILrSTU8qm9RiwWBAztbD4dVTHgqEhW9LAUJGDlCpziUoL4ZLphpyc9undPgdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788840054; c=relaxed/simple;
	bh=uAS9OkpwLPHeJlMQ/U1vOU2QbffPJ/SKe3md6NOYc4U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=unsh0lSUoTQ8yOMok49CCNNpkpC7joR7eZ6n9JSqfccVUudUe5p72HuS1LKDiyOxHX1sR/XFgzFhTcATv0niGU6WX3IGHzhDRXZxB+8Oet06yMoB8B7CUx00ajB2buENeOTUiQ1LbsrEoNUoJ4q076ZUtCi6gp9jf/S3vNem6m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QIKDT0CP; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QIKDT0CP"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2d9004f39d3so50545895ad.2
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 21:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788840052; x=1789444852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=L4jnmKHloU+sKl+iuw0i8Qcd5hz/Yqk3n6VoYdv2FXk=;
        b=QIKDT0CPvWcdirpmx7+9djnRtuZMGYHHIFJW36w4+Pcq5O/jllnL7izIhj0qQFqG+H
         y8yEQ43z9ncxSo9ysxG2PP8CUn0TXDGcIG3OJldpCrdtisCELqKvCV1iMGfb8nDEtUPc
         ZQVrxiA2v8k6hXg4K8M/DXWky1w59Un2p9l8hg3OacAC6mzfqcR3PSrEqEw/CC/7rT6b
         CHSG5/CG6VMjsfeQpsQD6CjiLZI06IQLETMsJLzziJSVYVCT9wDBOyLDoLyvU1zQdHc2
         3sHW0CHoBBf9hRBk+qN0q/knSxpMCQQF2/UMDfJpSVCB+KenF07CMkkdOl7i7aaoZ9wH
         dlnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788840052; x=1789444852;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L4jnmKHloU+sKl+iuw0i8Qcd5hz/Yqk3n6VoYdv2FXk=;
        b=smpxOzR1NGbqlDPYKAuv0ppmMfZ7qjDsh9qckzAKU6na3YjRhtCjIYIE9WF+ARczzF
         fylY2LMasPbTYpGqisU9aU7n7wNNX1QWfPFczazANz9xWgLWSj+Shj0o6kz51FfjKo5h
         irOQBwV58aKXh7fLZOPnrkek4eOcC8U4FgDGV+wSocYSVL3kABEldQpPsEPfUCXjTVER
         k+0JR68YEpCV5K2EBDP+RdRsodAGmvlkM+dh+Vmdcg9xWhAlxInLmerGV74bTZhXBcjc
         reAKK5XDSawoHFik2F8DCaZwoMMi3iElGPYPA+8VezmDX9SKcN2BzUicSx8kImpcYpAU
         v8iw==
X-Gm-Message-State: AFuF++npMVnjPYzamYg0WCGMYkCQcxUA0WfRN9oUGNzBOq3E1rkR0+dx
	dOf2FYMAi45Xa1xlsWoGlmTK1w/YRtqPc6i80aoc2MRHmo766zJV6V96TeTcHA==
X-Gm-Gg: AYBFou00mqZ0ILbEuUoeX4n7IAWA5ZZYRwpXiEwVd4cu+L0a0K7oaRKSdNTiiu4429K
	g0EEyOvuAtmN0ZR+xacuAxTglu79joMKA+xfp3xdzG0ZhEBBNMGkycLgA0P9re+iKu/fg3w0Yhc
	J6lahdaW3wk54uInvSNuZ3fwhqmcrlu19ZEBPZrSDtK8zZKKRgda/WnOo+4X7qQiOP0+EWoFcBH
	qKoAVOhyJVvJx0TpskL/f+c7Byc/a9PNx2vnWbORdBgKB4TQEXCwyb1hkvBn0C23k8A3ZcZm5mZ
	GT/za8OUZ2hPf4TZskJHy8OkgQRxCYHh2G/GOcu/Vgp6CKxeA0uqgxgriZ1aQoHktEUNlxjKJyr
	vdTjMTPv7BDIQPxL7bp73IqWU9ybLE+tmjThj6kconsIU6GQge8xuloA9L/vPrTYYohj9VM8UIf
	Ktq9bigLVsz7/NMuyDAsVNLf3iAIYktAjKVQT79SIakSHxb64LfanHFffLnUczA1xM5/N7mtlTD
	A+zCooM4hZ9kYbz4f+Y3U10uIr0uYWKtrnpKdpRVs6ChFWsr7TV+7XqU4RQvKDKV/AJgUAYPZz2
X-Received: by 2002:a17:90b:2542:b0:38e:6aa7:68ad with SMTP id 98e67ed59e1d1-39b26101402mr37347669a91.5.1788840052012;
        Mon, 07 Sep 2026 21:00:52 -0700 (PDT)
Received: from CP-IN-7ZMK5M3.. ([2402:e280:411f:685:1aaf:dd1e:6319:ef96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b813fb4ddsm6042860a91.10.2026.09.07.21.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 21:00:50 -0700 (PDT)
From: Amitesh Singh <singh.amitesh@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	andrew@lunn.ch,
	olteanv@gmail.com,
	kuba@kernel.org,
	davem@davemloft.net,
	Amitesh Singh <singh.amitesh@gmail.com>
Subject: [PATCH] net: dsa: tag_rtl8_4: push VLAN tag into payload before DSA CPU tag
Date: Tue,  8 Sep 2026 09:30:41 +0530
Message-ID: <20260908040041.124640-1-singh.amitesh@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a socket buffer has a hardware-accelerated VLAN tag (skb->vlan_tci
set), the upstream NIC (e.g. imx-dwmac with tx-vlan-offload fixed:on)
inserts the 802.1Q header after the DSA CPU tag, producing:

  [8100 VID][8899 CPU tag]

on the wire instead of the correct ordering:

  [8899 CPU tag][8100 VID]

The switch reads 0x8100 as the EtherType, does not recognise a valid
CPU tag, and fails to strip it on egress. The raw 0x8899 tag then leaks
to the peer port, breaking any protocol (e.g. batman-adv over a VLAN
subinterface) that relies on seeing clean 802.1Q frames.

Fix this by calling __vlan_hwaccel_push_inside() to move the VLAN tag
into the skb payload before prepending the RTL8_4 DSA CPU tag in
rtl8_4_tag_xmit(). The helper frees the skb internally on allocation
failure, so returning NULL directly is correct and consistent with how
tag_sja1105.c handles the same pattern.

Signed-off-by: Amitesh Singh <singh.amitesh@gmail.com>
---
 net/dsa/tag_rtl8_4.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/dsa/tag_rtl8_4.c b/net/dsa/tag_rtl8_4.c
index 4da3beebef75..bc11ddc4e178 100644
--- a/net/dsa/tag_rtl8_4.c
+++ b/net/dsa/tag_rtl8_4.c
@@ -128,6 +128,19 @@ static void rtl8_4_write_tag(struct sk_buff *skb, struct net_device *dev,
 static struct sk_buff *rtl8_4_tag_xmit(struct sk_buff *skb,
 				       struct net_device *dev)
 {
+	/* If the skb has a hardware-accelerated VLAN tag (skb->vlan_tci set),
+	 * push it into the payload before prepending the DSA CPU tag.
+	 * Otherwise the upstream NIC (e.g. imx-dwmac with tx-vlan-offload
+	 * fixed:on) will insert the 802.1Q header *after* the CPU tag,
+	 * producing [8100 VID][8899 CPU tag] on the wire instead of the
+	 * correct [8899 CPU tag][8100 VID].
+	 */
+	if (skb_vlan_tag_present(skb)) {
+		skb = __vlan_hwaccel_push_inside(skb);
+		if (!skb)
+			return NULL;
+	}
+
 	skb_push(skb, RTL8_4_TAG_LEN);
 
 	dsa_alloc_etype_header(skb, RTL8_4_TAG_LEN);
-- 
2.43.0

