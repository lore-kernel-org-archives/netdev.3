Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097A93F1AB7
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 08:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787127918; cv=none; b=ZKZfA6VqNIf+Q2w6TXLRkrIq7b/oTLiU+gZOdXZCKpGVyqrUWxljDyZ7+drZ9ZRvdMJ+u/cVhiJgwFb05/+NB6fVW6x9uJ5rwLY+gZNzak/CDeHn8M01zuBa3aFT/q66DdEokwZPo/xJYibBme2rDF3brUbthkEfuQ34JGyirPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787127918; c=relaxed/simple;
	bh=FIZe799keX6/87R98ipbyzIzZSidsesizsZyAD+2BMs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jGQiavJrQMN7va2B0Qu9i88wCZLjk8HlqyWbqEycbckjX04bPuKuDOPO8ACKrGtnm0VdHPLxmbR4Scrilmx/9qM6SMKy6A0u/znC7XR+uCtJra6wr5nrGgj10BZ2s+gDjPIj7YkBr9552aAJo/5U94R5SoX0vIiB4yvyAJCFgTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U5jyNpBk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U5jyNpBk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787127915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4I655Z8usTsABgDzcg+e8tOh9qDi1DnobFMKfs+spl8=;
	b=U5jyNpBkYaHQTaJKxYdhvjO24vw5x+cS5jgw8FbRtDtNx+zIYlyP9wkhNRsCm8TWEvnsQ9
	d8VJ/Y0ZKJOtTPANaXOwkTq/aGaV3LsC+wvW3kH9Fs1Y9UovoNBkLYjfSXe+fYGnNry0cS
	ZFYnzYuU16JGcB8dQc5KAhygKhFzkpc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-151-lhC8i2QbM3-0QiVi97DAxQ-1; Wed,
 19 Aug 2026 04:25:10 -0400
X-MC-Unique: lhC8i2QbM3-0QiVi97DAxQ-1
X-Mimecast-MFC-AGG-ID: lhC8i2QbM3-0QiVi97DAxQ_1787127908
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 58403195604C;
	Wed, 19 Aug 2026 08:25:07 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.22.88.187])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4B2741800348;
	Wed, 19 Aug 2026 08:25:01 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Kees Cook <kees@kernel.org>,
	Robert Malz <robert.malz@canonical.com>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl-net] ice: allow reading the last byte of the NVM and Shadow RAM regions
Date: Wed, 19 Aug 2026 10:24:58 +0200
Message-ID: <20260819082458.665947-1-poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

ice_devlink_nvm_read() rejects a read whose end lands exactly on the
region size, so feeding back the size devlink itself reports fails:

  devlink region show pci/0000:04:00.0/nvm-flash
  pci/0000:04:00.0/nvm-flash: size 10485760 snapshot [] max 1

  devlink region read pci/0000:04:00.0/nvm-flash address 0 length 10485760
  Error: ice: Cannot read beyond the region size.

shadow-ram behaves the same. The regions are created with those sizes, so
a read ending on the size is the whole region and has to be allowed.
ice_read_flat_nvm() uses > for its own Shadow RAM check, and so does
ixgbe, which grew its region support from this code.

Fixes: 3af4b40b0f2f ("ice: implement direct read for NVM and Shadow RAM regions")
Signed-off-by: Petr Oros <poros@redhat.com>
---
 drivers/net/ethernet/intel/ice/devlink/devlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
index 8c2b63eef82bd5..a52b6044288975 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
@@ -1953,7 +1953,7 @@ static int ice_devlink_nvm_read(struct devlink *devlink,
 		return -EOPNOTSUPP;
 	}
 
-	if (offset + size >= nvm_size) {
+	if (offset + size > nvm_size) {
 		NL_SET_ERR_MSG_MOD(extack, "Cannot read beyond the region size");
 		return -ERANGE;
 	}
-- 
2.54.0

