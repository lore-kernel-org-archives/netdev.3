Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38203381EAE;
	Mon,  3 Aug 2026 03:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785729129; cv=none; b=dokVjFqfW4e43erCh48EEpV6KR+Ek98DWqlzBOrUDLp+gGc4EXL3UoFcWeejF3QKQp4Wk6TlNfZmO/+9hQc0zD+QBvggkTHVxe3jwWjY6dOJ5GIwRdBil1aKVTL72004Z8vWqJuTdx8Dz7vvcQpJn9hqVvMxNSyPbHnVVk4Sj/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785729129; c=relaxed/simple;
	bh=+IcgiHpiEvJb3ogpQ9Q9fS57ctiSRxu/rK0zQdMhH4c=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lOpsSjiY2OcwK51PAbg4NkRTsPNmlI7VyVj82G8qdKO0oTQCtfSCW2bd06E/hu4KWREA4QxXHGcFd9iqm7KItru99TiyLxX1IS0GLBK8jcwwqJxSeL6dKP+AVGBRo70duCBJIlheOFaelG32UUaU/pJ0O4UR6dIOh35NczLMPi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wqjiU-000000004c8-1ccK;
	Mon, 03 Aug 2026 03:51:54 +0000
Date: Mon, 3 Aug 2026 04:51:51 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v9 1/5] net: dsa: add devlink flash_update callback
 to dsa_switch_ops
Message-ID: <ed55b3d67436c32fdb01dca8db759b24a6834d4c.1785728574.git.daniel@makrotopia.org>
References: <cover.1785728574.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1785728574.git.daniel@makrotopia.org>

Add a devlink_flash_update callback to dsa_switch_ops so that DSA
drivers can support devlink dev flash without open-coding the devlink
plumbing. Like the other trampolines in net/dsa/devlink.c, the op
returns -EOPNOTSUPP when the driver does not implement the callback;
the devlink core will then have fetched the firmware file from
userspace before the request fails, which is acceptable for an
operation as infrequent as a firmware update.

The devlink core calls the op with the devlink instance lock held and
without rtnl_lock, whereas DSA serialises its switch and port ops
under rtnl_lock, so a driver has to serialise a flash against its own
ops itself.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v9: install the flash_update op unconditionally and return -EOPNOTSUPP
    from the trampoline like the other DSA devlink trampolines,
    instead of a second devlink_ops permutation (Andrew Lunn)

v8:
 - retitled: this patch adds the callback, its first user is patch 3
 - describe the op's calling context in the commit message

v7: no changes

v6: no changes

v5: no changes

v4: only install the flash_update op for drivers implementing the
    callback so the devlink core keeps rejecting unsupported flash
    requests before fetching the firmware file

v3: no changes

v2: align continuation lines with the open parenthesis

 include/net/dsa.h |  3 +++
 net/dsa/devlink.c | 13 +++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index 6f7f5c17b532..58597b14e592 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -1172,6 +1172,9 @@ struct dsa_switch_ops {
 	int	(*devlink_info_get)(struct dsa_switch *ds,
 				    struct devlink_info_req *req,
 				    struct netlink_ext_ack *extack);
+	int	(*devlink_flash_update)(struct dsa_switch *ds,
+					struct devlink_flash_update_params *params,
+					struct netlink_ext_ack *extack);
 	int	(*devlink_sb_pool_get)(struct dsa_switch *ds,
 				       unsigned int sb_index, u16 pool_index,
 				       struct devlink_sb_pool_info *pool_info);
diff --git a/net/dsa/devlink.c b/net/dsa/devlink.c
index ed342f345692..25311a87cbc5 100644
--- a/net/dsa/devlink.c
+++ b/net/dsa/devlink.c
@@ -20,6 +20,18 @@ static int dsa_devlink_info_get(struct devlink *dl,
 	return -EOPNOTSUPP;
 }
 
+static int dsa_devlink_flash_update(struct devlink *dl,
+				    struct devlink_flash_update_params *params,
+				    struct netlink_ext_ack *extack)
+{
+	struct dsa_switch *ds = dsa_devlink_to_ds(dl);
+
+	if (!ds->ops->devlink_flash_update)
+		return -EOPNOTSUPP;
+
+	return ds->ops->devlink_flash_update(ds, params, extack);
+}
+
 static int dsa_devlink_sb_pool_get(struct devlink *dl,
 				   unsigned int sb_index, u16 pool_index,
 				   struct devlink_sb_pool_info *pool_info)
@@ -169,6 +181,7 @@ dsa_devlink_sb_occ_tc_port_bind_get(struct devlink_port *dlp,
 
 static const struct devlink_ops dsa_devlink_ops = {
 	.info_get			= dsa_devlink_info_get,
+	.flash_update			= dsa_devlink_flash_update,
 	.sb_pool_get			= dsa_devlink_sb_pool_get,
 	.sb_pool_set			= dsa_devlink_sb_pool_set,
 	.sb_port_pool_get		= dsa_devlink_sb_port_pool_get,
-- 
2.55.0
