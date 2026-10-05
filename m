Received: from mail-yx2-f6.google.com (mail-yx2-f6.google.com [74.125.224.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9606431714A
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 06:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791180036; cv=none; b=ZsAE1Cq6q369bfe7pirUTj4RNoV3BsnvG2OOnzI1tTSSwSC3toDX2j2C0+VKGmugKe27Db7hklyIoPMSxe+FjqF6kvk5wKe98XDADicdoBXiP14miXkR3EnTHzI9wJaUifnS6qcEtKeVgPhcMGcnt+zW006x6fed3THizf1czlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791180036; c=relaxed/simple;
	bh=ZsHnozCFRe8N55w99HabQxN8D2KdU1j/ypL3jxREuRY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OzdSsvmFB+hCbHL0ek7QWP1pjY/Ae+V9SIe1M3h7BFVB6fJua3EvPzkCgfK/hggn5n4/+OLM72dgGovrFO3Csi+R9xd0c0hzNk8HT0rBluZCN2r/+o+kUYESeH3D6HLJvFSVGSeE9GYh0MNNi5MhMkSDAD62styeZaKwsCPb2ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gRYULtAt; arc=none smtp.client-ip=74.125.224.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gRYULtAt"
Received: by mail-yx2-f6.google.com with SMTP id 956f58d0204a3-66e61475fa7so576222d50.0
        for <netdev@vger.kernel.org>; Sun, 04 Oct 2026 23:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791180031; x=1791784831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SUcUukBNYZdbFMBXRaDby96SHcIwSALeSewClcQZ668=;
        b=gRYULtAtKBBOgGWAUJrpuqkvShG5GGPH+lwl9LqyUW9LL/567VtLTRj3cC16sAQlpe
         1y+o53sdU9IkQSnQpdf6BUekiZVQB0313pKBHkMcGCbJTbH0lxN3KU08swiory2tgc06
         XeJ/Jv/FbrGWkgtKWpPuQHzLm/W0DG3AdTKZErPxaujZaT7XaYrD6DG1B5gRi81OINT1
         Zs6w47QjWG/T88Dvqauzvx0GQJHy+YSdkm/ubS37p+J5mCM6yZK0yJV0i8HyiUpK5d7+
         RHftWIBYS/aY/okIrhc+lMbezq6/ThqXUpWJY47JU4MsKE8Mqpex+l1iL7zttfVyi9zg
         P7ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791180031; x=1791784831;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SUcUukBNYZdbFMBXRaDby96SHcIwSALeSewClcQZ668=;
        b=aP9mbA19fTs9ezUlMl4jn7P3H72xqXi8+fxhwyKGn9ttt/0++8oS+gvZM6ZdxVYskI
         QrNSN5+rzJF4QTEG4bYGU44GA2R7qvkQ1VYOzx3Onc9t1u0Sr49BEMW8qojMl2rxC7JH
         seY0bDmHp9n6T163ZzUWTOWk+V6efEVv+fSjvgzjrCHUBmpk/eNga8CZOveyIOWmFG8p
         rT/n2zH0uFkkJZ1ur+NRBQnaE0zbUhx7KEnLA9o1qgokqXdE0pJAlgSLSq1NMqlzMTbR
         14pZG/eQ6+9rFJtDMSW84eyg5SOzjDQDBVZH3Y7soSN6QiO5NpJyGhIHB/304nuuZlVV
         pMmg==
X-Gm-Message-State: AFq9FYIzJrsRPp2eNkAoByX+nqRjyRF2fxE3lidVI4yjT7hcS+Eh9W/B
	HgljXiyJCnfsSO0xzv+RWRTuKq3aMqf9sTLnY8ec5sRmk117dPCMmS6bvpLqznYcLWGGxg==
X-Gm-Gg: AYBFou3OXyR+05AZZu7V+lUL6WArWMFOZFCU7Sfj/jTZQgEnOKBuT5HrX826Hrs/2t2
	5qNGBhByesv2j9NXUUzZrmI/f9bVWkQM+XoN7IV1uv8DE5ZVvHGH/WD9cy8rclLdAEgUtQHvgQm
	C+CJ+vlpDmzE8HPk5IX/pHBG5vEzKmoatf7uD4q11oc5laRX7u+aOItc1WdDGJh2sJN6uu9wCUH
	c/N8/oJ9kWZVMx22gpNzzKUKKUKScsrrV7bSB14oRkWksFBGQpndcztoHgX06g4vQXAFBQiY7ns
	7Nd8Wom6IcCOOtqolG2VGVK7sd/Xyh+rKl1jmwx72lBPCw6AgYtOj3IT2sIwpmBHQINjXHHLwhm
	K0jAxnKMZzuq9MCPElFLn4oA2sQZCC/8FbEtvLvyRhSyxIQiggsxUJTohe4K69ZWxzAkjT0G5Cv
	yyA5mHrGVYM6D0bmc7nmZIOo+D9GCFtcEW/zSqEd50qj208VO9lCe6Or/oo1n0KbaXBiXsm7+5+
	u4z1EYvu7y7uhUWRdcXJDEfATA0jM0IkDMgFxxhuHNEW+BtojfI
X-Received: by 2002:a05:690e:4090:b0:677:c85f:2abe with SMTP id 956f58d0204a3-677c85f396dmr1858797d50.7.1791180030581;
        Sun, 04 Oct 2026 23:00:30 -0700 (PDT)
Received: from Xinshengs-MBP.attlocal.net ([2600:1702:7d20:7d20:edd1:61d6:442f:e3ff])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8ae33fe81fdsm35786777b3.47.2026.10.04.23.00.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 04 Oct 2026 23:00:30 -0700 (PDT)
From: Xinsheng Zhu <xinsheng.zhu.ny@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net] net: usb: r8153_ecm: reject short register reads
Date: Mon,  5 Oct 2026 01:59:43 -0400
Message-ID: <20261005055943.35180-1-xinsheng.zhu.ny@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pla_read_word() and pla_write_word() read four bytes into an
uninitialized stack variable, but only check usbnet_read_cmd() for
negative return values. The helper can also return a non-negative
length smaller than requested, leaving part or all of tmp
uninitialized.

pla_read_word() may then derive the register value from uninitialized
bytes. pla_write_word() may include uninitialized bytes in the buffer
sent to the device during its read-modify-write operation.

Require the return value to equal sizeof(tmp) before using the buffer.
Return -ENODATA for short reads while preserving negative errors from
usbnet_read_cmd().

Found by manual code inspection with LLM assistance. The issue has not
been reproduced at runtime.

Fixes: c1aedf015ebd ("net/usb/r8153_ecm: support ECM mode for RTL8153")
Signed-off-by: Xinsheng Zhu <xinsheng.zhu.ny@gmail.com>
---
 drivers/net/usb/r8153_ecm.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/usb/r8153_ecm.c b/drivers/net/usb/r8153_ecm.c
index 8d860dacdf49..0988a3444c55 100644
--- a/drivers/net/usb/r8153_ecm.c
+++ b/drivers/net/usb/r8153_ecm.c
@@ -23,8 +23,10 @@ static int pla_read_word(struct usbnet *dev, u16 index)
 
 	ret = usbnet_read_cmd(dev, RTL8152_REQ_GET_REGS, RTL8152_REQT_READ, index,
 			      MCU_TYPE_PLA | byen, &tmp, sizeof(tmp));
-	if (ret < 0)
+	if (ret != sizeof(tmp)) {
+		ret = ret < 0 ? ret : -ENODATA;
 		goto out;
+	}
 
 	ret = __le32_to_cpu(tmp);
 	ret >>= (shift * 8);
@@ -55,8 +57,10 @@ static int pla_write_word(struct usbnet *dev, u16 index, u32 data)
 	ret = usbnet_read_cmd(dev, RTL8152_REQ_GET_REGS, RTL8152_REQT_READ, index,
 			      MCU_TYPE_PLA | byen, &tmp, sizeof(tmp));
 
-	if (ret < 0)
+	if (ret != sizeof(tmp)) {
+		ret = ret < 0 ? ret : -ENODATA;
 		goto out;
+	}
 
 	data |= __le32_to_cpu(tmp) & ~mask;
 	tmp = __cpu_to_le32(data);

base-commit: 6dc989ea46b96ce170840174b4a38c4a387fb005
-- 
2.54.0 (Apple Git-157)

