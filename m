Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794470192;
	b=McZ/w/tPmGHsP6E7bqUzOFASVQlHYsrVr4M0LiFQnTshl/CQ/9X8DFptkXGqBK1m3MlS
	 pl5ZWVs/mQGGvxmL8O9OuL+7p0zPEt3f8oHlZS8yqulCSJ9iT7LXXsh6dhjv8VY3eCZ1u
	 EtY2HQnnVoBXMY5aN48XTUwfnkEOO7/bK76Ssig1y1eLBFvK5+VdwdL83FKiZHghYnF9f
	 BBr2B55OgC2KvWR9I3FGljjMyio4YtDtjGVFGhbycWT1O+C+Dx98LBlgSswP17KMX7PkQ
	 xPvaoyFVqwmsSYCeHmCchT+P6rVJaN3vdUhEcKVJcEIaU1gzZa+L8Ku+cXDYB8yB8NA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794470192;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=UWhebc+R3cQ4MijJwX9jKvzqDJtWKsBp3DgTXq+ZaZk=;
	b=htYXL/3iQRq696Tjts1rgTnCcsgfpJre1Sx8we+gUBUSVgBduh/IS5kBfS4/0lZdpFv3
	 73J+sRFuSgjTFXK+b01N83S9tNUMwREL0d7yUVXbXVoTwCKeIV4+FSnqy+kLuUaCIGhjp
	 qtw7C8UDg+gJk+lrhZ9xaN9v4mQSbA/Dtb57ugB7XW1UtJe6OXwCOPD2EbwXvpZGs1L0/
	 NqE/Sf/1L2PUX3Fq9l6PAeufAcK5Shr3N/AQs1Y69g/nsrc5dEQk5o2HCvJc2FzFFQ/TV
	 a5umA6iVW9WqRDwfpAZ/Awts/IjtPwKflHQFkgVuQ/kN25pc7xJBoip0Ho/MlbyadJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=126.com;
	spf=pass smtp.mailfrom=126.com;
	dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=qVzNtuI4;
	arc=none smtp.remote-ip=117.135.210.6
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF66606A31C;
	Thu, 12 Nov 2026 07:56:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DF66606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=qVzNtuI4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=UW
	hebc+R3cQ4MijJwX9jKvzqDJtWKsBp3DgTXq+ZaZk=; b=qVzNtuI4WSQB9hzIpT
	MKNwDu8/TQquJgz3qURUTAJDYxdE3x4xH4yaw1ePi9wH3aFwC1mMwKc8m0+Inhac
	5j/NLP5q8n/LeF0nDwAFLZXI7r0Hu9IKkkyDV8TT+Pc5CLjkksYFCknowXVB+C/j
	gBAPDhurXY3Rq/JyCV+y/pbx0=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCkvCgD3H_vncPVqEKBNDQ--.18361S2;
	Thu, 12 Nov 2026 15:55:19 +0800 (CST)
From: Linkui Xiao <xiaolinkui@126.com>
To: maxime.chevallier@bootlin.com,
	andrew@lunn.ch,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	devnexen@gmail.com,
	sdf@fomichev.me,
	2022090917019@std.uestc.edu.cn
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linkui Xiao <xiaolinkui@kylinos.cn>
Subject: [PATCH net v2] net: ethtool: phy: warn about a phydev with no link topology
Date: Thu, 12 Nov 2026 15:55:17 +0800
Message-Id: <20261112075517.3904496-1-xiaolinkui@126.com>
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
X-CM-TRANSID:QCkvCgD3H_vncPVqEKBNDQ--.18361S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWFykAry7KFyxWrWDuw4DJwb_yoW5ur4xpa
	yF9Fy0yr9Yqrsaqr15ua15uryUZanrCrW5KFyF9rs8urs8Gr40ya1rtrsIqr1YyrZ5tFyY
	vr4DtFZ5XF1DZF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07ULFxUUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBlQdtRGr1cOfNFgAA3o

From: Linkui Xiao <xiaolinkui@kylinos.cn>

phy_prepare_data() reads reply_data->dev->link_topo and dereferences it
without checking it:

	struct phy_link_topology *topo = reply_data->dev->link_topo;
	...
	pdn = xa_load(&topo->phys, phydev->phyindex);

ethnl_req_get_phydev() returns dev->phydev as-is when the request carries
no phy-index, without consulting the topology, so a driver that populates
net_device->phydev without going through phy_attach_direct() reaches the
xa_load() above with topo == NULL. The IBM EMAC driver did exactly that on
its fixed-link path; it is fixed separately by "net: ibm: emac: attach the
fixed-link PHY with of_phy_connect()".

This is the only place in net/ethtool/ that touches ->link_topo without
coping with a missing topology: phy_link_topo_empty() is "return
!dev->link_topo", phy_link_topo_get_phy() and phy_link_topo_get_port()
both return NULL when it is NULL, and common.c, port.c, tsinfo.c and
ethnl_perphy_dump_one_dev() all test dev->link_topo first. Before
commit 9dd2ad5e92b9 ("net: ethtool: phy: Convert the PHY_GET command to
generic phy dump"), ethnl_phy_parse_request() bailed out with "if (!topo)
return 0;" before reaching the xarray; that check was not carried over
into phy_prepare_data().

A netdev with a phydev but no topology is a driver bug and is worth being
told about, so do not fail silently: warn once and answer -EOPNOTSUPP,
which is what phy_prepare_data() already returns when the phydev cannot be
found in the topology. Compared with the current NULL dereference this
keeps the driver bug in the log without oopsing the box for somebody who
merely ran ethtool on an otherwise working interface, which is a rather
indirect way of pointing at a MAC driver. The dump side already returns
early when dev->link_topo is NULL, so the warning can only fire from the
doit path, at most once per boot.

Verified by compilation; there is no EMAC fixed-link device here to
trigger it.

Fixes: 9dd2ad5e92b9 ("net: ethtool: phy: Convert the PHY_GET command to generic phy dump")
Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
---
v2: reworked after Andrew Lunn's review.

 - Point the finger at the real bug: the IBM EMAC driver assigning
   net_device->phydev by hand on its fixed-link path. That is now fixed
   separately with "net: ibm: emac: attach the fixed-link PHY with
   of_phy_connect()".
 - Keep the driver bug visible instead of papering over it: v1 silently
   returned -EOPNOTSUPP, v2 warns once and then returns -EOPNOTSUPP.
   Happy to drop this patch entirely if the NULL dereference is preferred
   as the way to catch such drivers.
 - Dropped Cc: stable.

v1: 
 - Link: https://lore.kernel.org/all/20261111072146.3293821-1-xiaolinkui@126.com/
---
 net/ethtool/phy.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ethtool/phy.c b/net/ethtool/phy.c
index 018b041..7e7e244 100644
--- a/net/ethtool/phy.c
+++ b/net/ethtool/phy.c
@@ -83,6 +83,9 @@ static int phy_prepare_data(const struct ethnl_req_info *req_info,
 	if (IS_ERR_OR_NULL(phydev))
 		return -EOPNOTSUPP;
 
+	if (WARN_ON_ONCE(!topo))
+		return -EOPNOTSUPP;
+
 	pdn = xa_load(&topo->phys, phydev->phyindex);
 	if (!pdn)
 		return -EOPNOTSUPP;
-- 
2.25.1

