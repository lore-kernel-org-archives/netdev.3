Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2F73B388C
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 21:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785791238; cv=none; b=qFhHuEodzLA+x88ae+Wro3D2jy9ohB7rqz/ehPrgghEvQKLdlMNsIe3HqRn7Ps+dOOeJTqfpwfHn0H9PpJxNB3zpJU91WJOoe/R/bH1FDAipjs0l7+oC+m24Qj+TteRV/YxG9W7FZYBu91iqiOtScAKwqjdMLsE3LJHXilR8l/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785791238; c=relaxed/simple;
	bh=OsgVlzmVLr5/kXYHJ8ZBVZQNm4yXod30WMwFCvSIo0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E8L5Onl6dEdPMLBL10cZe6l3UYGXMvOGRuB7h2TQB6BDDwV+f3/0CW++ytcHm7k7egv3VN4pcYgw3K3k1cDymU6rAuV324tNz2e2lNbIfRgseW/Dn/fWwt4BawxPJao1/dvHQrePsXMhLznXo5a6FladkbCb4Nze93QATChKYnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VM8p+FEC; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VM8p+FEC"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-80bb41f7f3cso38023817b3.2
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 14:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785791236; x=1786396036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xs6AeFC6wzPPBL4PftXRtu7W3n9YFR5yhGm6HKUzTww=;
        b=VM8p+FECQe2j/7JD8H1c8+Owj4eJ+8kYK29edLfbQ00nJLKqTv2TQ9uK0FASQkjdhg
         2dMNXYNWO9e8HbtyFq0xwdLlPk2Vgd/eBNkKMfCJX+jZM2Z0SKvO+FCnMXaRfjQkXrz0
         Wj2ED/K89fOscHBw49Q2Lpq/NYpdI8jAYuXsm743utHTrAdgQWnaysKDy4SybalczOug
         AljE/vfdf/9RRh1HT4ZWXSnQdXRAjR4L184pQKRaS8quQw3Z8Z1lSfZ7kowgH88vfxzI
         Bmw1fnmzDk7v5hrqTeQ4gxdOnCfuI9uBzQbtUgqjK0Bs2qm4XfH4SVdxj79BBGVwCWh/
         KAng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785791236; x=1786396036;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xs6AeFC6wzPPBL4PftXRtu7W3n9YFR5yhGm6HKUzTww=;
        b=lcPOjCRIXcN3dXpAk6XWmTkZhqPpMwaqSqCfJA/0qBe5mQwrQSaGIHPoY4m8K7mvBI
         MCMBr34KR6klfOl8wJrAR7DCqeNse4bbRL1Deflk0QSi7hIOL7YzME7b8Jjv3j8kQMVh
         Vw8I127fXcAFjyxmT4VBcG4oEdEp6SaG59KKIYZII7uwOSmt1bkkpet2mPKSTuK9nO2r
         jOjC37Lo1krkMfkR1neguvxR7YE+uG1ZW79+joXgex7M6qFI1xwyZFIA+WDB4j5kMTfr
         MWtxnYe4Va0YNPkex8n7DyAVxRHXfZrsG3rssML4hPpB8ZUXH043ApxdXWDAIY+qh5yw
         bL7Q==
X-Gm-Message-State: AOJu0YxFlbLsnyx3ni5H4QhHDcJoquWNBhuCSubbUTGL+iLBM/QYbzb7
	snWrJfML3xHmV9qMMDfinJTdIYvX2eCCSR8bsJDkOUknVOxukivYK2653ZgWQQ==
X-Gm-Gg: AR+sD12WfCAnFxD5iP3X9QN6KhhzeVN9N/cNRnSVsBcOia4wkbMQaUL/lSIRA3xnHT5
	1K156x+FvI7kEQDUKzf1JWKnE7bO0sWl33mC9u2BFKhui5dJbxZhS7Dqg+1URk+5bq///5d6IHZ
	sUV0/AqKWoQfApNTSJz7mMDkTLu6b/HxOtEJRGrIDRc0SN4y1BVdDULKp5w4u7RuOX1PStnpuLy
	ZQWEoC43CC4+CTIj+L4kCHEvZTYPxpgA/eKxgCv3Q89pGfHl7cEpEWWAnqlmeyR47KDqn6uuTI8
	I/Vxf8Tg4dzuzY20HTdTK5N30OqF2kKr2SlX48Yv/vKCGBbkGFZPlPaernbMVVJxCi5XmrfuF+1
	rG1ws4Z3qJGXPZoc7foWSjamGxc9BxHxGK2TTZo2DrJ/DuRfIthXKL6UyjMjwTlx/OEF5fH0nbh
	cgJzfgwPH5ref28ZCnpsYaS41NzIvGIl7dat22U4V4YFFFBe9VxfoHH24yukphJZQhfLWzsOGdq
	PdfBy7YnbfJ05kemgGW9lLbhnc2ykdc7wnS8Wm6Nhbo0z4ZZpaSiJJtfbU=
X-Received: by 2002:a05:690c:c91:b0:81e:abe2:e01b with SMTP id 00721157ae682-81fd4b8c96emr131532957b3.26.1785791235798;
        Mon, 03 Aug 2026 14:07:15 -0700 (PDT)
Received: from willemb.c.googlers.com.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fcd0f87efsm62099257b3.33.2026.08.03.14.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 14:07:14 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	joshua.a.hay@intel.com,
	przemyslaw.kitszel@intel.com,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH iwl-net v2] idpf: add missing cpu_to_le32 in idpf_tx_splitq_build_flow_desc
Date: Mon,  3 Aug 2026 17:06:23 -0400
Message-ID: <20260803210707.1912217-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.55.0.629.g250fe7f194-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

idpf_tx_splitq_build_flow_desc performs a 32-bit store to &cmd_dtype
to set the 8-bit cmd_dtype and zero the adjacent 3-byte timestamp
field in a single operation.

Descriptors are in little endian. Add missing cpu_to_le32 and cast to
__le32 to ensure the fields are written correctly also on big endian
platforms.

Fixes: 1a49cf814fe1 ("idpf: add Tx timestamp flows")
Signed-off-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Tony Nguyen <anthony.l.nguyen@intel.com>

---

Changes
  v1 -> v2
  - add Fixes tag, Tony's Reviewed-by and Cc: intel-wired-lan@lists.osuosl.org
  v1: https://lore.kernel.org/netdev/20260731103137.4000876-1-willemdebruijn.kernel@gmail.com/
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index c724d429a7aa..91ca75e45463 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -2408,7 +2408,7 @@ void idpf_tx_splitq_build_flow_desc(union idpf_tx_flex_desc *desc,
 				    struct idpf_tx_splitq_params *params,
 				    u16 td_cmd, u16 size)
 {
-	*(u32 *)&desc->flow.qw1.cmd_dtype = (u8)(params->dtype | td_cmd);
+	*(__le32 *)&desc->flow.qw1.cmd_dtype = cpu_to_le32((u8)(params->dtype | td_cmd));
 	desc->flow.qw1.rxr_bufsize = cpu_to_le16((u16)size);
 	desc->flow.qw1.compl_tag = cpu_to_le16(params->compl_tag);
 }
-- 
2.55.0.629.g250fe7f194-goog

