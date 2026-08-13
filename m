Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C58442FB2
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 11:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786619765; cv=none; b=GaiwJ9TF9mZudY40zZGzKKpTOH9crYgzQfPsFyrNVi6NIMs9GMdIbA4xRAHsE4tkOKLUvKRXCIeH/EQZWvahh0+6RcXDSUBmFwJT+wjSr3JKIbvWjnCsHMEOmRyDfrOOz/ABPbMSpSWVHyCJKKuhHqUlTahAurZRkXPnwQB81CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786619765; c=relaxed/simple;
	bh=eCtC6QgWZJI49Osw7++8fZemrdIWgMW8ibmZR93kf9E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=c7m+TcK+f48ee6OWPUfFtLxdETyjf+PiUfqFaM/3nkLWWZw62WCBhHfUxg+O3m7v+Bpewdat4Unm5bBOfKVsqnZihBdCGPNfw5cajm4iuFNQZTv9ubQD5fXmaEHLsdd35mSpECQnat6yfsYAOz8RI4sbbWckchDH02aplM68APE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=egkcsgmX; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=p15V5/nm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="egkcsgmX";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="p15V5/nm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786619755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eCtC6QgWZJI49Osw7++8fZemrdIWgMW8ibmZR93kf9E=;
	b=egkcsgmX6tbGaG5Xta4xTkVquNee7IzJqk52MqkQsCPUVhVZNOOohtZ8I1h6WTWspARx0h
	uJOaMvTahaFtCsl9833YYwc9ld+8rIJm03f0dm8oXLsNdF3PFxBhMjH4BWfB6x0uJ+mJq6
	/F6UnOyCEMgBjD/18d3i6XJMzT4Lg3U=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-cs3FqT5ZOzqxUn9PXWLEgg-1; Thu, 13 Aug 2026 07:15:54 -0400
X-MC-Unique: cs3FqT5ZOzqxUn9PXWLEgg-1
X-Mimecast-MFC-AGG-ID: cs3FqT5ZOzqxUn9PXWLEgg_1786619754
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c1b4d961dso8165041cf.1
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 04:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786619754; x=1787224554; darn=vger.kernel.org;
        h=content-type:mime-version:user-agent:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=eCtC6QgWZJI49Osw7++8fZemrdIWgMW8ibmZR93kf9E=;
        b=p15V5/nmCx7YfVZt38+gstLpHktrhVcwEispL7N9eP9nMLI8B/XUNB/QflDbjoC3dH
         Yr96B4Jf8OajlDulHNe6i8QeiuJWUOIz/nleBp/BSDpqGNcS3cSjrUsbrD05HCsbz7Zk
         aoXLf3dv1LRl7ZPqSxEqBm2D+jaVJaZhzno+jx3a8gy2Th2OdrNHYHvEc+5vltPckxvN
         Qp0SusYpNz0KTnvkhFe3jPrAFdOiA5bQhMY2x3ALSqubrTkfEWOYzEDHmgd+iC8Uwh6i
         ZBTf1z007k/PK5tncuDJZ50axq2nP6KPjQTDO76LJbcP1F+gGCqH6lEc/hXMlDD6W1Qo
         Xeww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786619754; x=1787224554;
        h=content-type:mime-version:user-agent:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=eCtC6QgWZJI49Osw7++8fZemrdIWgMW8ibmZR93kf9E=;
        b=VMY+i7NzEt4dNstHBfpMdVDYOMdOy1NrVjHXiWYluUpUum2GQmreLXPARfPJ+GJmpb
         IKT8TASAomsGW6Irnx9Gzeru+qH3yPX9VsMsZnlYLQPnq3D5AXS5Tg4Fkb4dJBKUqokH
         dHJ2R6AL1YrUd3+6/r5ZmINvu2aBWkm5J01SHkIsGCEu576LFm1DwBVEEMZ6O6IrLUhF
         2p3eNIrIVV7KzAB+C8xsJV7kOI3oklaMrC0Tw7jeCBQ88dR8m+0auX/nBF4zDIRhwNHs
         Rcvsy7bg+jjhSB4iIcH1zsKR6Q2bCtj7W/flH68qaTqn1XopquaTxvX5SeAj1xug5T6Z
         Ry2A==
X-Gm-Message-State: AOJu0YzV0AbJCvhugmlMxKT124FFDQPDzQScHUzixeCDHj28xNpaKgju
	Xm29Eja8kfT8J9o6+VzMVzxJ2lHbKlyQVGdWNG1wys3Cnq0aZWAHUR5VqPBmBy/uN34oUNLbPcd
	A6g412uZqNzKcujyDwaaOR+zptatfnOWgyDGzMhBjClox2YLZmBJIO2HM0vGsI9+Y0dA7
X-Gm-Gg: AR+sD10F5NFjVQc4KrYq7dF71Xl3HflZcpHlR9P+PjuNvBIIlOc5gBINnhWiW4L4GB+
	1si187fH3ITCaXNtGKjuhB6aDJ3+rWKDXTH/WHma5AOwYikdOApLB6hZjccClfCA/rkYWn5Ueom
	vnhGM6embdIVAN2W7ubrRbcn9I9J+i4W4Ef7yzD+GRBNj7zDLFk7X70UOm7/TCbHnktVAglX9ne
	/fBhaGJeSJiN23vFICQZ2imZ2JX6PNoeJBl3+jqsE+ngWlWmXepqIAObya23d4AlkoaEr9W/BJU
	ED2YQlamQ/PxPNginPU0SDdsSW71HcC69ufDn5OYIxXDnIoT9r+8ZjqzDGvNdFx+S0dN43Lz+AI
	QswieEcRY/IThr9W3OfmzOwZ7QFJp
X-Received: by 2002:a05:622a:590a:b0:51b:9873:e37b with SMTP id d75a77b69052e-52d751c7c1dmr41466581cf.9.1786619753843;
        Thu, 13 Aug 2026 04:15:53 -0700 (PDT)
X-Received: by 2002:a05:622a:590a:b0:51b:9873:e37b with SMTP id d75a77b69052e-52d751c7c1dmr41466021cf.9.1786619753443;
        Thu, 13 Aug 2026 04:15:53 -0700 (PDT)
Received: from aconole-thinkpadt14gen4.rmtusnh.csb ([216.212.25.12])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52d73fb89c0sm14535951cf.18.2026.08.13.04.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 04:15:53 -0700 (PDT)
From: Aaron Conole <aconole@redhat.com>
To: Minxi Hou <houminxi@gmail.com>
Cc: netdev@vger.kernel.org,  davem@davemloft.net,  dev@openvswitch.org,
  echaudro@redhat.com,  edumazet@google.com,  horms@kernel.org,
  i.maximets@ovn.org,  i.maximets@redhat.com,  kuba@kernel.org,
  linux-kernel@vger.kernel.org,  linux-kselftest@vger.kernel.org,
  pabeni@redhat.com,  shuah@kernel.org
Subject: Re: [PATCH net-next v10] selftests/net/openvswitch: add SCTP flow
 key support and test
In-Reply-To: <20260811181645.1918420-1-houminxi@gmail.com> (Minxi Hou's
	message of "Tue, 11 Aug 2026 14:16:45 -0400")
References: <20260811181645.1918420-1-houminxi@gmail.com>
Date: Thu, 13 Aug 2026 07:15:51 -0400
Message-ID: <f7t1pc2fezc.fsf@aconole-thinkpadt14gen4.rmtusnh.csb>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Minxi Hou <houminxi@gmail.com> writes:

> The ovskey flow-string parser has no OVS_KEY_ATTR_SCTP entry, so a
> flow string containing sctp(src=.../dst=...) parses without error but
> silently drops the L4 key. The resulting flow carries only
> ipv4(proto=132), and the kernel rejects it: match_validate() in
> flow_netlink.c requires OVS_KEY_ATTR_SCTP when the IP protocol is
> IPPROTO_SCTP and returns -EINVAL for the missing key.
>
> Register OVS_KEY_ATTR_SCTP in the parse table and add a matching
> selftest that verifies SCTP flow key matching (sctp src/dst port).
>
> One listener serves the whole test. socat's fork option handles each
> association in a child, so the flow rules are the only thing that
> changes between the three phases and the listener is never restarted
> underneath them. -t 1 bounds how long a forked child lingers after
> its association closes, and the existing kill -TERM of the captured
> pid on teardown removes the listener itself.
>
> Also enable CONFIG_IP_SCTP in the selftest kernel config. The config
> checker strips underscores before comparing keys, so the entry sorts
> before CONFIG_IPV6 rather than after it.
>
> Signed-off-by: Minxi Hou <houminxi@gmail.com>
> ---

Reviewed-by: Aaron Conole <aconole@redhat.com>

