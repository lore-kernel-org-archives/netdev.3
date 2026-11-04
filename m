Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793799582;
	b=tMitPAhEozlf5+OURkHuJCqqUcwgyDFkTmIB18Uhrb04USNNuggRc4WR6+RmXpXYmKpN
	 8XI+dQsNd/LcK9PRUTdlN5O4pKD6R3xlH6K3NPwQyIb8+KdgIq31jN+odLB3NunDkZ9A3
	 aeHhOt6V6b1bUlW/6yDBYqDPkbjeuMwV+NFc6g1Bbmt+XIAvDrt7Mw2XO/q38xUrxzNDI
	 o1asZoJBWWyWU8ftwfFF8QJLzJ6O8D3QGL5KYcnZc7LWi7KwYsby4vbOqq3iPIbzranZ+
	 FTXCUGsXxOSMmVXH0t94mwLlSxcwh14+pMBslBxWppkKs8s6P/NNCRLsKpjhVMOOMSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793799582;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=Lu6oIX/8hhhXX+/jHh7o/Ii7L+nOb7laO+bG3Z0feVk=;
	b=3KaTbSoRaYktUeiYZi8fFhRMWKil2zMt2yvEAzsooYvE7/Z+noBBdp4J0rpt8ZOEpXUX
	 X/joBvY9/FS/IAGgiQSH2M7gSmbTMPsAZaJ9v1HfEGb69KkjobP+jvW8wKEPV4wJ0z7UK
	 qoJAYrnYsEQZT9Uym5Ojq/yQsHrDm4eGLpQJNH6J+dj7ocQ6btX+0ckmg4xAwoa1uM4ZK
	 JWLtQ3iP5ycJWMxpv36wTxSKMng3lIvwBjzbo+2mE6inDEIg1mJUjX2SBU4iYb83Twwcl
	 Q12c3BzYfx2GYPr3z20iFPWFlF2lLKTrRor/s03SLMGkeqLPOapOTyBMqZB1fSuz21Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=hAgqiMcv;
	arc=none smtp.remote-ip=209.85.160.178
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FA9606A31B
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 13:39:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1FA9606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=hAgqiMcv
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-537548b811aso5059101cf.3
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 05:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793799580; x=1794404380; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Lu6oIX/8hhhXX+/jHh7o/Ii7L+nOb7laO+bG3Z0feVk=;
        b=hAgqiMcvcgTcz4QsX/ocvnzE+L+vb6JzBNaAFdDRoTBEf6uV+GvEXHJecqV7UtjlmB
         nMWep7UVAvhkBNXjf276o9VmYAotsWv/aE1y0QQ1rrr73UwPRCD2ZrQwOgKG3QBEVtRC
         WhR7o5wCiT1vj+NJW1Yk8ib+H3MGGL/Xkm2Xp2TlvMg7aQImIh4ciWiB0oq0ZB795JjA
         WUErsYEtbSIyL0sgofwmOFjD13SLPCnFnWlnZvM6tvoVTERuMrSJ1iBSZAbFcOBWC9V7
         JyzIz2moZI3RSsPMvsyXDPSOjJa9Z2f6YRKVSd20Ef2IFzjniiFxIj23G798/vUFQUk9
         3xXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793799580; x=1794404380;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Lu6oIX/8hhhXX+/jHh7o/Ii7L+nOb7laO+bG3Z0feVk=;
        b=jqXmzurDw1cezedPDuZ+VjBGmxKfMRnrC/lY2HEqvbQvlfTUWs03F5UBWjFN812i7C
         INi1Mlo9bDMojUUdMh3U5ySeDHM+6jm0M3BVAU34wMFFSCPwCkx/pZdkXy1S+nGn4xb7
         bvv8YVdLtXbsqz+7LAl1/Bc/4XIrug+lgC1UfGb+J/b32SeOaOeXe/QmcPM5bXr08w+W
         Th3BDYNnkpTPPNPnHYbHN1rRJPK2ugUAo9YlHYJynZtBVwI8AOr/ULYGacVB/TYQrlt3
         augjzcbJxmf8U+IqiEXOqoiTgKkn2MteiXhoBv6a4D/Mod/IOx5YLzyn9Ic18BKH2pJ/
         n9PQ==
X-Forwarded-Encrypted: i=1; AKwUvByGjj+jv+8S/Vz9VFCkMrrIWCAJb7vLDtHHDn5wM8s2BBQ+uq6lpMmZAxTFusZ/q07ClvfRrXE=@vger.kernel.org
X-Gm-Message-State: APuU4Z85Qenj4IFP7S/dfATWFjs0o1hg9J/y8+6cydikpqEICffe0XI0
	wLbq3wEGuspp4RoVwO2n6tQOWkld0MF0S9wAIUV707H/95rVYp78vT1VnykdgnnVYIY=
X-Gm-Gg: AYBFou3xGFLSi0FLFLRu1DJtyp6NyKYVovsxN5Imen8D859lJEEI9JxOx1UCWPBSWRY
	cC1izS5gbij2E8F+5bVQK+WOgio47K4uGPKExAHfBSiYH2kHhdSsjYyWXT4vphCQWq21XYb7zcD
	rMXp0UHSTzQKGjlTNsIZ9VaOLoSnr0LUUPgmcuhuCKPPO6UWJvJ+Q5eSAxtE2N6EnQ5h+VTcfgk
	kyouDNvm1WqScuSuEqMoY7qsWa5PBsK+1xBAknqfkxUg6BMOo6SPQLohZ4+uafU3NV3tShWDGAO
	ycorsicBIRRBHwzsUOc6vYTEQCznoTC2pv/oG0mLVQTTVIAPYtAfuM5Ista4ZXU6O2lZlNW7Ca4
	sjPIumHFP8AfiiiE8QjryPLUzKDmMCXVuxqCZ3ZsdU03V7/mrIkUCsl+ggfu3FpFHGgdFr7WGZI
	nfuFxwaeXL86jJtW0BtiYt2qbDMpRBl7hIVr/MaWyqvFqvlMhsTcoDIdtdBnjtT3xpOK3qrRLHM
	lSmPBDY2sXry3uXm+pcpL4u8zv8l4QMHWZoj4LefoT8AlBAElZy/Fe6Ql0YREM8zHLpoDGcBBjT
	NGC6pHAuFaafQLbbM84VwwPy3bAvg7BjGrfBmtfMxVuQNh9ZDxdfbYWx+eUwDGRDTmmNhDxUukn
	ds2i9Iiasrw==
X-Received: by 2002:a05:622a:a12:b0:535:10be:7d46 with SMTP id d75a77b69052e-542b687da57mr269211251cf.29.1793799580284;
        Wed, 04 Nov 2026 05:39:40 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54b1086db63sm24026871cf.11.2026.11.04.05.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 05:39:39 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xObDG-0000000GBDX-3ZyX;
	Wed, 04 Nov 2026 09:39:38 -0400
Date: Wed, 4 Nov 2026 09:39:38 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Doug Ledford <doug.ledford@hpe.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	Slingshot Open Source Team <slingshot-os-team@groups.ext.hpe.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-kbuild@vger.kernel.org,
	Sandeep Bhoot <sandeep.bhoot@hpe.com>,
	Iraimani P <iraimani.pavadai@hpe.com>,
	Mamila Santosh <santosh-kumar.mamila@hpe.com>,
	Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH 00/23] Subject: [PATCH net-next 00/23] net/hpe: add HPE
 Slingshot NIC drivers
Message-ID: <20261104133938.GP3889730@ziepe.ca>
References: <20261030-cxi-netdev-submission-v1-0-8c2c391cc283@hpe.com>
 <20261030151121.1f232b50@kernel.org>
 <7d4583c2-e8dc-4ffb-bc45-e2121f824b14@lunn.ch>
 <bde936b5-1b3f-4987-a3e5-36ec5c4710e6@hpe.com>
 <2f831f13-58ff-40ca-a76f-3aca647012b6@lunn.ch>
 <b260f39e-2ac0-4899-90d9-3e9dbadfacc4@hpe.com>
 <e9937650-1354-4d66-95fa-3492e3821823@lunn.ch>
 <3418b0f9-d053-4be1-81a0-fc938fc5a7ac@hpe.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3418b0f9-d053-4be1-81a0-fc938fc5a7ac@hpe.com>

On Tue, Nov 03, 2026 at 08:21:05PM -0800, Doug Ledford wrote:
> Top-posting an executive summary: HPE's ask is whether we should submit
> this driver through the netdev community or the rdma community. HPE
> prefers netdev, with RDMA as an aux driver, but needs the maintainers’
> call. A minimal Ethernet driver is about 48k lines plus 36k lines of
> mostly machine-generated headers (details below).

It depends on a simple question: can you create a functional ultra
ethernet device without a netdev and without an IP or routing table?
Like IB?

If yes then maybe you could do RDMA first.

If no, then you must get a netdev first.

Jason
