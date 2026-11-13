Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794586824;
	b=mVnSU9l4kEHZeoccJc2rcwsXCnY3v9ulgpfqPMz+cEP2V4MAMHwi1l+6wEHpGy1piVi7
	 xLV9nEX0y1lsNXZErQWV4SH+sKvom/AMQSMa0yTWeYK/8Fsz+56y/skBJpLzmsUDHilFA
	 yxE99eS/oqRtzUcsArUADNDvgqqABTAniojHzCzA+dIfI/pvZH7n1s/GzaOevBL9VsE2H
	 ohp4GNPVqEwAWKZz1+j7eqb5bSUYBpsRdogMVR2hac4J9kp8nEFUqDqqMLER0G5vWHctZ
	 gSjrV2fJt3tP7v8S2RKgH8dgG/4SyveokSOrdcJLLxfw1BCiApTEzfud+SVoq2L2vtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794586824;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=9mKuKJKQdz797u5WZKCno/OeV4zsZ4Me4LaLtgDigC8=;
	b=pBtGtanQtp5enH58/Nr1jADbPp3RQVeF2hFiDjXkR0vK0tMOIfX+Y6Or0aY1djsxZ029
	 e5i5JmUpXMah9wdJbLKxn8i3cm7JXI7N+OHRVqRl+TRtTRrHdErEzkLLJgOpTzmaSao6I
	 3xCrES6cIT52lqojGJO1h2fZ8puZ8yu+88edlJEEuyrn4Cw6JsrHRSExk7iS1F7siSL1l
	 L36l7gdGS/kllfkX3p1V/A1uvN54l5AIVCkciBC1EfJ1jud8xRkUe02JY6OEMAUmv7WHG
	 wCWmNadCzjBGXKptW0XOc56JfffH2+tTchtTQLJVTh8c+btM8oCaCBgsNAyoT7ORvtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DH849jxz;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32452606B2C3
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 16:20:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32452606B2C3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DH849jxz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794586823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9mKuKJKQdz797u5WZKCno/OeV4zsZ4Me4LaLtgDigC8=;
	b=DH849jxz66bTh8IztRhyOAUoN/Yp+fJ8IXjt/0kPBwPcTTmlYlz+w5ISe4eqJbBq98lR+n
	+ZJPYBffYCoeO+75UPskKEukkdx18248ThXeoQTIc0LKlr2SBGs/DbwasgogKLNgSnCGcZ
	0ZJBw5Nwk+1odVYsKfXcoKyjWC4t1Bk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-172-cXpBP3OMPDG0KRhS9CjTbA-1; Fri,
 13 Nov 2026 11:20:18 -0500
X-MC-Unique: cXpBP3OMPDG0KRhS9CjTbA-1
X-Mimecast-MFC-AGG-ID: cXpBP3OMPDG0KRhS9CjTbA_1794586815
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 75FC71955EA0;
	Fri, 13 Nov 2026 16:20:15 +0000 (UTC)
Received: from poros-thinkpadp16vgen1.tpbc.com (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AA2F51800495;
	Fri, 13 Nov 2026 16:20:09 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Petr Oros <poros@redhat.com>,
	netdev@vger.kernel.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Dave Ertman <david.m.ertman@intel.com>,
	Mateusz Palczewski <mateusz.palczewski@intel.com>,
	Leon Romanovsky <leon@kernel.org>,
	Rafal Rogalski <rafalx.rogalski@intel.com>,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH iwl-net v2 0/5] ice: fix RTNL vs auxiliary device lock inversion
Date: Fri, 13 Nov 2026 17:20:06 +0100
Message-ID: <20261113162006.1236497-1-poros@redhat.com>
In-Reply-To: <4b07e441-de15-44f8-a7ff-f67c9c442966@intel.com>
References: <20261023070258.730168-1-poros@redhat.com> <4b07e441-de15-44f8-a7ff-f67c9c442966@intel.com>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 11/4/2026 3:10 PM, Jacob Keller wrote:
> Sashiko has a couple of "high" complaints that look plausible to me.
> Could you please confirm if you are working on a v3 or respond to the
> reports and explain if any of these following issues are faulty reports
> from the AI?

v3 is out, rebased on Przemek's series in dev-queue. It fixes the
AFTER_TC_CHANGE report. The -EBUSY and mqprio teardown ones predate
the series, v3 only adds a warning for the latter.

Petr

