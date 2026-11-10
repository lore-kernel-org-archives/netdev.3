Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794308474;
	b=4iD0mvVsPjOte5LHov96HcSMmdWDfpYjfYzMUPmtgPylPahcYZHFHk++YC3BfX8OMeJA
	 BM2AwXUlmVr3Ckxv6hPlFljkSlIrVyIAOVJEzFHm+vTc4zvtK9ke25qZTOpBJUCzNoOhT
	 /OxF1hIi75G9OyA3fbKW20TwTEniGDlc81aH513MNNzruLIwTrOnkn245lbURp6Lnd961
	 NyH5ZRDqt8FBzQX3a25hZNnw8mUAhakb2oE9pLASnisoRHUS3sRIg4I10Zj0jNlx4ikdi
	 yg7qECbN/VD7w+l+F8VywSiXYMcKvTVDBvn0RBVBB3Rifv+ziaM8I+HsnQImbvGujig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794308474;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:MIME-Version:Content-Transfer-Encoding:X-Scanned-By;
	bh=eQ0sTKRXqIglYDVA2bsnqe02ftTzAEaMRDPz1hLTZc0=;
	b=gei2DZkHbsc6fFulHhuU9BXngGnI2t39yoLejZXoXnijAAYiGA+V09HCAVvKKJyGxwEB
	 za8n7Qo2pK6WQmMRN1L1delKv4EOBQFPSVQ8kYrheDulCTc404lOgPQDh1liCCqhJfryn
	 VefrA5dRVhbcFLXq16cAKsC+MNlYA8B108X4eyFunbUHACThj0gRjcMFVq3x3Dez/XRda
	 57xP491HZ/AjPSNQxP9fJD5PrGwyrw5TQ9a9lMSgIr31TgLlL/bhC6k6pnxrgg55UAu8m
	 vTshKGhTU3UYlhGCrmyGVBJMSDtj07pXYFiUJcpRynymbf7Lvlqt2ftCUDXIz4nTV9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="db/KY+x0";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCE6606A31C
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 11:01:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8CCE6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=db/KY+x0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794308472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eQ0sTKRXqIglYDVA2bsnqe02ftTzAEaMRDPz1hLTZc0=;
	b=db/KY+x0oUi17mw3x2QJj6t8viIaW5vTm/X+CQe3Sk7Pq7eb19NokyPHoNqY9wfBq69xAL
	c3V/vXY3BUo9Zr4CPWpMv6mH0ggD41FklLJtHnNVfqSZNntOO71elW7u85ctiGvuSqvwj1
	sDVHCVWSRv12gfcNfpOG54/qUTdbkdE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-512-1pv4V7OdNhKUy7jfeDTrwA-1; Tue,
 10 Nov 2026 06:01:10 -0500
X-MC-Unique: 1pv4V7OdNhKUy7jfeDTrwA-1
X-Mimecast-MFC-AGG-ID: 1pv4V7OdNhKUy7jfeDTrwA_1794308469
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5B59818005B7;
	Tue, 10 Nov 2026 11:01:09 +0000 (UTC)
Received: from poros-thinkpadp16vgen1.tpbc.com (unknown [10.44.32.99])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0CBA739203;
	Tue, 10 Nov 2026 11:01:06 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Ivan Vecera <ivecera@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Petr Oros <poros@redhat.com>
Subject: [PATCH iproute2-next 0/2] dpll: do not fail on interrupted dumps
Date: Tue, 10 Nov 2026 12:00:59 +0100
Message-ID: <20261110110101.2155953-1-poros@redhat.com>
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
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

A dpll device or pin dump that races with a registration or an
unregistration ends today as a failed command with a part of the list
on the output. This series makes the tool behave the way ip does in the
same situation. The whole dump is printed and a warning on stderr says
that it may be inconsistent.

The handling is added to mnl_utils as a separate helper that a caller
has to ask for, so the other users of mnlu_gen_socket keep their
current behaviour and can be converted one by one later. The helper
only reports the interruption. Whether to repeat the dump or to warn
is left to the caller, and dpll warns.

Petr Oros (2):
  mnl_utils: add a dump helper for NLM_F_DUMP_INTR
  dpll: warn about interrupted dumps

 dpll/dpll.c         | 37 ++++++++++++++++++-----------
 include/mnl_utils.h |  5 ++++
 lib/mnl_utils.c     | 58 +++++++++++++++++++++++++++++++++++++++------
 3 files changed, 79 insertions(+), 21 deletions(-)

-- 
2.56.0

