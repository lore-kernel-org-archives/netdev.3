Received: from ixit.cz (ixit.cz [84.42.129.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB4C57F72F;
	Wed, 23 Sep 2026 20:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.42.129.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790194776; cv=none; b=AqJayZLqqEbvPh9FuDmd1tpLJw7sjaE8hUrCVgnTWBfkdXzACsPL0HpthLBdksM7Z7b0I4hcSQVlanatgw9PbtxIjGLWtzOQyxBtdMAlryndDdEm09rg6l7gBfLGN47svRmQDoi4/BBDkhmGKH2QlMcAgoQRvsKue1RWHJKTAiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790194776; c=relaxed/simple;
	bh=jTTgaq8Jg0Us7MveAYFDhYn+JWGl/W2/BYk/ScSRMJE=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=EvgueSNehtdtfpYMVGiSY2UvDSKjg6dshlc5CuHA721wAHKyChJVf837GNuQIiXpZ4m7j/tzZk7JLT6o77oMDSo+k/4/mGXrXkSRjuOoUgykbiovspHUzi2xzJjYKibtt3qdRCYYuhfZxXUA7ax5M0Wy/uHfv47bJgUcwClQmvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ixit.cz; spf=pass smtp.mailfrom=ixit.cz; dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b=DggDRZbk; arc=none smtp.client-ip=84.42.129.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ixit.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ixit.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b="DggDRZbk"
Received: from [IPV6:2a02:830a:f787:8f00:d622:eaa3:3dd6:8f5e] (unknown [IPv6:2a02:830a:f787:8f00:d622:eaa3:3dd6:8f5e])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ixit.cz (Postfix) with ESMTPSA id 57FBF534081A;
	Wed, 23 Sep 2026 22:19:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
	t=1790194768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:autocrypt:autocrypt;
	bh=L+FndUAuUuEB3GBzTT3jgMIUGfofnLyhfCY6C8PSc9E=;
	b=DggDRZbkOqhJSiEnCnDfTFtKFGjLhwKBCkljGGfyFb99xP49pJD2eZr6sFdEuP/sQU7xJa
	d76HG0CpJO7e2yiImxe9mr9yDTOfzOJTdQo5x11qufxTUf6LaO+9TFMEvuVVW/B59b5znA
	rk5FeZKx9jnNmhUTcmG4lDL4sm9MojY=
Message-ID: <adeaccc1-cc04-4bb9-a28a-61a61d75ba14@ixit.cz>
Date: Wed, 23 Sep 2026 22:19:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, cs-CZ
To: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
Cc: oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
From: David Heidelberg <david@ixit.cz>
Subject: [pull-request] NFC fixes for net 7.3-rc5
Autocrypt: addr=david@ixit.cz; keydata=
 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
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

The following changes since commit fd73f4a6659897191fa0d40695fe370925dd3780:

   Linux 7.3-rc3 (2026-09-13 14:38:02 -0700)

are available in the Git repository at:

   https://codeberg.org/linux-nfc/linux.git tags/nfc-7.3-rc5

for you to fetch changes up to b61732f47316d45f27706db7812950145d3327b5:

   nfc: pn533: fix OOB read in pn533_acr122_is_rx_frame_valid() (2026-09-23 
22:13:18 +0200)

----------------------------------------------------------------
NFC fixes for net 7.3-rc5

Mostly security fixes.

fix use-after-free in nfc_get_local_general_bytes
llcp: Fix list corruption / refcount desync in nfc_llcp_recv_dm()
llcp: Fix race condition in accept_queue lifecycle
llcp: drop truncated I/RR/RNR PDUs in nfc_llcp_recv_hdlc()
llcp: fix -ENOMEM on connect with zero-length service name
llcp: fix WKS SAP hijacking via prefix match in nfc_llcp_wks_sap()
llcp: fix sdreq TLV list leak on parse/alloc/send failure
llcp: fix slab-out-of-bounds reads when logging service names
selftests/nci: Fix out-of-bounds store on thread join
selftests: nci: Correct pthread_create return value check
selftests: nci: Fix uninitialized family ID on missing attribute
virtual_ncidev: Add missing ioctl compat handler
nfcmrvl: validate helper command length before pull
pn533: fix OOB read in pn533_acr122_is_rx_frame_valid()
port100: reject frames whose declared length exceeds the received data
st21nfca: validate ISO15693 inventory length
st21nfca: validate received frame size
trf7970a: power down on startup RX gain failure

Signed-off-by: David Heidelberg <david@ixit.cz>

----------------------------------------------------------------
Aamir Ahmed (1):
       nfc: llcp: drop truncated I/RR/RNR PDUs in nfc_llcp_recv_hdlc()

Aldo Ariel Panzardo (1):
       nfc: llcp: Fix list corruption / refcount desync in nfc_llcp_recv_dm()

Chaithanya Lagisetty (1):
       selftests: nci: Fix uninitialized family ID on missing attribute

Chris Gellermann (2):
       selftests/nci: Fix out-of-bounds store on thread join
       nfc: virtual_ncidev: Add missing ioctl compat handler

Cong Nguyen (1):
       nfc: llcp: fix sdreq TLV list leak on parse/alloc/send failure

Deepanshu Kartikey (1):
       nfc: pn533: fix OOB read in pn533_acr122_is_rx_frame_valid()

Doruk Tan Ozturk (1):
       nfc: port100: reject frames whose declared length exceeds the received data

Lee Jones (1):
       nfc: llcp: Fix race condition in accept_queue lifecycle

Lei Zhu (1):
       selftests: nci: Correct pthread_create return value check

Luxiao Xu (1):
       nfc: fix use-after-free in nfc_get_local_general_bytes

Myeonghun Pak (1):
       nfc: trf7970a: power down on startup RX gain failure

Pengpeng Hou (3):
       nfc: nfcmrvl: validate helper command length before pull
       nfc: st21nfca: validate received frame size
       nfc: st21nfca: validate ISO15693 inventory length

Ömer Mete Kaya (3):
       nfc: llcp: fix -ENOMEM on connect with zero-length service name
       nfc: llcp: fix WKS SAP hijacking via prefix match in nfc_llcp_wks_sap()
       nfc: llcp: fix slab-out-of-bounds reads when logging service names

  drivers/nfc/microread/microread.c     |   6 ++---
  drivers/nfc/nfcmrvl/fw_dnld.c         |  11 +++++---
  drivers/nfc/pn533/pn533.c             |  14 +++++-----
  drivers/nfc/pn533/pn533.h             |   4 ++-
  drivers/nfc/pn533/usb.c               |   4 ++-
  drivers/nfc/pn544/pn544.c             |   7 +++--
  drivers/nfc/port100.c                 |   7 +++++
  drivers/nfc/st21nfca/core.c           |  12 ++++-----
  drivers/nfc/st21nfca/i2c.c            |  29 +++++++++++++-------
  drivers/nfc/trf7970a.c                |   4 ++-
  drivers/nfc/virtual_ncidev.c          |   3 ++-
  include/net/nfc/hci.h                 |   2 +-
  include/net/nfc/nfc.h                 |   3 ++-
  net/nfc/core.c                        |  15 +++++------
  net/nfc/digital_dep.c                 |   8 +++---
  net/nfc/llcp.h                        |   1 +
  net/nfc/llcp_commands.c               |   2 +-
  net/nfc/llcp_core.c                   | 175 
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------------------------------
  net/nfc/llcp_sock.c                   |  65 
+++++++++++++++++++++++++++++++-------------
  net/nfc/nci/core.c                    |  10 +++----
  net/nfc/netlink.c                     |   7 +++--
  net/nfc/nfc.h                         |   3 ++-
  tools/testing/selftests/nci/nci_dev.c |  45 +++++++++++++++++++------------
  23 files changed, 289 insertions(+), 148 deletions(-)
