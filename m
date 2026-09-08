Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D04C246788
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 00:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788828884; cv=none; b=kkHCutuI6hCexnIuefwh8EN5zj79hjCcU//nOQAgC+Ff7HP38KHlDwWDWfFmhhmUvSAWoKFiawCHArh9st9o9rQ0uBadZMB+9qEaR48HBpNAQPHNl9EIPfsNXjCx4yXG2gjdlIXCH+XRYkQnihQn38vque76paxqqvJ7rGso4yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788828884; c=relaxed/simple;
	bh=LL4yx9+duTmRtmjdwBAKJocU9BFUfdnzRIlWU/h+eos=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RXi+I1PQ2icVDmiDnFIMKahNqaNUQLVJyPHIG/XA16h4ieTEJ5M5cHbRx6+vXPzFKtZWKsaFMzDHfI8/t7UE9Ek8xII+sOE/6OHeF3ghK4so5VaXjPR1VM/W2VwLMXomGeryls6qzfZ++Kcp5p3xt/iKRa7Og5DrK6EAqu0O+v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aVZ4VMWm; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aVZ4VMWm"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49b8687630fso34639225e9.3
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 17:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788828881; x=1789433681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YgASPrGb+YzXVqSHqBKJ2dk/XrU8XstjjU7gCc3yWNU=;
        b=aVZ4VMWm/uxa66McIJA1uKK4fNddf64020o0NEjsiLW1t5uneeIbzvj7A708csxcQn
         +3rZCTc7C+TyLMxLsZuNEv5gXhJgqkuRHd2YqGwPX6Ij/5Jkc5hh291lFf5+ELfdUDG9
         qBxsrEN2pgVOPHnry5i2/XiCYehSl0VNBpEBCxwTYs74nNxgaPb4tmg7bDg0elJnnpxh
         NEv4FM4NYKd9/bvPXTutEoIHPIEX5JkwcyKGLf8o+cYa/fTWOAFz4r7PqOJnC31QkhAv
         yPJD+d9ltvRXrEXLKQCgT8z2OWMxItddCHjeXOclYsTk/Eh3/SXMs69b+vu2U5UDL9Sj
         b3pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788828881; x=1789433681;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YgASPrGb+YzXVqSHqBKJ2dk/XrU8XstjjU7gCc3yWNU=;
        b=UShQ6BooS8zJG4YIuz2A+ErPmpq7yTkllzcmTqRQDErnsTzZg/OYNQiulePmd9EHwQ
         ry3Y2tVpSgWECbjtX1dMs5ZnPF/G2CV9aagkJ3/gOio2bDEiJkGVZIh0m/47DY2bBH3F
         rouJXMrjCJRRuNqKkfv9bAL1Knfm1OJWU9aKoDwbssp/pY+g3E8agsnb24uaZnL0q5/Q
         YIobiuNvcREmRt5NjqOQ/rmx9tSZZIYTtr3UiCcCabb7H0iGuE/ocOSDk7RD5jKjS5uh
         9ufdZpOaVsMRr2Q+6RDx9vSHvv3Ad2nak9PytvhuGrnZnyV/zSGuDnf0LM9lcraSQdHE
         HRaw==
X-Forwarded-Encrypted: i=1; AKwUvBzxWkAslLvxpPg5RjHooqX4bBqmAm/xWt+zQ8Ct/qJFrVziH5eCr4x1WtrRlb/ZDHOyZ/J3B4M=@vger.kernel.org
X-Gm-Message-State: AFuF++l2UoBUqK2k6EFCdbxi5iMZPPz9Zz6JW98Ri22tn2iWN1ZgRLPW
	V53aK/1NRaTezE3zNURB8sAQMY9gem/2ZTWDx10ZaqVNX+T9h6VU+y4S
X-Gm-Gg: AYBFou336q/HqPxVc5wF29q/5M/qEgmfgaDdOpmn6r3sII+Mbjpw58qJZJbxzF/A5nL
	vNwVKu3l6C9i657QD6xVXWx5C/1HGZKac0WtvpsJ6AHJKaFg5i+WVDuT1Lj9HQ3B3vh6j0IuzE8
	soSxjVwM6jjeFoFc/DX/xXKQYIpKxCT6iAuVuCU2vIYcLF6HCKJBE7sohg2624tgZF5i41bucDP
	ihTDVTHKKZ/EhspWhUn/kiza00G0RBHSk/RkJOEbxvmpT1FywDlHOpoQEeCLwQhOmFgCNy3t5FE
	pPiMeOadSDvoe0AODEsPU5CvzkJyU2MYEBhcZaIU2X2GW9JSVqIbG1Ygh5X2dR/JY3F79cpq4Vy
	IU+AYtu5XRw1Z/1WCZc0wQl5ViWDs+T5z62iiV5sYpe+qAOtIjJMly5XtU5thGL/OknjAmaRtpt
	8bPpEdDcm2nGLTI5xpNUQqkp5kd7ET2xehWCgUdAvaQ26X87UTpXjjtMxu1womn3DyzxWndVn6V
	dLTC7y/2KWtIQk5UeRnM+DKk+U9J5noudDjOS03SYigGp8q
X-Received: by 2002:a05:600c:3b01:b0:49c:fa21:e73b with SMTP id 5b1f17b1804b1-49cfa21e86cmr213007455e9.17.1788828881004;
        Mon, 07 Sep 2026 17:54:41 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce5563c6csm368908035e9.4.2026.09.07.17.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 17:54:40 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	oss-drivers@corigine.com
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH] nfp: reject truncated hwinfo table
Date: Tue,  8 Sep 2026 01:54:37 +0100
Message-ID: <20260908005437.11004-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hwinfo_db_validate() only bounds db->size from above, so a firmware
table advertising size < sizeof(*db) + sizeof(u32) makes the following
"size -= sizeof(u32)" underflow and crc32_posix() read far out of
bounds. Reject such tables before the subtraction.

Fixes: 59a8474888e9 ("nfp: add hwinfo support")
Assisted-by: Claude Opus 5 (Anthropic)
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 drivers/net/ethernet/netronome/nfp/nfpcore/nfp_hwinfo.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_hwinfo.c b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_hwinfo.c
index cfa4db5d3f85..30aad12fd062 100644
--- a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_hwinfo.c
+++ b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_hwinfo.c
@@ -136,6 +136,11 @@ hwinfo_db_validate(struct nfp_cpp *cpp, struct nfp_hwinfo *db, u32 len)
 		return -EINVAL;
 	}
 
+	if (size < sizeof(*db) + sizeof(u32)) {
+		nfp_err(cpp, "Truncated hwinfo table, size %u\n", size);
+		return -EINVAL;
+	}
+
 	size -= sizeof(u32);
 	crc = crc32_posix(db, size);
 	if (crc != get_unaligned_le32(db->start + size)) {
-- 
2.55.0

