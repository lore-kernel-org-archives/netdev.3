Received: from ixit.cz (ixit.cz [84.42.129.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A3A3C09F2;
	Tue, 11 Aug 2026 16:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.42.129.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786465675; cv=none; b=WRzJ1KdUjtfGwlJoiXon7gRNAxbEWYq8yVCtGWSu4M/EqKJ7VrQaE9hHcDqf+MPLyTFBhUl06iN5Iz9C2o42i5hSAgJpQ7i4oJeAMhXNUR9wnSEcE50JnlJfqf/clthcLC2CF6OUs8HDoFr6+uQVc1Ooqqt3D6js4QakWAF7oWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786465675; c=relaxed/simple;
	bh=qVKeeqp08xO+94wBtHU9pJ3mCnVTi5EFtkRqtdsR9jc=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=BPoCRNnM0ru/MxJVF1w7mJSXOILgi6KyTFg3CnmYeOwubY9nStINHtBUIcm68zOfTvOFgVBC07ph8VDijkqgfjdglwcXrGv6DmdtSJcIOHavIrQXMBxyfFmyMMNCZtErXPFAphs8C9Ek2sYjeFBpMldTguM1uuomyJRpsOLCTO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ixit.cz; spf=pass smtp.mailfrom=ixit.cz; dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b=LViTNhhp; arc=none smtp.client-ip=84.42.129.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ixit.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ixit.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b="LViTNhhp"
Received: from [10.0.0.152] (unknown [10.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ixit.cz (Postfix) with ESMTPSA id 7F01D53405B2;
	Tue, 11 Aug 2026 18:27:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
	t=1786465670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:autocrypt:autocrypt;
	bh=khRRxb4sWKnRnDU17JqPgq8+LSMA/Ibvxy+lT48iRvQ=;
	b=LViTNhhp2Ve+jbiD2LGGNMRbMaGT9e95NjWV1mdDhWkQLrfi5HJr/VEgSMDswLGyQir2oj
	ET595J3qGvNK+PkIXKuVCwCpkUikb1dQq53NjkICViG3dfEO94qz+OPqpaLrl3gM0pY1j3
	qfwpYq33sRPXA9iyk9p3E8HqN6ePwBY=
Message-ID: <4bcd0efa-cd97-485b-a7ba-6db8e3c4d3dd@ixit.cz>
Date: Tue, 11 Aug 2026 18:27:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 oe-linux-nfc@lists.linux.dev
From: David Heidelberg <david@ixit.cz>
Subject: [pull-request] NFC fixes for net 7.1-rc8
Autocrypt: addr=david@ixit.cz; keydata=
 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
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

The following changes since commit db2ddb87143519e20a95aa36c60b36107b736a58:

   Linux 7.2-rc7 (2026-08-09 14:54:50 -0700)

are available in the Git repository at:

   https://codeberg.org/linux-nfc/linux.git tags/nfc-7.1-rc8

for you to fetch changes up to 25519469972ef57c3edb1805dabd6c5612b90211:

   nfc: microread: validate target discovery payload lengths (2026-08-11 
18:10:04 +0200)

----------------------------------------------------------------
Mostly security fixes.

nci: add data_len bound checks to activation parameter extractors
nci: fix double completion race in nci_data_exchange_complete
nci: fix out-of-bounds write in nci_target_auto_activated()
nci: fix uninit-value in the RF discover/activated NTF handlers
nci: fix use of uninitialized memory in CORE_INIT_RSP parsing
nci: free destination parameters when closing a connection
llcp: avoid userspace overflow on invalid optlen
llcp: bound SNL TLV parsing to the skb and add length checks
llcp: bound the connect_sn TLV walk to the skb
llcp: fix OOB read and u8 offset wrap in TLV parsers
llcp: read llcp_sock->local under the socket lock in getsockopt
llcp: reject PDUs shorter than the LLCP header
digital: Do not dump a NULL response in command completion
digital: clamp SENSF_RES length to the destination buffer
fdp: bound the device-reported read length and fix an skb leak
microread: validate target discovery payload lengths
pn533: hold a reference to the request skb during send_frame
pn533: purge fragmented skbs during cleanup
st21nfca: validate ATR_REQ length against the received frame

Signed-off-by: David Heidelberg <david@ixit.cz>

----------------------------------------------------------------
Breno Leitao (2):
       nfc: llcp: avoid userspace overflow on invalid optlen
       nfc: llcp: read llcp_sock->local under the socket lock in getsockopt

Bryam Vargas (2):
       nfc: nci: add data_len bound checks to activation parameter extractors
       nfc: fdp: bound the device-reported read length and fix an skb leak

Doruk Tan Ozturk (5):
       nfc: digital: clamp SENSF_RES length to the destination buffer
       nfc: llcp: bound SNL TLV parsing to the skb and add length checks
       nfc: llcp: reject PDUs shorter than the LLCP header
       nfc: llcp: bound the connect_sn TLV walk to the skb
       nfc: st21nfca: validate ATR_REQ length against the received frame

Linmao Li (2):
       nfc: digital: Do not dump a NULL response in command completion
       nfc: nci: free destination parameters when closing a connection

Muhammad Bilal (1):
       nfc: llcp: fix OOB read and u8 offset wrap in TLV parsers

Pengpeng Hou (1):
       nfc: microread: validate target discovery payload lengths

Samuel Page (2):
       nfc: nci: fix out-of-bounds write in nci_target_auto_activated()
       nfc: nci: fix uninit-value in the RF discover/activated NTF handlers

Xu Rao (1):
       nfc: pn533: purge fragmented skbs during cleanup

Yinhao Hu (1):
       nfc: pn533: hold a reference to the request skb during send_frame

Yun Zhou (1):
       nfc: nci: fix use of uninitialized memory in CORE_INIT_RSP parsing

Zhenghang Xiao (1):
       nfc: nci: fix double completion race in nci_data_exchange_complete

  drivers/nfc/fdp/i2c.c             | 27 +++++++++++++++++++++++++++
  drivers/nfc/microread/microread.c | 31 +++++++++++++++++++++++++++++--
  drivers/nfc/pn533/pn533.c         | 22 ++++++++++++++++------
  drivers/nfc/st21nfca/dep.c        |  3 +++
  net/nfc/digital_core.c            |  2 +-
  net/nfc/digital_technology.c      |  2 ++
  net/nfc/llcp_commands.c           | 18 ++++++++++++++++--
  net/nfc/llcp_core.c               | 44 
++++++++++++++++++++++++++++++++------------
  net/nfc/llcp_sock.c               | 14 +++++++++++---
  net/nfc/nci/data.c                | 10 +++++-----
  net/nfc/nci/ntf.c                 | 36 ++++++++++++++++++++++++++++++------
  net/nfc/nci/rsp.c                 | 42 +++++++++++++++++++++++++++++++++++++++---
  12 files changed, 211 insertions(+), 40 deletions(-)
