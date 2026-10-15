Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B6B3EA947
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 23:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792107222; cv=none; b=k8yBSpfUhLrBVgjUz6cBaMJj/vXNrT8LgYKVtthfja6ajancYQYPc/3+qQvonl8wGJ7+N+K1ywufc2r/pcyvuYSO+fbDMNf2JhesCp8Sh/NzusF7z0wJfY4J+13O+JLkdv20CQuICTPTpTh+1o4AeQkvg+IZIsH6aZ1bTQ0FPyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792107222; c=relaxed/simple;
	bh=u1jjfZ2KHFS8UprCW2+eFF7FxKQjxGdtpSgzNKRCzfo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oU1k1nZtE0VGzYPJLM+Am/F6cLLbOM7Y/GRR/+MtKF+OPDwRNNH9SW/SHSCwtbRDFADmELGPaEu1iFfSlxzcLKZnO1NZokl2v2ryCfyvdEOGiQbJ7j+/dCjqo0wMja6HgO3ASoJjB/4RMnazGzeVVwMU5oAJ7ZjNOrCtIF9Pzog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=attK6779; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="attK6779"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-6c1983dfaffso1959755eaf.2
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 16:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792107220; x=1792712020; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DOHXnXj9H0hCXUUYqqbghfjLZTExI37IMuLDbNTswLI=;
        b=attK67797Ipt0uje83UmosadCdlU9yCj8xuHkBWI9XRAW/9roFBVEcpG1t3jYyVM89
         RfU5gufeXK05yi26dmqEFpNzNVyuSAbyNugDW9Bp7czOgtpCMT0xIiabIct2b4qySQar
         zYejx2k8A+FB09Ppq/l3jd/5MJDHmxbft0Ovjp+nN9meenlYRfi7l7OMFesNBm2dYfBR
         Uw5xTzfyZ5nDXJ2w5W75+oSBbROjuTbQiAWIu+ehoRJOVvE+GTlRBBqGIqahK/XQHB8j
         qynSQp0xn3WQxgXJbbW37w//ZnaGjOTKgWhL4pr+ep+8PCpONZRgCfzTqIjasUSEOoC3
         X7Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792107220; x=1792712020;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DOHXnXj9H0hCXUUYqqbghfjLZTExI37IMuLDbNTswLI=;
        b=C9qyBUDHwOvOPebau0JNX9rh5N+dBjdMMfCHig/YDz7o23l2m7tDubXzuhUb9SKcxb
         NI3Yqtm2pSH7V4YDGoTEYv+1KGuVL3k2IE8ivMKaxLg6Yv4IqDhGUgJosyEc1YwWgS9v
         G2q2AorDp9+cx+medPljJUB9QSBvNsvSH4mISa9K3sHJmDU9lxULNRSD6rNzhS0uMnW3
         yGF06CS3aYd/DQJ1MMWkjH2cuf+fAeWgkg8U1rQRb0USbLjlsc6gb08WvtHWQlDdLZlk
         Aih95zgrcAsnzEL+qsboVsnEEky6zBggu+OYMwLP6bEOhkpS6sZQodKZMoqFPZ34ZSfz
         8+Rg==
X-Gm-Message-State: AFq9FYIJbHiZC1ABSxDm44+ac1mk/4zmqv6dk6S9nytxC7mi9UaXCkwo
	AW0vmFadM506ALlPvsMCl7+r//K2WYoElJHt5YQLxrTRE02YEG8pvnta
X-Gm-Gg: AYBFou12vrd5GQKfWgPj8erf0j8Um2ZGX2ckzG5Qdk2/J5nWbReX6oD52y5vmGkO6bJ
	QhFlo4O3Y/xpCH6Tj6hXN8ARTJTEJnschFy9/6NTqA2kFQV8UJMGEkGwMRXEy6+CJ4UcSD+jA4B
	HeoQKiRZgh8pVk4GCKhLErFTT5t97Q+146gdQOm6/eRGcin3Lc9bHf4KTVoUc+VtwjZJT1j9Uey
	aqHi2UaBtvbTzf+2vLICZ2D6Zt0+TpuqXrejbcmtf4cSdXV3T5+kvvEgFMfx6pofdrNWX8hrzp8
	7EeiCoSlMXRje2s5YlxermwD4RSFobGBFoWpdV02uM+FMisRDOVmRzjda3OHu9aI+Nenrn3Vk2x
	/v99YQ2kY4CmFgzj2YFF9kJvkpueG+a9UoSige5NqnotL9NyOYnht6qNQ8AX1fcJkjVnooS9/Rl
	P7VaA8o316HRa38hTWhIKXOQuv77pRJmCEW9Ytzp8OBvu55wEo/GbF5EijsZDs7CWUfFRmEFh3o
	9Yjcw4wfCYNKyM/rPo1QyV4rmzsfMYezgX7BpP5RiJ8np8aPRy2kkaoBgAuytsz56c9oyJTZIya
	AFRRdTftaNZjQIyKwLgu/pO3NByLqyXvz2ahf30izkNvYZBZgpr6gkGEh1fOH/7cGMGdz37B7Vt
	heZMYVyNEOQKcDi+xSQkGDg==
X-Received: by 2002:a05:6820:f025:b0:6f6:f650:b4ea with SMTP id 006d021491bc7-6f6f650c080mr11136970eaf.28.1792107219806;
        Thu, 15 Oct 2026 16:33:39 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-70188bd9ecdsm525519eaf.2.2026.10.15.16.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 16:33:39 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 15 Oct 2026 17:33:31 -0600
Subject: [PATCH net v4 1/5] ptp: drain virtual clock sysfs operations
 before unregistering children
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-ptp-vclock-sampling-v4-1-cba6ffc8ceb6@gmail.com>
References: <20261015-ptp-vclock-sampling-v4-0-cba6ffc8ceb6@gmail.com>
In-Reply-To: <20261015-ptp-vclock-sampling-v4-0-cba6ffc8ceb6@gmail.com>
To: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Yangbo Lu <yangbo.lu@nxp.com>, 
 Miroslav Lichvar <mlichvar@redhat.com>
Cc: Eric Dumazet <edumazet@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

Parent clock removal walks its virtual clocks before removing the
n_vclocks sysfs attribute. The mutex taken by ptp_vclock_in_use() is
released before that walk, so a concurrent sysfs deletion can pick the
same child and unregister and free its ptp_vclock a second time. A
reference held by the device iterator does not protect that separately
allocated virtual clock.

Remove n_vclocks before walking the children. Removing the attribute
prevents new stores and drains stores already running, without holding
n_vclocks_mux across a callback that needs that mutex. Skip virtual
clocks, which do not have this attribute.

This race was found by code inspection of virtual-clock registration
failure cleanup and parent removal.

Fixes: bfcbb76b0f59 ("ptp: unregister virtual clocks when unregistering physical clock.")
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/ptp/ptp_clock.c   | 5 +++++
 drivers/ptp/ptp_private.h | 1 +
 drivers/ptp/ptp_sysfs.c   | 6 ++++++
 3 files changed, 12 insertions(+)

diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index 4111342d64f0..47ffc773065a 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -508,6 +508,11 @@ static int unregister_vclock(struct device *dev, void *data)
 
 int ptp_clock_unregister(struct ptp_clock *ptp)
 {
+	/*
+	 * Stop and drain virtual-clock creation and deletion before walking the
+	 * children. Do not hold n_vclocks_mux while waiting for sysfs callbacks.
+	 */
+	ptp_vclock_remove_sysfs(ptp);
 	if (ptp_vclock_in_use(ptp)) {
 		device_for_each_child(&ptp->dev, NULL, unregister_vclock);
 	}
diff --git a/drivers/ptp/ptp_private.h b/drivers/ptp/ptp_private.h
index db4039d642b4..ec8633126d6b 100644
--- a/drivers/ptp/ptp_private.h
+++ b/drivers/ptp/ptp_private.h
@@ -169,6 +169,7 @@ extern const struct attribute_group *ptp_groups[];
 
 int ptp_populate_pin_groups(struct ptp_clock *ptp);
 void ptp_cleanup_pin_groups(struct ptp_clock *ptp);
+void ptp_vclock_remove_sysfs(struct ptp_clock *ptp);
 
 struct ptp_vclock *ptp_vclock_register(struct ptp_clock *pclock);
 void ptp_vclock_unregister(struct ptp_vclock *vclock);
diff --git a/drivers/ptp/ptp_sysfs.c b/drivers/ptp/ptp_sysfs.c
index dc398c6b7528..53388b123198 100644
--- a/drivers/ptp/ptp_sysfs.c
+++ b/drivers/ptp/ptp_sysfs.c
@@ -263,6 +263,12 @@ static ssize_t n_vclocks_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(n_vclocks);
 
+void ptp_vclock_remove_sysfs(struct ptp_clock *ptp)
+{
+	if (!ptp->is_virtual_clock)
+		device_remove_file(&ptp->dev, &dev_attr_n_vclocks);
+}
+
 static ssize_t max_vclocks_show(struct device *dev,
 				struct device_attribute *attr, char *page)
 {

-- 
2.53.0

