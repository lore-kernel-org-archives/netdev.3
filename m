Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B183BE636;
	Tue,  1 Sep 2026 07:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788249181; cv=none; b=aqvmIKuQqTcfrQRZCgfrVRctkT79f0mbvEKEQY522hw/ZCTge9ws14+iw6gA0zIiQAtmWXRQTVvHtl0XIOBE64s/1SPs01pl/FhXk7tAivzTWroj1Z4vnDoJef28qshClM7J3RnsuvTp6Crsjr9s0XIP7m0rUDqSq2KMbMD+3XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788249181; c=relaxed/simple;
	bh=hL/XQOVhcpwJxaLDyfLduwot2HfVj4twuEV49mSg/hQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r5SZm85W/6X9+3SZw9lsaiUmPJMUqcHk4X3V0RW/j0JnJtFW2QAAzggwjnR/bVOpeikdqFVx7uHUSCO61FJzD4xBli0u4dckEQw3r1PS5ASamEdCqNYdsy7w3nw0+6zeeOQYAsdIs1Yae31K4T9LleakZiW2tE3bYbUifcLQvC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=lgDGvNnH; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="lgDGvNnH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=j1
	wX6j3KRN+jGC0a4HA2yiq8U30rykpl0nv7aozNAy0=; b=lgDGvNnH9+vnYpAJUy
	zhCY10RVLIAAO8ABxHjHwWGk2zJFrB/NuYRmdhJc3fHhJiIjBx7tE55TMewS2ycQ
	Kv/VXsaS1Q2L7x0/+UzQekk/G8e0xugD9CdaTESQXijPmZoZpd/zqFaHxfaAC7LH
	+ucMOUg2vLegwF/G/ND6sJIOQ=
Received: from sky.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDX9QoyhJZqMCC5TQ--.47153S2;
	Tue, 01 Sep 2026 15:52:18 +0800 (CST)
From: Junnan Zhang <zhangjn_dev@163.com>
To: willemdebruijn.kernel@gmail.com
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
	zhangjn11@chinatelecom.cn,
	zhangjn_dev@163.com
Subject: Re: [PATCH net v2] net/packet: fix network header offset for non-VLAN raw packets
Date: Tue,  1 Sep 2026 15:52:18 +0800
Message-ID: <20260901075218.58914-1-zhangjn_dev@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <willemdebruijn.kernel.2a4f4a498e1ff@gmail.com>
References: <willemdebruijn.kernel.2a4f4a498e1ff@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDX9QoyhJZqMCC5TQ--.47153S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KF18GrWfGr4kZrWDKrW5Awb_yoW8Cw1Dp3
	WUCFZrtrs8GF1Sqrs7XF47AF4FyFs5G3W3X3s8Jryvvws8ua4fXFWxtFsIkFWjqr4kJ34U
	Zr1UZFyakaykZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUasjUUUUUU=
X-CM-SenderInfo: x2kd0wxmqbvvry6rljoofrz/xtbC7hJtA2qWhDK1xgAA3r

Hi Willem,

Thanks for the detailed review.

> Where does it do this? validate_xmit_vlan does this on the physical
> device I think.

You're right. vlan_dev_hard_start_xmit() only attaches the tag metadata
via __vlan_hwaccel_put_tag(); the actual tag bytes are inserted later by
validate_xmit_vlan() on the physical device via
__vlan_hwaccel_push_inside(). I've corrected this in the v3 commit
message.

> That adds a bigger problem that the extra needed headroom of
> (hard_header_len - min_header_len) is not reserved at the start of
> the frame.

Understood. In this case it happens to work because
LL_RESERVED_SPACE_EX() rounds the reservation up, so enough headroom
remains in front of the MAC header for __vlan_insert_inner_tag() to
push the tag inside, and with the fix the MAC header correctly sits at
network_header - min_header_len. Agreed that disentangling the legacy
hard_header_len usage is beyond this bug fix targeting net; happy to
help test if you look at it for net-next.

> Instead of using min_header_len != hard_header_len to detect vlan
> devices, consider is_vlan_dev(). [...] So for now I would focus on
> the VLAN issue only.

Done in v3: the condition is now

	if (sock->type == SOCK_RAW && !is_vlan_packet && is_vlan_dev(skb->dev))

and I renamed is_vlan to is_vlan_packet to avoid confusion with
is_vlan_dev(). You're also right that the ARPHRD_ETHER check excluded
the other hard_header_len cases anyway, so I scoped the subject and
commit message back to VLAN subinterfaces.

> It sucks that we have to add another branch in the hot path for an
> edge case. Would be preferable if we can fix this in the vlan driver.
> But that will come too late for skb_probe_transport_header.

Agreed - the correction has to happen before skb_probe_transport_header()
in packet_snd(), so the VLAN driver xmit path is too late.

v3 sent as a new thread with a Link to v2.

Thanks,
Junnan

