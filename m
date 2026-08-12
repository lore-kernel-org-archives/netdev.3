Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A764D367291
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 13:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786541306; cv=none; b=VOZXszGRQrrJ7qd9MW2/mjJCT+lalTueA8lMaP3sA0kJxe7epIrOkhZF8Ct+0k3fwUFyD9Ypa03LbyBmhVmhKO3Nha9b2kYX4KIBYXfVZwAVmMSWmK36eTY2sBz9wQxK7V8/Ss07WFJWek6VffkfDL0XUhra+vTk3XpEaC89G1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786541306; c=relaxed/simple;
	bh=9QTT3L3Pu9w2O25uxcDUaGMg8uCVo2PoWmNv0ctZxZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YCwi+pk3Fuh50zakY7oLmF5+IGTZry9yr1B1yRwGg04jK4nyE3wtqhNJTJC0ofWwhJL75nqBEmMS0zDCyvL2RB6Sc3tobf0eb3WDjCrOjSk1fjN9Yz3XgPqWB6N88i/5/bXy2Q74gXQBNxnSKwWHtCEljzs6A4+iS9yV7oor7Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PZmJN3/B; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZmJN3/B"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-47f703a9d05so648811f8f.0
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 06:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786541299; x=1787146099; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=u4+1ivRLPQ3G7Kv8GU2D8AHDkWXF6MhoqD65+o5xLeA=;
        b=PZmJN3/Bh09iNNhZJZZw9cIaaz4y1ziZXNP9dgzVV6usNSr0hMzSSQ1cD0fIc4G1ZF
         Z8wD8SFyd/paUvVeDkI9x3UOB/dtwcO2XZkjbOTDoT7bPGtK9pIZSIG6/ej/bZIVz+p7
         LliSB2L9z3C9VjWhIwG/UGN9cHaBtBR2vgCHHCkNmSK142BxMf/cRz3670+ExF8DHaS6
         N/7wC99Kc6Rc/U5/3k2rmu4gcxSEBAr3R1Nilr9kwpi2Rjbo9KhFSWET6yLrluNQ1EuS
         TuwxNstlMpSFYvj/fMUwyFvDqzrCMVOtTugdbZapVeVqTYq0ujtJxNlB+I3/YjE6biEr
         bpow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786541299; x=1787146099;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u4+1ivRLPQ3G7Kv8GU2D8AHDkWXF6MhoqD65+o5xLeA=;
        b=YIpS732c02k6lofnljtAbX4zFGJJrB3wxLxeiwZ41nCmy0MF9jywVNYEC4Y6GwUfPu
         xnV5cycnqwRErI9mI7ZpjN6qM0LqxN51PnlZ1/U6fgU+XtaCvdSx1KwENKTLqVkKlpJ8
         3oN7kxaECtTgXXfwVMWbGXJXd6xkhgFbgxqWr5Er7UnhvdKHQ27TbHy1+rMVFnUP0EjY
         /9DRBzboG4nz9yL9LaF3RfDQE//x9FAnEz+BYDjVTUTesDgPwXzh+yUtrqjNDww9L8Xx
         /A6LpDwMu5mVQMQbewUmgbXS/j6ofik7Eji8bK6j3KdG67gEm0nwtAxT5fYu62eIUtI/
         8vuw==
X-Forwarded-Encrypted: i=1; AHgh+RpmI33VacnzquYxJ9Qw88S1wVQL/PBTzvFy+omZ86Ni9F90We3/HHNJ6ki84FV6tdk/DzXHA6g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdEKTRZQzIvnB6Dbys4dqQlusQToLGdWO0k8pOQnx4mwaigcG/
	GSb06MfOggtfT/IwVgA4ZVsK3j1NMDScocy1OBH0wZLDOkYbPaIEj7Z3
X-Gm-Gg: AR+sD102a2R/uU2haa5gaRkqpqTuvTDV/xuyOYdwWROu1iq6hE+f1KAoOuP8WjGA06o
	nchMUAE+kN/4GXknxFasfrSu08frNRVc6D6eYXSWBHIkTtfc7+bXfdpMpktj5zUAfhK/xV+GLrA
	kor7Frwym+a3HMS3DDNDvGXIowJvEiiPB/MybWQbwdz6YSFK1cW7o/xhqgwD40sDu4z9ic3XXeZ
	/mDhnSXlTZkh5k4sEvrOEwXYFC8Xm8V4mYk21oxF8yfp8G2TloegNRFl311nEY6BN+mR/VH6ZrD
	RPLBqpdYYbAJmi9GvpdavDj+Lnk3dog9k7jKvDwNwPnwjXpbdicTXcETQVt41Ot5PDsYmOp1uDi
	IrwxiYbt+jLniL9MZ/XugVbwnnm5t1MoL5zS0Al2wOOjh1D8akRpeV+5QKxB5IU8i81mXFEG6DW
	aiX3Eu74QKcq8jzXjH8txJ/HWOFnjX/f5RBv67FR2eDVawY8CywhEdmZGyqEf4O3QNoGUn8B7jU
	Q2A0u8En9ahORqvWC/v5KcjqLQ4/w==
X-Received: by 2002:a05:600c:821b:b0:495:3e08:ad19 with SMTP id 5b1f17b1804b1-4997c1459cdmr73221095e9.9.1786541299017;
        Wed, 12 Aug 2026 06:28:19 -0700 (PDT)
Received: from localhost.localdomain.pl ([89.151.31.85])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997abf917csm87818995e9.13.2026.08.12.06.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 06:28:18 -0700 (PDT)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	netdev@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V3 4/4] ARM: dts: BCM5301X: Enable extra CPU ports for Netgear R8000
Date: Wed, 12 Aug 2026 15:27:55 +0200
Message-ID: <20260812132755.32585-4-zajec5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260812132755.32585-1-zajec5@gmail.com>
References: <20260812132755.32585-1-zajec5@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rafał Miłecki <rafal@milecki.pl>

Just because port 8 is a preferred CPU port (because it provides a full
switch functionality) it doesn't mean other ones can't be used. Let
software decide which CPU port to use.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
After some extra research I discovered we can't blindly update all
BCM5301X (Northstar) devices enabling all 3 ports (5, 7 and 8).
Sometimes extra ports require fixed link but it seems to be device
specific.

 arch/arm/boot/dts/broadcom/bcm4709-netgear-r8000.dts | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/broadcom/bcm4709-netgear-r8000.dts b/arch/arm/boot/dts/broadcom/bcm4709-netgear-r8000.dts
index bbb6b869507e..ef8f3b41d696 100644
--- a/arch/arm/boot/dts/broadcom/bcm4709-netgear-r8000.dts
+++ b/arch/arm/boot/dts/broadcom/bcm4709-netgear-r8000.dts
@@ -226,8 +226,6 @@ port@4 {
 		};
 
 		port@5 {
-			status = "disabled";
-
 			fixed-link {
 				speed = <1000>;
 				full-duplex;
@@ -235,8 +233,6 @@ fixed-link {
 		};
 
 		port@7 {
-			status = "disabled";
-
 			fixed-link {
 				speed = <1000>;
 				full-duplex;
-- 
2.51.0

