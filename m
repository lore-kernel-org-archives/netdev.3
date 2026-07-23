Received: from out02-fra1-mx.uberspace.de (out02-fra1-mx.uberspace.de [185.139.157.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB5444E65A
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 18:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.139.157.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784831236; cv=none; b=AmPz5+EICmzqRMVBdu2w+q7VUYFnYZQdrdstqKS3hFdQ03Sp9E9MSz1olcj9YQ4b9d0/arKuI5+uJ7KsniKLqRLHgrWr96P/zc20lsQisX8OX4vflSP2BSmcRrwWDifUsav+LAn/8S3WV2DuhwpE/p25VlzcxHw7kOtTwj928Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784831236; c=relaxed/simple;
	bh=SBo9/b5QI3fZwOSHTnC5dwKYUw3fBHlUhdmTdhVOxNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LzMHsQjNQek4vruxQgN6eCHrleR/nNqc6+V8USt6fyRkGtvo6EwLmgJySLPsTJJNm2jqhBlkeip6oIPAit0T7zHdm/4HlJb6+O4p+7Bj02Ga/SavsmH1gyyMRm29Qyu0lUZmFCu0dzLB8AgDT3ZLfMyq7nnKsBugGbPiFd5I370=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=plantwatch.de; spf=pass smtp.mailfrom=plantwatch.de; dkim=pass (2048-bit key) header.d=plantwatch.de header.i=@plantwatch.de header.b=AiXzWJkq; arc=none smtp.client-ip=185.139.157.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=plantwatch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=plantwatch.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plantwatch.de header.i=@plantwatch.de header.b="AiXzWJkq"
Received: from janus.uberspace.de (janus.uberspace.de [IPv6:2a0b:20c0:2000:62:be24:11ff:fe50:5107])
	by out02-fra1-mx.uberspace.de (Postfix) with ESMTPS id 378C7C0190;
	Thu, 23 Jul 2026 20:26:58 +0200 (CEST)
From: Simon Dietz <simon.dietz@plantwatch.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plantwatch.de;
	s=uberspace1; t=1784831217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SBo9/b5QI3fZwOSHTnC5dwKYUw3fBHlUhdmTdhVOxNo=;
	b=AiXzWJkqX3xq4p1LfYGk5s9PscFv8e0SJpH7bDhQCpfb+4dIZDsPJwcNjPBHYIYp5JG9WJ
	tNReU3u0xNGaaRPK741EVy+Te6FhjulbxVm7qzNGWg3zOraXGQydFDzidbIhx4jIZDg4IT
	MAogPeIi8NUGUbY8xQIc2YIWe1jBpuAyL1yNAXC+ZLWUrzOTx4Qs8qKvtq9cJxHsAebbZy
	YnXPdM+WKZVavMI9cuNCUekSQw0xNmrtCr4wcIbHoOPEdynb/Hfx1walSLhOL6PK3ti4fQ
	+pSfZht4FJJmbgicMvYBQm82Yc/RJfW7YqmqTx7Y9jJBWklpGzd1HW9BPo4mHA==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=simon.dietz@plantwatch.de smtp.mailfrom=simon.dietz@plantwatch.de
To: andrew@lunn.ch
Cc: andrew+netdev@lunn.ch,
	dietz23838@hs-ansbach.de,
	netdev@vger.kernel.org,
	simon.dietz@plantwatch.de
Subject: Re: [RFC PATCH net-next v0.1 1/1] net: add GeoNetworking protocol
Date: Thu, 23 Jul 2026 20:24:57 +0200
Message-ID: <20260723182457.2670919-1-simon.dietz@plantwatch.de>
In-Reply-To: <22fa2ec2-7db9-48f0-b03a-47826239d07c@lunn.ch>
References: <22fa2ec2-7db9-48f0-b03a-47826239d07c@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.38 / 999.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	BAYES_HAM(-0.52)[80.24%];
	R_MISSING_CHARSET(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	LOCAL_OUTBOUND(0.00)[];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:3320, ipnet:2003::/19, country:DE];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[plantwatch.de:s=uberspace1];
	ALIAS_RESOLVED(0.00)[];
	FROM_HAS_DN(0.00)[]

> It would be good to add some documentation somewhere what this S32
> represents. I normally see LAT and LOG represented as floating
> points. I _think_ i read somewhere in the standard that over the air
> messages user 1/10 of a degree?

1/10 of a microdegree, as stated in the standard:

"WGS 84 [i.6] latitude and longitude of the GeoAdhoc router reference
position expressed in 1/10 micro degree."

> Do you have a list here, or is it just one location

I think a location, which is represented as a list with two elements.

> This however brings us back to the routing table. [...]
> Forwarding on the same interface, and forwarding on a different
> interface are different operations?

When considering our 700m long train example, I think for sure. Because
the range of 802.11p is roughly 500m, there can be a optimal inter-
mediary, which is in range of the device at the start of the train but
not in range of the device of the end of the train. Which may allow the
edge case to route a packet from one of our devices to another one of
ours? (Consider a train passing a railway crossing in a rural area,
detecting a car with the front of train device, passing, losing range
with the front device, but maintain range with the back device.)

> Does the standard say anything about multi-interface devices?

The standard is mostly written with cars in mind, so I don't think so.
After all, there is not even an ITS-Type for trains, just one for trams

Simon
