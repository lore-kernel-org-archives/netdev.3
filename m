Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793829675;
	b=ssctGcK2vFTH9urXTRlerfQuHw1RWdLufZ/ALMUunwFCBn9P8fnXa6gIacDMptizS3rZ
	 4JwE16XZFk4IYEd9q74VH43nlXqY63ZCRkviuVmhEoLnafOAODeVJpL39Ei3kY9qkLE2J
	 jxMj3GHF/yUC79wAT2sA+Iaq80vdz9sYB6lfIYTJ3zSc2DSi+SlINr4sBPqqrblQm5Zii
	 kJPQHc24LsE/5LJ7iKDjNLOKq3H5Wy+IMWzBrqUqUkuG9dpwRIQgC19C7JaWD7IJJ8uiQ
	 IN6EQ5wMWneT+rNZL3domfNV/V9BwivsbY3Xx2brUCKicTgjZ+b6SdTueVRb0hVLy+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793829675;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:MIME-Version:Content-Transfer-Encoding:X-Scanned-By;
	bh=w9CdwPErUt55SviF3rKSmqb1tl8IBDbw/57AfeFpaXU=;
	b=PSRfQHsiq1cekGHyvmJWvpK8fc60iiLechu3EGfdoPa3qn+3/joy8aq3dOCdWz1zJ6pW
	 CU0KE2VkNFDWI9WlrMoIVSJl1Yt5HXnIeobwznBO+InLIY3833phPeyBaOMKxPh61PxQ3
	 AV634Igo4EVI74X/8hEkrunDX9OeIQBw27xtj1AV1XBgtxHDe3z9Jlt/OnIsxPCaa/lfR
	 4NBrdoQA2q1CZa8CRNE86DiKUo8mzEsG9pJ9Dofe59y7dM33QV69SL1nthabV5C17+fbU
	 SIg5U7B9C7/ij8izc40q1heNhZNTS1SGm80wrk1ITw7m6jLrfvxpFnC830EMuq4rveA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PXKOc23H;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EDD606C587
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 22:01:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8EDD606C587
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PXKOc23H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793829673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=w9CdwPErUt55SviF3rKSmqb1tl8IBDbw/57AfeFpaXU=;
	b=PXKOc23Hk9VOovhUEfaQZ+AoaSAMC9HlQ14vlQEGgVR/Ax8ZXVYuHtNtFuswnDDTx9OL7T
	wPboaZGstSEhvknu/i9DsA3zlJBINnkgccplWBdkxZDuYE7/wy5E+j8iAy3oE9FTn2Xe47
	eZDyxXYEih5JkTwfdy7dpz3Kf5CxNvw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-538-nPOl_08aPTO2CdaX177x4A-1; Wed,
 04 Nov 2026 17:01:07 -0500
X-MC-Unique: nPOl_08aPTO2CdaX177x4A-1
X-Mimecast-MFC-AGG-ID: nPOl_08aPTO2CdaX177x4A_1793829665
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5F6A81955F1B;
	Wed,  4 Nov 2026 22:01:05 +0000 (UTC)
Received: from poros-thinkpadp16vgen1.tpbc.com (unknown [10.44.32.42])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 76C9B195604C;
	Wed,  4 Nov 2026 22:01:00 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Simon Horman <horms@kernel.org>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Mateusz Pacuszka <mateuszx.pacuszka@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl-net] ice: do not classify EAPOL MAC address as LLDP
Date: Wed,  4 Nov 2026 23:00:42 +0100
Message-ID: <20261104220042.1421735-1-poros@redhat.com>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

01:80:c2:00:00:03 (Nearest Non-TPMR Bridge) is also the 802.1X PAE
group address used by EAPOL, and the virtchnl MAC filter API carries no
ethertype to tell the two apart. ice_vc_can_add_mac() therefore rejects
it on untrusted VFs, which fails the whole ADD_ETH_ADDR request and
breaks 802.1X authentication:

[  128.447213] ice 0000:17:00.2: An untrusted VF 0 is attempting to configure an LLDP multicast address
[  128.447301] iavf 0000:17:11.0: Failed to add MAC filter, error IAVF_ERR_ADMIN_QUEUE_ERROR

Drop 0x03 from ice_is_mc_lldp_eth_addr() and treat it as a regular
multicast MAC. Trusted VFs still get the ETH_P_LLDP forwarding rule
through the other two LLDP addresses and the rule does not match on
the destination MAC anyway.

Fixes: 2296345416b0 ("ice: receive LLDP on trusted VFs")
Signed-off-by: Petr Oros <poros@redhat.com>
---
 drivers/net/ethernet/intel/ice/virt/virtchnl.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/virt/virtchnl.c b/drivers/net/ethernet/intel/ice/virt/virtchnl.c
index ca8018e3dd4288..27f0e1dee24642 100644
--- a/drivers/net/ethernet/intel/ice/virt/virtchnl.c
+++ b/drivers/net/ethernet/intel/ice/virt/virtchnl.c
@@ -744,8 +744,9 @@ ice_vfhw_mac_add(struct ice_vf *vf, struct virtchnl_ether_addr *vc_ether_addr)
  * ice_is_mc_lldp_eth_addr - check if the given MAC is a multicast LLDP address
  * @mac: address to check
  *
- * Return: true if the address is one of the three possible LLDP multicast
- *	   addresses, false otherwise.
+ * Return: true if the address is one of the LLDP multicast addresses
+ *	   handled by this driver (Nearest Bridge or Nearest Customer Bridge),
+ *	   false otherwise.
  */
 static bool ice_is_mc_lldp_eth_addr(const u8 *mac)
 {
@@ -754,7 +755,7 @@ static bool ice_is_mc_lldp_eth_addr(const u8 *mac)
 	if (memcmp(mac, lldp_mac_base, sizeof(lldp_mac_base)))
 		return false;
 
-	return (mac[5] == 0x0e || mac[5] == 0x03 || mac[5] == 0x00);
+	return (mac[5] == 0x0e || mac[5] == 0x00);
 }
 
 /**
-- 
2.56.0

