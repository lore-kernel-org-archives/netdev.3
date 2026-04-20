Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BC334A79E
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 20:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776718361; cv=pass; b=Vv3bDKF7e4vvVXGOQxYQYD8HdJhtQvAW9My+b57grnUvsG+KhdDkQB+Uac7nwys17+s/4BZDFOzIf63p+7SjN5BDs1lnzs27bCyWzrUFMAlBChWDRG2JwohpQJwCaEu2lNfy6Z8mOEHiUsdXOPuyd+RDgqZilKqHiv+27o0jKqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776718361; c=relaxed/simple;
	bh=Pnhnz1gyermNjSQP4+5/crpMQ9x95/YqL02Qcv52xEI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dq5uhcGHMrAWOgTSLphCL0BN1AzcAa3E3pXHIzz3DjmUkZBqt+LdfdUvXvnFlh39dCye7BlgJQpCwV6hjMEFrMCUwvvFS6/i3mEI9G89pA6ep3FRuy8RSh1qX+w5CdJNCDRz6hDv1NO+Lu5Avr8XN22f5E9/DcZIm9oO7oecK4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FjIZLrLI; arc=pass smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FjIZLrLI"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82735a41920so1454311b3a.2
        for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 13:52:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776718360; cv=none;
        d=google.com; s=arc-20240605;
        b=Xyi5R+ghmjY93111xL4gY1B/XJVnk4fEXFkzOhUCo06IlKmBsb659twQfTFaQbO3VE
         FkRPlqg32Rh/zmnIiDvwFy9w0VPVHRKgEX5GuSQcCCCdKKF3JDj24UBZUynpLqlgAVmE
         NwPE17KokaELFoChp0HtDJ0uK/3+auqbh6RH/bnXXY4VZP7bHeLyH1reSfDwt/ItlIVQ
         wjdzpKC9vtnyNwZTrWrd8EOoVnaKczL9nmoz2zqO36R8+ksB2mUDK4LH2t4/1D30L+rQ
         Np8CwLviT/XPf2X3CGRt5/x7kpn7aFuQV45yVsi76VVdZLx2OD+KRQgnkWFLY9aTIKMB
         GAXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MxdD42vr//ngF98PTX13azQKwSAEPSKYCuEqwcGgkfs=;
        fh=Zp0LQiWjD5q9CJsxOG5W9hXV21UE/GyKhU+qOsfar+o=;
        b=QFrE582CuETcWzpJxRZMGYgZsRhx1bjwvKqW+MYANY87evWjMIZ1TZHxtU51fxerwj
         aRrydIzQpd7RNLfDx/DLNn8X8VhgzJpjPLzUT34M0mFn9rQpuD0hu8rh30cuxuC4awmW
         rDj6nJ2vSuIP2ftaT/fUpcYTo9LJuPLouLObaTCrDou/XbP/YmrP4sugHuJ1SVugp1Dn
         jD2OrU7OuS7RQ/J5nGDNSCwfg0cv2bLPi0ncJnf6bY7E/HLH/RMnSHfVL6N8yVrPMdWj
         6nEZbaQ9KMmxoeF7nrRgWs9C8jbdaASiSIX0QCEDPiNahCdblPqu3E9xUMHIbzdfdmCN
         x3jA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776718360; x=1777323160; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MxdD42vr//ngF98PTX13azQKwSAEPSKYCuEqwcGgkfs=;
        b=FjIZLrLI3KSkP9dhCKwgfkTNIuXNaYPG/XVG89sZwWDi+Lg5mTU+TIeS7qL8fIlP5Z
         9D2UZMCzGtnxdVpbyJp1cUEWpvLOIIoyUCMvzhyNSo8yRVJL3g2ToV1cBKEDM/aXg7gT
         //LIV2svgvvzAyQR80Sp0BLBm+jwmv74bzfOKz1Uz8KB1FF8oE2PeNK8CXhCpKdm/tyR
         Ehzm2Cr60Sr86eIQg3l/2mJogk6wZTBJgg1xtcAv2NQ6ocaOjEztzaMLlQjDz5AlO/E7
         /r5We0LGgS2WTO66XnvyjgPVPEI3K4NiwoC4Mx9BOfBeR2pM5DpGdVa6wt7RLoTNS7ss
         x5JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776718360; x=1777323160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MxdD42vr//ngF98PTX13azQKwSAEPSKYCuEqwcGgkfs=;
        b=hF08jYTMevRq8fiUpbU8GK3JqaiuYM2WHg4Dur3eLKNlQyT24PM9PpDBWRbTvXEjwb
         UPHcvv87N2KnSozEojVZIg0YSpzYuEvBYSemSodkjRD+XBcHPqJBABaCZNuk1GN6FkD0
         nchcCq3ll9CNGizaE4At99fkOmfifYKa38lED36hKn51hXoO47j0d7NeFbZq0hu48gBa
         bsgPZwM/1Of8wIQS2nCMPtsrLDN/PSjVRRy+Z4i6OcrChwEPm10i/0swVyoubKD4nRY7
         9px3VtpOf+rBV2ICr+gddo6AaUaB9Db1vGsjkbYkYLKKb7OsDx6A22JbMP5pG6pAr3+q
         vqZw==
X-Forwarded-Encrypted: i=1; AFNElJ/cD8toH5IFYVJLIWH8/saKswq7nUHmWMf6ticSCp0NDQyiFa6xUhU2dc54i5o86YQkAfrogU8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhSy18kdMTBWW2mc6+SYBPDLzGejnak+3hGJEV4oaQzq+THN2C
	W/wk6dhRMrcfl1di+PXxFmdf3nMgGE1SCnTuaFKyx0lL+G4ANlLaplDgIRl0h2qE8Hu5miJTA4j
	/D+IRvY6BtzA1kqaA2V46Mo+KfRg1vp4=
X-Gm-Gg: AeBDiesYHrPyCfhYBhGKPWKDWW/DqyKv6Dl7XO5VZXzKZhTHh3C4mmIg6zZj6FGTJ2f
	Ewr6kSbVLgNNYq0RmwDYTm6SctzanRqZpJ/9r9Xt8VVEFEvIqarqtWUVHVmZi3xxX7MZncU0Otq
	INBUvcKFiU3a40raruVgqgXHlPeNcyH7t+z+mMwg5hnbEMFYd7GUNu65aw9Sw7/pjdCjGMh7bTY
	X61Bib7JNVzkq7S8DuNQ039I9TCzld8E1+O7fSHDjiwoxzh/EbmgRfQ/sI3aN7bDdpu0Egu0wxA
	Kq5m+J/dregwrG9/B3j9e31NKbUlw3nbbKqX/azDwhkaesBo/Sq4ALWXCjotOGnXpLW+If1Ia2a
	iP/MdMUHLLt2zyJxEbGhoeXR/w3AMUdsrviglqql2X2HR9EnE
X-Received: by 2002:a05:6a00:2d1f:b0:82f:7252:38cf with SMTP id
 d2e1a72fcca58-82f8c82c396mr13602325b3a.16.1776718359711; Mon, 20 Apr 2026
 13:52:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260418195843.303946-1-yiche.cy@gmail.com> <20260420082334.7db8cbf4@kernel.org>
In-Reply-To: <20260420082334.7db8cbf4@kernel.org>
From: Xin Long <lucien.xin@gmail.com>
Date: Mon, 20 Apr 2026 16:52:27 -0400
X-Gm-Features: AQROBzDGLUKJMnGtLHblO9Fg05E_lPRg8I9KEhfXLSlLZeyIegT3XxzFdfu_aUI
Message-ID: <CADvbK_cmmdqxXJC1q-5gDTzhq_XH1ESgRZCD6pO4Ws4GoWooYQ@mail.gmail.com>
Subject: Re: [PATCH net v2] selftests: netfilter: conntrack_sctp_collision.sh:
 Introduce SCTP INIT collision test
To: Jakub Kicinski <kuba@kernel.org>
Cc: Yi Chen <yiche.cy@gmail.com>, Pablo Neira Ayuso <pablo@netfilter.org>, 
	Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, coreteam@netfilter.org, netfilter-devel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 20, 2026 at 11:23=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Sun, 19 Apr 2026 03:58:43 +0800 Yi Chen wrote:
> > The existing test covered a scenario where a delayed INIT_ACK chunk
> > updates the vtag in conntrack after the association has already been
> > established.
>
> AI says:
>
> The conntrack_sctp_collision.sh selftest is now failing in the NIPA CI on
> both the normal and debug kernel builds:
>
>   not ok 1 1 selftests: net/netfilter: conntrack_sctp_collision.sh # exit=
=3D1
>
>   # Test for SCTP INIT_ACK Collision in nf_conntrack:
>   # Invalid netns name ""
>   # Invalid netns name ""
>
> The root cause is a shell variable scoping bug introduced by this patch.
> The new test structure wraps `topo_setup` in a subshell:
>
>   (topo_setup && conf_delay $SERVER_NS link0 2) || exit $?
Better to change it to:

topo_setup || exit $?
conf_delay $SERVER_NS link0 2 || exit $?

Again, please do not post the patch until the fix gets merged into net.git:

https://lore.kernel.org/netdev/cover.1775847557.git.lucien.xin@gmail.com/

Otherwise, it will still be failing in the NIPA CI.

Thanks.

>   if ! do_test; then
>       ...
>   fi
>
> `topo_setup` calls `setup_ns CLIENT_NS SERVER_NS ROUTER_NS`, which sets
> those variables inside the subshell. Those assignments do not propagate
> back to the parent shell, so when `do_test` is called afterwards, both
> `$SERVER_NS` and `$CLIENT_NS` expand to empty strings. The `ip net exec "=
"`
> calls then fail with "Invalid netns name """.
>
> The second test case (SCTP INIT Collision) would have the same problem.
>
> The fix is to avoid the subshell or ensure the namespace variables are
> visible to `do_test`. The simplest approach is to remove the subshell
> wrapping and call `topo_setup`, `conf_delay`, and `do_test` in the same
> shell scope:
>
>   topo_setup && conf_delay "$SERVER_NS" link0 2 || exit $?
>   if ! do_test; then
>       exit $ksft_fail
>   fi
>
>   topo_setup && conf_delay "$CLIENT_NS" link3 1 || exit $?
>   if ! do_test; then
>       exit $ksft_fail
>   fi
>
> Please also note that `conf_delay` references `$ROUTER_NS` directly
> (not via a parameter), so it too requires that those variables be set
> in the same shell scope.
