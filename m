Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.242
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794613492;
	b=wMStJbRFOPWUMTpIt9dtMaBaeVpIJUQL+KmNAj6YX4I//wcQNxuyC6t4iANAg7rx+cK+
	 GNGsKxRN/+Lo2mjO+AgozqPLNWsT9mkgUnH14EQiJP1HFWb2+yfbRHBcjyRfK5gbEBKlY
	 DXl9FQ4XMQl097EDY3IO64PlvzhYdlKIajCZE8ehIQIo0TwGVJQ8z+nLqGuTEtU4OmSqa
	 OARTxLvGlgNboGEXFUvL4kzheiroqzxU1ac076WNY0cxmbOvjcpaak9e8BNKV/EKpIFU2
	 zF+mNroDbzXjiIK84N+/JI6IimE+P3aAAlJv3Sdbvq1lv03kVKsVCn7ySNVk5DVJLrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794613492;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=sfSwd+E8hxZNGFEXtM/YBMJuQSoOay1IgE8bLxa0aoY=;
	b=p9UOYwQXDIftLoHWb4CYmL9zvI4qSCY9FD2ljX8SaBx986GcSvK5S4SLIwMJOe75xpDD
	 oG7NNrSj+Ojif/Ivrdk10lo4Hqxz/az0iVnAx3caOg8/H0NcL09wwHmyv4dk9gbjgHD/L
	 zIPa1WubepWNjNITrmvQI3HWY1gZsROD5mA0P9Ek6KX6n6LJvHJ+PEgXT8q0jhMbU53IP
	 F5X2dsL/6CN2fsKb/filRb1tZ7GKD/njmCnbW4yVpWpkYLFhCETUonBagX2bm5DMDLuB+
	 bBPkQtqXVEupf1MBApHNQSMt6B1c4mJnXosf5TMllqPTFso3662qraCKKdGFFaIQIsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foxmail.com;
	spf=pass smtp.mailfrom=foxmail.com;
	dkim=pass header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=EMvDeECf;
	arc=none smtp.remote-ip=203.205.221.242
Received: from out203-205-221-242.mail.qq.com (out203-205-221-242.mail.qq.com [203.205.221.242])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F60606A323
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 23:44:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43F60606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=EMvDeECf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1794613482;
	bh=sfSwd+E8hxZNGFEXtM/YBMJuQSoOay1IgE8bLxa0aoY=;
	h=From:To:Cc:Subject:Date;
	b=EMvDeECfLE7cvE7kdUR2aYZGWeN70rssobxE27OiFhNnXT32Zksy4i/7y+tY9JJtw
	 YHB66MjKMQRNHVRfa1xB7dmjJKk+NaC1MnqslugNDGppkSbBoc+v99PIrYvBtsaGnq
	 yOrPlPPxNVGN0Mdy8mm320JvmepBMf3wG0ohmryQ=
Received: from localhost.localdomain ([240e:3bb:3032:791:1c66:e624:37fc:2222])
	by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
	id B2594C56; Sat, 14 Nov 2026 07:44:37 +0800
X-QQ-mid: xmsmtpt1794613477tmeedlg0v
Message-ID: <tencent_D2451CD0D7B4B812CEBADB56DC722BC33406@qq.com>
X-QQ-XMAILINFO: N7NMbzIEsXzdiw2d/4uwoMFvoN/1Asv48GiXFyLkwGuWV6FBdpujzDocOVk57Z
	 2ZQ83Bvuow2SzNR7ptDGUmQhepe2ifxU7WoBUfrCQdkKus5iOtc8+cJaRSPuc3nRXEJo23at5MQp
	 d7gFUn0oIkw4DQkTX0TixlA8cZD7liRRERKrhw0NbFYWSY5UhyiLgkmbJ75eos1d6YPMELk5W9gG
	 k/drAVfy3WxxMVEIwbqsaiV5zAVxAKwuzWQqclDt1vmAPvWIxGHq9lb5pAsbQrhHWRvpTAq9BLCc
	 3x/ScKdfRWLE2QWhx3uAnju3EAIk4FQ4T4+tBgF4D6N3LYp2iuCvXxn38+/eusyvCeSO3B4dI5sB
	 oz2BgdERPgWMyQlTwmWwU/yAYwlddtr2weENUWiT5VKsL+keZCNBzUnfMRfKWewjvRdtht4PTe3s
	 /EySuIHUMGTaHesE1v6FinbV+qNVDjHaAbcfH+XdAEFlZN4P0oJV0EgLp6Mknuqyn3Cwv/DrcVl5
	 nxJ5OktnyYou33O/5/HBPw43SoRMBwj8Pq5sFTuUfGJ3eMMbpBbT7pOyJxxSTJEukJFLB8Nn7ZsH
	 P4Yi2/btI6qHyMTYu1KdNh66EftCKIZGyGOgVlevApGgJNrJs8wK3CS1+myP/wEcdhSLxU1fHTmc
	 xUdnzJIVpdWb3Rd/Euv0ciYHs95KVCAcvh1YZYsdWJu3t8G4OUIB+qH1V+LIYbnV8Cqxu6eD4QxW
	 wHG13OpyB2A5fHP4jvMDDxnGuOXrvaMYzKIYzBhFUk7p/vWHcIiEoCsgXJuTSoAE3bkUxB9Set+K
	 CJFNF/FWetdjHgbu0Z5F/tlAi6+lD1hAThcY6Xyq39W5kpUmP+Xz0/ELVKk7Tu09xuOySJSjBq+L
	 /VRSSxf3af16IVmGMF606XhLOYwqSIOnLeAd6zx7CzQqbbAPT5A7DakJzYImaGVgrkoTAuBz9ckf
	 Juiw3dozmdk/D3fdTMmi9M7baGSmVwKQiFLGO6hjql8sdfnVXIECTtwrPEGqJ4eRuUhmXZA+aBb0
	 +/hk1AIQeG1WYjFnYvbnOB1zTNH4X9pmRtaMeOVgRQXMcjeysw5o3byb/IrpNPZlYFqqNTpiKR0r
	 hB7iYEsJcixUnmD8n7FBbrbJ+mUckWjWS849ZvPGBoliVrf7djDXwjIUzkWrWFMzPCNQGt
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
From: memoriaru@foxmail.com
To: netdev@vger.kernel.org
Cc: daniel.machon@microchip.com,
	Steen.Hegelund@microchip.com,
	UNGLinuxDriver@microchip.com,
	kuba@kernel.org,
	memoriaru@foxmail.com
Subject: [PATCH net v5 0/2] net: sparx5/lan969x: fix RX ring stall on frames from inactive ports
Date: Sat, 14 Nov 2026 07:44:34 +0800
X-OQ-MSGID: <20261113234436.75276-1-memoriaru@foxmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
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

From: Zhang Hewei <memoriaru@foxmail.com>

The FDMA RX path on both sparx5 and its lan969x sibling stalls the RX
ring forever when the hardware delivers a frame whose source port does
not map to an active netdev: the inactive-port error branch in both
drivers leaves the FDMA software cursor untouched, while the DCB keeps
its hardware DONE bit - so every following NAPI poll picks the same
DCB again and RX traffic stalls on all ports until the module is
reloaded.

Patch 1 treats a bogus frame on sparx5 as consumed (free the skb, clear
the array slot, return true). Patch 2 unifies the NULL semantics on
lan969x: NULL always means "frame dropped, page recycled" (inactive
port or failed build_skb()), and the poll loop advances past such a DB
like it does for any other frame.

v5: add the testing status to the commit messages as requested for fix
series (patch 1 not tested - no hardware available; patch 2's
drop-and-advance form was verified on lan969x hardware by Daniel Machon
during review). No functional change since v4.

v4 lore link:
https://lore.kernel.org/netdev/20261113122429.26163-1-memoriaru@foxmail.com/

Found by code inspection; the stall needs the hardware to emit a frame
with an invalid source port, which cannot be triggered without hardware.
Review from someone with access to sparx5/lan969x systems would be
appreciated.


Zhang Hewei (2):
  net: sparx5: fix RX ring stall on frames from inactive ports
  net: lan969x: fix RX ring stall on frames from inactive ports

 .../microchip/sparx5/lan969x/lan969x_fdma.c        | 14 ++++++++------
 .../net/ethernet/microchip/sparx5/sparx5_fdma.c    |  8 +++++---
 2 files changed, 13 insertions(+), 9 deletions(-)

-- 
2.39.5 (Apple Git-154)

