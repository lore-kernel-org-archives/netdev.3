Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793096326;
	b=SoJOI0k1Xd9uhBnH8fBjzlmADCmqrh4GPID6Z8udmSXYWFL1WbETjys61+BLFPf9Qc9Q
	 7eeXs0+AqErRZHIa5Ku92p3IeNNTdoBowCyHIsATMLDVe9DMJzMAtLMNvwmzVzxhoLhqy
	 sdHCwyINjQWBUm9iDJybrwndVJdHFqFJTPzy/GBSy7qyw+1qFJuQmdiwTfufw4qnLifzv
	 aw3jypRSdceGPeVqrglE8h0H3vlmfwGmy3Ni4YNDoXOELvQVABMMSGiWSXMpkAHq9vQ5f
	 D3DBeQajfzpktCZYS6Rkj20Pk0U2cSyC4LrbaY6T1EtvHZ7nadDkIjSBvJ9pxzucEkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793096326;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=GeuP82OoQJyfsoRLW0M/dQ6bKN3b3en2bYN7HzilbDU=;
	b=YTW/Bs1qdElpm3Mn3o7yj8+gYtT5VQrOicpZDKCWo4HvsQuN3e45mGwVBEhdWWzQBX/i
	 ON9kIJ7GZ9g4b5zkhjR0k2iefMmFCllmg89HI+zAwXlbzm0O/UljZW9MUaK0VQRZM420z
	 YsgexKmuIptNWKVZO/3KRg/cUgwgQklKxwIJnOZwe3YZBC7YSV3HVVOwayrurthWV55vH
	 5OIvhhekc75T4jUj+2v3E7O7ACZ5ioQ0q4ijSEmNho3sowHo/Mny30LQnDBx9I4bBPgff
	 r46ZpFb3dOawR7+s5pnpAooGDFk3pxlWbD9oZk9rGiZk62ABFUC5lotgt0E7v2rapBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JjzMpGlA;
	arc=none smtp.remote-ip=209.85.215.178
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBB9606A31B
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 10:18:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9EBB9606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JjzMpGlA
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cdab6ae1ee9so806558a12.1
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 03:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793096325; x=1793701125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GeuP82OoQJyfsoRLW0M/dQ6bKN3b3en2bYN7HzilbDU=;
        b=JjzMpGlAa1hgP31nL7dDFwOPMqpKi/hyCzrQ0rpnwVoNZlh730eyfE33VlCHYveuOw
         b2thGTjxfy7M4GarN/6C6/ctudRzC5S8YXOPgGTioYRCeqSc9SuViXDoKrQokgAZztgW
         s14/dbiQGDkXpJGengr01vHywNlZQ7M/b2oWu0DpPpVtmzMllN7KenRiX0RSPZL1lBuk
         DHugQEc2uYAFCalmevAoq+1/a/CSsyDaTBH+8qfg0r9HR5aLsxKcWcKETT8M/CS4MTI2
         TWxAL/FOiV6vGcAvWE5PFtU2qY73mrRebc+ZrLLLbeuIyxtqnja2lGBn2RtCmRQr3P+t
         akEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793096325; x=1793701125;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GeuP82OoQJyfsoRLW0M/dQ6bKN3b3en2bYN7HzilbDU=;
        b=pp08rjQAWjpjH5tA3uSSNIRiD+p+Ovit0cEu0Sz86OOkUBEN7OwZEWcNyA1ysFoo+5
         TAQhVLWWwdZTsu8xQ7/745RJKWh/OgSKuH1dLeXIddH51uMTUwcrcVBr68d2/v9t4hhj
         WeDW6w2unsV9w8DaVfuJaJvUB2Lc/QkcSnxtv9ypAw8YDHaANg/pHhafhfBtiCv0oX9w
         uqRxNcmWAAS4kvo3vflnpVxUtv/GztEcyTW92VvCDSfP8txRKjiPnUBZ2CGxrtK9zHPd
         7C9ToTNFfeKnp+m4YdscsoWR1OeKGFa0+rDYnGD3uG0espO7saD9ut3ezNmzHmsBA0iD
         JXAA==
X-Gm-Message-State: AFq9FYJTf676+qdGdTEZBF/yfTj35OU1nxltDulKNk9bZ+RGa+vNKhJs
	EzKNOO7PGdMM7rjr1/uRsewsHNpFCxsjoizsE0ghlXpj6Wllk9zQxhCU
X-Gm-Gg: AYBFou361cA7h3SMAundQhv10VvkyAeVSq48Ux5PURul1O/kg+162PxryNQzNnWr0Ta
	u+HDaK50uwomJS+WmrB9VtbPxjKZSnhgV1trNkas/3TP+s9HmYXVturbb9On8yjk/5c9pcifELH
	MACCr/NEXplk9hF4E5JNKCYxPD0q7Q/OrXUxtj6/C8sj3H/TGGyQ2+ntHgb1OAlREcsXESOA34+
	fHPWOCA7ovfBYuow9JLlwzlCm+Nppcc/USCK2Iwyj8YwbzaLWnMGuZHW/4lNWvfBFQU4mwH14h9
	t5TEN0YqnMVBx1Eg7l3EvGMqqqW85gdQvXetymiYjeipk6Im8maIUhIQdF6h9I/4MfbsWKRStuE
	4sVvCdnB46BE/wcSRa2cFHWhovwAbs2gmiCvOPtaONYCUsbbF5fTSYQKbknYzhBCEO7ZTGa2Z5D
	yF2+yFWvJurAu0uVUIgfltJCowIz3b6s1y91L4ESKb4voQeYTiF3FLXkhLekkIIV11ULVbNafuK
	ttXVCtdAazcVHGBC1MW4freZc6ua0WSJFyX4ca6QR7xfhx8hd5qYuQoYLWicDj947QfXfkfyvVQ
X-Received: by 2002:a17:90b:528a:b0:3ac:a11a:7c79 with SMTP id 98e67ed59e1d1-3adeae6db13mr6980934a91.16.1793096324799;
        Tue, 27 Oct 2026 03:18:44 -0700 (PDT)
Received: from ws ([103.197.28.179])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae40635a87sm3097896a91.7.2026.10.27.03.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 03:18:44 -0700 (PDT)
From: Xiao Liang <shaw.leon@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowangio@gmail.com>
Cc: netdev@vger.kernel.org
Subject: [PATCH net] tun: drop batched packets while the device is down
Date: Tue, 27 Oct 2026 18:18:27 +0800
Message-ID: <20261027101830.85327-1-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tun_sendmsg() handles TUN_MSG_PTR batches from vhost-net by calling
tun_xdp_one() instead of tun_get_user(). But this path does not check
IFF_UP, allowing packets from a guest to be injected into the host
receive path while the device is administratively down.

Check IFF_UP in tun_xdp_one() before running XDP or building an skb.
Drop the packet when the device is down, matching tun_get_user().

Fixes: 043d222f93ab ("tuntap: accept an array of XDP buffs through sendmsg()")
Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
---
 drivers/net/tun.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 439565a264ee..2cb0de36e186 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -2551,6 +2551,12 @@ static int tun_xdp_one(struct tun_struct *tun,
 		return -EINVAL;
 	}
 
+	if (unlikely(!(READ_ONCE(tun->dev->flags) & IFF_UP))) {
+		put_page(virt_to_head_page(xdp->data));
+		dev_core_stats_rx_dropped_inc(tun->dev);
+		return -EIO;
+	}
+
 	xdp_prog = rcu_dereference(tun->xdp_prog);
 	if (xdp_prog) {
 		if (gso->gso_type) {
-- 
2.56.0

