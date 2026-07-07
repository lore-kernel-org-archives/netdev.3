Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0568390C84
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 09:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783415478; cv=none; b=H2XiL3C8TdxpwxazdjqQmLe5igj3TXHgd+O8S5ajR+6OjcmIT0VYFV03ajhGamFO2KS/EeBJCTZK2tjeKEeoWvfIMo/t0HGmq/R8sW1OQYWKIOOGcKa1mEOjQIDRzsP1Xgp/xvmDUDlGGrqcJUX17Z7Tr/8YnuyQxYzc9NWu3L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783415478; c=relaxed/simple;
	bh=LcdpFlrsMeZN7QoWRQhK/cKX1hTenue3TaEEENYMPZE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tu67VWbv3SJkjlQMzEq4YZPHqiUWG/aNjZonK9iNWDks0dUuoG9YcA6pWFZXrGMCZPkSEypygdhTz/8e+FxbToHAwy7q3PL9/GlVZTAl9TgGdaxvUq520uSq7e1jzoxDJUjDNMbjD02abqVLU4Jy2vGKA99Wl9Kh2cErSjCvINg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V3aTbGnk; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V3aTbGnk"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-698e5859a3cso911275a12.0
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 02:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783415475; x=1784020275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m1RZuLSLPgvQmrHlTSn76qYj1An3fG36jxd15dXTQDE=;
        b=V3aTbGnko8cKDooffGgMKodaagWvuk5axuX+lvwpIv0Ueq6a1efEUeChyq55O4Aw1I
         3yx/cAY0ZMGDn+mZIdDMAVZ4BDywbKW4FBBVDnWzSL98EJw21isq5Kof+vsptiRhV+8q
         OX1NWq2Yt2qM3Lg159iEWinfp4r7yLTO3Wx9y7I8QGveAwcqJWyd64OVXxF/Y9YhuW1D
         TxKGnUeDINPK5zjkETCaNnrrs9IfDpStWsWdSj5vKIqWbnUewBKG99e1KgYg8D8tx9MU
         vOv9F0HXPM64SBBOXq8nwcJ2u9o7pvVCNmTmkNXn6OJsyuyjIiyAnba1mnL4YD3Zgtsg
         lYhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783415475; x=1784020275;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m1RZuLSLPgvQmrHlTSn76qYj1An3fG36jxd15dXTQDE=;
        b=dtp4arlFyblxYcRk6Rp4vqzGtYwSRcrMfPLckX/45xMwyogAmUfeTMT76gisXnwPN0
         skUtV46f3qhsTYnGj68PmpFTKopX+BIfVTX/RdQUkpd/jckn0RpgR5I7f+hGFzN9yQ5l
         Zc0W6KShNNM0FoKOnhLZDhijBhyeJ/LXl89usDX0Gaso+WPnGDVSXdjZFtQSwKpagMk0
         i7j6OJqFdsfCnsELHyCjVj3TsNElqNno5O1tMw/TJsZ3bbEIjwFAMQF6DFCYvhcAo1gA
         0GOcsJVMLYIAtfROXpfnfw2uaJbCOVK34KgM9FsXgEDKOUPrBLfufFrOSqe19p+pN23S
         kagw==
X-Gm-Message-State: AOJu0YwmaYd1C5B8/49dAoBVK+y1D/IvwI8uf4jj5voXkJ1tg0aghYHo
	qzMB9M2k2cmt2C/xl+hpvONXZEOXDBy2hU8vOEZmizjBKq7C7L2Umy9b
X-Gm-Gg: AfdE7cm0wFQEnJWlO5nRU+tBCQ1l80PNhh2TIfCoWmNnPP+qgl51eKzLVyiTa7LAK3A
	5/f9tWHm/ZOnrSsCnvQDBijhPNgiq1wALtN+qwQnjekPRIWOcSO9SBqA8XFsFrAfoM3T0oilGfd
	9gbeeAte0VRdYhEKtUZDCmn+S/IpHLuC32oVfo4UczxNpWhXdDzD6UBf7mUqahpFqlmmLmK1gMp
	dPzWFOFxkyVt9xEPpe6NhU6KvmjZUx4eyo9yK09aZSdDeCtRAEzfxcm8pZ62zXGMayPufZUXzW2
	Kga4o2wdDv03SgOSpUhM9gVZeL/SvhAVQOE40L9sHGVk+u7unHi0DbAMxcUkO/v490vq1KHBGtJ
	oPdI1itBiyKxYw55OxsJWWijOKi0S3EULFolIr+BpyQGuzTFqOmeftODK8EpZZjhTDGfKyyf70t
	0s1Em0JaJV9q5Z5Mr7CBYCIs0MQqQ1raVmK6aQmI/O3iOrWULFFoZyhHrcPRwQ5S5PcoZQ/iest
	YFE8qDSjq+ZYn9zWBzM/V6XjiTzNR3/h/tSPMvMIcLQ
X-Received: by 2002:aa7:d391:0:b0:69a:3652:9d33 with SMTP id 4fb4d7f45d1cf-69a9113f5dcmr667742a12.19.1783415474861;
        Tue, 07 Jul 2026 02:11:14 -0700 (PDT)
Received: from eric (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69a19cd87d6sm5297152a12.6.2026.07.07.02.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 02:11:14 -0700 (PDT)
From: Eric Woudstra <ericwouds@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Stanislav Fomichev <sdf.kernel@gmail.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Krishna Kumar <krikku@gmail.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>
Cc: netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	bridge@lists.linux.dev,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v12 nf-next 0/7] netfilter: Add bridge-fastpath
Date: Tue,  7 Jul 2026 11:10:38 +0200
Message-ID: <20260707091045.967678-1-ericwouds@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset makes it possible to set up a software fastpath between
bridged interfaces. One patch adds the flow rule for the hardware
fastpath. This creates the possibility to have a hardware offloaded
fastpath between bridged interfaces. More patches are added to solve
issues found with the existing code.

To set up the fastpath, add this extra flowtable (with or
without 'flags offload'):

table bridge filter {
        flowtable fb {
                hook ingress priority filter
                devices = { lan0, lan1, lan2, lan3, lan4, wlan0, wlan1 }
                flags offload
        }
        chain forward {
                type filter hook forward priority filter; policy accept;
		ct state established flow add @fb
        }
}

Creating a separate fastpath for bridges.

         forward fastpath bypass
 .----------------------------------------.
/                                          \
|                        IP - forwarding    |
|                       /                \  v
|                      /                  wan ...
|                     /
|                     |
|                     |
|                   brlan.1
|                     |
|    +-------------------------------+
|    |           vlan 1              |
|    |                               |
|    |     brlan (vlan-filtering)    |
|    +---------------+               |
|    |  DSA-SWITCH   |               |
|    |               |    vlan 1     |
|    |               |      to       |
|    |   vlan 1      |   untagged    |
|    +---------------+---------------+
.         /                   \
 ------>lan0                 wlan1
        .  ^                 ^
        .  |                 |
        .  \_________________/
        .  bridge fastpath bypass
        .
        ^
     vlan 1 tagged packets

Note: While testing direct transmit in the software forward-fastpath,
without the capability of setting the offload flag, it is sometimes useful
to enslave the wan interface to another bridge, brwan. This will make
sure both directions of the software forward-fastpath use direct transmit,
which also happens when the offload flag is set.

Note 2: For complete testing this patch-set, see:
[PATCH v5 nf-next] selftests: netfilter: Add bridge_fastpath.sh
This mail also mentions other patches involved in this, some patches
already applied, some patches are not.

Changes in v12:
- Added Note 2, refer to selftest script
- Added patch: nft_flow_offload_eval() check thoff==0.
- flow_offload_bridge_init() removed unnecessary call to memset().

Changes in v11:
- Dropped "Introduce DEV_PATH_BR_VLAN_KEEP_HW for bridge-fastpath" from
   this patch-set, it has moved to another patch-set.
- Updated nft_flow_offload_bridge_init() changing the way of accessing
   headers after fixing nft_do_chain_bridge().

v10 split from patch-set: bridge-fastpath and related improvements v9

Eric Woudstra (7):
  bridge: Add filling forward path from port to port
  net: core: dev: Add dev_fill_bridge_path()
  netfilter: nf_flow_table_offload: Add nf_flow_rule_bridge()
  netfilter: nf_flow_table_inet: Add nf_flowtable_type flowtable_bridge
  netfilter: nft_flow_offload: nft_flow_offload_eval: check thoff==0
  netfilter: nft_flow_offload: Add NFPROTO_BRIDGE to validate
  netfilter: nft_flow_offload: Add bridgeflow to nft_flow_offload_eval()

 include/linux/netdevice.h             |   2 +
 include/net/netfilter/nf_flow_table.h |   8 ++
 net/bridge/br_device.c                |  19 +++-
 net/bridge/br_private.h               |   2 +
 net/bridge/br_vlan.c                  |   6 +-
 net/core/dev.c                        |  66 +++++++++++---
 net/netfilter/nf_flow_table_inet.c    |  13 +++
 net/netfilter/nf_flow_table_offload.c |  13 +++
 net/netfilter/nf_flow_table_path.c    | 126 ++++++++++++++++++++++++++
 net/netfilter/nft_flow_offload.c      |  32 +++++--
 10 files changed, 259 insertions(+), 28 deletions(-)

-- 
2.53.0

