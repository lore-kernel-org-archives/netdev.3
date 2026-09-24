Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7704646AA9E
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 17:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790271661; cv=none; b=EfMHVgjUtiUXH7h2EGMS+3M2F+TSYRexfr868sbGj9POx6hJwaGil0373yPh89AQxorpB9G9B11XVa1uerrMShZYe8LMnXt5gcBTezYku176oS1mYACxxUccRYspn7hw89SBBfBqi0BYtvQyWiEPjWL+TqgUKY+hOO9B61M6sBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790271661; c=relaxed/simple;
	bh=yemf7qBVHtplzwIJK6k/1ljMzfRpZRUYczEE/HsMmmo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Eg0ZlxBD3E/yMTfp+vdhwQlhOXOMMNVDYiczX/Jp+IfkgpzrhrEDSq0eOP6C6pZ1AXD2cUd5qxh8iV5KXXx6SLXB+DhR7nuf7JTxYTi2pmnisiHvAnGBEycImso6ton9x7CbunKXzjR4ECekrcFiXVbvgPJbzYee53kDOQGeoKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=GAT2GxIn; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="GAT2GxIn"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccd66bb4so97268a91.1
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 10:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1790271659; x=1790876459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jcavR+kumVH2a25pyfmlJjp3ykD/tBOqZkHbAf7QxFs=;
        b=GAT2GxInqTQb4g1bJ+aVebjC/sgr/c6K3+LbPitNSpV8LZI/883vbFNLwdFRxu+ZBj
         nMcC/8XR3BtP6Q10JSAdyCSC6KfV/y4H+5bCiB1R0LwTY8tfEAvqadWhOmqzZUmmDI07
         pZfBa1XJJ2Pj1f7OxSFIjGaCsrVFGiSrXcw++1TFvQxy1f2bG7oHDJrWqaNZYHM22J/d
         KzLZO6U64JJPaZaB/sncvJQ8ltSeuzl6BhkBwB7QyZuEvI4XFTDClrpYCVuSj0YOvM3U
         FyZKYng7Vko1eTP3Ho70sGLxM1Vu074dJ57bQzWhOMp/q8RQSu2C/f7XgTEiuFpjdVWg
         QRnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790271659; x=1790876459;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jcavR+kumVH2a25pyfmlJjp3ykD/tBOqZkHbAf7QxFs=;
        b=zfqYCaMGV/sYdpPs71wGib/qXhyQtTW6USbU/EVgWo/q0l/QlSX3YUStrUopjtQ5wC
         ZtE1L0jveW9QUxSoeZymtyOX3Qhrmoiag9eJlertFfTUmGAb+1dyXQHo3dkvOUlkczLW
         CytJ+ssgb+uE/ZJgGzM9A00ZB5p1aw4qYa1BW6WPHWmWmDjA3Qc1B65mYMY0gwgDHvSp
         OuEP4oEZt37H18MFOc6DY8TKudQCkOKtoncjxNE2htOFZeP68oGFjSbKY7Vp+wr6fhtB
         wkwIy/IYJKFp1v7ut2y/QLJMxZmH/1LzM6hslPf5RhANc1lrON2IEP/ofDR5OUuwmqeb
         nU3w==
X-Forwarded-Encrypted: i=1; AKwUvBwbZmRYNUN4hluihdJxQcWsxkn6eOGYPmSXHG4FzS9cpmjl0IAINWEkHyBi/JUlOtbhJNFXRSQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lS4fsREId3ZxUaN4Pm2Mvn6fxtrue6Jt8y1/1iAqXbvzbUm5+N
	w0XkvcgrlGK6enuxKnURLWIPnqYphhsdOc/AXeg5OlNlzmcCScp+xbS/S5M/k3uvvzs=
X-Gm-Gg: AYBFou2ov0E9ntqB9ZsqmrYEkk0v3sFUP/omywMACvNhhY/d/qtG1U2SXJ+r9gzH2RM
	covoFkgWOHsV2euwpFO3TMcBk0urejM1VwXKgNzEEAJqaiMyGp53pXKAh657FWaXIuXjSLIDt1l
	/4HHnj85LpXtkQ6ngomblRW7V7gOpi7oNlyw1qZqPertHwmFlM4RGbgMTXN68Hk6MKQIjoNIYHF
	xYoyBLqORUVb65bbTi8psitIOhS4dqQeyaq7d4PYLau+U617yNwxkOLwhHX/2YdmoPiJ9Wr0R2b
	o4os7BpzQlqmMyeyIhO5EiBvdJr5Ix0VMJ3J7GHRvs6MFs99+e3ffpEk0O0slKZqpdAHKYGY5u0
	B906Mff+NZJuB7jlMS3cw9XUceq5T3CfEJlrjaCrr0aM0Js4fvPM9S3xut3iUFiuAVjrJX9BBvk
	1IvsjiLY2ppEZdwlESFg2Z7dmKX6Qst6/PAlX2WlI++Q4uxxhhIZCf3A2SdNnIy3Gdfb2jdImt+
	EohvpRdFM74fMYSQeAOgD3gKEf17hVlwrv3smBnXLQXJDau1DQW6e8lgfRA0gdtqhA/9x4=
X-Received: by 2002:a17:90b:3c0e:b0:39b:92bb:9eef with SMTP id 98e67ed59e1d1-3a098ce1c3emr3210269a91.22.1790271658828;
        Thu, 24 Sep 2026 10:40:58 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:f875:3165:4649:e818])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df9144e6e4sm120375ad.64.2026.09.24.10.40.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 24 Sep 2026 10:40:58 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Yan-Hsuan Chuang <tony0620emma@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Ping-Ke Shih <pkshih@realtek.com>
Subject: [PATCH 6.1.y] wifi: rtw88: delete timer and free skb queue when unloading
Date: Thu, 24 Sep 2026 13:40:53 -0400
Message-ID: <20260924174054.88252-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dmitry Antipov <dmantipov@yandex.ru>

[ Upstream commit 634fcbcaa4062db39aeb5ac6ed1bc1feb8dd5216 ]

Fix possible crash and memory leak on driver unload by deleting
TX purge timer and freeing C2H queue in 'rtw_core_deinit()',
shrink critical section in the latter by freeing COEX queue
out of TX report lock scope.

Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/r/20230628072327.167196-1-dmantipov@yandex.ru

[ Backport to 6.1.y: the source change is unchanged; only hunk locations
  in rtw_core_deinit() differ. The target-only Fixes trailer names the
  initial rtw88 driver commit, which introduced this lifetime. ]
Fixes: e3037485c68e ("rtw88: new Realtek 802.11ac driver")
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Hi Greg, Sasha, and rtw88 maintainers,

I am continuing with CVE backports still missing from 6.1.y.
This fix is inherited by v6.6 and every later mainline release, but 6.1.y
still has the affected code. The target-specific adjustment is described
in the bracketed note above.

Could you please queue it for 6.1.y?

Thanks,
Artem Dinaburg

CVE: CVE-2023-53574

Build: This patch was included in the x86_64 allmodconfig and
CONFIG_WERROR=y build.
It produced vmlinux and modules with no new warnings or errors.

AI assistance: An LLM helped find, adapt, and validate this
backport; I reviewed the patch and test output.

 drivers/net/wireless/realtek/rtw88/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 8f486152fbd9fe..53c61758d57a0e 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -2135,10 +2135,12 @@ void rtw_core_deinit(struct rtw_dev *rtwdev)
 		release_firmware(wow_fw->firmware);
 
 	destroy_workqueue(rtwdev->tx_wq);
+	timer_delete_sync(&rtwdev->tx_report.purge_timer);
 	spin_lock_irqsave(&rtwdev->tx_report.q_lock, flags);
 	ieee80211_purge_tx_queue(rtwdev->hw, &rtwdev->tx_report.queue);
-	skb_queue_purge(&rtwdev->coex.queue);
 	spin_unlock_irqrestore(&rtwdev->tx_report.q_lock, flags);
+	skb_queue_purge(&rtwdev->coex.queue);
+	skb_queue_purge(&rtwdev->c2h_queue);
 
 	list_for_each_entry_safe(rsvd_pkt, tmp, &rtwdev->rsvd_page_list,
 				 build_list) {
-- 
2.39.5
