Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949C346D548
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 09:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789984320; cv=none; b=OcHw6J8g/PzTXDYuHPmt3N/IHFBarCQ6ftzA7Qd2v6SgrxJFaVw7yWAwrQGKHjhfAA8cSMmlwAHitBetQhz8VB1DbagWtBVfqgbULrkS0e7fYsNsAroH9PN5HD8RrYytMIEzarNYFAtR4WOCEYU1caVb+MGw3ThJsJRIJ5huYYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789984320; c=relaxed/simple;
	bh=Mrto44z8auMjPVYZjsQlkZX5YH67DCe2Xy1B6uaopsA=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zk1QBdyWWODivInj2miRW8VBnegSiakidM+svsoEFWey2rhrX71p1CnQUGFoerVtWA2rosCFBpQ0Rb+uRvjMr0QwISDgUrlkKMqPPEgA8RQHlVGVmM5kUB/bIcmGUmxnsXGOsbZDBOdbDFGOZDWt/OUPIc4M0099h3DFFojs/Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 1193275cb5a211f19a56ed5b684f684d-20260921
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:1c037834-da9b-493b-b7c4-31e1d8546c31,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:7db8b62,CLOUDID:7c6b26e58ba1d5fe59038d3b5e3efa67,BulkI
	D:nil,BulkQuantity:0,SF:81|82|83|102|136|850|865|898,TC:nil,Content:0|15|5
	0|99,EDM:5|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
	,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 1193275cb5a211f19a56ed5b684f684d-20260921
X-User: zhangyunfei1@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zhangyunfei1@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1235505940; Mon, 21 Sep 2026 17:51:50 +0800
From: Zhang Yunfei <zhangyunfei1@kylinos.cn>
To: netdev@vger.kernel.org
Subject: Re: [PATCH net 1/2] net: ngbe: propagate resume errors to the PM core
Date: Mon, 21 Sep 2026 17:51:47 +0800
Message-Id: <20260921095147.881874-1-zhangyunfei1@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <178998233302.2160803.12428550394082304742@kernel.org>
References: <178998233302.2160803.12428550394082304742@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Thanks for the review. Point by point:

[High] ngbe_resume() still discards the return value of ngbe_reset_hw()

Agreed. ngbe_reset_hw() can genuinely fail (the wx_stop_adapter() error
exit, or the LAN reset read_poll_timeout() expiring), and on those exits
ngbe_reset_misc(), wx_clear_hw_cntrs(), wx_get_mac_addr() and
wx_init_rx_addrs() are all skipped; ngbe_probe() treats the very same
call as fatal. I will send a follow-up patch propagating that error as
well, so that the whole tail of ngbe_resume() reports failures to the
PM core.

[Medium] "the device can be re-probed"

Agreed, that sentence overstates the effect: device_resume()
(drivers/base/power/main.c) only records the failure (async_error,
dpm_save_failed_dev()) and logs it via pm_dev_err(); there is no
unbind, re-probe or retry. What the patch actually buys is that the
failure is reported to the PM core instead of being silently swallowed;
the user-visible state of the netdev itself is unchanged. Sorry for the
imprecise wording.

[High, pre-existing] detached netdev with __LINK_STATE_START still set
after a failed resume

Acknowledged. One detail from reading the code: the WX_STATE_RES_FREED
guard cannot fire in this scenario. That bit is only set by
ngbe_down_suspend(), which is reachable only via wx->down_suspend from
the PCI error-recovery path (libwx/wx_err.c); the normal suspend path
goes through ngbe_dev_shutdown() -> ngbe_close() and never sets it, so
the bit is clear here and the double teardown (including the memset()
of already-freed descriptor rings) is indeed reachable. It is
pre-existing and larger than this series; I plan to look at the
failed-open unwind separately.

[Medium, pre-existing] wxvf_resume()

Acknowledged -- the same swallowed-error pattern is there, with an
unconditional netif_device_attach() on top. It is shared by ngbevf and
txgbevf, so it deserves its own patch rather than being folded into
this series.

[Medium, pre-existing] ngbe_open() error path frees rings while the
hardware is still armed

Acknowledged; see my reply on 2/2, the same reasoning applies here.

To sum up: I do not plan a v2 of this series. Patch 1/2 does what its
commit message promises for the two error paths it touches, the
ngbe_reset_hw() gap is a separate fix, and the remaining findings are
pre-existing. I will follow up with patches for the ngbe_reset_hw()
propagation and the failed-open unwind.

Thanks,
Zhang Yunfei
