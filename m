Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E450248E0D9
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 17:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791824641; cv=none; b=K3nwvnv2dOYBr2ZEhce//obHC0xiMGEGxHHgvPNOUnJ0q378S9n6pKaUIKamvzL4B0Q4gJ+NHTyrqi56DeVg3+nq1h5AnAUnFwqGGy2QK3JJHmxaTRmYOETJUWx8TJYoscpJCaAQgb/pOVnno5IlE2RewuR0CaowgcKzfqnQvYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791824641; c=relaxed/simple;
	bh=rObaHEN0QjL/e3bE9GxNJ1JuKu/yoJDgC4pESkBbrFQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EOP/yk1FHuSotL8pbJQS5f1mFqLUitPh/57c60t8FNTpCMTjbC1aazCSQDVB1rp1o89F2n2lj01caO/1UtRWdJFUb9fTOmSb7u3dGcrG6tEd+/f0Hcu2rnp6ggbvzLSK4f3MsJJk3M5SyJpauVogGbQSYu5wp5+aTDUGu13lL54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QKTUrjrq; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QKTUrjrq"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49e6b771d06so5190095e9.2
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 10:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791824638; x=1792429438; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PSgt78AWEnmqijJ1WxZbVJPA+t7FccT7CHJDalT6CXc=;
        b=QKTUrjrqFNxb/DKqu4cxqnw+Uo3hcSy8c7otyJK3BODMfARqbERIptS8ERAEA8gzrE
         Ptd/vC4pYY1ftMs98ymGBf233aM0ho+6Cwxs2ybA7mmleu7yluJAcdfZC8O2N5Wmjb8p
         HbEvppnYKx+fJIsxKg5yQaw3wvg2nELtTTqOIWayMn2LbY+5xCT8ASWojH3c99qumI7g
         BzjQcUzXdeO5snRTYrJxoLVySjbSxOq/btRYZWpVXE/z8XvGrhZLKlbb83nEQTcwOebJ
         OJsZoNw+fzrAXbpA3Ck4Jxin5FTU4VphXSnK5UT8WK7O01wMyP1yZhj2uxl4L/UcHUcd
         SNHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791824638; x=1792429438;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PSgt78AWEnmqijJ1WxZbVJPA+t7FccT7CHJDalT6CXc=;
        b=a60cc1uQqLzWtJZ7mVBuy3oDhxZaOSkJnXnsRFpY7q3XIdSJ13w9ucrUQOZi7qndkm
         Ar1cOd9FnhaAQXu5NawgqLndoJUBWaEtNnD18T4sY1CNY21y6EIt/6xgFhGgp7TZ0VZI
         yMlyRlKkUTmOz5rAFnMKPg0Rkz/YFlLkOQIZHyOtqOzu/tll2lcx6O2I94Pz7CduqaRB
         W7uHe/iba/EFiRUD0YYG/RgHtJLWGlFdS3VdIuECyhrCJuAkn8wrwD5YDPHbeevD3X7k
         V2zQcwmlhwo1ovY/OAxW4nILVsrO8bsIp37kVdZNpj27aRr97sJ7H7MxQvaNz3UtACDo
         sNZA==
X-Gm-Message-State: AFq9FYI6MwBbB2+m8FSadSnPyTzPfdkU3WHqdtukMv7bifBViByfyKUT
	Xz3qkO0Pz+AvTfvVG2M6aJo1lBPZIQMf3KD6OPEirjuUQbIxCHVA3nSJngx05rRQ
X-Gm-Gg: AYBFou2BgrXypyVUk+P9RH0a6xPQoDrm1qyCdupB9IBuTqjPKGmeo2NLC5liLMSzLVj
	+HNzWeE+/YP3FWLSjP0C7DZUge1+S6RGrGwXAiEFSpv384NuyCZ+JICJ7jMROKYeHOUtf4qg5Z9
	9VOKzTqgqLK9GwLfgYfK4QuDNy5SxqWrUcXxbO7XGkaqvIIiLntdGy3YKxzJ3cT/LI/P/2J96YN
	pkmw9tkzz+GSOjosdNKCmSWh2BTFW56HLZe2Hfz4s5mUQhsFohTHWSWfu3KzTbyR6ApGu+NoWYL
	VpqzWyZywTbMVuSwVrS/aHA1WJCVLihnFr6rNcU5DYx61ZoOuXvbmVcblYz5LuqY6AlcJHV6fdR
	xWVoa/1+in32v27GghnQakHAa0Rg3r5/zrZd2aLQk7b46pMGeMuY0xBMIwJQ5jRmVnJ7y2+CtaC
	BeQlsTflBE1EJOZy3Jzj6x3qKW0/eHDz+zBhMB7zlEnxcJbYZua0Wp
X-Received: by 2002:a05:600c:3b29:b0:4a1:813f:2a5a with SMTP id 5b1f17b1804b1-4a18e477757mr189545745e9.2.1791824637929;
        Mon, 12 Oct 2026 10:03:57 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::4:c555])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a195002123sm291140605e9.1.2026.10.12.10.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 10:03:57 -0700 (PDT)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Subject: [PATCH net-next v2 0/2] netconsole: add locking to configfs _show
 callbacks
Date: Mon, 12 Oct 2026 18:03:42 +0100
Message-Id: <20261012-netcons-fixes-next-v2-0-ac8ec4c62edb@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NwQ6CMBBEf4Xs2Zq2BiSe/A/DAcoW1khrupVgC
 P9uqR49vsybmRUYAyHDpVgh4ExM3iXQhwLM2LoBBfWJQUtdKSlL4TAa71hYWpATLVG0Vvad1LU
 tzxJS8Rkwp6l3g+RnC5pvwq/ujibum7s7Ekcf3vl/Vrnxu6r+Xc1KSKFPyvS6srUp1XWYWnocj
 Z+g2bbtAyYQoSPQAAAA
X-Change-ID: 20261005-netcons-fixes-next-af0db028f570
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gustavo Luiz Duarte <gustavold@gmail.com>, 
 Sashiko <netdev-bot+sashiko@kernel.org>
X-Mailer: b4 0.15.2

Patch 1 fixes a couple of reports from sashiko by adding proper locking
to configs read callbacks to avoid printing partially updated data.
Patch 2 is mostly cosmetic but worth fixing.

Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
---
Changes in v2:
- Use target_list_lock instead of RTNL in dev_name_show().
- Link to v1: https://patch.msgid.link/20261006-netcons-fixes-next-v1-0-231cd26f8c51@gmail.com

---
Gustavo Luiz Duarte (2):
      netconsole: avoid printing partially updated target attributes
      netconsole: remove unnecessary target refcounting from the netdev notifier

 drivers/net/netconsole.c | 94 ++++++++++++++++++++++++++----------------------
 1 file changed, 52 insertions(+), 42 deletions(-)
---
base-commit: 29f144016f03608abfddcd6ebaeabafd7aeaadd2
change-id: 20261005-netcons-fixes-next-af0db028f570

Best regards,
--  
Gustavo Luiz Duarte <gustavold@gmail.com>

