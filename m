Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794488287;
	b=lScd3muBHkVWl0bBjw0cB9rr1p8GvheoFKmRgBgz0xtgRQ56CIGIaa6WRVYyVwXSB6Jf
	 gpAwvS+mD0dDK7W6W+GfMo1tzYmr+Mrh/u0E+s8Lh2Wkqk2Ry6vz9MkwReSFB7OG3ICCV
	 blNdgXkRKARvuA9nu/C+/QjQOyJxaloCubejdc6vqd5tvdoFBNCUSaXY1im7Zw47LrYKx
	 uIULLHl70CD+GDOj2pTh3uw0Ngj9WTIJXIGdwFBfPjI014CJsU0etOLiavIGXOJDe77kX
	 1m/xrkJpNjCeUe60l6RzAXdKmLSx2nf+U/6Z02cRIfRrecHa5GR4T5JGoYjV9rU9vAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794488287;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=Ut3ReE3Vk4vAaBJQfJjNFGyMn7t9SYLhTR7Gn8ahrCs=;
	b=cCvpNcEWvibOFrKtMH7bf4elD8qp9HgI9bZMQ3PhnFcef8BZVQfbC+OUBITEX8kDDTMO
	 5UXCm3ZqutyN9LZsJiSo/1CYOSmS0o62N93gCMGZRHb7I5vSD8NCDDNE9Hypj15nYKN+Z
	 brl0xk4AVMQQhRdRD/h+e006EkgPnHjsNbvoDEIBOON35RjQLV6GOwVOug0oc76joMuu9
	 aAhoRv3M/h2j2mY/ScQ8z2PZOBtKwRga/DtN2fe5wsOupC3CY/XB0ifw/1Nkl9Sko0Lig
	 UR8EwyCdr8YBpJRD2BZcu5bRvUyLPvGXpe/lr3GjXukQZ9za5BNC+5x1D9fG9Jk6FtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dPTSXLDH;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B121606A321
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 12:58:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B121606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dPTSXLDH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794488286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ut3ReE3Vk4vAaBJQfJjNFGyMn7t9SYLhTR7Gn8ahrCs=;
	b=dPTSXLDHZovPz1XH8vdZrOMfuVFV7HGbjFDYYz5oiWzFQic+RYFyas0btetLk/zu6cVjTu
	bIWQ/yQczXDUzIbWq/ipYO/yvZo7woZl9OS0JRnDygswjplXdxGafkCZryUx8jGJ9nusrj
	uLsIvG0Hafk+nzFtZHIvCbPiMiZgCEc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-353-VjP4D6inOGSHC-VFb-6R5g-1; Thu,
 12 Nov 2026 07:58:01 -0500
X-MC-Unique: VjP4D6inOGSHC-VFb-6R5g-1
X-Mimecast-MFC-AGG-ID: VjP4D6inOGSHC-VFb-6R5g_1794488279
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8D0351953983;
	Thu, 12 Nov 2026 12:57:59 +0000 (UTC)
Received: from poros-thinkpadp16vgen1.tpbc.com (unknown [10.44.32.7])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 37F0A1956086;
	Thu, 12 Nov 2026 12:57:55 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Michal Schmidt <mschmidt@redhat.com>,
	edumazet@kernel.org,
	horms@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	Jiri Pirko <jiri@resnulli.us>,
	andrew+netdev@lunn.ch,
	jacob.e.keller@intel.com,
	jedrzej.jagielski@intel.com,
	anzaki@gmail.com,
	brett.creeley@amd.com
Subject: Re: [PATCH net-next v5 10/15] iavf: use new opcodes to request more than 16 queues
Date: Thu, 12 Nov 2026 13:57:52 +0100
Message-ID: <20261112125752.825409-1-poros@redhat.com>
In-Reply-To: <20261110141534.95614-11-przemyslaw.kitszel@intel.com>
References: <20261110141534.95614-1-przemyslaw.kitszel@intel.com> <20261110141534.95614-11-przemyslaw.kitszel@intel.com>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Tue, 10 Nov 2026 15:07:19 +0100, Przemek Kitszel wrote:
> +		adapter->rss_key_size = adapter->vf_res->rss_key_size;
> +		adapter->rss_lut_size = adapter->vf_res->rss_lut_size;
> +		iavf_init_rss(adapter);

This divides by zero when a VF comes back from a reset that timed out
and the PF reports a different rss_lut_size than before.
iavf_disable_vf() leaves num_active_queues at 0, and
iavf_fill_rss_lut() uses it as the modulus:

  iavf 0000:04:01.0: Reset never finished (0)
  iavf 0000:04:01.0: Reset task did not complete, VF disabled
  iavf 0000:04:01.0: Hardware came out of reset. Attempting reinit.
  Oops: divide error: 0000 [#1] SMP KASAN PTI
  Workqueue: iavf iavf_watchdog_task [iavf]
  RIP: 0010:iavf_fill_rss_lut+0x14a/0x2c0 [iavf]
  Call Trace:
   iavf_init_rss+0xfa/0x1d0 [iavf]
   iavf_parse_vf_resource_msg+0x7d6/0xeb0 [iavf]
   iavf_watchdog_task+0x8c8/0x2e30 [iavf]

Reproducer on an E810, two VFs of 0000:04:00.0 bound to iavf on the
host. Run a PFR every 7 seconds

  ethtool --reset enp4s0f0np0 flags 0x1e

and meanwhile, once a second,

  devlink resource set pci/0000:04:00.0 path rss/lut_512 size 1
  devlink resource set pci/0000:04:01.0 path rss/lut_512 size 1
  devlink resource set pci/0000:04:01.1 path rss/lut_512 size $((i % 2))
  devlink resource set pci/0000:04:00.0 path rss/lut_512 size 0

with the LUT of the first VF released again on every fourth round.
One of the PFRs takes long enough for both VFs to give up on their
reset, and both oops on reinit, as the PFR also took their 512 entry
LUT away.

Sashiko reported this for v4 ("iavf: divide-by-zero in
iavf_fill_rss_lut() on reinit after iavf_disable_vf()"), it is not in
the v5 changelog.

Regards,
Petr

