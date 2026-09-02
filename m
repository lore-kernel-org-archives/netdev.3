Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5552217648
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 00:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788309229; cv=none; b=sdFq2zwyLgxr02bp5znqBytg8XJQA9isb1MBPChx8CwhR38WGddi023EX8I5lpXEAxzN4yv1UKO+imwHcomvzeewE4mEtqPYCtsCqVh9TTKfq/tlytAyIWUtVUy05RPB/dRpWuPfqo7Cc3cVRqCyM6sAuOPPRDrnoRXcU74g7gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788309229; c=relaxed/simple;
	bh=D6TohYiFW4lOnT8eEjY46+NuE3CAxgdkxwda83XCUZ0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=sSI13VFMVfpCjf4sS/LlzRgTVs5naBUpf2HzsJI74veCvU3/E7B1WjoTdw21egamI9xjCTxueHudYadb4udhr6h6wDRHPE5T/+t6y6l3SNhUdbB4Py33ohx/g402quv4e6XPr6PsUSXGtn4PN85GZJqSey320lc/GkLBr+GDvrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H/KNwT+l; arc=none smtp.client-ip=209.85.160.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H/KNwT+l"
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-52fb2a46cb5so11781371cf.3
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 17:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788309227; x=1788914027; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=O18ooVhGIftn67UgCjW5AwXaqlyfo+1zgjbl8OD4fJA=;
        b=H/KNwT+ltrDUrhnH5ZYtV55qIixIeCftnorR+fPe1kbI5NTdSaRmSQ79TcM5hlnB4x
         +SpoGViaCyYe3oXm1jp89EKpmJGUbucwP404yfDTLblYBuxkT3zgaJwfI6lygH0Bo8Ei
         wpY73rX6UKCGdCsXYcUPE05k/9ag+t4aPoX8daOrWRSkJ2oECeB3RwhdPZEDKT2xcRMN
         IHCctgyJlji5B2gGcSv9HUNhHyPSVpb2OlV4NAwfXa/Y04XidDa6m7SU9fqGTHg6yFPC
         6C4Gjm+4lMFzXGurb/Ey00XFVApmc2WVNW3J6J9EHQ9rcdlSOsC5TV7zdTcxGnsDoGLk
         Q+5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788309227; x=1788914027;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O18ooVhGIftn67UgCjW5AwXaqlyfo+1zgjbl8OD4fJA=;
        b=Ur5V/4Esm0K0QbS1EfJkItNimGJG+VS6SDWoHyxbY10TWj/FOBFkk3jpDgn6/hNFRO
         d0/TRKBwgwzU/hF6/2x6a+MPvuXBgNx1GngXwxfhj2c7aa2WmPdiCa9ZCqMidUrMeQVy
         2ETwUmX1a+H1mwg49o/cIb+csqd/D/CVF9uLTSTqwgj3Ex9OfkdRDy/EIv5XmWvkj/No
         l9LL5EbbDKD5E4sI6z4jYPjqMG4uin4UwvIEwnHwxk1uVSjrPvK8T1r+K0aP4aMI6/fz
         Rb9Gxjb53RUq1JXZNn+HRYLYYvQu5+vyiodFynu7b99b+riAezzfeSgBpsP6J5xn87mI
         IiPw==
X-Forwarded-Encrypted: i=1; AHgh+RpNEfLG9GPgg0SQhgB2QO7PRf97PtjAmld78gzUEkLg49/zU/pPLMd4CCPT68xY3QfZPxVPl84=@vger.kernel.org
X-Gm-Message-State: AFuF++kDDUQZTKOgIdgP4Cgakt4kPLtmPMS1azUeN/JK49J7hY0SLW0K
	F7flxOxS1WUMDpWXcjnjqd9KQr/oSKoESIqt4aaY4VwNhifSO6eYce0Sv5gJlqaDU07QinJ2skb
	57b6CEs8Sm3OKHg==
X-Received: from qviz17.prod.google.com ([2002:a0c:d791:0:b0:8dc:18c1:5c77])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:579a:b0:52f:bb67:8e42 with SMTP id d75a77b69052e-53036bda450mr13298701cf.9.1788309226532;
 Tue, 01 Sep 2026 17:33:46 -0700 (PDT)
Date: Wed,  2 Sep 2026 00:33:34 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.966.g6673acef38-goog
Message-ID: <20260902003344.1931843-1-edumazet@google.com>
Subject: [PATCH net-next 00/10] net: remove skb mac_header assumptions in TX
 paths (I)
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

In the transmit path, network drivers should not assume that
skb->mac_header has been set.

In the TX path, skb->data points to the start of the L2 header. Using
eth_hdr(skb) or vlan_eth_hdr(skb) when mac_header is unset reads from
skb->head + (u16)~0, leading to out-of-bounds reads (flagged by KASAN)
or triggering DEBUG_NET warnings.

Commit 96cc4b69581d ("macvlan: do not assume mac_header is set in
macvlan_broadcast()") introduced skb_eth_hdr() (and later commit
1f5020acb33f ("net: vlan: introduce skb_vlan_eth_hdr()")) to safely
access L2 headers in TX paths via skb->data without needing to call
skb_reset_mac_header().

This series converts the first batch of 10 network drivers and virtual
devices to use skb_eth_hdr(), skb_vlan_eth_hdr(), and
skb_checksum_start_offset() in their TX paths, and removes now redundant
skb_reset_mac_header() calls.

When all drivers are converted, we will remove skb_reset_mac_header()
from our TX fast paths.

Eric Dumazet (10):
  bonding: do not assume mac header is set in ALB/TLB tx paths
  atlantic: do not assume mac header is set in aq_ndev_start_xmit()
  ibmveth: do not assume mac header is set in ibmveth_start_xmit()
  net: mediatek: do not assume mac header is set in mtk_start_xmit()
  netvsc: do not assume mac header is set in netvsc_start_xmit()
  macsec: do not assume mac header is set in macsec_encrypt_finish()
  macvlan: do not assume mac header is set in macvlan_broadcast()
  vxlan: do not assume mac header is set in tx paths
  cdc_mbim: do not assume mac header is set in cdc_mbim_tx_fixup()
  ice: do not assume mac header is set in tx paths

 drivers/net/bonding/bond_alb.c                |  8 +++----
 .../net/ethernet/aquantia/atlantic/aq_main.c  |  2 +-
 drivers/net/ethernet/ibm/ibmveth.c            |  2 +-
 drivers/net/ethernet/intel/ice/ice_eswitch.c  |  2 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c     |  4 ++--
 drivers/net/ethernet/mediatek/mtk_eth_soc.c   |  2 +-
 drivers/net/hyperv/netvsc_drv.c               |  3 +--
 drivers/net/macsec.c                          |  3 +--
 drivers/net/macvlan.c                         |  5 ++--
 drivers/net/usb/cdc_mbim.c                    |  5 ++--
 drivers/net/vxlan/vxlan_core.c                | 24 +++++++++----------
 drivers/net/vxlan/vxlan_mdb.c                 |  4 ++--
 12 files changed, 28 insertions(+), 36 deletions(-)

-- 
2.55.0.966.g6673acef38-goog

