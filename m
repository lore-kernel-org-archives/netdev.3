Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3FE3D6CC6
	for <netdev@vger.kernel.org>; Sun,  9 Aug 2026 20:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786307346; cv=none; b=NdyBqwKmDNMNsuI8G1M8/6HUFllLGEZSrzgfZPt/kN8f6DZxu77xHcbRKRA4Mv5zmwOtV5oxRe5IaoSBFzTjomh49GxW9X1RNIqKanPVNYrDrshuTWsEj99o3UFY1e8dccNzk4xNPcoTubNS+izDdd8yp7j9ADul2XB9E/sIvl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786307346; c=relaxed/simple;
	bh=IzRlEU23yfQQ6x4BYmQXGZqejxD9TteX1wiEO5R8YME=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aUAGiddbeTj5AoNCxRV6OY+wl52HHpn07U/2+xTbsjfWG4YU9sUSBQE3NA3b6H9Pef27o7VlS4540xS3ijrxemg83rxZLmGScUgKiOa9+dgwZ9BpasJ1VeD6gKT6/e2kQhOYoYPs4wCjI1h/7W0rDdMeFa4oMSTqFKZ1RkUQVQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g7SfrSMK; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g7SfrSMK"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-4566a5bc186so485400fac.1
        for <netdev@vger.kernel.org>; Sun, 09 Aug 2026 13:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786307343; x=1786912143; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gyzPxN0hN+8W2JU9IAdx12pcVnDBJDk0tQrb35djIKE=;
        b=g7SfrSMKNLekcPmr078XrJ2wA+XQzpsrlAONOUPHs7tSKxgc1g7tbb3NtAZcSGCEqS
         yX4XOzQargS1FWzGzOpoZ3WV3JoQUFaOeri23j/moRyReuKZHuIcNtDwJVaCzzvpDB6x
         sao/HJfzy9ANUTBza3rbHxa/1fs8Z1McWVfHsA41YZcx2Rs8EiAX6eXbFo/hPJMG96uq
         RcXJd1IASpJKzXBvaUPcNerDByVs3jUyoUON523YQP1WSyGODjl/PdNfXtYL+ZeiXp0Y
         cK/yqzbmKpiFGcOMcBxvwil0jC33ed7+J6UJkTzmhBDXl1O6oK4HSL8PGMpRZxCZbSTn
         xhWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786307343; x=1786912143;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gyzPxN0hN+8W2JU9IAdx12pcVnDBJDk0tQrb35djIKE=;
        b=UY84NH+kjIUdnXKjLyMGer5HG6tlBWbGBAXvfQzWm+EDK+zwVzko9Xd5qTgcDEdnIl
         QUpp+Qni7njaTq2gnWJPxiPyYCpb0RkgExg4st0VAZqOUwySz+vA1lutwd7pi0+iSQxZ
         iqhCMAC7XTsWO41aN9CPc9d6GjYsFszwWGmnilUBAfVPVaobBWUH2wTzuL7RygbsSukU
         7GPXMwGTLhcGJHssSC2luiW/JlgsZHFu3IijF3Va9Fg07gZDCC3/OaClHmiWJP6rxhd3
         h7TlsWPHPcRDQtMh8PCkNIZAzD/9m0q+SrxiZNnpqTT4MJA+ktkHtPegj2PAyoLlCqBH
         i7pw==
X-Forwarded-Encrypted: i=1; AHgh+RqrdPLoOzEYgH1yGJ2DhwXRh4eK0nenC579Sc4NNMIYWzBWw1VYAMnS9V0KWet2bbLsc+4BTdw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK0pBpmNZdp4+RZgRO34ikjPkyvXzSjULyuPRvihw3M8HZ9BG/
	v+XdPjuTKSmFk4EBgWaG7vhU4tUsZPFsTlqE3hXzh/f6oPWTBvEGXHH7
X-Gm-Gg: AR+sD13tTSrLZccXIi7xXutgL/mw/0EpWCdOGdVFsxsLUmMwm7XrmDQTyFbuo054x7g
	m9i21QxhayQMOqQn07lX6olM7o3HZ0rRwCJT1QQ0ysWy/4xArTfPwnw/y/VjggyPcvmdR56XNvK
	BnS/wPBHrqRxKXd3f16nUd4FDdlmUzDIE7ZChobDq6wI8+4X1Xfvq4tMXUwlK5e/n925oqDEQlJ
	p3qZqv9tVMBRSaly+qTWxKf0SOBLgvzH8TzT89+NRT1m4bfWNb3lqGvgOQCMpRZB+NwW+ooaQkU
	adTG6+wVnlLjWIQfdCMWNkMWlU37n56iMxER/wMUoi9Wbi9Q1If04gSvFO/5AC0KBfNqEP7HDWb
	dRaeBEgWxuLfcb+tempsjsHtQLbRNWeGAkWlAFlLhtDk/1YWIe4XAZFi7jvLjO4Ygy8raDig2U3
	WQimj89zhGWLwC3pLYZMOUvlw4Eo2PFcdb9RMr3QO0SwN7tJW1qJ/0cRhOZB63orfWuIPsIub9h
	IMKne0DDc0+cFxGAxuO4yYLUB9Eaupqf9xZbL0ibh7auimpsf9Hqnv+sYuVh3RoQzt77hBUG9kj
	/IO0+ZsNbVB4QsTrFI17qYZfh5kquLmZRMpe+49Glq0YvJA/A5axbpl/eDsbDOQ2WHLsyK8Ff5+
	9tlJtQ/S+h4tUR8jw
X-Received: by 2002:a05:6870:2482:b0:451:ecac:2c13 with SMTP id 586e51a60fabf-459e2a47b11mr13178902fac.8.1786307343529;
        Sun, 09 Aug 2026 13:29:03 -0700 (PDT)
Received: from [127.0.1.1] (184-96-154-59.hlrn.qwest.net. [184.96.154.59])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-459f19fd31csm6975362fac.1.2026.08.09.13.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 13:29:02 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 09 Aug 2026 14:28:32 -0600
Subject: [PATCH net-next v5 2/5] mfd: syscon: Add managed registration for
 external regmaps
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260809-submit-acx00-of-dynamic-v1-v5-2-bfa1f8518b28@gmail.com>
References: <20260809-submit-acx00-of-dynamic-v1-v5-0-bfa1f8518b28@gmail.com>
In-Reply-To: <20260809-submit-acx00-of-dynamic-v1-v5-0-bfa1f8518b28@gmail.com>
To: Lee Jones <lee@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: mfd@lists.linux.dev, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
X-Mailer: b4 0.15.2

of_syscon_register_regmap() publishes an externally owned regmap in the
global syscon list, but provides no way for a removable driver to
withdraw it. Registering a devm-managed regmap from such a driver would
therefore leave a stale pointer after unbind.

Factor external registration through an internal helper and add
devm_of_syscon_register_regmap(). The managed action removes the entry
under the syscon list lock before later devres actions release the
regmap. Hold a device-node reference for the lifetime of every
externally registered entry so its lookup key also remains valid.

Consumers of a removable provider remain responsible for ordering
teardown, for example with a managed device link.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mfd/syscon.c       | 87 ++++++++++++++++++++++++++++++++++------------
 include/linux/mfd/syscon.h | 12 +++++++
 2 files changed, 77 insertions(+), 22 deletions(-)

diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
index 21a7fcdd2737..448422fe4f21 100644
--- a/drivers/mfd/syscon.c
+++ b/drivers/mfd/syscon.c
@@ -10,6 +10,7 @@
 
 #include <linux/cleanup.h>
 #include <linux/clk.h>
+#include <linux/device.h>
 #include <linux/err.h>
 #include <linux/hwspinlock.h>
 #include <linux/list.h>
@@ -193,53 +194,95 @@ static struct regmap *device_node_get_regmap(struct device_node *np,
 	return syscon->regmap;
 }
 
-/**
- * of_syscon_register_regmap() - Register regmap for specified device node
- * @np: Device tree node
- * @regmap: Pointer to regmap object
- *
- * Register an externally created regmap object with syscon for the specified
- * device tree node. This regmap will then be returned to client drivers using
- * the syscon_regmap_lookup_by_phandle() API.
- *
- * Return: 0 on success, negative error code on failure.
- */
-int of_syscon_register_regmap(struct device_node *np, struct regmap *regmap)
+static struct syscon *
+of_syscon_register_regmap_internal(struct device_node *np,
+				   struct regmap *regmap)
 {
 	struct syscon *entry, *syscon = NULL;
-	int ret;
 
 	if (!np || !regmap)
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);
 
 	syscon = kzalloc_obj(*syscon);
 	if (!syscon)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
 	/* check if syscon entry already exists */
 	mutex_lock(&syscon_list_lock);
 
 	list_for_each_entry(entry, &syscon_list, list)
 		if (entry->np == np) {
-			ret = -EEXIST;
-			goto err_unlock;
+			mutex_unlock(&syscon_list_lock);
+			kfree(syscon);
+			return ERR_PTR(-EEXIST);
 		}
 
 	syscon->regmap = regmap;
-	syscon->np = np;
+	syscon->np = of_node_get(np);
 
 	/* register the regmap in syscon list */
 	list_add_tail(&syscon->list, &syscon_list);
 	mutex_unlock(&syscon_list_lock);
 
-	return 0;
+	return syscon;
+}
+
+/**
+ * of_syscon_register_regmap() - Register regmap for specified device node
+ * @np: Device tree node
+ * @regmap: Pointer to regmap object
+ *
+ * Register an externally created regmap object with syscon for the specified
+ * device tree node. This regmap will then be returned to client drivers using
+ * the syscon_regmap_lookup_by_phandle() API.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+int of_syscon_register_regmap(struct device_node *np, struct regmap *regmap)
+{
+	return PTR_ERR_OR_ZERO(of_syscon_register_regmap_internal(np, regmap));
+}
+EXPORT_SYMBOL_GPL(of_syscon_register_regmap);
+
+static void devm_of_syscon_register_regmap_release(void *data)
+{
+	struct syscon *syscon = data;
 
-err_unlock:
+	mutex_lock(&syscon_list_lock);
+	list_del(&syscon->list);
 	mutex_unlock(&syscon_list_lock);
+
+	of_node_put(syscon->np);
 	kfree(syscon);
-	return ret;
 }
-EXPORT_SYMBOL_GPL(of_syscon_register_regmap);
+
+/**
+ * devm_of_syscon_register_regmap() - Register a managed external syscon regmap
+ * @dev: Device that owns the regmap
+ * @np: Device tree node associated with the regmap
+ * @regmap: Pointer to the externally created regmap
+ *
+ * Register an externally created regmap object with syscon and remove it when
+ * @dev is unbound. Consumers must stop using the regmap before the provider is
+ * unbound, for example by establishing a managed device link to @dev.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+int devm_of_syscon_register_regmap(struct device *dev,
+				   struct device_node *np,
+				   struct regmap *regmap)
+{
+	struct syscon *syscon;
+
+	syscon = of_syscon_register_regmap_internal(np, regmap);
+	if (IS_ERR(syscon))
+		return PTR_ERR(syscon);
+
+	return devm_add_action_or_reset(dev,
+					devm_of_syscon_register_regmap_release,
+					syscon);
+}
+EXPORT_SYMBOL_GPL(devm_of_syscon_register_regmap);
 
 /**
  * device_node_to_regmap() - Get or create a regmap for specified device node
diff --git a/include/linux/mfd/syscon.h b/include/linux/mfd/syscon.h
index aad9c6b50463..3e804fc1b03e 100644
--- a/include/linux/mfd/syscon.h
+++ b/include/linux/mfd/syscon.h
@@ -15,6 +15,7 @@
 #include <linux/errno.h>
 
 struct device_node;
+struct device;
 
 #ifdef CONFIG_MFD_SYSCON
 struct regmap *device_node_to_regmap(struct device_node *np);
@@ -30,6 +31,9 @@ struct regmap *syscon_regmap_lookup_by_phandle_optional(struct device_node *np,
 							const char *property);
 int of_syscon_register_regmap(struct device_node *np,
 			      struct regmap *regmap);
+int devm_of_syscon_register_regmap(struct device *dev,
+				   struct device_node *np,
+				   struct regmap *regmap);
 #else
 static inline struct regmap *device_node_to_regmap(struct device_node *np)
 {
@@ -75,6 +79,14 @@ static inline int of_syscon_register_regmap(struct device_node *np,
 	return -EOPNOTSUPP;
 }
 
+static inline int
+devm_of_syscon_register_regmap(struct device *dev,
+			       struct device_node *np,
+			       struct regmap *regmap)
+{
+	return -EOPNOTSUPP;
+}
+
 #endif
 
 #endif /* __LINUX_MFD_SYSCON_H__ */

-- 
2.53.0

