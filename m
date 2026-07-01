Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BEE3EFD04
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 09:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782898693; cv=none; b=rmRPdX8e5eNemi/pM7h/ktUoz3pHFDM8Gy+AIrMw/MTx7agmBk2hQk2xGVsQ8ImqJWitVjVhWe+UBydC/XGgtOxdUKeO6i0ZxHOU1TuIuCJg4beCTu+6tfaEkrJ1BaRxFyMC+AZ2CrJwVszPaR7aC59+HwkqEV2CIn8ERz4RCes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782898693; c=relaxed/simple;
	bh=bqgHMpRFSgGpk0AqOluAyO4FRLxnNblUBJ9bU6f+as4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UzVozhClaDyP3p42te3AInFbHPrfRhUW6OWBs98Zya+ELkEMqpqHfkJC6s4uwZchSaXuDPlwOvy9C1D6BDTsGYnpgWVcSJBFcfSHnKzVCthzKLZ5qETXR1s7U3MFgFqZeT4qke3IVgY6d/4paMzURmc3JH27oT2Ww7pdlUCKw+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=o7Jc64IG; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="o7Jc64IG"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-493bab44440so2244215e9.0
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 02:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1782898687; x=1783503487; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nUnu+0Gw8HzfquafR9sctwwF95xwBUzlKcuLZcG2ARA=;
        b=o7Jc64IGC/mjmA8FzgPnInOVyEaAn5OJvk65HU8OPnvilmSwhEWd8/t7nDoTLJ9G7I
         +3in0juB6vlbdU8JNa9U4H51n8VNHaJPXmwg06p4XKqTv5/S1huc3y8ls5OxGJJT/Hbt
         vL/2+3BQIge3troOS8fmouDZtUlc2gj5onwalZARN/fH8jzFaw/Rlex9mC3q0S1ZExgf
         vNbTGu8aU6cphdhDrN8YuFr6EWshqmBdELYABCrWVG9pl40obydlC7bJc/2tgHQkuFKe
         9KEjmSMZY2hh0a4Uablhv+muinvXLs2vk1+4+OHd7Gx3zUfXzLzbZUzM2ByfAEDZzd9R
         bVtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782898687; x=1783503487;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nUnu+0Gw8HzfquafR9sctwwF95xwBUzlKcuLZcG2ARA=;
        b=hY8rOTOb0FITWoh6Zfgv5Q3fZbI04xt+XIsSFwsEFW8aO67oouBIijyjEBqvFSQQzN
         CA7Xcjh2kZM1Y6MZJPZ2Vu7Q4JEOPr1ziRTtGZuPuuxnKmINAnkOd1fjukTF68AJznPq
         JZpClxiej5IRzzyDzYyk0NZiMMT940Dk5LezIc5GgGyE2KUzXC/B/g8GfVWZh2Q2KYF8
         P1TjE3uNz2L6ER4mzHY7JtIMOqaIC1Naqhr4HRTCm956HMS7PaEtP3MlU50C798I/aYj
         cQdyCm39dOqJwt1EEsV6BqRKEUMilU71I4SCv5ZWeB72O+cXnCHLtj0tNDH6oPb7mA8z
         EmHg==
X-Forwarded-Encrypted: i=1; AFNElJ8/HWhakJLK/t9HnlMb/esG6LEDzaxqwza9p37wqsR9nupE4o40C90gYjGkjzrkB0gR8YYs6OY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhgPoZ1e7+KLygZrd9jKM+i5dMR1bsPD5ICWvpIPQ4R+U3bWwG
	z/lBlehrslaNKYvlwAIaL2sVcSX/3amTXmvWopX/QqXz4H2Iliafar78GKx+HynQRAM=
X-Gm-Gg: AfdE7cmxinfcmjKaqsJhpr6ny8xbnz/8ckcDFdKyTrr4hysNl2D+YbRLU+pFHpLu6UV
	bmLiEpeR7Y7AME0NpI3wyeCQ/JbDQFYyW9uVoG3DIqTOuJgLxRpP0dCOTSfS6msdZJVj089JBEV
	lIfLWXXapg142FYCxha4but9XebeDHVVAtWdXhA3noK/wc73IhXP1jtBCXwde931mS4G16LdEP1
	7HwS8O/qPIXvRUAuOVh/TAXX0a/UvdcKgREBu2uDDJeEekZPbCXTChH+GRHr0ztTAU8DZ/cEj/M
	d64ljny1Gr+2/dKD/rSozXL3vb5DzpelyDO4IV6jk9ejYXadF1Aw/RJ5Oy2czL0F4ooBp6dnHGg
	PdcutTSmcFRFloazFPpNWr9Q6PVatjWu/5npbEcuVnI1rC3UzkaByPJReStemSxKKk+gpw/QBfc
	lipGmWo1ZgDe94rrZp16wk1A==
X-Received: by 2002:a05:600c:8715:b0:493:b36b:4933 with SMTP id 5b1f17b1804b1-493bc2099a9mr74044725e9.3.1782898687239;
        Wed, 01 Jul 2026 02:38:07 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-475643cd64bsm16217328f8f.14.2026.07.01.02.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 02:38:06 -0700 (PDT)
Date: Wed, 1 Jul 2026 11:38:03 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Mark Bloch <mbloch@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next V4 3/6] devlink: Parse eswitch mode boot defaults
Message-ID: <akTencQhKSanuFeW@FV6GYCPJ69>
References: <20260629182102.245150-1-mbloch@nvidia.com>
 <20260629182102.245150-4-mbloch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629182102.245150-4-mbloch@nvidia.com>

Mon, Jun 29, 2026 at 08:20:58PM +0200, mbloch@nvidia.com wrote:
>Add devlink_eswitch_mode= kernel command line parsing for a default
>eswitch mode.
>
>The supported syntax selects either all devlink handles or one explicit
>comma-separated handle list:
>
>  devlink_eswitch_mode=*=<mode>
>
>  devlink_eswitch_mode=<handle>[,<handle>...]=<mode>
>
>where <mode> is one of legacy, switchdev or switchdev_inactive. All
>selected handles receive the same mode. Assigning different modes to
>different handle lists in the same parameter value is not supported.
>
>Store the parsed selector and mode in devlink core so the default can be
>applied by a downstream patch.
>
>Document the devlink_eswitch_mode= syntax and duplicate handle handling.
>
>Signed-off-by: Mark Bloch <mbloch@nvidia.com>
>---
> .../admin-guide/kernel-parameters.txt         |  25 ++
> .../networking/devlink/devlink-defaults.rst   |  78 ++++++
> Documentation/networking/devlink/index.rst    |   1 +
> net/devlink/core.c                            | 227 ++++++++++++++++++
> 4 files changed, 331 insertions(+)
> create mode 100644 Documentation/networking/devlink/devlink-defaults.rst
>
>diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>index b5493a7f8f22..117300dd589c 100644
>--- a/Documentation/admin-guide/kernel-parameters.txt
>+++ b/Documentation/admin-guide/kernel-parameters.txt
>@@ -1249,6 +1249,31 @@ Kernel parameters
> 	dell_smm_hwmon.fan_max=
> 			[HW] Maximum configurable fan speed.
> 
>+	devlink_eswitch_mode=
>+			[NET]
>+			Format:
>+			<selector>=<mode>
>+
>+			<selector>:
>+			* | <handle>[,<handle>...]
>+
>+			<handle>:
>+			<bus-name>/<dev-name>
>+
>+			Configure default devlink eswitch mode for matching
>+			devlink instances during device initialization.
>+
>+			<mode>:
>+			legacy | switchdev | switchdev_inactive
>+
>+			Examples:
>+			devlink_eswitch_mode=*=switchdev
>+			devlink_eswitch_mode=pci/0000:08:00.0=switchdev
>+			devlink_eswitch_mode=pci/0000:08:00.0,pci/0000:09:00.1=switchdev_inactive
>+
>+			See Documentation/networking/devlink/devlink-defaults.rst
>+			for the full syntax.
>+
> 	dfltcc=		[HW,S390]
> 			Format: { on | off | def_only | inf_only | always }
> 			on:       s390 zlib hardware support for compression on
>diff --git a/Documentation/networking/devlink/devlink-defaults.rst b/Documentation/networking/devlink/devlink-defaults.rst
>new file mode 100644
>index 000000000000..380c9e99210e
>--- /dev/null
>+++ b/Documentation/networking/devlink/devlink-defaults.rst
>@@ -0,0 +1,78 @@
>+.. SPDX-License-Identifier: GPL-2.0
>+
>+==============================
>+Devlink Eswitch Mode Defaults
>+==============================
>+
>+Devlink eswitch mode defaults allow the eswitch mode to be provided on the
>+kernel command line and applied to matching devlink instances during device
>+initialization.
>+
>+The devlink device is selected by its devlink handle. For PCI devices this is
>+the same handle shown by ``devlink dev show``, for example
>+``pci/0000:08:00.0``.
>+
>+Kernel command line syntax
>+==========================
>+
>+Defaults are specified with the ``devlink_eswitch_mode=`` kernel command line
>+parameter.
>+
>+The general syntax is::
>+
>+  devlink_eswitch_mode=<selector>=<mode>
>+
>+``<selector>`` is either ``*`` or one or more devlink handles::
>+
>+  * | <bus-name>/<dev-name>[,<bus-name>/<dev-name>...]
>+
>+``*`` applies the mode to every devlink instance. All handles in the same
>+selector receive the same eswitch mode.
>+
>+``<mode>`` is one of ``legacy``, ``switchdev`` or ``switchdev_inactive``.
>+
>+Syntax rules
>+------------
>+
>+The following syntax rules apply:
>+
>+* Specify the default in one ``devlink_eswitch_mode=`` parameter. Repeated
>+  ``devlink_eswitch_mode=`` parameters are not accumulated.
>+* The ``devlink_eswitch_mode=`` value is limited by the kernel command line
>+  size.
>+* Whitespace is not allowed within the parameter value.
>+* ``<selector>`` must be either ``*`` or a handle list. ``*`` cannot be
>+  combined with explicit handles.
>+* ``<bus-name>`` and ``<dev-name>`` must not be empty.
>+* ``<dev-name>`` may contain ``:``. This allows PCI names such as
>+  ``0000:08:00.0``.
>+* Handles must not contain whitespace, ``*``, ``=`` or more than one ``/``.
>+* A comma separates handles.
>+* Comma-separated default assignments are not supported.
>+* Duplicate handles are rejected and the devlink eswitch mode default is
>+  ignored.
>+
>+The eswitch mode default corresponds to the userspace command::
>+
>+  devlink dev eswitch set <handle> mode <value>
>+
>+
>+Examples
>+========
>+
>+Set all devlink instances to switchdev mode::
>+
>+  devlink_eswitch_mode=*=switchdev
>+
>+Set one PCI devlink instance to switchdev mode::
>+
>+  devlink_eswitch_mode=pci/0000:08:00.0=switchdev
>+
>+Set two PCI devlink instances to switchdev inactive mode::
>+
>+  devlink_eswitch_mode=pci/0000:08:00.0,pci/0000:09:00.1=switchdev_inactive
>+
>+The following is invalid because comma-separated default assignments are not
>+supported::
>+
>+  devlink_eswitch_mode=pci/0000:08:00.0=switchdev,pci/0000:09:00.0=switchdev_inactive

Interesting. I would think that this is something user may want to set
for some usecases, no?


>diff --git a/Documentation/networking/devlink/index.rst b/Documentation/networking/devlink/index.rst
>index 32f70879ddd0..93f09cb18c44 100644
>--- a/Documentation/networking/devlink/index.rst
>+++ b/Documentation/networking/devlink/index.rst
>@@ -56,6 +56,7 @@ general.
>    :maxdepth: 1
> 
>    devlink-dpipe
>+   devlink-defaults
>    devlink-eswitch-attr
>    devlink-flash
>    devlink-health
>diff --git a/net/devlink/core.c b/net/devlink/core.c

Wanna have this in a separate file perhaps? "default.c"?


>index fe9f6a0a67d5..5126509a9c4e 100644
>--- a/net/devlink/core.c
>+++ b/net/devlink/core.c
>@@ -4,6 +4,10 @@
>  * Copyright (c) 2016 Jiri Pirko <jiri@mellanox.com>
>  */
> 
>+#include <linux/init.h>
>+#include <linux/list.h>
>+#include <linux/slab.h>
>+#include <linux/string.h>
> #include <net/genetlink.h>
> #define CREATE_TRACE_POINTS
> #include <trace/events/devlink.h>
>@@ -16,6 +20,193 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(devlink_trap_report);
> 
> DEFINE_XARRAY_FLAGS(devlinks, XA_FLAGS_ALLOC);
> 
>+static char *devlink_default_esw_mode_param;
>+static bool devlink_default_esw_mode_match_all;
>+static enum devlink_eswitch_mode devlink_default_esw_mode;
>+static LIST_HEAD(devlink_default_esw_mode_nodes);
>+
>+struct devlink_default_esw_mode_node {
>+	struct list_head list;
>+	char *bus_name;
>+	char *dev_name;
>+};
>+
>+static int __init
>+devlink_default_esw_mode_to_value(const char *str,
>+				  enum devlink_eswitch_mode *mode)
>+{
>+	if (!strcmp(str, "legacy")) {
>+		*mode = DEVLINK_ESWITCH_MODE_LEGACY;
>+		return 0;
>+	}
>+	if (!strcmp(str, "switchdev")) {
>+		*mode = DEVLINK_ESWITCH_MODE_SWITCHDEV;
>+		return 0;
>+	}
>+	if (!strcmp(str, "switchdev_inactive")) {
>+		*mode = DEVLINK_ESWITCH_MODE_SWITCHDEV_INACTIVE;
>+		return 0;
>+	}
>+
>+	return -EINVAL;
>+}
>+
>+static int __init
>+devlink_default_esw_mode_handle_parse(char *handle, char **bus_name,
>+				      char **dev_name)
>+{
>+	char *slash;
>+	char *p;
>+
>+	if (!*handle)
>+		return -EINVAL;
>+
>+	for (p = handle; *p; p++) {
>+		if (*p == '*' || *p == '=')
>+			return -EINVAL;
>+	}
>+
>+	slash = strchr(handle, '/');
>+	if (!slash || slash == handle || !slash[1])
>+		return -EINVAL;
>+	if (strchr(slash + 1, '/'))
>+		return -EINVAL;
>+
>+	*slash = '\0';
>+
>+	*bus_name = handle;
>+	*dev_name = slash + 1;
>+	return 0;
>+}
>+
>+static struct devlink_default_esw_mode_node *
>+devlink_default_esw_mode_node_find(const char *bus_name, const char *dev_name)
>+{
>+	struct devlink_default_esw_mode_node *node;
>+
>+	list_for_each_entry(node, &devlink_default_esw_mode_nodes, list) {
>+		if (!strcmp(node->bus_name, bus_name) &&
>+		    !strcmp(node->dev_name, dev_name))
>+			return node;
>+	}
>+
>+	return NULL;
>+}
>+
>+static int __init
>+devlink_default_esw_mode_node_add(const char *bus_name, const char *dev_name)
>+{
>+	struct devlink_default_esw_mode_node *node;
>+
>+	if (devlink_default_esw_mode_node_find(bus_name, dev_name))
>+		return -EEXIST;
>+
>+	node = kzalloc_obj(*node);
>+	if (!node)
>+		return -ENOMEM;
>+
>+	INIT_LIST_HEAD(&node->list);
>+	node->bus_name = kstrdup(bus_name, GFP_KERNEL);
>+	node->dev_name = kstrdup(dev_name, GFP_KERNEL);
>+	if (!node->bus_name || !node->dev_name) {
>+		kfree(node->bus_name);
>+		kfree(node->dev_name);
>+		kfree(node);
>+		return -ENOMEM;
>+	}
>+
>+	list_add_tail(&node->list, &devlink_default_esw_mode_nodes);
>+	return 0;
>+}
>+
>+static int __init devlink_default_esw_mode_handles_parse(char *handles)
>+{
>+	char *handle;
>+	int err;
>+
>+	if (!strcmp(handles, "*")) {
>+		devlink_default_esw_mode_match_all = true;
>+		return 0;
>+	}
>+
>+	while ((handle = strsep(&handles, ",")) != NULL) {
>+		char *bus_name;
>+		char *dev_name;
>+
>+		err = devlink_default_esw_mode_handle_parse(handle, &bus_name,
>+							    &dev_name);
>+		if (err)
>+			return err;
>+
>+		err = devlink_default_esw_mode_node_add(bus_name, dev_name);
>+		if (err)
>+			return err;
>+	}
>+
>+	return 0;
>+}
>+
>+static void __init
>+devlink_default_esw_mode_node_free(struct devlink_default_esw_mode_node *node)
>+{
>+	kfree(node->bus_name);
>+	kfree(node->dev_name);
>+	kfree(node);
>+}
>+
>+static void __init devlink_default_esw_mode_nodes_clear(void)
>+{
>+	struct devlink_default_esw_mode_node *node;
>+	struct devlink_default_esw_mode_node *node_tmp;
>+
>+	list_for_each_entry_safe(node, node_tmp,
>+				 &devlink_default_esw_mode_nodes, list) {
>+		list_del(&node->list);
>+		devlink_default_esw_mode_node_free(node);
>+	}
>+
>+	devlink_default_esw_mode_match_all = false;
>+}
>+
>+static int __init devlink_default_esw_mode_parse(char *str)
>+{
>+	char *handles;
>+	char *separator;
>+	char *mode;
>+	enum devlink_eswitch_mode esw_mode;
>+	int err;
>+
>+	if (!*str)
>+		return -EINVAL;
>+
>+	separator = strrchr(str, '=');
>+	if (!separator || separator == str || !separator[1])
>+		return -EINVAL;
>+
>+	*separator = '\0';
>+	handles = str;
>+	mode = separator + 1;
>+
>+	err = devlink_default_esw_mode_to_value(mode, &esw_mode);
>+	if (err)
>+		return err;
>+
>+	err = devlink_default_esw_mode_handles_parse(handles);
>+	if (err)
>+		devlink_default_esw_mode_nodes_clear();
>+	else
>+		devlink_default_esw_mode = esw_mode;
>+
>+	return err;
>+}
>+
>+static int __init devlink_default_esw_mode_setup(char *str)
>+{
>+	devlink_default_esw_mode_param = str;
>+	return 1;
>+}
>+__setup("devlink_eswitch_mode=", devlink_default_esw_mode_setup);
>+
> static struct devlink *devlinks_xa_get(unsigned long index)
> {
> 	struct devlink *devlink;
>@@ -382,6 +573,14 @@ struct devlink *devlinks_xa_lookup_get(struct net *net, unsigned long index)
> /**
>  * devl_register - Register devlink instance
>  * @devlink: devlink
>+ *
>+ * Make @devlink visible to userspace. Drivers must call this only after the
>+ * instance is fully initialized and its devlink operations can be called.
>+ *
>+ * Context: Caller must hold the devlink instance lock. Use devlink_register()
>+ * when the lock is not already held.
>+ *
>+ * Return: 0 on success.
>  */
> int devl_register(struct devlink *devlink)
> {
>@@ -580,6 +779,31 @@ static int __init devlink_init(void)
> {
> 	int err;
> 
>+	if (devlink_default_esw_mode_param) {
>+		char *def;
>+
>+		def = kstrdup(devlink_default_esw_mode_param, GFP_KERNEL);
>+		if (!def) {
>+			devlink_default_esw_mode_param = NULL;
>+			pr_warn("devlink: devlink_eswitch_mode parameter ignored, failed to allocate memory\n");
>+		} else {
>+			err = devlink_default_esw_mode_parse(def);
>+			kfree(def);
>+			if (err == -EEXIST) {
>+				devlink_default_esw_mode_param = NULL;
>+				pr_warn("devlink: duplicate eswitch mode handles ignored\n");
>+			} else if (err == -EINVAL) {
>+				devlink_default_esw_mode_param = NULL;
>+				pr_warn("devlink: invalid devlink_eswitch_mode parameter ignored\n");
>+			} else if (err == -ENOMEM) {
>+				devlink_default_esw_mode_param = NULL;
>+				pr_warn("devlink: devlink_eswitch_mode parameter ignored, failed to allocate memory\n");
>+			} else if (err) {
>+				goto out;
>+			}

Move this to a separate helper alongside the other "default" functions?


>+		}
>+	}
>+
> 	err = register_pernet_subsys(&devlink_pernet_ops);
> 	if (err)
> 		goto out;
>@@ -595,7 +819,10 @@ static int __init devlink_init(void)
> out_unreg_pernet_subsys:
> 	unregister_pernet_subsys(&devlink_pernet_ops);
> out:
>+	if (err)
>+		devlink_default_esw_mode_nodes_clear();
> 	WARN_ON(err);
>+
> 	return err;
> }
> 
>-- 
>2.43.0
>
