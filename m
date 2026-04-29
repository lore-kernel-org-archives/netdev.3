Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8FD39099B
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 12:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777464068; cv=none; b=WL4dlBccucADsoxk7bJZu8bh7KtHMU6QA54t9oFIHdKPULa2li92CmSvxTlqcH9o2KlbpSQLQ6yH72xaM8oFStJMjJ5p/dASb8C5FWMXKHXTBVbkq1yxorLy8XNVqF9cYiUHXIlW3XuERkbmQRBe2z0mqcP/BCzJcviHKRUE+JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777464068; c=relaxed/simple;
	bh=itr8NWOHQ6V8gxzf86xpcySPtZbv4JBsseEIXm5Jbts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KmMKpAW48tqZ/bWLUhMqzjoHiNYi2VAfDiC7Zpe6fKqiZeBzQ8/f6JUGWixZN6uewgtyf2ssBjQynxYyGcg+9Oe6y7W3O3BsbFixMNUu5Hp4sgGwxj7zV2BsbLCDt4K8uxCB+BzEe+k7DEOyREtBl5d5OD1fb7DoJegLQqwINBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RnnXKcd4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RnnXKcd4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777464066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=itr8NWOHQ6V8gxzf86xpcySPtZbv4JBsseEIXm5Jbts=;
	b=RnnXKcd4cSlQ44bQIMP+PEI/llzE0Kqve0kImxTCXVOej74aPieK9dDeRP++mWFqv2gQt9
	DAgGOqd2Hk8WX0aWo5BaBBYSAesdaOjRfB0Yil6eDsx4LiLCOgqJEzAzTDDFdgPS/fxfbi
	IeixB0y1KImjl1UiB8kGcl3ffuYbFhY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-251-1K6ZWJ6kO1qRKGz_ssUZRQ-1; Wed,
 29 Apr 2026 08:00:57 -0400
X-MC-Unique: 1K6ZWJ6kO1qRKGz_ssUZRQ-1
X-Mimecast-MFC-AGG-ID: 1K6ZWJ6kO1qRKGz_ssUZRQ_1777464054
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4E300180036E;
	Wed, 29 Apr 2026 12:00:54 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.45])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 23490195608E;
	Wed, 29 Apr 2026 12:00:48 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: aleksandr.loktionov@intel.com
Cc: anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	intel-wired-lan@lists.osuosl.org,
	jacob.e.keller@intel.com,
	jesse.brandeburg@intel.com,
	jtornosm@redhat.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	przemyslaw.kitszel@intel.com,
	stable@vger.kernel.org
Subject: Re: [PATCH net v5 3/4] iavf: send MAC change request synchronously
Date: Wed, 29 Apr 2026 14:00:47 +0200
Message-ID: <20260429120047.218369-1-jtornosm@redhat.com>
In-Reply-To: <IA3PR11MB89861527E138BBA14FA907DCE5342@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <IA3PR11MB89861527E138BBA14FA907DCE5342@IA3PR11MB8986.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hello Aleksandr,

> I think continue at the end of the cycle is redundant.
That continue is intentional; without it, if timeout expires but there
are still messages in the queue, we give up without processing them. The
message we're waiting for might be in the queue and not a lot of messages
stored are expected.
That continue reduces possible false timeouts (because the expected message
could be stored in the queue) while keeping the delay minimal.
The timeout is really just an estimate, and I don't think it needs
to be very precise.

Thanks

Best regards
Jose Ignacio

