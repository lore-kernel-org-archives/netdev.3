Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D402843A7F5
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 09:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788343078; cv=none; b=cbynfjW9P9syo5DbF8A+WnP08KvTDrw34aD5s2pEjv+mGXwQsxk3s7PUvIXU3Rt+/1tmnOBWU5Q1/5c2K/kSeym83Obfok5KGo9fjT6L+4sPQzE0qa7s3qmcyt0U6Ek3SNsKm8v82lFQjYzdWHDzQawjcl8I8yapMNaSD/wVO1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788343078; c=relaxed/simple;
	bh=Rn3Ml6qD+1HHdOTjNfgj8Ak/gjAuC1HBFzLG+cdX6mw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j6jDmaVJ4YaeHG/d3yhBeWw4pqa2kXcHOkm2fe/LxhxRVu+A52oLO2ZWP5/Qu+tHGEcd8tO/y4XeGoxLVYqzcaJd3Xg4P8wub0UqoBIGwiiwotTDLn2El2vY9Aq/bpoHZY0O5oxRdZCHJyauiUd/ZT2cOhyRNKk6p9lfLfvJC6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BCW3LOeZ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BCW3LOeZ"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-499c0879d51so689585e9.2
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 02:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788343074; x=1788947874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bdTxfR9/XiBh42PkGitR6A4ZtE4V1E6y6EFDszmsd5s=;
        b=BCW3LOeZGqLem7DnM19NhwrgjegrdcVfE1gzXeW22UmibPhV7Sk50+UWRREKDW3PqR
         PR3z2Ze+y6H+MRPUEg3RjwoJdt5VlJlxWt1OcasFDgju+9s/xUleEh79t5r2Tk0UiPR4
         Iw3+S6uVLVoobf8EYHGyF10Azqv2bTGn+CJ9NL9HlhjI53W/W8juwAn5wmEyq7tyEMs4
         aXv/01EirO1mCkcATWxhS3fxt8AGXiglTufPXDREBzN5JceYQyIWk0JiZjzxTWnuX7yR
         1ZhbXeDCzA8a7HoUQ/R0rgOL6ThKzS9A3rRWgT1UvtQ93i5tpCS/biLudr0ljZuQ9OnF
         nyGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788343074; x=1788947874;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bdTxfR9/XiBh42PkGitR6A4ZtE4V1E6y6EFDszmsd5s=;
        b=HW7HpkdRyFsjFSXmoIUNHqhbolR3svWIPTR/zlT8x2exDci81h1O+KIj2IhniOiZi/
         5OXp19DNSadXY2942jhh0b8jwFO8P2ZrNkH1epy3LNqmeWy0QeH0l7Vf8oIZO5mvraGn
         RDYvNlbYjajjBkIxcIS8ih44maVR5iKSvZVCldgzKoBRJvjvghNDpUMUVQoHEnpFeYnb
         SfQ2KXXG4ZjgnTfJLfyTsTNOV3V2lxi0wBJ8c+z02B2KBpDzwSJ+4rj64sQ+O7FpM7yW
         UGC/21S0vGTuv8Sy4aeLTTGDCcXW8noXKxoLeDPf6XwnRvhCh2YX8Gsdo753UKotfceK
         3UEg==
X-Gm-Message-State: AFuF++n335V9Y3AaftITwN1dShfNBPm+lzYYcZsZOjd9kVdmeEL/Njw1
	KFajurBiIAqLWfgwT2Fqp1ySv+xpB0LSyqeO9Z0g14tQ/v9sFX2fze+83uQYnpDnLDQ=
X-Gm-Gg: AR+sD12ftZHTclo4LVxFqEZ1q+AvYNKGrqws1Kf8U3UzsXvBw4ccQwqh2+FqqtWqqbf
	jQZmklnrlMArLVA2VNOMNoU87HDV71lBaAq2fz6zfMpZVsedINyB1Xw2a8OUgBzt5kb5HjenYCn
	T4bgNdTrwYP6nSavnRGoUlKI5EiX48Wqh5iT49T6+rNLu/LBpNsePcmqBG76ECdre4BgCFfl4YY
	KHTbqq0Bl82pH7ksdoY0SOf3kQth10KhRSyIssr6TnvpIHm6V2TSWT05JmBZ1xeC23Bp4olCa98
	pX4jhOE49DnKn788Tmn+1zwuhopOoOrUo3KNNpMjoUjUzOR6kDnFs/9iob2TPY3dhofOO8w61eF
	DqJU4uKMm4iWF/qx1+dc4mvJd9/mlPdysqFqUf2sfbcd+sEGLR9k8usfXCgCmc0TC1wH+7t+dup
	w9Gv5bWThbDoX6XJ3Ic/fIYYISe+61rFpBrmFcNz5Vo1BJtHJ2zewKRw3xH4YhvpgwOiTfsmdrk
	DUAgQO/oiI4ubvpVQGLNkxbqoCkMlY1qs/tS7D+VwILK1Bg/3a1mLnIHJCYwWsSW7/i59D3XADk
	bbhiRaBQGfvmhBM=
X-Received: by 2002:a05:600c:3b03:b0:49b:910c:76fb with SMTP id 5b1f17b1804b1-49ce58252e3mr29148515e9.2.1788343073581;
        Wed, 02 Sep 2026 02:57:53 -0700 (PDT)
Received: from pop-os.. (98.102.222.87.dynamic.jazztel.es. [87.222.102.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce46422desm54543615e9.1.2026.09.02.02.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 02:57:53 -0700 (PDT)
From: Miguel Garcia <miguelgarciaroman8@gmail.com>
To: netdev@vger.kernel.org
Cc: Miguel Garcia <miguelgarciaroman8@gmail.com>,
	andrew@lunn.ch,
	jacob.e.keller@intel.com,
	syzbot+372a7d84708b07f64d9b@syzkaller.appspotmail.com,
	linux-kernel@vger.kernel.org,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Subject: [PATCH net v4] devlink: use direct firmware requests for flash updates
Date: Wed,  2 Sep 2026 11:57:30 +0200
Message-ID: <20260902095739.3587287-1-miguelgarciaroman8@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

request_firmware() may enter the sysfs fallback and call
try_to_freeze(). Devlink invokes it while holding the instance lock,
causing syzbot to report:

  WARNING: syz-executor/... still has locks held!

Firmware flash requests already name a file provided by userspace.
Use request_firmware_direct() in both flash update paths so a missing
file fails immediately instead of entering the sysfs fallback. This
keeps the normal devlink locking intact.

On systems with CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y, devlink flash
can no longer obtain a missing image through that fallback. Callers still
receive the existing error result, and netlink users retain the extack
message.

Fixes: b44cfd4f5b91 ("devlink: move request_firmware out of driver")
Reported-by: syzbot+372a7d84708b07f64d9b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=372a7d84708b07f64d9b
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Miguel Garcia <miguelgarciaroman8@gmail.com>
---
Changes in v4:
- Resend as a new thread so patchwork and CI pick up the new revision.

Changes in v3:
- Use request_firmware_direct() instead of dropping the devlink instance
  lock, as suggested by Jakub Kicinski.
- Document the resulting sysfs fallback behavior.
- Rebase onto net/main at bc93419130bb.

Changes in v2:
- Cc Jacob Keller, author of b44cfd4f5b91, as requested by Andrew Lunn.
- Keep only b44cfd4f5b91 as the Fixes tag; ed539ba614a0 provides the
  registration check but did not introduce the locking bug.

v3: https://lore.kernel.org/r/20260901123819.2035064-1-miguelgarciaroman8@gmail.com
v2: https://lore.kernel.org/r/20260830111700.1799255-1-miguelgarciaroman8@gmail.com
v1: https://lore.kernel.org/r/20260829142525.3900565-1-miguelgarciaroman8@gmail.com

 net/devlink/dev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/devlink/dev.c b/net/devlink/dev.c
index 55959b0ff..b85bb02a9 100644
--- a/net/devlink/dev.c
+++ b/net/devlink/dev.c
@@ -1169,7 +1169,7 @@ int devlink_nl_flash_update_doit(struct sk_buff *skb, struct genl_info *info)
 
 	nla_file_name = info->attrs[DEVLINK_ATTR_FLASH_UPDATE_FILE_NAME];
 	file_name = nla_data(nla_file_name);
-	ret = request_firmware(&params.fw, file_name, devlink->dev);
+	ret = request_firmware_direct(&params.fw, file_name, devlink->dev);
 	if (ret) {
 		NL_SET_ERR_MSG_ATTR(info->extack, nla_file_name,
 				    "failed to locate the requested firmware file");
@@ -1245,7 +1245,7 @@ int devlink_compat_flash_update(struct devlink *devlink, const char *file_name)
 		goto out_unlock;
 	}
 
-	ret = request_firmware(&params.fw, file_name, devlink->dev);
+	ret = request_firmware_direct(&params.fw, file_name, devlink->dev);
 	if (ret)
 		goto out_unlock;
 
-- 
2.43.0
