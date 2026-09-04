Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684613B5837;
	Fri,  4 Sep 2026 07:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788508094; cv=none; b=QxFoGmzi+7nQRYTnFoBPQdJIt314D796q0EncRnDo7olW85mMP2xNRVyNRSOKJ65pAXLOiyc8Mnc46D7tjCUUhva8aCXX0WPMf7H6g7/8DESN03hvDDgF/gF61nMKYMa7b1IPZlT/iCE0geqgGz4Psf8jYKmlBaTIzoIha8Lfzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788508094; c=relaxed/simple;
	bh=cXicb+6WFbyg0nQa6eIWsi3x59U76GSl9xN4Nx8RUAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aBKQ8Y2vuWZGZzOcSNMZMTwfuRl3BF71DIwXFZ2Ubw3EcKh4d2tz0Ie6PqyqaL0L2KSzVWbfE3a4X1UahFXDneDfCDiwazBWmMYVpugu8GT3y/q/8TxyZ/G2K0s/JM9kA90pAwE4/MRUDrWIK+2jLhJ9nL2KrtHuD9oSTaxvstk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=DiAwu5J3; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="DiAwu5J3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=cX
	icb+6WFbyg0nQa6eIWsi3x59U76GSl9xN4Nx8RUAs=; b=DiAwu5J3FeDobR2m7l
	Bl2ou0xl16EBGqE1MFmHgyfyYuWh1P+UOTI3/7zbFwnEzriHcen47hNhen2IPdTu
	bQp+YnabXtqGufXxchCD6rpsveahqY3eGYMvSsa4x0NL9E6LSKYgKAN7U6q3ThSe
	K0E0cfpL0WTTSXdI9MKfJnk8w=
Received: from sky.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wBXPyWUd5pqPaRUAg--.32109S2;
	Fri, 04 Sep 2026 15:47:33 +0800 (CST)
From: Junnan Zhang <zhangjn_dev@163.com>
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	liuhangbin@gmail.com,
	mst@redhat.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	sunshx@chinatelecom.cn,
	willemdebruijn.kernel@gmail.com,
	zhangjn11@chinatelecom.cn,
	zhangjn_dev@163.com
Subject: Re: [PATCH net v3] net/packet: fix network header offset for non-VLAN raw packets on VLAN subinterfaces
Date: Fri,  4 Sep 2026 15:47:31 +0800
Message-ID: <20260904074731.42652-1-zhangjn_dev@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178842152801.3394541.15512936705284584859@kernel.org>
References: <178842152801.3394541.15512936705284584859@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBXPyWUd5pqPaRUAg--.32109S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZF4DGrWftF4DGr4kur1rJFb_yoW8WrW5pa
	y5Jas3Jr4DJ3Zxtrn7tw18Xa1j9r4xC3W3WFWfGrWj9a15uFyFyryfKFW29FyUJ34xXrWj
	qr12qayYkF48Kw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUsID7UUUUU=
X-CM-SenderInfo: x2kd0wxmqbvvry6rljoofrz/xtbC7hVE2Wqad5XJFAAA3p

Hi,

The High finding from the Sashiko review is correct.

Commit 447cbe95ebb953 ("vlan: fix skb_under_panic and races when
toggling HW VLAN offload") is now in mainline (v7.3-rc1). It makes
vlan_dev_init() keep hard_header_len == real_dev->hard_header_len
unconditionally and accounts VLAN tag space in needed_headroom
instead.

With that change, a VLAN subinterface on a plain Ethernet NIC has
hard_header_len == min_header_len == ETH_HLEN, so packet_snd() already
places network_header at the L2/L3 boundary of the user-supplied
frame. The branch added by this patch writes back the identical value
and is a no-op. I applied 447cbe95ebb953 on my baseline and re-ran my
reproducer (virtio_net without NETIF_F_HW_VLAN_CTAG_TX, AF_PACKET
SOCK_RAW + PACKET_VNET_HDR over a VLAN subinterface): the failure is
gone.

On the Medium finding: the concern is valid. For a VLAN subinterface
over a with hard_header_len < min_header_len (e.g.
cx82310_eth, which sets hard_header_len = 0), the new branch would
point network_header at min_header_len even for frames shorter than
that, recreating the mac_len > skb->len state that 993675a3100b1
(": reset network header if packet shorter than ll reserved
space") was written to avoid. Had the patch survived, it would need a
frame-length guard (e.g. skb->len >= skb->dev->min_header_len).

My v1-v3 baseline predated 447cbe95ebb953, which is why the issue
reproduced back then. The patch is now superseded; please drop it if
it is still queued.

Willem, thank you for the thorough reviews on all three versions.

Thanks,
Junnan

