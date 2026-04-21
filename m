Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8967028371
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 10:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776768342; cv=none; b=Jc7GHsOhCqVIV4vYRRm2UoUZclD4ct7oS79u7UXlem4Z8Dar/ylh/vBfxq+38uTOZllMrZn8CFPXdMJfoGP01K4LjjVrCBWUA1N9RhZM6wLNCrP1XgdXAapecbggpgrAQttprCeXaYIaClV7x0G55cU7ru0pK+GzuMrukJq0DrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776768342; c=relaxed/simple;
	bh=BY8MWcsb2oZBqrb75F25sZ5/T75cQ0WZCAhrjVP7rFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A4DDBrJCByRg26a4D/OtZjpx23ecsm5PoFs1OSVemEycXSqs2GpcK+iMMhc7+g6qrClMid/cml2NLgTkMTi201y2pA3Nv6jHHxhxlchWVteIc88w4yQwVoDSG8CxByN+neUChbPnKCF89g/HsnlhzJ552twk3jYxb0h2ZUBLh2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bUaAztzC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bUaAztzC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776768340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BY8MWcsb2oZBqrb75F25sZ5/T75cQ0WZCAhrjVP7rFk=;
	b=bUaAztzCtN+XLI9Wiwu33IdcYiGzBGg7B1XN5cCysYqPOJhfjHd0RFOseHrjUKPMQ1CbAb
	znkt5gYNabNVt4jSl9sPimBGTuNo5peJPS+RUxSj5JbtNvyF/Hq31gDKCpE2eqKTac+4wy
	BABRwHiv6CfGAIaVD/QbDV4bJQwI7Gs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-_I1oxavfMQyLka5E9CFIDg-1; Tue,
 21 Apr 2026 06:45:37 -0400
X-MC-Unique: _I1oxavfMQyLka5E9CFIDg-1
X-Mimecast-MFC-AGG-ID: _I1oxavfMQyLka5E9CFIDg_1776768335
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9EBDD1955DE2;
	Tue, 21 Apr 2026 10:45:35 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.68])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DC2FD3000C15;
	Tue, 21 Apr 2026 10:45:31 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: przemyslaw.kitszel@intel.com
Cc: anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	intel-wired-lan@lists.osuosl.org,
	jtornosm@redhat.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	stable@vger.kernel.org,
	horms@kernel.org
Subject: Re: [Intel-wired-lan] [PATCH net v3 3/5] iavf: send MAC change request synchronously
Date: Tue, 21 Apr 2026 12:45:30 +0200
Message-ID: <20260421104530.103328-1-jtornosm@redhat.com>
In-Reply-To: <d04d7827-f990-45ac-aadb-4079ab270159@intel.com>
References: <d04d7827-f990-45ac-aadb-4079ab270159@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hello Przemek,

Thank you again for your comments, I appreciate your help.
I will try to include the new ones too in the next version.

I am also trying to analyze the comments from Simon with his AI review
tool.

Thanks

Best regards
Jose Ignacio

