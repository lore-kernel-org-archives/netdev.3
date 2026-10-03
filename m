Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A524446EC;
	Sat,  3 Oct 2026 15:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791042689; cv=none; b=YXl1OIknMMcF3Nu9Nip9joeWWJmsJThVcIJg48hq49WaSLJHwQeYF+8s1r6dhCIcNLS9MWu2U3eIplkN3i1Muu8TAE1Cc1nai5TYoFMQmpwpk/XZEWjHNd4mUcDEy8YAui35xKVDMtDKkEiwJqDky8LL+HlMdZXNH7O46JeCLnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791042689; c=relaxed/simple;
	bh=Vpjp52oPI0Otuq7zxjETSib8CySNjwlkcVlvLOHuzEc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rV8/c4PVjnFcNaR0H9rDidA8RIdRyccFI+SG6RL2TbqfOssd0nP/stzy1HujMjCVJWILg3GuU3/ASdI8xhV6jx0bG3ZffmSeHRdrRO/H679GlDiML5NFxvAPL5ATs2juH6AiWgEte4gFT54LyZ+BhIs8oSVQTOEXMu0pDZbLNGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768)
	 (Exim 4.100.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1xD21C-000000001Fp-3MLy;
	Sat, 03 Oct 2026 15:51:22 +0000
Date: Sat, 3 Oct 2026 16:51:19 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Daniel Golle <daniel@makrotopia.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	driver-core@lists.linux.dev
Subject: [PATCH net-next v19 1/6] net: dsa: add devlink flash_update callback
 to dsa_switch_ops
Message-ID: <35450d868a8d1918380481420022b618e3758762.1791035885.git.daniel@makrotopia.org>
References: <cover.1791035885.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1791035885.git.daniel@makrotopia.org>

Add a devlink_flash_update callback to dsa_switch_ops so that DSA
drivers can support devlink dev flash without open-coding the devlink
plumbing. Like the other trampolines in net/dsa/devlink.c, the op
returns -EOPNOTSUPP when the driver does not implement the callback.
The devlink core takes a non-NULL ops->flash_update as the capability
gate, so on a switch without the callback a flash request now fetches
the firmware file, unless it names a component, which the core refuses
after consulting the driver's info versions, or an overwrite mask,
which it refuses outright: a missing file fails with the firmware
loader's errno, -ENOENT, instead of -EOPNOTSUPP, and a file that is
found reaches the trampoline inside a FLASH_UPDATE/FLASH_UPDATE_END
notification pair. The ETHTOOL_FLASHDEV ioctl on a user port reaches
the same trampoline through devlink's compat path, without extack.
Both are acceptable for an operation as infrequent as a firmware
update.

The devlink core calls the op with the devlink instance lock held and
without rtnl_lock. DSA calls its port ops from paths of its own, some
without rtnl_lock either, and registers the devlink instance before
the user ports exist, so a driver serialises a flash against its own
ops and its own setup itself.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
v19: commit message: DSA calls some port ops without rtnl and registers
     devlink before the user ports exist, so the driver serialises its
     flash against its setup as well; a request with a component or an
     overwrite mask is refused before the file is fetched, the errno of
     a missing file is the firmware loader's, and the ETHTOOL_FLASHDEV
     ioctl on a user port reaches the trampoline too, without extack
     (found by Sashiko AI review and a local review)
v18: no changes
v17: no changes
v16:
 - commit message: name the errno and the notifications the shared ops
   table changes for switches without the callback (found by Sashiko
   AI review)
 - commit message: a missing firmware file fails before the
   notification pair, which wraps only the call into the trampoline
v15: no changes
v14: no changes, picked up Andrew's v13 Reviewed-by
v13: no changes
v12: no changes
v11: no changes
v10: no changes
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
index 5d12191b6f6f5..1fcf4af6c5064 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -1176,6 +1176,9 @@ struct dsa_switch_ops {
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
index ed342f345692b..25311a87cbc56 100644
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
2.56.0
