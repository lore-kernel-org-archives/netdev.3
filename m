Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794089762;
	b=TSECg7J/98kC/Vl8onLFwrS7uZqFM2wI0gViHobmxEzN7+m2fzBRfCLKeAykCd/uP1La
	 oeQiouPaJBhH4fsV19zcKnrux07tHhGl1VKeExKnFDGDz4guQh2Bthvgt8rKhOb3LWZwY
	 W+WTNKnrP3I47mYGqCTJpxPHwsvc9dHdxMJon4o+HPdpkSVKUAVvyVd5NLc9tfaCQEOm8
	 HKMq1vahhT82VZqYTufaM1YUuHOyHOPq1LB3nh+uplArXJfnCrkSa5Hd/xLz18RtX66Yb
	 qN0Gm+KH8de5rT+hrTe4bsFD1pdsD8kJEhdHYeZE2RloPkC3ZIqI26SxaLQ4WANfaUQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794089762;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=o4tz06DzCLHV+ZlaAK8efvWKy5+EgQA7F7usPbcqp/o=;
	b=TjaeyBBd2RsbqiaX98jeM1Y7ABPHd99HrX7V94/0DfqKuv4W3Vi/2XDk2WSaiq9uAcax
	 Gac75+vfE3np9IeVKrHJcQW7n7/B16+fqvbYFWWTWIeSZR0O2m9dG0zmbLK0X1mONQ0RU
	 UBW1uKmp+++TMKZ1ldZM5jT9aKQ19UsHe2pGPcp9EgeNSkyaCeMSFdOBmzAxv8I5sSidU
	 6de9JlCxagLVVJr1moGOx6jLwEXTwoIhj5THwml0nn6P8htaaOhWNmtZF7Zi01dA58VLt
	 Z7d13u9sP788M5cZJtRUZSSp4cvqH7rJaGyb/vJhtHkrnQQzUUwYSmFfI2UesG9eMpQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=b6B1HkjM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.178
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CD1606A326
	for <netdev@vger.kernel.org>; Sat,  7 Nov 2026 22:16:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7CD1606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=b6B1HkjM
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8a0673d9bd2so28244b3a.3
        for <netdev@vger.kernel.org>; Sat, 07 Nov 2026 14:16:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794089761; cv=none;
        d=google.com; s=arc-20260327;
        b=O6hBGNemqSD3yfnqHIN/1z7s5QxFE+bNJR5fT78B7gg9vSYyQzkvfc9JpUnU/LCVAQ
         g5HcC+3W77gvcM+YdWefzOjC0mjF1qb7DRAgyb9b4Vflj2Ow5ZQhzLHAIaUvdLi/T6JO
         3f2DaeaX4TmFAPg1iyvQvCxhuctvz4GPVnQuEj0LBiwzPDiY2PRIKBMFGOxt9b+Oyome
         8jgR//K30j1Mf04D/eBFdkf8t5jSEgst5f+J4wGMCAoOdDuJxkzAmLMZHIoP1AbJU9PH
         PDFBz/4GpPR+q2IPTRS8mNA1xlQKxgwC74j0a9D+5cYBIuXyfzXbAQIFdNS7bQJoPQpO
         Olpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=o4tz06DzCLHV+ZlaAK8efvWKy5+EgQA7F7usPbcqp/o=;
        fh=Wb9DVDULmpc6j8VpUw/87dSUm8bUBKa2Tfv3D2tp0ZI=;
        b=sGdt9SI52JpheQ7EkCRKyzk0p/aihl+i5tOVUQQ+jGuDDXFnZ9wNzK5eBLD8AqPrhC
         xr+ujsSUICnPF7luPSmBfn2i+yLz4CmQ/wBMi9PK+OqfmFr/hrn5GMGPByDIrC5sL6lv
         iKK3L+nSlAjKDFu25LMBfXrsPYSaIgrXRR9NEd+f/dSXHIWUdLae6k7lHzR7leuSgzsm
         CcuTKhFB6/x2LpogyHy2AVTOCTVRjBpXEhk2ZKkJSVNt+1beGttMoRAPuRnRUi/8ithB
         Gze0b/N15eciXsp4M/LyXEtANEs0CNiJTwrhJJhit68woi0uio+sTqD+YZwDgBRDhR1F
         mqoA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1794089761; x=1794694561; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=o4tz06DzCLHV+ZlaAK8efvWKy5+EgQA7F7usPbcqp/o=;
        b=b6B1HkjMie2eGJo3x8MJmf60WsxZxJJdti4ZsqUx0TMMxyZ79rdu3kQQc6rFk0D5sa
         ZsqXWWEVjbso/gRYe/uPyC2uwx4/Bhz6ACkkSiO7TYzk26LofQnI8avHKILhdp1oM6I+
         j6DoiWo90zQi9A6fJOjmq47PZja6MkjlMn3/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794089761; x=1794694561;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o4tz06DzCLHV+ZlaAK8efvWKy5+EgQA7F7usPbcqp/o=;
        b=ekDac14S8Xc+yDAOkFtLAH8CgaD0HYqixRnLLw5F2YF7nFO75n2Audz0nGMtuGigwK
         9jronFkJyEcTB+Vy1X8H3IbqnRIJmt36rPgGTMHeuAROPVFswIt+6EUAkB1+JTHDnH6U
         Y5DIJxhpsX1Vx5DGp4P+clArob3zhuMQOaby5RqNgkzVpCrKpmFDnktdCkrb+HG3FhL1
         cld4Rk+eUf0/IfmurmYyWj0FeGS86NVSKaAI7dISLJh6cG+Jh7ok+N3rXI18+395NtAw
         X/TAYV0sbwgpe2f9jBQ9qV5vsS7C1/XgrynwNlcyaZg6xMVQv0sPuq0fiz+xwMsi8hWW
         ue1g==
X-Gm-Message-State: APuU4Z/WAdSRiw03Rwh6aV8FHAuXxhPyxaJ43HnckR4mX4AWruaRaS7y
	aiIRigbHn99nA0qm5OKBm8wipXzWgCRCYJ/1QbXHxILl71atXo9GD6CZqBA7u8T1b/AK5OfGAdb
	Bbz+TFxk5XS8EU+/w4Pj2Jct5Xb40nAWaiUGYJSQ3
X-Gm-Gg: AYBFou0Mrc2V78RgLktyC8SFKRihzUMGfsIT6ESJFMrzXD1kfJ2L8bCV3SjXKu2fPxP
	AEBeALysCCyD4LxZloe6YAULNJLCTZLzUqjModmldlJi8rpmuV/T1IABYQNfdSmmB/uliDZQsjs
	7d+brohi0x0fsxrArwmD2rzbEHiXwZYdIXBfj3RoOSYWNIJwvBk+w9YwWcTwhLaX9HUWGngwiKG
	1tKamGAosdSsj9YQ8O06Ocw1ozR90TEr2U/m/LchWWqPc3iyJGsK+avBVBGoKksnQsFb4Yf04GK
	fVwGaTkZ6kZmTUZZmZQJyr5xJm+w3OlRVULA9qDdWqOTjiES2egvn95F9jB9218vQYVFCqU6OsM
	4tNsjiQm6mH3aDgYXO08uJJu8zFqLOoUH1r3hlR3RSc9CC3Ut+kuYUrq/CKiof9azbGG/DUvvmX
	uKSCqrMnjrUPrn0J4=
X-Received: by 2002:a05:6a00:3d4d:b0:8b1:3137:d78b with SMTP id
 d2e1a72fcca58-8b67082f822mr37510b3a.48.1794089761173; Sat, 07 Nov 2026
 14:16:01 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <SER-NSBD.v3.r0.20261103064310-4@mojatatu.com> <179406302081.994134.2324214805948881495@kernel.org>
In-Reply-To: <179406302081.994134.2324214805948881495@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 7 Nov 2026 17:15:49 -0500
X-Gm-Features: AclHuK-EImvDmozLrSXa89DezzPdIm_N3VnO1x4Pj8HHQtC5v1kgy6BRB_djrq0
Message-ID: <CAM0EoMnjMoHQ2kU01naxDT0L3JXx61uKa7XBEWSQTJ9DaUa0_w@mail.gmail.com>
Subject: Re: [PATCH net v3 4/4] selftests: tc-testing: teql: cover each attach
 rejection on its own
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, shawnq1@163.com, 
	davem@davemloft.net, edumazet@kernel.org, horms@kernel.org, jiri@resnulli.us, 
	kuba@kernel.org, pabeni@redhat.com, victor@mojatatu.com, 
	thomas.goff@boeing.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 7, 2026 at 9:50=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wrot=
e:
>
> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in ca=
se
> you want to address the nit picks below when you respin.
>
> Low priority / nit picks for your consideration:
>
> - [Low] The commit body describes the patch as a change relative to an
>   unmerged v2 posting, not as a change to the tree.
> - [Low] Both rejection cases check only that tc exits with 2 and that no
>   matching qdisc is dumped.
>

Again cosmetics - so far no reason to resend.
6a06 is added by this commit, not by a previous posting, if i resend i
would reword to state that.
The module point cannot cause a pass here - it would fail several other tes=
ts..


cheers,
jamal
> --
>
> selftests: tc-testing: teql: cover each attach rejection on its own
>
> This commit moves tdc case 124e out of the nsPlugin test namespace and
> into init_net with its own dummy device. Only the root-only check in
> teql_qdisc_init() can then refuse it. It also adds case 6a06, which
> attaches teql0 at root from the test namespace, so that only the
> namespace check can refuse that one.
>
> Link: https://lore.kernel.org/netdev/179366641863.488856.1736857159146600=
0274@kernel.org/
> Link: https://lore.kernel.org/netdev/179366641986.488856.2193313144081673=
076@kernel.org/
>
> > It no longer proves that a child attach is
> > refused as such, and the case added in the previous posting covers the
> > namespace check alone.
>
> [ ... ]
>
> > Attach a root qdisc from the test namespace in the second case, so that
> > only the namespace check can refuse that one.
>
> [Severity: Low]
> This isn't a bug, but these sentences read as if a namespace rejection
> case is already in the tree. Is that the case?
>
> Case 6a06 ("Reject TEQL attach from a different network namespace") is
> added in full by this commit. The parent commit, "net/sched: sch_teql:
> reject qdiscs from another network namespace", changes nothing under
> tools/testing/selftests/tc-testing/.
>
> The only place that says a new case is added is the v1 -> v2 and
> v2 -> v3 changelog. That text sits below the "---", so it is dropped
> when the patch is applied.
>
> Could the body say outright that this commit adds new coverage for the
> namespace rejection and moves 124e into init_net?
>
> > diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/teql.js=
on b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/teql.json
> > index 0179c57104adb..ab5d0881c0070 100644
> > --- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/teql.json
> > +++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/teql.json
>
> [ ... ]
>
> > @@ -104,7 +100,35 @@
> >          "verifyCmd": "$TC -s -j qdisc ls dev $DUMMY parent 1:1",
> >          "matchJSON": [],
> >          "teardown": [
> > -            "$TC qdisc del dev $DUMMY root handle 1:"
> > +            "$TC qdisc del dev $DUMMY root handle 1:",
> > +            "$IP link del dev $DUMMY"
> > +        ]
> > +    },
> > +    {
> > +        "id": "6a06",
> > +        "name": "Reject TEQL attach from a different network namespace=
",
>
> [ ... ]
>
> > +        "setup": [],
> > +        "cmdUnderTest": "$TC qdisc add dev $DUMMY root handle 3: teql0=
",
> > +        "expExitCode": "2",
> > +        "verifyCmd": "$TC qdisc show dev $DUMMY",
> > +        "matchPattern": "qdisc teql0 3: root",
> > +        "matchCount": "0",
>
> [Severity: Low]
> Can this case pass even when the namespace check is not what refused
> the attach?
>
> tc exits with 2 for any netlink error. The verify step only checks that
> no teql0 qdisc shows up in the dump. Case 124e has the same weakness:
> it checks only expExitCode "2" and matchJSON [].
>
> In teql_qdisc_init(), both rejections return the same errno. Only the
> extack text tells them apart:
>
> net/sched/sch_teql.c:teql_qdisc_init() {
>     ...
>         if (sch->parent !=3D TC_H_ROOT) {
>                 NL_SET_ERR_MSG_MOD(extack, "teql can only be used as root=
");
>                 return -EOPNOTSUPP;
>         }
>
>         if (dev_net(dev) !=3D dev_net(m->dev)) {
>                 NL_SET_ERR_MSG_MOD(extack, "teql master is in a different=
 network namespace");
>                 return -EOPNOTSUPP;
>         }
>     ...
> }
>
> The tc-testing config sets CONFIG_NET_SCH_TEQL=3Dm. Unlike the other
> sch_* modules, sch_teql.c has no MODULE_ALIAS_NET_SCH(). So the
> alias-based request_module() never autoloads it, and the lookup fails:
>
> net/sched/sch_api.c:qdisc_create() {
>     ...
>         ops =3D qdisc_lookup_ops(kind);
>         if (!ops) {
>                 err =3D -ENOENT;
>                 NL_SET_ERR_MSG(extack, "Specified qdisc kind is unknown")=
;
>                 goto err_out;
>         }
>     ...
> }
>
> When that happens, tc still exits with 2 and nothing named teql0
> appears. Both 6a06 and 124e then pass, whether or not the kernel has
> either check. That includes a kernel without the namespace fix.
>
> The module is loaded only by try_modprobe() in tdc.sh. That function
> just prints "skipping" when modprobe fails. Running tdc.py directly,
> for example with -e 6a06 or -c teql, never loads it.
>
> The commit message says "only the root-only check can refuse it" and
> "only the namespace check can refuse that one". That only holds when
> sch_teql is loaded.
>
> Would it make sense for each case to match the specific extack
> message? Another option is to fail when the teql0 kind is unavailable.
>
> The positive teql cases would fail in the same setup, so the suite as a
> whole would still show that something is wrong.
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/SER-NSBD.v3.r0.20261103064310%40mojatatu.com
