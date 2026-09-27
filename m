Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB3D423E99
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 19:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790536172; cv=none; b=gweKHQ0E+EcBe3SwBucFdkQfi6HFz1drDbQWwd9izRSM6/cBErWOgHIvASLcGw4Ol0dw35QDWLY0bENrdkRPwhZ6fFE53rONLEIwDR/kkqcViLvBCsoQeySqRT1e9RBFsonmX4kWPpPdQCPr9gFzwyQbpQD7VLQbWcpI+bqmNkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790536172; c=relaxed/simple;
	bh=/Ncv4pmHB2k5k4a6mo3lzenG6x84qqCfM0wTLNgXudw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n7W/MTEGZAFr4kELm5UFvH0g6hTA7G+2AQwY5QNLPLPNb3ObW46hZ77ltz9/UihZek/HRqHO6vuB8Cn7EZNFW/A3xVDAAc/TbAocyQot7gGFA7JgxT90wuZNsBdGtLklEXYx5McWXYy0SVztVyPDsN9VRGObS7PI41iaQrtLpvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N7WKBKll; arc=none smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N7WKBKll"
Received: by mail-pz2-f40.google.com with SMTP id d2e1a72fcca58-87c90648f99so1840399b3a.0
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 12:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790536171; x=1791140971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OPb2gJjQHkq+JlwtbOznBiTNAc1qQBhHXizpCBFuJII=;
        b=N7WKBKll8PWhnGQ1FyXM1gC3akstDhXuQvYgtpMaF1ek2oO1W1j0eSc9bEi4miPqa8
         VSUsm97a3IZLk8yS2LoHAA7TRKip3Zn8kvwHFYVZucb46fYp7+PPIGL4AGgpF9ek2E3O
         oAAYh93be1C8yuOqHPDBYnjzkRj2KmmVA1VXkCByWjwJ3vqJ7oxPIx6UoIJGjlh7seP9
         7UKb0fH1/zYaKWK4PHUDiw1L3Tg8Xvrg2/y3069ttozpaF0Q43EnexupM4tvYJ/Ig4b8
         xHE6U03/kLQWaM6z9vPGew6OXTHrDIvpum86R46o2DbbDcO+3b35xibdQ0q4kuDr/87/
         uMtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790536171; x=1791140971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OPb2gJjQHkq+JlwtbOznBiTNAc1qQBhHXizpCBFuJII=;
        b=rSeBcDu1DCTvRFgAGvnEMac09WsjJbdVclZKcTmAFxEkAvbiYwy4h/5+GMiYiytchC
         EqpNLHAkNmDB3NBecp+5C3ZaTKx2GdzTC69JG1Y2oBP4Zl/KmOOwud5CRZSpUcgbWnQ1
         PfjKAYAphVnnTfdpc3ZeOlrjKhjo5J4wUviTnwtMVM0A4+UTdx5soJ2nHFdft8d123me
         B0qAo8LZ7usin0jpjY7GBTBE3s1Ef/VurlRwjLDNwjmEVSQW7Wm0YppOwQvDR6DsZ43i
         R1jy56kcEZrsFjcfD/M+Lvw/14SQ+mopOcGhmLSEFGsfWZ9y7hvuIZG3YyJ3QEqLEal6
         /T8w==
X-Forwarded-Encrypted: i=1; AKwUvBxBVmdVneHadTrUVUdZyjzOB82d9IklZraeLevK1NyYrNi29YgUfN8xndjmOv0OMvJ7GKmUiew=@vger.kernel.org
X-Gm-Message-State: AFuF++mX6v4mMERotVlwaI41RcAAmkkv8to8DLSTWRPNEJLhNORuDbvm
	BUGoxu7X51ZsHCdHtdCvS6R0LvwdIhLKEdlHpkadJ4f3fb3RGkwXMqkV
X-Gm-Gg: AYBFou2bK+w2+up9Rk3/6+ZI9F6eGKgiQ2AWUIXuP8DpYkfIi5OOwbXtBisLe9oLIfy
	gCHa7Jvd2WUUR2SLfpTxa3dnpfPUPnmHUlER4SKCwAXk79ns6DZdyVRs2LIwIuP+sZkVAaaou7P
	Camxzyfa/NhfE6oQsl6gBwoX1QTZPIB7bDlVY4wcYuIOXfII3eZzMPqvbKzBc2b8+MiTSsB9FVd
	pYfrWIgs3TEUNHuIT+SmbjwpfOGJVSH7CvvSF86FN/URTltpagEXrAxHkMUpgcnIC7wYgd5TWoX
	1jRjJDa3WLv1Li/22n4LjssgTRLzE3WoQg3LjQ0cydO1Cfw7QWt8iw0+XGShvlnqP32X6fhS08u
	jeenS95UHF6bhY+HnMduzih3BQuOetAGip19SexM/YCmlR8QFCBLSAtCvKmJqoKZiqlmipgv7IE
	Q08k25Ja2+DD9CEG7YW/OfoebITS8XceflbWlGvgKfApSFkXAWPrpjPZGoSitEz2E450W3Olpin
	bZxV+vh3eQvyy1Y/d35JD2d8YgW4YHlVPqSdMvxsQxkDc5+NZ7anBz8r9zXAqEPkxVxGvHW5w==
X-Received: by 2002:a05:6a00:2347:b0:881:e266:c3f1 with SMTP id d2e1a72fcca58-881e266c8fdmr2589039b3a.21.1790536170813;
        Sun, 27 Sep 2026 12:09:30 -0700 (PDT)
Received: from Inspiron-14-5420.. ([2402:e280:21c6:671:6651:2efb:bfb:bd73])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87feb385ed8sm3204478b3a.45.2026.09.27.12.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 12:09:29 -0700 (PDT)
From: "Hemendra M. Naik" <hemendranaik@gmail.com>
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	hemendranaik@gmail.com,
	horms@kernel.org,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	tahiliani@nitk.edu.in,
	vishy0777@gmail.com
Subject: Re: [PATCH net-next v8 2/3] selftests: tc-testing: add fq_pie per-flow class stats test
Date: Mon, 28 Sep 2026 00:39:15 +0530
Message-Id: <20260927190915.12527-1-hemendranaik@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <179028364138.2160803.8521628163584007831@kernel.org>
References: <179028364138.2160803.8521628163584007831@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thank you for the review. Our response to the low-severity comment is inline below.

> [Severity: Low]
> This is a robustness point, not a bug. fq_pie_walk() in
> net/sched/sch_fq_pie.c only dumps flows that have a non-empty flowchain:
>
>     if (list_empty(&q->flows[i].flowchain)) {
>         arg->count++;
>         continue;
>     }
>
> That makes this ping the only thing that gets class 2:1 into the output.
>
> In the standard tdc setup this works. nsPlugin runs the command inside
> the namespace, dummy is NOARP, and the 98-byte frame fits under tbf's
> max_size of 100.
>
> If ping is missing, or doesn't accept -i 0.001 / -W 0.01, the "|| true"
> and the redirect hide the error. The test then fails as a regex mismatch
> in the verify stage, not as a setup error.
>
> Should this step be allowed to fail visibly? The same pattern is already
> used elsewhere in tc-testing (infra/qdiscs.json), so it may be fine as is.

Keeping it as is. tc-tests/infra/qdiscs.json (test ca5e, "Check class
delete notification for ffff:") already uses the identical pattern:

    "ping -c1 -W0.01 -I $DUMMY 10.10.10.1 || true",

as a setup step whose only job is to push a packet through the qdisc,
with the same silent-failure trade-off described above. 83c0 follows
existing practice here rather than introducing a new one.


Regards,
Hemendra
