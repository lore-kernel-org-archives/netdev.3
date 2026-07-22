Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC76361970
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 15:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784735503; cv=none; b=ualT+Z4y/bPuosh0b6kF6vZ1jhAJHpPhlVQ0xDK0m1YHJTtCCZXqomWKgRjwaYDs2E3Z18H3tEU6Bd4+QoltV8SE9IgKa2nWaPckZRNl2fhji+W1PCPUd2MfGRs/jW3i78aBj9k/z5kDAD9xaZLFovr/q7nWEvqo9xshnHne0fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784735503; c=relaxed/simple;
	bh=9TUR9cAGj2yXVRXJOEDiPIL4RjRfQnRMLgfAozGleC0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O99OqKuOTjO2PdC3RyTXuTfZ9UPbLTX0aKBFY1A7lm1BXhWtK6PODPcor5YcFWWCp8H7znuD7721DMS/Hu+elpVmAQWwijjSIEvoABjotIpRZZxjS7iZnKYHNaXsNFo3WCvwj+JDR78+VXpkmYypGUpgjkGA9jwOBq02fuKVqDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DqWgzw95; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DqWgzw95"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38dc69c74b8so10408710a91.0
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 08:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784735499; x=1785340299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bCDZjXcO9RglPEcAaNCtyWIuIizr1JjjqianyQEEqZQ=;
        b=DqWgzw95X4FtGF75tPxngRWUko5eJid6ZAsClCEvZ3EO+NzLzwvguNzkJKtdGN2Dfe
         n5dpa2F8QMWWo7kNJqeJb7pmkInl0LuS/HOvTIRir9vc9N+/0Z4sqyMpXh+vmoBBjgHs
         vD70quA+ozgXgUTEh65AWlGkMa+x0MVWN5PDYsN8DGB6NF0DMQZYueJZ0jI55os8r/cu
         cQYKtdv7giB2fgoQOoxwvUZDUggAu0odYZmFy1bCPv2nZvoywiClybfzP4Gs61FSfnU8
         6j94EM2/dCu/EONyqyShHvW63SmWVbVssiJLsPGSpuqJUvYIeGpmj9zdyYiq150hHWSb
         /+Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784735499; x=1785340299;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bCDZjXcO9RglPEcAaNCtyWIuIizr1JjjqianyQEEqZQ=;
        b=DirRMrBza8hx456pn+tXsqdBBKC7Bc4pBCWMCD38rHyBmIUOxhv4F5MxBPIofi3SoA
         s9pt17kXoT1hK9aTEaqzaHq764V3hU9UnCwgjQ/EhrMTN2XlErhrsXVfIfePiprFFe1L
         6Z7nfBY+GrQMXJbxNVVZZyFjVQ3yhavbPM0HptSVjqjpAtHnnt4Bk1ZXTnLc4fxYecA/
         00Kz4P2uKVTZMcK2AoE62nVMSuUKfap6R1k1BFeEcoaCBfvwNkdTTM6r5rBZLOsVrYsG
         NaJAO6EA+yJcanRSutxc9vGrky58YnIDVvQxGWFtWc5EC7V6LTPmKwI3u7dWjOr6KMDy
         fdVw==
X-Forwarded-Encrypted: i=1; AHgh+RqTqiJ7NawCJwH38O37BCLvqtWsW5+o9k3EZPFn5L+8SuKAX/8o1DpG86utjP+bWkhKBtddG0E=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk97aBLwuvqL8TY3E+DVWKGLWD46bDJcsPJGFhudignoYMNg9d
	eAqorkZvrph7YKeb9qPczOEakIAxIgK6tYR4S8gJIkQNi4ur40EwEJtI
X-Gm-Gg: AR+sD11BrbgAAlS7eazEVARXKmKthQv9U65o9nHV6vpLKi2aT2PrQI8zVNXiqm+mxiN
	B6maO5EGH1mARZHpJD9p7EqwifX8QqART/JpPIAgs3CZF47HjGUxIXL4GguffMY+gxXXwpHGl+F
	apDe5UEqN5cW2MWYwjgIr+eoWbKZeFb7lvdcuURqkahJC+7pXDv3pt568lg7gCZnyhe7SW4qCAg
	gTnB9s/cSEg38NUuohRBQ10p4WAjw49fLOWDfmircYoK1LJiu/kIbQ2s2Xgzs0IbXjW2tPIuAG3
	tlrBLojCqGvtVfMEgxkCd4wcP3e1VvFRCmKRgEAIIDDEAHVw6gmHNIJLvJYAG+TRzgMNlkmdyhK
	CRhfxnzCkz29482vPmCCQ2sWqkezPSWvj6WEvxONPHdgrkptiRhil1HuYf3b7YXqiP8ePAw//YV
	lYTtQXPywyuN00oSWN4X2rnMXKjuI=
X-Received: by 2002:a05:6a21:7111:b0:3c3:90e6:48b9 with SMTP id adf61e73a8af0-3c3ada516e8mr25985517637.66.1784735498774;
        Wed, 22 Jul 2026 08:51:38 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147df097e0sm11123125eec.17.2026.07.22.08.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 08:51:38 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Veerasenareddy Burru <vburru@marvell.com>,
	Sathesh Edara <sedara@marvell.com>,
	Satananda Burla <sburla@marvell.com>,
	Shinas Rasheed <srasheed@marvell.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Simon Horman <horms@kernel.org>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	David Carlier <devnexen@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v6 0/4] octeon_ep, octeon_ep_vf: fix RX skb frags overflow and page leak
Date: Wed, 22 Jul 2026 23:51:27 +0800
Message-Id: <20260722155131.2017597-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The octeon_ep and octeon_ep_vf RX paths add one skb fragment per buffer
with no bound against MAX_SKB_FRAGS. buff_info->len comes from the device
response header. A long packet needs about 18 fragments. That is one past
the default MAX_SKB_FRAGS of 17. skb_add_rx_frag() then writes past
shinfo->frags[]. Patch 2 bounds octeon_ep. Patch 4 bounds octeon_ep_vf.

Both drivers also leak the pages of a dropped multi-buffer packet. The
drop path unmaps each buffer but never frees its page. Patch 1 fixes
octeon_ep. Patch 3 is Guangshuo Li's fix for octeon_ep_vf. The overflow
drops in patch 2 and patch 4 reuse those helpers. They free their pages
too.

The drop drain length derives from the device length. It had no bound
against the ring. Patch 1 and patch 4 stop the drain after MAX_SKB_FRAGS
fragments. A valid packet never holds more. This keeps a bad device length
from running the drain past the ring.

v6:
 - octeon_ep: add patch 1 to free the dropped RX buffer pages, per Jakub
   Kicinski. The drop path leaked the head page and every fragment page.
   The overflow drop in patch 2 reuses that helper. The v5 cover deferred
   this fix to a follow-up.
 - octeon_ep, octeon_ep_vf: bound the drop drain to MAX_SKB_FRAGS. The drain
   length derives from the device length. A bad length could run it past
   the ring. This is defense in depth against a misbehaving device.

v1: https://lore.kernel.org/r/20260701112825.1653044-1-maoyixie.tju@gmail.com
v2: https://lore.kernel.org/r/20260702180518.2013324-1-maoyixie.tju@gmail.com
v3: https://lore.kernel.org/r/20260704061511.2350737-1-maoyixie.tju@gmail.com
v4: https://lore.kernel.org/r/20260706150208.2944898-1-maoyixie.tju@gmail.com
v5: https://lore.kernel.org/r/20260716063432.2908100-1-maoyixie.tju@gmail.com

Guangshuo Li (1):
  octeon_ep_vf: Fix RX page leak on napi_build_skb() failure

Maoyi Xie (3):
  octeon_ep: free the dropped RX buffer pages
  octeon_ep: fix skb frags overflow in the RX path
  octeon_ep_vf: fix skb frags overflow in the RX path

 .../net/ethernet/marvell/octeon_ep/octep_rx.c | 19 ++++++-
 .../marvell/octeon_ep_vf/octep_vf_rx.c        | 52 +++++++++++++------
 2 files changed, 53 insertions(+), 18 deletions(-)

--
2.34.1

