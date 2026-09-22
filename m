Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F9B531AE6
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 22:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790117843; cv=none; b=lWHJPsSXJAmRobuh5ug4FcHmeNcFX2bfgmXyhF3Ltao8hUCNLFi5dYYHUdiTmhDrWg3zA8oycGKmdWgaDNuk7x6qdxKtfAfwsqD8kTgMkweoY9O9wtK1Js8gt4x+O6mEfDwl8Sck9+2CBh06flDciJF2zzpcdrzT/3/2HwKd5Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790117843; c=relaxed/simple;
	bh=MlvWhc27/Wnf3UCEBSDCmF0Yz4ceH7CgS4IWEcLi5ps=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=log2PiSODAzJSQmJIcK99uRzyJmir15VVPyzJHpExGz34JgnssPoL1IG2Awdnqq3yQGj9NSDn5K2OiPe6nLQMwbic/HCzCoo10WAfvNw+JQ7r6/35bpMqfioRtPo/BQCYY48ycPJpfBIEzALtEEu0gp1LVZf8QupE5GyciSZ3bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=begyv8G6; arc=none smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="begyv8G6"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-328664dbdd2so107552eec.1
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 15:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790117836; x=1790722636; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aTPRvJvF/abYMEvNmlO3pHSl3zMEUYZicwYugH3SZJ0=;
        b=begyv8G6XJ/FzFdJuULE8br5tO1zsKNxSKio2GXNGp3dIV9hb9stcfr4ywXNyFJX/s
         YF+QXM3bXQltqABrbQoYNW96qG1i1b0kGQkP+kCLIebmoqibk2s3eic4FrBRgvHFRH0n
         1oc3l/uVcduHcR/cmTih1GhuhAjWQi+ej8VCCmndmWZO1aLrSxqegbLM4icqJZEZ4sIX
         XpbfONxu+hg85oHYIHhd0KALNi2rC5QPlAEeo/embF2vXIlBRRMLTym5D0lH/POVQ1op
         2TPcoVn4bVZLkuZp/8MK+vQkkdd59ANOnT3PGRK2dfPoAF9LRQYkzpt/Dyz7OgYjVp4H
         czCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790117836; x=1790722636;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aTPRvJvF/abYMEvNmlO3pHSl3zMEUYZicwYugH3SZJ0=;
        b=O6+7DbYWOoO1LgwlHNKV17zwK5SqkEyszkd94ig0tuqDW/SqEwIDh2zQfvpNc5j4kR
         evY1LAOXMVd3cWyTt1V5XY2g0TJP18rr6sbI5GpNzRQTssmVZJOGPFajcf9eVlq8uR7M
         V6jWgqezJlBP740aJlB+Etv8UAeRd5wsQ+bn+BH29tSphcHohQiR9vcP5dNsODLW3q39
         Bh+iWzWT8sjsYyyd++TS4mmgTSKqB+L57G8rM/35zvs/Endt3da4i+KgMwoQZSic2Nlf
         VMgX3Fds0VWX32L8wFce9vc97cBWYNtXmeVUaCpxXt8hOIGNBeq/tSkjXYgDUlXfBjUa
         x/uA==
X-Forwarded-Encrypted: i=1; AKwUvBy3qIujmmtUCriL3dCrRnyc42OM6dYPIVqJ6bA6BE1EmJSU1xGrVeWheq3kq/PtxPqDHkktHQk=@vger.kernel.org
X-Gm-Message-State: AFuF++m1ECzmyjABhdDdWykwKNAPey1Uv+aSlsvrzIAN5B3d6D5BsCrA
	toRXVbvsvTOvSbNZERUM9Gb/B3RBrUJ4/DjgGOIxlKXGoCBA8wnf5/Lc
X-Gm-Gg: AYBFou28Y6Hope3V0GTFJO5WfFoV5/RIrlETe2QuNwca643bQarhBeOasXnESfq6CLg
	7y2X9LxqJrqftt2fFdqxAmH8tickkaZ/oPj6wpyAidRGAXQ4KYRA2Avp24RkgFCw9TWuAX2A0LK
	TyiDwa5SG0Cj4e1iB/sdJws+jpsd9iUpJupXqGf8CYwwZsRPrheoJM4YiYL3YmcPgayYewnRLmL
	9IiQkbiyUcbpegQI+umc8UKfKUfxqIJzwgjIEU8VsjAB+5Hr8xYmyL52BIivpmOIlP06yGD6Bl5
	5Wndffyp1YxxOqpm4HjeTDsFifj4fSMJ+A+QlAATl3ZNF/mdFoEQEeyQvUjfJhpYxWQvQdXeKXA
	grbcanXAPfWb2JNNI4Yt0GDQ9d3sr5LvNh4pHA7TH5d0w/Ut5isws5Qfm7e6gmE1kgWfJ4rvnWu
	yw/KWbce8T0USK7wWgMrd4UoMB/G4Y6JCc4XpCmnlK5/tJZC2i4wawDZmofI7Kk8JPLK7QR6U0p
	tyIip78ElPHBfRRU2uwi5IpmQ==
X-Received: by 2002:a05:7300:b0d:b0:33b:f3ea:db21 with SMTP id 5a478bee46e88-33e7a2d8a2emr903397eec.4.1790117836248;
        Tue, 22 Sep 2026 15:57:16 -0700 (PDT)
Received: from localhost ([13.93.150.60])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e96d497e1sm1241801eec.25.2026.09.22.15.57.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 15:57:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 22 Sep 2026 22:57:14 +0000
Message-Id: <DLM7T8138Q0Q.HNNP2M4NLPDL@gmail.com>
Cc: <dsahern@kernel.org>, <idosch@nvidia.com>, <davem@davemloft.net>,
 <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
 <horms@kernel.org>, <rdunlap@infradead.org>, <netdev@vger.kernel.org>,
 <aajith@arista.com>, <roopa@nvidia.com>, <jhpark1013@gmail.com>,
 <corbet@lwn.net>, <skhan@linuxfoundation.org>, <shuah@kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3 1/2] ipv6: update NUD_FAILED neighbors from
 NA messages
From: "Lawrence Lee" <lfqlee314@gmail.com>
To: <netdev-bot+sashiko@kernel.org>
X-Mailer: aerc 0.17.0
References: <e5b7a4f8cbd7c436b463b3751bf283ce861fcfaa.1789734885.git.lfqlee314@gmail.com> <179011667864.2160803.5487538537038042784@kernel.org>
In-Reply-To: <179011667864.2160803.5487538537038042784@kernel.org>

On Tue Sep 22, 2026 at 10:37 PM UTC,  wrote:
> [Severity: Low]
> This isn't a bug, but a note on test coverage for the new FAILED branch i=
n
> ndisc_recv_na().
>
> At the time this patch is applied on its own, the in-tree selftests only
> walk the "absent entry" rows of the matrix: the matrix comment in
> tools/testing/selftests/net/ndisc_unsolicited_na_test.sh and verify_ndisc=
()
> start from an empty neighbor cache, and arp_ndisc_untracked_subnets.sh do=
es
> the same for the accept=3D2 subnet rule. That leaves the new
>
> 	if (!neigh || (READ_ONCE(neigh->nud_state) & NUD_FAILED)) {
>
> path, and the FAILED rows now documented for accept_untracked_na, without=
 a
> test.
>
> This is addressed later in the same series by "selftests: net: test
> untracked NA recovery of FAILED neighbors", which extends the matrix
> comment in ndisc_unsolicited_na_test.sh with the six "failed" rows, adds
> initial_state/same_subnet parameters to verify_ndisc() and
> test_unsolicited_na_common() that seed the entry with
>
> 	ip neigh replace ${HOST_ADDR} dev ${ROUTER_INTF} nud failed extern_learn
>
> and then adds cases for accept=3D1, accept=3D0, forwarding=3D0, drop=3D1 =
and both
> in-prefix and out-of-prefix accept=3D2, checking that the lladdr is learn=
ed
> for the STALE rows and absent for the rows that must stay FAILED. So the
> gap exists only for this commit in isolation, not for the final state of
> the series.
>
> Would it be worth mentioning the follow-up selftest patch in this commit
> message so the coverage relationship is visible when this commit is read
> alone?

The cover letter already mentions that tests are added in a separate=20
patch in this series. I'm not aware of any precedent or convention to=20
mention follow-up selftest patches in commit messages for earlier=20
patches in the series.=20
