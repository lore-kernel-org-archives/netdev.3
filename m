Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D1148551F
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 17:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786037139; cv=none; b=O30EuSGRQ8YcWljgcDUKNjbN6BOiFkbpGk19O9Zeij+HP0v1X4CZcBTlI72eLA16W/Sx5GXJmwPnkzq68AM7/9VWuy7XbUcGdEXvXcMSQ8mMtv0nPj0TGSd0FWXy4vTSwYAk8Kf6A4OZVc+4WUWpVKgx9Xslnl6BMZWkdjO1abc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786037139; c=relaxed/simple;
	bh=bZP+M5covBQtrQ2/QpkLXWL+jOK0O6sgCty2Nw0Ju2g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EM+GB9p8nG2Qg9xmTJ2bTFZ3ELP/RKL4opRm9F1LjvG6/597jxp0XMg4zB/Hvdy35fQoG7RyCIzSJu5wdG8lgI95jrYwKnc8gHG4XfZD/wHm1y++hlDLpglRjT1adNdRMYMtc/Mybx7tr5aOLGkqReMTjpa78PuZl6mxF4Jpvtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SJiXSZf9; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJiXSZf9"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so2020800a91.2
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 10:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786037138; x=1786641938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=g5bdrOH9EQYp8+Y2KB755YBGfk5WlLVToWPGvUG6bgI=;
        b=SJiXSZf9iPvJE4fSfLQxnE1zxY8xHOtOb5pSuXXu1hZybm8qlMuwDgzho72WdAiAvm
         9hYf1Tq0BCHbkqFRJ49350J2GvP3+giVN2lK7gUEMOCLTxVKsI9rvZ7aXmNNz3/McO+l
         7GmUJ9RxdEDSGbnZTF9wMDwwZhz6gpy8lIdhH1JOM5inrx8KV3kjy9Ug1rZpK0nMhCna
         FH/I313KY+dcHpGHRd3HQSCoKONt9uM7r0gW75I78jXk6CfxUIynzhwYL4/uDYkKfeXd
         QDl9nVCXbmPdxHUKPm860y+a83VRobCRagD6VJa+zPLr2PR0LOgytRCV3pS6RNnKBvf9
         h0TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786037138; x=1786641938;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g5bdrOH9EQYp8+Y2KB755YBGfk5WlLVToWPGvUG6bgI=;
        b=D6h6qqiUJ83fCsEWV8f7G4KRVRbPKFC/ULxPCExX6GH6pS8KiojBdJi/YIkNA2pDT3
         d8Itt4g4zelBNPEFRH5qluPxD0Kuo/etiAJYcqm7qS36EcsFjx2EZR17vsjguI2KZJrb
         oVwaB7NgtyZ0mEyFVY/zif6TNGETOtSs/NS9t4eXS1KolM7azqw7Gwc1zluITmzs3/Ye
         S9/ddhHmPBQc793LpWxbL2R1c9EHi9o4SFwQy42e5ozNQ+cxfPOUEnoJUxE+1kFtVFtt
         UGtsKQuV3cGWwDDKINaUoex6rNsxnkbhlsF8RzwOqoB/6qFjsYLuaQOstawcjvtfRXOS
         EneQ==
X-Forwarded-Encrypted: i=1; AHgh+RpqltYT6Noo9Vt1l9uyLSYZ5vhsf30kj1VZ3PXF7P+upQ6oEgwFIucg951vsor/q5aDmEXyWGs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdhsCnVZdKFv2fIhGkDMn1o6gD0JCyrasQms7PCFLk+UiXt1BD
	564FBQc82oTVlcC94CK6wA62+L/JVlfAcEs2vVEotAraaxaaPojhoHd5
X-Gm-Gg: AR+sD12kAYtwxgeSfW01FUI85On+fAaSRx27+nH3Q+LlfNROcjS2TaqpeZuQNymQcY8
	QHO1F8tgA9TL79FqfT4O6zABqA5EIFJNtzF9sRhnJJ4v75tpUsfBmfzoRJdxCg6SaP9SraLw0cS
	c6ySwi92y9k/nlCzMci32UCKTnV81wV/fzyexhoTidrnBwwSJx32aWmhMYi6O0MkeSaq4NsslYV
	7a5e7Kzrw/L5hizK7CzTksQO6XWE0liNS/yLhnxCXHRMHIxe6S6BD1j77kfO/JUvGoHQGwLCs1z
	qllzNRzSLI9cjJ9PuJoowpcG2GJFHvy7rLtG6ZOo4nSZmts9HqRMOxJsDdqQUQnmvd+Ekl0Qjst
	4179wff4iXB7ZDs4QDZl2iZJftVLW3MhAaKIw08hByRFnXzaYGpFLITBOI7WlLLTXFsSh07/reH
	zIE0xmzmlQ9LpB7Fzhzz6ouzp3C2fFt+ziwTPiY377O1zZMqZuozvSe+GZfIZpaZeBtLJSaDa4T
	pOElu/ompPIHt2ypKTl+ZH5sf7UwYY1wrHHwi9r39gouOMFj7WAG6crKSs/
X-Received: by 2002:a17:90b:524c:b0:38e:5ac1:9517 with SMTP id 98e67ed59e1d1-3903c54b386mr15896123a91.3.1786037137831;
        Thu, 06 Aug 2026 10:25:37 -0700 (PDT)
Received: from bloom.localdomain ([2604:3d09:178e:e100::6868])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-390b1389e3csm57948a91.2.2026.08.06.10.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 10:25:36 -0700 (PDT)
From: Ivy Lopez <skunkolee@gmail.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ivy Lopez <skunkolee@gmail.com>
Subject: [PATCH] e1000e: fix incorrect modified flag check in e1000_read_nvm_spt()
Date: Thu,  6 Aug 2026 11:24:52 -0600
Message-ID: <20260806172452.32139-1-skunkolee@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

e1000_read_nvm_spt() reads two adjacent 16-bit NVM words as one
32-bit dword for efficiency. When deciding whether to use the
shadow RAM value for the high word (data[i + 1]), it incorrectly
checks the "modified" flag of the low word (shadow_ram[offset + i])
instead of the high word's own flag (shadow_ram[offset + i + 1]).

This can cause silent NVM shadow RAM corruption:
 - if only the high word is marked modified, its pending write is
   lost and the stale flash value is returned instead
 - if only the low word is marked modified, the high word is
   incorrectly overwritten with the low word's shadow value

This function is used on all PCH chips from SPT onward (SPT, CNP,
TGP, ADP, MTP, etc). The bug has been present since the dword-read
optimization was introduced for these chips.

Note: this was found via code review while investigating a separate
reproducible packet loss issue on I219-LM (SPT+ PCH). Testing showed
this fix does not resolve that particular symptom, but the flag
check is still a genuine logic bug that can corrupt shadow RAM
contents and should be fixed regardless.

Fixes: 79849ebc0e06 ("e1000e: initial support for i219")
Signed-off-by: Ivy Lopez <skunkolee@gmail.com>
---
 drivers/net/ethernet/intel/e1000e/ich8lan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
index aa90e0ce8aca..87cd1cdc6f10 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
@@ -3473,7 +3473,7 @@ static s32 e1000_read_nvm_spt(struct e1000_hw *hw, u16 offset, u16 words,
 				    dev_spec->shadow_ram[offset + i].value;
 			else
 				data[i] = (u16)(dword & 0xFFFF);
-			if (dev_spec->shadow_ram[offset + i].modified)
+			if (dev_spec->shadow_ram[offset + i + 1].modified)
 				data[i + 1] =
 				    dev_spec->shadow_ram[offset + i + 1].value;
 			else
-- 
2.55.0

