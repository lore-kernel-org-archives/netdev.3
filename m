Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2443F42A80
	for <netdev@vger.kernel.org>; Sun, 30 Aug 2026 11:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788088627; cv=none; b=sj4uSdUZfIafzcMI6VUpodl9MnC8JFQzCz/lowbJRpNpad7Dkl98qk6UM1KhMM9DVno041WCy+JAwji/zNHKKOdWrNeGFGBtZ/z8hYoo9OxfWtJXs4CTASaNlozF/dSFFUNYnXkYFjrGEP/i9+LGFq95+uWxpnKg6m8JFmoOMsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788088627; c=relaxed/simple;
	bh=LWCyxgNbdXMvmdz8E4BAcs+q1r9d6AOdZ136H5aO3V8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UIXhAzMNbroysXmJFsUkxG1Kdb6yuOlpDbr43htPuaqUzGh4AQuGQRfjjPGPGLnlDQ1nO3/3gK5vQ9CmcG+TWyejIWE8vtEH4HpYap/MdXieD/PPCz3NuJoZFyXcrjZRofTce35sxtZRaD7heBIepySL8o9hsQ7O2WnCZxNzXT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OATbsc1o; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OATbsc1o"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-482e7093e75so269749f8f.1
        for <netdev@vger.kernel.org>; Sun, 30 Aug 2026 04:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788088624; x=1788693424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=x4VO/Cw9ZIDj95FS0KQWicgscx6hGYIjScA8+mxmLtg=;
        b=OATbsc1oXg6Nj+v+8A0ZKJ5iv+pKdOur/8Pa/ov7/yuhq0iqX3EXKI6tiO4EjlXa4p
         fQb3Cb5hvtvZoQydxo95GHzht50C59VXFcCGoQXf3pLnIiVaYbuuwcjfIeVX05/Anb/J
         gnaXmX5fa1Sih+qdtVw+/k9UbDeslZuFPVqvHFWACVc3/smeiRRQ5Mthh79l/bpRPnHK
         G3JwItC/eDKrGo3LfVB5m+qRX85UwYTmnncCVL7k9Ev2Ipr72hC9HwLlEiW+RN7zSynA
         +PnY7gCUdhYeMZfYuQfMLoEhEVVxElQU4K0a2wObjsIyGJgNxj1ZMZNg8QluDU+PotWo
         bZjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788088624; x=1788693424;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x4VO/Cw9ZIDj95FS0KQWicgscx6hGYIjScA8+mxmLtg=;
        b=tBXHEw3H0KzYRERwq0EyWcrEXdgXTIR7tDhAy712yv9YHNiZt8KtwNAw1ybQY/eueU
         a9MzyrO/2fv6+hE11nBs7cWoGdnTNo74MscrlwDmWXsBQawDfNDY/RQxPSwjSDGlWJaY
         LoL6IvtdxB/iWWX2e3vlYJ97hes3GApDInFpLsYvp65nS/HnoVeqsiL/2Who1tL80sMq
         79QhtqQeADEWgHxN8w06ml3HMikxDuxvMl8ciE1hXT2QX7V+WXALGxc4clvKrffPvjk0
         gHNxCtv5P57mrMUdGzv+OKAYakUFN8MB8fRcqKN+PKfF/H6zz8FSygmy66MoOUXs6FbX
         s84w==
X-Gm-Message-State: AFuF++m29FxrmI/UPgI4WEKfKTBQ3EoxYEW8HGcB5xtRbIOd7QyD4hnI
	4DOh44K5qfQbxjGJZZ9u5AqhAhtXiIRCCDLmoZbkRCu7cw/kRENdVZJ0wSu58rheick=
X-Gm-Gg: AYBFou0sJJo4cQNvRDuA6glkY5JPJDopIfjsGp0UtMFaMx8/6xgXowBp9BwW/BYJE26
	RlLLGsptv/AoubNPdj1esbAek/stzKgV39e8fpnh/1s+zfto3HFewXjavGlFCWigQg2cQ4kGRh2
	UkJxzXUGFdddAd7KvuOAPSXPHgrpRHL7D1K5feUUGRNWdxHgcSswq6SxxXN5WOhc46aZRLWD3WZ
	+9C5S5MnfYFV7d+HigC7sNVHTFEeAt6zMGYqjjyFKoQi/f4DpxiZmZQDZzIspxmpU5ciwAQvLRz
	uPvPSDZUGcW0y55L6oID2qclJE74t+aoflCxLxTxoZs4ZalJun6OeRH5PgAveHZU4kmHvCEf1TU
	JcxmNXqEwb/d19WP4VFRLUkWL+MacawktjawY8xdhM40QqCyXcqmSIzuWkwLRuoAkcjtqoLWmY0
	jbMG/7cyZp0ma1cdOIyzBW/rzEYRXjwxH5nWhKEqdzt5hC+fFMdQGr/qYDRoPUU+WhpxfwcOJU0
	ACoEzyxmiSL7nXZYPchAIqkFgKYpYmhOlOvds1316Ldp9jgnD7w/7RJ2eVGJ1edC+YuA5OOpuTJ
	2w1YAO2pSGfMMg==
X-Received: by 2002:a5d:5885:0:b0:482:f1fc:d9a0 with SMTP id ffacd0b85a97d-482f79de183mr14582361f8f.4.1788088624046;
        Sun, 30 Aug 2026 04:17:04 -0700 (PDT)
Received: from pop-os.. (98.102.222.87.dynamic.jazztel.es. [87.222.102.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482fbb20737sm14000985f8f.22.2026.08.30.04.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 04:17:02 -0700 (PDT)
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
Subject: [PATCH net v2] devlink: request flash firmware without instance lock
Date: Sun, 30 Aug 2026 13:17:00 +0200
Message-ID: <20260830111700.1799255-1-miguelgarciaroman8@gmail.com>
X-Mailer: git-send-email 2.43.0
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
Reported-by: syzbot+372a7d84708b07f64d9b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=372a7d84708b07f64d9b
Signed-off-by: Miguel Garcia <miguelgarciaroman8@gmail.com>
---
Changes in v2:
- Cc Jacob Keller, author of b44cfd4f5b91, as requested by Andrew Lunn.
- Keep only b44cfd4f5b91 as the Fixes tag; ed539ba614a0 provides the
  registration check but did not introduce the locking bug.

v1: https://lore.kernel.org/r/20260829142525.3900565-1-miguelgarciaroman8@gmail.com

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
