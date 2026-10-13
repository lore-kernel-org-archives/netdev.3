Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F7D51B179
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 16:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791909028; cv=none; b=SwLh9oA/TC2VGfqTjb+wVUmpX9fggbveeaZ4HUwrnuYEH58uxRPcq60ZcdgoV9zQ9UVSWkPma/3dqD9Yzy/+auKEMdxgrCatX9UB5fCq2h/SS5OAb77iVY57zAfp+ld2br2tVX7WjFAkWxAN+5FNhY8RZ++NCS1pstgCSxXf2ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791909028; c=relaxed/simple;
	bh=9m7NtTHET6m83f9Mk11W5vw2NZvap3fwY2zve4r26nk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IXAnU3y+NMgYjnsn/hgjt7XRC34Y68r8qWjz8Mz0slNQXUufgaIBOFvouWPdhH9bGHnGBx+CUnItk7h65cRCRaqVx0tYP1BpsvS4o7DN5JR8N9n62pS0NEvF8I074RFvBxA1Eaxb/f6S4r0gZWSS6/ak7CCkpU/Agp4sz6sV6yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WHg9HfOn; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WHg9HfOn"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cc785ed8aacso154402a12.2
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 09:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791909026; x=1792513826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PlQnD3vqPXRC6bXv4DWDPrp7sKdyCguQyIZC8BvmMCk=;
        b=WHg9HfOn3eqKIqfAk3JNTb3PTNGZRcurqkXrHdM32W4fyHpgK/l1YW5DSIW8h8udFC
         LBpIg9uo4UmpEAXCiWx0pa6hkuSu0vGVX0rJXVbusFYPPO3a93/lWwOtQYV55UhRrDdf
         IlqkGk+2046Ch2MnIRbaudJk3DuDpGHTE9YH2Xcd6TInhaOZpnrgsQZK28bT5IG3Tk6r
         RnjWgSbFZF6H/3h/c9W5fnXRuusJJtNvKbJyZJU73ltDepT8tGT6vEsMqtK+J3FWuT+f
         ftGchntIdS4lijiI4YRCvVrE8YRRpbcZ5E5zlBHK1O26VWRQ16MqDSmL2HurmWMiQHZ3
         Gy/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791909026; x=1792513826;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PlQnD3vqPXRC6bXv4DWDPrp7sKdyCguQyIZC8BvmMCk=;
        b=trNMnS7Sa0DMWt8vRTGxh0QS3QZ6mWmQSPay5Z/q2XRJXA0ToX6lvTIR4X5OWwz+2a
         15Qj5mqP1MLQq4A+N7vQSqV4IRqnfxIYbNcMHY1EQrI1mFzaBxVUqwGCULfDli3mpNmi
         oxRD1wsTMb1oYB6UJyY1FHiXzD8AGuhqSOIOqGZ0dOZ4k5Hkce7Kvg0QwwF110gSEoGU
         Uk7HVijvpCPyTjoFdsnTO/pvMxotySsYQ4SamArEuSkDWxFqjKSJx6yTGj3yEHIeOikQ
         xUSZ9MzwIMuh/HxFTljlyQPsx04zWiCr0yEi7RsgyWjXvdL+hiDC3iZdo+UZrONk7Jae
         itZQ==
X-Gm-Message-State: AFq9FYKGV1aIksynKdzlTJbE3J1bNY7a0cQbjP4OIqq5boNqFnEOBadR
	Zfwfq46zwFGulqDLqWTnfC6BWj3Swx3NVGTI8j+WitRjqbjj1RrEhzw+ebcJhQ==
X-Gm-Gg: AYBFou0CA8ATDaFQ0CsENb5Y5IiiGzmmZU+UA240zoCwe0k7LwFYne1xGYYU4CakeAd
	rDnwgbY7GVeX9tC6HtneKp2eL9QyAcsjBdoF++zwdgXTSS0Q5T8pyHA1gVHgWnaoi35VaIBi98p
	P87TO1N9bP1pdZubi/TTQ/6pvaPgGzhrenLHS6mqQwKIPbiMLnDK6QPbi29F/KOfy9K0j5B8wkg
	L8EfcdvisuPoak2sAXR6zbZLpunSiBcAy8dl1zmfC+PkX19Nl6pAXLXv/fCJ8ywnADIp5G/cGgB
	fbegKqQA9v76LWaOSTn7cg95OHDyQvspfifg7bvafHGnQgT+WYMHHeYH9aq1Naez1nQsbQG2xwb
	kwYe57np9xfAvpB7L2/uzYCmOZjSr8TVlFuNkkyUNlle0W8REZ6P4UauEGSxHjKIBT9bKcV0Tny
	kvoVw9YnVxnqz9nDMBAY+OoFfGBBHOn0aYS//eF22FhgLATTLE5AbDZbSC3TpGoJH0AoDI1ZFbU
	CkyHrOGy6OXyLvnBlko+KmwfxKfMBi+8nHx2iw/pDo0RNK3rWWtrb+cpXXrBjEK1KcJ
X-Received: by 2002:a05:6a20:430e:b0:3de:7dd4:e32a with SMTP id adf61e73a8af0-3e16bdae01emr16584442637.2.1791909024978;
        Tue, 13 Oct 2026 09:30:24 -0700 (PDT)
Received: from localhost.localdomain ([119.127.198.225])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd3d9e0816csm6462483a12.7.2026.10.13.09.30.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 13 Oct 2026 09:30:24 -0700 (PDT)
From: Qihang <q.h.hack.winter@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	elic@nvidia.com,
	stable@vger.kernel.org,
	Qihang <q.h.hack.winter@gmail.com>
Subject: [PATCH] net/sched: cls_api: skip indr register on failed bind
Date: Wed, 14 Oct 2026 00:30:14 +0800
Message-ID: <20261013163014.25722-1-q.h.hack.winter@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Binding a device without ndo_setup_tc() to a shared block that already
offloads records the block on flow_indir_dev_list and then fails.  Nothing
removes that record, so once the block is destroyed the next
flow_indr_dev_register() splices a list into freed memory:

  tcf_block_offload_cmd()
    -> flow_indr_dev_setup_offload()
       -> indir_dev_add()   [ record: data = block,
                                cb_list = &block->flow_block.cb_list ]
    -> return -EOPNOTSUPP
  tcf_block_offload_bind()
    -> tcf_block_offload_in_use(block) is true    [ offloadcnt > 0 ]
    -> return -EOPNOTSUPP
  tcf_block_get_ext()
    -> err_block_offload_bind            [ no tcf_block_offload_unbind() ]

Only a FLOW_BLOCK_UNBIND calls indir_dev_remove(), and the failed bind
never issues one.  The next flow_indr_dev_register() replays the record
through existing_qdiscs_register(), where list_splice() writes the new
linkage into the freed block's cb_list; the callback that the replay
allocates keeps indr.data pointing at the freed block, so a later driver
unregister reaches tc_block_indr_cleanup() on it as well.

The fix was built and the reproducer re-run clean on it.

Fix by returning -EOPNOTSUPP before flow_indr_dev_setup_offload() when the
command is FLOW_BLOCK_BIND and the block is already offloading, which is
the condition tcf_block_offload_bind() rejects the bind with, so that no
record is created.  Keep the check limited to the bind: on unbind this
branch is the only caller of indir_dev_remove(), and it runs while
offloadcnt is still non-zero.

Fixes: 74fc4f828769c ("net: Fix offloading indirect devices dependency on qdisc order creation")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Qihang <q.h.hack.winter@gmail.com>
---
 net/sched/cls_api.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index a9f54988561f..7acfe71853a7 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -860,6 +860,10 @@ static int tcf_block_offload_cmd(struct tcf_block *block,
 		return tcf_block_setup(block, &bo);
 	}
 
+	/* a bind that cannot succeed must not leave a record behind */
+	if (command == FLOW_BLOCK_BIND && tcf_block_offload_in_use(block))
+		return -EOPNOTSUPP;
+
 	flow_indr_dev_setup_offload(dev, sch, TC_SETUP_BLOCK, block, &bo,
 				    tc_block_indr_cleanup);
 	tcf_block_setup(block, &bo);
-- 
2.54.0 (Apple Git-157)

