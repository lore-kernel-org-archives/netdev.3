Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF4A4F4733
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 18:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792090524; cv=none; b=uvxjUhpcQI3sgU+hoEp10WPSLvJ3EMPd+hjerelK58IDrhl364+Yptcvdh+m8YD9Y4N1FjGJpjfFMeopYGJodomFyi6HkrvAX7usqMC0CeNfswlgGhbBvLoeZ0LCEoUgIFQGUNgxdqq796bmUZNewasnc6Hbp5dJh4v649TBa94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792090524; c=relaxed/simple;
	bh=S21YojpVXyoD0w7YKuSVQH09IvJc9X+ncpEbKejmmH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s9p2mHxizqp4hjLAChkxBcpcEPOVA9lR5OvIC62wrB5JoL8LyJ13K1/EiAknHaq54ECCaEp5Ngwqn/Y3KBGCdVa4lhTsyCnd15XVFmKKDSUNhrfZXqR3jdRGFd+FVliSxrM3mvIUb07ynq/V90MMRpSl9hW5XRD6x/w0AqoKPbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gjl79YC/; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gjl79YC/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792090519; x=1823626519;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S21YojpVXyoD0w7YKuSVQH09IvJc9X+ncpEbKejmmH8=;
  b=gjl79YC/p2LkqYO/Iv/gJd3OwHlVlqvnGbjrn71p7xENEejMse/PgWy6
   9z6yJyrjf958pJ0gBuIu5aK9Di5Sk/uo3nO0ck6g5rxHKA+eG0EwFsm9g
   HZU6Eg34F7sL+BgqhUp+i1PDzEw+Cpf6imeG4/nWvp7/3UW8M+qAmD2T7
   2t0/d+KnlIM3PChawztExqFDH/LnTTO8IIYwjpPqa7oWoI29qqjwF3nGK
   3jI4PMsLSns3jS4Y7oaX7NHfJs4D/iaZDvyE+5cnAWrr7ldxgKD9yKojc
   tIABYu1CyRN2k9jFwMuJpkyGdAWHCP+P4HCtUziqDF2I4GWfRLUIXh++c
   A==;
X-CSE-ConnectionGUID: KwgWYz8kQXOGbxWLIvhGig==
X-CSE-MsgGUID: YTmCFwSTRqC9j2U2yqAQBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="757932"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="757932"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 11:55:16 -0700
X-CSE-ConnectionGUID: pZK9c03VSGOGZ/0K0vYV8A==
X-CSE-MsgGUID: stDDY3fvSYeQRVQ3ZVN6sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="2003137"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa001.fm.intel.com with ESMTP; 15 Oct 2026 11:55:08 -0700
Received: from pkitszel-desk.tendawifi.com (unknown [10.245.244.208])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id DD23632EC4;
	Thu, 15 Oct 2026 19:55:05 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Michal Schmidt <mschmidt@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	edumazet@kernel.org,
	horms@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	Jiri Pirko <jiri@resnulli.us>,
	Jonathan Corbet <corbet@lwn.net>,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	andrew+netdev@lunn.ch,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	leon@kernel.org,
	mbloch@nvidia.com,
	jacob.e.keller@intel.com,
	jedrzej.jagielski@intel.com,
	anzaki@gmail.com,
	brett.creeley@amd.com,
	jtornosm@redhat.com,
	ohartoov@nvidia.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net-next v3 01/15] devlink, mlx5: add init/fini ops for shared devlink
Date: Thu, 15 Oct 2026 20:51:12 +0200
Message-ID: <20261015185454.6332-2-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20261015185454.6332-1-przemyslaw.kitszel@intel.com>
References: <20261015185454.6332-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add .shd_init() and .shd_fini() ops, that will be called for the first
devlink_shd_get() (to initialize driver's priv data) and on the last
devlink_shd_put() (to allow for the cleanup). Both ops are optional.

.shd_init() could return an error, which will stop creation of shd
instance. The initializer also gets an additional, optional param,
that driver could use for any needs.

devlink_shd_get() now returns ERR_PTR() on failure instead of NULL, so
the error from .shd_init() reaches the caller. Adjust mlx5, the only
user, to that and to the new param.

If any of the callbacks will need to get devlink instance, it could
be accessed by shd_priv_to_devlink().

Both callbacks are called with devl_lock held, .shd_init() before
devlink is registered, .shd_fini() after it is unregistered.

Next commit will make use of the callbacks, a later one will make use
also of the additional param.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
(v0) first discussed at:
https://lore.kernel.org/netdev/20260325063143.261806-3-przemyslaw.kitszel@intel.com

v1: remove redundant added blank line (Jiri)

v2:
 * call devl_register() only after .shd_init(), so there is no NEW/DEL
   notification pair when the init callback fails; adjust the order of
   devl_unregister() in devlink_shd_destroy() (Sashiko)
 * return the error from .shd_init() to the caller instead of
   collapsing every failure into -ENOMEM, devlink_shd_get() returns
   ERR_PTR() now (Sashiko)
 * commit message: .shd_init()/.shd_fini() are called outside of
   devlink registration; the init param is used within this series
 * kdoc: use @shd_init/@shd_fini member tags, fix the "shd_devlink'
   priv" wording, document the calling context (locks, before
   registration/after unregistration) and that a failed .shd_init()
   is retried on the next devlink_shd_get() (Sashiko)
 * devlink-shared.rst: document .shd_init()/.shd_fini(), init_param,
   ERR_PTR() return and shd_priv_to_devlink() (Sashiko)
---
 .../networking/devlink/devlink-shared.rst     | 19 ++++++-
 include/net/devlink.h                         | 30 ++++++++++
 .../ethernet/mellanox/mlx5/core/sh_devlink.c  |  6 +-
 net/devlink/sh_dev.c                          | 57 ++++++++++++++++---
 4 files changed, 98 insertions(+), 14 deletions(-)

diff --git a/Documentation/networking/devlink/devlink-shared.rst b/Documentation/networking/devlink/devlink-shared.rst
index 16bf6a7d25d9..f8b2a3d8aa82 100644
--- a/Documentation/networking/devlink/devlink-shared.rst
+++ b/Documentation/networking/devlink/devlink-shared.rst
@@ -45,6 +45,14 @@ The following functions are provided for managing shared devlink instances:
 * ``devlink_shd_get()``: Get or create a shared devlink instance identified by a string ID
 * ``devlink_shd_put()``: Release a reference on a shared devlink instance
 * ``devlink_shd_get_priv()``: Get private data from shared devlink instance
+* ``shd_priv_to_devlink()``: Get shared devlink instance from its private data
+
+``devlink_shd_get()`` returns ``ERR_PTR()`` on failure.
+
+The driver may initialize and clean up its private data of the shared
+instance in the optional ``shd_init()`` and ``shd_fini()`` callbacks of
+``struct devlink_ops``. The ``init_param`` argument of ``devlink_shd_get()``
+is passed to ``shd_init()``.
 
 Initialization Flow
 -------------------
@@ -55,7 +63,9 @@ Initialization Flow
 
    * The function looks up existing instance by identifier
    * If none exists, creates new instance:
-     - Allocates and registers devlink instance
+     - Allocates devlink instance
+     - Calls ``shd_init()`` (if set), on failure frees it and returns the error
+     - Registers devlink instance
      - Adds to global shared instances list
      - Increments reference count
 
@@ -67,7 +77,8 @@ Cleanup Flow
 
 1. **Cleanup** when PF is removed
 2. **Call** ``devlink_shd_put()`` to release reference (decrements reference count)
-3. **Shared instance is automatically destroyed** when the last PF removes (reference count reaches zero)
+3. **Shared instance is automatically destroyed** when the last PF removes (reference count reaches zero),
+   ``shd_fini()`` (if set) is called after unregistering it
 
 Chip Identification
 -------------------
@@ -85,6 +96,10 @@ Locking
 
 A global mutex (``shd_mutex``) protects the shared instances list during registration/deregistration.
 
+``shd_init()`` and ``shd_fini()`` are called with ``shd_mutex`` and the devlink
+lock of the shared instance held, thus must not call ``devlink_shd_get()`` nor
+``devlink_shd_put()``, and must use ``devl_*()`` variants of devlink API.
+
 Similarly to other nested devlink instance relationships, devlink lock of
 the shared instance should be always taken after the devlink lock of PF.
 
diff --git a/include/net/devlink.h b/include/net/devlink.h
index 7abd23376319..98bdde4f72ca 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -1607,6 +1607,34 @@ struct devlink_ops {
 	 * with other operations.
 	 */
 	bool supported_cross_device_rate_nodes;
+	/**
+	 * @shd_init: Shared devlink instance initializer.
+	 *
+	 * Gets the driver's priv data of the shared instance (the same as
+	 * devlink_shd_get_priv() returns) and the init_param passed to
+	 * devlink_shd_get(). Should initialize the priv data. May be NULL.
+	 *
+	 * Called when devlink_shd_get() creates the shared instance, before
+	 * it is registered. If it fails, the instance is freed without calling
+	 * @shd_fini, and the next devlink_shd_get() for the same id will try to
+	 * create it (and call @shd_init) again.
+	 *
+	 * Called with the global shared devlink mutex and the devlink lock of
+	 * the shared instance held, thus must not call devlink_shd_get() nor
+	 * devlink_shd_put(), and must use devl_*() variants of devlink API.
+	 *
+	 * Return: 0 on success, negative errno to fail the creation.
+	 */
+	int (*shd_init)(void *priv, void *init_param);
+	/**
+	 * @shd_fini: Shared devlink instance finalizer.
+	 *
+	 * Gets the driver's priv data of the shared instance. Called when the
+	 * last reference is dropped, after the shared instance is unregistered,
+	 * in the same locking context as @shd_init. Should clean up the priv
+	 * data. May be NULL.
+	 */
+	void (*shd_fini)(void *priv);
 	/**
 	 * selftests_check() - queries if selftest is supported
 	 * @devlink: devlink instance
@@ -1672,9 +1700,11 @@ void devlink_free(struct devlink *devlink);
 struct devlink *devlink_shd_get(const char *id,
 				const struct devlink_ops *ops,
 				size_t priv_size,
+				void *init_param,
 				const struct device_driver *driver);
 void devlink_shd_put(struct devlink *devlink);
 void *devlink_shd_get_priv(struct devlink *devlink);
+struct devlink *shd_priv_to_devlink(void *priv);
 
 /**
  * struct devlink_port_ops - Port operations
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
index b925364765ac..2c58f820b018 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
@@ -43,10 +43,10 @@ int mlx5_shd_init(struct mlx5_core_dev *dev)
 	*end = '\0';
 
 	/* Get or create shared devlink instance */
-	devlink = devlink_shd_get(sn, &mlx5_shd_ops, 0, pdev->dev.driver);
+	devlink = devlink_shd_get(sn, &mlx5_shd_ops, 0, NULL, pdev->dev.driver);
 	kfree(sn);
-	if (!devlink)
-		return -ENOMEM;
+	if (IS_ERR(devlink))
+		return PTR_ERR(devlink);
 
 	dev->shd = devlink;
 	return 0;
diff --git a/net/devlink/sh_dev.c b/net/devlink/sh_dev.c
index 85acce97e788..4f1b2f24b755 100644
--- a/net/devlink/sh_dev.c
+++ b/net/devlink/sh_dev.c
@@ -34,43 +34,61 @@ static struct devlink_shd *devlink_shd_lookup(const char *id)
 static struct devlink_shd *devlink_shd_create(const char *id,
 					      const struct devlink_ops *ops,
 					      size_t priv_size,
+					      void *init_param,
 					      const struct device_driver *driver)
 {
 	struct devlink_shd *shd;
 	struct devlink *devlink;
+	int err;
 
 	devlink = __devlink_alloc(ops, sizeof(struct devlink_shd) + priv_size,
 				  &init_net, NULL, driver);
 	if (!devlink)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 	shd = devlink_priv(devlink);
 
 	shd->id = kstrdup(id, GFP_KERNEL);
-	if (!shd->id)
+	if (!shd->id) {
+		err = -ENOMEM;
 		goto err_devlink_free;
+	}
 	shd->priv_size = priv_size;
-	refcount_set(&shd->refcount, 1);
 
 	devl_lock(devlink);
+
+	if (ops->shd_init) {
+		err = ops->shd_init(shd->priv, init_param);
+		if (err)
+			goto err_unlock;
+	}
 	devl_register(devlink);
 	devl_unlock(devlink);
 
+	refcount_set(&shd->refcount, 1);
 	list_add_tail(&shd->list, &shd_list);
 
 	return shd;
 
+err_unlock:
+	devl_unlock(devlink);
+	kfree(shd->id);
+
 err_devlink_free:
 	devlink_free(devlink);
-	return NULL;
+	return ERR_PTR(err);
 }
 
 static void devlink_shd_destroy(struct devlink_shd *shd)
 {
 	struct devlink *devlink = priv_to_devlink(shd);
 
 	list_del(&shd->list);
 	devl_lock(devlink);
 	devl_unregister(devlink);
+
+	if (devlink->ops->shd_fini)
+		devlink->ops->shd_fini(shd->priv);
+
 	devl_unlock(devlink);
 	kfree(shd->id);
 	devlink_free(devlink);
@@ -81,46 +99,53 @@ static void devlink_shd_destroy(struct devlink_shd *shd)
  * @id: Identifier string (e.g., serial number) for the shared instance
  * @ops: Devlink operations structure
  * @priv_size: Size of private data structure
+ * @init_param: Passed to .shd_init() callback alongside driver's priv;
+ *              this value need not match across all users of the shared
+ *              instance
  * @driver: Driver associated with the shared devlink instance
  *
  * Get an existing shared devlink instance identified by @id, or create
  * a new one if it doesn't exist. Return the devlink instance with a
  * reference held. The caller must call devlink_shd_put() when done.
  *
+ * On creation, @ops->shd_init() is called (if set), see its description
+ * for the calling context. Its error is returned to the caller.
+ *
  * All callers sharing the same @id must pass identical @ops, @priv_size
- * and @driver. A mismatch triggers a warning and returns NULL.
+ * and @driver. A mismatch triggers a warning and returns ERR_PTR(-EINVAL).
  *
  * Return: Pointer to the shared devlink instance on success,
- *         NULL on failure
+ *         ERR_PTR() on failure
  */
 struct devlink *devlink_shd_get(const char *id,
 				const struct devlink_ops *ops,
 				size_t priv_size,
+				void *init_param,
 				const struct device_driver *driver)
 {
 	struct devlink *devlink;
 	struct devlink_shd *shd;
 
 	mutex_lock(&shd_mutex);
 
 	shd = devlink_shd_lookup(id);
 	if (!shd) {
-		shd = devlink_shd_create(id, ops, priv_size, driver);
+		shd = devlink_shd_create(id, ops, priv_size, init_param, driver);
 		goto unlock;
 	}
 
 	devlink = priv_to_devlink(shd);
 	if (WARN_ON_ONCE(devlink->ops != ops ||
 			 shd->priv_size != priv_size ||
 			 devlink->dev_driver != driver)) {
-		shd = NULL;
+		shd = ERR_PTR(-EINVAL);
 		goto unlock;
 	}
 	refcount_inc(&shd->refcount);
 
 unlock:
 	mutex_unlock(&shd_mutex);
-	return shd ? priv_to_devlink(shd) : NULL;
+	return IS_ERR(shd) ? ERR_CAST(shd) : priv_to_devlink(shd);
 }
 EXPORT_SYMBOL_GPL(devlink_shd_get);
 
@@ -159,3 +184,17 @@ void *devlink_shd_get_priv(struct devlink *devlink)
 	return shd->priv;
 }
 EXPORT_SYMBOL_GPL(devlink_shd_get_priv);
+
+/**
+ * shd_priv_to_devlink - Get shared devlink instance from its priv data
+ * @priv: Driver's priv data, as returned by devlink_shd_get_priv()
+ *
+ * Return: pointer to shared devlink instance the @priv belongs to.
+ */
+struct devlink *shd_priv_to_devlink(void *priv)
+{
+	struct devlink_shd *shd = container_of(priv, struct devlink_shd, priv);
+
+	return priv_to_devlink(shd);
+}
+EXPORT_SYMBOL_GPL(shd_priv_to_devlink);
-- 
2.51.1

