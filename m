Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793285942;
	b=D1QkzaWfIRh8tJZ52Lt+/J5+1fjqHaD+xjYrY5uuTj+e9WPK4IfZyKREdnx7WfG549Gv
	 OtNj0xC1K8nf3XjVdaqeMNsTIwYtCsVIfusxi4MRxAW0lcPB1/Cf7fAK8WOkAJX40IDlo
	 C6FD/4HBgOKeTkvn1ECY7SbR6LN95GCp3D79BegmDpkDuIB1RXXAkR2EiRyZ9hfJmRClt
	 Ww7rj8WCB8lavHwQ7YNYC33SqnLDi/DagrSmgA0ZIg4jthQcbyu/V+94S/4ioi2f3YbeH
	 VQni/LOhaxkHWkdZsgjVAZ42BAeV6nWPBBIRJQAgq0o9JTRBQ5tWSi5CCmTjiH6Yd8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793285942;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=W1NlihvaJXejrTDGGOl3Hof38A7ldhULq/AQA3ZMnok=;
	b=qhQzpW53ZmlaQoeiAMCXgxOjWlhUuNVUdelhuUVRZhPViXJ0NX+2Jv81rDuYzq/8dYRF
	 uhhxUnNitgJayJVmNHC2SIB76Vj/GjG8Xfrm/YHIWrgG64qQqOxh6yBscdlzVz3fc4Ht7
	 9iYuvzqN6zAq9QzF/FqHEjsBJTkWQz1a0eu4IPXLR7IoZsiFNrpSAbY2Pxh3XZxT+XugH
	 XRtWG98x13c0D/EWPBg+44/+IvixkGMHAcopHF2rlDd+y8qCEUokPzdunHcjgMqmpzV7O
	 hgwacmCLPjspuUQrhcD0xe/7Tj274QVSUFrUy37xzQXXNYhz+99k63sXS0miiVOsPiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uEkVXSPm;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1B8606A321
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 14:59:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC1B8606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uEkVXSPm
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a2069b9710so21343415e9.2
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 07:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793285940; x=1793890740; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W1NlihvaJXejrTDGGOl3Hof38A7ldhULq/AQA3ZMnok=;
        b=uEkVXSPmhnvCFI1L4+2+0k0KbwiX2lUGRnEl5UdcX5B5WerVThw0gKpk+7OXuT4NsS
         dagdzhqNEWgvTbQ88qQwx1SFzHT0gt/cznkFBxFJ05P78rx8TYrq019QxvsbwxyYb3fS
         R5Wo7p08Z4QA4sPa4k9vTNir8pltgp5IQJ5EaXkKWwRy2xkq/xZ76ZWJWmKrUvyUVMFh
         0hR92+Cn5TK7Ve9V7To7Swd3LDWmeMwVhKlYHwatOhuixMjkxa1rVwdc45hwH/HLqTc3
         xpHJHo/LS7XWKaeeX0zcVtSL0Y4fNEDBpUaVBuVz1tuZ8Hmtxp0Y+z60Urhdkpup+q1k
         NXNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793285940; x=1793890740;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=W1NlihvaJXejrTDGGOl3Hof38A7ldhULq/AQA3ZMnok=;
        b=0HOraAttAavNCOR/853D1vVKseXSD+THOjae8FkkJTWp2jvPMT/a2tlg48Mi5kjlFE
         CxG4zxqCKjNYbtLIKeCCnjryOGMCMgaYcvt2ovH/qbGURsjAZbt2Jxn0O7Lj4UztmII5
         GsU9cznyT8vDhuPqUY+O64WDnJwc5xFm/oHUy/SlBV7wVfLJMrxVWEyCXsLrV2jZyN/b
         z9SMqQfEsBZh4N1yk/1RVNPmTStvJdhI38TZ8TljMFMHdfFDye9llqnLszxnPkzpW0Cv
         S6c0rV2LKLkupxKYKziMv+6XKS+ynpimWNaAviwvdlKSoXdB+FNQ2swp7atu5m/08KFB
         E9cA==
X-Forwarded-Encrypted: i=1; AKwUvBxO/FjSk9R9oh6IEG9W6bGRu8qmbtB6NzXu4bJfihjKyjU3IL1Wb6BcjJ2WJE8RmoUpgW3Mnpo=@vger.kernel.org
X-Gm-Message-State: AFq9FYIe9Lof9l0BtUpCQIKsw9tWuXhGskoLWeGlkixTrJvLBTbSYVXw
	6PiL8MnUSbEyQeQ6+adBA9p1OkK49O1BreUgeJtrGP1FQlCygxG7X0Xg
X-Gm-Gg: AYBFou0bafGCOFuwOsYqzcsIaDtkj02R6nKlU+jvXpIa1nnEMEenCnVTmV5INp3Brup
	KVqA6OOf763iHaxHlcudYR+Y8937LESvv/Qokl+yA0ybDy0WeqpcjsY8TrhJATE/jR6rMPwX83q
	TinF1jKTR/jkOZDHwimy5uH3UKCmCz/nqzfPrDda/HCO0ULc9NVyW8IFeCkX9/73IfMRQmTUgpL
	/kSsgL/VxKLlPP/T1utwtdVTMcldHXg2OxV1Py6y+V3fx8kFSf8rG8fxT/XO60pkedJizmaROkq
	K46++wvLfOU2SXpyGke08Jz3OEf83GB2xa0h7Ig3WRu1HQWEMdNamMDlFM2qsTDIDv6Iiep0TN5
	0xDKcB2a9jfXjhCDePeJQCGzAknD+ZWoiDCdDKUbi1GKKNVqBjpZwfVRa/wf6PM1oP44Yam6x6j
	ul0qVIljPEbFLtC+osPDLowDCzPaiI822Yiev4wpM7TMc8A0FqRI/C5BbE3VWvvMROa0asE87UK
	+Fvy+PQxgqB5Z3/gjeKcpmtqb4CqKflt3iuIuAGVNhnJopdThvvn/epIOr7hVxOxsXctsbDwjSR
	KqeDSbFUSPTkuHQrum0i0TZ2RdU=
X-Received: by 2002:a05:600c:37c3:b0:49d:1fa8:b266 with SMTP id 5b1f17b1804b1-4a9674e63d7mr123124135e9.26.1793285939996;
        Thu, 29 Oct 2026 07:58:59 -0700 (PDT)
Received: from metepc ([46.197.185.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa8213ead6sm70941745e9.14.2026.10.29.07.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 07:58:59 -0700 (PDT)
From: =?UTF-8?q?=C3=96mer=20Mete=20Kaya?= <omermetekaya0@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abini <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	syzbot+88435e204734072bf39a@syzkaller.appspotmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?=C3=96mer=20Mete=20Kaya?= <omermetekaya0@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] netdevsim: reject port addition and clean up ports after a failed reload
Date: Thu, 29 Oct 2026 17:58:34 +0300
Message-ID: <20261029145844.231018-1-omermetekaya0@gmail.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

nsim_drv_port_add() does not check devlink_is_reload_failed(), so ports
can be added via new_port after a failed reload.  nsim_dev_reload_destroy()
returns early in that state, leaving them behind.  nsim_drv_remove() then
hits WARN_ON in bpf_offload_dev_destroy() and a subsequent use-after-free.

Block port creation with -EIO when reload has failed, and delete any
leftover ports on the early-return path as a safety net.

Fixes: 75ba029f3c07 ("netdevsim: implement proper devlink reload")
Reported-by: syzbot+88435e204734072bf39a@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=88435e204734072bf39a
Cc: stable@vger.kernel.org
Signed-off-by: Ömer Mete Kaya <omermetekaya0@gmail.com>
---
Tested with syzbot C reproducer.
 drivers/net/netdevsim/dev.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/netdevsim/dev.c b/drivers/net/netdevsim/dev.c
index feb88ccbbced..61f0824ce4d3 100644
--- a/drivers/net/netdevsim/dev.c
+++ b/drivers/net/netdevsim/dev.c
@@ -1697,8 +1697,10 @@ static void nsim_dev_reload_destroy(struct nsim_dev *nsim_dev)
 {
 	struct devlink *devlink = priv_to_devlink(nsim_dev);

-	if (devlink_is_reload_failed(devlink))
+	if (devlink_is_reload_failed(devlink)) {
+		nsim_dev_port_del_all(nsim_dev);
 		return;
+	}
 	debugfs_remove(nsim_dev->take_snapshot);

 	if (nsim_dev_get_vfs(nsim_dev)) {
@@ -1758,7 +1760,9 @@ int nsim_drv_port_add(struct nsim_bus_dev *nsim_bus_dev, enum nsim_dev_port_type
 	int err;

 	devl_lock(priv_to_devlink(nsim_dev));
-	if (__nsim_dev_port_lookup(nsim_dev, type, port_index))
+	if (devlink_is_reload_failed(priv_to_devlink(nsim_dev)))
+		err = -EIO;
+	else if (__nsim_dev_port_lookup(nsim_dev, type, port_index))
 		err = -EEXIST;
 	else
 		err = __nsim_dev_port_add(nsim_dev, type, port_index, perm_addr);
--
2.56.0

