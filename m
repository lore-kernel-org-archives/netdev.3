Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A0445C6E0
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 09:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786698674; cv=none; b=K7CS0me6GLciVls0DJQf8YoGzlIskobDmV0oiUL1GD3RzB4W+hc/hUbr4tcpoHez7hOil7jHbcO5o1CCx5TykfKnIPTNgdTiPd/pOYSpmhUagLBzpTyrQa7DBvguaQdm7mnKcitFGU1HN4xXbnIFrm+LlspoYom4zcigX/faWq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786698674; c=relaxed/simple;
	bh=mitSiM7Zm2Qehwr9qj883Y6+SDxH1sOjtvMEjMsC6lI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gU1mK0f1mVqr2JIvnxXdl0xWesBxM0NvUqPh2gOud0tHD4/EsHkUjkFjhxtC105kej0w7FasyR21yX18l8UW39hVeAdwke5S0CQRUScBc22fsHl1Nwidv6WZptAQwREvhu2BABf9UkP97hLBkxWjVprIx+8fvx9ItyqjgI8Kx/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=HkwuoYgw; arc=none smtp.client-ip=209.85.216.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HkwuoYgw"
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-38e58034d05so618400a91.2
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 02:11:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786698673; x=1787303473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kN3cxg4FbIo8tTISuz5oziD0hZFYkConcwf1MZhcyQs=;
        b=dlRWE2/20eN8SNHrVT/gWRxJVJCfqH7Dwb6v1tRQ3y+esFdwgdm7BvLzGv+9hukYB8
         euzJby30XsdLyV6W34pOVb7wHYk2dAUvs1EgQqjdVuIR8ypm2kNokivEtkSzrq1KZrsU
         fx1gLWv8+7rx12k+94D9C1a12AhTwxJnBcAJ3Jcuns0kWlWf3zqgvj7FYmf0M9JVNXlU
         WgZarbwFmxtYQQYBKKrOHsxyzT50VNOkc4BSRwSxjyoNd9Z6Idiyw+0NB4ng7Ex3M1ia
         ZRc97rIrx7X3CuIU9JDosii8q5jSfBFexRsmeRRJHXE/KxjNxIFV+RxNmFN3lArOU4Br
         YpIg==
X-Gm-Message-State: AOJu0YycBeMj+Se2b2NILmP+px2NypiLiGWNm/kBB9b58gXVr8Pb3oUf
	9wySsy2bA7LwZzG8DLOtMGr5uu9zpgjaNcmu87y7X8yPjbz5kbf6gIIktT98bUE50eORgs/U2Zj
	74xhhBwbPmEZiUD3CeQ75RouTf+DeIcLDp62uuHgSq6EfVQzRWxW4BonGrhYyP/Ty8juA3PRJ7s
	FytPGVQN4Ci0eqCtcDNhwjepPKqBMUdJZUXyf/JhLNvLi/GQEoSOVJA+in4uRxL2B0Pq49uVoyO
	8wKbsEskA==
X-Gm-Gg: AR+sD1396oaeW9vtAVx8W6TRAizviTGdz0XvYM20ZXhilonMHPX113ttfWe/RSTneP+
	yCb5L1CaM8izVLz86YcN4+J1k+AVLInGPJlCy53mbUlJ/bsXG8WOpcFSOPePhqCxcPzTnfeGvn2
	XubwUyID4cJftqdNJd6evATaTctvQE9MUkZs2eQsdEf6AH6srMukAd9r4gbEGMR70PfMwSB3A/r
	GqLj09LkVJ5FmLUnwFMUwMH6I0a9N7im1D96Ee/i8VjmRrmAsXJbkuXik/110Cvi7JLZKIkWEPo
	lFV7sXJ+YyBY3AfeGhxzcuuwdzevmQOxVSVV3FXCwLmtGFEkY5TuYtf/pioNy0ql5g8Urz3bCbQ
	9o5v/vnoKpDkOh5qN2IgcgLxDd1gHTltayuooYfGRzaYCmSYfmk2RSK9TdFPmaed51AglvGmVAr
	YCOojzoS24W3K3qHjyYITInVIT7cbUpQHTOA==
X-Received: by 2002:a17:90b:3c4a:b0:38e:63de:730d with SMTP id 98e67ed59e1d1-3933b6f15dbmr4484759a91.3.1786698672689;
        Fri, 14 Aug 2026 02:11:12 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-20.dlp.protect.broadcom.com. [144.49.247.20])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-394ea8637dbsm659345a91.2.2026.08.14.02.11.12
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Aug 2026 02:11:12 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cbb467e56aaso552279a12.1
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 02:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1786698671; x=1787303471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kN3cxg4FbIo8tTISuz5oziD0hZFYkConcwf1MZhcyQs=;
        b=HkwuoYgwEPqKN0koso6y9OIyhl45iVu7ai605RYTf/vvftVrH37c9asen0Kuf1rAsq
         6Izbicj9FBntl+wu16710zMCSDBNJBDThskiOTscYui+N2Ys3WrJ3cpHm29Ftd4nHwAE
         JS9d/xvqrsj+PLpDw3jvjV/r+QEB0/0bp2Xfg=
X-Received: by 2002:a05:6a21:3391:b0:3bf:a638:4376 with SMTP id adf61e73a8af0-3cc71ccc432mr4827093637.21.1786698671008;
        Fri, 14 Aug 2026 02:11:11 -0700 (PDT)
X-Received: by 2002:a05:6a21:3391:b0:3bf:a638:4376 with SMTP id adf61e73a8af0-3cc71ccc432mr4827020637.21.1786698670453;
        Fri, 14 Aug 2026 02:11:10 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1413887e3e7sm7056408c88.9.2026.08.14.02.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 02:11:10 -0700 (PDT)
From: Vikas Gupta <vikas.gupta@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	leonro@nvidia.com,
	jgg@nvidia.com,
	bhargava.marreddy@broadcom.com,
	rahul-rg.gupta@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	rajashekar.hudumula@broadcom.com,
	ajit.khaparde@broadcom.com,
	siva.kallam@broadcom.com,
	usman.ansari@broadcom.com,
	Vikas Gupta <vikas.gupta@broadcom.com>
Subject: [PATCH net-next 1/2] bng_re: add support for the shutdown callback
Date: Fri, 14 Aug 2026 14:40:53 +0530
Message-ID: <20260814091054.359508-2-vikas.gupta@broadcom.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260814091054.359508-1-vikas.gupta@broadcom.com>
References: <20260814091054.359508-1-vikas.gupta@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: "Usman S. Ansari" <usman.ansari@broadcom.com>

At present it calls bng_re_remove(), which adequately handles device
teardown on shutdown. Appropriate shutdown-specific handling will be
introduced in the future.

Signed-off-by: Usman S. Ansari <usman.ansari@broadcom.com>
Reviewed-by: Siva Reddy Kallam <siva.kallam@broadcom.com>
Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
---
 drivers/infiniband/hw/bng_re/bng_dev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/infiniband/hw/bng_re/bng_dev.c b/drivers/infiniband/hw/bng_re/bng_dev.c
index 311c8bc93160..42b473919d09 100644
--- a/drivers/infiniband/hw/bng_re/bng_dev.c
+++ b/drivers/infiniband/hw/bng_re/bng_dev.c
@@ -477,6 +477,11 @@ static void bng_re_remove(struct auxiliary_device *adev)
 	kfree(dev_info);
 }
 
+static void bng_re_shutdown(struct auxiliary_device *adev)
+{
+	bng_re_remove(adev);
+}
+
 static const struct auxiliary_device_id bng_re_id_table[] = {
 	{ .name = BNG_RE_ADEV_NAME ".rdma", },
 	{},
@@ -488,6 +493,7 @@ static struct auxiliary_driver bng_re_driver = {
 	.name = "rdma",
 	.probe = bng_re_probe,
 	.remove = bng_re_remove,
+	.shutdown = bng_re_shutdown,
 	.id_table = bng_re_id_table,
 };
 
-- 
2.47.1

