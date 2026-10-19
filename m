Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058F7361666
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 02:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792376250; cv=none; b=HgCoVfUi6cGr1UDTffKhPcz0oKjxEoldzMZ1EJOw3WOI51oc6FFtiQtqCXg2Xt4HMcb7wKCU4geJebNSNLIf++w18qMKauTDi5zmS4YUbgOP9akdiqYl/c32q2P3qHB/p7m/AOtFOOLwozugq01N/H/+ChHejqoAbusQSE9hz/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792376250; c=relaxed/simple;
	bh=NJJGDOvEDiGRbIgSFW8MSvLC/yadQm8VHB1EwfkMMck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gb3DlTY9sHpEe+o9O75FtHkDeXJz6Ub77frmoZRSBjnI+HKueOkR3nITcWzPDfrLSXTIkWm/UbZspZQ0VIQGz+2E6QaSWLTIfHRjHJoUOBXubtmfm6tv0tYzM3XoxexcTNwFpA9F7gfPaCe2sR9b16PkpOKSex7H9WD+IQtLZf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gt.tech.gov.sg; spf=pass smtp.mailfrom=gt.tech.gov.sg; dkim=pass (1024-bit key) header.d=gt.tech.gov.sg header.i=@gt.tech.gov.sg header.b=Ji1gaZtJ; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gt.tech.gov.sg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gt.tech.gov.sg
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gt.tech.gov.sg header.i=@gt.tech.gov.sg header.b="Ji1gaZtJ"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-3535bf8b3e0so3318369eec.0
        for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 19:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gt.tech.gov.sg; s=google; t=1792376248; x=1792981048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NJJGDOvEDiGRbIgSFW8MSvLC/yadQm8VHB1EwfkMMck=;
        b=Ji1gaZtJEp/1uK1gCSaYzNSctLm3210xuTsvphqPvtrWYqsg84IMWG6Dei6f3R/VOc
         uxtHffmtH9WIX4yZ/tTW982pkisXW5Ab+dHdyYtC4eZgfO4Isq/1bEPICQxN67+NAPMo
         sA9/7f8GrIj/TNGP+52oDO/w974N5E5lkrhGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792376248; x=1792981048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NJJGDOvEDiGRbIgSFW8MSvLC/yadQm8VHB1EwfkMMck=;
        b=VNA4M/0MJdGNKba5xVZlt++5TiaXujos+tTygmfhrJa52O5SWZccTTCD/xNVabMAg0
         qci5vkigZ0aBeAem3jBqLcMd97/yHNZk7KuhptuZI3xMDW3rXGLoHi41cfZ2coLLLi8Y
         9xP+5guq55YZ4QtUYkqmmCvVtKgzj/0dakXN9afQsIPs4aQjzEPPerzOL9It20t+sOiC
         01EDo69oo/XCXyFz4k6+wFcna/s9vxwv8k0XALyA8P7/3abUDL4iNZgIiF59Gkehz2WP
         lJg6bn6dZmizrCGOMAeqhx8CZAw4t3+MjyyY8mR6L9NJx5W8v5tgJu33JI9Uytd5rzvo
         J1uA==
X-Forwarded-Encrypted: i=1; AKwUvBx2GxKtvRH+qjfEJl22HGJFsYp2EwJsM8kDECTPwQiIr/RDhtRkV4TID7S2srXQ8b+UOae4cfg=@vger.kernel.org
X-Gm-Message-State: AFq9FYLGUc9DF/eaBUp+bZJy3okCwsTU1JCyDPfgikJmA+FpLgayHAE1
	qQasPwDRZ32Ud6W8vORS499PqYhOdGXhMu4yJ2I59JJLzxGrI5BSYePvre2B4Askfic=
X-Gm-Gg: AYBFou0x3ZOIpcRe8x3FKiCJrFdpZdX23lATsaEeI9yBk3yOJsfBzoV88YMhTL0VSZY
	U//b+LzrPpJfPSNHS9Ii+O9pOZdSWLC3wK//vlJ/ya1PFQ6g9yk0SkKH+NcREioQKb2nyRUUhPg
	kWm++8qdmVMZoxW6Ar0csVl2sUqjlis/ytKY++rrQhAR3oBiNl/dADbth+Xvbaey0fbXNvOaIlz
	BdaW150uWL44idFQgB7xooLilmcrmk6RxDM3kUCyPfufUVErbV4Cf+20o/9izxUAdzunqMBYy+R
	nLcaptiIkZgbFSsLZybUV0PTP6nPeOr0O8X/oNvT+2Xzlq2jipVlaLEN0PC83L50EzBTtYN2fGC
	Dnw1wcDGauWbOd5BjonE+de6sNIBRQKJjn2IkNq/yd/qp8aHef4nQl6qPmd5F/C84MFsLh5UbXo
	AexindNwDygf+GicNwt9MyKJ0lyE3jKcCt9yA9VwsSwjUK8/An+oQKCKoUEXLPxO42a177fpBJC
	jESF6KycgaAzSdvx5uB4+B8YmcShQkEH5lFRm+DptlpiHquo7ErK94=
X-Received: by 2002:a05:701b:2207:b0:136:c443:80e5 with SMTP id a92af1059eb24-1876658f6c4mr5983797c88.6.1792376247926;
        Sun, 18 Oct 2026 19:17:27 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain (bb119-74-6-224.singnet.com.sg. [119.74.6.224])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-18314b1722asm25766382c88.1.2026.10.18.19.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 19:17:27 -0700 (PDT)
From: Wei Jie Law <law.wei.jie@gt.tech.gov.sg>
To: andrew@lunn.ch
Cc: 98lawweijie@gmail.com,
	Thangaraj.S@microchip.com,
	UNGLinuxDriver@microchip.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	law.wei.jie@gt.tech.gov.sg,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	stable@vger.kernel.org,
	woojung.huh@microchip.com
Subject: Re: [PATCH net v2 2/2] net: usb: lan78xx: reject short register and statistics reads
Date: Mon, 19 Oct 2026 10:17:13 +0800
Message-ID: <20261019021713.150059-1-law.wei.jie@gt.tech.gov.sg>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ce3a8add-3bf2-4507-b778-a0f8a10370c7@lunn.ch>
References: <ce3a8add-3bf2-4507-b778-a0f8a10370c7@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> You are assuming reading registers can fail with sort reads. To be
> symmetric, don't you have to assume writes can also fail in the same
> way? Should lan78xx_write_reg() have a similar test?

Thanks for pointing out, and I agree. This will be added in a v4 patch
request after the 24h cooldown expires.

> If short reads can happen, bad things are expected to happen. No need
> for examples.

Will drop from the commit message in v4.

> This belongs below the --- so that is it not part of the commit
> message.

Will be moved below the --- line in v4.
