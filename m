Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794488266;
	b=DLpbpsaKOLoUS9yCOHUT7lY9YgoCMD5I78MyKPxwdVPjey/gRquT3WmMdzDo93a0ZFcT
	 LvuOY/J9mmuvj5afKYT2qZfXESaQ6+Il576EXsr8o7NxDklscuWrmuio0JcHGtsKgYVwJ
	 pRD00OhiFV4pS+kna+d1daYM4Xqx2P93YGXq3OuhyDOAFReD3MxJqt8f+eVfGwZ2GqGqR
	 YlI0Lnk4sGTBzyxTqn4fB8OgH/b5wOljc4KfeG/2ZO2YB8WqsenNKqK0w8YNkcobELTnf
	 GNQC2kvAmf9kIpUZH+nX+VpjdKKpzT9XdchmSP4s95ghg6i3EiekXMh4XME7dkxhMvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794488266;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=n7nmYV/nc2ZMfNHmsmsdo28BO75A9coZpYiy7AgO8pI=;
	b=pIH6sMlQAgIcO8kbeujII8yXnp6xW+wcSW2bO6oqN3W4HdsQsEZdjgR3uyx4c6cWFYgb
	 t7yl+V16i0/HGWJ0aHhYz4YbX8e8+30guPe6pH8UoP3kfNGhCw9y1CEKQvtlhI3Pp5oeP
	 FpNb5BwDmGbi5Y+G9U7MhHuojhkVjW3itZNdHvT0d1oloaW533pblzYpRd8JsZglRojpx
	 JuovwhRE5u83o+hvKqNbmpL926dtvYC1uT5QDq3M6/zc1zRRnTepYsrAB8myYcAXAZ+wE
	 IkNXMaKPrkxMzc4RvQQC19PLEd0QP3EpgLSnNFxYuwTkbYIpdgRMYjfzvA5w0kVtgXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FJU4xPqx;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FE5606A31C
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 12:57:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74FE5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FJU4xPqx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794488264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n7nmYV/nc2ZMfNHmsmsdo28BO75A9coZpYiy7AgO8pI=;
	b=FJU4xPqx8frRN9GYIKoh/TNlcuWnMuu7ShoZJpIU5P6+XoMYQZLH0XO6PxQDqleQVSpm6N
	1daJfNVrR/AiYW6Q7OcgCfdztTgEMm/x1jo6LVG2di1EEEKk+ja0olKhmADZJ/IRh0d4Qf
	JxL3d/WJlndFapSIhgUhLSM/dyCOJ3Y=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-219-AFvbz-msOrePvzTfCiByPg-1; Thu,
 12 Nov 2026 07:57:43 -0500
X-MC-Unique: AFvbz-msOrePvzTfCiByPg-1
X-Mimecast-MFC-AGG-ID: AFvbz-msOrePvzTfCiByPg_1794488261
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A86441955F12;
	Thu, 12 Nov 2026 12:57:40 +0000 (UTC)
Received: from poros-thinkpadp16vgen1.tpbc.com (unknown [10.44.32.7])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1A30F18004FF;
	Thu, 12 Nov 2026 12:57:35 +0000 (UTC)
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
Subject: Re: [PATCH net-next v5 00/15] devlink, mlx5, iavf, ice: XLVF for iavf
Date: Thu, 12 Nov 2026 13:57:21 +0100
Message-ID: <20261112125721.825296-1-poros@redhat.com>
In-Reply-To: <20261110141534.95614-1-przemyslaw.kitszel@intel.com>
References: <20261110141534.95614-1-przemyslaw.kitszel@intel.com>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Tue, 10 Nov 2026 15:07:09 +0100, Przemek Kitszel wrote:
> Thanks to Petr Oros for testing v4, both problems he has found are
> fixed in v5 (the first two items below):

Confirmed on the same E810-C, v5 on top of 6db9448a443a with KASAN and
lockdep.

An iavf built from the parent commit keeps its 64 entry LUT with
lut_512 and with lut_2048 assigned to the VF, across ethtool -L, FLRs
and a PFR, and iperf lands on all 16 queues.

16 VFs with a global LUT each and ethtool -L 64 on all of them: no
"Scattered mode" message, no NACK, no Tx timeout, no MDD event, and
every VF passes traffic. Only three VFs at a time got their 64 queues
though, the rest was refused with "only 39 are free in one range", and
VF 0 could not get 256 while the other 15 VFs existed ("only 231").
Worth a sentence in ice.rst.

One new problem, a divide by zero in the RSS refill added in patch 10.
Details and a reproducer are in my reply to that patch.

Regards,
Petr

