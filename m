Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301BF1DED42
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 02:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787539591; cv=none; b=fSXDxNP+PLL4rwMpBbw1yd8RcyGqZSOFpuqjYaIuQyGBoa9vX140VED6v7dRBydq8JHYWXJERct+WSe1Y+O+OMdXYR2eyrk05U1x+p9axtrhVlbswusPWRyArYxhqXQS190UBwnXUp4XpCxHK/LbJ/8VsdBJ43/Tw3ju3zqH8mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787539591; c=relaxed/simple;
	bh=6wHJp5jWLPXyCPbYYK7srf8P7Lk/x3nahhhtNbm1rOc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WMWS4JHHEbW1qimUu3kqJjZc/yaY3Nw8i94Z4r4gsXcVNSTDt0Kpqti5fqtSQM583chR32ZUCs1udyJ0qXaVM+LYOxRioNjhW5ibU3JLsS0gsj4Prnw/g4bjTgPF4hcgX5BNdKkcovWoLY4fpxxOGGKr4RdE1w6k6K0rfARUE9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tHwzdLUG; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tHwzdLUG"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cbee846deecso3393713a12.1
        for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 19:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787539589; x=1788144389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JdXAVtfWW5XJfHD/rPxea3ZWIOeQzMPQX3bPL/2GZJM=;
        b=tHwzdLUGkEuymfGBZd0yUkMv9ICFDKDT/V2s5F2wZ0XOQN/ujIIXDGZp+v6hlLPr6c
         BkqlIlw5O7abckrZ4/bqWLVcjQpspOlzfje5uqkGoXhMXeRBu3sTr2skr2qCeLlN2D2w
         udlCwEKwK/TJoQZC9H/uon8315p+Qq6ZkElrOy2TnqbQ+Zhe6KBcfYIU47JoM8CYRKKs
         f0i5zpELEbBo37AJ006EXlC5n8fX6Ha4FzyBi29AKDxCEwJGptDfqRv243TEW+nS4Se6
         lAjGB9xG9mQLT/vZ3AO9XvK/VH61eix1/M2YBMGnkyQurUndIGXsZt74h1rrHpuStz4R
         1J6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787539589; x=1788144389;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JdXAVtfWW5XJfHD/rPxea3ZWIOeQzMPQX3bPL/2GZJM=;
        b=RkicavwDRmjt4Q2SeCiA8+399v/YU0DYxRI8lAozJfzPgrUxHNLIRK963bRkh6LMRK
         L3/r0cuCUpu+5hI1t0741lwySsjnk+vrfZCFxrb9INfkS4wzRXcW7n76x8o9iPFKCjj7
         EiJiH3G/qsgEr6+g9kJBURya3SDVXtF/dLhUFfUT5/iQZMztSxk7tH3rfcTGzDpZxFsj
         4FiNOzVdm1X2qtVZvOfxT06U0tiF98Zu92ZSmlbmroPRGjAUuuVDND2WjGAzQF+0c9En
         pvgzXut1AyzjKcmJnSCNzRoy0iUoH4DQwKo4gioRuwalBw2JPFGT8Zwhxe50xgFNIYl0
         uWzw==
X-Forwarded-Encrypted: i=1; AHgh+Rp/LrtJzjQmh2MebVWxYijBep37ZZZJMg/Rlomx4Bd+p58AXIzshP+qb9dbhpNihJYpK/cyYK0=@vger.kernel.org
X-Gm-Message-State: AFuF++meABRb+y8wnbWPaIfK2qYyGLIA7n66ybsK2qbi0mAInRQ2ulo0
	U6jt6/Mkr7T2UiKum7C2+FuM0OOC1gdqIhLzrJwhQBdMK4aA1lzvKWfw
X-Gm-Gg: AR+sD10XKbWBUQ/NWVVHAD7x++MIsnhdgHnf5M4Ctm7PzOSs27BgEq3D9qPcaD9RJww
	JkXOLGvTlfkz3IwjtoqwchErm757926rCr2Kn/xsSpNeSuS6K1jHRb2dgD6hViSZSnt31jc3Jt+
	Bg9aY9JHkywiZ3SpcJSiuURvHkKFBWvFh9lByfViVZSKG9emM2rpipEJp5lvhFht0OyiIrgzg5j
	YTwtkaUA2be6PXHzbAknMbvLEct7FtFqf6iKf0nnWECHfDkkMb5HkI6OE8PW2bU1mbVP8zB6vTc
	/XPsA6Tyj5ybVQ06A2C3AyGSdMVDrajSKet0XZ6twe5W9JLzjNqWeTDUqs/y5zKckA8tA3v0TwE
	czOn1U+4gByhWzR2FMJxU6xIhSMsPhdFki4TwTevg2V994Qg+0Gd3SFlDKRDAYTC0Vn8vZySgPr
	cTODMou6WmFg40xjxY6BWhKzeVfSgnHOrAJuOyQLxy+NxM2dWVrina3pyn1f3nHKXIVboSjTv6L
	lMxg19XPXMg2Vc/xlHMsZg=
X-Received: by 2002:a17:90b:2e8f:b0:381:e74f:8a6a with SMTP id 98e67ed59e1d1-395c3abee54mr41014455a91.16.1787539589306;
        Sun, 23 Aug 2026 19:46:29 -0700 (PDT)
Received: from deepanshu.. ([2405:201:682f:383f:4cf4:9e7a:69d:2900])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f90e22f8sm18744195eec.13.2026.08.23.19.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 19:46:28 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: 3chas3@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: linux-atm-general@lists.sourceforge.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+6665d3db5fef15914802@syzkaller.appspotmail.com
Subject: [PATCH] net: atm: fix shift-out-of-bounds in __vcc_connect()
Date: Mon, 24 Aug 2026 08:16:20 +0530
Message-Id: <20260824024620.23485-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dev->ci_range.vpi_bits and vci_bits can legitimately be ATM_CI_MAX (-1),
a sentinel meaning "no range configured, use maximum" (see
include/uapi/linux/atmdev.h). Some drivers, such as usbatm_atm_init()
in drivers/usb/atm/usbatm.c, set this sentinel and never resolve it to
an actual bit width.

__vcc_connect() uses these fields directly as a shift amount without
checking for the sentinel, so binding a PVC socket on such a device
triggers a negative shift:

  UBSAN: shift-out-of-bounds in net/atm/common.c:381:10
  shift exponent -1 is negative

Skip the range check when ci_range.vpi_bits/vci_bits is still
ATM_CI_MAX, since that value means "unrestricted".

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+6665d3db5fef15914802@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=6665d3db5fef15914802
Tested-by: syzbot+6665d3db5fef15914802@syzkaller.appspotmail.com
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 net/atm/common.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/atm/common.c b/net/atm/common.c
index 81195727fa18..73057bb016f7 100644
--- a/net/atm/common.c
+++ b/net/atm/common.c
@@ -378,8 +378,11 @@ static int __vcc_connect(struct atm_vcc *vcc, struct atm_dev *dev, short vpi,
 	int error;
 
 	if ((vpi != ATM_VPI_UNSPEC && vpi != ATM_VPI_ANY &&
+	    dev->ci_range.vpi_bits != ATM_CI_MAX &&
 	    vpi >> dev->ci_range.vpi_bits) || (vci != ATM_VCI_UNSPEC &&
-	    vci != ATM_VCI_ANY && vci >> dev->ci_range.vci_bits))
+	    vci != ATM_VCI_ANY &&
+	    dev->ci_range.vci_bits != ATM_CI_MAX &&
+	    vci >> dev->ci_range.vci_bits))
 		return -EINVAL;
 	if (vci > 0 && vci < ATM_NOT_RSV_VCI && !capable(CAP_NET_BIND_SERVICE))
 		return -EPERM;
-- 
2.34.1

