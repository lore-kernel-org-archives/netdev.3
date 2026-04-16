Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4D837883E
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 05:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776318715; cv=none; b=konzvSC6f5EfuINdjV9jKIAYlUvuY4pMCMm+bfFyif+BrBu/xboXQPcrkk3FLecsiFaW4qhF0RtFaqk95CyMchhvodWZoUvTfIZefEyHJpGpLUgGdJFcjMp5B1pwan2aMNycUixjgbvu4ar2MZNFR9gHtV1Mhem8zTAcu0yL0Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776318715; c=relaxed/simple;
	bh=S9WaNaQ/uFgsOFE1s6aD5beNTsaN2ql4WsVBGG/diHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CNLq8QL67oeu9bmphT1Y+jPZU3/pQgPvshFG/Uwte/r0DejkUuKa9RbmLR3LrT9a1FAGmkW8hlfiYyNcY+P21aKzl7UB8AwcFGxVfkLXKOhUhhRmr5oa4lu5S30HhgUl1r8CxwuyrDLv5K08WTfiryZf5EaS42DifGA6/sZq8Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=atVY+RKY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="atVY+RKY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776318712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S9WaNaQ/uFgsOFE1s6aD5beNTsaN2ql4WsVBGG/diHU=;
	b=atVY+RKYAFN6Ag5u8gqP5A5SOnMMwSVDQO9zefvUhhLPMOa53mc5VVmJ4ekXIIa4+uz+Mu
	Scn1VovFsgxXUV6UG1CmGRvFqIgZQqI8FsY14aefu5RZ1CfidJKW8mItXlAXcLMJHid5tz
	viQpaVASPtViFNjTNnUYlxwuK2ZTLn0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-j7N_kwrUPIi1B6AD2q453A-1; Thu,
 16 Apr 2026 01:51:49 -0400
X-MC-Unique: j7N_kwrUPIi1B6AD2q453A-1
X-Mimecast-MFC-AGG-ID: j7N_kwrUPIi1B6AD2q453A_1776318708
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F0CA218004A9;
	Thu, 16 Apr 2026 05:51:47 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.48.46])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7796030001A4;
	Thu, 16 Apr 2026 05:51:42 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: aleksandr.loktionov@intel.com
Cc: anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	intel-wired-lan@lists.osuosl.org,
	jesse.brandeburg@intel.com,
	jtornosm@redhat.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	przemyslaw.kitszel@intel.com
Subject: RE: [Intel-wired-lan] [PATCH net v3 5/5] iavf: refactor virtchnl polling into single function
Date: Thu, 16 Apr 2026 07:51:41 +0200
Message-ID: <20260416055141.19127-1-jtornosm@redhat.com>
In-Reply-To: <IA3PR11MB8986843CDCC4F6DC6CD015FDE5252@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <IA3PR11MB8986843CDCC4F6DC6CD015FDE5252@IA3PR11MB8986.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hello Aleksandr,

Thank you for your comments.
I wanted to link this patch in some way with patch 3/5, but you are right,
perhaps as a refactoring, better for net-next.
Anyway, I am going to wait for Przemek and
"iavf: add iavf_poll_virtchnl_response()" merge, after that I will rebase
and I will create another version of the series, dropping this for now.

Best regards
Jose Ignacio

