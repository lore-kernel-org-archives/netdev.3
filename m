Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CC83A5433
	for <netdev@vger.kernel.org>; Sun,  9 Aug 2026 06:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786257917; cv=none; b=fw0/LjAPDRJtCRYF4HS6x2j/035PWcsmyNALNqPLoQa5VRaLlTGL4Hyu6xkApWJmCMLqHT6Fa3oAn3zcScXnfleH1NEujttrpMbdaXnOy520YaDkk6WvIoQQCY9xJ+VmMsvpqXlf6TSMMeQNJSAPBMKyryBXbzN9Ygld1cMVaQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786257917; c=relaxed/simple;
	bh=nB1hW7MtM3EsPo8aHptljn66e8/QvrnZV50AbZ154jo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kuYA3lqPw2PxZhyU+uV1dQ3oQu0IKzTBV/4tRuKx0Pm5QJmi3GUeVMP0B0GeKk0kAp43SVy5Qmhjg2lut1mCtSztWFCtI1Kdzyncv9xfotQXHzgreZ99/YlwPMcg+CCEebS2v2K2pJaUwyx5K7dcIeVKH7hwIWQ++LOVZyeqL7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D55YkJdR; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D55YkJdR"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cacb8416a1so8027425ad.1
        for <netdev@vger.kernel.org>; Sat, 08 Aug 2026 23:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786257915; x=1786862715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nE/y360woHSjvYFnukflvjTswiorQVMHnIf8Hn9PrxQ=;
        b=D55YkJdRGd4kYWgNkYt+kghr99o/33YK+aTHAXStxoYoDKWMHL1KAKCXwhIrzxZdq0
         aZT7leQcY9u2u7gKTHds5+puGqElxsBAVFswl+QSy7RurxI7xkMtmCS9dQ2Wf/WkrFq6
         /3B1Re6sRrTln7vR6ML4tssUkR2NTL19qtFQigfZoXgQiHeXb+xyQ5Wk2HWRu5d4fdV5
         /DBpTr5kmbnlUn1kCaPJFEV0/x5bbVMBbwFYD/Ibd89I9Z/HIiYgnkolFAlDxRO5Du4B
         X49Z8RdKRdM84lXAywB7w2pDB6KipTd1jKSiaq3x69OBuNj8snKlxOvE8xeVGa39MH4m
         89AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786257915; x=1786862715;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nE/y360woHSjvYFnukflvjTswiorQVMHnIf8Hn9PrxQ=;
        b=aahEu2GxCdf3hPr2TTjQk03Jtc9tH8Q+/3IKovaUXjNPp+WOqouQjdDNQkM8J7so7x
         PXsKPiqJ8fma6Fn0+vmxbeyOFc7/aeVzS72SsM84hekepLnJzXXEPaEtT7WG5wsHaMlp
         nSlOr4WiBvWV4MNfpkkjCyDY+++sEyiGycqnpMKRpWS5r8ZXdu0XJG35+y2+uBM7kK+0
         Rp46sVl7KMgJ0hmEiEuo4AxgKZ3Mt7oAhTGdrNPR6y4kf7fH444hJtIUWfPVwuo64MN7
         G/yFGSw/zesEUGfEyEJtp3kekR/WFsNst4lei5NQU51z/aH6rkGFI0eju1BuEFy2Fn38
         r2kw==
X-Forwarded-Encrypted: i=1; AHgh+RpEmGhIySnrdGwg03e3teqhm9hCYcvVXArdwXRPd5YRag9CbhXTXdJefmzF/kA4k0Atx5wDndc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPE5ug1Ed98FBiiaoO/qlj/18nYWGZWPhacBg6dPzaz8GTrJNq
	5doZWFTXgqjnqFZsOF54PtVZ5WFvgeborCXoKdi/UpFpz7yz1Rg3K7/y
X-Gm-Gg: AR+sD12ImKDOAFpxKCVHX0FALYO+m1BV1q0DWEX4fv9Z/nOzI2F+DStZ+i/8kWv3FiC
	T90CC/i8CU5dLaT1BRpDjAb+LcTjUBQTDKn+8FDTBvfZgCX+LDTnmwTDFNsYupymEkM8PAXQ9i+
	MhTYwT+jsD1MtiPqbYwReM4HtM09PW39NuPg3hyzp/KRMevS8uf6ognk3tR7hbg2AOQwrFX2qhU
	W1B4YaOMuiY4MKy0fPQ1wyq1MRF9aZEQvaasPcP949V500wEAcp3UnaYdq3CrW6hJCeyB7VYQka
	jGeRzMczH8uWn9xDBFerCSPFN/SYOlOfWtofCGggd/8HYvZGfqy4ySTozQBNWaNqlkK6jt7PJeX
	Vi8MhHSoe3vjjJU55htUpbpVuyq1YSrcIUfOMvTjaQtrKk7SEg9sihGgLOkFi9UQgXrD6mhHToA
	uqvhR43zxwv1XIRWg+E6eRCEGxNk8Ln9OIsxSbHbPNoFIxYYoDJwNuusYgNSFQ2j70U7UvIYzEe
	OzXB4dLk+qMAYJoML2MHoXYYZq3pqm+IqEPew==
X-Received: by 2002:a17:903:3806:b0:2cc:8267:31b5 with SMTP id d9443c01a7336-2d2a8e941d5mr142212115ad.19.1786257914980;
        Sat, 08 Aug 2026 23:45:14 -0700 (PDT)
Received: from localhost.localdomain ([152.59.178.168])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315be8a7395sm28043292eec.9.2026.08.08.23.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 23:45:14 -0700 (PDT)
From: Krishan Singh <krishanmohan298@gmail.com>
To: linux@armlinux.org.uk
Cc: andrew@lunn.ch,
	hkallweit1@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krishan Singh <krishanmohan298@gmail.com>
Subject: [PATCH net-next v2] net: sfp: fix hwmon_name memory leak on hwmon registration failure
Date: Sun,  9 Aug 2026 12:15:04 +0530
Message-Id: <20260809064504.70579-1-krishanmohan298@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hwmon_sanitize_name() allocates sfp->hwmon_name before
hwmon_device_register_with_info() is called. If the registration
fails, sfp->hwmon_dev is left pointing to an error while
sfp->hwmon_name remains allocated.

Later, when the SFP module is removed, sfp_hwmon_remove() only frees
hwmon_name when hwmon_dev is valid. As a result, hwmon_name is leaked
if hwmon_device_register_with_info() fails.

Free hwmon_name independently of hwmon_dev. Continue to unregister the
hwmon device only when hwmon_dev was successfully registered.

Fixes: 3f118c449c8e ("net: sfp: use hwmon_sanitize_name()")
Suggested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Krishan Singh <krishanmohan298@gmail.com>

---
v2:
- Move hwmon_name cleanup to sfp_hwmon_remove().
- Free hwmon_name independently of hwmon_dev.
---
 drivers/net/phy/sfp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index f52020673..bfa2b821f 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -1916,7 +1916,11 @@ static void sfp_hwmon_remove(struct sfp *sfp)
 	if (!IS_ERR_OR_NULL(sfp->hwmon_dev)) {
 		hwmon_device_unregister(sfp->hwmon_dev);
 		sfp->hwmon_dev = NULL;
+	}
+
+	if (!IS_ERR_OR_NULL(sfp->hwmon_name)) {
 		kfree(sfp->hwmon_name);
+		sfp->hwmon_name = NULL;
 	}
 }
 
-- 
2.34.1

