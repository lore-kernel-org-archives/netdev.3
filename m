Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D83C3D3CFA
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 14:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769006594; cv=none; b=KbDQgsn8o1LObf00AdrMy/QyZDwEC9i+6C3XbilhczHrNLGiOVuQMZZ4pir+dqdN95leclHOHc4v201+CvKHqO+pacepGdmoakowVdrkYnMNs0QPRPLF5C2TRO09ESQZF+p+mtxF9JCMoD2UiU8yVtkTkcLPun1C+RxeB7S6W8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769006594; c=relaxed/simple;
	bh=gHPiL96eNjmTlPWAfoWRA1J6NuEr/c2dfcWyU2idECo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=GSuP67SOiQMJcq45aSCTvX4h17azY3yKknEqYob1IAIp3iyUBPyHkHZ9CQJUsx3az0EV5WKItWDeT5eN7lIy1ZO1rQlc28gqyBli3Atljv7Oae/T+kPI1UmirTUa+LvyJLa2a4aA0yZsZwj0quJBfNg9G8q8xidc7HpkpQAbuq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ObtQiv5v; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ObtQiv5v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769006589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zqdkNxHcbaWyGUvBz/H79CvvP2GDktchKPKGebDCIkY=;
	b=ObtQiv5vcOYN3K4ZEb4PGfEUZtc5iHSc/oMyh4r4sxttDBRshdHcvZE2LsH7SIPdXRBrDZ
	ViULfKpyejrcuS5pwsfHqjiYxhFQ5qwN+C2O1I/dOQeBvc4VD830lUKC43xs3UI4IEhrtg
	pM+JekSMu0Cx0qCFG6n28bu78W35moc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-a-HIUmV3Nn2btqiK18PwMA-1; Wed,
 21 Jan 2026 09:43:07 -0500
X-MC-Unique: a-HIUmV3Nn2btqiK18PwMA-1
X-Mimecast-MFC-AGG-ID: a-HIUmV3Nn2btqiK18PwMA_1769006585
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 05E861954B12;
	Wed, 21 Jan 2026 14:43:02 +0000 (UTC)
Received: from [10.45.225.85] (unknown [10.45.225.85])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 52E2A1800577;
	Wed, 21 Jan 2026 14:42:56 +0000 (UTC)
Message-ID: <6e4e40b8-b3cb-4892-8d37-d450a02e4c52@redhat.com>
Date: Wed, 21 Jan 2026 15:42:54 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ivan Vecera <ivecera@redhat.com>
Subject: [Proposal,Question - refresh] ACPI representation of DPLL/Ethernet
 dependencies (SyncE)
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Mark Brown <broonie@kernel.org>,
 Jan Aleszczyk <jaleszcz@redhat.com>, Michal Schmidt <mschmidt@redhat.com>,
 Petr Oros <poros@redhat.com>, linux-acpi@vger.kernel.org,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Hi Andy, Rafael and others,

(based on the previous thread [1] - now involving more people from
  networking and DPLL)

Thank you for the insights on _CRS and ClockInput.

I think we have circled the issue enough to identify the core disconnect:
* While the physical signals on these wires are indeed clocks (10MHz,
   etc.), from the OS driver perspective, this is not a "Clock Resource"
   issue. The NIC driver does not need to gate, rate-set, or power-manage
   these clocks (which is what _CRS/ClockInput implies).
* Instead, the NIC driver simply needs a Topology Map. It needs to know:
   "My Port 0 (Consumer) is physically wired to DPLL Pin 3 (Provider)."

The NIC driver needs this Pin Index (3) specifically to report it via
the RtNetlink. This allows the userspace daemon (e.g., synce4l or
linux-ptp) to see the relationship and decide to configure the DPLL via 
the DPLL Netlink API to lock onto that specific input.

A generic ClockInput resource in _CRS is anonymous and unordered. The OS
abstracts it into a handle, but it fails to convey the specific pin
index required for this userspace reporting.

Since ACPI lacks a native "Graph/Topology" object for inter-device
dependencies of this nature, and _CRS obscures the index information
required by userspace, I propose we treat _DSD properties as the
de-facto standard [2] for modeling SyncE topology in ACPI.

To avoid the confusion Andy mentioned regarding "Clock Bindings" in
ACPI, I suggest we explicitly define a schema using 'dpll-' prefixed
properties. This effectively decouples it from the Clock subsystem
expectations and treats it purely as a wiring map.

Proposed ACPI Representation with proposed documentation [3]

If the ACPI maintainers and Netdev maintainers agree that this
_DSD-based topology map is the acceptable "Pragmatic Standard" for this
feature, I will document this schema in the kernel documentation and
proceed with the implementation.

This solves the immediate need for an upcoming Intel SyncE enabled
platform and provides a consistent blueprint for other vendors
implementing SyncE on ACPI.

Regards,
Ivan

[1] 
https://lore.kernel.org/linux-acpi/3bf214b9-8691-44f7-aa13-8169276a6c2b@redhat.com/
[2] 
https://docs.kernel.org/firmware-guide/acpi/dsd/data-node-references.html
[3] https://gist.github.com/ivecera/964c25f47f688f44ec70984742cf7fbd

