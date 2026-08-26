Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66A738F633;
	Wed, 26 Aug 2026 15:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787759992; cv=none; b=eBTnl252QMFb2xcJEC/kYauG/BZEiFYjv/9Z/dzR0Fex24T5wRVI4is8lrO+5BcVBOS+vU1OfWMiLkbseDNtlOYwW6832k60Nn2sK6PpNppQ4B6yGshlvOHhEJ90ZrxopdllBZeL5w3Kl2c6H19+yvJycYn9G8DtwAtIoZOefM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787759992; c=relaxed/simple;
	bh=C/j5JsOQuT9ioo9qkbgBTsuIi+HtFcKKahUZ/Q72Tm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bMI3hx+OTY0GGwyOh6bMaHew9VqNpw3ueizO4pXflzpagkUBRoZ0VJu3l5myFprjBypkGgD+pxu3NitFj/HChEku2q2rgZ5XjSMCO8R0DDsmR2/OmPPBC6RsbU5Gvw3ccCi5bm19CZ2swAnIvyyNXL0otqMxzwRRe1/jYgVHGKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=hp8ZtsH9; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="hp8ZtsH9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=0l
	74OhUqceJnGj4xl9NmQr5VfyR7MzAJ2mmS1+9Yg/Q=; b=hp8ZtsH98txM5iq3pN
	oCwlLezbMUjqRvbU3cInBK9+MCA6YWJcIInrWDX/UMPu33OQGnvn1fb0Lcr/uTtB
	KcA8EiA6krkGwyTUdcVW09zGJmOgHSfqm/KGWoq5hGcm8BzOK8OxRdaHFcpfoyit
	Belei59uC+44Ha7j8pGKtMTU4=
Received: from sky.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wDXx1o1DY9qlBl_Dw--.2963S2;
	Wed, 26 Aug 2026 23:58:54 +0800 (CST)
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
Subject: Re: [PATCH] net/packet: fix network header offset-VLAN raw packets on VLAN subinterfaces
Date: Wed, 26 Aug 2026 23:58:42 +0800
Message-ID: <20260826155842.37442-1-zhangjn_dev@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <willemdebruijn.kernel.388b632cadf16@gmail.com>
References: <willemdebruijn.kernel.388b632cadf16@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXx1o1DY9qlBl_Dw--.2963S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWFy7Wr1xuFWDKw4kXw1UZFb_yoW5urWfpa
	yYqF9xtw4Dur15tr48J3WfJFWjvr4fGa4UWFy5JrWI9FWYgFyrAFWftF4jgFyj9ryrXr1F
	vr1UX3W3uF4vyrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JU373kUUUUU=
X-CM-SenderInfo: x2kd0wxmqbvvry6rljoofrz/xtbC7R-QZmqPDT-sowAA3c

Hi Willem,
Thanks for the follow-up.
> Why is the real length 14 + 14 == 28?
> Where does the second 14 come from?
You're right to flag this - my previous mail used "base" inconsistently,
which is what made the "14 + 14" look unexplained. Let me redo it with a
single reference point.
The cleanest reference is skb->data after packet_snd() has set things up
(i.e. the start of the user-supplied raw frame). With hard_header_len=18
and min_header_len=14 on a software-offload VLAN subif:
  - skb_reset_network_header() runs while data is at head + hlen
    (hlen = LL_RESERVED_SPACE_EX(dev, 18) = 32, the HH_DATA_MOD-rounded
     headroom), so network_header lands at head + hlen = head + 32.
  - The SOCK_RAW branch then does skb_reserve(skb, -reserve) with
    reserve = hard_header_len = 18, moving data back to head + 14
    (= head + hlen - hard_header_len).
  - The small-frame skb_reset_network_header() at packet_snd:3078 does
    not fire for a GSO frame, so network_header stays at head + 32.
Relative to data (= head + 14), this means:
    network_header = data + (32 - 14) = data + 18 = data + hard_header_len
    real IP header  = data + ETH_HLEN  = data + 14 = data + min_header_len
So network_header points VLAN_HLEN (4) bytes past the real IP header.
The "14 + 14 = 28" in my earlier reply was the absolute offset of IP
from head (data-offset 14 from rounding + ETH_HLEN 14); the second 14 is
ETH_HLEN, i.e. the user-supplied Ethernet header. I should not have mixed
the head-relative IP position with a data-relative network_header - sorry
for the confusion. v2 will use data-relative offsets throughout, which
also matches skb_network_offset() and is independent of the
LL_RESERVED_SPACE rounding.
With the fix, skb_set_network_header(skb, dev->min_header_len) sets
network_header = data + min_header_len = data + ETH_HLEN, i.e. exactly on
the real IP header, so both skb_probe_transport_header() (nhoff) and GSO
see the correct L3.

> This is the hint that this is a vlan device with software VLAN tag
> insertion? Technically, it might apply to other variable length
> header devices too.
>
You're right, it is not specific to VLAN. min_header_len <
hard_header_len also matches Ethernet drivers that reserve extra space
in hard_header_len beyond ETH_HLEN for their own wrapping. For all of these, 
the user-supplied non-VLAN SOCK_RAW frame still carries a standard 14-byte 
Ethernet header, so its L3 header sits at ETH_HLEN = min_header_len, and 
pointing network_header there is correct.
The condition is intentionally generic, not VLAN-specific.
For any ARPHRD_ETHER device whose hard_header_len exceeds min_header_len,
a non-VLAN SOCK_RAW frame's L3 sits at min_header_len (the standard
Ethernet header length), regardless of what extra bytes hard_header_len
reserves for driver-internal wrapping. The fix points network_header at
exactly that L2/L3 boundary. This matches the existing
dev->min_header_len != hard_header_len check already used in packet_snd()
(the small-frame skb_reset_network_header path).
I'll reword the v2 commit message to describe the scope as "Ethernet
devices whose hard_header_len exceeds min_header_len" rather than "VLAN
subinterfaces", and drop the misleading VLAN-only framing.
I'll send v2 as a new thread.

Thanks,
Junnan

