Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC5E2D5932
	for <netdev@vger.kernel.org>; Sat, 29 Aug 2026 14:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788013539; cv=none; b=ewU2PBj8vNwnWKjMiNiGZl3SWG1eK848xlSiRlPCoSDfQ44f8vSzz64uPeCWOEeOB+/1s07Lx18Ms6Dtp+LDaOZfg1VoJYkRemIBRSR5jIiNGtjw/Zg5Q3mgd2E3iQMLyXKj5yRVw+kGFtDn1selbtlqjPp7zZAcInEUBSAygao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788013539; c=relaxed/simple;
	bh=ubMPolVr1RyqlqLsPDJ9Q3hMnDeZ3ThPTZSytVpBbcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZabBbaLelH92MBE+Q6UU1ZfRikH0H4O5iKJRC3QgRdKPr0wXTwAt6EWh9TY/ZT4e1zdutyvN/KiJXiR63u6o140uQTus6o8QY1ir3zejq+D2NzA0NDLOW2A8ETsz4Q+xNPkA6WO6i7uA7QVQjT57WSa95wsredJcWn3BS8CUn9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H1XKbvWu; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H1XKbvWu"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47f502ff678so270942f8f.0
        for <netdev@vger.kernel.org>; Sat, 29 Aug 2026 07:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788013536; x=1788618336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=krHARCezf5ftbCW4uWxA5magjwIWxrSJ3wP9w668rkk=;
        b=H1XKbvWuR3t1lrXl7A0e8hWTHBVqUNvE1QEzLrhS1rI17wT3NXyy/RY8LnvxfnkcRY
         iePgqh64ynxtJ6AEiGXGkR1rEMTvjtNFeZMmZncCS5n6OOa1q231ijiPK69YHNUO72vh
         U0Na2DE/nxUEyfS4C9BlN6hraoNGEng4TV4ll+HvVI85RGh+IV14H3eLd26NG49B02oA
         2G9It1zZomO8VevNlGbWKbrHRqeBQ8nDj6jETMM71lZOFoMbmFGqB7G0BHOSWaktuINv
         6wGw1HHOUUWKrkzYyaOCJs+ZCV+Vhylrfgplqy58XLXttlEs3ojO2001T+7H+MuFeB4M
         7Jgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788013536; x=1788618336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=krHARCezf5ftbCW4uWxA5magjwIWxrSJ3wP9w668rkk=;
        b=QDOfugM1JfEJWVgaKbXvVci/dn/elrlMZfPiqyeZgkFQKv61vxgMUEaFarnGogkT/o
         yYh6IjdRUYTEsYKL2dBfSLJo7i5n4FOpFahC265a/hqEcpq7NcDhEuJTa5dJtGlOU5CY
         busNAjNkRFsKF/Tmec65oCdxidsIjtiNnUz2nEXGlDCnMN+u2LEMa43SMJCwyU9qRdLH
         ZVi19kaF81YzvNYslclbX0MrA+aqJznz6RalCpg5NgxX12Rhz/ZRlD/4VXPtlnXMeHVm
         16A2dY4dMMJx1Y1fx2Hy5iC6xOKZEDW3u1g+0mH/cnp+ZJohT9VnwHjtZ999nBWqa3dy
         gYvg==
X-Gm-Message-State: AFuF++nRdlj5we/cXZ03/kjLXPf2xOd5U1RCdA6NpkqagZY+bCNWwCKZ
	hoRhCVU361CvUcurSQp12kpUZ6MfqAwxW9QblP3mFX94QCXTB7p+IN4jaiqBB5Dx1pY=
X-Gm-Gg: AYBFou0akpMSgOtRRqNZegqcE9AHWKJ/Vd/oBYHlxglUpYfu6CsHpFzU+KWDBkueJEI
	vqp8pgvk5FCwEeTVB7rv3bH9rnquGq+OADxAEEIfNtt+2HtTd+qZP+RNRlkjZAc3UvMR5ArDQ4h
	hil8kDqbQ5NWe46JVOd/nQylT7L0Km8RbnYA8A9EtVxCPHGNoX27ejLkGnVTr10KPFNn8j++PH/
	MojLB7i5ume63b/mKe019A6F2IMDKMIf4ZWpBTQs3MLeyb35DvGDDp4fm44tL6z8XjNs94zSIsT
	ocjfYLH44U76GvzVlwDd/pMWDrlRtb9B8F927BOt6/TwM3vdhXqk0BsB7Gdvb4/wloOCWvnN2Gk
	kzurjSB53hbSW0YwJ/yImd6ZDpyO/mSesU5OA7HkCnxk9AZC9Pg/A2ieNhT6rmJAXxfii+qc25g
	4OdhcqlgsFcsKeDEgqLXa3aTZ98qidd1XIj0Qjvyrz/HdanMlb32qu3ZIbRLMfa5PSC6ypwoHnW
	RmORgBf2cVwEo0lZH+5xq3BhCCOsIBKiGsm0o14sc1L92rashgdiTuHGqKGVrTK+UwFkevqBhwG
	gksUMaahiERSOw==
X-Received: by 2002:a05:6000:2502:b0:482:f2f2:3b99 with SMTP id ffacd0b85a97d-482f782b2cdmr10414798f8f.0.1788013536211;
        Sat, 29 Aug 2026 07:25:36 -0700 (PDT)
Received: from pop-os.. (98.102.222.87.dynamic.jazztel.es. [87.222.102.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482fbb20713sm10107497f8f.21.2026.08.29.07.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 07:25:35 -0700 (PDT)
From: Miguel Garcia <miguelgarciaroman8@gmail.com>
To: netdev@vger.kernel.org
Cc: Miguel Garcia <miguelgarciaroman8@gmail.com>,
	syzbot+372a7d84708b07f64d9b@syzkaller.appspotmail.com,
	linux-kernel@vger.kernel.org,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Subject: [PATCH net] devlink: request flash firmware without instance lock
Date: Sat, 29 Aug 2026 16:24:40 +0200
Message-ID: <20260829142525.3900565-1-miguelgarciaroman8@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <6a908733.1d9ded08.62e62.00d9.GAE@google.com>
References: <6a908733.1d9ded08.62e62.00d9.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

request_firmware() may enter the userspace fallback and call
try_to_freeze(). Holding the devlink instance lock across that call
triggers a lockdep warning and can block unregister for the duration of
the firmware fallback.

Drop the instance lock around firmware loading in both flash update paths.
The callers hold a devlink reference, which also pins the parent device.
Recheck registration after reacquiring the lock before calling into the
driver.

Fixes: b44cfd4f5b91 ("devlink: move request_firmware out of driver")
Fixes: ed539ba614a0 ("devlink: always check if the devlink instance is registered")
Reported-by: syzbot+372a7d84708b07f64d9b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=372a7d84708b07f64d9b
Signed-off-by: Miguel Garcia <miguelgarciaroman8@gmail.com>
---
 net/devlink/dev.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/net/devlink/dev.c b/net/devlink/dev.c
index 55959b0ff..cdbf39f19 100644
--- a/net/devlink/dev.c
+++ b/net/devlink/dev.c
@@ -1169,17 +1169,25 @@ int devlink_nl_flash_update_doit(struct sk_buff *skb, struct genl_info *info)
 
 	nla_file_name = info->attrs[DEVLINK_ATTR_FLASH_UPDATE_FILE_NAME];
 	file_name = nla_data(nla_file_name);
+	devl_unlock(devlink);
 	ret = request_firmware(&params.fw, file_name, devlink->dev);
+	devl_lock(devlink);
 	if (ret) {
 		NL_SET_ERR_MSG_ATTR(info->extack, nla_file_name,
 				    "failed to locate the requested firmware file");
 		return ret;
 	}
+	/* The device may have been unregistered while the lock was dropped. */
+	if (!devl_is_registered(devlink)) {
+		ret = -ENODEV;
+		goto out_release;
+	}
 
 	devlink_flash_update_begin_notify(devlink);
 	ret = devlink->ops->flash_update(devlink, &params, info->extack);
 	devlink_flash_update_end_notify(devlink);
 
+out_release:
 	release_firmware(params.fw);
 
 	return ret;
@@ -1244,15 +1252,24 @@ int devlink_compat_flash_update(struct devlink *devlink, const char *file_name)
 		ret = -EOPNOTSUPP;
 		goto out_unlock;
 	}
+	devl_unlock(devlink);
 
 	ret = request_firmware(&params.fw, file_name, devlink->dev);
+	devl_lock(devlink);
 	if (ret)
 		goto out_unlock;
 
+	/* The device may have been unregistered while the lock was dropped. */
+	if (!devl_is_registered(devlink)) {
+		ret = -ENODEV;
+		goto out_release;
+	}
+
 	devlink_flash_update_begin_notify(devlink);
 	ret = devlink->ops->flash_update(devlink, &params, NULL);
 	devlink_flash_update_end_notify(devlink);
 
+out_release:
 	release_firmware(params.fw);
 out_unlock:
 	devl_unlock(devlink);
-- 
2.43.0

