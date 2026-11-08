Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794103611;
	b=JllJxqZi3ffBKPCwCIO2Hwwin/ZkSVwcQMVLKX4PdCVmGdOH2cAWcCaIf2eDkW+50DM8
	 B9nyO+N7+GgR+d1ab4rLASxDUGtZl05bzQ3wj9dDicpSSfU+bgP0JtloLeJr2XrvRBcK+
	 N7Gc/1T5CHKOndmqBr5MpY76FysidgQILj2NzZCO8pzVP0Dwjrj0lVmXmRyok3dxMEQOs
	 AL103yqZR3WIqctoIijBnmKE9YXL8jxKt0P9t+3n1w9RAN6v+vki53tSZEufBdzU8C8L7
	 Gml0Lipagko+YXH4whhs8g1x368W/d0WiFVGoxC6H3+vkhcN3sb2FgGeRa+MJBAEwng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794103611;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=aiRaC4SClDloiXf7Yez+ZyKTHNOd4SsXvN8IxBT1Ks8=;
	b=aHV9MXxS5oJqGqX+s8tTHR5B+jM7GZ/YzXc16iM4bDhd5NfZ71tk1WwgEDpvBpzCTUep
	 wUqSJhLZSxIzQlHZxLcVJLNw1DTDvKhXey0JtzOZq1BSVsv9BubZ6nuTU2nYz1nIba2Mf
	 spDdNlziToeZaeQU8wKnkMu65xEGGeJCaSp8XwsK66SYflXycoagQEU49A+kkJgYN6pXa
	 bi79znU+2anwA7lEuENjkdiio96EJgR2tQO6V/I8qrEyeBpRX6H4rpgUXDAh0X9HUJAdb
	 /ZEBJVTiYHlYVR5Dmkbdtq4TZCJBiz/S6o+3xe3MsBm39vL6Rp5l5FbZEVpgzuMc/Tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=NiY5kEPN;
	arc=none smtp.remote-ip=111.22.67.137
Received: from cmccmta4.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5F3606A31A;
	Sun,  8 Nov 2026 02:06:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B5F3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=NiY5kEPN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=NiY5kEPNk+czCIGYumRrQCOdMA4vrwBPF3mjebWTuHAOon/SZySx/DL1hNqj8dT6wpjWytluRU9SI
	 q0sb48ik8u6fabs8ZnmzcaEwPgoArPGS01JkHBblo1fCW3T2pEsnD3Q2ySWB3y/igR1LDUFwZ/Efbn
	 IfPUG3JRoEgj4vyU=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee46aefd93271f-593a8;
	Sun, 08 Nov 2026 10:06:45 +0800 (CST)
X-RM-TRANSID:2ee46aefd93271f-593a8
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from openEuler-24.03.03 (unknown[74.82.203.40])
	by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee56aefd91c07a-59adc;
	Sun, 08 Nov 2026 10:06:45 +0800 (CST)
X-RM-TRANSID:2ee56aefd91c07a-59adc
From: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	willemb@google.com,
	mst@redhat.com,
	jasowangio@gmail.com,
	eperezma@redhat.com,
	willemdebruijn.kernel@gmail.com,
	linux-kernel@vger.kernel.org,
	Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
Subject: [PATCH net 0/2] net: do not run out of frags in alloc_skb_with_frags()
Date: Sun,  8 Nov 2026 19:06:15 +0900
Message-ID: <20261108100617.23840-1-yanhaishuang@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
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

alloc_skb_with_frags() can fail with -ENOBUFS for a data_len that passed
its own size check, because it splits the tail into one frag per bit set
in its page count. With vhost-net + tun, a guest that sends a ~480-540K
GSO packet makes the vhost worker retry that packet forever (100% CPU,
device dead). Patch 1 fixes the split without changing any allocation
that works today; patch 2 adds a KUnit test that fails before patch 1.

Haishuang Yan (2):
  net: do not run out of frags in alloc_skb_with_frags()
  net: add a KUnit test for the alloc_skb_with_frags() tail split

 net/core/net_test.c | 24 ++++++++++++++++++++++++
 net/core/skbuff.c   | 14 ++++++++++++--
 2 files changed, 36 insertions(+), 2 deletions(-)


base-commit: 30c71476d842b094651bd7712f6c8ee8716147d0
-- 
2.43.0



