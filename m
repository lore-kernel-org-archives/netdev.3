Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9653398911
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 08:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777276803; cv=none; b=ePfcAFWlnMhMhc0mN1j04iLR68k0ilV8Bo63uARkVQv18baKajmSm8f1+lnjMXJprjePPRn6soDobPJPh8LtN8axwIPEt1l80923rPc4qToM+sTkG/dYFar7poDmE4/JlvJrvPt9KebvXOo/9kqbcDQw7CluKQe67b2SSlKwzFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777276803; c=relaxed/simple;
	bh=8muKc8/uv8ZwFs1HhIEKd2DGHtuHL4YiGE08g4+DiMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dsAoWuwTFYyaQavQMZhOEStcfKcNmzgwZGVEvpWRGP5pGaMA6Vu85NQ+2aNUHx2a7bSGBs0D0IcXbvkgRKxLL0U/Um9HYby1x/+NX/4jXW8kSleTUZArRePtLgtceoQZx0D2ttoaANaxfdj9xaKgeO7uiuVzKYomDDpi0NMe9d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=afK5TEj8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="afK5TEj8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777276800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8muKc8/uv8ZwFs1HhIEKd2DGHtuHL4YiGE08g4+DiMc=;
	b=afK5TEj8+duPm6USnvP8lG+aJRnfsBhrvxScGRVLA5yXjA0l1cOloITp9lvxMKDalROxlQ
	kwMa2ZqpI07JTCq0BcZiKCfYKqUSHrNoXTbZOSajcxeMR05lmgKQHTFy7IN5AH4cbsB8pw
	ZvzzxpFlqjqE8LXa94gM3FpheCS6jqg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-198-QMhenUDpPoqrWVabTYQnhg-1; Mon,
 27 Apr 2026 03:59:56 -0400
X-MC-Unique: QMhenUDpPoqrWVabTYQnhg-1
X-Mimecast-MFC-AGG-ID: QMhenUDpPoqrWVabTYQnhg_1777276795
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6C6221956046;
	Mon, 27 Apr 2026 07:59:54 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.96])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AF372180047F;
	Mon, 27 Apr 2026 07:59:49 +0000 (UTC)
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
	przemyslaw.kitszel@intel.com
Subject: RE: [PATCH net v4 4/4] ice: skip unnecessary VF reset when setting trust
Date: Mon, 27 Apr 2026 09:59:48 +0200
Message-ID: <20260427075948.870208-1-jtornosm@redhat.com>
In-Reply-To: <IA3PR11MB8986BB8F2B8FBA03679590AEE52B2@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <IA3PR11MB8986BB8F2B8FBA03679590AEE52B2@IA3PR11MB8986.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Hello Aleksandr,

> One more nit, kdoc should end with '*/' not '**/'
Ok, in the current code there are already some functions with headers
ending in '**/' and others with '*/' , the functions I have added or
changed the prototype in the series will all end in '*/' as you say,
in the next version.

Thanks

Best regards
Jose Ignacio

