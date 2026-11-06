Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793976262;
	b=TSCQUwz/HFYs7tCX5DbDQ7G3j/HSH5gSHATlBU2sP/lNuc1cfWelZqUTvQtTzHiKUZRc
	 kJaH++nXCezHiYsSjWfGHgzPinFSpdBJqUqk7NaREMDcD61x+NBOgHgts3Eg/wrkb1nho
	 wXbp5p3lFNWMeY16iD3EyrdgKmoc3WJ1d+scfcjkY8U1Epm3FSRe80Hrcvj7mIPKyoN1s
	 FW+49xZozg3Fuxss+PIaqJSv0vhWN98gi3QZAvaH1WEdUTpbHoCbLQbHwfWWgv6CAbymA
	 8CEsg+YC0M7ISmJUDb2ZfwaZ2HXWaB8J9t4LTFcoXCj0RP+Zbw90Jqujadpl+ZeK5Mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793976262;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=F3QFcS6EAmV3kFTO+kCVCbRgqueOJsNvpmRJjVyrvCA=;
	b=eHsprucWlyeIWYlgBiqwqEb7FJNS5+1k7UTIPdSjs3lyJGj08yQn8Vs0UORugmuDxYlZ
	 5WdFCf9F5PvWgsdnlK/RwDjkx/VQaquGMFbPQ+yECCnhKxvkiAWETtvB9qvynWGQxPIVB
	 9W3l5nWgOmub0bSdrVVCEjD6pdmfz9J97aztsJPCTthnMtSnrnPmbvGccU+HkKIeelBoT
	 UEHfd9MjvrhEr59UbZG7ZJftAaorlEwrIXEggVvyeDvBDf4TW4X+8xRvnPmJm9ZyVUX6O
	 c0IeReFcKooE5gOFegFAkk2TqFz0IeLe1xv951g3BKIdIH985pFp5JYK7g4JOpJGQxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xvLyKzYQ;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF6A606A337
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 14:44:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2DF6A606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xvLyKzYQ
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3ace1f3897cso362583a91.0
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 06:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793976261; x=1794581061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=F3QFcS6EAmV3kFTO+kCVCbRgqueOJsNvpmRJjVyrvCA=;
        b=xvLyKzYQ4auVmJsYnFJ+bsVWvuOhy5aGyJv4IC1wszP7cVinXXAALXXL5jSzjeUecF
         wU9e53UrybKy+HUk4fZcPkVyt1AezCpA7acg9RPM3xuJ466+bdQH8prF5V6UWzs67gan
         1zuaHv0sqI/9MqRpmPr3PlogxFkslJ5EBfvJasETJAei6+Vjxc22vLh/XMAi/kwEkX4w
         96TzS0Em0sIRhnBeqHhDTn4T1GlmdtF9xMaEOWZvxBHtFx/pflu6pperAAUNTCRUB8Dl
         +kuUE30VF25t1eM+ir86zigWjbIAGFPCL5F690bFc5YaRTGEeQtfNHJsmMpQdWlcrqXz
         4rpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793976261; x=1794581061;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F3QFcS6EAmV3kFTO+kCVCbRgqueOJsNvpmRJjVyrvCA=;
        b=GQD6Er4xc4UTVSQrFRFndDtIigXTR+abfXgTaiGjfLbMi/BP3rWF+8/4dORkg0VQk3
         KG1IBIxDhby3o8cb+xwT7XlvslXWL2dF3+dt5BLo6Nex9pdaeQ1yY5dMQOZOSnIQqSR4
         qJHEHWKpnjXZELwsLKyZw5LVhAH3uAvcH5LTwGhdEDzgyzS8uvFi+A09mPpDouBu4WSq
         Bd8UYPJb81k6uQuA7abnuNxvFL/tVfSB6XBGwnzlilJFCSow67wkYILo2wIhki5WI7D3
         fX+CW1yiwGdP7HOQX76vuhv7TS0YEw4XE3+dVRawcIOSB0RiVEuH9jOzOiNqEIpQpk3v
         6TAg==
X-Gm-Message-State: APuU4Z+x/zkwxso2gwBte1kOc1g5xpPDduKNUMSqohx4sLBVtV7oJgZ0
	/E4H616WZVs/zZICc6yJ8gVxQDrU/NS9FacC+r+SP4EiEq/zZ2E6tTAWlGJ1aCE8
X-Gm-Gg: AYBFou0D+fR56LVr4S0zaa1YEVLBgVuRn/M0MywTAhhdIJwr3+K8jCHMM7aBvWYhnfQ
	PriaTgejW8IawcmqenuXDvFsdjIyYSKPO4mVW5RRQm8BuZTLhBwvDpz3ZkbXQjk4d5TF9sHv61X
	7s/dX+TQhVFO0iIdgpIkeObXpo7UoCUFD2x6QsOrdgZRfUkDaNE0vQB3/+4IhhQxU/GYZejhoKh
	hyzj2LihBmqi39krDzILeXUYpJD4KiA4iZ+WQOqoya6x0LMVH0JIiroAIMvohr21W09a/T+F6/x
	3mhti09H4taNB6x2idrAm/H24Bu5PyItE7R028dWKWJwmPSiSPdFzQqZNtqvihJcZOVy5jtd7We
	1w73+i03HQrpghTZbY5hANjvw2iC/gVFVrsSL+QXq0TRkZ928GJKWrXXYlRobce/Yh4h3jfRCd1
	poOlGzM4T5KHdlOnk70BRQovft9jnsMfX+k22HS9u0Q3zlH4qktsnswYmdiCAT+2Zf08hG5vnRG
	JUqtVgqis6aVzMFNCeRSywACazpOHjOXG94uHuSBbfhHUsygUekv6pONn7tCmXaqSCS+ay12aat
	LGpT8jURBgFQyzriKcp+ty3zFPfRG1gPNZge1LZOXHIDT6yvNw8osR8zP1VteD/CNzvZmettQm7
	mQ/M=
X-Received: by 2002:a17:90b:4b89:b0:3a7:82ef:bcdd with SMTP id 98e67ed59e1d1-3b0db6fc27cmr2848553a91.41.1793976261259;
        Fri, 06 Nov 2026 06:44:21 -0800 (PST)
Received: from localhost.localdomain ([116.88.205.165])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b32812a6sm8051922a91.11.2026.11.06.06.44.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 06 Nov 2026 06:44:19 -0800 (PST)
From: CMGS <ilskdw@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	CMGS <ilskdw@gmail.com>
Subject: [PATCH net] vxlan: reset the remote's dst cache when snooping moves a MAC
Date: Fri,  6 Nov 2026 22:44:06 +0800
Message-ID: <20261106144406.66035-1-ilskdw@gmail.com>
X-Mailer: git-send-email 2.54.0
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

vxlan_snoop() handles a known MAC that now arrives from another remote
by rewriting the remote's IP address in place. It leaves the remote's
dst_cache alone, so the next packet to that MAC is routed with the dst
cached for the previous remote. When the two remotes have different
next hops, the packet leaves the wrong way. For example, if the
previous remote was on-link and the new one is behind a router, the
device resolves the new remote's address on the local link, the
neighbour stays incomplete, and traffic to the MAC is blackholed until
the cached route is invalidated, such as by "ip route flush cache".

vxlan_fdb_replace(), which makes the same change through netlink,
already resets the cache. Reset it when snooping too.

Reproduced with network namespaces: a learning VXLAN device has one
peer VTEP on-link and another behind a router, and an inner MAC moves
from the first peer to the second. Without this patch, pings to the MAC
fail after the move until the route cache is flushed: in 5 of 5 runs
with one CPU, and in 1 of 3 runs with two CPUs, where it depends on
whether the sending CPU holds the stale entry. With the patch, they
succeed in all 8 runs.

This was found by our AI-driven automated live migration tests. The fix
and this changelog were written with the help of an AI coding assistant.

Fixes: 0c1d70af924b ("net: use dst_cache for vxlan device")
Signed-off-by: CMGS <ilskdw@gmail.com>
---
 drivers/net/vxlan/vxlan_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index d11028b37..6ee071cd2 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1482,6 +1482,7 @@ static enum skb_drop_reason vxlan_snoop(struct net_device *dev,
 				    "%pM migrated from %pIS to %pIS\n",
 				    src_mac, &rdst->remote_ip.sa, &src_ip->sa);
 
+		dst_cache_reset(&rdst->dst_cache);
 		rdst->remote_ip = *src_ip;
 		vxlan_fdb_notify(vxlan, f, rdst, RTM_NEWNEIGH, true, NULL);
 	} else {
-- 
2.47.3

