Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46334AFE17
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 22:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791326941; cv=none; b=LKNH1mnsl4+POnQfL9xa3m5b8M8iSl5UdXTPUygMKUAMRvFUfmU3vmunTzxeK1Qy1DxXTSMItKIavSlSa2PpZS7h3WQkuCW/RwGnXB5IwNXsUpsz8rNL2BB8GWdYeY8ukmSB2aqylTQVoLk9m671rMMqdxsqnMcnvYblJnHJJEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791326941; c=relaxed/simple;
	bh=9q/Q6o+ob2o7WEZqJukHlF5j2ofuhypf6s5/8ZliFW8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YBQkYPd6tBSBZ7d1QOFXtogblRUL4TYMvoxJxS5LWGUXHhzCJMCrj/YGGckFsGFz+3vuTEQZ/FzmleZpjmf/yrNPr9WyzSOfPnIaW9857QRkTCK37Jgh/VUL72JsB7IgKXRQSoeYZfsrq0jAXp4OehFYr5DBCtvD5FaDrPby62A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=AMFGDjCD; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="AMFGDjCD"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cc4c7fab7b6so2372362a12.0
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 15:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1791326940; x=1791931740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YAIbJYCoaKPFMKMZsiSwU2c25LSNjGe+Dlh96jOlX6g=;
        b=AMFGDjCDBa75kEEQf9toq9RlFNmk+5GO7lietZHgQm1PcZW55Swy8qYSNSPBQQIHVN
         clPALjp2VHHuU7eHDxDzMp2snoLLQudcENloE1zUfRrnAws9JQo4yOpmhUZ3NN6vd5fr
         zfFuf/8jtS1UqY+OelzSAGD3U9eCfzcxeQB8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791326940; x=1791931740;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YAIbJYCoaKPFMKMZsiSwU2c25LSNjGe+Dlh96jOlX6g=;
        b=Zu7HSFDwyMZ7HZ3mL5X/m52cRVfcXAklUdVT8NKe4URfecXtRSOODMPGk+xEg4VYH/
         YJZeUhBoH/p2sF70Z5pm2uz5xIKVTaB0LJEr1TVpjbLqlJAYxVu1Zn27tOQa9XR8mpqI
         XZm/7QifmajDEgsFB/XAHUd6SPW7/tqcAmgJNpffTbXGfB+WV3OqV77MS9fNHUtF8gvD
         vwXWHN9mG6Y/rQHbt17RZYE8MuEFZaOHwpvLQ0avsRfjOa1X2WE3UXYD9jbflaA7dZkl
         HeJgVZmb1QWUNX6HW/kBKHhcret9co7W/KVVS3G4vL9kY9xm/Wj3IcbvIHwboF9OMri+
         lswA==
X-Gm-Message-State: AFuF++kwhTkT1k7ZbX6uDI6vVCuKa9b+f32HmaYnPmM6PrkYIfZ1DQ4+
	ncKhVRleWDrPCMY2aFz+kXFfAiBw19Pq+tpxerXqOuRd+kEcrEtUaN3SP3kfEqXCdX2u5roLyJU
	LHjrfXdY=
X-Gm-Gg: AYBFou1b3o3zCHzULTC3ekKNg8CEuw4d2zQDryXyaEwP5XtEd0zWplCN357aKpF9QNx
	WZzAsJEvUt59ehKUVj5AqNlnqIJtro6sSHHWSIJuG326zVJe5UiPcCTSFNyRNqkA9wq9EUBnXDY
	1rG4XPM2r46xsedzK3ITBwPOexpb8WWLxfUQRwvLixUQIBIU6F7B6IGXs1jhVU3iAGu2nz507xb
	tKvMvb+Plyon5jSbI9zqlR1iDoT2ILRAj+YQmAOxsW5QRRuzgn0wlE9/wmsU4gePxrphoJgfDNk
	r+yx7Ex6FQcNpsf23jO+4o5tvXBhXlHIlomcqshVtovsmGkGtw8aCtE8PAyHN8JhVToAwpPWjxy
	GyZa33+I6eziYoi+GnyMxxbAxrsi6rxuR5TGgub7RaucQ3C1nSNuk0y3Jq0LVrlDN+wY5aBs8mi
	PMkwNiD+xneIEpjFfK1DRH7Ma0otmHJbcYpsEc5+x37+/7J4IXnTlbAFjs8sqHCXJ1j0tPiTMiR
	noc0tMEZSgFihoPWYQ1orFuznXw1/yGXMDpEysPdmkj4eDPLbKVigsZYP49l44aTZWMBN/Z494i
	5kOAyvZTBg==
X-Received: by 2002:a05:6870:4409:b0:48f:e0e5:a1fe with SMTP id 586e51a60fabf-4a259655af6mr418975fac.50.1791326557484;
        Tue, 06 Oct 2026 15:42:37 -0700 (PDT)
Received: from com-75606.corp.openai.org ([199.47.143.7])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a25700e3easm586986fac.3.2026.10.06.15.42.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 06 Oct 2026 15:42:37 -0700 (PDT)
From: Kyle Zeng <kylebot@openai.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	outbounddisclosures@openai.com,
	Kyle Zeng <kylebot@openai.com>
Subject: [PATCH net] netlink: reset skb headers before unicast and multicast filtering
Date: Tue,  6 Oct 2026 15:42:32 -0700
Message-ID: <20261006224232.50724-1-kylebot@openai.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Socket filters can use SKF_NET_OFF and SKF_LL_OFF to read relative to
an skb's network and MAC headers. Netlink producers may reserve
headroom without resetting those headers, allowing a receiving socket's
filter to read data before the initialized message.

For example, IWPM HELLO replies are allocated with dev_alloc_skb(),
which reserves NET_SKB_PAD bytes. An unprivileged NETLINK_RDMA user can
attach a classic socket filter and disclose this headroom through the
length of the delivered reply. The resets in netlink_dump() do not help
because IWPM sends a separately allocated skb through netlink_unicast().

Reset both headers before running the receiver's filter in unicast and
broadcast delivery, as is already done for dump skbs. This also covers
other netlink producers that reserve headroom without changing their
allocation or message-building code.

Fixes: b1153f29ee07 ("netlink: make socket filters work on netlink")
Assisted-by: Codex:gpt-6-astra
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
 net/netlink/af_netlink.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 9fdf964224ab..01af3bb144ae 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1363,6 +1363,8 @@ int netlink_unicast(struct sock *ssk, struct sk_buff *skb,
 	if (netlink_is_kernel(sk))
 		return netlink_unicast_kernel(sk, skb, ssk);
 
+	skb_reset_network_header(skb);
+	skb_reset_mac_header(skb);
 	if (sk_filter(sk, skb)) {
 		err = skb->len;
 		kfree_skb(skb);
@@ -1497,6 +1499,8 @@ static void do_one_broadcast(struct sock *sk,
 		goto out;
 	}
 
+	skb_reset_network_header(p->skb2);
+	skb_reset_mac_header(p->skb2);
 	if (sk_filter(sk, p->skb2)) {
 		kfree_skb(p->skb2);
 		p->skb2 = NULL;
