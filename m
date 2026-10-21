Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792574193;
	b=pnMal2h+93Ptjx6N4XWD1ujnFq9MaYZYfwYRbM//yT510X6NkO8p9yDDopYBDJDKwNcn
	 ldTv/TiL0+Is24qL13lcWj64pfrElX8OZsrEb8XuouJ9Fia+KtVPDCRCOj+nSTHPpck4w
	 /3RaoCsL449BtIgP37W8alck9GBECCWdKXoNyRvsa7deURkykqYFW8rg09P0ocxJZAo43
	 qjJM9r8WBVW6JckNFfLhH/Drr9NCRj4IZyXKDjEmHudZ9lRRpoLcMGI615pfZOT+gcpDd
	 cRYOX7qRh1kLDdHdcR2ySSMOAHzMfpcc6VjDWmm3y1wLBqCEusVO5e2UqAuAL9vdM7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792574193;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:Sender:X-CM-SenderInfo;
	bh=TAyowwRcHh+nrqWpXVvmQRCdLdjZ8giPGwSLjKH4dIM=;
	b=I5xbvpJaLYRVtcuFxxL0ElAXq1AQYhc1C0wKMY7nm2wY9pt8TXgj7zswGyaInlGEtwpF
	 MSX937QWTbXSB6p1WCMubtq8uqWPOTD8GjIQcsYOSVk6tPgGMv6IpejYV6JzLk42oNYR1
	 xYyaVQlc3hKUGhSC8y/92OwBDtFgE2ofFJanm2DfCLvAdyS6P8B7UyyXEtScoEStV4wVv
	 xUChEiRdqycnrc1+f+1GnDffDunGF0l/AGzyNiDK2r1X7XF7dEWC0Sba+6PaG5SiFzpQP
	 goD4jlynSp09TUmy6U/WqzVbri825fFqB3WH8sxPYdtAIX7/zhSGFewWXNtUZMfmJZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=fibocom.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=eDY9jLFw;
	arc=none smtp.remote-ip=117.135.210.2
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29770606A31A;
	Wed, 21 Oct 2026 09:16:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29770606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fibocom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=eDY9jLFw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=TA
	yowwRcHh+nrqWpXVvmQRCdLdjZ8giPGwSLjKH4dIM=; b=eDY9jLFw6KnhDGCnl3
	A0YpeaKiYUGUJLkA8y2YNkI6q3kauobzgtjb2TPae/XQwKKlrKE33lixzVtUa/HF
	MbgXxDRJrBKqar/ksMZ+rtXpf4jJjD7n6zYxCUHdCmh26obqwn92UQMXicCPe1ES
	sP+Tp+O9rRM7eWHNIU3zvQ8d4=
Received: from GHT-5854251031.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDnr9PGgthqi5y2BQ--.62596S2;
	Wed, 21 Oct 2026 17:15:55 +0800 (CST)
From: Wanquan Zhong <wanquan.zhong@fibocom.com>
To: mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Wanquan Zhong <wanquan.zhong@fibocom.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH v6 0/2] add Rolling Wireless RW135R-GL and RW151 MHI support
Date: Wed, 21 Oct 2026 17:15:46 +0800
Message-ID: <cover.1792573876.git.zwq2226404116@163.com>
X-Mailer: git-send-email 2.53.0
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
X-CM-TRANSID:_____wDnr9PGgthqi5y2BQ--.62596S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WF1UCrW7tr4rtryxKFy3Jwb_yoW8Wr1fpF
	WrKws3GFW09r13CF4fJr4xC34FgFs3GrWjgryak34xWFy5Aa17GrWagry5Kr1qqr4fWrWj
	kayYqFWDua4UZa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UJPEDUUUUU=
Sender: zwq2226404116@163.com
X-CM-SenderInfo: h2ztjjaswuikqrrwqiywtou0bp/xtbC9Auj+mrYgssFtgAA3u

This is a standalone series against current mhi-next. v3-v5 were
incremental diffs on an unmerged local tree, so they did not apply.

Patch 1/2 adds the full RW135R-GL (sdx35) and RW151 (sdx75) channel
and event config, plus all known PCI subsystem IDs. Patch 2/2 enables
the ADB WWAN port in mhi_wwan_ctrl; that change is split out as
requested.

Signed-off-by: Wanquan Zhong <wanquan.zhong@fibocom.com>

---
Changes in v6:
- Resend as a standalone 2-patch series against current mhi-next
- Include full RW135R-GL/RW151 config (v1/v2 were never merged)
- Split ADB mhi_wwan_ctrl change into its own patch (Loic)
- Drop no_m3 (Loic, Krishna, Mani)
- Set RW151 MBIM ring size to 32 to match firmware (Krishna)
- Add SAHARA SBL channels for EDL
- Move NMEA from channels 14/15 to 60/61
- Align RW151 DIAG ring (64) and timeout (8000 ms) with RW135R-GL
- Add RW151 PCI IDs 2099:1501 and 2099:1502
- Put version changelog below --- (Mani)

Changes in v5:
- Add RW151 PCI IDs 2099:1501 and 2099:1502

Changes in v4:
- Drop no_m3 quirk per review; keep RW151 MBIM ring size fix only

Changes in v3:
- Increase RW151 MBIM ring size from 4 to 32

Changes in v2:
- Correct Rolling EDL firmware paths
- Fix RW151 PCI subsystem IDs (Lars)
- Document suspend-to-RAM testing (Loic)

Wanquan Zhong (2):
  bus: mhi: pci_generic: add Rolling Wireless RW135R-GL and RW151
    support
  net: wwan: mhi_wwan_ctrl: add ADB channel support

 drivers/bus/mhi/host/pci_generic.c | 113 +++++++++++++++++++++++++++++
 drivers/net/wwan/mhi_wwan_ctrl.c   |   1 +
 2 files changed, 114 insertions(+)

-- 
2.53.0

