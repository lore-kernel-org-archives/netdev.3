Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E3E4ADD9B
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 11:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790164773; cv=none; b=nwwnvqC1iX1CTLjvhTIYV4JQHzfCW9w3bqMMfiyuWhzr4vTCuWZqrAfv8e8sR7Yz7wtFVJHOY06IgTJL64Z1iyUJJC6bU2UMDz6yIjVh2v0VvD5qKC0YthKbohXLWCz08XqKVLhPqu3i5EinNAoiqwQyW6VnbTJ0tN63E9z7Zb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790164773; c=relaxed/simple;
	bh=lyThp7bIz6kj168zSwcpYX6Pcr2CQbMqDAwt8ob+z70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IevIcO5NMpjW6LcokevJvYfb3vsFLHxTVrHtdpDPCySUHPOIsGN1Y4dm5SoBecytWRp298kzJAhrr1Y2xodD+qcAqOQp6N8A+P20LftXEQH77LoScWHrvDAZaE/oU1XP3STZaWTNWZEdr2oLnJ9fPDDfh2bPyi6dd2vKF0jzlj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DBXnmgxe; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DBXnmgxe"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccafb751so477719a91.2
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 04:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790164767; x=1790769567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BrzXSXvlSZQsoju04uUevcVwnOSzbxdAq6pl8JZzW5k=;
        b=DBXnmgxegbZBUmOsq3ltZ7SoonG/vyLROHa14W3bPLY0yEqB1VWFo7NC0gPqLMMy/K
         zj/ZBWFLkXNK8uDFTkFYUjWgOGvceYykGRnILOhe9wtj2T564r+wCaDHyGEzOkyX3sQX
         lvnSNeaEHXbtWqhkMleUt0NePUoJjQ/exLHhmx0BGBMEZVMd05F45669JGghJWgvLcYQ
         tusInSmiEsXb/dpfKyzy45GxPaM5YyJnEZ/y8+IuSacGQW4T+SPAK7VaL60wmcrN//L3
         hbzcGzpnlEzriwWqAp312asfccBF1q9rs2k2Eu//HzgJOTcT/89FUG8otdn05cIkCo0J
         Blhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790164767; x=1790769567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BrzXSXvlSZQsoju04uUevcVwnOSzbxdAq6pl8JZzW5k=;
        b=Jy/ETmuaegjS50eAlAXn6NLriu9OseK3QXFJB0Exmmvune+ghFfXPOOJjMUzpoXz59
         fnh4DffbHZ8VNhbCu1jFxY5N4zAVQW12r18s7DA+F5ViRUHamsC37J/j2BRPry3g0XI2
         hU6i+S5bbF1W71qL3PJO3yVk+NbvKXlbqcsjNWdNqoQcMqdhtKrlVaVbFBTioqtZRUXL
         HGbX9iwhvlFU6ImiYd8RguTiBD9d3Sh7+uMvr/Dtnhtg9IOPfnHNvevWZnLtqbhvC+qU
         sX2Vaj/lBOTaTogC78E/8FKmEH8OqlWj0bHmT/fFZC0rQOcdfqcbhiN3Zi4pV1VF5feH
         ZAng==
X-Forwarded-Encrypted: i=1; AKwUvBxxZZ5RDPVSX7NmV00riJ9dXPQ3oOyymUKTkK9IBkB2rYqjr+rf4VrnyXQ2kJZVf9k1+b6VHy4=@vger.kernel.org
X-Gm-Message-State: AFuF++lKiZt7XOI5FbKpIlVTIFPqGRkVIbrW8hmMmh46G7eNLkrc/xvv
	7/O1AcBVYtV5VlUzBjrzOGcZl8/i8fOFE/XcD1IQOnM/uezAdU8gR1eh
X-Gm-Gg: AYBFou3gLmhF8u+dCVPLDCg1ood1HhW/R3YuhBLXMiN0G7GR6FF8sQUmF/gbMSc+Vfi
	LwiY76NbAC0r47ZgadqKR6P9/ojiIEIEWis19ySShDKoofz6QacH9uAFNqOGPoXgVlVWwuVIdvt
	2NeHszjT9j5OE+LuY5RgGJZn38wWVxFYjD+xmElvMjJiIz7D/yzdZIPksvM4H5iJzE0bN6TB0N6
	sQYxqhD8dxNGizpyEENeKvjfqPAuhjoH73hWxSE1Zu41vqv+JQ7DjS2hsgxUOU/6zM0jAZrb1bl
	Nr5zfvgElSDdAxXbSA34rm2GYm4efFbO6nN5Hegb1RigS04u3/VZg7bJ1OkLZeNuz4fS1OLc3oc
	qEglhDITSSZBSBNabgbASAEufcbCjv6n+lAcn2rg5nunKy/yRqyc8aN92qwTtormVLkGNGf7bdt
	RZSAnsNvCBVuL4pMtfm1wEkMgDAcjCQPRveJc7PnZXoL6kW0iSGD2izveH/OGEttU=
X-Received: by 2002:a17:90b:4a45:b0:39e:2530:2102 with SMTP id 98e67ed59e1d1-3a07e56552cmr2048640a91.11.1790164766974;
        Wed, 23 Sep 2026 04:59:26 -0700 (PDT)
Received: from dev ([163.43.103.131])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a07ddae66asm5970635a91.3.2026.09.23.04.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 04:59:26 -0700 (PDT)
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
To: idosch@nvidia.com
Cc: dsahern@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	justin.iurman@gmail.com,
	alex.aring@gmail.com,
	steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	razor@blackwall.org,
	eyal.birger@gmail.com,
	nicolas.dichtel@6wind.com,
	lucien.xin@gmail.com,
	shuah@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net 0/4] net: lwtunnel: accept encap attributes without NLA_F_NESTED
Date: Wed, 23 Sep 2026 20:59:14 +0900
Message-ID: <20260923115914.70760-1-yuya.kusakabe@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260923112917.GA2749166@shredder>
References: <20260923-lwt-encap-noflag-v1-0-8de7ab6c86e9@gmail.com> <20260923112917.GA2749166@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Sep 23, 2026 at 02:29:17PM +0300, Ido Schimmel wrote:
> If this never worked, then why target these patches at net and blaming
> up to 7 years old commits? I try to follow [1] when deciding between net
> and net-next.
You are right, it is not a regression.  If there is a v2 it will go to
net-next without the Fixes tags.

> Also, did you hit this in practice or was this flagged by AI? If nobody
> is using save/restore and hitting this in practice, then maybe it's not
> worth to loosen the validation performed by the kernel.
It was flagged by an AI review of a new encap I am working on (SRv6
Mobile User Plane, still RFC).  I reproduced it there, and checking the
existing encaps showed rpl, ioam6, xfrm and the ip tunnel options behave
the same.  I have no report from their users.

My motivation was that a feature which exists should not silently fail,
and the series only drops the flag check on the container; everything
nested inside is still validated strictly.  But if nobody relies on
save/restore for these encaps, I am fine dropping the series, and the
new encap will keep nla_parse_nested() like rpl, ioam6 and xfrm.

Thanks
