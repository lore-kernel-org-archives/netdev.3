Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC9F345CCA
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 01:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790126441; cv=none; b=AA+jwpJbTTHkywMZQvJ2beh28OcO/dcFj0H/vhy6aEq4XfIvJi+Jx98yHCMzb0ZdoOuKIUJToC7t9A2TNM9stWT71SmaA2t0vFO/3yGGu1lSl+eSGb+nmEUaOOJLhMIMlzePk2AFtRk8ewn2CQuB7EESGV4w56KXFYqLcblXmYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790126441; c=relaxed/simple;
	bh=I81iv3lczUS3G6IPpI6uKZ4DjFCsc5VGR7jHPqYVRgs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ot54fGUhm11P7yIo5nJrf4bENySQymz8p0TOe2UWiV0d3MCWEJwx0VdLxQ1G4GB6y+4fwRO1nfp3L/3wlN4T9Lbjzmu8Il6wDJv52RCQdTCrXe7w9g/w5VSS81kopskQvYB5U1FXGDuizrqLkMPGZTjcMyKs9GTqDKXFOnCfWng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BuDUsr2i; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BuDUsr2i"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33bfb26865fso317948eec.2
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 18:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790126438; x=1790731238; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bexp4Cp8y+5hA37h2dF2gaOO9AQzqDKE3dHgoAsDxks=;
        b=BuDUsr2iFSI6goqLTQcNUXI2wUY6rHleI30cULIc5XYxmWUBbSLBePQgdhl02a0qfE
         kefcvMTi5XTKPoANKdSykYk+0aPfMfkNLRc89wFh1FkoBB7Oeoq3VumV11NAYFlABqZe
         N9ykxm/lA0jy0WDfFlE0OdVQcZpkqt4IjFfQEG0XhvjzZJjfe2mK6vMArZHwg+eQpRd0
         qiXpnrtJr2+n3suEOQ4ad1cC38ZkpOZWe+roXDBJO/71sUrTFm4I11FJkpLWSX/6M+E+
         t0FRdbeChzmmoqRcutl0ha0MyZybBvSh8opSEUcPFjOjANGi2tu2HLkZPyqI1WmUvSs6
         PbYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790126438; x=1790731238;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bexp4Cp8y+5hA37h2dF2gaOO9AQzqDKE3dHgoAsDxks=;
        b=gk6/B5miv15CYvvmuE9GuyFCHNomiVDrRFtcstcNY6GoW5VaU8ndm/CUhxuqjJRRwv
         X7AfP7+zqwz2fx0I21WLdjWOvE+hrHA+MBbsAtIHt8PBY4RZT95l3FPiHmm9TPVzaa/D
         gFVvrzr1A+zn66kXNtRW6ubE+d1zn5hgDsQ4Bnq+4tUUWUJ1Xnso5PQmXQcBzQrjkuzJ
         LhYp7pIV4qi+W+sfS7ADuvLwzuWXIkQ+GZkaComP1ckKTR/95Kqm40lqV7Y2zsGzznct
         1CfDBwKD2UMmR3aBWCgzcmRJK1vCx3nHM4gOmbzANxUm5aq/AxnpCoz5GfZm7qT2IiPb
         hGNw==
X-Forwarded-Encrypted: i=1; AKwUvBwjcEsfuzUlb05uI/6BliXtaJz5tY39oe6QDMhhE8tHTkvg0JInE2HiYSGDhl+3bvYoDki0X3M=@vger.kernel.org
X-Gm-Message-State: AFuF++lnKjKMqcxmYkvyAfpjzB44t/bf/leDX2zkK0TkX+XpjeAkEz0v
	SefibuUGmzCQJBRYOjbjx9BX0gfBpKrrgh+24k2taNc+MMC8SdYDgvNS
X-Gm-Gg: AYBFou0ZGRrN6bf1YA2/BjfOo35fcS8AxxBoYVVpGLW669M9SMu7GCCMD9pMUDaYXzb
	u6+T0nVUw5oSDex1wF58hg05oODmtPuxtkBXIiblXnHV6AZTjbA2ySY/wZ9RtJa6lZ5IfRzf2rl
	mffZlfA6Re1oDTiIXNZvpzoXEMAi2MB9kBZcGz2VLAWahDxyY7c1cgJHyu62qn0hm5IcfSTXD3o
	0dCl2R6FvkVkCkOlKKwy9BI28dlge8eCOZvmhWSUm9TqtmPhejRR+wnjGTrtgwgrwGpqd7qICKy
	W1hWUrJNy8J4q8IIOkpYFPpiqLwnA29vLsh/AvtcoCvINVXdLsbK0X87WE/nEobuLXKeT9XK5++
	drsV0h1M/JxwZ/Y4dVnAG/kwArE/2Wl6668aUOX8VE5Rtx3gNtvvYXwStTypUtyTtbAdK0fxoja
	QniNsEGqm1A7+kO1i3Ymw+Mw3o4pErGJvJyG6vTVoOT3PypUTILpSj+q4D+qquQ0L4xPgwxEcdV
	kL1ZRptR2wUkCuMbgsZ0aBa3A==
X-Received: by 2002:a05:693c:60cd:b0:33b:e306:2e27 with SMTP id 5a478bee46e88-33ea3eb055bmr1139528eec.5.1790126437786;
        Tue, 22 Sep 2026 18:20:37 -0700 (PDT)
Received: from localhost ([13.93.150.60])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e96f47d52sm1953755eec.28.2026.09.22.18.20.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 18:20:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 23 Sep 2026 01:20:35 +0000
Message-Id: <DLMAUZF2EY4Z.2FZ7BR3O62LAS@gmail.com>
Cc: <dsahern@kernel.org>, <idosch@nvidia.com>, <davem@davemloft.net>,
 <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
 <horms@kernel.org>, <rdunlap@infradead.org>, <netdev@vger.kernel.org>,
 <aajith@arista.com>, <roopa@nvidia.com>, <jhpark1013@gmail.com>,
 <corbet@lwn.net>, <skhan@linuxfoundation.org>, <shuah@kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3 2/2] selftests: net: test untracked NA
 recovery of FAILED neighbors
From: "Lawrence Lee" <lfqlee314@gmail.com>
To: <netdev-bot+sashiko@kernel.org>
X-Mailer: aerc 0.17.0
References: <7285b55a1e29d2f04de4e3fe1e723a9724e0377e.1789734885.git.lfqlee314@gmail.com> <179011668031.2160803.1030111847497325728@kernel.org>
In-Reply-To: <179011668031.2160803.1030111847497325728@kernel.org>

On Tue Sep 22, 2026 at 10:38 PM UTC,  wrote:
> [Severity: Low]
> tcpdump is now a background child, and cleanup_tcpdump() is the only plac=
e
> that kills and reaps it. Can that child be left running when the script
> leaves through a path that never reaches cleanup()?
>
> cleanup_tcpdump() is reached only from cleanup(), which runs at the tail =
of
> test_unsolicited_na_combination() after log_test() returns:
>
> 	log_test "${rc}" 0 "${test_msg[*]}"
> 	cleanup
>
> log_test() can exit first when the script is run with -p or -P and the
> operator answers 'q':
>
> 	if [ "${PAUSE}" =3D "yes" ]; then
> 		echo
> 		echo "hit enter to continue, 'q' to quit"
> 		read a
> 		[ "$a" =3D "q" ] && exit 1
> 	fi
>
> setup() also runs under set -e, so a failing sysctl there (for example
> accept_untracked_na=3D2 on a kernel without mode 2) exits the shell direc=
tly.
> There is no trap cleanup EXIT INT TERM anywhere in the file, so in those
> cases the two namespaces from setup_ns and both mktemp files are left
> behind, and if the failure happens between start_tcpdump() and
> wait_tcpdump() (for instance the new slowwait 5 grep for "listening on"
> timing out, or host_link_up failing) a live timeout 15s tcpdump keeps a
> packet socket and a netns reference until its own timeout expires.
>
> Would adding a trap that calls cleanup on EXIT, INT and TERM be reasonabl=
e
> here?
>

I would lean towards no, since tcpdump already times out on its own and=20
any orphaned tempfiles or netns are a pre-existing issue. No change=20
planned.

> [Severity: Low]
> This isn't a problem introduced by this patch, but the absent-entry branc=
h
> of verify_ndisc() still discards the exit status of ip neigh show and onl=
y
> tests that the output is empty. If the command itself fails, is the empty
> output then reported as a pass without the neighbour table ever having be=
en
> read? The same pattern is present in the baseline version of the function=
,
> so this is pre-existing; the new expected_state branch fails closed. Woul=
d
> checking the exit status of the query in the else branch be worth folding
> in while this function is being touched?
>

Pre-existing issue, will leave as-is

> [Severity: Medium]
> The new rc=3D$? capture also repairs a reporting bug that existed before =
this
> patch. In the baseline the sequence was:
>
> 	test_unsolicited_na_common $1 $2 $3
> 	test_msg=3D("test_unsolicited_na: "
> 		"drop_unsolicited_na=3D$1 "
> 		"accept_untracked_na=3D$2 "
> 		"forwarding=3D$3")
> 	log_test $? 0 "${test_msg[*]}"
>
> The array assignment between the helper call and log_test sets $? to 0
> (none of the assigned words contain a command substitution), so log_test
> always received 0 and all eight existing combinations reported OK no matt=
er
> what verify_ndisc returned. Capturing rc immediately after
> test_unsolicited_na_common() changes the pass/fail semantics of those eig=
ht
> pre-existing cases so they can now actually fail.
>
> The changelog describes only the new FAILED-neighbour coverage and does n=
ot
> mention that the existing reporting was broken, and there is no Fixes: ta=
g
> (git blame points the log_test $? line at f9a2fb73318eb).
>
> Would it make sense to split this into its own patch with a Fixes: tag, s=
o
> it can be applied and backported independently of the new mode 2 and
> FAILED-state coverage, which needs kernel features not present in older
> trees?
>

An entirely new patch submission seems like overkill for this. I'll=20
update the commit message to mention this change and add the Fixes tag.

pw-bot: changes-requested

