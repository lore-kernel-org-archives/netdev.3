Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649E547CC69
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 09:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782985414; cv=none; b=NmMUZXSsAh7gENqaaawIxpDoIvKSDSIUG4/mzYHaxAQO14Zv/UIOw3QdUdDXCw7fKg2Kcf+SznkEKWd+KzBmhkTaf89sJc5IJ4X06WOdTuKN/ONVtsN3hdNeQWe0WeQBS5IDaIPJqKMugeZs0C0x+V+r8tKf7pMszl4qIV8XtQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782985414; c=relaxed/simple;
	bh=pOdAUpTY7VdmO2zJNJlQhA/y5rutGS8uz+Zk2m3/oWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D39lZ8M/tPahfOfAJ0hdI6QeWY5P/R9JRIXsD5czdNW/0klxA4WPUoLImwcFfY+Xc3rh8Ef7hevF4KwMUNtHdvHLLxy3x/Ng0kApzBY/UUqUF/xCXawkDrSEmiX6Gy+wY2JunsBGQKRsh6oc9waNJwKkWIahyriYhWTPWe7KpVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K+3aqqNI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K+3aqqNI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782985411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=roDh6mmUlFNcXrwzbI7m0CnSSEDydvq2qq6/HQSOpdA=;
	b=K+3aqqNIH/M3ZgiMibyg370T5s43MXACJ4Z/J5x5H0LpB5NkbKhs4cm60EiaaY1egjdw8M
	HsWYKQi/o6d3f/rUhjsBNpmG/QGkmeCmpDsfUUBOVQZYPY26Z5fZqVej8emXpza3M4Aq27
	b+FQ0OoT87AglymRg0bYeEVXE3zrsxE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-389-HWyScGX9NYiq9_nwQY3OnA-1; Thu,
 02 Jul 2026 05:43:25 -0400
X-MC-Unique: HWyScGX9NYiq9_nwQY3OnA-1
X-Mimecast-MFC-AGG-ID: HWyScGX9NYiq9_nwQY3OnA_1782985399
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 44B27195394F;
	Thu,  2 Jul 2026 09:43:19 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.48.252])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 17003196B0A3;
	Thu,  2 Jul 2026 09:43:13 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: illusion.wang@nebula-matrix.com
Cc: dimon.zhao@nebula-matrix.com,
	alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com,
	netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	corbet@lwn.net,
	kuba@kernel.org,
	horms@kernel.org,
	linux-doc@vger.kernel.org,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	lukas.bulwahn@redhat.com,
	edumazet@google.com,
	enelsonmoore@gmail.com,
	skhan@linuxfoundation.org,
	hkallweit1@gmail.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v20 net-next 09/10] net/nebula-matrix: add common/ctrl dev init/remove operation
Date: Thu,  2 Jul 2026 11:43:10 +0200
Message-ID: <20260702094310.111412-1-pabeni@redhat.com>
In-Reply-To: <20260630010718.4346-10-illusion.wang@nebula-matrix.com>
References: <20260630010718.4346-10-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

From: AI Reviewer <ai@example.com>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev/
---
net/nebula-matrix: add common/ctrl dev init/remove operation

This patch adds nbl_dev_setup_common_dev and nbl_dev_setup_ctrl_dev helpers,
plus matching teardown paths, and wires them into nbl_dev_init and
nbl_dev_remove.

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
> index 5deb21e35f8ef..8feae561d0f13 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c

[ ... ]

> @@ -38,11 +190,29 @@ int nbl_dev_init(struct nbl_adapter *adapter)
>  	dev_mgt->chan_ops_tbl = chan_ops_tbl;
>  	adapter->core.dev_mgt = dev_mgt;
>  

[Severity: High]
Does this initialize the common device components before the chip is actually
initialized?

If nbl_dev_setup_common_dev() configures queues (which accesses hardware)
before the hardware is brought up via nbl_dev_setup_ctrl_dev(), could writing
to those queue registers cause hardware faults?

> +	ret = nbl_dev_setup_common_dev(adapter);
> +	if (ret)
> +		return ret;
> +
> +	if (common->has_ctrl) {
> +		ret = nbl_dev_setup_ctrl_dev(adapter);
> +		if (ret)
> +			goto setup_ctrl_dev_fail;
> +	}
>  
>  	return 0;
> +setup_ctrl_dev_fail:
> +	nbl_dev_remove_common_dev(adapter);
> +	return ret;
>  }
>  
>  void nbl_dev_remove(struct nbl_adapter *adapter)
>  {

[Severity: High]
Are the teardown operations in the correct order here?

The comment in nbl_dev_remove_ctrl_dev() mentions that setting the driver
status to false triggers the firmware to clean up the qinfo registers.

If nbl_dev_remove_ctrl_dev() deinitializes the chip first, will the
subsequent call to nbl_dev_remove_common_dev() attempt to tear down the
queues by writing directly to those deactivated qinfo registers? 

Could this lead to PCIe master aborts or panics during driver unbind?

> +	struct nbl_common_info *common = &adapter->common;
> +
> +	if (common->has_ctrl)
> +		nbl_dev_remove_ctrl_dev(adapter);
> +	nbl_dev_remove_common_dev(adapter);
>  }
>  
>  /* ----------  Dev start process  ---------- */
-- 
This is an AI-generated review.

