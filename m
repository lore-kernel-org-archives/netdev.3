Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794242623;
	b=OjSBLohW/HqKGohZEONwwFXyRtStjOlUIU67P1d5gPZ4+R3n230vkqEVl8D3yWG7kI85
	 3jwsut1fKcJXJaXtrGcLlrKzDkk7P4dqB0eV3V2+q0Luys+56xJz8cB1mEHTMBN7l/l2G
	 1+oATzXHOifsHQ8dCA855usTGJ3qQ0Ny3Wq6FJsbdeKKzdlGGbXUn5PkawAjEPB5yHI7G
	 ME7vmz40ZRlue4fxbxOmYmOtqZjavIoyTal7LuYBqUHb/q2ceGX1gBZbhDXZ3z7gpeAdx
	 /zuOWPAr8KuDBGhUnu3f45+lBdkLqPO9i9GacomA8YrGOHW/cD9gqUWF5ozqfSl+Z+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794242623;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Content-Transfer-Encoding:Message-Id:References:To:X-Mailer;
	bh=cTcx+iYQEwQqlDWtvuitNRUigxF9/D90op7v+uRHdIo=;
	b=aIfJXmXkT2M1wyOSNCoIwl06lGlIDddVEYd1Y05r6/H2rTNfREkmzNExQU2+fDLsClNL
	 nYGB0/GvSiYV7ZS+3/nEApbQIAzWnBI0kn8oxRNgd6+ZojxXbyIR/n5Cfu5bZz07rOWQh
	 eCubtoiHrFcAyuzOw0h2sFwhQhEFY1IciaqIXum3v8kvwMGbt6kfaS7EW6qZ+Z9YJwk4I
	 jRn88nkMiaDWkffmULbLi3yJ+Aqhr5HZRw3wdJS/wCDpFEJVRMkujXsSDGS1s38cQE1Jl
	 2n3QSI0iECmzQyN/XlV4Xtpou8juQDWzuEAmbGP/2/FqVza+j+4yjV35QB8nRprwSyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="K/BCf1Cc";
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDC2606A334
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 16:43:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1EDC2606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=K/BCf1Cc
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-3712b6d9843so744260eec.1
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 08:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794242622; x=1794847422; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cTcx+iYQEwQqlDWtvuitNRUigxF9/D90op7v+uRHdIo=;
        b=K/BCf1CcnsbXSn9afua9y6dCw1fhSD50tx15jtTyJSp6Mk6ALw+eZxpNTvhTCPVolO
         4RrA2wNZS3czpBVR6OqVHo0Iyx2vrY/tlhd1/kMAIGH6GEZ0r4NG4CU7sFNUEV6tPyjK
         ADdkObIkw56597yAY2xrIgg2QNQz6i8TKD4jPnGF6rCxhHTRHkgazvdPnyd7WFylvxaT
         gLAiq4bOZguDFEc7i4+5N6hm3VmXkv+BoN1iaWv6PN2swkzOhaOo92J7BoEMGe1zZTrm
         49n7kc6/a5Cp2FSzJxx8kIoPngYm/UydiZadvmY/BHHDNT5kVHgEeTc7Co4b2xG8vPKR
         lctA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794242622; x=1794847422;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cTcx+iYQEwQqlDWtvuitNRUigxF9/D90op7v+uRHdIo=;
        b=Q89+kVVe8+cq/dTBZr9PTvCJ7GM9r8n0y0mycIPCc3ysldTCVOa10jFPJ8tgZuMU4p
         GxsORK6R3M56SUtC0YKN/dMoJULOmJhC43t+X3ddmENfY1JNizHup3WHYBmI3CxewM2b
         GfEJg6z/vEHNBVBBE/huyumz+2cr2hwb9v7ufEybfC4OGEDWIIIZ565T0Ug5mDgSyDRM
         28sX8oORAzveR3XCR+UCJ8Ly+W2fGeBt/mvZZNjBvIh/NA1yPvVaWbSmNFgBZVx3rIQf
         oKQR0uGEPSrrzPHrIE03Hsx6HFra6fooxHk40fZQ4rA0evojOHEjOoZHXkIvqVvq5fLk
         LtFg==
X-Forwarded-Encrypted: i=1; AL+hErFYMbjpgns//ib3a7gh9ZTxYinJks9NoZ42td+AmAqg/vP8qRnd+yMdMVs3ke5DoMLTvHR0a0s=@vger.kernel.org
X-Gm-Message-State: APuU4Z/8Mr0pdp4lRs+icM69p86zb+YNPyM1hAing4Vx8y8LpQhGgdu5
	F6TpOO9B1edg8bXbjwibkVMFi/3VIrLkrLntaKOgA7oPbXFLlWSJCx83
X-Gm-Gg: AYBFou2wDZ41Rmq2RxfE9YlJyHJOAGV5kqd3jYiOR1jnZVGfdExm6YMeJq8DH5uSAcR
	lwmVEMdK2fpXx/wSS4vbuVAJyAJBcjC/Hukyb4MNtPMuLnDFWmuerEmCYLOVDwLUVVUmm1pKCHx
	IN3TeIF8bcWdIg8MTzqEQLZ/vw2CTfJvRCXoLbNojS18mTzbSZL83BGlDH9SPlvy3bDTFBVi9t1
	SW6ndz3DTZFUkdeKGyt70cb9wmWxlK/h7f7ny0/Klezy/RZA1NJadtJfO6nNAF4UuoP7TZigG8W
	s2OaM2rtyNo/v9zdu+wKX0ZzUzP9glNxF+rUYOlU+ABVpWCmj1fN0WemOuvZ07hFl/5CvkA138R
	nAFyu5nMpIpbPZc4Hf8sJYISnwhSgYtlNGWSohtak5AFJEAhyMur2AIVPOQEUXaX3xKmgoH6T10
	ySt5/YSuUn+dBu8k6HhoeL95m9ZYuk/8kOsG57e/5CWO1uDOvhU/L6Yxi+Kp9HzQOoplh5dlLs7
	wct3ucgfHksDhRiwmdgpIydx8TfRyybFAgJIM0Ux5QtbXzUoKiJhB73EKIXjlf5kcWhibamSIS4
	kydxdb40fvk0c+nNTw4ucFhXVgfpIAD7V6M4VnvVvWDkPxUmE1hdYswQsqlnbUijvTnAdxRYRI9
	qELzhbcCSUx3M
X-Received: by 2002:a05:7301:180b:b0:36a:1732:1e7 with SMTP id 5a478bee46e88-37255e4c0fcmr8052837eec.31.1794242622101;
        Mon, 09 Nov 2026 08:43:42 -0800 (PST)
Received: from smtpclient.apple (v133-18-180-162.vir.kagoya.net. [133.18.180.162])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-372665db733sm12958545eec.23.2026.11.09.08.43.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Nov 2026 08:43:41 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.12\))
Subject: Re: [PATCH net-next v2 4/4] selftests/net: packetdrill: add TCP MTU
 probing test
From: Esko Mobius <echoowall@gmail.com>
In-Reply-To: <CADVnQykAX6Fw8_86emqtTUDWgFzRd_jXTZKdDJLb0s8AUmfUaw@mail.gmail.com>
Date: Tue, 10 Nov 2026 00:43:25 +0800
Cc: davem@davemloft.net,
 pabeni@redhat.com,
 horms@kernel.org,
 kuba@kernel.org,
 kuniyu@google.com,
 shuah@kernel.org,
 edumazet@kernel.org,
 linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 panweiping3@gmail.com,
 netdev@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <93CEDEF5-5204-42D1-AF92-C63D64546D31@gmail.com>
References: <20261108-mtu-probing-series-v2-0-355d6490c3db@gmail.com>
 <20261108-mtu-probing-series-v2-4-355d6490c3db@gmail.com>
 <CADVnQykAX6Fw8_86emqtTUDWgFzRd_jXTZKdDJLb0s8AUmfUaw@mail.gmail.com>
To: Neal Cardwell <ncardwell@google.com>
X-Mailer: Apple Mail (2.3901.100.1.1.12)

> AFAICT if we drop the tcp_timestamps=0 line here (so our SYN offers
> timestamps and the scripted SYN-ACK declines them), the script should
> pass unchanged with patch 1/4, and fail without it (2072-byte rather
> than 2048-byte TSO packets, i.e. 2 x 1036 bytes). So I'd suggest
> dropping that tcp_timestamps=0 line. That way this test also covers
> the active-side part of patch 1/4.

Thanks, Neal. I removed the timestamp override and updated the commit
message.

The revised test passed with patch 1 in all three IP modes on x86_64
KVM. On the same net-next base without patch 1, all three failed on the
first data packet. Packetdrill expected 2048 bytes of TCP payload and
received 2072, as you predicted.

v3 has this change.

Thanks,
Yongjian

