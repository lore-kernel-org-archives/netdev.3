Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0176F41BA77;
	Tue, 15 Sep 2026 10:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789469759; cv=none; b=BYOPIedbNIqsjFTYFowk1jLU/pAq22BLgLuXa4ykF1t/7bSxAeNBW28ZTqw34cemSNe+dlZkanf6B54O0a8pKp8p3sDEEvzL74MaGeUC7MZqIVXDaoLNWM7V1uFyMe+6/GpJiOQgXqzF2EKv1tdl81IMyVr8Dp4OR6bLKtZUi9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789469759; c=relaxed/simple;
	bh=uEO06yrjerNAJXbVchPGb5EM1DzK66gD+su9qTzJ5dE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R9iHPf+uF3t0pq7ZHGsHE2IPmE7fkWKCe7aV7Y4lRGEyGfWZ0Eg3YXZYS2HhQTicGFJSUL1leiIH8L6gLGIfONz3Wea7D7lLdzDvahRWrqcCYszxyouifbJYeiiLjWFNrDHFy7Lan1/G8YVTxS8THrcoKTitHrbaqbAcN+BFKYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=i3jBU6pZ; arc=none smtp.client-ip=117.135.210.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="i3jBU6pZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=It
	Mo0Ijf+IBEa3gflKGxVBmdGZlVr9v/TYueIOJl/yc=; b=i3jBU6pZgpO2vQjxmk
	1nOMSTpfimMjHXndxqrYWomVbTQt9ex8HnRQjS65wKQmxpOxCDLMabA25eUkA08E
	oY/uwyRO26/xJRHd2QET7VpU6bnPomKqkOmc/06wazG6gRPrJmIX+8BUNTXdPVTh
	S0SQnn0+aFZr5+IRJOC6i0lq0=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD3X275I6lqXI5EBQ--.27399S2;
	Tue, 15 Sep 2026 18:54:50 +0800 (CST)
From: Linkui Xiao <xiaolinkui@126.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linkui Xiao <xiaolinkui@kylinos.cn>
Subject: [Intel-wired-lan] [PATCH] i40e: fix NULL pointer dereference in i40e_lan_del_device()
Date: Tue, 15 Sep 2026 18:54:47 +0800
Message-Id: <20260915105447.574951-1-xiaolinkui@126.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3X275I6lqXI5EBQ--.27399S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kr4fCFW3XFW8GFWUtrWkJFb_yoW8KrW3pr
	W7Ja45CrW5Jw43WayjqFW8uFyrJw40k345Kr13Crs09Fn8tF92yFWYyryrAas3ArWktFnx
	tF9Fya48Ar4DGr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UniSLUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBqBoM4mqpI-o+jwAA33

From: Linkui Xiao <xiaolinkui@kylinos.cn>

i40e_lan_del_device() dereferences pf->cinst unconditionally. pf->cinst
is only assigned by i40e_client_add_instance(), which resets it to NULL
whenever the i40e_client_instance allocation, i40e_client_get_params()
or i40e_register_auxiliary_dev() fails, and it returns void so
i40e_lan_add_device() cannot report any of that to its caller.

i40e_lan_add_device() can also fail before it ever gets there, for
example when the i40e_device allocation fails, and i40e_probe() only
prints a message instead of clearing I40E_FLAG_IWARP_ENA. i40e_remove()
therefore still calls i40e_lan_del_device() and dereferences a NULL
pf->cinst.

Only tear the auxiliary device down when an instance was actually
created. Removing the PF from the i40e_devices list below does not
depend on it.

Fixes: f4370a85d62e ("i40e: Register auxiliary devices to provide RDMA")
Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
---
 drivers/net/ethernet/intel/i40e/i40e_client.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_client.c b/drivers/net/ethernet/intel/i40e/i40e_client.c
index 84a97ca8a6d8..9a4f50af5347 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_client.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_client.c
@@ -496,15 +496,22 @@ int i40e_lan_add_device(struct i40e_pf *pf)
  **/
 int i40e_lan_del_device(struct i40e_pf *pf)
 {
-	struct auxiliary_device *aux_dev = pf->cinst->lan_info.aux_dev;
+	struct auxiliary_device *aux_dev;
 	struct i40e_device *ldev, *tmp;
 	int ret = -ENODEV;
 
-	auxiliary_device_delete(aux_dev);
-	auxiliary_device_uninit(aux_dev);
+	/* i40e_client_add_instance() leaves pf->cinst NULL when it fails,
+	 * so there may be no auxiliary device to tear down here.
+	 */
+	if (pf->cinst) {
+		aux_dev = pf->cinst->lan_info.aux_dev;
 
-	/* First, remove any client instance. */
-	i40e_client_del_instance(pf);
+		auxiliary_device_delete(aux_dev);
+		auxiliary_device_uninit(aux_dev);
+
+		/* First, remove any client instance. */
+		i40e_client_del_instance(pf);
+	}
 
 	mutex_lock(&i40e_device_mutex);
 	list_for_each_entry_safe(ldev, tmp, &i40e_devices, list) {
-- 
2.25.1

