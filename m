Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793284547;
	b=A0rfs+pYa43bFmocLg/JDHAb3TX0g3bbBAFKUwq2S7Z/NtUdIfJYW18wCrfbABMhgfiZ
	 FMj46+0NydjeXNttO3HoMzRXbvTKUn01yl/73H0uv3SG0M7cMLZFZLNqjfrh/1gz/HjRM
	 c4Tr3LwAZQ6nrjl04ZH2vKtsebxX/8P48H/mVDhtxxu9npU+gz6kg0x0iIUBp4hQa903S
	 d/2LmVKijUvO4ymduBCi6cJSBGspO2RPqkhMIJFDX1aycWXVzh4AyP2czNUibi34dJ0Yv
	 BoGwAIlcrZObHFL8pJ22Tzd5rJvXA4wlPvKAIM3mk5GcZ4X3++zaXE9RDQk19gx7R7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793284547;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=l6xcxDtlzQpcugPAaSZmvKKzHwB4F3KDnx148FqKe9A=;
	b=Y7Dq8iCSBJtG6+LdMDYKL0C4wIugUztd/ANRtW36UlPM7h5w+YY8SpK6QY2FMMaU3A3z
	 1pJxrcftYdwrb357eAVoFoTy4EkkLnm0xQqgZdhzTv2zHg76rjECaPkvAPVMzCG59Yeem
	 Ij6qpD8BspXEO61xoNRU51/eL1Y4u8Dpt+2iCxdxSnZ0M88jLf+FNKWtmXwTvYe4AdL0I
	 f/BIw7L3vESf+I2dgNWI0v7IplSd7KCtkRWH/Mjh7ytuhJE7VwL3nMbiFhZOW71FPmrjw
	 k4TmPy5j7I/KZwy81wipG82uFSbXWDOvhAOTDgwVF+M8b6Crlm7OWYd/BwflebtOLMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i15Rr42E;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74225606A31C
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 14:35:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74225606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i15Rr42E
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-3535a54bed9so3176959eec.1
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 07:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793284547; x=1793889347; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=l6xcxDtlzQpcugPAaSZmvKKzHwB4F3KDnx148FqKe9A=;
        b=i15Rr42EaIEWKA1s65MiXIZmoT+6GXqUWOV6NZH9RWcM1f1FnKLPQMoi2r8tasCb9n
         9VNt/m71psP/WbwThdwtGQt6YUu1YF3BS4m95IfFchu3raQ1GgYs1KvHdRmJO7XW3fdY
         2NPfmglJV0ymUs8yGrEPwzMvelHH0FOR760ypNk/ptzreeYP1+6xn0s3jsboq/BbHNhB
         NaQuu4SYO3qauHICevUEjrOBa0i6MEzZseyVmk7+IlRc/k4+QDNMtF8A2uaGaROL3xts
         n3oiaz90V5Tq81IVwTUtWuDzsNFrZZg2FwpyPTc8I2RDx/WLH6Bz2JW8iIuTmMZDVF2g
         cSqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793284547; x=1793889347;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l6xcxDtlzQpcugPAaSZmvKKzHwB4F3KDnx148FqKe9A=;
        b=H8d9LjWRjEfsxehYDq3Xkncl7pycuTNRrmrLBpPWQO0b+SmkmIxAi1MpLdIFSDCOIA
         A96WMvPtfjhZtvICWSKQ7r/pBc9i7kG5cWCxIJB6gU83GoXMYLrHH3XM8BktHCzASduG
         BLRFuRhK4Me/ui+I7F0GrOrHTiw8j6XkBxFcvVVR8jvWvxinYmdZAWpNc8r6ea28FvQs
         U/aBzjb22XltA8W6LzD+iXXgcbjruSYX9xlhjz6EOu+xy1fMCVZwSYiuZC5ih6NHbGpc
         tq/MsOMYModvF4BVNWchf2uHv1C8/3+Q7fURr1DL/JKTFZFv4QL3dKT9Sm29Hi2xQov1
         Bk6A==
X-Forwarded-Encrypted: i=1; AKwUvBwuXFh1vZfabtLWOcr7eCtHSTprmZolK4E0mgj915MdfF9TpzH9PUtaEPSGh0OGN2lTgMTIMgs=@vger.kernel.org
X-Gm-Message-State: AFq9FYKKh2OYfo9sxOQI4h3H7b438LB0FM8cqnmC3+STGk8UiAXbRWHk
	7P8pkH5axrxVJTLPZ9RSqzOrKMGe0Ti8v+9FR73mQyee95bwv3VCNxAe
X-Gm-Gg: AYBFou1qvhmzpLEqBbKE5r2gKmG37ogFqWDb6bezs9Qt6f/cAUDoS2R/c3FaJQfB4MT
	/BFqCWSbxqaAKWRF5b85ZStU8zcBr72ggcxVTaKC1k43n94pKiA3MLxg+6Q9FZlfpiAbOCTgXwK
	OwmJWXiAb+dsqXzkhRqcC65giJTyyfUvcZW15gXaySnTEsxp4AqY0/O6U6wU89F6ruPIVZLqUz4
	lOrg7PSsckT+uVrkZpD8HoMsHH7C/pZFMU2sTcY/mTuA152ckLp8iuf9AVpR9I7kZoyeujUN/T9
	is/waU67IuM5LphhyHsVIq/L8d8Ql2D+ZyRwHVHdmQZvqFKdKlpI+6Lus9vfSn+IGBbE9/1C98U
	aJda1U9CAvKsYlsgw0KxqaosOw6mvZtq2EgI9vugW0bXX6Yz5VB9xf8r5LqL/2viZwMhE2r5DAR
	NUmydMIDZVQ2hZ8sb+6QS4NxhtaDHVUymn6NbZ9hPdRK7wfGCH7TBR0729Fdz9J87weYY0sceFJ
	MIZkdPLKqPrGypCNLuPPbFAXYQfO6fztaJPkJDU5XcJwoCosD9/029UTCg2QYRmjWG3Cj8ybK4U
	uVLcDKzDHgOn1R6pH6U+/vCJi4zb2U1JH124RLq40F5BuEyWF1wCHeq34GLSx1NIkdUrfvcFekQ
	=
X-Received: by 2002:a05:7301:4701:b0:359:8492:20ff with SMTP id 5a478bee46e88-36a20393e95mr6826737eec.12.1793284546478;
        Thu, 29 Oct 2026 07:35:46 -0700 (PDT)
Received: from [127.0.1.1] (67.216.200.102.16clouds.com. [67.216.200.102])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a2395bee6sm17248533eec.21.2026.10.29.07.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 07:35:45 -0700 (PDT)
From: Cheng Yongkang <teel4res@gmail.com>
To: netdev-bot+sinfo@kernel.org
Cc: Nikolay Aleksandrov <razor@blackwall.org>,
 Ido Schimmel <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 bridge@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: bridge: mcast: release the EHT host budget for
 zero-address hosts
Date: Thu, 29 Oct 2026 07:35:34 -0700
Message-ID: <179328453413.1172981.17449459861301643018@gmail.com>
In-Reply-To: <179328352676.3327.7322681510650096532@kernel.org>
References: <179328314076.648427.17991367257682028617@gmail.com>
 <179328352676.3327.7322681510650096532@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

The PoC sends an IGMPv3/MLDv2 report from the unspecified source
address, creates and deletes the corresponding EHT set entries, and
observes that the host's num_entries budget is not released, while the
same sequence with a non-zero report source releases it.
