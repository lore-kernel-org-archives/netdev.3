Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8984E3783BE
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 10:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782125529; cv=none; b=mdJjVbUx165lpr/RmhrPebCjBz/Y7iMgO9cnPwBNi+SxiZ1jFZWsZ5U0madyYY9cDF8Oe8yovh5Mv1pv+RJOKcQluy9pKZfpnRS7k1IrKEgyKNZ6QBAF3yoH1n9ee3rKgQzKOAnX96FqxbKPSLgd7ntTOSswT3gXodWoWEfZcVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782125529; c=relaxed/simple;
	bh=dP7YOQdMFFWMe6SFbBqJUEKuKE6sG1VVyWa1eKmnmZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FWjNdt6deTm+K2cZd2YL31JT97uGLct2zGkh2j6P6AuVSdsqHOt9iWMcYgmiBI+rgMmBrDoqbBeIXcwRMQc7aFE5C83PMj78EhS5Pp7OR1jnbUfXbBKZ5A4JQrOiwb7at4+tLWIeZA08CNSy6s+DZ0OtXkQxY0of5clV/gx/9ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TB/Mxr1y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TB/Mxr1y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782125527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dP7YOQdMFFWMe6SFbBqJUEKuKE6sG1VVyWa1eKmnmZ0=;
	b=TB/Mxr1y2NlbnqUHoIlnV3XeBZXTJGGK4QN07ioN5zCRjMTOZFv0DN8KuFdI1MFZvvztVi
	pCnUnFsJnJScqsRgXERIWq1lp8YTV2+XSmJYMe65qiF4EOdAmVl9ol5i5WZEZrLs/p8zFL
	ME/XFQItOEl/UpzhG8lPuBajHBogjrE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-119-LNoohOtNOv2JJmqnfWRb-g-1; Mon,
 22 Jun 2026 06:52:01 -0400
X-MC-Unique: LNoohOtNOv2JJmqnfWRb-g-1
X-Mimecast-MFC-AGG-ID: LNoohOtNOv2JJmqnfWRb-g_1782125520
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B86B718005AB;
	Mon, 22 Jun 2026 10:51:59 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.91])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8DD96195608B;
	Mon, 22 Jun 2026 10:51:54 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: horms@kernel.org
Cc: aleksandr.loktionov@intel.com,
	anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	intel-wired-lan@lists.osuosl.org,
	jacob.e.keller@intel.com,
	jesse.brandeburg@intel.com,
	jtornosm@redhat.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	przemyslaw.kitszel@intel.com
Subject: Re: [Intel-wired-lan] [PATCH net v6 0/4] Fix i40e/ice/iavf VF bonding after netdev lock changes
Date: Mon, 22 Jun 2026 12:51:51 +0200
Message-ID: <20260622105152.24016-1-jtornosm@redhat.com>
In-Reply-To: <20260622103159.GZ827683@horms.kernel.org>
References: <20260622103159.GZ827683@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hello Simon,

> Unfortunately the Netdev CI was unable to apply this series cleanly against net.
> Would you be able to rebase and repost?
Sure, I'll rebase on current net and send v7 shortly.

Thanks

Best regards
José Ignacio

