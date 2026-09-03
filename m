Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC04941D226
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 07:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788420795; cv=none; b=FgNRYcBRNTLY91/9hTzwL2h7Tjo18jVYwX6FXKOHR6prqa0GdFIxsPYkcx1nt6oiwhbOrKJjRn7EH97UJNy9b18kL6VuLTVBv8P/x/0h4dgz5XPL2My/TASka+4OQz/KWvaL/tot22cNwyE2fclM5WUKpAoJ4nHDyC8xgtdlhI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788420795; c=relaxed/simple;
	bh=hFt1NkArimH8+qxUmJAoo3uATQRlL9qRZn621gV6oWw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DBwnreZtB6vGc0Y+HsOK1cIfA7+NN9+Re6B7D3v1Jac7PP+8/BYbT8XcOXf9rg1TQ4wQ7TtPwqiX7AVNSDUq0o6hRw5MnKxMmAIL5tDEswIVpQy+tl/1Rt6WPTaeqFYCtLaz6iFcg9VzXb5mCkD9geEEVb6TDXf8kIEBQ93IUYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZJ0mCjDl; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJ0mCjDl"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cc891373e0so21380585ad.2
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 00:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788420793; x=1789025593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XD10siGyv2UXcVcAX66uMHAbJieFBJyM178WgyCpFQo=;
        b=ZJ0mCjDl0/2MXooLjBxQWLecNHnTY9YtjYa6NH/sNbPYHRbyMU6JWo7JrWJ9M5acDp
         Ra1J/VSJ1m7uhw20ea58ecHwXuqy2e0w0Ke4p2zDXXwMHfmR/8GeAdbFIs6KntaWw1dq
         taQC7GBrXWaBPu8YVPEqHBiuGUjXwlVWJrsKYA22mQVAYF10ealEXLq1W5pTexJkkYzn
         G5N2kMGa69ZwSWgRIc+ilDTsLIpef18umn0IQbNJIY+1aqi3z5ZK/bG72GxYgRc6UU0K
         XHs4E9Kv/OkTjDvifBiOJ8EtW/EiEkWrLD6w7u1iT7w64vIiBertSqqq9qeVtzD6Tcjs
         LC7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788420793; x=1789025593;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XD10siGyv2UXcVcAX66uMHAbJieFBJyM178WgyCpFQo=;
        b=F4M2Jhiz8jjV1ic13hto49sFzj6inMjCtphFIF0tyyk9QLEoR3K9MTZwdJWERn0NK6
         vQl/ntJyX63YEQYRh8Fm6XzKdTr1ZD9ejVbEY1Ls3P/mTetqXSD/DJd1sCRyKI5ndQgp
         AJDnjQl1qdI0iBWHySG1d0tkpGw4YrzNxqmRxpb3WSC+wieL4nWKiCiTW9i0QkIry7vJ
         3msEvVZ2odJ9Ia+BvyyPNnm8vmYiEHk19CpQCICwIcxHQxV14DzJlnpohJYiS0xBFcXD
         Ulm8IOjmRzMxkWQ6utDuDURk4h0A5GHd4vCdk/hSLLrnZ4kQU/ZppcpujSX8UQOhyDUA
         q3YQ==
X-Forwarded-Encrypted: i=1; AKwUvBxiVIXEVA7Egii9jz+XzMPwGJWyGCP6tfoF8rtFO9Rke6ZDGJKgWuusFEe6IqmeSAdkJl8zAZo=@vger.kernel.org
X-Gm-Message-State: AFuF++mPtDd04eg9GVoDsUVJhn4kRRpamH/Mrj1W9h8gUAsh0oHjxwes
	T2O91Lu9+Mh4nk1dOlrFo/mxYizIWDE3Z3AEPUkV0Ge9cuFvp0hunjSS
X-Gm-Gg: AYBFou3gDbGe/2mHP6d2kOr3KuR1D9NxQ56QsAuYr21QdM5THbFfEsY1eA+a80TfcpL
	s6RWfOiyKMrRdCHUThp1/W3IioQkiOTaPf6Q7WKFiAE8we90j7hDZEq8YCvLC/Qor8mgwerRRen
	qbw9+37RmHobWV59sbHoeqHeJPLRUf5ILJDLl+x28TjPllmdJceTNI/XOc0XQg5SkeogTw4gA8/
	zYL5HfpzQQPyELL70iXo7jCu4Utk9QjD/fc8guGM+YaZzhINAl0Syhk4Pts/xk83ZMJztfE9tfx
	zOqg6smB5+vjSDrRZ6jjrIRodLmPERFI4C7HwLm5Z1GP2YS6RR4XmOQPuxW6xuPDqrvWJgiPfwH
	yO/sMMMnHZt666DeOzKEAnGnq+0M9tSRv3G6IWotxASSz1KGivAK3GWPdRu9U29PQwa6MEuHsbO
	jGuSMgeb/IE/j7drdTjUNs5jwrTIDeRlW9hndrIcWsiooJo2yGk4uQnDgVLJ4x1X5BqPDFdP9/Z
	26PbQUcoDxAoGKZ6fkof6HQQqetxrjJB8hxJZG3MZcAHdLoS8PgpjrYUZ1k1wn9rdf9kmu8D24b
	Hu4X0z8em09/tFU=
X-Received: by 2002:a17:90b:2d8f:b0:398:9beb:5c17 with SMTP id 98e67ed59e1d1-39aee13d992mr17057325a91.18.1788420792882;
        Thu, 03 Sep 2026 00:33:12 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08624f11sm3606813a91.11.2026.09.03.00.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 00:33:12 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Michal Simek <michal.simek@amd.com>,
	Simon Horman <horms@kernel.org>
Cc: Andre Przywara <andre.przywara@arm.com>,
	Robert Hancock <hancock@sedsystems.ca>,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH net-next v5 0/3] net: xilinx: axienet: Fix IRQ error handling
Date: Thu,  3 Sep 2026 14:32:49 +0700
Message-ID: <20260903073252.339250-1-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

Hi all,

This series fixes IRQ error handling in the Xilinx AXI Ethernet driver

Handle errors from optional IRQ lookup and preserve the original error
codes instead of returning -ENOMEM.

The changes were found by manual code inspection and compile-tested
only.

Link v1 : 
https://lore.kernel.org/all/20260811034715.6034-1-phucduc.bui@gmail.com/
Link v2 : 
https://lore.kernel.org/all/20260813042012.17631-1-phucduc.bui@gmail.com/
Link v3 :
https://lore.kernel.org/all/20260817105241.63345-1-phucduc.bui@gmail.com/
Link v4 :
https://lore.kernel.org/all/20260821123249.41527-1-phucduc.bui@gmail.com/

Changes in v2 : 
 - Split one patch from v1 into two patches.
Changes in v3 :
 - Move the lp->eth_irq check below instead of handling it immediately 
   after platform_get_irq_optional()
 - Add error handling for platform_get_irq()
Changes in v4 : 
 - Add Reviewed-by tags
 - Add error handling for irq_of_parse_and_map()
Changes in v5 : 
 - Change the error code returned when irq_of_parse_and_map() fails 
   from -ENOMEM to -EINVAL.

Best regards,
Phuc

bui duc phuc (3):
  net: xilinx: axienet: Propagate errors from optional IRQ lookup
  net: xilinx: axienet: Handle optional IRQ return value correctly
  net: xilinx: axienet: Fix IRQ error handling

 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

-- 
2.43.0

