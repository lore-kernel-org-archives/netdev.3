Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793844083;
	b=SVqlr3mtStc3VFe+Nrf+SzNKLqDEyyJfMq6J6A7R70KOTdsGCbPOb6U35pkU+RRA58kK
	 M5oLWkuWggKPXeZZo1Uh9mz4otJWYRZ+5Q2ZTwq6N+yQBd8+XIx6ce4N7TXhBjFnFK+t6
	 E35v+7Zl6+y3P4JjyBrWhXQ7gljFyN+MDr1xy748XbQ/YR1/lLjq5BKxUV4WGpmvMdgrI
	 BdecsOEV0+SOYbDW6PgUlAuPM3cS0B9wGyrqqwejFNl1IG6XcFLZUfUcGoOorloMdyWNN
	 RSYmpjRrUWQbzm+HeuAxIdYdv/dvfYeTYtxOaNkoE2f03HrsBddHSWBrgPdca0o0Nog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793844083;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=uP4WjeA3JswVZeabC7KpofLrQ7N3W1fMzpyXVDcHxUY=;
	b=3DngnZOC6e7PYe7WFmsVCZfRbvJ8JQoqHw5ZFZWaTk0YM0CgONj0FzIThLqSLuDa5KII
	 4eQ4a3ZBcyvNTv+VhBFsTbGOX1K5nq5hXDZOef7BWNTZR/OvEIgc/HfAnlFJCpGUpEqKL
	 /woMyiIoDJpOMuYkFmfUeW25d1JcfVKfh2xEooeeyfd84puOcW8LT5U9fmLLsTvjVW19v
	 I1KyFKs8uiI9P2zK/rxjdNabQgAu1JudLUrBnvuW2D9GGfEDaiJMdALhbRNOcVYQzofza
	 5NvzGEnYg/Xsb6Hu4rhn2HJcR3/H4gQMaDRJxgbS2hXigaNNkadFUhNoK8VYgWgprWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b="N1Ch9/s4";
	arc=none smtp.remote-ip=111.22.67.135
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1274D6082BE6;
	Thu,  5 Nov 2026 02:01:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1274D6082BE6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=N1Ch9/s4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=N1Ch9/s4VmCUB/eX/jTozk30Qq7MARDEWNwjti1dtOcwqQp9GORLUeKXGxr4JvokHG9QvJ5x9SeS3
	 ANMSLy4sxkgwtWZb5wJ2Xw/1DO7JOx65rB1yQqspHd7MLH8IP3jTqs/iP094NozjoRzzHAQkOPj/+7
	 s57zXRoraISrVKDg=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee36aebe36e06b-6d430;
	Thu, 05 Nov 2026 10:01:18 +0800 (CST)
X-RM-TRANSID:2ee36aebe36e06b-6d430
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from FHB-W5100256 (unknown[10.55.1.70])
	by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee96aebe36bc9a-3523e;
	Thu, 05 Nov 2026 10:01:18 +0800 (CST)
X-RM-TRANSID:2ee96aebe36bc9a-3523e
From: xujiahao <xujiahao@cmss.chinamobile.com>
To: Edward Cree <ecree.xilinx@gmail.com>,
	netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-net-drivers@amd.com,
	linux-kernel@vger.kernel.org,
	xujiahao <xujiahao@cmss.chinamobile.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH net-next] sfc: avoid truncating MCDI hwmon attribute names
Date: Thu,  5 Nov 2026 10:01:15 +0800
Message-ID: <20261105020115.278-1-xujiahao@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
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

The name of each MCDI hwmon attribute is built in a 12-byte buffer as
prefix + 1-based per-type index + suffix, with prefixes up to "power"
and suffixes up to "_input".  With W=1 gcc reports:

  warning: 'snprintf' output may be truncated before the last format
  character [-Wformat-truncation=]

at mcdi_mon.c:457, :488 and :495, in both the sfc and the siena copy.

The same 12-byte field in struct efx_mcdi_mon_attribute, which receives
a strscpy() of the local buffer and backs the sysfs attribute name,
would also truncate silently once a sensor type has more than 9
instances: "power10_crit" already needs 13 bytes.

Enlarge both buffers to 24 bytes, enough for the longest possible name:
"power" + 10 digits + "_input" + NUL = 22 bytes.

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/all/202401100509.U4prhh6J-lkp@intel.com/
Signed-off-by: xujiahao <xujiahao@cmss.chinamobile.com>
---
 drivers/net/ethernet/sfc/mcdi_mon.c       | 4 ++--
 drivers/net/ethernet/sfc/siena/mcdi_mon.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/sfc/mcdi_mon.c b/drivers/net/ethernet/sfc/mcdi_mon.c
index e574f91f6..9700228df 100644
--- a/drivers/net/ethernet/sfc/mcdi_mon.c
+++ b/drivers/net/ethernet/sfc/mcdi_mon.c
@@ -138,7 +138,7 @@ struct efx_mcdi_mon_attribute {
 	unsigned int type;
 	enum efx_hwmon_type hwmon_type;
 	unsigned int limit_value;
-	char name[12];
+	char name[24];
 };
 
 static int efx_mcdi_mon_update(struct efx_nic *efx)
@@ -308,7 +308,7 @@ int efx_mcdi_mon_probe(struct efx_nic *efx)
 	MCDI_DECLARE_BUF(outbuf, MC_CMD_SENSOR_INFO_OUT_LENMAX);
 	unsigned int n_pages, n_sensors, n_attrs, page;
 	size_t outlen;
-	char name[12];
+	char name[24];
 	u32 mask;
 	int rc, i, j, type;
 
diff --git a/drivers/net/ethernet/sfc/siena/mcdi_mon.c b/drivers/net/ethernet/sfc/siena/mcdi_mon.c
index 0216a2a60..0037f603f 100644
--- a/drivers/net/ethernet/sfc/siena/mcdi_mon.c
+++ b/drivers/net/ethernet/sfc/siena/mcdi_mon.c
@@ -138,7 +138,7 @@ struct efx_mcdi_mon_attribute {
 	unsigned int type;
 	enum efx_hwmon_type hwmon_type;
 	unsigned int limit_value;
-	char name[12];
+	char name[24];
 };
 
 static int efx_mcdi_mon_update(struct efx_nic *efx)
@@ -308,7 +308,7 @@ int efx_siena_mcdi_mon_probe(struct efx_nic *efx)
 	MCDI_DECLARE_BUF(outbuf, MC_CMD_SENSOR_INFO_OUT_LENMAX);
 	unsigned int n_pages, n_sensors, n_attrs, page;
 	size_t outlen;
-	char name[12];
+	char name[24];
 	u32 mask;
 	int rc, i, j, type;
 
-- 
2.43.0



