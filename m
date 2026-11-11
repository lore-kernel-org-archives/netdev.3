Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794382116;
	b=Hf4x3h3BEJvHAJ3xbKi1WBFw/r4c9qZH0+bfqaiLDvYrlZEYSmrLDZ69KHuAo55uY087
	 elz0//PunLcstJFiDIK2Td+SujcwghMrY6h2PLA5qHIajGMdBxXswJcSMkJvSYvF1nzyR
	 iuuri7rfXWd3wvJJ/a0cZqqRQMRXwbSy/05j9jBU+ksd4VfgHq5ExOvkDnb2f/ruQ34w0
	 mPYBScww2L+6M4L1UffCBa6Rj1nHh+2mrx4HkQXBruXA3e4VN514mU8EbbgafJ5XYHeAT
	 KKP5UpiCwZ5xJrxGc8XYcbUSWi6OXFbWgE+ejpX2H7RZqvFajfcjUc0ctsyZ1f4TdaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794382116;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=fvA4caXYy5BSpxvCaqEJeTCv8onAojVykrQnaCc9pCY=;
	b=BlZABpF2XLMw62460CSGKcuDWiBAOyv3mot4fInmoBeKTVHf4kb8H1ysuB/OAF3YY+Pz
	 5D6xe/yC1AOzUdcLHidXmu8vi8IXkyOEcO+TJE8xMJj3hnvqwOUbyxS6mmqZKDF7TBP3x
	 RUmEa99tjiPhp9uqroQrLekB7j0VojksEHgpebH+ZByBHVfsQ6t4T59kd/ybLnnoyuRY7
	 VAcAeb10QO8la2ufRl/oic+P8a3W/IFeNR18UoiSlTYhjgsC/qa8VahY8anqV3GwXTyuP
	 4D2guKM2EgXeNN0RKlZ49dYiI5Gc3vueqeOxDqHwjcXzyYR34wAGamRXxwiVNv30/Og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=126.com;
	spf=pass smtp.mailfrom=126.com;
	dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=eRjJGj5E;
	arc=none smtp.remote-ip=117.135.210.6
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC32606A321;
	Wed, 11 Nov 2026 07:28:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1BC32606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=eRjJGj5E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=fv
	A4caXYy5BSpxvCaqEJeTCv8onAojVykrQnaCc9pCY=; b=eRjJGj5EJf9WJSHZLI
	TMy626n8dvUKL9EFq/cet51zQnlQNo9AogKL0aHCFaTff39jrcwfgmR7bBt6Q0dn
	J9L9CZHx2/tCLk6FaK67rnWrEZbb4jodk6Qpp//H2wUnhiYdKQLOFt35Xrka3fvm
	/0sn40CE5nY/UbEp6ErOasGlA=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCkvCgD3f__eGPRqKBYdDQ--.2187S2;
	Wed, 11 Nov 2026 15:27:26 +0800 (CST)
From: Linkui Xiao <xiaolinkui@126.com>
To: andrew@lunn.ch,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	sdf@fomichev.me,
	jacob.e.keller@intel.com,
	bjorn@kernel.org,
	alexanderduyck@fb.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linkui Xiao <xiaolinkui@kylinos.cn>
Subject: [PATCH net-next] net: ethtool: request rtnl_lock for ETHTOOL_MSG_PORT_GET
Date: Wed, 11 Nov 2026 15:27:24 +0800
Message-Id: <20261111072724.3295527-1-xiaolinkui@126.com>
X-Mailer: git-send-email 2.25.1
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCkvCgD3f__eGPRqKBYdDQ--.2187S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZr1rKF4fGF4rGFy7tFykGrg_yoW5GF18p3
	srAFyUCrWUuwn2qFnrXa1rWFyrAanxWw15Ar18tFy3Wr15Xr4xAFW7K3y3W3W5ZrsaqF95
	ArZ8XrZ5uanFyaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UYiiDUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBlB4V62r0GN7g3gAA3S

From: Linkui Xiao <xiaolinkui@kylinos.cn>

port_prepare_data() resolves the requested port through
phy_link_topo_get_port(), which requires rtnl_lock to be held before it
reads topo->ports:

	/* ports in the topo are RTNL protected, but may be accessed under
	 * netdev_lock for ops-locked devices. For now keep them under rtnl
	 * protection, as no ops-locked devices have phy_port capabilities
	 * yet.
	 */
	ASSERT_RTNL();

The dump side honours this, port_dump_one_dev() takes rtnl_lock()
itself. The doit side does not. ETHTOOL_MSG_PORT_GET is served by
ethnl_default_doit(), which keeps rtnl_lock only when the device is not
ops-locked, or when ethtool_nl_msg_needs_rtnl() asks for it:

	need_rtnl = !netdev_need_ops_lock(req_info->dev) ||
		    ethtool_nl_msg_needs_rtnl(req_info->dev, cmd);

ethtool_nl_msg_needs_rtnl() has no case for ETHTOOL_MSG_PORT_GET and
falls through to "return false", so on a device that opts into the
instance lock (request_ops_lock, queue_mgmt_ops or net_shaper_ops)
PORT_GET runs with netdev_lock only. Such a device that does have a
link topology trips the ASSERT_RTNL() warning and reads topo->ports
without the protection the xarray is documented to need.

Add the missing case. Like TSCONFIG_GET/SET, PORT_GET has no
corresponding ethtool ioctl, so it is Netlink-only and always needs
rtnl_lock.

The bug is latent as no device opts into the instance lock while also
carrying a link topology, so it cannot be observed yet and the change is
compile-tested only.

This was found during an audit of net/ethtool/ performed with the help
of an AI coding assistant (Codex), which also proposed the analysis and
the fix. I verified the Fixes commit and the callers of
ethtool_nl_msg_needs_rtnl().

Fixes: 27859d18bf41 ("net: ethtool: Introduce ethtool command to list ports")
Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
---
 net/ethtool/common.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/ethtool/common.h b/net/ethtool/common.h
index b062e99e89db..372304722ecc 100644
--- a/net/ethtool/common.h
+++ b/net/ethtool/common.h
@@ -124,6 +124,14 @@ ethtool_nl_msg_needs_rtnl(const struct net_device *dev, u8 cmd)
 		 * these cases are Netlink-only.
 		 */
 		return true;
+	case ETHTOOL_MSG_PORT_GET:
+		/*
+		 * port_prepare_data() resolves the port through
+		 * phy_link_topo_get_port(), which asserts rtnl_lock before
+		 * reading topo->ports. There is no corresponding ethtool
+		 * ioctl, so this case is Netlink-only.
+		 */
+		return true;
 	}
 	return false;
 }
-- 
2.25.1

