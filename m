Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4585616C6
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 12:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788957466; cv=none; b=ZQ+hwSjuPYCr7QCgtCmvq1v4k+9jj32zcXuWDh0Mw8iaSUbEZP2Zq/xQYO0BSvOQPuOUAvRJRVdRPCoNsCJfDE4BnT90u70Ef+l6/b7/n8Jtn+TtltmsVS20Whgc7gODWYcLkzLjQTrnnYZTZVnPe5GlRS8iY4b3DP/tf16QfNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788957466; c=relaxed/simple;
	bh=3+ese/BC7ABQtPNeXTWrPYUi2tWpSVRo5ACoFFtlpsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HqkH8M0auResG0CPdipQnOpP2lovolvgGMLA3shW95KzrZmy72hSRd/KuSHtnNy7A2sw1kQ7VRqxXIXjfc4A+gh90XSQGKt9+kvmE+sRRWBconK90nKJOWbLysgBc85JtgtiNiJxv6bTDHPmW7A6oqx9DJLlAgmJ9KmsyyaV2o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=bk6wRSPB; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="bk6wRSPB"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85469e25187so107384b3a.2
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 05:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788957462; x=1789562262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lVbHlHnf4CwWKZF41ARDlFSQjSg4eEO9OdDQSzP1YhU=;
        b=bk6wRSPBMtx6Jo1Qm6kkuv9oSKbxX9A4Siz2pZnLbU+5AD01yi86DncZVKmeWooNJq
         h7muHQD8ccwflhAxDqmdRvVcdiTGT997sQWf1nc0yzwFNwj+W8VNki+uhFbwAMYmwQfu
         g+kXFVamRKEq82nc2/JmySfFHgU4ItBKEKP/I9iO4T5ysMHG4fdR5b4WKq5iE/G+IvhA
         pFSO4AX8CDrLkXIS0uzXZgRdsmrlmT6DBUZK1mXvDmqJBP/GAq/qGDEQjZZSS5eshW86
         T8XrUG5f8skQNzP9AIgnx5Sm+eVhh6pBzcy98t0mlgWvD1UF3ZyZ/S/p41iVWKnltxpc
         xYfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788957462; x=1789562262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lVbHlHnf4CwWKZF41ARDlFSQjSg4eEO9OdDQSzP1YhU=;
        b=n5X8xHcbOzgJY2F4BmQYbwF7D4GJm81aRpfy8euyCbqYHhOlj6AM+NCiH+X5UzRwPF
         jkrCEX67SteO/w1Z8hUpKGYb5F831pyn/vpgpJ1bHZA2XTTtw3lJD8Oq6nEjw2TYzT2H
         ZFN05PnU7klprcwzGrJ2B05Z1A1Jxyr/4xf8Xflmt/Br4tnKPaIKyn5vpaPBXd67WZoO
         onkdsGExrL1jojRUz7La9C9t5A08mracE7cU+39C/6KcCEgCt1nIwTfhWrWB5JrZyl85
         D2xZ0FKgiSlbAdBGfANIz4spgSzHyGMnGCUiDrBB96iGLdA9MZ1rvl/Rc6dYEpxe/9y8
         uChQ==
X-Forwarded-Encrypted: i=1; AKwUvBxAYcV9ssHixVYOBWMLvMzXxz6o+FOACj0xV6qq563XccdVeX7EPiYreWOIt3wg/fz8Omzlugk=@vger.kernel.org
X-Gm-Message-State: AFuF++khzuNLcm6ORpZCdflf8qowI6/v5r1IMkh62j5DrrBI8g2jOLbY
	hkV/BXfDpcG6ZtlG9toxCaCSq4BYfyLhj2Dovw+86L6z2vWNDGb62EO0L1Uw+rI25RcE
X-Gm-Gg: AYBFou0/DU2Ygh/3jpTSY3kMnN9WNb6IZAT1KPSW8YfPkUTFu3KDXLb55uSGAzOCsWM
	lEudXz/k/MdQQtHvmmi7b/mH521o7Yx1N5kGMhzPbi6Gj+QsjIB/HjqyFoNvmGe5ZpJSWAALfGF
	7h0uX6qau55eknIhvs6usiUp8FPUwf/yrG0R082tSFD2QHPdA+nQ/Yt0A3uv4q1DQbosbNXob5/
	vUaoYV9SMo/FrUNcR/RfLXKxViGCZ8p0y3mxtMTB9ZbT6YHKcP259OLn8S3wpkTGCpEpqM8BSfp
	+R3WMsQinYRhYe5cKAjK2+c847CpFuSEySxg3qM8bK8HEcyhJEvCvdv/AgkAOo8HW97nhI1zrrc
	O4w0R1bxXWR1Wn66PJPie1hB+oE7eqejnzOJR5F/4VSD0HULZhU9msPIoCG2hnKOLWtwYBMadLA
	MYsSYV7GyFAtvRYl9BmmSjf4WYCZFr+viX2DhSEPlFbDwdX+wABhVc/A4GsxVUvFapNv7lXDzIR
	xOPXm9NUK/yz69fmRx+W0SaWEKtJg==
X-Received: by 2002:a05:6a00:985:b0:857:7384:b5fc with SMTP id d2e1a72fcca58-86948d28ecamr1113151b3a.24.1788957462456;
        Wed, 09 Sep 2026 05:37:42 -0700 (PDT)
Received: from b6ad5085b32f.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86153027951sm6828614b3a.40.2026.09.09.05.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 05:37:41 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org
Cc: Zihan Xi <zihanx@nebusec.ai>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mariano Baragiola <mbaragiola@linux.com>,
	James Guan <guan_yufei@163.com>,
	Kees Cook <kees@kernel.org>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Alexander Popov <alex.popov@linux.com>,
	Breno Leitao <leitao@debian.org>,
	Alistair Strachan <astrachan@google.com>,
	Tristan Muntsinger <muntsinger@google.com>,
	Cody Schuffelen <schuffelen@google.com>,
	Greg Hartman <ghartman@google.com>,
	stable@vger.kernel.org,
	Vega <vega@nebusec.ai>,
	Luxing Yin <root@tr0jan.top>
Subject: [PATCH v2 1/1] wifi: virt_wifi: don't transfer operstate before register
Date: Wed,  9 Sep 2026 12:37:18 +0000
Message-ID: <f5a832fb0ab228ce6e2b5a91fba4ca8b79198a2f.1788948455.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1788948455.git.zihanx@nebusec.ai>
References: <cover.1788948455.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virt_wifi_newlink() calls netif_stacked_transfer_operstate() before
register_netdevice(). If the lower device is dormant, that queues the
new netdev on lweventlist while it is still uninitialized. If
registration fails after that, for example because of an invalid name
such as "bad/name", free_netdev() immediately frees the object. A
later linkwatch_fire_event() then use-after-frees the list entry.

Move the transfer to after netdev_upper_dev_link(), as macvlan and
ipvlan already do.

Fixes: c7cdba31ed8b ("mac80211-next: rtnetlink wifi simulation device")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Co-developed-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
changes in v2:
  - Fix virt_wifi_newlink() instead of dropping events in
    linkwatch_fire_event().
  - Fixes: c7cdba31ed8b, the commit that added virt_wifi.
  - v1 Link:
    https://lore.kernel.org/all/cover.1788500348.git.zihanx@nebusec.ai/

 drivers/net/wireless/virtual/virt_wifi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/virtual/virt_wifi.c b/drivers/net/wireless/virtual/virt_wifi.c
index b69a4650fba85..48afc2432f93a 100644
--- a/drivers/net/wireless/virtual/virt_wifi.c
+++ b/drivers/net/wireless/virtual/virt_wifi.c
@@ -558,7 +558,6 @@ static int virt_wifi_newlink(struct net_device *dev,
 	}
 
 	eth_hw_addr_inherit(dev, priv->lowerdev);
-	netif_stacked_transfer_operstate(priv->lowerdev, dev);
 
 	dev->ieee80211_ptr = kzalloc_obj(*dev->ieee80211_ptr);
 
@@ -584,6 +583,8 @@ static int virt_wifi_newlink(struct net_device *dev,
 		goto unregister_netdev;
 	}
 
+	netif_stacked_transfer_operstate(priv->lowerdev, dev);
+
 	dev->priv_destructor = virt_wifi_net_device_destructor;
 	priv->being_deleted = false;
 	priv->is_connected = false;
-- 
2.43.0

