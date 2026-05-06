Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1241276026
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 19:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778094549; cv=none; b=Te+zANKEbPPuu4uJNWAZPDts8rQtV30b3Y66NRyJ3H0HV4U4YhijxMoeucZTLnflvWZQzeUGa7A3TzxiZtJQ0u8ixQSi0HRiHDbNxkn+OWgy5yMessdEehV/p5q2Zo117feBtb/ATRQJEo75dsj4MTx5lhUwMhLDoCjOubVK36k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778094549; c=relaxed/simple;
	bh=kbMarVyWZxXKMncMkYMZaQ4aRZVlKmcN1UBGb77FlXE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lbpE7rYtEgfNEmJv4Kvi3ANRxivh288v1LHNS91hEpCIgccned23Yyd6oBK1eLquq50JuBwUfeBa/YRR9/KMTacG05iEgMvvNJp0N48VhGyeYPT3BoQJiDE9yvd+I1AhVsvZvsZne4hqgodHocdl34jJncIxk6Qb03XIc5UnyL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bC8/kdsg; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bC8/kdsg"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8cb40149037so3126685a.2
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 12:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778094547; x=1778699347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cSVRfUiyveHtuhcViHRSH9EEOLcj6OoJ1VLVtuv1LHI=;
        b=bC8/kdsg32/x7eWeitPYNpiONsa133WGE6R+/kteMZXHImmymkcqtw7KckDDOhZsmu
         wmhvSY+Z69YF548qE3YeQyM2z1awZtEWSU4gCo0IZUnUxpuMSOwoR6h1WeJ7bbtKzCdo
         eVtiSAZekmIe/dHoy7bHbvXvqOnVxT+QOQ5mkLpoTRPUISQBnc6bXJARDtmlglY8b8SJ
         V7QwS+3KKF7Jpx6+Aeodyayu6qFeJ8eBDoQzjteo3Su0iKS5RZxSwGdCURQ91ytLyuCS
         1s0RjpEfMYEMVvy90wfktMnh1TQcgKGwiqDM0+EXIgCOfysX8fgvtpXOz7wJQpGjtl2v
         6uCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778094547; x=1778699347;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cSVRfUiyveHtuhcViHRSH9EEOLcj6OoJ1VLVtuv1LHI=;
        b=n2+/21m7T/+POud4ruAO4IUl6Puk29IR4c+YogpH+EukQnDZonyIOoDxY0OXj3iMMP
         vjnW9rFp6MUBBL2ZwFjPFdHqAo+IuD594XzVf/VoPziTrf4KMU+ZCYoj44nQuEVR3qjl
         eSIx5UJN1qv/kI7AcwtFevtc/NDSjGh/Lc4VHkYgW/w9XpBDM8/hYOZa5ImFTZ9Rwh8Q
         NvEiEHkTfLIfeU9Fey+c7RKsMUvH5nVn6DWsYcNBPH/zFK8jwmcDU0TxJzbWlPu0EN5c
         mf3+BeHvN9JcnPJMPrWamcpSgYJjBEf5ffuWG9iypZAs80NcADJUN/RErkZEemOEGFuu
         N8fA==
X-Forwarded-Encrypted: i=1; AFNElJ8rmEiNC9HFRC+CjaGk3pgAqxa88sYjuaQsHJXZdcMKFziu5vi8kZt705upG1/kkFKJnTO7t8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR8yTDI0rT2/xGfu1cAEXWa3DJB2d8fCfTtTIHQAjn+ylV0ErT
	VZ51vusBws3n05NjLgtDJvaSvG0RVrF54niCiWyj/jAlGFYnY7tunPex
X-Gm-Gg: AeBDieu8YWn/FjaN92FEOzdsvOlej1tzv1g48THwKcAnoCP7gWFmiEM8FwDcnXjS9Gn
	ZPnFehT0wwCb1UPZo6iBKiTGUOAkJk5NKmBoZ7FgwIW9esPGXnjdcLvOeLM5aNfqtCoYWzdsu7g
	rHa3cEasJBdXQi0KEQt6bPK2IXHMQREqr6YqaV3B3sej9CH8cij5ru9IxWLz549Zznd2d8wrhHj
	/t/DDtrK3mQsfPYeNx6bKsX9pkhpxBO7OiqQ28rq8geIvR11CVpgYpVZ2hNHmZzAp2TAbW2JkOK
	IBwjLHFaoQG0IfXNI7Se9UXC5VJ/2+kbkzvlFDpTujHgTsAUsCC+HuuaavcG0GN5DBpnZhZCHUB
	xcCGQ3s92G6Fc65syRP5dsw7wGkJAqsjvyiUqqrtDs86Cb5BwYjRfhbpiO71ysZOZtgAZPUJDVk
	kVjEToOnT28z2SL/LeVya5LLewKCwXRPTZMaasYmt3yZQJBfXhf2MaUcvZVADE4OQXN30UGHp33
	RXhcg==
X-Received: by 2002:ac8:5807:0:b0:50b:3357:7e70 with SMTP id d75a77b69052e-51461fb3815mr64757881cf.28.1778094546647;
        Wed, 06 May 2026 12:09:06 -0700 (PDT)
Received: from PF5YBGDS.localdomain ([163.114.130.1])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5104090bb03sm157489421cf.10.2026.05.06.12.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 12:09:06 -0700 (PDT)
From: mike.marciniszyn@gmail.com
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Kees Cook <kees@kernel.org>
Cc: mike.marciniszyn@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/2] second series for xpcs based rsfec configuration
Date: Wed,  6 May 2026 15:09:02 -0400
Message-ID: <20260506190904.4029-1-mike.marciniszyn@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>

This series adds to xxxx to add the necessary configuration steps
for the DW PCS/refec part of high speed interfaces.

Mike Marciniszyn (Meta) (2):
  net: pcs: xpcs: Add hooks for xpcs configuration of rsfec
  net: pcs: xpcs: Add handling for 4 channel rsfec device

 drivers/net/pcs/pcs-xpcs.c | 170 +++++++++++++++++++++++++++++++++++++
 drivers/net/pcs/pcs-xpcs.h |  31 +++++++
 include/uapi/linux/mdio.h  |   3 +
 3 files changed, 204 insertions(+)

--
2.43.0

