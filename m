Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793269302;
	b=d66ppLeTtcowLs6jyG7YZ5UczoHix0n05ZDFCzRnLJCwuzJmKIuRPIr8DZDR7S1nmfTX
	 DEcMntlbZwLzNdYcSPQEWiZZ+Y2QOz1WGA8b2hhxXx8zSLvwzOSP7kNoQjAQDZm+QyCZr
	 ipmSiMcHFtVNhJUGoGO/0ARY2c7EI5lyfG5kOxW3dZYl/9NDecOsUMUXdjYOC8yr8z1F+
	 dEk7bML9yUvix7f2Wq/rjFG4dG5oXIeyugH7eqBXbb+ns0Hp/9quRsPXiBgMY8RP6/+zW
	 ZBWgFsJL/ZN1InigaNYvitS21VFAL3FQdTqdMPUK/Y8zmdLHO4xh3mo1tO+ZL8C68iQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793269302;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Content-Transfer-Encoding:Message-Id:References:To:X-Mailer;
	bh=p4CsFDjPOd5dzP69uoDvcx2oKYWrFhACnk9N0TgFakE=;
	b=t1+FtRLZMTwmt6WBUHNPWi4Qxa1/8fv+esDA+xjfTvKiVNpq6fpFe/YQppTR+vuu8d/D
	 ZYZjQTxkWlbES/wOyIEuXnELbD3SADvW0YtGQ3UCKN9k7ZaqihWTetW3EcRlRYvjpo/5r
	 rqLFsGs5noY+c2UwRJfFS2flZAj5AdBhHK0i6NMXHuIKqFqzUhr4UB14IRToX+akieA12
	 nJ7feJ2bqcMua/GNrdVxkhw+isLJRDmOALG1b/J0S2Jnji6crCIOh5K7V6u+YMHDoxUCh
	 HCrJpkVDwctIFljkRTZpEP/hfSS95LxSE0HzJtOCIyZ1RHk8m1URFpIBu8fl15yz2kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bYEkEP0d;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B43606A31A
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 10:21:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6B43606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bYEkEP0d
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1a2761c69fbso4675340c88.0
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 03:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793269301; x=1793874101; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=p4CsFDjPOd5dzP69uoDvcx2oKYWrFhACnk9N0TgFakE=;
        b=bYEkEP0dNxlhTdG9foSUPIsWMX1MtvqNyYtlLTMcLbRq0lyy2cratV0BIr2gtYu5ia
         H4zg9Ixd+52wVE1IOa1nwYwk0JaaaTVOGzCRbxdtp8UMWRBohoa59HBAkTPnVp6UCjYG
         MM5tpk3Qrmw+LDihNTctddLyIJcWuFt153NjbOak20ztDLbLw8MGv7Ayc/Ncpd/eY3Q5
         g7OrNaKPat6T4uqBs/NJ5x4Js0oTp1QyHZlkxvIILTsOo9tvGe6YYKzHiuNHZC8yKsKC
         JClp1ejGPTY4+BGdjE4Jd4Kl1RXPXXteK7SPhdDpfqTYVwJuMrAI5HkWguqSUZ37URHf
         datQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793269301; x=1793874101;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p4CsFDjPOd5dzP69uoDvcx2oKYWrFhACnk9N0TgFakE=;
        b=GjxIUW4VUBJSXX1tAUcc+li30msdmXGXPQ+qNlLAtopxxw9wxBMRRMnipJVAnLHSZd
         CAd/Eb2QbWVFSD85sXW4hytzTGHlCcENY815cAQ1C42Lm39XOe3DOCMmxuX4xw/QO/50
         w37QGvGIG65YH32GGFX7Pz33GnzUFnr6uHTBpVgL3QmABZmnpZZudM5QKYwIblNWjKq+
         6OAZoc7StHGcZEHSUfAxxiv/JSAY7Q5wagjBDNv/876qC2y5FK3IOiFTw+yYrJQm3qrf
         rhKjqluilXl2Pi5mHsHbD2og4TJaOzciFRBZ1Hz/MvSbl5v5bK5cmQkIrO3fqW4z1l7T
         +LtA==
X-Gm-Message-State: AFq9FYIaRmIF/I126aDg33lCqAdZfM8VtJH5PSYcQc8P1bzRTXzAG7F4
	GUMHwFGBXB7+a/a2hW9mDQnCuxzXrGV99XCmlZeeW/8bTbxcZ+sxboBH
X-Gm-Gg: AYBFou0osN1CVPU5mUjNsPvFL4O/lJu0eWQBfQTXUF3bg30E4lcAWBw6gv0bRN3A4+F
	5p73yyd6Qqu24y50lVS4Iil0+24yeXMMTMXxLupzdS0ezzomOFkD8IlIPKukHWfjittX9czSKhd
	CVRKwV/qpUrZbXf/gUgprQpjPU8cxbK/7qxWS7iCJAZlCnX6be8wT7OBlcWhUPrVj9P6RdHMzN4
	qHxYqbNCrkbPpwNCHeNwd3Lk/wQYAXArNaHD2lseMfmxCXX2L9NwJYGzvJ0toRJ+k5U4knQxd4Y
	crYscF7qY7Y6CStzuk4bmVGxlOxeiDN1lEptCKeiXvT5W7dqzriBC4d5CZ2G1opTLJ+XXsXjOhK
	sPjFBjpZvBQOaqzyNO2pnQJp6DfsfUMU0g5CWJx1FsSZuL/pj2VpppJtNGiEMwOSxP3VmjaosK6
	j7B+EQjWH71gTW5bJrRxW8OrOKCewO2Wbk//OY3wBineCz+3dxP4UyQgRGOsBXbmqKwNPkhWXoa
	R0rSeukL8AwvfYSSPv83NgWEmfVAfCBYM6n4+F2EB2vlKbacMH41hpDaABdL+DgJs3s/drWE+W2
	1zeeym455+4EImnMnL3fCY5ykByM16TyhXgpIsrpu4s0ykCXdoeWzYkknh5mu87AeGM=
X-Received: by 2002:a05:701b:4211:10b0:18c:ad6d:b790 with SMTP id a92af1059eb24-1a6cf914593mr7053743c88.45.1793269300875;
        Thu, 29 Oct 2026 03:21:40 -0700 (PDT)
Received: from smtpclient.apple (v133-18-180-162.vir.kagoya.net. [133.18.180.162])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a75d76814bsm13556801c88.10.2026.10.29.03.21.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Oct 2026 03:21:40 -0700 (PDT)
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
Subject: Re: [PATCH net 2/2] Revert "net: advertise TCP MSS from the
 configured MTU, not the learned PMTU"
From: Esko Mobius <echoowall@gmail.com>
In-Reply-To: <20261029101859.6893f1a0@pumpkin>
Date: Thu, 29 Oct 2026 18:21:22 +0800
Cc: netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Simon Horman <horms@kernel.org>,
 David Ahern <dsahern@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>,
 Jiayuan Chen <jiayuan.chen@linux.dev>,
 Shuah Khan <shuah@kernel.org>,
 Thorsten Leemhuis <regressions@leemhuis.info>,
 regressions@lists.linux.dev,
 linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org,
 Eric Dumazet <edumazet@kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <22077B76-12B0-4DD6-813E-A3968003575F@gmail.com>
References: <20261026-advmss-revert-v1-0-272fa4b7ecb6@gmail.com>
 <20261026-advmss-revert-v1-2-272fa4b7ecb6@gmail.com>
 <20261029101859.6893f1a0@pumpkin>
To: David Laight <david.laight.linux@gmail.com>
X-Mailer: Apple Mail (2.3901.100.1.1.12)

On Thu, 29 Oct 2026, David Laight wrote:
> If it isn't a silly question, how to connections in the other direction
> work?
>
> I'd have thought they'd need that ICMP message to get through.

Not silly at all. The frag-needed always goes back to whoever sent the
oversized packet, and only the client side filters inbound ICMP.

Server -> client (downloads): the server's full-size segment hits the
1456 hop, the router there sends frag-needed back to the server, which
accepts it, learns the PMTU and resends smaller segments. The server's
send side was never changed by 2640e6419594 (tcp_current_mss() still
uses the learned PMTU), so downloads always worked.

Client -> server (uploads): the client's full-size segment hits the same
hop, the frag-needed goes back towards the client (via the relay's
conntrack), and the client-side firewall drops it. The client never
learns to send smaller segments, so the upload stalls. Here the only
thing that kept segments small was the smaller MSS the server
advertised in its SYN-ACK, which is what the reverted commit removed.

Thanks,
Yongjian

