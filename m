Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AB3364EA5
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 10:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777026767; cv=none; b=riapW3uwQObKyhfPrQu1BCSYqG+irii6fHGkfowvmMWMJcwitdq2Q/lZb7UxdeEKWFpwEaVSDpygudaKZVZKLdbt2YZUVxhl++9omXvxjKr+OcrpkIbUB2/oLDisrBUTwqK0ZSqm0jFT5jHhMwA2ypc/3iPULKQZcDzelRiiB38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777026767; c=relaxed/simple;
	bh=FdOO5ZJKpunXt8R9oWk6B4rgl/tR+89ai4r1VJJ6pgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YjArQtEDVYSw2bl61gl1jJyPR9OweXHngyXc2+1ecLlSn2yytT8OGfgIZkZ3H4d/ltbwHIenttzT3ZSy83XK+6InbdvDya3EvHrMAHJYMg9eEcmC7az21qfOS7FJ2JojL5NkOKG/7M2XKdaZsc1XkKkYW1NDhb2AmLbzEAilNOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SmV9njz5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SmV9njz5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777026765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j8BpQcTU/HrFkQ0+UuHlyLaR2zAA5vDMBO2MGcO/oD4=;
	b=SmV9njz5Ccuknz8SZJc2EggTZmWIdO+TCnenqk0QBEKIzERC+SGBinSQca42h+nOj4LIAj
	cslWlJU/fTZAr73rP4VbQKFAZ2tuF+aAaWLYM5j0Bfcq0fqTnu3MDUdc2O+fS0+Rm3RE16
	BXl/A76t0FByEGEtKgHB+nV491tIXZI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-572-Bb_4hFO_PMqekvjZMqwVzw-1; Fri,
 24 Apr 2026 06:32:41 -0400
X-MC-Unique: Bb_4hFO_PMqekvjZMqwVzw-1
X-Mimecast-MFC-AGG-ID: Bb_4hFO_PMqekvjZMqwVzw_1777026759
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3576E19560AF;
	Fri, 24 Apr 2026 10:32:39 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.29])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0D9631800348;
	Fri, 24 Apr 2026 10:32:34 +0000 (UTC)
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
Date: Fri, 24 Apr 2026 12:32:33 +0200
Message-ID: <20260424103233.622318-1-jtornosm@redhat.com>
In-Reply-To: <IA3PR11MB89862412A9F682D59474841DE52A2@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <IA3PR11MB89862412A9F682D59474841DE52A2@IA3PR11MB8986.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Hello Aleksandr,

> For me it looks like  cc: stable@vger.kernel.org must be added
I am not sure about that, because the bugs fixed  here (vf->trusted
ordering and race condition) only trigger when MAC LLDP filters exist,
which is an uncommon scenario.
And most users will benefit from the performance improvement that is an
optimization rather than the bug fixes.
I mean, I included the commit fixed as a reference but due to optimization
as the main reason, I didn't dare to request this for older versions.

> You declare ice_vf_clear_all_promisc_modes() returning int, but ignore
> the return value.
> Looks suspicious isn't it?
Well, it is used like that when the funciton is called locally (the
function is not modifiedi, just made public), and really my intention was
to clean as much as possible (so error checking is not necessary).
In my opinion it would be enough to warn about the possible problems
(already done in the existing function).

Anyway, if, despite the reasons I have tried to explain, you still think
the same way, please let me know so I can adjust them (if you don't mind,
I would wait for more reviews to include them in a next version).

Thanks

Best regards
Jose Ignacio

