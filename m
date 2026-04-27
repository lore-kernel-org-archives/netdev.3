Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A486D1AA1D2
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 11:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777289712; cv=none; b=DAzsQ9XhDyOPX41h2/Erj98tPIIti1l/FniR+aUQRF8ANEAF0Vg7WcXU/IsMOjgZ+NPDr3a1HtNb85twavttS9HUhPm1Bs7akK6SesGg10GSmN8OX5Dgv2CPJk52z7epvndrQg4ZO1Ja6XDOS/9v4LbpCZNv2i8Znwam+0Vclq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777289712; c=relaxed/simple;
	bh=zTmOBQOfI2cC6OKRMtTqpwmhqCYyPD1tqmAV3nNBJko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HFuQgtYMMclqow+FCOquw9gh6/Zy0+hBlFemEtKpg9+EcRT2zqwuEBFRVlxFQhSUNVttSr3oYquxEgFOHyMES90HLvh8mlbkQJWwFbHdWO1SC87sxdfg+oEm/W9u0hXZ5rfhMwex1SJZd7E10W0mApb50QwaB95FXV+xvgs5ozE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ccnRk3J+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ccnRk3J+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777289710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zTmOBQOfI2cC6OKRMtTqpwmhqCYyPD1tqmAV3nNBJko=;
	b=ccnRk3J+T4+UiBaoTOeyP65EOS56N/SmHAX6DT1A2dOq5vgYHlp5FhW/JAhJibGO3DWOvR
	Oytu5WyQqMxFJcv7vAs+M1cJHgw4ikhHn9ssfET1zYSN11l1IcCADeyudYwj6rtDX+l/37
	mO9KGb9/N3QYSG3Y/cHjanY1/6TKAFw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-217-5jr6GjTLMJ-8MlD7OXhyrQ-1; Mon,
 27 Apr 2026 07:35:05 -0400
X-MC-Unique: 5jr6GjTLMJ-8MlD7OXhyrQ-1
X-Mimecast-MFC-AGG-ID: 5jr6GjTLMJ-8MlD7OXhyrQ_1777289703
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 20CDF19560BF;
	Mon, 27 Apr 2026 11:35:03 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.96])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A457D19560B7;
	Mon, 27 Apr 2026 11:34:58 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: przemyslaw.kitszel@intel.com
Cc: aleksandr.loktionov@intel.com,
	anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	intel-wired-lan@lists.osuosl.org,
	jacob.e.keller@intel.com,
	jtornosm@redhat.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net v4 3/4] iavf: send MAC change request synchronously
Date: Mon, 27 Apr 2026 13:34:56 +0200
Message-ID: <20260427113456.1267171-1-jtornosm@redhat.com>
In-Reply-To: <d055ed86-89d9-42fd-a881-0384ebfd24f7@intel.com>
References: <d055ed86-89d9-42fd-a881-0384ebfd24f7@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hello Przemek,

Thank you again for your comments.
I will try to include the new ones too in the next version.
Indeed kdoc "Return:" was already commented by you, I will try to address
all the occurences now.

Thanks

Best regards
Jose Ignacio

