Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793264564;
	b=TiykYfZl9M6Urco8ZGEBRIU4rQF5JBdumkPfDRVDXXRNxeDw++TpdfYk7ba9v7y6PDH5
	 lCPYhds262NVIqbgpYMtzg4vlHB0yZxSATCt6GUyrn+TERhWcXZXnmv/L3jI13z+ILUTx
	 8PttSdUiwrs1rEaHhsX4fUrLBAwxFvIqkC2dOEwuVY4tVoG5N39g8YV+z+7rgkY1TSVeZ
	 1fIy187Ql6fsa7R303aUPt2LbqYlNGT/eKqmDgSnDZH+lvwkqfJQagcZg8UWweyZVq2Ns
	 xCkiItjaj/E90doLzqYs/3XKVdX14zlNCHyJ0CS2SbnDV76ztxW+TrmJKGpoLGfOqgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793264564;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=0DuXaAUxf/NY45cWLigCoPU0pIq1flmIM/0SGX1XZtU=;
	b=5LJM2/AP1Y9D6lk3yru6cBINmttw88SzgeIxO3NpgJni9lxHimBfjACvT8LOa5lBs1OV
	 2t5sLULtlzQfOSq5z5xegY3IK/ASCLaXhdwCUwULl9Wsz3Nnqc/wufl2lh1Tl6UNaGy5H
	 w7iGVef3TR+ajDru+iRBNLBQyT1PUmMzLy9LPkJVpH4NgXIiA+XE7DyEVUYYyT78i3LTK
	 qo8vS3CNVv/+RqcUGPzvOprF/yi5XjI5ig/zWwN4uBXxFyo3k72kUt28atptR28YPbkiG
	 2JN70750tnmA8AytQjJFyYis0CLrjumQGPGilTlc9ordZfnyIRlHF1TimJoLl8QGC7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--starchang.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=elK1toSn;
	arc=none smtp.remote-ip=209.85.210.198
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6278860A261C
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 09:02:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6278860A261C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--starchang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=elK1toSn
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-88c768885b4so3241557b3a.0
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 02:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793264564; x=1793869364; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0DuXaAUxf/NY45cWLigCoPU0pIq1flmIM/0SGX1XZtU=;
        b=elK1toSnmEW0Kx6uUg36KLLjxw88v+fpbxeQXa4lgvRJs/bk6Frt3Ev8nfcPEj5mq2
         kSzXF5wUJql9tDdwUoWx0XVAvspHNHjkHGysczIL18dIock4yXJKhfxDYkayuzldZkZI
         b8MvFVLvLVk/DKVaczI5+Zij3AlKZELpn7kYOSqDdDov+YSeiyYAkkBDrcgI1dbeqxEz
         1zYRR2y/F/v8CgeAinwozGvF0isrhvbjq8EauXuRT3rf55ccOgTq/5iVmIVAYN+uISdq
         UITFUFZLCAUWaGMwI+rnCh+9MTMLR4U4eH9odekcvWJSB/dorsZEZZgGTnCaq+/p3110
         4MhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793264564; x=1793869364;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0DuXaAUxf/NY45cWLigCoPU0pIq1flmIM/0SGX1XZtU=;
        b=oPCRAFcFXV25klFek2VoyPGIUhZMaCFK+620GTaEX3J8X19DWwoFSJrSao0l/86iKW
         9H5wA7p6qVWB2d8+qS35oMegBDTOIwbcmemXO7FcsVW10FRmIW3e9fP/8cQfyAUmxob2
         dZ2u0swxS5kDvXrf5L8nqEI6Z7hiRbp5nHl8+WRWIEKGNBRdnibNzPkzr97LOhc40LXS
         xsYhH/u+OHFVCY7jp0fk2UXNnuwGPBsNMqEfQUnz4RcwlwcNsJpfZgUo7NCp1ebEHIXc
         aCgENbAj/pBTypDuxFzK+hInyJPrcNoz/7dPHqhQNQoLOVsph1oJTXu7Pu8XbB8fn/CF
         15Eg==
X-Gm-Message-State: AFq9FYI4IIdYYg1GQpp4kDACCO0nijB9RN486c9dJeJeg/QuwME9JW50
	zKpoB2M6gpw/QDp4K0XqTrsdoAq0kAJhLRlhoSvJ4tr3l+WmhOMNI6kl2prv5BBQFgMGBQ1a+SV
	R4i1I4oLS502cKTV5fg==
X-Received: from pfh1.prod.google.com ([2002:a05:6a00:12c1:b0:885:756d:3709])
 (user=starchang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3a15:b0:899:465d:c8f4 with SMTP id d2e1a72fcca58-8a6e6efa7c5mr3950320b3a.14.1793264563489;
 Thu, 29 Oct 2026 02:02:43 -0700 (PDT)
Date: Thu, 29 Oct 2026 09:02:41 +0000
In-Reply-To: <f631e178-d9ec-f335-9163-c44a9e6c58af@ssi.bg>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261026150539.1357037-1-starchang@google.com>
 <20261027015619.1745984-1-starchang@google.com> <5c1fe870-39ff-e83e-e479-0e1f0fed6a83@ssi.bg>
 <20261028061644.2997812-1-starchang@google.com> <f631e178-d9ec-f335-9163-c44a9e6c58af@ssi.bg>
X-Mailer: git-send-email 2.56.0.313.g2479322e68-goog
Message-ID: <20261029090241.4070613-1-starchang@google.com>
Subject: Re: [PATCH net v4] net: Fix Hole-196 vulnerability by dropping
 unicast ARP/IP in L2 BMC
From: Star Chang <starchang@google.com>
To: ja@ssi.bg
Cc: netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, johannes@sipsolutions.net, johannes.berg@intel.com, 
	linux-kernel@vger.kernel.org, wangroger@google.com, starchang@google.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Julian,

Thank you for the prompt feedback!

On the ARP side:
Glad to hear that dropping non-GARP ARP Replies (ar_op =3D=3D ARPOP_REPLY &=
& sip !=3D tip) in L2 BMC sounds like the right direction.

Regarding the points you raised:
1. For GARP: Leaving it to DROP_GRATUITOUS_ARP to decide makes total sense.=
 Legitimate GARP (sip =3D=3D tip) will bypass our drop check and fall throu=
gh to the existing IN_DEV_DROP_GRATUITOUS_ARP logic in arp_process().
2. For RFC 3927 (169.254.0.0/16): I completely agree with your concern that=
 exempting it opens another door. Given that Hole-196 attacks typically tar=
get the subnet gateway rather than link-local addresses, keeping it simple =
without an exemption seems safer.

Regarding your comment on the IP part ("But not sure for the IP part..."):
Could you please elaborate on your concerns with the IP changes?

The motivation for exempting UDP port 68 was that in our lab testing, we no=
ticed certain DHCP servers responding with unicast IP addresses over L2 bro=
adcast, which caused legitimate lease packets to be dropped by drop_unicast=
_in_l2_multicast.

We would be very glad to adjust, simplify, or rethink the IP logic based on=
 your advice.

Thanks again for your time and guidance!

Best regards,
Star Chang
