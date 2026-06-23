Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [194.59.206.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5A139B97F;
	Tue, 23 Jun 2026 07:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.59.206.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782198534; cv=none; b=tu3CSRRrJMwn4sglpl4hA+vjKIsfKo+QvOfT0ioYukcc4dw84iVHZAek7s+WBLpvC5QFYW1XIZ+S4bAXq2LTrSm5UqGOEtb1hOtOMfv12Nmh1MmPVYArZadkvOCw3iJFmKw50oLlH/vgmCGd9q5RKX/YAEuFDwKh70E0pgfbu0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782198534; c=relaxed/simple;
	bh=kj/4cnt96eILQPYefGiJaKPu2Kq5RADso/2LSAZKwPk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hGPqhlxSKab0QBEIkKHtCoO6QXxIv22AeyPVyy7BVbCpoc69fVi5OPLfn8herspKeEjC6DEBgaWEzl4j/kO2xhyVMtdcEc+U8MBv5z3zS7qAtzjH9g8ojNbMC3K4VmHdScMVd4m7FjBGJqg2CHT78YQCrSpyZJZMqGQ4LLSnqtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=ITchBb2H; arc=none smtp.client-ip=194.59.206.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="ITchBb2H"
Received: from relay02-mors.netcup.net (localhost [127.0.0.1])
	by relay02-mors.netcup.net (Postfix) with ESMTPS id 4gkx4Q3S9jz48Cn;
	Tue, 23 Jun 2026 09:08:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1782198518;
	bh=kj/4cnt96eILQPYefGiJaKPu2Kq5RADso/2LSAZKwPk=;
	h=From:To:Cc:Subject:Date:From;
	b=ITchBb2HFx19FmHofW/i8DDM8iXJmP76Hd3lyjpK5xxlypQK0TjjNA+BFACN+zaZh
	 84D2kownQSjm0pffDS2Q03ZxiKoYE3yPHKtTu8+/zN+sFpRtb8dmkg9VqA1+SeORIx
	 8hd1uleP3kkVKRxyzgiqIrXCcOTfXo/ynJVUarUXC17IeACHTqObQFd4bV3tL/ndru
	 HE8vrXg9htQUTeXO1JhKWRWaobwT5sV6qFFN9zOx6orinBSeWnBy+ik7fxFHjJnEvQ
	 9vVlUZDepRW68Vt/pQZZKRd4f5gibT2qQ9GHBF7G0L34vSrTDSg31M29hsi9qqzT48
	 3bNLuvvt5qdcg==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by relay02-mors.netcup.net (Postfix) with ESMTPS id 4gkx460W44z7w6q;
	Tue, 23 Jun 2026 09:08:22 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4gkx452y1Tz8sgw;
	Tue, 23 Jun 2026 09:08:20 +0200 (CEST)
Received: from luggage.fritz.box (unknown [IPv6:2a02:8108:8984:1d00:a8ad:ebd4:6fc6:160])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id D33BD5F94A;
	Tue, 23 Jun 2026 09:08:19 +0200 (CEST)
Authentication-Results: mxe9fb;
	spf=pass (sender IP is 2a02:8108:8984:1d00:a8ad:ebd4:6fc6:160) smtp.mailfrom=linux@leemhuis.info smtp.helo=luggage.fritz.box
Received-SPF: pass (mxe9fb: connection is authenticated)
From: Thorsten Leemhuis <linux@leemhuis.info>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	donald.hunter@gmail.com,
	riana.tauro@intel.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] tools/ynl: add missing uapi header deps in Makefile.deps
Date: Tue, 23 Jun 2026 09:08:18 +0200
Message-ID: <20260623070818.2161810-1-linux@leemhuis.info>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <178219850021.1431613.7857959409078267283@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: D33BD5F94A
X-NC-CID: fthmGy+ngVgUYmq0YmkCnRZOKNsdl5Y7HnsV2gEWvhVHWd8tX5c=

drm_ras includes drm/drm_ras.h, which is a relatively new header not yet
shipped in most distro kernel-header packages. Without the explicit
entry, the build might fail with a message like this:

  drm_ras-user.c:19:10: error: ‘DRM_RAS_CMD_CLEAR_ERROR_COUNTER’ \
   undeclared here (not in a function); did you mean \
  ‘DRM_RAS_CMD_GET_ERROR_COUNTER’

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---

Lo! Quick note, I'll might be afk in the next few days and slow to respond.
Ciao, Thorsten

 tools/net/ynl/Makefile.deps | 2 ++
 1 file changed, 2 insertions(+)

diff --git tools/net/ynl/Makefile.deps tools/net/ynl/Makefile.deps
index cc53b2f21c4446..43d06ecbae93d0 100644
--- tools/net/ynl/Makefile.deps
+++ tools/net/ynl/Makefile.deps
@@ -14,10 +14,12 @@ UAPI_PATH:=../../../../include/uapi/
 
 get_hdr_inc=-D$(1) -include $(UAPI_PATH)/linux/$(2)
 get_hdr_inc2=-D$(1) -D$(2) -include $(UAPI_PATH)/linux/$(3)
+get_hdr_inc_drm=-D$(1) -include $(UAPI_PATH)/drm/$(2)
 
 CFLAGS_dev-energymodel:=$(call get_hdr_inc,_LINUX_DEV_ENERGYMODEL_H,dev_energymodel.h)
 CFLAGS_devlink:=$(call get_hdr_inc,_LINUX_DEVLINK_H_,devlink.h)
 CFLAGS_dpll:=$(call get_hdr_inc,_LINUX_DPLL_H,dpll.h)
+CFLAGS_drm_ras:=$(call get_hdr_inc_drm,_LINUX_DRM_RAS_H,drm_ras.h)
 CFLAGS_ethtool:=$(call get_hdr_inc,_LINUX_TYPELIMITS_H,typelimits.h) \
 	$(call get_hdr_inc,_LINUX_ETHTOOL_H,ethtool.h) \
 	$(call get_hdr_inc,_LINUX_ETHTOOL_NETLINK_H_,ethtool_netlink.h) \

base-commit: d07d80b6a129a44538cda1549b7acf95154fb197
-- 
2.54.0

