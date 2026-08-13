Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292C43AD52A
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 17:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786643264; cv=none; b=SeekqQPfth7tR7AkdMVKAKf3IypHJWn9XDOuEvEXkZ4hC/HyEMCYJfI8/dx7LxRguhaj2kISb7oabAiIUKirpQjzLPp7QDIhuaeXSGfxihTGNSYdpcEaAFJyr+IBA4ATsfWuBo1X4yjSvbN8cM9oA7JOsznKeVmuSBWY2QoCV9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786643264; c=relaxed/simple;
	bh=q5930mDZa8nyXDAn+W2zn/rpNIQ+KxznOLcbAGh3aPM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o7MkuTnHMGFMeQxrHh60KTLmDqeiWIeJ5VjbGE3XNdxyNlW4ccJ2ljaqHCpSnsqFixkzHL9RLu6NPQ7GwbQ5Rdi3buw8QfGCbgTGswj0cjp0Dfbw5sihco/hXOkLP8hR6POK1bgEpvIIF5lGdqsGF866Pf2XHiFJQMIOOcM7Ayo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z3t9CcOw; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z3t9CcOw"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4953e04ef16so1746975e9.2
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 10:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786643255; x=1787248055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=c7wvD5wo2/av6+IbmyK7GMULA2iVsXLMzj4pik6CuA8=;
        b=Z3t9CcOwAncqE7QhT4dlnAP7AaOzRcPET7QKI/nHHfHHWkuS+VeRwIYoBS9ud9oI/D
         BkuVYOgvYULyONTTMkD2amDWLQTwB6POfC8JkqKNVsZqb0FDqJSJT20243uASOLHvfye
         YHMJIsbLXzwme/A7C1UuQzs8HLLDLM8PUQchadkeLPjx4Vjs8vKbJ4J4Qa4fJ/OAJzkN
         RUy61alhxpdGSqUTGPjMU/d2M5MXBtALvWfbNFHRMKRunn8aFIyxw8xDEB31BpavXIzz
         Rr3M1wmKqpxi9rRQ6D7xzx+21sJaSTi9i3VHd4mFAT+69uMC2++NnNEXwncSWqCK6oqp
         CMzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786643255; x=1787248055;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c7wvD5wo2/av6+IbmyK7GMULA2iVsXLMzj4pik6CuA8=;
        b=T7boTIjwCsYledqiTskaNUC7BYP5a1KRrLHgmFsfzR0kPG+oOfIecUeYKmH6a/NJAz
         NlCuFF7ES9J5+CuvVey3Ldx0FjwTy1YsYf1eBDxsFfgczEMKvMTGwCg2fkPa1nsgQ86D
         9T7xs5y7LlRegV3xVNqfoW5+qA3UzZ8yDC4yhfQ3wrf39b4r4Pgnf3GHg9u88CyTK0Ht
         oHbWwg8XM/fYGfScs4iMT8FOXNxkuuR2vVYoDp0LN7QsC9OAddktuqoxMGwKMRywKEKI
         eFYAyNXlaMhOdBkUY97QnzN8/xMFeRE9KnLo5Bio/SQ9RyF9gd+GQC4ibsOtSN4T6Qqu
         bdCw==
X-Gm-Message-State: AOJu0Yzq/8SNYQ33jiiI9eyACCs0GgrMm11Q0v9gsKc8kUPRHlyD+D1F
	fzytoRfVN0Np9HHpPiQGaO6/GaNN+qI7YuizhC/qF0eI1aJ58JoPm4l+qN/DGA==
X-Gm-Gg: AR+sD13zzveF9/83Y13Sr8PI9yzI59xbddaYQ2pyY5bstL+m8M+E9dYVQwM3CHoSvyz
	9alLP/mF4NQs/ztpgGouQEgkOfgpdceK3Ev/rCyra08SIPSL6PNJEnceU+m7xD4+QQrnShRXLlZ
	FNKqmgMXMnYpeV7mJyt6hXNajFFAGkfN0ZKRvROkmefIoccyLp/KCbTnzHvju98XlYakOGIg0LD
	C4Rj5cA76D3moQPHXCzU9nHjLAkYcBS2Ql+eCH1l4hqOTw20qyIXD3M6sfvcdxoS7Z+t8uQ5CVH
	8W1Y7jLw7W9FVlBZgN2cYRngwV48ODrlAvNW2cZhIUxy0p0SUh9OCwvr9+HGKFyGGqU3zuKHLjK
	zgaxYTlphD4GQEPo3xt7Gf58VQ9vEB6PUsl6r1DnVn1RCALPvUyLNBQvxxTm75c907we4RP4Ab7
	0g2XNd3CXc+m7bA6rp5M8GgxerCQ/R9ZDr+WwcW2WDAm3KyvXm3+EdYPrEl29/370koG8=
X-Received: by 2002:a05:600c:34cf:b0:499:48bb:417e with SMTP id 5b1f17b1804b1-49987929750mr3080675e9.2.1786643254529;
        Thu, 13 Aug 2026 10:47:34 -0700 (PDT)
Received: from SurHub.localdomain ([102.218.51.180])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49981b62437sm81694175e9.12.2026.08.13.10.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 10:47:34 -0700 (PDT)
From: Abdifatah Suruur <suruurism@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	quic_subashab@quicinc.com,
	quic_stranche@quicinc.com,
	doruk@0sec.ai,
	Abdifatah Suruur <suruurism@gmail.com>
Subject: [PATCH net] net: qualcomm: rmnet: require CAP_NET_ADMIN in the real device netns for changelink
Date: Thu, 13 Aug 2026 20:47:27 +0300
Message-ID: <20260813174727.14857-1-suruurism@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A changelink() on an rmnet device mutates the rmnet port state attached
to the real device (endpoint mux table, port->data_format and, via
rmnet_vnd_update_dev_mtu(), the real device MTU).  The real device may
live in a different netns than the rmnet device (rmnet_newlink()
resolves it in link_net), but the rtnl path only checks CAP_NET_ADMIN
against dev_net(dev).  A caller privileged only in the rmnet device's
netns can therefore rewrite the shared cellular data-path state owned by
another netns.

Gate rmnet_changelink() with rtnl_dev_link_net_capable(), matching the
"require CAP_NET_ADMIN in the device netns for changelink" series
(vxlan/geneve, CVE-2026-68432).

Fixes: 2abb5792387e ("net: qualcomm: rmnet: Allow configuration updates to existing devices")
Reported-by: Abdifatah Suruur <suruurism@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Abdifatah Suruur <suruurism@gmail.com>

---
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
@@ -312,6 +312,14 @@
 	if (!rmnet_is_real_dev_registered(real_dev))
 		return -ENODEV;
 
+	/*
+	 * The rtnl path only checks CAP_NET_ADMIN against dev_net(dev),
+	 * but the port state mutated below is attached to real_dev, which
+	 * may live in a different netns.
+	 */
+	if (!rtnl_dev_link_net_capable(dev, dev_net(real_dev)))
+		return -EPERM;
+
 	port = rmnet_get_port_rtnl(real_dev);
 
 	if (data[IFLA_RMNET_MUX_ID]) {
