Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC0242C4EA
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 09:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786440550; cv=none; b=ghkNcM4PLtUJImG/A1Yd6dizpwSY0zM6pJjYx3xAnWz9bnqRaqxzXXfLm7fzQl2hGcb1nyQzb34pMQI65aZQaBasD1rSb2frOEQ5BNveshASzfsIuOvliF9w9fhqRvopwQRkz5/9n2FDkuwNiuKTdtiEp7RiUO4PvnxzHLa8aN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786440550; c=relaxed/simple;
	bh=xxx10RtBFinRWlDbb8ENPXIENAy57kXt86GpiH76uaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KQ2XXvs11R6uL0VAgRu0EXPTjuSZM1+sv8bJaaaI/jduEhcXkZpBF/xoPz4i9BlaaT6h9P2p7oY/8vf8xNmi9+ZqiBVGQ3iyzd3Qhfl+V8J4Fd1WjFaqrUXn6knf3Il3omgH70v8bjkhoeE1z+cbzJxQtEtZ+V2yIqo1Pcap14w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qJsjySH6; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qJsjySH6"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-496bb7cdf51so39576315e9.2
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 02:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786440545; x=1787045345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hZ+c+aznU4Zcf3YZTWH14MdAWf1QMAvY28BOcntSRAM=;
        b=qJsjySH6wLHLDjcX4AdnzIfb2+kbVYafv3jtTpeI/zrMJMi/ywnt0c3tB6Pryz2zcT
         K8TP7KX5ki2O9d2pQSLw2XUydTyPsY3YCbDMuGuLmIAbWjSr1gKpjwu1X7564baNJO+G
         xJ7rCdEsjsQNFNZtiqZCFuz1sE/Zw7YvDYsKgRLLIWHFjwBE4qPWzxnnJsLMfauOpWyR
         T+7BmH9YDs29FKlPOCeIClUmf4JREmopLZ3ZFhHSEd+FeYI6F0FF0xg2xYxacYxMSYTW
         rw/T8JTzLcM/7xx+1BeL7r2Mk3Yv235FgfMa1593tqB5DJRVRDoKRfTAwSCg5HNHny2D
         8xQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786440545; x=1787045345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hZ+c+aznU4Zcf3YZTWH14MdAWf1QMAvY28BOcntSRAM=;
        b=XsZtR3YpdyOIKdi8QldSmB5mGemi8vgL06IG+f3BOaazeW2jnbFnncXh2E2pAiJRtJ
         9T3LSNKTwmINOBVqMepbGynBaK8zIua3vN611gZWkvfXtL7J8yNEAoIqsLleRXY+heOP
         7NFBrQLJXfVu1Vcz8RZps2Sf33GA1JGxIPNH/cuCZ+w1vFfZyjI2LTazPUjrivNlwemz
         5WHa95+BxiVK0G0xs+JkI238qozxDcRvQTUEfOJZJDIINPj2By8cel5xSWFfREYqcn45
         8JjU7dRYrwazrnL/4abb72cs43esJ4YJdxvfWLP82RtuXscNjmcTNwuaT1Iy1EDAcP6e
         Q7vw==
X-Forwarded-Encrypted: i=1; AHgh+Rqvo3JmvpHnEiLrdSWIg8c5c8rUwatAnt1T86SHmHMFUtw5KcKWqyP9eiKKqKb0aC6q/gzo2w0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNgfYhTUY8qtVYyI4/U2nobUJQnkhmT1e10vJ9waNqvrg6+mg/
	jQdZ7DZltrtKVQnai++uLG+cr/nD+3qXGz81ep9DNHUO9o+KPueU4XoH
X-Gm-Gg: AR+sD11fEkr8u29FlgJDN3DbGzzYldhsHGIukn/cwKRxm2DOUf0jMk2u+Nr76jys0xH
	0gNZoJWpgYlgbhYdgWN+EW9MhVmCoCJp3OYhAKEIiupWm6cI6zcRTKIctuwigaE/jhoArVXA71M
	xRIgObXJfK6wjkqtlp1+6XyRlzoyyCiXBg/6pnfMt7Xrqcna/a5hHPG8fYy3M+iauKVHFyLZiq4
	gjN1BrMjT3AhPHx9vYH+9fEhhOdi24rGEvPWuDD0rMy/ftiAgc08hPHLHViDP6an10ah+2g3K9l
	JHexok9hSYC7lSAXTvEqRmXES3mDp9bHhg6kZilfQ8W8YDLkUU6Jmu92gDckoEbFpC5aOPhvPxD
	h+1VF7AObsjEszuaGEXwJE+g+dwYXp08tBvT6ax8pYtuj1xlBcbWQJVpajFY1a7mUeuV5c/t5Jj
	uLoTrKO1Pf8rsly+e5OFX+lRVtmtioiEdKgsHXS8u7OeN7q3zMnedtVe1MRbV/axUw5i1SCcgv3
	f9h1X4y/HiCgQ32SYlwtcK8f3cQp6ZWhzyoaKDnrrMFM5rJ
X-Received: by 2002:a05:600c:4e48:b0:495:4fd4:619b with SMTP id 5b1f17b1804b1-4997842dd51mr34675035e9.1.1786440545212;
        Tue, 11 Aug 2026 02:29:05 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-87-20-3-207.retail.telecomitalia.it. [87.20.3.207])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4997402a89bsm56135735e9.0.2026.08.11.02.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 02:29:04 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	llvm@lists.linux.dev
Cc: Daniel Golle <daniel@makrotopia.org>
Subject: [PATCH net-next v13 03/12] net: pcs: implement Firmware node support for PCS driver
Date: Tue, 11 Aug 2026 11:28:28 +0200
Message-ID: <20260811092843.673837-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260811092843.673837-1-ansuelsmth@gmail.com>
References: <20260811092843.673837-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the foundation of Firmware node support for PCS driver.

To support this, implement a simple Provider API where a PCS driver can
expose multiple PCS with an xlate .fwnode_xlate function.

PCS driver will have to call fwnode_pcs_add_provider() and pass the
firmware node pointer and a xlate function to return the correct PCS for
the passed #pcs-cells.

This will register the PCS in a global list of providers so that
consumer can access it.

The consumer will then use fwnode_pcs_get() to get the actual PCS by
passing the firmware node pointer and the index for #pcs-cells.

For a simple implementation where #pcs-cells is 0 and the PCS driver
expose a single PCS, the xlate function fwnode_pcs_simple_xlate() is
provided.

For an advanced implementation a custom xlate function is required.

On removal the PCS driver must delete itself from the provider list
using fwnode_pcs_del_provider().

A devm variant devm_fwnode_pcs_add() is provided to automate the release
procedure.

Generic functions fwnode_phylink_pcs_count() and fwnode_phylink_pcs_parse()
are provided for MAC driver that will declare PCS in DT (or ACPI).

Function fwnode_phylink_pcs_count() will parse "pcs-handle" property and
will return the number of PCS entries described in the passed firmware
node.

Function fwnode_phylink_pcs_parse() will parse "pcs-handle" property and
fill the passed available_pcs array with the available PCS found up to
passed num_pcs value. It's worth to mention that this function will ignore
PCS that still needs to be probed (returning -ENODEV) and such PCS won't be
added to the available_pcs array.

Co-developed-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/pcs/Kconfig          |   6 +
 drivers/net/pcs/Makefile         |   1 +
 drivers/net/pcs/pcs.c            | 245 +++++++++++++++++++++++++++++++
 include/linux/pcs/pcs-provider.h |  70 +++++++++
 include/linux/pcs/pcs.h          |  74 ++++++++++
 5 files changed, 396 insertions(+)
 create mode 100644 drivers/net/pcs/pcs.c
 create mode 100644 include/linux/pcs/pcs-provider.h
 create mode 100644 include/linux/pcs/pcs.h

diff --git a/drivers/net/pcs/Kconfig b/drivers/net/pcs/Kconfig
index e417fd66f660..f5c9ca2e992b 100644
--- a/drivers/net/pcs/Kconfig
+++ b/drivers/net/pcs/Kconfig
@@ -5,6 +5,12 @@
 
 menu "PCS device drivers"
 
+config FWNODE_PCS
+	bool "PCS Firmware Node"
+	depends on ACPI || OF || COMPILE_TEST
+	help
+		Firmware node PCS accessors
+
 config PCS_XPCS
 	tristate "Synopsys DesignWare Ethernet XPCS"
 	select PHYLINK
diff --git a/drivers/net/pcs/Makefile b/drivers/net/pcs/Makefile
index 4f7920618b90..3005cdd89ab7 100644
--- a/drivers/net/pcs/Makefile
+++ b/drivers/net/pcs/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 # Makefile for Linux PCS drivers
 
+obj-$(CONFIG_FWNODE_PCS)	+= pcs.o
 pcs_xpcs-$(CONFIG_PCS_XPCS)	:= pcs-xpcs.o pcs-xpcs-plat.o \
 				   pcs-xpcs-nxp.o pcs-xpcs-wx.o
 
diff --git a/drivers/net/pcs/pcs.c b/drivers/net/pcs/pcs.c
new file mode 100644
index 000000000000..39550d9a12a2
--- /dev/null
+++ b/drivers/net/pcs/pcs.c
@@ -0,0 +1,245 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/mutex.h>
+#include <linux/property.h>
+#include <linux/phylink.h>
+#include <linux/pcs/pcs.h>
+#include <linux/pcs/pcs-provider.h>
+
+MODULE_DESCRIPTION("PCS library");
+MODULE_AUTHOR("Christian Marangi <ansuelsmth@gmail.com>");
+MODULE_LICENSE("GPL");
+
+struct fwnode_pcs_provider {
+	struct list_head link;
+
+	struct fwnode_handle *fwnode;
+	struct phylink_pcs *(*fwnode_xlate)(struct fwnode_reference_args *pcsspec,
+					    void *data);
+
+	void *data;
+};
+
+static LIST_HEAD(fwnode_pcs_providers);
+static DEFINE_MUTEX(fwnode_pcs_mutex);
+
+struct phylink_pcs *fwnode_pcs_simple_xlate(struct fwnode_reference_args *pcsspec,
+					    void *data)
+{
+	return data;
+}
+EXPORT_SYMBOL_GPL(fwnode_pcs_simple_xlate);
+
+struct fwnode_pcs_provider *
+fwnode_pcs_add_provider(struct fwnode_handle *fwnode,
+			struct phylink_pcs *(*fwnode_xlate)(struct fwnode_reference_args *pcsspec,
+							    void *data),
+			void *data)
+{
+	struct fwnode_pcs_provider *pp;
+
+	if (!fwnode)
+		return ERR_PTR(-EINVAL);
+
+	pp = kzalloc_obj(*pp);
+	if (!pp)
+		return ERR_PTR(-ENOMEM);
+
+	pp->fwnode = fwnode_handle_get(fwnode);
+	pp->data = data;
+	pp->fwnode_xlate = fwnode_xlate;
+
+	mutex_lock(&fwnode_pcs_mutex);
+
+	list_add(&pp->link, &fwnode_pcs_providers);
+	fwnode_dev_initialized(fwnode, true);
+
+	mutex_unlock(&fwnode_pcs_mutex);
+
+	pr_debug("Added pcs provider from %pfwf\n", fwnode);
+
+	return pp;
+}
+EXPORT_SYMBOL_GPL(fwnode_pcs_add_provider);
+
+void fwnode_pcs_del_provider(struct fwnode_pcs_provider *pp)
+{
+	if (IS_ERR_OR_NULL(pp))
+		return;
+
+	mutex_lock(&fwnode_pcs_mutex);
+
+	list_del(&pp->link);
+	fwnode_dev_initialized(pp->fwnode, false);
+
+	mutex_unlock(&fwnode_pcs_mutex);
+
+	fwnode_handle_put(pp->fwnode);
+	kfree(pp);
+}
+EXPORT_SYMBOL_GPL(fwnode_pcs_del_provider);
+
+static void devm_fwnode_pcs_del(struct device *dev, void *res)
+{
+	struct fwnode_pcs_provider *pp = *(struct fwnode_pcs_provider **)res;
+
+	fwnode_pcs_del_provider(pp);
+}
+
+struct fwnode_pcs_provider *
+devm_fwnode_pcs_add_provider(struct device *dev, struct fwnode_handle *fwnode,
+			     struct phylink_pcs *(*fwnode_xlate)(struct fwnode_reference_args *pcsspec,
+								 void *data),
+			     void *data)
+{
+	struct fwnode_pcs_provider **ptr, *pp;
+
+	ptr = devres_alloc(devm_fwnode_pcs_del, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return ERR_PTR(-ENOMEM);
+
+	pp = fwnode_pcs_add_provider(fwnode, fwnode_xlate, data);
+
+	if (!IS_ERR(pp)) {
+		*ptr = pp;
+		devres_add(dev, ptr);
+	} else {
+		devres_free(ptr);
+	}
+
+	return pp;
+}
+EXPORT_SYMBOL_GPL(devm_fwnode_pcs_add_provider);
+
+static int fwnode_parse_pcsspec(const struct fwnode_handle *fwnode,
+				int index, const char *name,
+				struct fwnode_reference_args *out_args)
+{
+	if (!fwnode)
+		return -EINVAL;
+
+	if (name) {
+		index = fwnode_property_match_string(fwnode, "pcs-names",
+						     name);
+		if (index < 0)
+			return index;
+	}
+
+	return fwnode_property_get_reference_args(fwnode, "pcs-handle",
+						  "#pcs-cells", 0, index,
+						  out_args);
+}
+
+static struct phylink_pcs *
+__fwnode_pcs_get_from_pcsspec_provider(struct fwnode_reference_args *pcsspec,
+				       struct fwnode_pcs_provider *provider)
+{
+	if (provider->fwnode != pcsspec->fwnode)
+		return ERR_PTR(-EINVAL);
+
+	return provider->fwnode_xlate(pcsspec, provider->data);
+}
+
+static struct phylink_pcs *
+fwnode_pcs_get_from_pcsspec(struct fwnode_reference_args *pcsspec)
+{
+	struct fwnode_pcs_provider *provider;
+	struct phylink_pcs *pcs = NULL;
+
+	if (!pcsspec)
+		return ERR_PTR(-EINVAL);
+
+	mutex_lock(&fwnode_pcs_mutex);
+	list_for_each_entry(provider, &fwnode_pcs_providers, link) {
+		pcs = __fwnode_pcs_get_from_pcsspec_provider(pcsspec, provider);
+		if (!IS_ERR(pcs))
+			break;
+	}
+	mutex_unlock(&fwnode_pcs_mutex);
+
+	return !IS_ERR_OR_NULL(pcs) ? pcs : ERR_PTR(-ENODEV);
+}
+
+static struct phylink_pcs *__fwnode_pcs_get(const struct fwnode_handle *fwnode,
+					    unsigned int index, const char *con_id)
+{
+	struct fwnode_reference_args pcsspec;
+	struct phylink_pcs *pcs;
+	int ret;
+
+	ret = fwnode_parse_pcsspec(fwnode, index, con_id, &pcsspec);
+	if (ret)
+		return ERR_PTR(ret);
+
+	pcs = fwnode_pcs_get_from_pcsspec(&pcsspec);
+	fwnode_handle_put(pcsspec.fwnode);
+
+	return pcs;
+}
+
+struct phylink_pcs *fwnode_pcs_get(const struct fwnode_handle *fwnode, unsigned int index)
+{
+	return __fwnode_pcs_get(fwnode, index, NULL);
+}
+EXPORT_SYMBOL_GPL(fwnode_pcs_get);
+
+unsigned int fwnode_phylink_pcs_count(struct fwnode_handle *fwnode)
+{
+	struct fwnode_reference_args out_args;
+	int index = 0;
+	int ret;
+
+	while (true) {
+		ret = fwnode_property_get_reference_args(fwnode, "pcs-handle",
+							 "#pcs-cells", 0, index,
+							 &out_args);
+		/* We expect to reach an -ENOENT error while counting */
+		if (ret)
+			break;
+
+		fwnode_handle_put(out_args.fwnode);
+		index++;
+	}
+
+	return index;
+}
+EXPORT_SYMBOL_GPL(fwnode_phylink_pcs_count);
+
+int fwnode_phylink_pcs_parse(struct fwnode_handle *fwnode,
+			     struct phylink_pcs **available_pcs,
+			     unsigned int num_pcs)
+{
+	unsigned int i, found = 0;
+
+	if (!available_pcs)
+		return -EINVAL;
+
+	if (!fwnode_property_present(fwnode, "pcs-handle"))
+		return -ENODEV;
+
+	for (i = 0; i < num_pcs; i++) {
+		struct phylink_pcs *pcs;
+
+		pcs = fwnode_pcs_get(fwnode, i);
+		if (IS_ERR(pcs)) {
+			/* Exit early if no PCS remain.*/
+			if (PTR_ERR(pcs) == -ENOENT)
+				break;
+
+			/*
+			 * Ignore -ENODEV error for PCS that still
+			 * needs to probe.
+			 */
+			if (PTR_ERR(pcs) == -ENODEV)
+				continue;
+
+			return PTR_ERR(pcs);
+		}
+
+		available_pcs[found] = pcs;
+		found++;
+	}
+
+	return found;
+}
+EXPORT_SYMBOL_GPL(fwnode_phylink_pcs_parse);
diff --git a/include/linux/pcs/pcs-provider.h b/include/linux/pcs/pcs-provider.h
new file mode 100644
index 000000000000..15c198ffdd58
--- /dev/null
+++ b/include/linux/pcs/pcs-provider.h
@@ -0,0 +1,70 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef __LINUX_PCS_PROVIDER_H
+#define __LINUX_PCS_PROVIDER_H
+
+struct fwnode_pcs_provider;
+
+/**
+ * fwnode_pcs_simple_xlate - Simple xlate function to retrieve PCS
+ * @pcsspec: reference arguments
+ * @data: Context data (assumed assigned to the single PCS)
+ *
+ * Returns: the PCS pointed by data.
+ */
+struct phylink_pcs *fwnode_pcs_simple_xlate(struct fwnode_reference_args *pcsspec,
+					    void *data);
+
+/**
+ * fwnode_pcs_add_provider - Registers a new PCS provider
+ * @fwnode: Firmware node
+ * @fwnode_xlate: xlate function to retrieve the PCS
+ * @data: Context data
+ *
+ * Register and add a new PCS provider to the global providers list
+ * for the firmware node. The relevant PCS from the PCS provider
+ * is retrieved from the passed fwnode_xlate function.
+ *
+ * The xlate function MUST return a pointer to an existing, already-allocated
+ * struct phylink_pcs and MUST NOT dynamically allocate a new PCS.
+ * The same PCS object must be returned for a given firmware reference and args,
+ * as PCS pointer identity is used to associate PCS objects with their provider.
+ *
+ * Returns: A pointer to the registered PCS provider on success, or
+ * an ERR_PTR() encoded error code on failure.
+ */
+struct fwnode_pcs_provider *
+fwnode_pcs_add_provider(struct fwnode_handle *fwnode,
+			struct phylink_pcs *(*fwnode_xlate)(struct fwnode_reference_args *pcsspec,
+							    void *data),
+			void *data);
+
+/**
+ * fwnode_pcs_del_provider - Removes a PCS provider
+ * @pp: PCS provider returned by fwnode_pcs_add_provider()
+ */
+void fwnode_pcs_del_provider(struct fwnode_pcs_provider *pp);
+
+/**
+ * devm_fwnode_pcs_add_provider - Registers a new PCS provider
+ * @dev: Device of the PCS provider
+ * @fwnode: Firmware node
+ * @fwnode_xlate: xlate function to retrieve the PCS
+ * @data: Context data
+ *
+ * Register and add a new PCS provider to the global providers list
+ * for the firmware node. The relevant PCS from the PCS provider
+ * is retrieved from the passed fwnode_xlate function. While at that, it
+ * also associates the device with the PCS provider using devres.
+ * On driver detach, release function is invoked on the devres data,
+ * then, devres data is freed.
+ *
+ * Returns: A pointer to the registered PCS provider on success, or
+ * an ERR_PTR() encoded error code on failure.
+ */
+struct fwnode_pcs_provider *
+devm_fwnode_pcs_add_provider(struct device *dev, struct fwnode_handle *fwnode,
+			     struct phylink_pcs *(*fwnode_xlate)(struct fwnode_reference_args *pcsspec,
+								 void *data),
+			     void *data);
+
+#endif /* __LINUX_PCS_PROVIDER_H */
diff --git a/include/linux/pcs/pcs.h b/include/linux/pcs/pcs.h
new file mode 100644
index 000000000000..ef2134c578c7
--- /dev/null
+++ b/include/linux/pcs/pcs.h
@@ -0,0 +1,74 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef __LINUX_PCS_H
+#define __LINUX_PCS_H
+
+#include <linux/phylink.h>
+
+#if IS_ENABLED(CONFIG_FWNODE_PCS)
+/**
+ * fwnode_pcs_get - Retrieves a PCS from a firmware node
+ * @fwnode: firmware node
+ * @index: index fwnode PCS handle in firmware node
+ *
+ * Get a PCS from the firmware node at index.
+ *
+ * Returns: a pointer to the phylink_pcs or a negative error pointer. Can
+ * return -ENODEV if the PCS is not present in global providers list (either
+ * due to driver still needs to be probed or it failed to probe/removed).
+ */
+struct phylink_pcs *fwnode_pcs_get(const struct fwnode_handle *fwnode,
+				   unsigned int index);
+
+/**
+ * fwnode_phylink_pcs_count - Count PCS entries described in firmware node
+ * @fwnode: firmware node
+ *
+ * Helper function to count the number of PCS entries referenced by the
+ * "pcs-handle" property in a firmware node.
+ *
+ * Note that this function counts all PCS references in the firmware node,
+ * regardless of whether the corresponding PCS devices are already probed.
+ *
+ * Returns: number of PCS entries described in the firmware node.
+ */
+unsigned int fwnode_phylink_pcs_count(struct fwnode_handle *fwnode);
+
+/**
+ * fwnode_phylink_pcs_parse - Parse available PCS from firmware node
+ * @fwnode: firmware node
+ * @available_pcs: pointer to preallocated array of PCS
+ * @num_pcs: maximum number of PCS entries to scan
+ *
+ * Helper function that parses PCS references from the "pcs-handle"
+ * property of a firmware node and fills @available_pcs with PCS that are
+ * currently available up to @num_pcs.
+ *
+ * Only PCS that are currently available are stored in @available_pcs.
+ * PCS that returns -ENODEV are skipped.
+ *
+ * Returns: number of PCS stored in @available_pcs, or negative error code.
+ */
+int fwnode_phylink_pcs_parse(struct fwnode_handle *fwnode,
+			     struct phylink_pcs **available_pcs,
+			     unsigned int num_pcs);
+#else
+static inline struct phylink_pcs *fwnode_pcs_get(const struct fwnode_handle *fwnode,
+						 unsigned int index)
+{
+	return ERR_PTR(-ENOENT);
+}
+
+static inline unsigned int fwnode_phylink_pcs_count(struct fwnode_handle *fwnode)
+{
+	return 0;
+}
+
+static inline int fwnode_phylink_pcs_parse(struct fwnode_handle *fwnode,
+					   struct phylink_pcs **available_pcs,
+					   unsigned int num_pcs)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+
+#endif /* __LINUX_PCS_H */
-- 
2.53.0

