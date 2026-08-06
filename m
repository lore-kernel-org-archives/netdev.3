Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F493115AF
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 11:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786016575; cv=none; b=MTYUFBshKdhLtVxl3zBoSD5pBuwrPVdu5zyC1aUmgd5Z6uJlQ875j4llfM+cWQaycfIXHqUCcYi0KuMOkxzHt6kPZDSqLbuCqhsNO6l79udhKfJILB8E19qyQO422bMjalCUQszxA80xVytvwjft9o0sHi7beE4jVFFA0UxWanI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786016575; c=relaxed/simple;
	bh=lLIv+GBfnp0Asaitu6xr1dOWl+9//A2rCdI6bcSWBJU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iGofolUdV2KFofz1bcOHo3sbVh1dux5o/VjxnuJ2AdxBssjCQr9z9Ss+IDftJta8+I9iDg6KbvM/eZtmzemyww9cXYSLsIdxcw+npnhBsKp+JnG9VObBu/1dYbMjachhB9AdEXa0r2WT5mh0XvIJmotCcW5KlzLwt5EULDOJaR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X181mcOd; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X181mcOd"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-47f3b39f2a1so1572085f8f.2
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 04:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786016572; x=1786621372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pP2RHdBvl9Vbu++q0+wAPww43hCY6xSyT/WVN5AI6mc=;
        b=X181mcOdvLw8kpjFHLUiB31+3As/MGZOGmQnnMLQyhqIaG0NbgqVm0poCpHlUt+XKN
         vdXMUocwKMSHg6IsKcb5pGKmfeFE9ZNSFElYUwwbE/pQulE+dDb3OhaFJSptps0pLyid
         0hh1VFqJ5Fo6euIVV8F1aobpNcxHcCJsDzOI4boZLR809FARElPiEeL8vfVbKO0blYQu
         AaNItjPutYl4Gs5H27Re2y4liDSfwTU51UrwIy2jMHOQVxDKkYVeXuyI6mt+kmlcvYZs
         Fffo1d+ECZX0DiGcvyPBIqeLwPWDhCnszE55bSpbDfcAezK0ebnV0sr7PXkf/u0JtxAq
         yIdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786016572; x=1786621372;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pP2RHdBvl9Vbu++q0+wAPww43hCY6xSyT/WVN5AI6mc=;
        b=lgRa9uc4xnYOdxQycV8dICDG9NOXyg4nn1apy51WBJDIaeVpKkO54Nj9PoZZsIE66U
         Q8W+qcSgT1RHRwXs6vIKG9JKci2aMj8tq+QlPy3FPKjXXFRDhZhAOKibu0Kw0BA2FoQz
         t3Yu8Q5u/16C1BF1mgpAMCaBmPQlMOgkuPe7ICrwMc0ECpRJgd23P7BzLgcpVhRd69Pc
         NlXMbwuFT3MycKBDRPiRrln3CJKnqIB4uQ+ab5AMrgHkOsZ2SH8gI4Tk3qb8kCROdCwt
         I2RN27/KGmwHm/tWFIJUjZFZzjZSZIehzkzeavOKII1+3pmt/SGY8dbAKn+gkfkdLHVU
         vlyQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq0PlRJPtRSznBmAW3IjF1ys3jPFURshOD9jtgn2xOu+UovWifkqu2HDwxyCvAPh20d++mRNh8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym+cV1LfQH66/mykLwOWXMyTe7+6MNIuRG6U9YVyGqWhWnCDqV
	2TN5JPGjact6b+4IwqTgaFCtoBeAFwZB3RFN3sjWhvR8OBTZdMkp0qyI
X-Gm-Gg: AR+sD12bQ9MbkDMkM7VX+TiZYJIXs4oDkNZEUOfzF+hL/X8gwjMuAnwegJm6m7ql5Cw
	mM4PzMZr5PwMs5N2R6YyE/vLrxc7SxMYLTACzvSYnrJ+feMmpJ89Hem3cpdhA+osm119OX4WYdG
	KSE/DejLli90tKeJYZVs5AC0mHgVT0eQY5RgIqBdL331MZp9qLC18VZX6jiOst3AzgKGIhgixEy
	tO4N6ei5UNTULV+xjqGSCDrENBNbwyE0jj3T7zaoRAlbEuTdetWSEAtCnZsvgmp6c5/3tDx1BQT
	psB4I0f7le+z/xJU/QvGH9TefghcVBQQRXTN1sHQJYnnZU62fyNeT5wQa6mIB2kt/qqRNFYms2S
	oHCZZslszDoYvu+hL0S/uXK1CDZ2uHQBuNJqaPCgu1Yp8KmUiiTdr8iEj/Rie9uzyjUW+VCt0a0
	sxJM2qhDZQ61MaPQDxy0es3CYY38/rfnKGkr2EVAGbWCr6d+6O3s+V3GB+7wijbBBFKaT9xXhLk
	9xVkmJFo+P1Xjmt0I4P1U0oonJO+tJiOms4msITbldECwx7f55vxS5hnTDX4XIYZlglcJpJR3pH
	gahUKemnKscK
X-Received: by 2002:a05:600c:8b23:b0:495:4d00:2fc0 with SMTP id 5b1f17b1804b1-4994e7bb12dmr172180005e9.12.1786016572398;
        Thu, 06 Aug 2026 04:42:52 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499542135cesm60598005e9.4.2026.08.06.04.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 04:42:51 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH io_uring-7.2 1/1] io_uring/zcrx: fail non-qops netdevs early
Date: Thu,  6 Aug 2026 12:42:33 +0100
Message-ID: <23ae94da6725cac660652781b3533a20d0a1ad34.1786016493.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

netdev_get_by_index_lock() might return a netdev that doesn't have qops
and also relies on rtnl. We're going to reject it later when opening a
queue, but netdev_queue_get_dma_dev() warns before that. Reject non-qops
netdevs earlier for now.

RTNL: assertion failed at ./include/net/netdev_lock.h (72)
WARNING: ./include/net/netdev_lock.h:72 at netdev_assert_locked_ops_compat
    include/net/netdev_lock.h:72 [inline]
WARNING: ./include/net/netdev_lock.h:72 at netdev_queue_get_dma_dev+0x52e/0x660
    net/core/netdev_queues.c:43,
RIP: 0010:netdev_assert_locked_ops_compat include/net/netdev_lock.h:72 [inline]
RIP: 0010:netdev_queue_get_dma_dev+0x53a/0x660 net/core/netdev_queues.c:43
Call Trace:
 <TASK>
 zcrx_register_netdev io_uring/zcrx.c:831 [inline]
 io_register_zcrx+0xe94/0x1d30 io_uring/zcrx.c:983
 __io_uring_register io_uring/register.c:942 [inline]
 __do_sys_io_uring_register+0x1193/0x1bc0 io_uring/register.c:1040
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Cc: stable@vger.kernel.org
Fixes: b6c5f9454ef34 ("io_uring/zcrx: call netdev_queue_get_dma_dev() under instance lock")
Reported-by: syzbot+a78926bdac2adb52dc0e@syzkaller.appspotmail.com
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index f1464ea8ca64..add91d6d6e52 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -825,6 +825,10 @@ static int zcrx_register_netdev(struct io_zcrx_ifq *ifq,
 						reg->if_idx);
 	if (!ifq->netdev)
 		return -ENODEV;
+	if (!ifq->netdev->queue_mgmt_ops) {
+		ret = -EOPNOTSUPP;
+		goto netdev_put_unlock;
+	}
 
 	netdev_hold(ifq->netdev, &ifq->netdev_tracker, GFP_KERNEL);
 
-- 
2.54.0

