Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A434D7D38
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 12:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791549581; cv=none; b=fXXmExANm7lMlxsT6+NRCFYgPIerf0xO5WAnGTF6XB2JYmnqvAVrM6GPU46atabN2Ef5++XgljbfiyX60RRI9hDzV46WauGrCXKWSK2ASx1ALpM+U4cgQSLhGsGTZd5U5NCSt+nwyGEpg+4XdPby3FkYwpekJ2DZ+gLNf3SCOFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791549581; c=relaxed/simple;
	bh=YkFngmUHJVNtqW4md/XBpJxxkgF7T+dBARvecXA4TKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mw5vQ41eVi3RnZFV2B+zV6AW+ahPDlzIH3VSJ42bPpRkULJij4ZFU/wg4w3aEbz7Oy2/AyAM6Gdme580jES0y66YmSTui4pSpuIzpiC6/OnXU5Cmmr+u1WWt8tOHehE8Z/ZaDkdiEbRHDcNGOYzCvd0zQDaymvNHP2/6WzbZabo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XQcts8ut; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQcts8ut"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-3a9ad623098so17753851fa.1
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 05:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791549572; x=1792154372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kyY83NomyQWfh4LKX7bgA+B05RDisIzsK5TyQRhxHSo=;
        b=XQcts8utbnFWyDR2h9ZGUIOpzNZR6Z6PuazvleT+oEA/CzCd+cRYfnWZWkD0V5Jfx6
         yXRd/OeaJpaZfZJ/ijIdMY3DuipEFnbkUSWNSlGJLNitl7x48sMzygVlFAU8Bgjjslvy
         j/b1aY4NAvuSposZiOeMs6cSEHZicRCxIfGWZJvsSH2UC5aruO25QghzVXwxVzI+gnsk
         /SHZdZeYEd8bqG/ADYuX0/8LoGNfPzLDMedWsMwvdvKfBU+dW+ddXU8D8rW4ftOkQ1RK
         KZX8mK4OtWcBRAPWDmvCuOGzv4u8hOdr1xN56DY15TtFGDU975CQr86WRAJy8tFjY2zw
         ok5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791549572; x=1792154372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kyY83NomyQWfh4LKX7bgA+B05RDisIzsK5TyQRhxHSo=;
        b=xYkFEH1bOCt/0kYxsHKLEm2nxVfTZ3LfVgKv9iw/W0RZIMRz7LHv2B7oNGb1y3jss4
         vfelAb8Zzz5AbmQQUX+nVRHSV7TsymzBXA2ca0DTM8/L0PuZA0954Yxrgbf0HYSm7cIA
         lu4qS7IGfnwrO6DFCKc3asEYB/cFri9vo6y/uJJY0rLKw4TifA1avNTifQXL9f7HRIWy
         r6NonFoq6OlIR7FL67j2At0HESMC5a6ucCVGNDLYsNZykO6P61VWE1TSUQI9HwoLeHKs
         AAp9y4rDPD+dQrPW7SU+99yk3oyIQNVZG99JnpoYwHbnj6cCoHE0jeXljOvlbZlLLznD
         33zA==
X-Forwarded-Encrypted: i=1; AKwUvBwQs82IlMJYZNyYD63EaiI2O44FTYpgAWg9Mx+dVWWLRKGhb/fH3XFhjUERzr40Nm0JVxPhXSg=@vger.kernel.org
X-Gm-Message-State: AFq9FYK4w+gg1vrfDZrNe7/g4TNC0otXYlH6yNaZnalJOsQzbq/yCrA/
	yrfUiWxDXgHcugh3p6m+k2DmolO62eA7WjwrkH4FxeWGh69CRHWJ1Rfw45k+dEP9
X-Gm-Gg: AYBFou39sH4WRfRKocgYkRhA8igU48x3xoD8C25iyHyNHdnuSC4W471R3sObwrqY3Gs
	H8zTopSLaygowp65aYbygfH8J44YM+qSDYbWF9hm8wNchXGVZYfbZ9sL0dLxh/RVxbFQTKdWcBV
	odFoaYuStc1UW9rQh/litREHjUIqz7IX+EHt2jaDtrDYRSqySvmm3KPoWXcX8/Ablf4KAn81kjs
	ZlRJG4pX58LoNgDO1F9oooNvMai+LXPoRXtJrXZESKd7nMVXgNseM/ElEYUFat2xU5HkAz4zmU6
	QQxCC1NumxDV3wTAmu4GucMPcQlQTQ/ATGW39chpqFuLg/yBBxK+i0J8mA5He+04+gKYaMtXI9s
	VD38S8yRcxHAcRkYahJ1bbLmF3ytAN5eg3w3/A5ZtgY/majrEzxlRn9Pw9LyNUm3uvpHTzqALmW
	JuhBJtlCRO4o1bYouhu0xGLy40RxYXOSkptuJhaoE4u5Xy37HDIpVgQNBwyZN6OCt/ByoCdFepR
	ARu
X-Received: by 2002:a05:651c:549:b0:3a9:7b12:b35b with SMTP id 38308e7fff4ca-3a9c53b2811mr4542691fa.12.1791549572202;
        Fri, 09 Oct 2026 05:39:32 -0700 (PDT)
Received: from grower.uveon.ru ([37.230.157.20])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a9c3cf5903sm6729281fa.42.2026.10.09.05.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 05:39:31 -0700 (PDT)
From: Alexander Martyniuk <alexevgmart@gmail.com>
To: pchelkin@ispras.ru,
	stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: alexevgmart@gmail.com,
	davem@davemloft.net,
	johannes.berg@intel.com,
	johannes@sipsolutions.net,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	lvc-project@linuxtesting.org,
	netdev@vger.kernel.org,
	syzbot+63a84ea9c0f57d6133fa@syzkaller.appspotmail.com,
	thomas@cozybit.com
Subject: [PATCH 5.10/5.15 v2] wifi: mac80211: mesh: release the channel if start fails
Date: Fri,  9 Oct 2026 15:39:26 +0300
Message-ID: <20261009123926.22180-1-alexevgmart@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261008220352-4a493878ce385d22bedcf4a4-pchelkin@ispras>
References: <20261008220352-4a493878ce385d22bedcf4a4-pchelkin@ispras>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

commit ae97fff6495a8764bc0ef281cfe5444f701e527f upstream.

ieee80211_join_mesh() acquires a channel context and then calls
ieee80211_start_mesh(), which can fail. In that case, the chanctx
isn't released then interface removal will attempt to unassign it
after it's removed from the driver, hitting:

  wlan0: Failed check-sdata-in-driver check, flags: 0x0
  WARNING: net/mac80211/driver-ops.c:366 at drv_unassign_vif_chanctx
   ieee80211_assign_link_chanctx
   __ieee80211_link_release_channel
   ieee80211_link_release_channel
   ieee80211_teardown_sdata
   unregister_netdevice_many_notify
   _cfg80211_unregister_wdev
   ieee80211_remove_interfaces
   ieee80211_unregister_hw
   mac80211_hwsim_del_radio
   hwsim_exit_net

Correctly release the channel on start failures.

Assisted-by: LLM
Reported-by: syzbot+63a84ea9c0f57d6133fa@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=63a84ea9c0f57d6133fa
Fixes: 2b5e19677592 ("mac80211: cache mesh beacon")
Link: https://patch.msgid.link/20260908122838.201719-21-johannes@sipsolutions.net
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
[Alexander: No such function ieee80211_link_release_channel(), so
ieee80211_vif_release_channel() is used]
Signed-off-by: Alexander Martyniuk <alexevgmart@gmail.com>
---
Backport fix for CVE-2026-98326
 net/mac80211/cfg.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 29bcb5f6013a..d5865f4083cf 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -2311,7 +2311,14 @@ static int ieee80211_join_mesh(struct wiphy *wiphy, struct net_device *dev,
 	if (err)
 		return err;
 
-	return ieee80211_start_mesh(sdata);
+	err = ieee80211_start_mesh(sdata);
+	if (err) {
+		mutex_lock(&sdata->local->mtx);
+		ieee80211_vif_release_channel(sdata);
+		mutex_unlock(&sdata->local->mtx);
+	}
+
+	return err;
 }
 
 static int ieee80211_leave_mesh(struct wiphy *wiphy, struct net_device *dev)
-- 
2.43.0

