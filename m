Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794408281;
	b=jRnSdv//Smf855GKWaC68jrj7bVYH3yM517PNFOvnA90YrNl76qz2xo+lOw9iP8voXM3
	 5Gl7wit5zkxpKTU2Cke0Av9IggA3ZZ1Dah7g9juYOoT8KcjtX/U/z0uC6zNf1XU+bHb0l
	 QoiNOcq0MYXcd5fsG7CQ6GlsldG8cZh3mOxpVK5CvZNUzuuutVVr0mYJSjzgYqzfJxosl
	 ng0UwvxfTBhrItSdzNC8Nw8+vGFA7Ar33oKGkxC1SfJ6rSPZxKaGjhkRgp+TSEFv6PxQT
	 oLu9ejhGBRujAEKYo1eYvIfFd2orKR37eksWRfZf31qUGcEu22B9WXLxGq4cK1F3B6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794408281;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=LPsq33bOSJgVO/RNV124EKVcCGGrlMvdhjL7wfKrHy8=;
	b=kTYMoEQKqYXU361vK+QRMKxlaWejLBc5Pbu0hP3rFVh/1T+kUtW5MsinTvZrpEOagxCi
	 Njj8niN+Qk8Y9Wzn3+b6jzSQrKqjBYlbA1340FATZNArlWCCJ0O8KD4qM2oN1Zn95svlf
	 aFM21qaHbNTEkPDHYrseKGiYybx5s0Jd1BnyuuMbhHrbolqk4+G19CqFsEmqS8gDhoza8
	 fFYUv3bxcl8hKXqpYCuRap+xvYPmu9mBGEAgAYj8QGCvcyJT0/7FVwVTxlqCTPZHh8HEu
	 GqVFrSqGklvRbfSxuwJMa62z1zsfEmcxzOFDufA8oFW5zbEEsaFJmfNU/33DZCAPygA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k+Swmzkm;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901D760A3814
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 14:44:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 901D760A3814
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k+Swmzkm
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a5087a5348so28432275e9.0
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 06:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794408280; x=1795013080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LPsq33bOSJgVO/RNV124EKVcCGGrlMvdhjL7wfKrHy8=;
        b=k+SwmzkmeruMyqeW5z6x/dsExshBytMDpxcO1OU4qU2kAfFNVuzAQtHDrHYdDz8Hvm
         OUTVWbCxynl3CtGFNMp8o95ip7H7qCrf4O6LhRcD83LHbP/PYgnVvUZaJmlWhGa5x4ye
         n61r0y9ZWtacYE/iYoFN16Awu2pzCeBbK6DKAMF0mtTVLikRG4NeubyuQlF5y78PQYbA
         HvE6ncIX0yo6Ivf0fAlIYHFj80507YdfWQS6mwo4eka9u/uBZjTqhRu3dyNjpovlWdeH
         LGurjKJgjfzKrmdes3ZpL4QHaBLzB4aG5TSa3q/Ry1xfjk3b0BtgqZPPlQoCFDt/oENg
         APVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794408280; x=1795013080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LPsq33bOSJgVO/RNV124EKVcCGGrlMvdhjL7wfKrHy8=;
        b=Hf+r6FUf7XMz7Q1wat1+VfRbxceYHk2uZTU7Og+fkJ0jSVoW7IC/wKisLo9lVpCUpN
         QlTGGIREw3oMbMRZSJJXXHgDx1OChNe90hzdIsg3RU4QS4/Ujxgp443CtcLrntikNvcx
         Fs+c7xjdngpZ6rG9TT8nSAHNL8mX76YfkQVVIwQ7I1dy77B6whsxWukv1/jtufE1vAuG
         OmlkDmP7tzz5xrmApBfHMPB/iyjfItNOfDnUz57Hw3TLiUOyxSshT9yiXdKE9l3aOGHQ
         FVeGL844K1xElvv1Y8z7jxBqRY/A88T4aCl8yswL0B4vaGO/ZmQ6ZONJZCfCECkYf+IF
         0J8g==
X-Forwarded-Encrypted: i=1; AL+hErHJBAhmvuqYWHi5Yxlfv83GnMsNKcRuCXZK+kqoEYrjcg0iM8F5Qu9H3dLvzenDYmz9+LhQzhw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9RcxrqsA+fixWvMw6dWSBxu+P6iAfIDXxBlAnbOtW1cx4LF+PQ
	ePx8kG9L3UfGKPFDMtewojX2fr3ne6VZDZOgw4uvWIf0LPA9z4MIjlDU
X-Gm-Gg: AYBFou124QTInL9BabJIPQvrS9k2iVtKyZBH9bEIgUcRye0SEmgycAtiuK0bkBb+Jf1
	6P5DgsFfBB0WMVheRruMzC2d4AqwaaGeMFx9RiB0B4ZuCJMruBXThYBSmt5XU10rotNA0mbGmLt
	gfIwA39UYeSyTdhHlTk4RZdgTeSo5EkeJkosuHyIfuF83ID8+/096BAdPmJDMGAYEBNPHr5mAY6
	PBhqURWqT3mNqBtgIfW6vH2StiOq8CIBtkwa7drtt1uRtnrbP71p34wdSgW/bRhiIyuThJbVUuJ
	ixw7k15UN00F1OzpiL+WYmhDsBbj2li8g0LfhG7C1A9hMilww1K6DZN4cUkBo01nNGUdnUIzptM
	GAXgoyyDGK4dhBdVSOLdte1BSdEUO5S1u193vKedoKfrJMskSOadmf7euRFupLgUURuLH4SucMj
	wp9k2K6qmiS6jN6fggBy51y4BAMT8sCZQPk+z2qev9EbKJLxy2LasZlphzwBGVQtkzaPGW8vlFm
	aiEBlfUVVvSlr7Z8aB8M+iK888ZZuFLubaId4L/It+ctk8GlevAtxPb5vewLlnOTCtq3n/1uaLG
	R0UumbDrwyo4E9qh08GPtu2XMm7kCiI8fd8FFMgx8TC9ViUZ2vq3vzNM
X-Received: by 2002:a05:600c:c83:b0:4a2:150f:1605 with SMTP id 5b1f17b1804b1-4ba0936f386mr49865155e9.24.1794408279927;
        Wed, 11 Nov 2026 06:44:39 -0800 (PST)
Received: from dev.Default ([86.127.229.203])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba08de826asm46656495e9.0.2026.11.11.06.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 06:44:39 -0800 (PST)
From: Agustin Santiago Isasmendi <isasmendi.agus@gmail.com>
To: Navid Ghahremani <ghahramani.navid@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Junyang Han <han.junyang@zte.com.cn>,
	=?UTF-8?q?Stefan=20D=C3=B6singer?= <stefandoesinger@gmail.com>,
	Felix Fietkau <nbd@nbd.name>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next 5/5] net: ethernet: zte: zx279128s: debugfs knobs for the WLAN ring
Date: Wed, 11 Nov 2026 15:44:26 +0100
Message-Id: <20261111144426.1321237-6-isasmendi.agus@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20261111144426.1321237-1-isasmendi.agus@gmail.com>
References: <20261111144426.1321237-1-isasmendi.agus@gmail.com>
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

wlan_state (counters and port table), wlan_inject_all (inject every
frame of the bound interfaces, as the vendor firmware does, to exercise
the ring and the trap path without flows) and wlan_bind (bind an
interface by name).  Testing aids, kept apart so they can be dropped.

Assisted-by: LLM
Signed-off-by: Agustin Santiago Isasmendi <isasmendi.agus@gmail.com>
---
 drivers/net/ethernet/zte/zx279128s-wlan.c | 34 +++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/net/ethernet/zte/zx279128s-wlan.c b/drivers/net/ethernet/zte/zx279128s-wlan.c
index 6c6f6a36d34f..29970db47a41 100644
--- a/drivers/net/ethernet/zte/zx279128s-wlan.c
+++ b/drivers/net/ethernet/zte/zx279128s-wlan.c
@@ -18,6 +18,7 @@
 #include <linux/platform_device.h>
 #include <linux/seq_file.h>
 #include <linux/tcp.h>
+#include <linux/uaccess.h>
 #include <linux/udp.h>
 #include <net/arp.h>
 #include <net/cfg80211.h>
@@ -751,6 +752,38 @@ static int zx_wlan_state_show(struct seq_file *s, void *data)
 	return 0;
 }
 
+/* Bind an interface by name without waiting for a flow (testing) */
+static ssize_t zx_wlan_bind_write(struct file *file, const char __user *ubuf,
+				  size_t count, loff_t *ppos)
+{
+	struct zx_eth_adapter *adapter = file->private_data;
+	char name[IFNAMSIZ + 1];
+	struct net_device *vif;
+	int ret;
+
+	if (count == 0 || count > IFNAMSIZ)
+		return -EINVAL;
+	if (copy_from_user(name, ubuf, count))
+		return -EFAULT;
+	name[count] = 0;
+	strim(name);
+	vif = dev_get_by_name(dev_net(adapter->wlan->napi.dev), name);
+	if (!vif)
+		return -ENODEV;
+	mutex_lock(&adapter->ppe_lock);
+	ret = zx_wlan_is_ap(vif) ? zx_wlan_port_get(adapter->wlan, vif) : -EINVAL;
+	mutex_unlock(&adapter->ppe_lock);
+	dev_put(vif);
+	return ret < 0 ? ret : count;
+}
+
+static const struct file_operations zx_wlan_bind_fops = {
+	.owner	= THIS_MODULE,
+	.open	= simple_open,
+	.write	= zx_wlan_bind_write,
+	.llseek	= noop_llseek,
+};
+
 void zx_wlan_debugfs_init(struct zx_eth_adapter *adapter, struct dentry *dir)
 {
 	if (!adapter->wlan)
@@ -759,6 +792,7 @@ void zx_wlan_debugfs_init(struct zx_eth_adapter *adapter, struct dentry *dir)
 				    zx_wlan_state_show);
 	debugfs_create_bool("wlan_inject_all", 0600, dir,
 			    &adapter->wlan->inject_all);
+	debugfs_create_file("wlan_bind", 0200, dir, adapter, &zx_wlan_bind_fops);
 }
 
 /* ---- init / fini --------------------------------------------------- */
-- 
2.30.2

