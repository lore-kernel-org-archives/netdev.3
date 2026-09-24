Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139F616A395
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 05:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790227825; cv=none; b=abhASbogVatjWcg3pR1h4rlkNrWkVAtUfkxr0taztDVdrBW/nrqMH0KZ1Z4IejWozkjKwo1CkFEl0BdRsgT6M2yXalz4oGtfLhrGrmhtIjpf97aXLJ/GtLLW8zTG4NxZlF9UFrRQf1FBq0qP5eIj4QcRsL31ShWfvjUxMcd2iWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790227825; c=relaxed/simple;
	bh=Ay4fmhsJGvr3YQ0A6NPN0+C4V+l/9BVHMKz93pYHwYk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YZEvmWVLhuoiwkHbxM3Y4hQ2sJBT/cn+YG/Pjlw7HOUPdzEep6mVsemnfkVNgXo8RRG/mIO1GluONMJ5osmEGpoDzHIGc0AVxttiMmvMsTWLPGhgKESB7vUWfZD8rA28vaubf2ILylf7VagRoyFtbrwDwRARcD9vT5SOrBUVXHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Usopi51r; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Usopi51r"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f635552aso1330771f8f.2
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 22:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790227822; x=1790832622; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Ay4fmhsJGvr3YQ0A6NPN0+C4V+l/9BVHMKz93pYHwYk=;
        b=Usopi51rQQF98z/WjmYLSp1ooQmqkEdZirENuPiRz5HqOBtA6w4vxpQPccJZWCfVDP
         zLZYtgF/TMDtFsKSXhkBUaqpJdEYTJoppEB2OolIGzUZ0HYJlNFhUefNRdiWdgTjCgs1
         fmDzsAdE2mHnv/7tKJPEfCpaQzYkMIFkhOi1fw5QbZ7OswMspcuwpoOZn9AXZlq/rTMu
         oa1QD/Xer7DH8uKc7wYvgfeKB7k+78LEKDwE3xbNOnTGiNMqUriEMTIUCN4N6fU9PqCd
         IBgunbMgW9WPU8PE1kiWn2E6JUZbpc9Q+zQYHxtIajp7nOfEQaBezQTuwDHx9kLPr6Hz
         69wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790227822; x=1790832622;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ay4fmhsJGvr3YQ0A6NPN0+C4V+l/9BVHMKz93pYHwYk=;
        b=i2dDUUnvcgXYDrGPpU0VXJavA7s8xDzVlrv8NBpp5/AJ3NvrR1UQAgaFL0aNzCvncb
         ghpMPYomIezMoMwwdHA9JScLuJV7TVUceNe86FpqQjzT5ZwE8c8xRbEBIGmgYun64uWf
         XVkfIA7MBxc0Y0UdsWlwSY7RZFJNea2IUx2vyPY58CXX7AqA3l8/K/syAwBD56Rjl261
         bVgTtYkMalUt/B4+5xXAF1FBBTBn9r76Uz8hIdHpDBHVlRNm+VIiBrwTuOD6Gk19RxOK
         VBY2SSB1EZ75XRHeetIsCx5w35s5HNSSE4Jn8zMQhyP14nuDOXYNt/2B1N74nPdKbGW1
         zZRA==
X-Forwarded-Encrypted: i=1; AKwUvByqavsXBbLn3aL59VaQhc5DOi8F3kiy6p6xohE2pDnYEPLUd/nHI9biOBZJbHB3ealdldtPCTI=@vger.kernel.org
X-Gm-Message-State: AFuF++ku7q2bUCKt7Yc1mTElCR3LaWQW5Nnx5I0UwG9/nvM6aCmTcvGE
	a/sBYT7ZeWzfpNjlh1rJd2hfr0+mr9UZv0tam8ulyDTYM7YF63rrdX9J
X-Gm-Gg: AYBFou38Gm6yJgOMUx/LE4/mvKgBTtv3U5UBRA2lnzKd1KQM+4qE1RonqOqcwXtXWKd
	X6fCDuLWJ8H0n37FrO8FhZHgClE0WUPLSBv7an3cNRx5+ZWtbD8fnZgral0Ed/f/C3r10jjqjws
	CJanyNsYhPq+b1rt6e/TQJLPrSbNckDWDGiXBfK3VqaGqbwhpmIOhG+oHLx6ZaIQlrnr+vn897P
	MpXPkzZ1zQJO92Fn9B1H/ryf3koHjYONHfA+GW3BDbOet4ttoJ5VyMQgpiDXkql7H6JmyaC/zO2
	PA4W6l/PFMEbUqiHAZ3YbI5zsI/5eWJTElrr8YrfdPI7jpn2r06dNbeRlyg6UuAW2jDZus8y4Dn
	g5IMhGyxQEVnKefHf8Dd+80fR70Z6IfhM3Qes2MkCy45kOFjuecYC628xzyk/jOelbQrHXoNLpk
	dT16+4cxIZB3egjwHS1MGufz0fWHO7JgGmcia0T4/YTZ9WzmSuyPp4wZZBQP1cWD8RD/Ti7A3+g
	O7SlVgQM8q2m84R1aFnUrzSFpe4M+YKIqjltadGcVu05f6BJCrFKNYhdX3m7/Tmsp8gc6uN0ANB
	rQLXQeHfL4+CxhsS5FmYWWbxWuSIfCA2Mka50uvS0ABBdg==
X-Received: by 2002:a05:6000:4812:b0:487:931:946e with SMTP id ffacd0b85a97d-48872a5cc7fmr1371456f8f.1.1790227822011;
        Wed, 23 Sep 2026 22:30:22 -0700 (PDT)
Received: from [10.148.84.254] ([195.228.69.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4886876c1fdsm13629259f8f.14.2026.09.23.22.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 22:30:20 -0700 (PDT)
Message-ID: <7f82e52d5495cf61f7debf860ab5585d03ebfb66.camel@gmail.com>
Subject: Re: [PATCH iproute2-next 0/3] ip: netns: report the network
 namespace cookie
From: GMail <primalgamer@gmail.com>
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: dsahern@kernel.org, stephen@networkplumber.org, petrm@nvidia.com, 
	daniel@iogearbox.net, ferenc@fejes.dev
Date: Thu, 24 Sep 2026 07:30:19 +0200
In-Reply-To: <20260923161756.2914560-1-idosch@nvidia.com>
References: <20260923161756.2914560-1-idosch@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10+b1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-09-23 at 19:17 +0300, Ido Schimmel wrote:
> The kernel identifies a network namespace by a 64-bit cookie that is
> assigned when the namespace is created and never changes.
>=20
> The cookie is reported by a growing number of trace events such as
> the
> TCP-MD5 and TCP-AO events and the net device events (e.g.,
> net:net_dev_xmit). This allows filtering events that occur in a
> specific
> network namespace, for example:
>=20
> =C2=A0# perf record -a -e net:net_dev_xmit --filter 'net_cookie =3D=3D 12=
'
>=20
> It is also available to tracing BPF programs that can access
> 'net_cookie' in 'struct net'.
>=20
> However, no utility currently reports the cookie of a given network
> namespace, so mapping a cookie in a trace to a namespace requires a
> custom program that calls getsockopt(SO_NETNS_COOKIE) from within the
> namespace.
>=20
> Since Linux 6.18, the cookie is also the generic namespace ID and can
> be
> retrieved via the NS_GET_ID ioctl on a network namespace file
> descriptor. Unlike SO_NETNS_COOKIE, this does not require entering
> the
> namespace, so the cookie of any namespace whose file can be opened
> can
> be retrieved without privileges. A kernel selftest [1] ensures that
> both
> interfaces report the same value for a given network namespace.
>=20
> This patchset extends ip-netns to display the network namespace
> cookie.

Super useful, thank you!

>=20
> Patch #1 imports the nsfs.h header that defines the NS_GET_ID ioctl.
>=20
> Patch #2 reports the cookie in "ip netns list". It is always reported
> in
> JSON mode and only reported with "-d" in plain text mode to avoid
> breaking scripts that rely on the current output format.
>=20
> Patch #3 adds "ip netns cookie [ NETNSNAME | PID ]" to report the
> cookie
> of a single network namespace, including namespaces that are not bind
> mounted under /var/run/netns, such as those created by container
> runtimes.
>=20
> [1] nsid_netns_basic in
> tools/testing/selftests/namespaces/nsid_test.c
>=20
> Ido Schimmel (3):
> =C2=A0 uapi: import nsfs.h from last sync point
> =C2=A0 ip: netns: report the network namespace cookie
> =C2=A0 ip: netns: add "ip netns cookie" command
>=20
> =C2=A0include/uapi/linux/nsfs.h | 122
> ++++++++++++++++++++++++++++++++++++++
> =C2=A0ip/ipnetns.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 71 ++++++++++++++++++++++
> =C2=A0man/man8/ip-netns.8.in=C2=A0=C2=A0=C2=A0 |=C2=A0 30 +++++++++-
> =C2=A03 files changed, 222 insertions(+), 1 deletion(-)
> =C2=A0create mode 100644 include/uapi/linux/nsfs.h

Ferenc
