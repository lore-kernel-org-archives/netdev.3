Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424413290A5
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 02:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788832915; cv=none; b=N9BTSrp3dvrxfXrtHnWTW5ir84WHMbRalpvHzuBdFObXyEyS42UVP8hKHD5MRXzkxbxyBTZ+/zqugNb1IYV8u3RFJMv2lHTNNV/MruBntSqNFD8tjkv8VJD4JQwyGvU2WTESYHfJDJpQrMtAfLMzsbw7fS7rc8dGRGz9pTognH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788832915; c=relaxed/simple;
	bh=1Jpz4C6MSsU9Koby2MHY5i1hCRUHdkIFReChZeDjEbQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=K60aOJVBwLvFzMSbBjCmWI/bLknaKIPtgQtPs8zIArSJtgs4y10ajeIe3W1BAVGngQEuCLCWCqQi8sROsHfLRHfOvBA3og/y+wSqm9TmfZ5e1uR4ivzCsjbgCGag54SGokwC69mSZgZPgdSd2o+SOur786HA7sc218eA37+lqP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=it0krGc1; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="it0krGc1"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-8588583a7c3so38038827b3.2
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 19:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788832912; x=1789437712; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dAzStVVGyfE/6fL+70Rz6voDdHfrVrCBZi2MNygmT8U=;
        b=it0krGc1/zcT84UQjlJZ88RxQHknkcB7wTQEwNe6FZcowuXYJMNDNeECqCJMKX+vkK
         BA39MG4eaeONzDlXW5nNbkGdXpn8CCuEgsd4NtC/Gd0tbetyxgY/gDKsau74nswLW7RH
         huUwmC9G+wdy0Kc7EwlLHP5RVhbWMTTJEVBApgbyQN9dFZji0ut+/cLk55jHDBgbIuzI
         SGop30KEeKsB16i87I5/Sed0C17Ac21/e2VbMnpeCP0w21orWGdS5+a9PBFUOXZ2c60/
         AdEVpFjSdCE2/cGiy3Nnmx8/Ae9pXB5hGwukdp/eWxCo+Y8dO8yFFOkHolLIwf1ZZVjR
         +hmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788832912; x=1789437712;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dAzStVVGyfE/6fL+70Rz6voDdHfrVrCBZi2MNygmT8U=;
        b=AyB9iC5aDedB7l+XdhtHXb39Bc3YflYnRGQ6JOGqELaaO1sw+9q4sMtqhzEeOqSaLq
         HiwJe+O0GDaKp3m2nTQZDKepLJLrO/BGe53kOK+qS31/0NfO2benoPhhNxFY/WB78A6Q
         dpjNoB04ssC/RnIgy6G4VvZ4Uaz3qaUeI2hWoDfi2Zytp2hGe0att6IIGstrI5jVlhkS
         KbVGDEKZSXF70H8bIg/vujX0lFnGQXrnGTX80GcxmQcdIb6Dr15NUZWBVecVz9tMsc0S
         wp40OUpDcXdcJcbZ1Jy7xod6cKHZNliA69Yjow7guFobLW2oleJW89KHKYa692n2edY3
         6ZOg==
X-Gm-Message-State: AFuF++lUu9g569qZr/POkJcSBYAszhSfQk3f0qmtWBdkTqWT5innA6vq
	bs0Cr+5ly/6rZllPoYBliSaP0ZWCiZFgccBzCh0W2quFnAMd1dmE7q5f
X-Gm-Gg: AYBFou3pQjvqpRzjsGG3q5qLOQh8F8O1mlrxunYPlSqQxVj/GqCT3kmyIOQ0MPR/EY0
	+PCrTAFGrJNuzVxLB7EclSdFLCTuqwYxaKkLINWbSVuSj+ZLIedPVakyzHN4rRK7rGUYaef4FYR
	RiO+l/JHuq1lsInFKaj6uBpSKpu5f0LruyHD+fnsA72XzL5wF91Vb+PL5wpYgWAW+HjpbE8pfl7
	kZW0HSV/w/9ng8ukDCK2FKbCNmE02YX+UtkN63LAbl0puuNeYM/jh5HrPDI4VKdD/A0LNeRetuJ
	VirxJ5w8cKf5G8OPAD4fsfRw2XOPl+sWQwGeTIv/cxlp3IDBtxCa04asXHAmo5Sl0t3t8pKcAhR
	CV4J81JDPgdgVKEPPkuF71MS57etIkLOtbE8hSgA65Tv3EwcYjhZInfjci0KVFQ2EpQB3CTwcW7
	Qbnu9R0bFmdW9GoxWNFJntqfcB4qh/SnkjvpOyFu9GG42C6myI0bIaRghIjRnk3QQ2xckRR+tFO
	uINBOK4QTveajOe1tNpQiKvHbejB7bv5yOmymxp4Q==
X-Received: by 2002:a05:690c:4dc7:b0:873:5bb2:6c1a with SMTP id 00721157ae682-8735bb26f13mr47009517b3.68.1788832912006;
        Mon, 07 Sep 2026 19:01:52 -0700 (PDT)
Received: from gmail.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8714b62bc77sm81658687b3.39.2026.09.07.19.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 19:01:51 -0700 (PDT)
Date: Mon, 07 Sep 2026 22:01:50 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev-bot+sashiko@kernel.org, 
 willemdebruijn.kernel@gmail.com
Cc: netdev@vger.kernel.org, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 andrew+netdev@lunn.ch, 
 willemb@google.com
Message-ID: <willemdebruijn.kernel.1ff5ab9efe897@gmail.com>
In-Reply-To: <178876110986.219967.12438774212046389670@kernel.org>
References: <20260904030624.3833721-1-willemdebruijn.kernel@gmail.com>
 <178876110986.219967.12438774212046389670@kernel.org>
Subject: Re: [PATCH net-next v2] selftests: net: csum: filter packets by
 source address and port
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

netdev-bot+sashiko@ wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
> =

> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 0
> =

> - [Medium] The newly added source-port filter is silently disabled for
>   the `-Z` (zero-checksum) configuration in both receive paths, leaving=
=E2=80=A6
> =

> =

> [Severity: Medium]
> Could the !cfg_zero_sum condition in recv_udp() and in
> recv_verify_packet_udp() get a comment, or be replaced by computing the=

> expected port on the receiver?
 =

Fair. For -Z, I'll have the receiver call build_packet() too, so that
build_packet_udp() updates cfg_port_src to the expected value.
